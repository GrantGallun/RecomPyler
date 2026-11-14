"""Read-only actual AOT/C CFG and instruction comparison; no artifact imports.

The AOT entry is selected through its successful audit's mapped Python wrapper
and direct machine call. Reachable control flow is closed below that wrapper.
Addresses/padding are normalized; RIP constants are compared as actual bytes.
"""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
import struct

from common import digest, read, sha, write_new

PADDING = {"nop", "nopl", "nopw", "int3"}
RETURNS = {"ret", "retq"}


def parse_assembly(path):
    rows = []
    for line in Path(path).read_text(encoding="utf8").splitlines():
        match = re.match(r"\s*([0-9a-fA-F]+):\s+(\S+)(?:\s+(.*))?$", line)
        if match:
            rows.append({"address": int(match.group(1), 16), "op": match.group(2),
                         "operands": match.group(3) or ""})
    return rows


class Image:
    def __init__(self, path):
        self.path = Path(path)
        self.raw = self.path.read_bytes()
        pe = struct.unpack_from("<I", self.raw, 0x3c)[0]
        assert self.raw[pe:pe + 4] == b"PE\0\0"
        count = struct.unpack_from("<H", self.raw, pe + 6)[0]
        size = struct.unpack_from("<H", self.raw, pe + 20)[0]
        opt = pe + 24
        assert struct.unpack_from("<H", self.raw, opt)[0] == 0x20b
        self.base = struct.unpack_from("<Q", self.raw, opt + 24)[0]
        self.sections = []
        for index in range(count):
            at = opt + size + 40 * index
            _, rva, raw_size, offset = struct.unpack_from("<IIII", self.raw, at + 8)
            self.sections.append((rva, raw_size, offset))

    def bytes_at(self, address, size):
        rva = address - self.base
        for start, length, offset in self.sections:
            if start <= rva and rva + size <= start + length:
                return self.raw[offset + rva - start:offset + rva - start + size]
        raise ValueError(f"Unmapped constant {address:#x} in {self.path}")


def direct_target(operands):
    match = re.match(r"\s*0x([0-9a-fA-F]+)", operands)
    if match is None:
        raise ValueError("Expected a direct branch: " + operands)
    return int(match.group(1), 16)


def body(rows, begin, limit, image):
    by_address = {row["address"]: row for row in rows}
    following = {row["address"]: rows[index + 1]["address"]
                 for index, row in enumerate(rows[:-1])}
    pending, visited = [begin], set()
    edges = {}
    while pending:
        address = pending.pop()
        if address in visited:
            continue
        assert begin <= address < limit, (hex(begin), hex(address), hex(limit))
        row = by_address[address]
        visited.add(address)
        op = row["op"]
        assert op != "int3", "Reachable trap/alignment byte"
        if op in RETURNS:
            successors = []
        elif op in {"jmp", "jmpq"}:
            successors = [direct_target(row["operands"])]
        elif op.startswith("j") or op.startswith("loop"):
            successors = [direct_target(row["operands"]), following[address]]
        elif op in {"call", "callq"}:
            raise ValueError("Nested call in selected arithmetic body; needs manual review")
        else:
            successors = [following[address]]
        edges[address] = successors
        pending.extend(successors)
    counted = sorted(address for address in visited if by_address[address]["op"] not in PADDING)
    indices = {address: index for index, address in enumerate(counted)}

    def nonpadding(address):
        while by_address[address]["op"] in PADDING:
            assert len(edges[address]) == 1
            address = edges[address][0]
        return address

    normalized, cfg = [], []
    for address in counted:
        row = by_address[address]
        op = row["op"]
        operands = row["operands"].split("#", 1)[0].strip()
        if op.startswith("j") or op.startswith("loop"):
            operands = "instruction:" + str(indices[nonpadding(direct_target(operands))])
        else:
            rip = re.search(r"(-?(?:0x[0-9a-fA-F]+|[0-9]+))\(%rip\)", operands)
            if rip:
                displacement = int(rip.group(1), 0)
                width = (16 if any(part in op for part in ("apd", "aps", "upd", "ups", "andpd", "andps", "orpd", "orps", "dqu", "dqa"))
                         else 4 if op.endswith("ss") else 8)
                constant = image.bytes_at(following[address] + displacement, width)
                operands = operands[:rip.start()] + "RIP_BYTES:" + constant.hex() + operands[rip.end():]
            operands = re.sub(r"\s+", " ", operands)
        normalized.append([op, operands])
        cfg.append([indices[address], [indices[nonpadding(target)] for target in edges[address]]])
    histogram = dict(sorted(Counter(by_address[address]["op"] for address in counted).items()))
    return {"begin_rva": begin - image.base, "last_instruction_rva": counted[-1] - image.base,
            "return_rvas": [address - image.base for address in counted if by_address[address]["op"] in RETURNS],
            "instruction_count_nonpadding": len(counted), "opcode_counts": histogram,
            "normalized_instructions": normalized, "normalized_cfg": cfg,
            "normalized_instruction_sha256": digest(normalized), "normalized_cfg_sha256": digest(cfg)}


