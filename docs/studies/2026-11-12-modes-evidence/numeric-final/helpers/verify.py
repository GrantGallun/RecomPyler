"""Independent post-run evidence/count/sample verifier; no product imports."""
import argparse
import hashlib
import json
from pathlib import Path
import statistics

from common import HERE, SCHEMA, digest, inventory, read, sha, write_new

MASK = 2**64 - 1


def fibonacci_pair(n, mask=None):
    if n <= 0:
        return 0, 1
    a, b = fibonacci_pair(n // 2, mask)
    c, d = a * (2 * b - a), a * a + b * b
    if mask is not None:
        c, d = c & mask, d & mask
    return (d, (c + d) & mask if mask is not None else c + d) if n % 2 else (c, d)


def power_sum(y, n):
    """Independent modular geometric sum; no timed kernel is transformed."""
    if n <= 0:
        return 1, 0
    p, s = power_sum(y, n // 2)
    pp, ss = (p * p) & MASK, (s * (1 + p)) & MASK
    return ((pp * y) & MASK, (ss + pp) & MASK) if n % 2 else (pp, ss)


def reference(function, args, modular=False):
    if function == "fibonacci":
        value = fibonacci_pair(max(0, args[0]), MASK if modular else None)[0]
    else:
        x, y, z = args[:3]
        n = max(0, args[3]) * 16 if function == "loop_recurrence16" else int(function.rsplit("_", 1)[1])
        if modular:
            p, s = power_sum(y, n)
            value = (x * p + z * s) & MASK
        elif n == 0:
            value = x
        elif y == 0:
            value = z
        elif y == 1:
            value = x + n * z
        elif y == -1:
            value = -x + z if n % 2 else x
        else:
            raise ValueError("Valid fixed corpus has y in {-1,0,1}")
    return ((value + 2**63) & MASK) - 2**63 if modular else value


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    root = args.root.resolve()
    manifest = read(root / "manifest.json")
    manifest_hash = sha(root / "manifest.json")
    corpus = read(root / "inputs" / "corpus.json")
    assert manifest["schema"] == SCHEMA and manifest["prepared_without_product_import"] is True
    for name, expected in manifest["helper_files"].items():
        assert sha(HERE / name) == expected, name
    for version in ("current", "candidate"):
        assert inventory(root / "inputs" / version) == manifest[version]["files"]
    process_count = 0
    for path in sorted((root / "processes").glob("*.json")):
        process = read(path)
        assert process["exit_code"] == 0 and process["timed_out"] is False, path
        assert sha(path.with_suffix(".stdout")) == process["stdout_sha256"]
        assert sha(path.with_suffix(".stderr")) == process["stderr_sha256"]
        assert process["wall_s"] >= 0
        process_count += 1
    totals = {"aot_complete_timing_calls": 0, "jit_complete_timing_calls": 0,
              "complete_fallback_calls": 0, "foreign_complete_timing_calls": 0,
              "native_batch_invocations": 0, "native_batch_status_failures": 0,
              "invalid_audit_cases": 0, "aot_replay_children": 0}
    expected_cells = set()
    for function, config in corpus.items():
        for variant in manifest["variants"]:
            for task in ("prepare", "audit"):
                expected_cells.add(f"{task}-{function}-{variant}")
            for round_number in range(manifest["rounds"]):
                task = "time-aot" if variant in {"current-strict", "candidate-strict", "checked", "unchecked-int64"} else "time"
                expected_cells.add(f"{task}-r{round_number}-{function}-{variant}")
        for variant in ("current-strict", "candidate-strict", "checked", "unchecked-int64"):
            expected_cells.add(f"build-aot-{function}-{variant}")
            expected_cells.add(f"audit-aot-{function}-{variant}")
    actual_cells = {p.parent.name for p in (root / "cells").glob("*/result.json")}
    assert actual_cells == expected_cells, {"missing": sorted(expected_cells - actual_cells), "extra": sorted(actual_cells - expected_cells)}
    for label in sorted(expected_cells):
        path = root / "cells" / label / "result.json"
        row = read(path)
        assert row["manifest_sha256"] == manifest_hash and row["valid_exact_results"] is True
        config = corpus[row["function"]]
        count = len(config["inputs"])
        expected_values = [reference(row["function"], values) for values in config["inputs"]]
        assert row["expected_results_sha256"] == digest(expected_values)
        assert row["corpus_count"] == count and row["contract"] == config["contract"]
        stdout = read_stdout_json(root / "processes" / (label + ".stdout"))
        assert stdout["sha256"] == sha(path)
        if row["variant"] not in {"cpython", "c-exact", "c-wrap"}:
            assert row["first_call_counts"]["aot_calls"] + row["first_call_counts"]["jit_calls"] == 1
            assert row["validation_counts"]["aot_calls"] + row["validation_counts"]["jit_calls"] == count
            assert row["validation_counts"]["fallback_calls"] == 0
            assert row["program"]["native_loader"]["available"] and row["program"]["native_loader"]["enabled"]
        for audit in row.get("invalid_audits", []):
            assert audit["matched"] is True
            native = list(audit["observed_native_entries"].values())
            assert all(item["entered"] == item["returned"] == item["successful_status"] + item["failed_status"] for item in native)
            if row["variant"] not in {"cpython", "c-exact", "c-wrap"}:
                assert audit["observed_attempt_delta"]["attempts"] == 1
                assert sum(item["successful_status"] for item in native) == audit["counter_delta"]["aot_calls"] + audit["counter_delta"]["jit_calls"]
            if audit["policy"] == "defined-modulo-int64":
                arguments = [int(value) for value in audit["bound_values"]]
                expected = reference(row["function"], arguments, modular=True)
                assert audit["actual"] == {"kind": "value", "type": "builtins.int", "value": repr(expected)}
            elif audit["policy"] == "Python-compatible":
                assert audit["actual"] == audit["python"]
            elif audit["policy"] == "rejection-before-native":
                assert audit["actual"]["kind"] == "error"
                assert audit["actual"]["type"].endswith(".NumericContractError")
                assert all(audit["counter_delta"][key] == 0 for key in ("compiled_calls", "aot_calls", "jit_calls", "foreign_calls"))
                assert sum(item["entered"] for item in native) == 0
            elif audit["policy"] == "C-reference-binding-TypeError":
                assert row["variant"] == "c-wrap" and audit["bound_values"] is None
                assert audit["actual"] == audit["python"] and audit["actual"]["type"] == "builtins.TypeError"
                assert sum(item["entered"] for item in native) == 0 and audit["counter_delta"]["foreign_calls"] == 0
            totals["invalid_audit_cases"] += 1
        if row["task"] in {"time", "time-aot"}:
            assert len(row["samples"]) == manifest["samples_per_child"]
            assert row["median_ns"] == statistics.median(sample["elapsed_ns"] for sample in row["samples"])
            assert all(sample["calls"] == count * config["complete_repeats"] and sample["elapsed_ns"] > 0 for sample in row["samples"])
            assert all(sample["checksum_uint64"] == (sum(expected_values) * config["complete_repeats"]) & MASK for sample in row["samples"])
            calls = count * config["complete_repeats"] * manifest["samples_per_child"]
            timing = row["timing_counts"]
            if row["variant"] not in {"cpython", "c-exact", "c-wrap"}:
                assert timing["aot_calls"] == calls and timing["jit_calls"] == 0 and timing["fallback_calls"] == 0
            if row["variant"].startswith("c-"):
                assert timing["foreign_calls"] == calls
            totals["aot_complete_timing_calls"] += timing["aot_calls"]
            totals["jit_complete_timing_calls"] += timing["jit_calls"]
            totals["complete_fallback_calls"] += timing["fallback_calls"]
            totals["foreign_complete_timing_calls"] += timing["foreign_calls"]
        if row["task"] in {"time-aot", "audit-aot"}:
            assert row["numba_imported"] is False
            selected = row["aot_selection"]
            assert selected["program_digest"] == row["program"]["program_digest"]
            assert sha(selected["binary"]) == selected["binary_sha256"]
            assert selected["runtime_wrapper_rva"] == selected["static_mapping"]["method_rva"]
            totals["aot_replay_children"] += 1
        if row["task"] == "build-aot":
            built = row["aot_build"]
            assert sha(built["frozen_pycc_mixin"]["path"]) == built["frozen_pycc_mixin"]["sha256"]
            assert built["frozen_pycc_mixin"]["path"] in built["pycc_native_sources"]
            assert all(sha(path) == expected for path, expected in built["pycc_native_sources"].items())
        if row["task"] == "native":
            batch = row["native_batch"]
            if row["variant"] == "cpython":
                assert batch["available"] is False
                continue
            assert batch["available"] is True
            assert all(value == 0 for value in batch["region_counter_delta"].values())
            assert len(batch["samples"]) == 3
            assert batch["median_ns"] == statistics.median(sample["elapsed_ns"] for sample in batch["samples"])
            for sample in batch["samples"]:
                assert sample["native_invocations"] == count * config["native_repeats"]
                assert sample["status_failures"] == 0 and sample["elapsed_ns"] > 0
                assert sample["checksum_uint64"] == (sum(expected_values) * config["native_repeats"]) & MASK
                totals["native_batch_invocations"] += sample["native_invocations"]
                totals["native_batch_status_failures"] += sample["status_failures"]
            if row["variant"] not in {"c-exact", "c-wrap"}:
                assert sum(row["program"]["dispatcher_cache_hits"].values()) == 0
                assert sum(row["program"]["dispatcher_cache_misses"].values()) >= 1
                assert batch["selected_target_digest"] == row["program"]["program_digest"]
                for kind in ("source", "llvm", "asm"):
                    name = "adapter-source.py.txt" if kind == "source" else "adapter." + ("ll" if kind == "llvm" else "asm")
                    assert sha(path.parent / name) == batch["adapter_" + kind + "_sha256"]
    write_new(args.output, {"schema": SCHEMA, "manifest_sha256": manifest_hash,
                           "verified_processes": process_count, "verified_cells": len(actual_cells),
                           "totals": totals, "product_imported": False, "all_assertions_passed": True})
    print(json.dumps({"output": str(args.output), "sha256": sha(args.output), "totals": totals}))


def read_stdout_json(path):
    lines = path.read_text(encoding="utf8").splitlines()
    assert lines
    return json.loads(lines[-1])


if __name__ == "__main__":
    main()
