"""Disassemble audit-selected AOT binaries, read-only; never import artifacts."""
import argparse
import json
from pathlib import Path
import re
import subprocess

from common import SCHEMA, read, sha, write_new
from pe_method import inspect_method


def instructions(text):
    result = []
    for line in text.splitlines():
        match = re.match(r"\s*([0-9a-fA-F]+):\s+(\S+)(?:\s+(.*))?$", line)
        if match:
            result.append({"address": int(match.group(1), 16), "op": match.group(2),
                           "operands": match.group(3) or "", "text": line})
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    root = args.root.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    manifest = read(root / "manifest.json")
    tool = Path(manifest["clang"]["path"]).parent / "llvm-objdump.exe"
    rows = []
    for path in sorted((root / "cells").glob("audit-aot-*/result.json")):
        audit = read(path)
        assert audit["numba_imported"] is False and audit["validation_counts"]["jit_calls"] == 0
        assert audit["validation_counts"]["aot_calls"] == audit["corpus_count"]
        selected = audit["aot_selection"]
        binary = Path(selected["binary"])
        mapping = inspect_method(binary, selected["export"])
        assert mapping == selected["static_mapping"]
        assert mapping["method_rva"] == selected["runtime_wrapper_rva"]
        label = audit["function"] + "-" + audit["variant"]
        command = [str(tool), "--disassemble", "--demangle", "--no-show-raw-insn", str(binary)]
        result = subprocess.run(command, capture_output=True)
        assert result.returncode == 0, result.stderr
        (args.output / (label + ".asm")).write_bytes(result.stdout)
        (args.output / (label + ".stderr")).write_bytes(result.stderr)
        parsed = instructions(result.stdout.decode("utf8"))
        wrapper_range = [item for item in mapping["unwind_ranges"]
                         if item["begin_rva"] <= mapping["method_rva"] < item["end_rva"]]
        wrapper_lines = []
        if wrapper_range:
            assert len(wrapper_range) == 1
            bounds = wrapper_range[0]
            wrapper_lines = [line for line in parsed if mapping["preferred_base"] + bounds["begin_rva"]
                             <= line["address"] < mapping["preferred_base"] + bounds["end_rva"]]
        targets = []
        for line in wrapper_lines:
            if line["op"] in {"call", "callq"}:
                match = re.match(r"0x([0-9a-fA-F]+)", line["operands"])
                targets.append({"call_address": line["address"], "target": int(match.group(1), 16) if match else None,
                                "operands": line["operands"]})
        rows.append({"function": audit["function"], "variant": audit["variant"],
                     "program_digest": selected["program_digest"], "selected": selected,
                     "audit_path": str(path), "audit_sha256": sha(path),
                     "command": command, "tool_sha256": sha(tool),
                     "assembly_file": str(args.output / (label + ".asm")),
                     "assembly_sha256": sha(args.output / (label + ".asm")),
                     "wrapper_range": wrapper_range, "wrapper_direct_call_candidates": targets,
                     "manual_native_body_selection_required": True})
    write_new(args.output / "index.json", {"schema": SCHEMA, "manifest_sha256": sha(root / "manifest.json"),
                                           "artifact_executed": False, "rows": rows})
    print(json.dumps({"rows": len(rows), "index": str(args.output / "index.json"),
                      "sha256": sha(args.output / "index.json")}))


if __name__ == "__main__":
    main()
