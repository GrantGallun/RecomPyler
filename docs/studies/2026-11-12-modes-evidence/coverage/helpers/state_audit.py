"""Explicit-entry semantic/AOT diagnostic, never a default deployment timing."""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import random
import sys

import state_recipe as recipe


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def save(path, value):
    Path(path).write_text(json.dumps(value, indent=2, allow_nan=False) + "\n", encoding="utf-8")


def compiler_identity(heap):
    root = Path(heap.__file__).parent
    paths = [path for path in sorted(root.rglob("*")) if path.is_file()
             and "__pycache__" not in path.parts and path.suffix not in (".pyc", ".pyo")]
    return {str(path): digest(path) for path in paths}


def export_address(native, module):
    """Bind the actual Python C callable to its loaded PE wrapper RVA."""
    import ctypes

    get_function = ctypes.pythonapi.PyCFunction_GetFunction
    get_function.argtypes = [ctypes.py_object]
    get_function.restype = ctypes.c_void_p
    address = get_function(native)
    kernel = ctypes.WinDLL("kernel32", use_last_error=True)
    kernel.GetModuleHandleW.argtypes = [ctypes.c_wchar_p]
    kernel.GetModuleHandleW.restype = ctypes.c_void_p
    base = kernel.GetModuleHandleW(str(Path(module.__file__).resolve()))
    assert address and base and address >= base
    binary = Path(module.__file__).read_bytes()
    nt = int.from_bytes(binary[0x3c:0x40], "little")
    image_size = int.from_bytes(binary[nt + 24 + 56:nt + 24 + 60], "little")
    assert 0 <= address - base < image_size, "export pointer is outside the mapped PE image"
    return {"function_address": address, "module_base": base, "wrapper_rva": address - base, "image_size": image_size,
            "module_path": str(Path(module.__file__).resolve()), "module_sha256": digest(module.__file__)}


def input_identities(value):
    seen, result = set(), {}

    def visit(item, path):
        kind = type(item)
        if kind in (bool, int, float, str, type(None)) or id(item) in seen:
            return
        seen.add(id(item))
        if kind is tuple:
            for index, child in enumerate(item):
                visit(child, path + f"[{index}]")
            return
        result[path] = id(item)
        children = enumerate(item) if kind is list else sorted(vars(item).items())
        for name, child in children:
            visit(child, path + "." + str(name))

    visit(value, "arguments")
    return result


