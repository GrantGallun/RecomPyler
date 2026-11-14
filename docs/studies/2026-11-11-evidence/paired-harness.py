"""Frozen-population, restartable paired coverage and process-wall study.

prepare never executes benchmark code. run requires the coordinator's exclusive
measurement slot. Each profile and each fresh-process repetition is persisted.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import importlib.metadata
import json
import math
import os
from pathlib import Path
import platform
import shutil
import signal
import statistics
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
PARENT = HERE.parent
CORPUS = PARENT.parent / "recompyler-coverage"
TUNED = {"nbody", "fannkuch", "float", "richards", "spectral_norm", "raytrace", "coroutines", "scimark", "barnes_hut"}


def digest(data):
    return hashlib.sha256(data).hexdigest()


def read(path):
    return json.loads(Path(path).read_text(encoding="utf-8"))


def save(path, data):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    temp = path.with_name(path.name + ".tmp")
    temp.write_text(json.dumps(data, indent=2, allow_nan=False) + "\n", encoding="utf-8")
    temp.replace(path)


def file_hashes(folder):
    return {str(p.relative_to(folder)).replace("\\", "/"): digest(p.read_bytes())
            for p in sorted(Path(folder).rglob("*")) if p.is_file()
            and "__pycache__" not in p.parts and p.suffix not in {".pyc", ".pyo"}}


def input_inventory(folder, kind):
    """Full mapping; additions and deletions are as important as changed bytes."""
    folder = Path(folder)
    excluded = {"__pycache__", ".venv", ".git", "results", ".pytest_cache"}
    return {str(p.relative_to(folder)).replace("\\", "/"): digest(p.read_bytes())
            for p in sorted(folder.rglob("*")) if p.is_file()
            and not any(part in excluded for part in p.relative_to(folder).parts)
            and p.suffix not in {".pyc", ".pyo"}
            and (kind == "corpus" or p.suffix in {".py", ".pyd", ".dll", ".so"}
                 or "models" in p.relative_to(folder).parts)}


def runtime_identity():
    executable = Path(sys.executable).resolve()
    packages = {}
    for dist in importlib.metadata.distributions():
        name = dist.metadata.get("Name")
        if name:
            packages[name.lower().replace("_", "-")] = {
                "version": dist.version,
                "metadata_sha256": digest((dist.read_text("METADATA") or "").encode()),
                "record_sha256": digest((dist.read_text("RECORD") or "").encode())}
    return {"executable": str(executable), "executable_sha256": digest(executable.read_bytes()),
            "version": sys.version, "implementation": sys.implementation.name,
            "cache_tag": sys.implementation.cache_tag, "platform": platform.platform(),
            "runtime_dlls": {p.name: digest(p.read_bytes()) for p in sorted(executable.parent.glob("python*.dll"))},
            "packages": packages}


def execution_environment(bot):
    # This closed allowlist contains compiler/system paths and numeric runtime
    # controls only. Unknown variables (including credentials and bot overrides)
    # never reach children or the manifest. Values are frozen, not reread on resume.
    allowed = {"PATH", "SYSTEMROOT", "WINDIR", "COMSPEC", "PATHEXT", "SYSTEMDRIVE",
               "PROGRAMFILES", "PROGRAMFILES(X86)", "PROGRAMW6432", "PROGRAMDATA",
               "USERPROFILE", "LOCALAPPDATA", "APPDATA", "NUMBER_OF_PROCESSORS",
               "PROCESSOR_ARCHITECTURE", "PROCESSOR_IDENTIFIER", "INCLUDE", "LIB", "LIBPATH",
               "VSINSTALLDIR", "VCINSTALLDIR", "VCTOOLSINSTALLDIR", "VCTOOLSVERSION",
               "WINDOWSSDKDIR", "WINDOWSSDKVERSION", "WINDOWSSDKBINPATH", "WINDOWSSDKVERBINPATH",
               "UNIVERSALCRTSDKDIR", "UCRTVERSION", "VSCMD_ARG_HOST_ARCH", "VSCMD_ARG_TGT_ARCH",
               "CC", "CXX", "LANG", "LC_ALL", "TZ", "OMP_NUM_THREADS", "NUMBA_NUM_THREADS",
               "OPENBLAS_NUM_THREADS", "MKL_NUM_THREADS", "NUMEXPR_NUM_THREADS", "BLIS_NUM_THREADS",
               "VECLIB_MAXIMUM_THREADS", "NUMBA_THREADING_LAYER", "NUMBA_CPU_NAME", "NUMBA_CPU_FEATURES"}
    env = {k.upper(): v for k, v in os.environ.items() if k.upper() in allowed}
    bot = Path(bot).resolve()
    env.update(NUMBA_DISABLE_JIT="0", POKER_BOT=str(bot),
               POKER_COUNTER_MODEL=str(bot / "models" / "response_policy.json"),
               POKER_MODE="adaptive", POKER_VARIANT="counter_pref_identify")
    return env


def revision(folder):
    def git(*args):
        result = subprocess.run(["git", "-C", str(folder), *args], capture_output=True, text=True)
        return result.stdout.strip() if result.returncode == 0 else None
    return {"path": str(folder), "git_head": git("rev-parse", "HEAD"),
            "git_status": git("status", "--porcelain"), "src_sha256": file_hashes(folder / "src")}


def execute(stem, command, cwd, env, timeout):
    stem = Path(stem)
    result_path = stem.with_suffix(".json")
    if result_path.exists():
        return read(result_path)
    stem.parent.mkdir(parents=True, exist_ok=True)
    start = time.perf_counter()
    popen_args = {} if os.name == "nt" else {"start_new_session": True}
    process = subprocess.Popen(command, cwd=cwd, env=env, stdout=subprocess.PIPE,
                               stderr=subprocess.PIPE, **popen_args)
    status = "ok"
    try:
        stdout, stderr = process.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        status = "timeout"
        if os.name == "nt":
            subprocess.run(["taskkill", "/PID", str(process.pid), "/T", "/F"], capture_output=True)
        else:
            os.killpg(process.pid, signal.SIGKILL)
        process.kill()
        stdout, stderr = process.communicate()
    result = {"command": command, "cwd": str(cwd), "status": status,
              "exit_code": process.returncode, "wall_s": time.perf_counter() - start,
              "stdout_sha256": digest(stdout), "stdout_bytes": len(stdout),
              "utc": datetime.now(timezone.utc).isoformat()}
    stem.with_suffix(".stdout").write_bytes(stdout)
    stem.with_suffix(".stderr").write_bytes(stderr)
    save(result_path, result)
    print(f"{stem.name}: {status} exit={process.returncode} wall={result['wall_s']:.3f}s", flush=True)
    return result


def same_output(a, b):
    return (a["status"] == b["status"] == "ok" and a["exit_code"] == b["exit_code"]
            and a["stdout_sha256"] == b["stdout_sha256"])


def coverage(report):
    total = max(report.get("total_s", 0), 1e-9)
    script = report.get("script_self_s", 0)
    verified, recommended, evidence = [], [], []
    blockers = {}
    for row in report.get("functions", []):
        candidate = row.get("candidate", {})
        if candidate.get("status") == "verified":
            reach = min(script, row.get("cumulative_s", row["self_s"]) if candidate.get("engine") == "region" else row["self_s"])
            verified.append(reach)
            if candidate.get("recommended"):
                recommended.append(reach)
            evidence.append({"function": row.get("qualname", row.get("function")), "reach_fraction": reach / total,
                             "engine": candidate.get("engine"), "samples": candidate.get("samples"),
                             "compiled_samples": candidate.get("compiled_samples"),
                             "fallback_samples": candidate.get("fallback_samples"),
                             "speedup": candidate.get("speedup"), "recommended": candidate.get("recommended"),
                             "first_pass_s": candidate.get("first_pass_s"), "warm_start_s": candidate.get("warm_start_s")})
        elif row.get("function") != "<module>":
            reason = candidate.get("region_reason") or candidate.get("reason") or candidate.get("status", "unknown")
            blockers[reason] = blockers.get(reason, 0) + row.get("self_s", 0) / total
    return {"largest_verified_fraction": max(verified, default=0) / total,
            "largest_recommended_fraction": max(recommended, default=0) / total,
            "script_fraction": script / total, "verified_candidates": evidence,
            "blocker_self_fractions": blockers, "plan": report.get("plan"),
            "accounting": "maximum candidate reach, not union coverage; overlapping candidates are never summed"}


def prepare(args):
    out = Path(args.output).resolve()
    if (out / "manifest.json").exists():
        raise SystemExit("Manifest already exists; use a new output directory to change frozen choices.")
    out.mkdir(parents=True, exist_ok=True)
    shim = out / "shim"
    shutil.copytree(CORPUS / "tools" / "shim", shim, ignore=shutil.ignore_patterns("__pycache__"))
    workloads, excluded = [], []
    for path in sorted((CORPUS / "results-heldout").glob("*.json")):
        old = read(path)
        if "failed" in old:
            excluded.append({"name": path.stem, **old})
            continue
        folder = CORPUS / "corpus" / "pyperformance-1.14.0" / "benchmarks" / ("bm_" + path.stem)
        script = folder / "run_benchmark.py"
        text = script.read_text(encoding="utf-8")
        workload = {"name": path.stem, "group": "tuned" if path.stem in TUNED else "heldout",
                    "script": str(script), "cwd": str(folder), "args": [], "include": [],
                    "meaningful_work": "runner.bench_command(" not in text and "runner.timeit(" not in text,
                    "inventory_kind": "corpus", "input_sha256": input_inventory(folder, "corpus")}
        workloads.append(workload)
    folder = CORPUS / "corpus" / "pyperformance-1.14.0" / "benchmarks" / "bm_go"
    workloads.append({"name": "go", "group": "addition", "script": str(folder / "run_benchmark.py"),
                      "cwd": str(folder), "args": [], "include": [], "meaningful_work": True,
                      "inventory_kind": "corpus", "input_sha256": input_inventory(folder, "corpus")})
    bot = PARENT.parent / "heads-up-bot"
    bot_script = out / "poker_selfplay.py"
    shutil.copyfile(PARENT / "integration" / "benchmarks" / "poker_selfplay.py", bot_script)
    workloads.append({"name": "poker_selfplay", "group": "addition", "script": str(bot_script),
                      "cwd": str(bot), "args": [str(args.bot_deals), "equity"], "include": [str(bot)],
                      "meaningful_work": True, "inventory_kind": "bot", "input_sha256": input_inventory(bot, "bot"),
                      "script_sha256": digest(bot_script.read_bytes()),
                      "limitation": "Imported bot functions may verify but runner only rewrites script definitions; counters distinguish actual use."})
    manifest = {"schema": 2, "utc": datetime.now(timezone.utc).isoformat(), "python": sys.executable,
                "python_version": sys.version, "platform": platform.platform(), "samples": args.samples,
                "harness_sha256": digest(Path(__file__).read_bytes()),
                "runtime_identity": runtime_identity(), "execution_environment": execution_environment(bot),
                "limit": args.limit, "repetitions": args.repetitions, "timeout_s": args.timeout,
                "baseline_original_revision": "56211d5", "sources": {"baseline": revision(Path(args.baseline).resolve()),
                    "integrated": revision(Path(args.integrated).resolve())}, "shim_sha256": file_hashes(shim),
                "workloads": workloads, "historical_exclusions": excluded,
                "order": "per program, profiles baseline then integrated; repetitions rotate plain/baseline/integrated",
                "timing": "fresh process wall; profile-created disk cache reused, includes startup, compiler load, guards, conversions and workload; no --force",
                "equality": "exact stdout bytes and process exit only; empty stdout does not prove result equivalence; captured verification samples separate"}
    save(out / "manifest.json", manifest)
    print(f"Prepared {len(workloads)} workloads (47 fixed + 2 additions), {2 * len(workloads)} profiles and up to {3 * args.repetitions * len(workloads)} fresh-process timed runs.")


def environment(out, name, variant, source, frozen_environment):
    env = dict(frozen_environment)
    cache = out / "cache" / name / variant
    temp = cache / "temp"
    temp.mkdir(parents=True, exist_ok=True)
    env.update(PYTHONPATH=os.pathsep.join([str(out / "shim"), str(Path(source) / "src")]),
               PYTHONWARNINGS="ignore", PYTHONHASHSEED="0", PYTHONDONTWRITEBYTECODE="1",
               RECOMPYLER_CACHE=str(cache / "recompyler"), NUMBA_CACHE_DIR=str(cache / "numba"),
               MPLCONFIGDIR=str(cache / "matplotlib"), TEMP=str(temp), TMP=str(temp))
    return env


def check_frozen(out, manifest):
    if digest(Path(__file__).read_bytes()) != manifest["harness_sha256"]:
        raise SystemExit("Harness changed after preparation.")
    if file_hashes(out / "shim") != manifest["shim_sha256"]:
        raise SystemExit("Frozen shim changed.")
    if runtime_identity() != manifest["runtime_identity"]:
        raise SystemExit("Frozen runtime/dependency identity changed; prepare a new output directory.")
    for source in manifest["sources"].values():
        current = revision(Path(source["path"]))
        if current != source:
            raise SystemExit(f"Frozen source changed: {source['path']}; prepare a new output directory.")
    for w in manifest["workloads"]:
        root = Path(w["cwd"])
        if input_inventory(root, w["inventory_kind"]) != w["input_sha256"]:
            raise SystemExit(f"Frozen workload input inventory changed: {root}")
        if "script_sha256" in w and digest(Path(w["script"]).read_bytes()) != w["script_sha256"]:
            raise SystemExit("Frozen poker driver changed.")


def run(args):
    out = Path(args.output).resolve()
    manifest = read(out / "manifest.json")
    check_frozen(out, manifest)
    py, timeout = manifest["python"], manifest["timeout_s"]
    names = set(args.names or [])
    for workload in manifest["workloads"]:
        name, script, forwarded = workload["name"], workload["script"], workload["args"]
        if names and name not in names:
            continue
        directory = out / "programs" / name
        envs = {variant: environment(out, name, variant, source["path"], manifest["execution_environment"]) for variant, source in manifest["sources"].items()}
        for variant in ("baseline", "integrated"):
            plan = directory / (variant + ".plan.json")
            command = [py, "-m", "recompyler", "profile", "--json", str(plan), "--limit", str(manifest["limit"]), "--samples", str(manifest["samples"])]
            for included in workload["include"]:
                command += ["--include", included]
            command += [script, *forwarded]
            execute(directory / (variant + "-profile"), command, workload["cwd"], envs[variant], timeout)
        modes = ["plain", "baseline", "integrated"]
        for repetition in range(manifest["repetitions"]):
            for variant in modes[repetition % 3:] + modes[:repetition % 3]:
                env = envs["baseline"] if variant == "plain" else envs[variant]
                command = [py, script, *forwarded]
                if variant != "plain":
                    plan = directory / (variant + ".plan.json")
                    profile = read(directory / (variant + "-profile.json"))
                    if profile["status"] != "ok" or profile["exit_code"] != 0 or not plan.exists():
                        continue
                    command = [py, "-m", "recompyler", "run", "--json", str(directory / f"{variant}-{repetition}.counts.json"), "--plan", str(plan), script, *forwarded]
                execute(directory / f"{variant}-{repetition}", command, workload["cwd"], env, timeout)
        summarize(out)
    check_frozen(out, manifest)


def summarize(out):
    manifest = read(out / "manifest.json")
    rows = []
    for w in manifest["workloads"]:
        directory = out / "programs" / w["name"]
        row = {"name": w["name"], "group": w["group"], "meaningful_work": w["meaningful_work"]}
        plain = [read(directory / f"plain-{i}.json") for i in range(manifest["repetitions"]) if (directory / f"plain-{i}.json").exists()]
        row["plain_complete"] = len(plain) == manifest["repetitions"]
        stable = bool(plain) and all(same_output(plain[0], r) and r["exit_code"] == 0 for r in plain)
        row["plain_output_stable"] = stable
        row["stdout_has_observable_output"] = bool(plain and plain[0]["stdout_bytes"])
        row["plain_median_wall_s"] = statistics.median(r["wall_s"] for r in plain) if plain else None
        for variant in ("baseline", "integrated"):
            part = {}
            profile = directory / (variant + "-profile.json")
            plan = directory / (variant + ".plan.json")
            if profile.exists():
                prof = read(profile)
                part["profile_wall_s_including_capture_verify_build"] = prof["wall_s"]
                part["profile_status"] = prof["status"]
                part["profile_exit_code"] = prof["exit_code"]
                part["profile_stdout_exit_match"] = bool(plain and same_output(plain[0], prof))
                if prof["status"] == "ok" and prof["exit_code"] == 0 and plan.exists():
                    part["coverage"] = coverage(read(plan))
            timed = [read(directory / f"{variant}-{i}.json") for i in range(manifest["repetitions"]) if (directory / f"{variant}-{i}.json").exists()]
            part["timed_repetitions"] = len(timed)
            valid = row["plain_complete"] and stable and len(timed) == manifest["repetitions"] and all(same_output(plain[0], r) and r["exit_code"] == 0 for r in timed)
            part["stdout_exit_match"] = bool(valid)
            part["median_wall_s"] = statistics.median(r["wall_s"] for r in timed) if timed else None
            part["process_speedup"] = row["plain_median_wall_s"] / part["median_wall_s"] if valid else None
            part["wall_samples_s"] = [r["wall_s"] for r in timed]
            counts = [read(directory / f"{variant}-{i}.counts.json") for i in range(manifest["repetitions"]) if (directory / f"{variant}-{i}.counts.json").exists()]
            part["run_counts"] = counts
            part["compiled_calls_total"] = sum(f.get("compiled_calls", 0) for c in counts for f in c.get("functions", []))
            part["fallback_calls_total"] = sum(f.get("fallback_calls", 0) for c in counts for f in c.get("functions", []))
            part["batch_rows_total"] = sum(b.get("rows", 0) for c in counts for b in c.get("batches", {}).values())
            row[variant] = part
        rows.append(row)
    groups = {}
    for group in ("heldout", "tuned", "addition"):
        fixed = [r for r in rows if r["group"] == group]
        paired = [r for r in fixed if r["meaningful_work"] and all(r[v].get("process_speedup") is not None for v in ("baseline", "integrated"))]
        groups[group] = {"fixed_population": len(fixed), "paired_meaningful_timing_n": len(paired),
                         "paired_names": [r["name"] for r in paired]}
        for variant in ("baseline", "integrated"):
            cover = [r[variant]["coverage"] for r in fixed if "coverage" in r[variant]]
            groups[group][variant] = {"successful_profiles": len(cover),
                "mean_largest_verified_fraction_fixed_denominator": sum(c["largest_verified_fraction"] for c in cover) / len(fixed) if fixed else None,
                "over_10pct_verified": sum(c["largest_verified_fraction"] > .1 for c in cover),
                "process_speedup_geomean_paired": math.exp(statistics.mean(math.log(r[variant]["process_speedup"]) for r in paired)) if paired else None}
    save(out / "summary.json", {"groups": groups, "programs": rows,
         "limitations": [manifest["equality"], "Coverage is largest verified-candidate share, an overlap-safe approximation, not union coverage.",
                         "Kernel candidate speedups exclude process/profile cost and are never process-speedup claims.",
                         "Historical failed packages/data are exclusions recorded in manifest; attempted additions separate."]})
    return groups


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("mode", choices=["prepare", "run", "summary"])
    parser.add_argument("--output", default=str(HERE / "results"))
    parser.add_argument("--baseline", default=str(PARENT / "baseline"))
    parser.add_argument("--integrated", default=str(PARENT / "integration"))
    parser.add_argument("--limit", type=int, default=40)
    parser.add_argument("--samples", type=int, default=8)
    parser.add_argument("--repetitions", type=int, default=5)
    parser.add_argument("--timeout", type=float, default=180)
    parser.add_argument("--bot-deals", type=int, default=2)
    parser.add_argument("--names", nargs="*")
    args = parser.parse_args()
    if min(args.limit, args.samples, args.repetitions, args.timeout, args.bot_deals) <= 0:
        parser.error("numeric settings must be positive")
    if args.mode == "prepare":
        prepare(args)
    elif args.mode == "run":
        run(args)
    else:
        print(json.dumps(summarize(Path(args.output).resolve()), indent=2))


if __name__ == "__main__":
    main()
