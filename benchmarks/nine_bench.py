"""Time the nine tuned programs: C, CPython and ``recompyler run`` from this checkout.

Reuses the C baseline harness (recompyler-coverage/c-baseline/run_baseline.py) for
the scripts, drivers and checks, but writes everything to ``--out`` and runs the
RecomPyler in this checkout's ``src``. The C programs are the prebuilt ones.

Usage:
    python benchmarks/nine_bench.py --out DIR [--baseline PATH] [--reps N] [name ...]
"""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
SRC = HERE.parent / "src"
DEFAULT_BASELINE = Path(r"D:\Code\Datathon\recompyler-coverage\c-baseline")


def load_harness(folder):
    spec = importlib.util.spec_from_file_location("run_baseline", folder / "run_baseline.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def timed(harness, command, env, cwd):
    done = subprocess.run(command, capture_output=True, text=True, cwd=cwd, env=env, timeout=1800)
    if done.returncode:
        raise RuntimeError(f"{command[:4]} failed: {done.stderr[-1500:]}")
    return harness.parse(done.stdout), done.stderr


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--out", type=Path, required=True)
    parser.add_argument("--baseline", type=Path, default=DEFAULT_BASELINE)
    parser.add_argument("--reps", type=int, default=5)
    parser.add_argument("--reuse-plans", action="store_true", help="keep plans already in --out")
    parser.add_argument("names", nargs="*")
    args = parser.parse_args()
    harness = load_harness(args.baseline)
    out = args.out.resolve()
    out.mkdir(parents=True, exist_ok=True)
    harness.PY = out
    env = dict(os.environ, PYTHONPATH=os.pathsep.join((str(harness.SHIM), str(SRC))), PYTHONWARNINGS="ignore")
    results = {}
    for name in args.names or list(harness.DRIVERS):
        c_name = harness.C_SOURCES.get(name, name)
        (c_checks, c_seconds), _ = timed(harness, [str(args.baseline / f"{c_name}.exe"), "20"], env, args.baseline)
        script = harness.write_script(name)
        (py_checks, py_seconds), _ = timed(harness, [sys.executable, str(script), str(args.reps)], env, out)
        plan = out / f"{name}.plan.json"
        if not (args.reuse_plans and plan.exists()):
            timed(harness, [sys.executable, "-m", "recompyler", "profile", "--json", str(plan), "--limit", "40",
                            str(script), "1"], env, out)
        (rp_checks, rp_seconds), stderr = timed(
            harness, [sys.executable, "-m", "recompyler", "run", "--force", "--plan", str(plan), str(script),
                      str(args.reps)], env, out)
        entry = {"c": c_seconds, "python": py_seconds, "recompyler": rp_seconds,
                 "checks_match": all(harness.same_value(py_checks[k], rp_checks.get(k, "missing")) for k in py_checks),
                 "c_checks_match": all(harness.same_value(c_checks[k], py_checks.get(k, "missing")) for k in c_checks),
                 "compiled": [line.strip() for line in stderr.splitlines() if "compiled" in line][:8]}
        forced = harness.region_plan(name, plan) if name in harness.REGIONS else None
        if forced is not None:
            (region_checks, region_seconds), _ = timed(
                harness, [sys.executable, "-m", "recompyler", "run", "--force", "--plan", str(forced), str(script),
                          str(args.reps)], env, out)
            entry["recompyler_region"] = region_seconds
            entry["checks_match"] = entry["checks_match"] and all(
                harness.same_value(py_checks[k], region_checks.get(k, "missing")) for k in py_checks)
        results[name] = entry
        for key, c in c_seconds.items():
            rp = min(rp_seconds.get(key, float("inf")), entry.get("recompyler_region", {}).get(key, float("inf")))
            print(f"{name:14} {key:26} C {c * 1e3:9.3f} ms  CPython {py_seconds[key] * 1e3:9.3f} ms  "
                  f"RecomPyler {rp * 1e3:9.3f} ms  {rp / c:7.1f}x C  checks {'ok' if entry['checks_match'] else 'DIFFER'}",
                  flush=True)
    saved = out / "nine.json"
    if saved.exists():
        results = {**json.loads(saved.read_text(encoding="utf-8")), **results}
    saved.write_text(json.dumps(results, indent=2), encoding="utf-8")


if __name__ == "__main__":
    main()
