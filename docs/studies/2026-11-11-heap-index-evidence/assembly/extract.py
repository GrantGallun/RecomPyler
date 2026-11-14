"""Read existing map payloads/PE disassembly; never import or execute an artifact."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent
STUDY = ROOT.parent / "wave5-study" / "results"
RANGES = {
    "baseline": {
        "entry": (0x180001090, 0x180001D20),
        "wrapper": (0x180001D20, 0x180002540),
        "force": (0x180004040, 0x180005180),
        "insert": (0x180005180, 0x180007D80),
        "force-fields": (0x180004160, 0x180004229),
        "force-mass": (0x1800040C7, 0x1800040DB),
    },
    "candidate": {
        "entry": (0x180001090, 0x1800019E0),
        "wrapper": (0x1800019E0, 0x180002200),
        "force": (0x180003C20, 0x180004A80),
        "insert": (0x180004A80, 0x180006A50),
        "force-fields": (0x180003D2A, 0x180003D7B),
        "force-mass": (0x180003C9F, 0x180003CA6),
        "remaining-list": (0x180003CDF, 0x180003D1A),
    },
    "c": {
        "force": (0x140002710, 0x1400028F0),
        "force-fields": (0x140002750, 0x140002790),
    },
}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


manifest = json.loads((STUDY / "manifest.json").read_text())
provenance = {"sources": {k: {
    "git_head": v["git_head"], "heap_sha256": v["src_sha256"]["recompyler/heap.py"]
} for k, v in manifest["sources"].items()}, "artifacts": {}, "static_ranges": {}}
for variant, ranges in RANGES.items():
    asm = ROOT / ("c-barnes_hut.asm" if variant == "c" else f"{variant}-aot.asm")
    if variant != "c":
        mapping_path = STUDY / "diagnostics" / f"{variant}-aot-map.payload.json"
        mapping = json.loads(mapping_path.read_text())[0]
        assert mapping["selected_export"] == "r0"
        assert int(mapping["wrapper_preferred_address"], 16) == ranges["wrapper"][0]
        assert digest(Path(mapping["artifact"])) == mapping["artifact_sha256"]
        for key in ("plan", "audit"):
            assert digest(Path(mapping[key])) == mapping[key + "_sha256"]
        mapping["mapping_path"] = str(mapping_path)
        mapping["mapping_sha256"] = digest(mapping_path)
        provenance["artifacts"][variant] = mapping
    else:
        artifact = STUDY / "bin" / "barnes_hut.exe"
        provenance["artifacts"][variant] = {"artifact": str(artifact), "sha256": digest(artifact)}
        old = ROOT.parent / "wave4-instructions" / "c" / "evidence.json"
        expected = json.loads(old.read_text())["barnes_hut"]["manifests"]["native-study"]["binary"]["sha256"]
        assert digest(artifact) == expected
        provenance["artifacts"][variant]["same_as_wave4_c"] = True
    parsed = []
    for line in asm.read_text(encoding="utf-8-sig").splitlines():
        match = re.match(r"\s*([0-9a-f]+):\s+(\w+)\s*(.*)", line)
        if match:
            parsed.append((int(match[1], 16), match[2], match[3], line))
    for name, (start, end) in ranges.items():
        rows = [row for row in parsed if start <= row[0] < end]
        (ROOT / f"{variant}-{name}.asm").write_text(
            f"# Existing measured PE, {variant} {name}: [{start:#x}, {end:#x})\n"
            "# Source/call-site inferred range; nearest-export labels are not helper symbols.\n"
            + "\n".join(row[3] for row in rows) + "\n")
        counts = Counter(row[1] for row in rows)
        provenance["static_ranges"][f"{variant}-{name}"] = {
            "start": hex(start), "end_exclusive": hex(end), "address_span_bytes": end-start,
            "instruction_lines": len(rows), "cmovlq": counts["cmovlq"],
            "sarq_63": sum(row[1] == "sarq" and row[2].startswith("$0x3f,") for row in rows),
            "negative_immediate_cmpq": sum(row[1] == "cmpq" and row[2].startswith("$-") for row in rows),
            "direct_calls": [{"at": hex(row[0]), "target": re.search(r"0x[0-9a-f]+", row[2])[0]}
                             for row in rows if row[1] == "callq" and re.match(r"0x", row[2])],
        }
provenance["limitations"] = [
    "No artifact imported, compiled, executed, or timed by this extraction.",
    "Full native helper ranges include alignment padding before the next mapped helper.",
    "Static pattern counts are not executed counts, cycles, or a performance attribution.",
    "Selected artifacts and wrappers are bound to independent successful-call audit metadata.",
    "No generated source reconstructed here; no claim of a new source digest reconstruction check.",
]
(ROOT / "provenance.json").write_text(json.dumps(provenance, indent=2) + "\n")
for variant in ("baseline", "candidate", "c"):
    print(variant, provenance["static_ranges"][f"{variant}-force"])
