"""One isolated numeric cell. This file runs only after an explicit CPU grant."""
import argparse
import ctypes
import hashlib
import importlib.util
import inspect
import json
from pathlib import Path
import statistics
import sys
import time

from common import COUNTERS, SCHEMA, counters, delta, digest, inventory, read, require_grant, sha, write_new

MASK = 2**64 - 1
MINIMUM = -(2**63)
MAXIMUM = 2**63 - 1


def signed(value):
    return ((value + 2**63) & MASK) - 2**63


def oracle(name, args, modular=False):
    if name == "fibonacci":
        a, b = 0, 1
        for _ in range(args[0]):
            a, b = b, signed(a + b) if modular else a + b
        return a
    steps = args[3] * 16 if name == "loop_recurrence16" else int(name.rsplit("_", 1)[1])
    t, y, z = args[:3]
    for _ in range(steps):
        t = signed(signed(t * y) + z) if modular else t * y + z
    return t


def module_from(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


def source_path(root, variant):
    return root / "inputs" / ("current" if variant == "current-strict" else "candidate")


def construct(root, variant, fn, config, aot=False):
    if variant == "cpython":
        return fn
    if variant.startswith("c-"):
        library = ctypes.CDLL(str(root / "build" / "kernels.dll"))
        mode = variant.split("-", 1)[1]
        cfn = getattr(library, fn.__name__ + "_" + mode)
        cfn.argtypes = [ctypes.c_int64] * 4
        cfn.restype = ctypes.c_uint64 if mode == "wrap" else ctypes.c_int64
        signature = inspect.signature(fn)

        class NumericContractError(ValueError):
            pass

        def wrapped(*args, **kwargs):
            # Explicit binding/type/range guard for the complete foreign-call row.
            try:
                bound = signature.bind(*args, **kwargs)
            except TypeError:
                # Let the original supply the exact original argument-error text.
                return fn(*args, **kwargs)
            values = tuple(bound.arguments[name] for name in config["parameters"])
            for name, value in zip(config["parameters"], values):
                lo, hi = (MINIMUM, MAXIMUM) if mode == "wrap" else config["contract"][name]
                if type(value) is not int or not lo <= value <= hi:
                    if mode == "wrap":
                        wrapped.representation_rejections += 1
                        raise NumericContractError("C wrapping reference requires exact signed-int64 inputs")
                    wrapped.fallback_calls += 1
                    return fn(*args, **kwargs)
            loop_n = values[0] if fn.__name__ == "fibonacci" else values[3] if fn.__name__ == "loop_recurrence16" else None
            if mode == "wrap" and loop_n is not None and max(0, loop_n) > 1024:
                wrapped.loop_limit_rejections += 1
                raise NumericContractError("C wrapping reference retains max(0,n)<=1024 operational cap")
            padded = values + (0,) * (4 - len(values))
            result = cfn(*padded)
            wrapped.foreign_calls += 1
            return signed(result) if mode == "wrap" else result
        wrapped._cfn = cfn
        wrapped._library = library
        wrapped.foreign_calls = wrapped.fallback_calls = wrapped.representation_rejections = wrapped.loop_limit_rejections = 0
        return wrapped
    sys.path.insert(0, str(source_path(root, variant)))
    if variant in {"current-strict", "candidate-strict"}:
        from recompyler.heap import lift_region
        if aot:
            from recompyler._region_seed import ExactExport
            built = read(root / "cells" / f"build-aot-{fn.__name__}-{variant}" / "result.json")["aot_build"]
            section = built["plan"]
            binary = Path(built["binary"])
            assert sha(binary) == built["binary_sha256"]
            module = module_from(binary, section["module"])
            exports = section["functions"][0]["exports"]
            return lift_region(fn, ahead_of_time=ExactExport({key: getattr(module, value) for key, value in exports.items()}))
        return lift_region(fn)
    from recompyler.experimental import IntIntervals, lift_numeric, load_numeric
    if aot:
        built = read(root / "cells" / f"build-aot-{fn.__name__}-{variant}" / "result.json")["aot_build"]
        return load_numeric(fn, Path(built["manifest"]), mode=variant,
                            contract=IntIntervals(**config["contract"]))
    return lift_numeric(fn, mode=variant, contract=IntIntervals(**config["contract"]))


def build_aot(root, target, variant, fn):
    folder = root / "aot" / variant / fn.__name__
    folder.mkdir(parents=True, exist_ok=False)
    before = time.perf_counter()
    from recompyler._pycc import CC
    compiler_version = "current" if variant == "current-strict" else "candidate"
    mixin = source_path(root, variant) / "recompyler" / "_pycc" / "modulemixin.c"
    frozen = read(root / "manifest.json")[compiler_version]["files"]
    assert sha(mixin) == frozen["recompyler/_pycc/modulemixin.c"]
    c_sources = CC("wave10_source_inventory")._get_mixin_sources()
    assert mixin.resolve() in {Path(path).resolve() for path in c_sources}
    if variant in {"current-strict", "candidate-strict"}:
        from recompyler.heap import build_regions
        plan = build_regions([((fn.__name__, fn.__code__.co_firstlineno), fn, target)], folder)
        assert plan
        binaries = list(folder.glob(plan["module"] + "*.pyd"))
        assert len(binaries) == 1
        result = {"plan": plan, "binary": str(binaries[0]), "binary_sha256": sha(binaries[0])}
        write_new(folder / "strict-plan.json", result)
        result["manifest"] = str(folder / "strict-plan.json")
    else:
        from recompyler.experimental import build_numeric
        manifest = Path(build_numeric(target, folder))
        result = {"manifest": str(manifest), "manifest_sha256": sha(manifest), "policy": read(manifest)}
    result["build_s"] = time.perf_counter() - before
    result["pycc_native_sources"] = {str(Path(path).resolve()): sha(path) for path in c_sources}
    result["frozen_pycc_mixin"] = {"path": str(mixin), "sha256": sha(mixin)}
    result["files"] = inventory(folder)
    return result


def artifact_info(target, fn, out, capture=False):
    info = {"function": fn.__qualname__, "function_module": fn.__module__,
            "function_file": inspect.getsourcefile(fn),
            "function_source_sha256": hashlib.sha256(inspect.getsource(fn).encode()).hexdigest(),
            "function_bytecode_sha256": hashlib.sha256(fn.__code__.co_code).hexdigest(),
            "selected_mode": getattr(target, "mode", "strict"),
            "identity": getattr(target, "identity", None),
            "contract": repr(getattr(target, "contract", None)),
            "proof_certificates": repr(getattr(target, "proof_certificates", None)),
            "problem": getattr(target, "problem", None)}
    policy = getattr(target, "policy", None)
    if policy is not None:
        info["policy_metadata"] = json.loads(policy.metadata)
    program = getattr(target, "latest", None)
    if program is None:
        return info
    info.update(program_digest=program.digest, program_cached=bool(program.cached),
                program_ahead_of_time=bool(program.ahead_of_time),
                entry_name=program.entry.name, program_source_sha256=hashlib.sha256(program.source.encode()).hexdigest(),
                dispatcher_module=getattr(program.run, "__module__", None),
                dispatcher_qualname=getattr(program.run, "__qualname__", None))
    heap = sys.modules["recompyler.heap"]
    native = getattr(heap, "_native", None)
    info["native_loader"] = {"available": native is not None, "enabled": bool(heap.NATIVE),
                              "path": getattr(native, "__file__", None),
                              "sha256": sha(native.__file__) if native is not None else None}
    assert native is not None and heap.NATIVE, "Comparison requires the frozen native loader support binary"
    if capture:
        (out / "program-source.py.txt").write_text(program.source, encoding="utf8", newline="\n")
    overloads = []
    for signature, result in getattr(program.run, "overloads", {}).items():
        row = {"signature": str(signature), "native_symbol": result.fndesc.llvm_func_name,
               "cpython_wrapper_symbol": result.fndesc.llvm_cpython_wrapper_name,
               "code_capture_requested": capture}
        if capture:
            llvm, assembly = result.library.get_llvm_str(), result.library.get_asm_str()
            assert llvm.strip() and assembly.strip(), "Cold selected code capture is unavailable"
            row.update(llvm_sha256=hashlib.sha256(llvm.encode()).hexdigest(),
                       asm_sha256=hashlib.sha256(assembly.encode()).hexdigest())
            index = len(overloads)
            (out / f"selected-{index}.ll").write_text(llvm, encoding="utf8", newline="\n")
            (out / f"selected-{index}.asm").write_text(assembly, encoding="utf8", newline="\n")
        else:
            row["code_capture_note"] = "No cached LLVM/ASM inspection requested or claimed"
        overloads.append(row)
    info["overloads"] = overloads
    info["dispatcher_cache_hits"] = {str(k): int(v) for k, v in getattr(program.run, "_cache_hits", {}).items()}
    info["dispatcher_cache_misses"] = {str(k): int(v) for k, v in getattr(program.run, "_cache_misses", {}).items()}
    return info


def aot_selection(root, variant, fn, target):
    """Bind successful actual AOT execution to sealed binary and method RVA."""
    from pe_method import inspect_method
    built = read(root / "cells" / f"build-aot-{fn.__name__}-{variant}" / "result.json")["aot_build"]
    if variant in {"current-strict", "candidate-strict"}:
        record = built["plan"]
        export = record["functions"][0]["exports"][target.latest.digest]
        binary = Path(built["binary"])
    else:
        manifest = Path(built["manifest"])
        record = read(manifest)
        assert record["source_digest"] == target.latest.digest
        binary, export = manifest.parent / record["binary"], record["export"]
    mapping = inspect_method(binary, export)
    get_function = ctypes.pythonapi.PyCFunction_GetFunction
    get_function.argtypes, get_function.restype = [ctypes.py_object], ctypes.c_void_p
    address = get_function(getattr(target.latest.run, "_wave10_original", target.latest.run))
    kernel = ctypes.WinDLL("kernel32", use_last_error=True)
    get_module = kernel.GetModuleHandleExW
    get_module.argtypes = [ctypes.c_uint32, ctypes.c_void_p, ctypes.POINTER(ctypes.c_void_p)]
    get_module.restype = ctypes.c_int
    base = ctypes.c_void_p()
    assert get_module(6, address, ctypes.byref(base))
    runtime_rva = address - base.value
    assert runtime_rva == mapping["method_rva"]
    return {"program_digest": target.latest.digest, "export": export, "binary": str(binary),
            "binary_sha256": sha(binary), "runtime_wrapper_address": address,
            "runtime_module_base": base.value, "runtime_wrapper_rva": runtime_rva,
            "static_mapping": mapping, "actual_wrapper_counts_after_cell": counters(target)}


def call_outcome(target, args, kwargs):
    try:
        value = target(*args, **kwargs)
    except Exception as exc:
        return {"kind": "error", "type": type(exc).__module__ + "." + type(exc).__qualname__,
                "message": str(exc)}
    return {"kind": "value", "type": type(value).__module__ + "." + type(value).__qualname__,
            "value": repr(value)}


def audit_instrumentation(target):
    """Separate audit only: observe attempted/rejected and raw native entries.

    These proxies are never installed in complete-call or native timing cells.
    Completed Region counters remain the product's own counters.
    """
    state = {"attempts": 0, "rejected_attempts": 0, "attempt_exceptions": 0, "programs": {}}
    if not hasattr(target, "attempt"):
        return state
    original_load = target.load

    def observed_load(program, values):
        if not hasattr(program.run, "_wave10_original"):
            native = program.run
            item = state["programs"].setdefault(program.digest, {
                "mode": "AOT" if program.ahead_of_time else "JIT", "entered": 0,
                "returned": 0, "successful_status": 0, "failed_status": 0})

            def observed(*arguments):
                item["entered"] += 1
                result = native(*arguments)
                item["returned"] += 1
                item["failed_status" if int(arguments[3][0]) else "successful_status"] += 1
                return result
            observed._wave10_original = native
            program.run = observed
        return original_load(program, values)
    target.load = observed_load
    original_attempt = target.attempt

    def observed_attempt(*arguments, **keywords):
        state["attempts"] += 1
        try:
            result = original_attempt(*arguments, **keywords)
        except Exception:
            state["attempt_exceptions"] += 1
            raise
        if not result[0]:
            state["rejected_attempts"] += 1
        return result
    target.attempt = observed_attempt
    return state


def semantic_audits(target, fn, name, variant):
    class IntSubclass(int):
        pass
    if name == "fibonacci":
        cases = [([81], {}), ([100], {}), ([-1], {}), ([1024], {}), ([1025], {}),
                 ([True], {}), ([IntSubclass(3)], {}), ([2.0], {}),
                 ([], {}), ([3], {"bad": 1}), ([], {"n": 4})]
    elif name == "loop_recurrence16":
        cases = [([2**20 + 1, 1, 0, 16], {}), ([2**40, 2**40, 1, 2], {}),
                 ([MAXIMUM, 1, 1, 1], {}), ([MINIMUM, -1, 0, 1], {}),
                 ([True, 1, 2, 2], {}), ([IntSubclass(2), 1, 2, 2], {}),
                 ([2.0, 1, 2, 2], {}), ([2**80, 1, 1, 2], {}),
                 ([1, 1, 1, -1], {}), ([1, 1, 1, 1025], {}),
                 ([], {}), ([1, 1, 1, 2], {"bad": 1}),
                 ([], {"x": 1, "y": 1, "z": 2, "n": 3})]
    else:
        cases = [([2**20 + 1, 1, 0], {}), ([2**40, 2**40, 1], {}),
                 ([MAXIMUM, 1, 1], {}), ([MINIMUM, -1, 0], {}),
                 ([True, 1, 2], {}), ([IntSubclass(2), 1, 2], {}), ([2.0, 1, 2], {}),
                 ([2**80, 1, 1], {}), ([], {}), ([1, 1, 1], {"bad": 1}),
                 ([], {"x": 1, "y": 1, "z": 2})]
    observed = audit_instrumentation(target)
    rows = []
    for args, kwargs in cases:
        before = counters(target)
        observations_before = json.loads(json.dumps(observed))
        actual = call_outcome(target, args, kwargs)
        python = call_outcome(fn, args, kwargs)
        try:
            binding = inspect.signature(fn).bind(*args, **kwargs)
            bound_values = tuple(binding.arguments[param] for param in inspect.signature(fn).parameters)
        except TypeError:
            bound_values = None
        representable = (bound_values is not None
                         and all(type(value) is int and MINIMUM <= value <= MAXIMUM for value in bound_values)
                         and (name != "fibonacci" or max(0, bound_values[0]) <= 1024)
                         and (name != "loop_recurrence16" or max(0, bound_values[3]) <= 1024))
        if variant in {"unchecked-int64", "c-wrap"}:
            if representable:
                expected = {"kind": "value", "type": "builtins.int", "value": repr(oracle(name, bound_values, True))}
                matched, policy = actual == expected, "defined-modulo-int64"
            elif variant == "c-wrap" and bound_values is None:
                # Reference boundary only: fixed Python binding TypeError, no body call.
                expected, policy = python, "C-reference-binding-TypeError"
                matched = actual == expected and actual["kind"] == "error" and actual["type"] == "builtins.TypeError"
            else:
                expected, policy = "NumericContractError before native/body execution", "rejection-before-native"
                matched = actual["kind"] == "error" and actual["type"].endswith(".NumericContractError")
        else:
            expected, matched, policy = python, actual == python, "Python-compatible"
        change = delta(counters(target), before)
        if variant in {"unchecked-int64", "c-wrap"} and policy == "rejection-before-native":
            matched = matched and all(change[key] == 0 for key in ("compiled_calls", "aot_calls", "jit_calls", "foreign_calls"))
        row = {"args": [repr(value) for value in args], "arg_types": [type(value).__qualname__ for value in args],
               "kwargs": {key: repr(value) for key, value in kwargs.items()}, "actual": actual,
               "bound_values": None if bound_values is None else [repr(value) for value in bound_values],
               "python": python, "expected": expected, "policy": policy, "matched": matched,
               "counter_delta": change}
        row["observed_attempt_delta"] = {key: observed[key] - observations_before[key]
                                          for key in ("attempts", "rejected_attempts", "attempt_exceptions")}
        row["observed_native_entries"] = {key: {"mode": item["mode"],
                **{field: item[field] - observations_before["programs"].get(key, {}).get(field, 0)
                   for field in ("entered", "returned", "successful_status", "failed_status")}}
                for key, item in observed["programs"].items()}
        rows.append(row)
    assert all(row["matched"] for row in rows), rows
    return rows, observed


def native_batch(root, target, variant, values, expected, repeats, out, smoke=False):
    library = ctypes.CDLL(str(root / "build" / "kernels.dll"))
    data = (ctypes.c_int64 * (4 * len(values)))(*(value for row in values for value in (*row, *([0] * (4 - len(row))))))
    completed, failures = ctypes.c_uint64(), ctypes.c_uint64()
    adapter = None
    if variant.startswith("c-"):
        batch = getattr(library, "batch_" + variant.split("-", 1)[1])
        batch.argtypes = [ctypes.c_void_p, ctypes.POINTER(ctypes.c_int64), ctypes.c_size_t,
                          ctypes.c_size_t, ctypes.POINTER(ctypes.c_uint64)]
        batch.restype = ctypes.c_uint64
        args = [ctypes.cast(target._cfn, ctypes.c_void_p), data, len(values), repeats, ctypes.byref(completed)]
        mode = "C-exact" if variant == "c-exact" else "C-unsigned-wrap"
    else:
        program = getattr(target, "latest", None)
        if program is None or not getattr(program.run, "overloads", None):
            return {"available": False, "reason": "selected callable has no supported Numba dispatcher ABI"}
        from numba import carray, cfunc, types
        F, I, top, status = target.arrays()
        loaded, _ = target.load(program, tuple(values[0]))
        parameters = "x" if len(values[0]) == 1 else "x, y, z, n" if len(values[0]) == 4 else "x, y, z"
        source = ("def adapter(fp, ip, tp, sp, x, y, z, n):\n"
                  f"    return target(carray(fp, {len(F)}), carray(ip, {len(I)}), carray(tp, 4), carray(sp, 1), {parameters})\n")
        (out / "adapter-source.py.txt").write_text(source, encoding="utf8")
        namespace = {"target": program.run, "carray": carray}
        exec(compile(source, str(out / "adapter-source.py.txt"), "exec"), namespace)
        signature = types.int64(types.CPointer(types.float64), types.CPointer(types.int64),
                                types.CPointer(types.int64), types.CPointer(types.uint8),
                                types.int64, types.int64, types.int64, types.int64)
        build_start = time.perf_counter()
        adapter = cfunc(signature)(namespace["adapter"])
        adapter_build_s = time.perf_counter() - build_start
        adapter_llvm = adapter.inspect_llvm()
        (out / "adapter.ll").write_text(adapter_llvm, encoding="utf8")
        (out / "adapter.asm").write_text(adapter._library.get_asm_str(), encoding="utf8")
        selected_symbols = [result.fndesc.llvm_func_name for result in program.run.overloads.values()]
        selected_call_lines = [line.strip() for line in adapter_llvm.splitlines()
                               if ("call " in line or "invoke " in line)
                               and any(symbol in line for symbol in selected_symbols)]
        batch = library.batch_rp
        batch.argtypes = [ctypes.c_void_p, ctypes.POINTER(ctypes.c_int64), ctypes.c_size_t, ctypes.c_size_t,
                          ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p,
                          ctypes.c_int64, ctypes.POINTER(ctypes.c_uint64), ctypes.POINTER(ctypes.c_uint64)]
        batch.restype = ctypes.c_uint64
        args = [adapter.address, data, len(values), repeats, F.ctypes.data, I.ctypes.data,
                top.ctypes.data, status.ctypes.data, loaded.top, ctypes.byref(completed), ctypes.byref(failures)]
        mode = "JIT-selected-dispatcher-via-cfunc-adapter"
    before = counters(target)
    samples = []
    for _ in range(1 if smoke else 3):
        start = None if smoke else time.perf_counter_ns()
        checksum = batch(*args)
        elapsed = None if smoke else time.perf_counter_ns() - start
        assert checksum == (sum(expected) * repeats) & MASK, (checksum, expected)
        assert completed.value == len(values) * repeats and failures.value == 0
        samples.append({"elapsed_ns": elapsed, "native_invocations": completed.value,
                        "status_failures": failures.value, "checksum_uint64": checksum})
    result = {"available": True, "boundary": "prevalidated-input-C-loop-native-call-and-status-reset",
              "mode": mode, "samples": samples,
              "median_ns": None if smoke else statistics.median(s["elapsed_ns"] for s in samples),
              "timing_eligible": not smoke,
              "region_counter_delta": delta(counters(target), before),
              "counter_accounting": "C loop counts native invocations; Region Python counters do not count adapter calls"}
    if adapter is not None:
        result.update(adapter_build_s=adapter_build_s, adapter_address=adapter.address,
                      selected_target_digest=program.digest,
                      selected_target_symbols=selected_symbols,
                      adapter_selected_target_call_lines=selected_call_lines,
                      selected_target_physical_calls_retained=bool(selected_call_lines),
                      native_invocation_meaning="C loop invokes adapter; selected dispatcher body is linked and may be inlined by LLVM",
                      adapter_source_sha256=sha(out / "adapter-source.py.txt"),
                      adapter_llvm_sha256=sha(out / "adapter.ll"), adapter_asm_sha256=sha(out / "adapter.asm"))
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--grant", type=Path, required=True)
    parser.add_argument("--variant", required=True)
    parser.add_argument("--function", required=True)
    parser.add_argument("--task", choices=("prepare", "time", "audit", "native", "native-smoke", "build-aot", "time-aot", "audit-aot"), required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    require_grant(args.grant)
    root = args.root.resolve()
    manifest = read(root / "manifest.json")
    assert manifest["schema"] == SCHEMA
    for name, expected_hash in manifest["helper_files"].items():
        assert sha(Path(__file__).parent / name) == expected_hash, f"Frozen helper changed: {name}"
    if args.variant not in {"cpython", "c-exact", "c-wrap"}:
        compiler = "current" if args.variant == "current-strict" else "candidate"
        assert inventory(root / "inputs" / compiler) == manifest[compiler]["files"]
    assert sha(root / "inputs" / "kernels.py") == manifest["kernel_source_sha256"]
    assert sha(root / "inputs" / "corpus.json") == manifest["corpus_sha256"]
    config = read(root / "inputs" / "corpus.json")[args.function]
    kernels = module_from(root / "inputs" / "kernels.py", "wave10_fixed_kernels")
    fn = getattr(kernels, args.function)
    args.output.mkdir(parents=True, exist_ok=False)
    values = config["inputs"]
    expected = [oracle(args.function, row) for row in values]
    started = time.perf_counter()
    target = construct(root, args.variant, fn, config, aot=args.task.endswith("-aot") and args.task != "build-aot")
    construction_s = time.perf_counter() - started
    before = counters(target)
    started = time.perf_counter()
    first = target(*values[0])
    first_call_s = time.perf_counter() - started
    assert type(first) is int and first == expected[0]
    first_counts = delta(counters(target), before)
    before = counters(target)
    actual = [target(*row) for row in values]
    assert all(type(value) is int for value in actual) and actual == expected
    validation_counts = delta(counters(target), before)
    if args.variant not in {"cpython", "c-exact", "c-wrap"}:
        assert first_counts["aot_calls"] + first_counts["jit_calls"] == 1, first_counts
        assert validation_counts["aot_calls"] + validation_counts["jit_calls"] == len(values), validation_counts
        assert validation_counts["fallback_calls"] == 0, validation_counts
    result = {"schema": SCHEMA, "manifest_sha256": sha(root / "manifest.json"),
              "variant": args.variant, "function": args.function, "task": args.task,
              "contract": config["contract"], "corpus_count": len(values),
              "expected_results_sha256": digest(expected), "valid_exact_results": True,
              "construction_s": construction_s, "first_call_s": first_call_s,
              "first_call_counts": first_counts, "validation_counts": validation_counts,
              "program": artifact_info(target, fn, args.output, capture=args.task in {"prepare", "native", "native-smoke"}),
              "numba_imported": "numba" in sys.modules, "python_version": sys.version}
    if args.task in {"time", "time-aot"}:
        before = counters(target)
        samples = []
        for _ in range(manifest["samples_per_child"]):
            checksum = 0
            start = time.perf_counter_ns()
            for _ in range(config["complete_repeats"]):
                for row in values:
                    checksum += target(*row)
            elapsed = time.perf_counter_ns() - start
            assert checksum == sum(expected) * config["complete_repeats"]
            samples.append({"elapsed_ns": elapsed, "calls": len(values) * config["complete_repeats"],
                            "checksum_uint64": checksum & MASK})
        result.update(samples=samples, median_ns=statistics.median(row["elapsed_ns"] for row in samples),
                      timing_counts=delta(counters(target), before),
                      boundary="complete-Python-call-plus-all-return-integer-sum")
        attempted = len(values) * config["complete_repeats"] * manifest["samples_per_child"]
        if args.variant not in {"cpython", "c-exact", "c-wrap"}:
            assert result["timing_counts"]["aot_calls"] + result["timing_counts"]["jit_calls"] == attempted
            assert result["timing_counts"]["fallback_calls"] == 0
        elif args.variant.startswith("c-"):
            assert result["timing_counts"]["foreign_calls"] == attempted
    elif args.task in {"audit", "audit-aot"}:
        result["invalid_audits"], result["audit_observations"] = semantic_audits(target, fn, args.function, args.variant)
    elif args.task in {"native", "native-smoke"}:
        result["native_batch"] = ({"available": False, "reason": "CPython reference is an ordinary Python call"}
                                  if args.variant == "cpython" else native_batch(root, target, args.variant, values,
                                  expected, 1 if args.task == "native-smoke" else config["native_repeats"],
                                  args.output, smoke=args.task == "native-smoke"))
    elif args.task == "build-aot":
        result["aot_build"] = build_aot(root, target, args.variant, fn)
    if args.task in {"time-aot", "audit-aot"}:
        assert "numba" not in sys.modules, "AOT replay imported Numba"
        assert result["validation_counts"]["aot_calls"] == len(values)
        assert result["validation_counts"]["jit_calls"] == 0
        result["aot_selection"] = aot_selection(root, args.variant, fn, target)
    result["final_counts"] = counters(target)
    result["cache_files"] = inventory(Path(__import__("os").environ["RECOMPYLER_CACHE"]))
    write_new(args.output / "result.json", result)
    print(json.dumps({"result": str(args.output / "result.json"), "sha256": sha(args.output / "result.json"),
                      "variant": args.variant, "function": args.function, "task": args.task,
                      "counts": result["final_counts"]}))


if __name__ == "__main__":
    main()