def make_entry(module, artifact, kind):
    original, arguments = recipe.original_entry(module)
    if kind == "original":
        return original, arguments, None
    destination = artifact / "pixels-entry.py"
    if destination.exists():
        old_hash = digest(destination)
    else:
        old_hash = None
    entry, source = recipe.image_observation_entry(module, destination)
    if old_hash is not None:
        assert digest(destination) == old_hash, "derived canary changed between build and AOT"
    return entry, arguments, source


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--mode", choices=["build", "aot"], required=True)
    parser.add_argument("--kind", choices=["original", "pixels"], required=True)
    parser.add_argument("--script", type=Path, required=True)
    parser.add_argument("--artifact", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    args.artifact = args.artifact.resolve()
    args.output = args.output.resolve()
    args.artifact.mkdir(parents=True, exist_ok=True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    recipe.FROZEN_SOURCE = args.script.resolve()
    module = recipe.load_workload()
    function, arguments, derived = make_entry(module, args.artifact, args.kind)
    from recompyler import heap
    assert heap._native is not None, "state audit requires actual native support extension"
    source_identity = compiler_identity(heap)
    record = {"mode": args.mode, "kind": args.kind, "timing_eligible": False,
              "population_evidence": False, "script": str(recipe.FROZEN_SOURCE),
              "script_sha256": digest(recipe.FROZEN_SOURCE), "compiler_inputs": source_identity,
              "derived_source_sha256": None if derived is None else hashlib.sha256(derived.encode()).hexdigest(),
              "limitations": ["Explicit entry diagnostic does not establish default plan selection or process profitability.",
                              "Original API returns None; image equality is established only by the separately changed pixels canary."]}
    artifact_manifest = args.artifact / "artifact.json"
    state = random.getstate()
    expected_arguments = copy.deepcopy(arguments)
    expected = function(*expected_arguments)
    expected_random = random.getstate()
    random.setstate(state)
    before_ids = input_identities(arguments)
    if args.mode == "build":
        if artifact_manifest.exists():
            raise RuntimeError("Do not rebuild an existing immutable artifact; choose a new folder")
        region = heap.lift_region(function)
        result = region(*arguments)
        record.update(compiled_calls=region.compiled_calls, aot_calls=region.aot_calls,
                      jit_calls=region.jit_calls, fallback_calls=region.fallback_calls,
                      problem=region.problem, gave_up=region.gave_up)
        record["state_matches"] = (recipe.freeze_graph(result) == recipe.freeze_graph(expected)
                                   and recipe.freeze_graph(arguments) == recipe.freeze_graph(expected_arguments)
                                   and random.getstate() == expected_random
                                   and input_identities(arguments) == before_ids)
        assert record["state_matches"]
        if region.compiled_calls != 1 or region.fallback_calls != 0:
            record["status"] = "native-declined"
            save(args.output, record)
            return 0
        section = heap.build_regions([((function.__name__, function.__code__.co_firstlineno), function, region)],
                                     args.artifact)
        assert section is not None, "verified native diagnostic failed AOT export"
        modules = {str(path.resolve()): digest(path) for path in args.artifact.glob(section["module"] + "*")
                   if path.suffix in (".pyd", ".so", ".dll")}
        assert modules
        save(artifact_manifest, {"section": section, "compiler_inputs": source_identity,
                                "script_sha256": record["script_sha256"], "kind": args.kind,
                                "derived_source_sha256": record["derived_source_sha256"], "modules": modules})
        (args.artifact / "generated-source.py.txt").write_text(region.latest.source, encoding="utf-8")
        record.update(status="aot-built", modules=modules, section=section,
                      generated_source_sha256=digest(args.artifact / "generated-source.py.txt"))
    else:
        from recompyler import aot
        from recompyler.runner import _AotOnlyExports
        artifact = json.loads(artifact_manifest.read_text(encoding="utf-8"))
        assert artifact["compiler_inputs"] == source_identity
        assert artifact["script_sha256"] == record["script_sha256"]
        assert artifact["kind"] == args.kind
        assert artifact["derived_source_sha256"] == record["derived_source_sha256"]
        for path, expected_hash in artifact["modules"].items():
            assert digest(path) == expected_hash
        section = artifact["section"]
        native_module = aot.load(section)
        assert native_module is not None
        entry = section["functions"][0]
        calls = {}
        exports = {}
        addresses = {}
        for key, export in entry["exports"].items():
            native = getattr(native_module, export)
            addresses[key] = {"export": export, **export_address(native, native_module)}

            def observed(*values, _native=native, _key=key, _export=export):
                item = calls.setdefault(_key, {"export": _export, "entered": 0, "returned": 0,
                                               "successful_status": 0, "growth_status": 0, "other_status": 0})
                item["entered"] += 1
                result = _native(*values)
                item["returned"] += 1
                status = int(values[3][0])
                item["successful_status" if status == 0 else "growth_status" if status == 2 else "other_status"] += 1
                return result

            exports[key] = observed
        region = heap.lift_region(function, _AotOnlyExports(exports), seeds=entry.get("seeds"))
        rejected = 0
        attempt = region.attempt

        def observed_attempt(*values, **keywords):
            nonlocal rejected
            got = attempt(*values, **keywords)
            rejected += not got[0]
            return got

        region.attempt = observed_attempt
        result = region(*arguments)
        actual_state = {"arguments": recipe.freeze_graph(arguments), "result": recipe.freeze_graph(result),
                        "random": recipe.freeze_graph(random.getstate())}
        expected_state = {"arguments": recipe.freeze_graph(expected_arguments), "result": recipe.freeze_graph(expected),
                          "random": recipe.freeze_graph(expected_random)}
        save(args.output.with_name(args.output.stem + "-expected-state.json"), expected_state)
        save(args.output.with_name(args.output.stem + "-actual-state.json"), actual_state)
        record.update(status="aot-state-verified", compiled_calls=region.compiled_calls,
                      aot_calls=region.aot_calls, jit_calls=region.jit_calls, fallback_calls=region.fallback_calls,
                      rejected_attempts=rejected, raw_export_entries=calls, selected_digest=region.latest.digest,
                      raw_export_addresses=addresses,
                      modules=artifact["modules"], numba_imported="numba" in sys.modules,
                      exact_state_match=actual_state == expected_state,
                      input_identities_preserved=input_identities(arguments) == before_ids)
        assert actual_state == expected_state
        assert input_identities(arguments) == before_ids
        assert (region.compiled_calls, region.aot_calls, region.jit_calls, region.fallback_calls, rejected) == (1, 1, 0, 0, 0)
        entered = sum(item["entered"] for item in calls.values())
        returned = sum(item["returned"] for item in calls.values())
        successes = sum(item["successful_status"] for item in calls.values())
        growth = sum(item["growth_status"] for item in calls.values())
        other = sum(item["other_status"] for item in calls.values())
        assert entered == returned and successes == 1 and growth == entered - 1 and other == 0
        record["raw_native_growth_retries"] = growth
        record["raw_native_entry_accounting"] = "One completed AOT call; extra raw entries are observed status2 arena-growth retries, verified by final exact state."
        assert region.latest.digest in calls
        assert "numba" not in sys.modules
    assert compiler_identity(heap) == source_identity
    save(args.output, record)
    return 0


if __name__ == "__main__":
    sys.exit(main())