def aot_bodies(root):
    index_path = root / "aot-assembly" / "index.json"
    result = {}
    for record in read(index_path)["rows"]:
        selected = record["selected"]
        mapping = selected["static_mapping"]
        wrapper = mapping["preferred_base"] + mapping["method_rva"]
        candidates = {item["target"] for item in record["wrapper_direct_call_candidates"]
                      if item["target"] is not None and mapping["preferred_base"] <= item["target"] < wrapper}
        rows = parse_assembly(record["assembly_file"])
        image = Image(selected["binary"])
        assert sha(selected["binary"]) == selected["binary_sha256"]
        # Wrappers also call small NRT helpers below their own entry. Select by
        # a closed leaf CFG and the source-backed arithmetic, not mere proximity.
        expected_multiply = (0 if record["function"] == "fibonacci" else 16
                             if record["function"] == "loop_recurrence16"
                             else int(record["function"].rsplit("_", 1)[1]))
        accepted, selection = [], []
        for entry in sorted(candidates):
            try:
                candidate = body(rows, entry, wrapper, image)
                multiply = sum(value for op, value in candidate["opcode_counts"].items() if op.startswith("imul"))
                additions = sum(value for op, value in candidate["opcode_counts"].items()
                                if op.startswith("add") or op.startswith("lea"))
                backedge = any(target <= origin for origin, targets in candidate["normalized_cfg"] for target in targets)
                assert multiply == expected_multiply
                assert additions > 0
                if record["function"] in {"fibonacci", "loop_recurrence16"}:
                    assert backedge
                accepted.append((entry, candidate))
                selection.append({"rva": entry - image.base, "selected": True})
            except (AssertionError, ValueError, KeyError) as error:
                selection.append({"rva": entry - image.base, "selected": False,
                                  "reason": type(error).__name__ + ": " + str(error)})
        assert len(accepted) == 1, (record["function"], record["variant"], selection)
        entry, actual = accepted[0]
        actual.update(program_digest=record["program_digest"], export=selected["export"],
                      binary=selected["binary"], binary_sha256=selected["binary_sha256"],
                      assembly_file=record["assembly_file"], assembly_sha256=sha(record["assembly_file"]),
                      selected_wrapper_rva=mapping["method_rva"],
                      runtime_wrapper_rva=selected["runtime_wrapper_rva"],
                      wrapper_candidate_selection=selection,
                      direct_wrapper_call_target_rva=entry - image.base)
        assert actual["selected_wrapper_rva"] == actual["runtime_wrapper_rva"]
        result[record["function"] + "/" + record["variant"]] = actual
    return result


def c_bodies(root):
    export_text = (root / "processes" / "c-exports.stdout").read_text(encoding="utf8")
    exports = {}
    for block in re.findall(r"Export\s*\{([^}]+)\}", export_text):
        name = re.search(r"Name:\s*(\S+)", block)
        rva = re.search(r"RVA:\s*0x([0-9a-fA-F]+)", block)
        if name and rva:
            exports[name.group(1)] = int(rva.group(1), 16)
    rows = parse_assembly(root / "processes" / "c-disassembly.stdout")
    image = Image(root / "build" / "kernels.dll")
    result = {}
    ordered = sorted(exports.values())
    for name, rva in sorted(exports.items()):
        if not name.endswith(("_exact", "_wrap")) or name.startswith("batch_"):
            continue
        limit = image.base + min(value for value in ordered if value > rva)
        actual = body(rows, image.base + rva, limit, image)
        actual.update(export=name, binary=str(image.path), binary_sha256=sha(image.path))
        result[name] = actual
    assert len(result) == 10, len(result)
    return result


def compare(old, new, kind):
    assert set(old) == set(new)
    result = []
    for name in sorted(old):
        first, second = old[name], new[name]
        cfg_equal = first["normalized_cfg"] == second["normalized_cfg"]
        opcodes_equal = first["opcode_counts"] == second["opcode_counts"]
        instructions_equal = first["normalized_instructions"] == second["normalized_instructions"]
        result.append({"kind": kind, "function_variant": name, "cfg_equal": cfg_equal,
                       "opcode_counts_equal": opcodes_equal, "normalized_operands_equal": instructions_equal,
                       "equivalent": cfg_equal and opcodes_equal and instructions_equal,
                       "prototype": first, "final": second})
    return result


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--prototype", required=True, type=Path)
    parser.add_argument("--final", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    rows = compare(aot_bodies(args.prototype), aot_bodies(args.final), "actual-selected-AOT")
    rows += compare(c_bodies(args.prototype), c_bodies(args.final), "actual-C-export")
    result = {"prototype_manifest_sha256": sha(args.prototype / "manifest.json"),
              "final_manifest_sha256": sha(args.final / "manifest.json"), "postprocessor_sha256": sha(__file__),
              "artifact_executed": False, "timings_reused_or_relabelled": False,
              "all_equivalent": all(row["equivalent"] for row in rows), "rows": rows,
              "normalization": "Reachable CFG from actual selected wrapper call/C export; exclude padding; branches use instruction indices; RIP constants use actual bytes; other operands retained exactly. Static comparison is not cycle attribution."}
    write_new(args.output, result)
    print(json.dumps({"rows": len(rows), "all_equivalent": result["all_equivalent"],
                      "output": str(args.output), "sha256": sha(args.output)}))
    if not result["all_equivalent"]:
        raise SystemExit("Native body difference: retain evidence and request coordinator review")


if __name__ == "__main__":
    main()
