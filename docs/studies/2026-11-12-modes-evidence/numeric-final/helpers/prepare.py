"""Freeze new source/corpus metadata. No product, NumPy or Numba imports."""
import argparse
import hashlib
import importlib.metadata
import itertools
import json
from pathlib import Path
import platform
import random
import shutil
import subprocess
import sys

from common import CURRENT_HEAD, HERE, SCHEMA, digest, inventory, read, sha, write_new

STEPS = (1, 16, 64)
BOUND = 2**20


def recurrence_source(steps):
    return (f"def recurrence_{steps}(x, y, z):\n    t = x\n"
            + "    t = t * y + z\n" * steps + "    return t\n")


def c_source():
    out = ['#include <stdint.h>\n', '#include <stddef.h>\n',
           '#if defined(_WIN32)\n#define API __declspec(dllexport)\n',
           '#define NI __declspec(noinline)\n#else\n',
           '#define API __attribute__((visibility("default")))\n',
           '#define NI __attribute__((noinline))\n#endif\n']
    for steps in STEPS:
        for mode, kind in (("exact", "int64_t"), ("wrap", "uint64_t")):
            parameters = ("int64_t x_in, int64_t y_in, int64_t z_in, int64_t unused_n" if mode == "wrap"
                          else "int64_t x, int64_t y, int64_t z, int64_t unused_n")
            out.append(f"API NI {kind} recurrence_{steps}_{mode}({parameters}) {{\n")
            if mode == "wrap":
                out.append("    uint64_t x=(uint64_t)x_in, y=(uint64_t)y_in, z=(uint64_t)z_in;\n")
            out.append(f"    {kind} t = x;\n" + "    t = t * y + z;\n" * steps + "    return t;\n}\n")
    for mode, kind in (("exact", "int64_t"), ("wrap", "uint64_t")):
        out.append(f"API NI {kind} loop_recurrence16_{mode}(int64_t x_in, int64_t y_in, int64_t z_in, int64_t n) {{\n")
        out.append(f"    {kind} t=({kind})x_in, y=({kind})y_in, z=({kind})z_in;\n")
        out.append("    for (int64_t i=0; i<n; ++i) {\n" + "        t = t * y + z;\n" * 16 + "    }\n    return t;\n}\n")
    out.append("API NI int64_t fibonacci_exact(int64_t n, int64_t unused_y, int64_t unused_z, int64_t unused_n) {\n"
               "    int64_t a=0, b=1;\n"
               "    for (int64_t i=0; i<n; ++i) { int64_t next=a+b; a=b; b=next; }\n"
               "    return a;\n}\n")
    out.append("API NI uint64_t fibonacci_wrap(int64_t n, int64_t unused_y, int64_t unused_z, int64_t unused_n) {\n"
               "    uint64_t a=0, b=1;\n"
               "    for (int64_t i=0; i<n; ++i) { uint64_t next=a+b; a=b; b=next; }\n"
               "    return a;\n}\n")
    return "".join(out)


