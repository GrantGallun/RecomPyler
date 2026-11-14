#!/usr/bin/env python3
"""Portable, stdlib-only evidence tools. See tools/README.md."""
import argparse
import difflib
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys

CASES = {
    "negative-indices": ["tests/test_heap_indices.py", "-k", "python_negative_indices or negative_ndarray_stride"],
    "native-present": ["tests/test_heap_indices.py", "-k", "object_slot_machine_code"],
    "nullable-fields": ["tests/test_heap_indices.py", "-k", "nullable_tuple or missing_or_unbound or partial_class_field or optional_mixed"],
    "rollback": ["tests/test_array_fallback.py"],
    "cross-process": ["tests/test_region_reuse.py::test_source_and_seed_stable_across_processes"],
    "native-reuse": ["tests/test_region_reuse.py::test_native_reuse_empty_globals",
                     "tests/test_region_reuse.py::test_native_reuse_guard_miss_once",
                     "tests/test_region_reuse.py::test_reuse_guards_after_success"],
}


def metadata(path):
    path = Path(path).resolve(strict=True)
    raw = path.read_bytes()
    return {"path": str(path), "bytes": len(raw), "sha256": hashlib.sha256(raw).hexdigest()}


def executable(value):
    found = shutil.which(value)
    if found is None:
        raise ValueError(f"executable not found: {value}")
    return str(Path(found).resolve())


def save(path, data):
    path.write_text(json.dumps(data, indent=2, ensure_ascii=True) + "\n", encoding="utf-8")


def output(args):
    path = Path(args.output).resolve()
    path.mkdir(parents=True, exist_ok=False)
    return path


def invoke(command, out, stem, timeout, **kwargs):
    try:
        result = subprocess.run(command, capture_output=True, timeout=timeout, **kwargs)
        stdout, stderr, code = result.stdout, result.stderr, result.returncode
        error = None
    except subprocess.TimeoutExpired as exc:
        stdout, stderr, code = exc.stdout or b"", exc.stderr or b"", None
        error = f"timeout after {timeout} seconds"
    (out / f"{stem}stdout.bin").write_bytes(stdout)
    (out / f"{stem}stderr.bin").write_bytes(stderr)
    return {"command": command, "returncode": code, "error": error,
            "timeout_scope": "direct child only; descendants created by the target/tool may survive a timeout"}, stdout


def diff(args):
    left, right = metadata(args.left), metadata(args.right)
    raw = [Path(row["path"]).read_bytes() for row in (left, right)]
    compared = raw[:]
    for normalize in args.normalize:
        if normalize == "newlines":
            compared = [b.replace(b"\r\n", b"\n").replace(b"\r", b"\n") for b in compared]
        else:
            compared = [re.sub(rb"(?m)^(\s*)[0-9a-fA-F]+:", rb"\1<address>:", b) for b in compared]
    out = output(args)
    for name, data in zip(("left.raw", "right.raw"), raw):
        (out / name).write_bytes(data)
    # Quoting each byte-line makes CR/LF, missing final newline and non-UTF8
    # differences visible. Raw copies remain the authoritative lossless data.
    lines = [[json.dumps(line.decode("latin1")) + "\n" for line in data.splitlines(keepends=True)] for data in compared]
    delta = "".join(difflib.unified_diff(*lines, fromfile=left["path"], tofile=right["path"]))
    (out / "diff.txt").write_text(delta, encoding="utf-8")
    same = compared[0] == compared[1]
    save(out / "report.json", {"kind": "byte-line-diff", "left": left, "right": right,
                              "normalization": args.normalize, "raw_equal": raw[0] == raw[1],
                              "compared_equal": same})
    return 0 if same else 1


