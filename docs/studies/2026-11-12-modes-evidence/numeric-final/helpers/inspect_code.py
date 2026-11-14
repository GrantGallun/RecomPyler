"""Read captured selected code only; imports no product or numeric runtime.

Metrics are explicit static text counts, never automatic proofs of which checks
were discharged. A human review maps source sites and guard paths separately.
"""
import argparse
import ast
import hashlib
from collections import Counter
import json
from pathlib import Path
import re

from common import SCHEMA, read, sha, write_new


def llvm_definitions(text):
    result = {}
    for match in re.finditer(r'^define\b[^\n]*@(?:"([^"]+)"|([^\s(]+))\(', text, re.MULTILINE):
        end = text.find("\n}", match.start())
        if end < 0:
            raise ValueError("Unterminated LLVM definition")
        result[match.group(1) or match.group(2)] = text[match.start():end + 2]
    return result


def metrics(body):
    lines = body.splitlines()
    arithmetic = [line for line in lines if re.search(r'\b(add|sub|mul)\b(?: nsw| nuw)* i64\b', line)]
    return {"llvm_lines": len(lines),
            "integer_arithmetic_lines": len(arithmetic),
            "flagged_integer_arithmetic_lines": [line.strip() for line in arithmetic
                                                   if re.search(r'\b(nsw|nuw)\b', line)],
            "signed_overflow_intrinsic_call_lines": sum("call" in line and bool(re.search(r'@llvm\.s(?:add|sub|mul)\.with\.overflow', line)) for line in lines),
            "sitofp_lines": sum("sitofp " in line for line in lines),
            "fmul_lines": sum(" fmul " in line for line in lines),
            "fcmp_lines": sum(" fcmp " in line for line in lines),
            "xor_i64_lines": sum(bool(re.search(r'\bxor i64\b', line)) for line in lines),
            "conditional_branch_lines": sum(bool(re.search(r'\bbr i1\b', line)) for line in lines),
            "store_i8_one_lines": sum(bool(re.search(r'\bstore i8 1,', line)) for line in lines),
            "call_lines": [line.strip() for line in lines if re.search(r'\bcall\b', line)],
            "interpretation": "Text counts in the bound selected native LLVM definition; branches/stores are not automatically classified as numeric checks."}


def source_calls(path, name):
    module = ast.parse(path.read_text(encoding="utf8"))
    matches = [node for node in ast.walk(module) if isinstance(node, ast.FunctionDef) and node.name == name]
    assert len(matches) == 1, (path, name)
    names = Counter(node.func.id for node in ast.walk(matches[0]) if isinstance(node, ast.Call) and isinstance(node.func, ast.Name))
    return dict(sorted(names.items()))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    rows = []
    for result_path in sorted((args.root / "cells").glob("prepare-*/result.json")):
        result = read(result_path)
        program = result["program"]
        for index, overload in enumerate(program.get("overloads", [])):
            llvm_path = result_path.parent / f"selected-{index}.ll"
            text = llvm_path.read_text(encoding="utf8")
            definitions = llvm_definitions(text)
            symbol = overload["native_symbol"]
            assert symbol in definitions, symbol
            # The runtime API string is LF text; Windows text-mode capture is
            # CRLF. Validate the API's canonical text hash and separately retain
            # the actual captured byte hash. Neither file nor runtime is changed.
            canonical_hash = hashlib.sha256(text.encode()).hexdigest()
            assert canonical_hash == overload["llvm_sha256"]
            body = definitions[symbol]
            body_path = result_path.parent / f"selected-{index}-native.ll.txt"
            with body_path.open("x", encoding="utf8") as stream:
                stream.write(body + "\n")
            source_path = result_path.parent / "program-source.py.txt"
            rows.append({"variant": result["variant"], "function": result["function"],
                         "selected_digest": program["program_digest"], "selected_symbol": symbol,
                         "selected_signature": overload["signature"],
                         "result_sha256": sha(result_path), "llvm_sha256": sha(llvm_path),
                         "canonical_runtime_llvm_text_sha256": canonical_hash,
                         "capture_representation": "Raw captured byte hash and canonical runtime LF text hash are recorded separately",
                         "native_body_file": str(body_path), "native_body_sha256": sha(body_path),
                         "generated_entry_calls": source_calls(source_path, program["entry_name"]),
                         "native_llvm_metrics": metrics(body)})
    write_new(args.output, {"schema": SCHEMA, "manifest_sha256": sha(args.root / "manifest.json"),
                           "rows": rows, "artifact_executed": False,
                           "manual_check_mapping_required": True})
    print(json.dumps({"rows": len(rows), "output": str(args.output), "sha256": sha(args.output)}))


if __name__ == "__main__":
    main()