def freeze(source, destination):
    source = Path(source).resolve()
    git = ["git", "-c", f"safe.directory={source.as_posix()}", "-C", str(source)]
    head = subprocess.check_output([*git, "rev-parse", "HEAD"], text=True).strip()
    status = subprocess.check_output([*git, "status", "--porcelain"], text=True)
    files = inventory(source / "src")
    for name in files:
        target = destination / name
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(source / "src" / name, target)
    assert inventory(destination) == files
    return {"original_path": str(source), "git_head": head, "git_status": status,
            "files": files, "tree_identity": digest(files), "frozen_path": str(destination)}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--current", type=Path, required=True)
    parser.add_argument("--candidate", type=Path, required=True)
    parser.add_argument("--candidate-commit", required=True)
    parser.add_argument("--native-reference", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--clang", type=Path, required=True)
    args = parser.parse_args()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    (output / "inputs").mkdir()
    current = freeze(args.current, output / "inputs" / "current")
    if current["git_head"] != CURRENT_HEAD or current["git_status"]:
        raise ValueError("Primary current source must be clean strict 1d4084f")
    candidate = freeze(args.candidate, output / "inputs" / "candidate")
    if candidate["git_head"] != args.candidate_commit or candidate["git_status"]:
        raise ValueError("Candidate must match the final reviewed clean commit")
    kernels = "\n".join(recurrence_source(steps) for steps in STEPS)
    kernels += ("\ndef fibonacci(n):\n    a, b = 0, 1\n    for i in range(n):\n"
                "        a, b = b, a + b\n    return a\n")
    kernels += ("\ndef loop_recurrence16(x, y, z, n):\n    t = x\n    for i in range(n):\n"
                + "        t = t * y + z\n" * 16 + "    return t\n")
    (output / "inputs" / "kernels.py").write_text(kernels, encoding="utf8", newline="\n")
    (output / "inputs" / "kernels.c").write_text(c_source(), encoding="utf8", newline="\n")
    rng = random.Random(0x574156453130)
    values = list(itertools.product((-BOUND, 0, BOUND), (-1, 0, 1), (-BOUND, 0, BOUND)))
    values += [(rng.randint(-BOUND, BOUND), rng.choice((-1, 0, 1)), rng.randint(-BOUND, BOUND))
               for _ in range(257)]
    functions = {f"recurrence_{steps}": {"steps": steps, "parameters": ["x", "y", "z"],
                 "contract": {"x": [-BOUND, BOUND], "y": [-1, 1], "z": [-BOUND, BOUND]},
                 "inputs": [list(row) for row in values], "c_arguments": 4,
                 "complete_repeats": 8, "native_repeats": 2048}
                 for steps in STEPS}
    functions["fibonacci"] = {"parameters": ["n"], "contract": {"n": [0, 80]},
                              "inputs": [[n] for n in range(81)], "c_arguments": 4,
                              "complete_repeats": 8, "native_repeats": 2048,
                              "availability": "requires bounded-loop proof in candidate"}
    long_values = [list(row) + [n] for row in values[:27] for n in (0, 1, 16, 256, 1024)]
    long_values += [list(row) + [rng.randint(0, 1024)] for row in values[27:]]
    functions["loop_recurrence16"] = {"parameters": ["x", "y", "z", "n"],
                                     "contract": {"x": [-BOUND, BOUND], "y": [-1, 1],
                                                  "z": [-BOUND, BOUND], "n": [0, 1024]},
                                     "inputs": long_values, "c_arguments": 4,
                                     "complete_repeats": 1, "native_repeats": 8}
    write_new(output / "inputs" / "corpus.json", functions)
    reference = read(args.native_reference)
    for key, path in (("corpus_sha256", output / "inputs" / "corpus.json"),
                      ("kernel_source_sha256", output / "inputs" / "kernels.py"),
                      ("c_source_sha256", output / "inputs" / "kernels.c")):
        assert sha(path) == reference[key], "Fixed kernel/corpus/reference C input changed"
    versions = {}
    for name in ("numba", "numpy", "llvmlite"):
        dist = importlib.metadata.distribution(name)
        versions[name] = {"version": dist.version,
                          "metadata_sha256": hashlib.sha256((dist.read_text("METADATA") or "").encode()).hexdigest(),
                          "record_sha256": hashlib.sha256((dist.read_text("RECORD") or "").encode()).hexdigest()}
    clang_version = subprocess.check_output([str(args.clang), "--version"], text=True)
    objdump = args.clang.parent / "llvm-objdump.exe"
    objdump_version = subprocess.check_output([str(objdump), "--version"], text=True)
    runtime = {"executable": str(Path(sys.executable).resolve()), "executable_sha256": sha(sys.executable),
               "version": sys.version, "cache_tag": sys.implementation.cache_tag,
               "dlls": {p.name: sha(p) for p in sorted(Path(sys.executable).parent.glob("python*.dll"))},
               "packages": versions, "platform": platform.platform(), "machine": platform.machine()}
    helper_files = {p.name: sha(p) for p in sorted(HERE.iterdir())
                    if p.is_file() and p.suffix in {".py", ".md", ".c"}}
    for name in helper_files:
        destination = output / "helpers" / name
        destination.parent.mkdir(exist_ok=True)
        shutil.copyfile(HERE / name, destination)
    coverage_files = inventory(HERE / "coverage_helpers")
    if coverage_files:
        shutil.copytree(HERE / "coverage_helpers", output / "helpers" / "coverage_helpers",
                        ignore=shutil.ignore_patterns("__pycache__"))
    manifest = {"schema": SCHEMA, "current": current, "candidate": candidate, "runtime": runtime,
                "timing_scope": "complete-call-only",
                "expected_cells": 355, "expected_raw_processes": 361,
                "retained_native_evidence": {"manifest": str(args.native_reference.resolve()),
                    "manifest_sha256": sha(args.native_reference),
                    "candidate_head": reference["candidate"]["git_head"],
                    "timings_pooled_or_relabelled": False,
                    "require_final_selected_native_code_equivalence": True},
                "clang": {"path": str(args.clang.resolve()), "sha256": sha(args.clang), "version": clang_version},
                "llvm_objdump": {"path": str(objdump.resolve()), "sha256": sha(objdump), "version": objdump_version},
                "c_flags": ["-O3", "-march=x86-64", "-ffp-contract=off", "-fms-runtime-lib=dll"],
                "corpus_sha256": sha(output / "inputs" / "corpus.json"),
                "kernel_source_sha256": sha(output / "inputs" / "kernels.py"),
                "c_source_sha256": sha(output / "inputs" / "kernels.c"),
                "helper_files": helper_files, "frozen_helper_path": str(output / "helpers"),
                "coverage_helper_files": coverage_files,
                "rounds": 7, "samples_per_child": 3, "complete_repeats": 8,
                "native_repeats": 2048,
                "variants": ["cpython", "current-strict", "candidate-strict", "checked", "unchecked-int64", "c-exact", "c-wrap"],
                "prepared_without_product_import": not any(name.split(".")[0] in {"numba", "numpy", "llvmlite", "recompyler"}
                                                          for name in sys.modules)}
    write_new(output / "manifest.json", manifest)
    print(json.dumps({"manifest": str(output / "manifest.json"), "sha256": sha(output / "manifest.json"),
                      "product_imported": not manifest["prepared_without_product_import"]}))


if __name__ == "__main__":
    main()