def asm(args):
    binary, tool = metadata(args.binary), executable(args.tool)
    if (args.start is None) != (args.stop is None) or (args.start is not None and args.start >= args.stop):
        raise ValueError("--start and --stop must specify an increasing address range")
    out = output(args)
    prefix = [tool, *args.tool_arg]
    version, stdout = invoke([*prefix, "--version"], out, "version-", args.timeout)
    report = {"kind": args.kind, "kind_origin": "user-supplied label; not inferred from filename",
              "binary": binary, "tool": metadata(tool), "tool_arguments": args.tool_arg,
              "tool_version": stdout.decode("utf-8", "replace"), "version_command": version,
              "status": "error", "binary_executed": False}
    if version["returncode"] != 0:
        save(out / "report.json", report)
        return 2
    command = [*prefix, "-d", *( ["--x86-asm-syntax=intel"] if args.format == "llvm" else ["-M", "intel"])]
    if args.start is not None:
        command += [f"--start-address={args.start}", f"--stop-address={args.stop}"]
    command.append(binary["path"])
    result, stdout = invoke(command, out, "assembly-", args.timeout)
    (out / "assembly.txt").write_bytes(stdout)
    headers, _ = invoke([*prefix, "-p", "-t", binary["path"]], out, "headers-", args.timeout)
    report.update(result, headers=headers)
    report["status"] = "ok" if result["returncode"] == headers["returncode"] == 0 else "error"
    report["symbol_note"] = "Raw tool symbols only; stripped or ambiguous symbols are not guessed. Address ranges require independent provenance."
    save(out / "report.json", report)
    return 0 if report["status"] == "ok" else 2


def c_view(args):
    source = metadata(args.source)
    includes = [metadata(p) for p in args.include]
    binary = metadata(args.binary) if args.binary else None
    compiler = executable(args.compiler) if args.compiler else None
    out = output(args)
    (out / "source.raw").write_bytes(Path(source["path"]).read_bytes())
    report = {"kind": "c-provenance", "source": source, "includes": includes, "binary": binary,
              "flags": args.flag, "flags_origin": "user-supplied; not recovered from binary",
              "build_performed": False, "status": "ok"}
    if compiler:
        result, stdout = invoke([compiler, "--version"], out, "compiler-", args.timeout)
        report.update(compiler=metadata(compiler), compiler_version=stdout.decode("utf-8", "replace"), version_command=result)
        if result["returncode"] != 0:
            report["status"] = "error"
    save(out / "report.json", report)
    return 0 if report["status"] == "ok" else 2


def phases(args):
    repo = Path(args.repo).resolve(strict=True)
    script, plan = metadata(args.script), metadata(args.plan)
    python = executable(args.python)
    package = repo / "src" / "recompyler"
    if not (package / "heap.py").is_file() or not (package / "runner.py").is_file():
        raise ValueError("--repo must contain src/recompyler/heap.py and runner.py")
    out = output(args)
    cwd = Path(args.cwd).resolve(strict=True) if args.cwd else repo
    config = {"repo": str(repo), "script": script["path"], "plan": plan["path"], "function": args.function,
              "line": args.line, "force": args.force, "script_args": args.arg,
              "result": str(out / "diagnostic.json")}
    save(out / "config.json", config)
    report = {"kind": "instrumented-region-diagnostic", "script": script, "plan": plan,
              "python": metadata(python), "source": [metadata(p) for p in sorted(package.rglob("*")) if p.suffix in {".py", ".c", ".h"}],
              "artifacts": [metadata(p) for p in args.artifact]}
    planned = []
    sections = json.loads(Path(plan["path"]).read_text(encoding="utf-8")).get("plan", {})
    for kind in ("aot", "aot_regions"):
        section = sections.get(kind)
        if not section or not section.get("folder") or not section.get("module"):
            continue
        folder = Path(section["folder"])
        folder = folder if folder.is_absolute() else cwd / folder
        parts = section["module"].split(".")
        folder = folder.joinpath(*parts[:-1])
        candidates = [metadata(p) for p in sorted(folder.glob(parts[-1] + ".*"))
                      if p.suffix.lower() in {".pyd", ".so", ".dll", ".dylib"} and p.is_file()]
        planned.append({"section": kind, "module": section["module"], "folder": str(folder.resolve()),
                        "candidates": candidates, "loaded": None})
    report["planned_artifacts"] = planned
    env = dict(os.environ, PYTHONDONTWRITEBYTECODE="1")
    env["RECOMPYLER_CACHE"] = str(Path(args.cache).resolve()) if args.cache else str(out / "cache")
    env["NUMBA_CACHE_DIR"] = str(out / "numba-cache")
    report["cache"] = env["RECOMPYLER_CACHE"]
    worker = Path(__file__).with_name("_phase_worker.py")
    result, stdout = invoke([python, str(worker), str(out / "config.json")], out, "", args.timeout,
                            cwd=str(cwd), env=env)
    report.update(result)
    report["worker"] = metadata(worker)
    report["checks"] = [line for line in stdout.decode("utf-8", "replace").splitlines() if line.startswith("check ")]
    diagnostic_path = out / "diagnostic.json"
    report["diagnostic"] = json.loads(diagnostic_path.read_text(encoding="utf-8")) if diagnostic_path.exists() else {"error": "worker did not produce a diagnostic"}
    loaded = report["diagnostic"].get("loaded_native_modules", [])
    for item in planned:
        item["loaded"] = next((row for row in loaded if row.get("module") == item["module"]), None)
    report["status"] = "ok" if result["returncode"] == 0 and "error" not in report["diagnostic"] else "error"
    save(out / "report.json", report)
    return 0 if report["status"] == "ok" else 2


