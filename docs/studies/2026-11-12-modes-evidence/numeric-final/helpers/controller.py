"""New append-only rotating controller. Every executing command requires a grant."""
import argparse
import json
from pathlib import Path
import statistics
import subprocess
import sys

from common import HERE, SCHEMA, environment, execute, read, require_grant, sha, write_new


def build(root, manifest, grant):
    build = root / "build"
    build.mkdir(exist_ok=False)
    clang = manifest["clang"]["path"]
    env = environment(root / "cache" / "c-build")
    flags = manifest["c_flags"]
    commands = [
        [clang, *flags, "-c", str(root / "inputs" / "kernels.c"), "-o", str(build / "kernels.obj")],
        [clang, *flags, "-c", str(HERE / "batch.c"), "-o", str(build / "batch.obj")],
        [clang, "-shared", str(build / "kernels.obj"), str(build / "batch.obj"), "-o", str(build / "kernels.dll")],
        [clang, *flags, "-S", "-emit-llvm", str(root / "inputs" / "kernels.c"), "-o", str(build / "kernels.ll")],
    ]
    for index, command in enumerate(commands):
        execute(root / "processes" / f"c-build-{index}", command, root, env)
    tool_root = Path(clang).parent
    for name, command in (
        ("c-disassembly", [str(tool_root / "llvm-objdump.exe"), "--disassemble", "--demangle", "--no-show-raw-insn", str(build / "kernels.dll")]),
        ("c-exports", [str(tool_root / "llvm-readobj.exe"), "--coff-exports", str(build / "kernels.dll")]),
    ):
        execute(root / "processes" / name, command, root, env)
    write_new(build / "identity.json", {"schema": SCHEMA, "manifest_sha256": sha(root / "manifest.json"),
              "grant_sha256": sha(grant), "commands": commands, "link_time_optimization": False,
              "files": {p.name: sha(p) for p in sorted(build.iterdir()) if p.is_file()}})


def cell(root, manifest, grant, task, function, variant, label):
    source = root / "inputs" / ("current" if variant == "current-strict" else "candidate")
    cache = root / "cache" / "native-cold" / label if task in {"native", "native-smoke"} else root / "cache" / variant
    env = environment(cache, source)
    output = root / "cells" / label
    command = [manifest["runtime"]["executable"], "-B", str(HERE / "worker.py"),
               "--root", str(root), "--grant", str(grant), "--task", task,
               "--function", function, "--variant", variant, "--output", str(output)]
    execute(root / "processes" / label, command, root, env)
    return read(output / "result.json")


def summary(root):
    manifest = read(root / "manifest.json")
    results = []
    for path in sorted((root / "cells").glob("*/result.json")):
        row = read(path)
        assert row["manifest_sha256"] == sha(root / "manifest.json")
        results.append((path, row))
    groups = {}
    for path, row in results:
        if row["task"] not in {"time", "time-aot", "native"}:
            continue
        key = (row["function"], row["variant"], row["task"])
        groups.setdefault(key, []).append((path, row))
    output = []
    for (function, variant, task), rows in sorted(groups.items()):
        timed = [row if task in {"time", "time-aot"} else row["native_batch"] for _, row in rows]
        if not all(row.get("available", True) for row in timed):
            output.append({"function": function, "variant": variant, "task": task,
                           "available": False, "reasons": [row.get("reason") for row in timed]})
            continue
        medians = [row["median_ns"] for row in timed]
        iterations = timed[0]["samples"][0].get("calls", timed[0]["samples"][0].get("native_invocations"))
        output.append({"function": function, "variant": variant, "task": task,
                       "children": len(rows), "samples": sum(len(row["samples"]) for row in timed),
                       "median_child_ns": statistics.median(medians), "min_child_ns": min(medians),
                       "max_child_ns": max(medians), "calls_per_sample": iterations,
                       "median_ns_per_call": statistics.median(medians) / iterations,
                       "cells": [{"path": str(path), "sha256": sha(path)} for path, _ in rows]})
    write_new(root / "summary.json", {"schema": SCHEMA, "manifest_sha256": sha(root / "manifest.json"),
              "fixed_rounds": manifest["rounds"], "cells": output,
              "no_historical_pooling": True})


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--grant", type=Path, required=True)
    parser.add_argument("--stage", choices=("all", "build", "preflight", "build-aot", "audit-aot", "timing", "summary"), required=True)
    args = parser.parse_args()
    require_grant(args.grant)
    root = args.root.resolve()
    manifest = read(root / "manifest.json")
    if args.stage == "all":
        for stage in ("build", "preflight", "build-aot", "audit-aot", "timing", "summary"):
            print(json.dumps({"starting_stage": stage}), flush=True)
            subprocess.run([sys.executable, "-B", str(Path(__file__).resolve()), "--root", str(root),
                            "--grant", str(args.grant.resolve()), "--stage", stage], check=True)
    elif args.stage == "build":
        build(root, manifest, args.grant)
    elif args.stage == "summary":
        summary(root)
    elif args.stage == "preflight":
        for function in read(root / "inputs" / "corpus.json"):
            for variant in manifest["variants"]:
                for task in ("prepare", "audit"):
                    cell(root, manifest, args.grant, task, function, variant, f"{task}-{function}-{variant}")
            print(json.dumps({"preflight_function_complete": function}), flush=True)
    elif args.stage in {"build-aot", "audit-aot"}:
        for function in read(root / "inputs" / "corpus.json"):
            for variant in ("current-strict", "candidate-strict", "checked", "unchecked-int64"):
                cell(root, manifest, args.grant, args.stage, function, variant,
                     f"{args.stage}-{function}-{variant}")
            print(json.dumps({"stage": args.stage, "function_complete": function}), flush=True)
    elif args.stage == "timing":
        # Cyclic order; reverse odd rounds. No timings select later kernels/order.
        variants = manifest["variants"]
        for round_number in range(manifest["rounds"]):
            offset = round_number % len(variants)
            order = variants[offset:] + variants[:offset]
            if round_number % 2:
                order = list(reversed(order))
            for function in read(root / "inputs" / "corpus.json"):
                for variant in order:
                    tasks = (("time-aot",) if variant in {"current-strict", "candidate-strict", "checked", "unchecked-int64"}
                             else ("time",))
                    for task in tasks:
                        cell(root, manifest, args.grant, task, function, variant,
                             f"{task}-r{round_number}-{function}-{variant}")
            print(json.dumps({"timing_round_complete": round_number + 1}), flush=True)
    print(json.dumps({"stage": args.stage, "root": str(root), "completed": True}))


if __name__ == "__main__":
    main()
