"""New wave10 evidence helpers. Importing this module imports no product/runtime."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
CURRENT_HEAD = "1d4084f914fa9594ecb801e3efa565edcd7e1241"
SCHEMA = "wave10-numeric-study-v1"
COUNTERS = ("compiled_calls", "aot_calls", "jit_calls", "fallback_calls",
            "contract_native_calls", "guard_misses", "representation_rejections",
            "loop_limit_rejections", "native_failures", "foreign_calls")


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def digest(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(",", ":"),
                                     allow_nan=False).encode()).hexdigest()


def read(path):
    return json.loads(Path(path).read_text(encoding="utf-8"))


def write_new(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("x", encoding="utf-8", newline="\n") as stream:
        json.dump(value, stream, indent=2, allow_nan=False)
        stream.write("\n")


def inventory(root, suffixes=None):
    root = Path(root)
    return {p.relative_to(root).as_posix(): sha(p) for p in sorted(root.rglob("*"))
            if p.is_file() and not any(part in {"__pycache__", ".git", ".pytest_cache"}
                                       for part in p.relative_to(root).parts)
            and p.suffix not in {".pyc", ".pyo"}
            and (suffixes is None or p.suffix in suffixes)}


def counters(region):
    return {name: int(getattr(region, name, 0)) for name in COUNTERS}


def delta(after, before):
    return {name: after[name] - before[name] for name in COUNTERS}


def environment(cache, source=None):
    allowed = {"PATH", "SYSTEMROOT", "WINDIR", "COMSPEC", "PATHEXT", "SYSTEMDRIVE",
               "PROGRAMFILES", "PROGRAMFILES(X86)", "PROGRAMW6432", "PROGRAMDATA",
               "USERPROFILE", "LOCALAPPDATA", "APPDATA", "NUMBER_OF_PROCESSORS",
               "PROCESSOR_ARCHITECTURE", "PROCESSOR_IDENTIFIER", "INCLUDE", "LIB", "LIBPATH",
               "VSINSTALLDIR", "VCINSTALLDIR", "VCTOOLSINSTALLDIR", "VCTOOLSVERSION",
               "WINDOWSSDKDIR", "WINDOWSSDKVERSION", "WINDOWSSDKBINPATH", "WINDOWSSDKVERBINPATH",
               "UNIVERSALCRTSDKDIR", "UCRTVERSION", "VSCMD_ARG_HOST_ARCH", "VSCMD_ARG_TGT_ARCH"}
    env = {key.upper(): value for key, value in os.environ.items() if key.upper() in allowed}
    cache = Path(cache).resolve()
    temp = cache.parent / "temp"
    temp.mkdir(parents=True, exist_ok=True)
    env.update(RECOMPYLER_CACHE=str(cache), NUMBA_CACHE_DIR=str(cache / "numba"),
               PYTHONDONTWRITEBYTECODE="1", PYTHONHASHSEED="0", NUMBA_CPU_NAME="generic",
               OMP_NUM_THREADS="1", NUMBA_NUM_THREADS="1", OPENBLAS_NUM_THREADS="1",
               MKL_NUM_THREADS="1", NUMEXPR_NUM_THREADS="1", TEMP=str(temp), TMP=str(temp))
    if source:
        env["PYTHONPATH"] = str(Path(source).resolve())
    return env


def execute(stem, command, cwd, env, timeout=240):
    """Append-only process record, including raw streams and complete process wall."""
    stem = Path(stem)
    if any(stem.with_suffix(ext).exists() for ext in (".json", ".stdout", ".stderr")):
        raise FileExistsError(f"Evidence exists, choose a new cohort: {stem}")
    stem.parent.mkdir(parents=True, exist_ok=True)
    start = time.perf_counter()
    timed_out = False
    process = subprocess.Popen(command, cwd=str(cwd), env=env,
                               stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    try:
        stdout, stderr = process.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        timed_out = True
        if os.name == "nt":
            subprocess.run(["taskkill", "/PID", str(process.pid), "/T", "/F"],
                           stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        process.kill()
        stdout, stderr = process.communicate()
    result = {"schema": SCHEMA, "command": command, "cwd": str(cwd),
              "environment": env, "utc": datetime.now(timezone.utc).isoformat(),
              "timed_out": timed_out, "exit_code": process.returncode,
              "wall_s": time.perf_counter() - start,
              "stdout_sha256": hashlib.sha256(stdout).hexdigest(),
              "stderr_sha256": hashlib.sha256(stderr).hexdigest()}
    stem.with_suffix(".stdout").write_bytes(stdout)
    stem.with_suffix(".stderr").write_bytes(stderr)
    write_new(stem.with_suffix(".json"), result)
    if process.returncode or timed_out:
        raise RuntimeError(f"Process failed; retained {stem}: {stderr.decode(errors='replace')[-1600:]}")
    return result


def require_grant(path):
    grant = read(path)
    if grant.get("schema") != SCHEMA or grant.get("exclusive_cpu_grant") is not True:
        raise ValueError("An explicit coordinator CPU grant is required")
    return grant