def cases(args):
    if args.list:
        print(json.dumps(CASES, indent=2))
        return 0
    if not (args.case and args.repo and args.python and args.output):
        raise ValueError("cases requires CASE, --repo, --python and --output, or --list")
    repo = Path(args.repo).resolve(strict=True)
    selectors = CASES[args.case]
    files = [repo / s.split("::")[0] for s in selectors if s.startswith("tests/")]
    for path in files:
        if not path.is_file():
            raise ValueError(f"case unavailable in this checkout: {path}")
    command = [executable(args.python), "-m", "pytest", *selectors, "-q"]
    out = output(args)
    report = {"case": args.case, "command": command, "repo": str(repo), "executed": not args.dry_run,
              "test_sources": [metadata(p) for p in files]}
    if not args.dry_run:
        env = dict(os.environ, PYTHONPATH=str(repo / "src"), PYTHONDONTWRITEBYTECODE="1")
        result, _ = invoke(command, out, "", args.timeout, cwd=repo, env=env)
        report.update(result)
    save(out / "report.json", report)
    return 0 if args.dry_run or report["returncode"] == 0 else 2


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="command", required=True)
    p = commands.add_parser("diff", help="lossless byte-line comparison; raw copies always retained")
    p.add_argument("left"); p.add_argument("right")
    p.add_argument("--normalize", choices=["newlines", "asm-addresses"], action="append", default=[])
    p.set_defaults(action=diff)
    p = commands.add_parser("asm", help="read existing binary using objdump; never execute it")
    p.add_argument("--binary", required=True); p.add_argument("--tool", default="llvm-objdump")
    p.add_argument("--tool-arg", action="append", default=[])
    p.add_argument("--format", choices=["llvm", "gnu"], default="llvm")
    p.add_argument("--kind", choices=["actual-aot", "cached-jit", "c", "unknown"], default="unknown")
    p.add_argument("--start", type=lambda s: int(s, 0)); p.add_argument("--stop", type=lambda s: int(s, 0))
    p.set_defaults(action=asm)
    p = commands.add_parser("c", help="capture C source/flags/tool provenance without building")
    p.add_argument("--source", required=True); p.add_argument("--binary"); p.add_argument("--compiler")
    p.add_argument("--flag", action="append", default=[]); p.add_argument("--include", action="append", default=[])
    p.set_defaults(action=c_view)
    p = commands.add_parser("phases", help="execute an instrumented region run in a child Python")
    for key in ("repo", "python", "script", "plan", "function"):
        p.add_argument("--" + key, required=True)
    p.add_argument("--line", type=int); p.add_argument("--force", action="store_true")
    p.add_argument("--arg", action="append", default=[]); p.add_argument("--artifact", action="append", default=[])
    p.add_argument("--cache"); p.add_argument("--cwd")
    p.set_defaults(action=phases)
    p = commands.add_parser("cases", help="list or invoke named compiler regression cases")
    p.add_argument("case", choices=CASES, nargs="?"); p.add_argument("--list", action="store_true")
    p.add_argument("--repo"); p.add_argument("--python"); p.add_argument("--dry-run", action="store_true")
    p.set_defaults(action=cases)
    for name, command in commands.choices.items():
        command.add_argument("--output", required=name != "cases", help="new evidence directory; existing paths are never overwritten")
        command.add_argument("--timeout", type=float, default=300, help="child command timeout in seconds")
    args = parser.parse_args()
    try:
        if args.timeout <= 0:
            raise ValueError("--timeout must be positive")
        return args.action(args)
    except (OSError, ValueError, KeyError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
