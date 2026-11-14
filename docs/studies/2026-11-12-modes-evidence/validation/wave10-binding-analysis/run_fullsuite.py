"""Explicitly invoked only after the coordinator's post-review CPU grant."""
import argparse
from datetime import datetime, timezone
import hashlib
import importlib.metadata
import json
import os
from pathlib import Path
import platform
import subprocess
import sys
import time


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def write_new(path, value):
    with path.open("x", encoding="utf-8", newline="\n") as stream:
        json.dump(value, stream, indent=2)
        stream.write("\n")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--expected-commit", required=True)
    parser.add_argument("--label", required=True)
    parser.add_argument("--input-map", default="after-contract-fix-input-map.json")
    arguments = parser.parse_args()
    reports = Path(__file__).resolve().parent
    repository = reports.parent / "wave10-binding"
    if not arguments.label.replace("-", "").isalnum():
        parser.error("label must contain only letters, digits and hyphens")
    stem = reports / arguments.label
    output_paths = [stem.with_suffix(extension) for extension in
                    (".stdout", ".stderr", ".before.json", ".after.json", ".receipt.json")]
    if any(path.exists() for path in output_paths):
        raise FileExistsError("Run evidence exists; use a new label")
    commit = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=repository, text=True).strip()
    if commit != arguments.expected_commit:
        raise RuntimeError("The reviewed commit is not the current checkout")
    git_status_before = subprocess.check_output(["git", "status", "--porcelain"], cwd=repository, text=True)
    if git_status_before.strip():
        raise RuntimeError("The reviewed checkout is not clean before the run")
    input_map = reports / arguments.input_map
    expected = json.loads(input_map.read_text(encoding="utf-8-sig"))
    paths = tuple(expected)
    assert len(paths) == 65
    before = {name: sha(repository / name) for name in paths}
    if before != expected:
        raise RuntimeError("The reviewed source/test bytes changed before the run")

    sys.path.insert(0, str(repository / "src"))
    from recompyler import heap, _monitor
    assert heap.NATIVE and heap._native is not None
    expected_support = {
        "_heap": "17e2e43e8825188a9e4339586b47fcc712d81a13ef90874cf869cac099dd16e0",
        "_monitor": "00d6138bbf198ecff79cea44e18de1d122727c3c0e2acacbe9260a603f22e9e5",
    }
    support = {}
    for name, module in (("_heap", heap._native), ("_monitor", _monitor)):
        support[name] = {"path": str(Path(module.__file__).resolve()), "sha256": sha(module.__file__)}
        assert support[name]["sha256"] == expected_support[name]
    before_all = dict(before)
    before_all.update((str(Path(item["path"]).relative_to(repository)).replace("\\", "/"), item["sha256"])
                      for item in support.values())
    write_new(stem.with_suffix(".before.json"), before_all)

    environment = dict(os.environ)
    environment["RECOMPYLER_CACHE"] = str(reports / (arguments.label + "-cache"))
    environment["PYTHONDONTWRITEBYTECODE"] = "1"
    environment["PYTHONPATH"] = str(repository / "src")
    environment["NUMBA_CACHE_DIR"] = str(reports / (arguments.label + "-numba"))
    for name in ("NUMBA_NUM_THREADS", "OMP_NUM_THREADS", "OPENBLAS_NUM_THREADS", "MKL_NUM_THREADS", "NUMEXPR_NUM_THREADS"):
        environment[name] = "1"
    temporary = reports / (arguments.label + "-temp")
    temporary.mkdir(exist_ok=False)
    environment["TEMP"] = environment["TMP"] = str(temporary)
    command = [sys.executable, "-m", "pytest", "-q", "tests"]
    receipt = {
        "commit": commit, "cwd": str(repository), "command": command,
        "started_utc": datetime.now(timezone.utc).isoformat(),
        "python": sys.version, "executable": sys.executable, "executable_sha256": sha(sys.executable),
        "platform": platform.platform(), "machine": platform.machine(),
        "packages": {name: importlib.metadata.version(name) for name in ("numba", "numpy", "pytest")},
        "environment": {name: environment.get(name) for name in
                        ("PYTHONPATH", "RECOMPYLER_CACHE", "NUMBA_CACHE_DIR", "NUMBA_CPU_NAME",
                         "NUMBA_NUM_THREADS", "OMP_NUM_THREADS", "PYTHONDONTWRITEBYTECODE")},
        "input_files": len(paths), "native_binary_files": len(support), "total_input_files": len(before_all),
        "native_loader_enabled": heap.NATIVE, "support": support,
        "git_clean_before": not git_status_before.strip(),
        "reviewed_input_map": str(input_map), "reviewed_input_map_sha256": sha(input_map),
        "runner_sha256": sha(__file__),
    }
    print(json.dumps({"command": command, "commit": commit, "started_utc": receipt["started_utc"]}), flush=True)
    started = time.perf_counter()
    with stem.with_suffix(".stdout").open("xb") as stdout, stem.with_suffix(".stderr").open("xb") as stderr:
        process = subprocess.run(command, cwd=repository, env=environment, stdout=stdout, stderr=stderr)
    receipt["elapsed_s"] = time.perf_counter() - started
    receipt["exit_code"] = process.returncode
    after = {name: sha(repository / name) for name in paths}
    receipt["inputs_unchanged"] = after == before
    receipt["support_after"] = {name: sha(item["path"]) for name, item in support.items()}
    receipt["support_unchanged"] = receipt["support_after"] == expected_support
    after_all = dict(after)
    after_all.update((str(Path(item["path"]).relative_to(repository)).replace("\\", "/"), receipt["support_after"][name])
                     for name, item in support.items())
    write_new(stem.with_suffix(".after.json"), after_all)
    receipt["git_clean_after"] = not subprocess.check_output(["git", "status", "--porcelain"], cwd=repository, text=True).strip()
    receipt["stdout_sha256"] = sha(stem.with_suffix(".stdout"))
    receipt["stderr_sha256"] = sha(stem.with_suffix(".stderr"))
    receipt["finished_utc"] = datetime.now(timezone.utc).isoformat()
    write_new(stem.with_suffix(".receipt.json"), receipt)
    print(json.dumps(receipt), flush=True)
    if not receipt["inputs_unchanged"] or not receipt["support_unchanged"] or not receipt["git_clean_after"]:
        return 2
    return process.returncode


if __name__ == "__main__":
    raise SystemExit(main())
