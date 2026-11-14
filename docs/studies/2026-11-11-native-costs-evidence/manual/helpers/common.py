"""Wave 3 matched study with warm bytecode and separate execution-mode audits.

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


def bytecode_inventory(folder):
    return {str(p.relative_to(folder)).replace("\\", "/"): digest(p.read_bytes())
            for p in sorted(Path(folder).rglob("*")) if p.is_file()}


def verify_bytecode(folder, expected):
    if bytecode_inventory(folder) != expected:
        raise SystemExit(f"Frozen bytecode changed: {folder}")


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


def exact_timing_modes(counts, repetitions):
    rows = [row for report in counts for row in report.get("functions", [])]
    if len(counts) != repetitions or not rows or not all("aot_calls" in r and "jit_calls" in r for r in rows):
        return None, None
    return sum(r["aot_calls"] for r in rows), sum(r["jit_calls"] for r in rows)


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


