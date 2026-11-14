"""What ``recompyler run`` costs over plain ``python`` on whole programs.

For each pyperformance benchmark with a profile report in ``--plans`` (as made by
recompyler-coverage/tools/run_study_limit.py), times ``python run_benchmark.py``
against ``python -m recompyler run --plan <report> run_benchmark.py``, wall clock,
start-up included, alternating the two. Both use the pyperf shim, so each runs the
benchmark body in-process. A first row times an empty script, which is start-up alone.

Usage:
    python benchmarks/run_overhead.py --plans DIR [--repeats N] [--json PATH] [name ...]
"""
import argparse
import json
import os
from pathlib import Path
import statistics
import subprocess
import sys
import tempfile
import time

HERE = Path(__file__).resolve().parent
SRC = HERE.parent / "src"
COVERAGE = Path(r"D:\Code\Datathon\recompyler-coverage")
CORPUS = COVERAGE / "corpus" / "pyperformance-1.14.0" / "benchmarks"
SHIM = COVERAGE / "tools" / "shim"


def wall(command, cwd, env):
    start = time.perf_counter()
    done = subprocess.run(command, cwd=cwd, env=env, capture_output=True, text=True, errors="replace", timeout=900)
    return time.perf_counter() - start, done


def summary(plan):
    """(functions the plan would compile, whether the plan is worth running)."""
    data = json.loads(plan.read_text(encoding="utf-8"))
    rows = data.get("functions") or []
    picks = sum(1 for row in rows if row.get("candidate", {}).get("status") == "verified"
                and row.get("candidate", {}).get("recommended"))
    return picks, bool(data.get("plan", {}).get("worth_running"))


def measure(name, script, plan, repeats, src):
    plain_env = dict(os.environ, PYTHONPATH=str(SHIM), PYTHONWARNINGS="ignore")
    run_env = dict(os.environ, PYTHONPATH=os.pathsep.join((str(SHIM), str(src))), PYTHONWARNINGS="ignore")
    plain_cmd = [sys.executable, str(script)]
    run_cmd = [sys.executable, "-m", "recompyler", "run", "--plan", str(plan), str(script)]
    # One untimed round each fills the OS file cache and any compile cache.
    _, first = wall(run_cmd, script.parent, run_env)
    _, reference = wall(plain_cmd, script.parent, plain_env)
    plain, ran = [], []
    for _ in range(repeats):
        seconds, _ = wall(plain_cmd, script.parent, plain_env)
        plain.append(seconds)
        seconds, _ = wall(run_cmd, script.parent, run_env)
        ran.append(seconds)
    return {"name": name, "python_s": min(plain), "run_s": min(ran),
            "python_median_s": statistics.median(plain), "run_median_s": statistics.median(ran),
            "same_exit": first.returncode == reference.returncode, "same_stdout": first.stdout == reference.stdout}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--plans", type=Path, required=True)
    parser.add_argument("--corpus", type=Path, default=CORPUS)
    parser.add_argument("--src", type=Path, default=SRC)
    parser.add_argument("--repeats", type=int, default=5)
    parser.add_argument("--json", type=Path)
    parser.add_argument("names", nargs="*")
    args = parser.parse_args()
    rows = []
    with tempfile.TemporaryDirectory() as folder:
        empty_script, empty_plan = Path(folder) / "empty.py", Path(folder) / "empty.json"
        empty_script.write_text("", encoding="utf-8")
        empty_plan.write_text('{"functions": []}', encoding="utf-8")
        row = measure("(empty script)", empty_script, empty_plan, max(args.repeats, 10), args.src)
        rows.append({**row, "picks": 0, "worth_running": False})
        for plan in sorted(args.plans.resolve().glob("*.json")):
            name = plan.stem
            script = args.corpus / f"bm_{name}" / "run_benchmark.py"
            if (args.names and name not in args.names) or not script.exists():
                continue
            if "failed" in json.loads(plan.read_text(encoding="utf-8")):
                continue
            picks, worth = summary(plan)
            rows.append({**measure(name, script, plan, args.repeats, args.src), "picks": picks, "worth_running": worth})
            print_row(rows[-1])
    print_table(rows)
    if args.json:
        args.json.write_text(json.dumps(rows, indent=2), encoding="utf-8")


def print_row(row):
    extra = row["run_s"] - row["python_s"]
    flag = "" if row["same_exit"] and row["same_stdout"] else "  OUTPUT DIFFERS"
    print(f"{row['name']:26} python {row['python_s'] * 1e3:8.1f} ms  run {row['run_s'] * 1e3:8.1f} ms  "
          f"{extra * 1e3:+7.1f} ms {extra / row['python_s'] * 100:+6.1f}%  compiled {row['picks']}"
          f"{' (worth running)' if row['worth_running'] else ''}{flag}", file=sys.stderr, flush=True)


def print_table(rows):
    print("| Program | python (ms) | recompyler run (ms) | overhead (ms) | overhead | plan compiles |")
    print("|---|---:|---:|---:|---:|---|")
    for row in rows:
        extra = row["run_s"] - row["python_s"]
        what = f"{row['picks']}" + (" (worth running)" if row["worth_running"] else "")
        print(f"| {row['name']} | {row['python_s'] * 1e3:.1f} | {row['run_s'] * 1e3:.1f} | {extra * 1e3:+.1f} | "
              f"{extra / row['python_s'] * 100:+.1f}% | {what} |")
    body = [row for row in rows[1:] if not row["worth_running"]]
    if body:
        extras = [row["run_s"] - row["python_s"] for row in body]
        ratios = [row["run_s"] / row["python_s"] for row in body]
        print(f"\nPlans that compile nothing ({len(body)}): median overhead {statistics.median(extras) * 1e3:+.1f} ms, "
              f"geometric mean ratio {statistics.geometric_mean(ratios):.3f}")


if __name__ == "__main__":
    main()
