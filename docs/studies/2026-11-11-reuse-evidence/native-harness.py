"""Compare the existing matched C ports with frozen RecomPyler kernel drivers.

This is a separate best-of-repeated-kernel diagnostic, not the held-out process
wall-time headline. Compilation/profile costs and process wall time are retained.
"""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import struct
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
C_SOURCE = ROOT.parent / "recompyler-coverage" / "c-baseline"


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def harness():
    spec = importlib.util.spec_from_file_location("matched_c_ports", C_SOURCE / "run_baseline.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    module.PY = HERE / "drivers"
    module.PY.mkdir(exist_ok=True)
    return module


def save(path, value):
    path.write_text(json.dumps(value, indent=2) + "\n", encoding="utf8")


def checks_equal(left, right):
    if left.keys() != right.keys():
        return False
    for key, value in left.items():
        other = right[key]
        if "0x" in value.lower() or "0x" in other.lower():
            if struct.pack("!d", float.fromhex(value)) != struct.pack("!d", float.fromhex(other)):
                return False
        elif value != other:
            return False
    return True


def execute(label, command, env, cwd, timeout=300):
    spec = importlib.util.spec_from_file_location("paired_study", ROOT / "wave2-study" / "compare.py")
    paired = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(paired)
    result = paired.execute(HERE / label, command, cwd, env, timeout)
    result["stdout"] = (HERE / (label + ".stdout")).read_text(errors="replace")
    result["stderr"] = (HERE / (label + ".stderr")).read_text(errors="replace")
    return result


def prepare(names):
    module = harness()
    binaries = HERE / "bin"
    binaries.mkdir(exist_ok=True)
    flags = ["-O3", "-march=native", "-ffp-contract=off", "-D_CRT_SECURE_NO_WARNINGS", "-fms-runtime-lib=dll"]
    prepared = {}
    for name in names or module.DRIVERS:
        source = C_SOURCE / (module.C_SOURCES.get(name, name) + ".c")
        binary = binaries / (name + ".exe")
        command = ["clang", *flags, str(source), "-o", str(binary), *module.LINK]
        built = subprocess.run(command, cwd=C_SOURCE, capture_output=True, text=True)
        if built.returncode:
            raise RuntimeError(built.stderr)
        script = module.write_script(name)
        prepared[name] = {"source": str(source), "source_sha256": sha(source),
                          "binary": str(binary), "binary_sha256": sha(binary),
                          "script": str(script), "script_sha256": sha(script), "build_command": command}
    version = subprocess.check_output(["clang", "--version"], text=True)
    save(HERE / "manifest.json", {"compiler": version, "flags": flags, "programs": prepared,
         "method": "Best of 5 fresh-state kernel repetitions in Python/RecomPyler and 20 in C; excludes setup/process startup. Default and explicitly forced paths separate; same floating operation order, FMA disabled; C is a comparison port, not a proof of optimal assembly."})
    print("Prepared", len(prepared), "native ports and drivers; no timing run.", flush=True)


def run(names):
    module = harness()
    manifest = json.loads((HERE / "manifest.json").read_text())
    paired_path = Path(os.environ["RECOMPYLER_PAIRED_MANIFEST"])
    if not paired_path.is_file():
        raise RuntimeError("A frozen wave3 paired manifest is required")
    paired_manifest = json.loads(paired_path.read_text())
    source = Path(os.environ.get("RECOMPYLER_NATIVE_SOURCE", ROOT / "integration"))
    source_head = subprocess.check_output(["git", "-C", str(source), "rev-parse", "HEAD"], text=True).strip()
    source_files = {str(p.relative_to(source / "src")): sha(p) for p in sorted((source / "src").rglob("*"))
                    if p.is_file() and "__pycache__" not in p.parts}
    measured = {"git_head": source_head, "source_path": str(source), "source_sha256": source_files,
                "harness_sha256": sha(Path(__file__)), "audit_sha256": sha(HERE / "audit_native.py"),
                "extra_sha256": sha(HERE / "extra_native.py"), "paired_manifest_sha256": sha(paired_path),
                "execution_environment_manifest": str(paired_path), "repetitions_python": 5,
                "repetitions_c": 20, "method": manifest["method"]}
    measured_path = HERE / "measured-source.json"
    if measured_path.exists() and json.loads(measured_path.read_text()) != measured:
        raise RuntimeError("Native diagnostic source changed; use a separate output directory.")
    save(measured_path, measured)
    cache = HERE / "cache"
    temp = HERE / "temp"
    temp.mkdir(exist_ok=True)
    env = dict(paired_manifest["execution_environment"])
    env.update(PYTHONPATH=os.pathsep.join([str(paired_path.parent / "shim"), str(source / "src")]),
               RECOMPYLER_CACHE=str(cache), NUMBA_CACHE_DIR=str(cache / "numba"),
               TEMP=str(temp), TMP=str(temp), PYTHONHASHSEED="0", PYTHONWARNINGS="ignore",
               PYTHONDONTWRITEBYTECODE="1", PYTHONPYCACHEPREFIX=str(HERE / "bytecode"))
    results_path = HERE / "results.json"
    results = json.loads(results_path.read_text()) if results_path.exists() else {}
    for name, item in manifest["programs"].items():
        if names and name not in names:
            continue
        for path_key in ("source", "binary", "script"):
            if sha(item[path_key]) != item[path_key + "_sha256"]:
                raise RuntimeError("Changed input: " + item[path_key])
        plan = HERE / (name + ".plan.json")
        runs = {}
        runs["c"] = execute(name + "-c", [item["binary"], "20"], env, HERE)
        runs["python"] = execute(name + "-python", [sys.executable, item["script"], "5"], env, HERE)
        profiled = execute(name + "-profile", [sys.executable, "-m", "recompyler", "profile", "--json", str(plan),
                "--limit", "40", "--samples", "8", item["script"], "1"], env, HERE)
        if profiled["exit_code"] == 0 and plan.exists():
            for variant, force in (("default", []), ("forced", ["--force"])):
                runs[variant] = execute(name + "-" + variant, [sys.executable, "-m", "recompyler", "run", *force,
                    "--plan", str(plan), "--json", str(HERE / (name + "-" + variant + ".counts.json")), item["script"], "5"], env, HERE)
        parsed = {key: module.parse(value["stdout"]) for key, value in runs.items() if value["exit_code"] == 0}
        py_checks, py_times = parsed.get("python", ({}, {}))
        row = {"profile_wall_s": profiled["wall_s"], "profile_exit_code": profiled["exit_code"], "variants": {}}
        for key, (checks, seconds) in parsed.items():
            row["variants"][key] = {"checks_match_python": bool(py_checks) and checks_equal(py_checks, checks),
                                    "kernel_best_s": seconds, "process_wall_s": runs[key]["wall_s"]}
        results[name] = row
        save(HERE / "results.json", results)
    print(json.dumps(results, indent=2), flush=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("mode", choices=["prepare", "run"])
    parser.add_argument("names", nargs="*")
    args = parser.parse_args()
    (prepare if args.mode == "prepare" else run)(args.names)
