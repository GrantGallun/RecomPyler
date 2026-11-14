"""Compare existing ordinary-lifter PE sections, without loading either module."""
import hashlib
import json
from pathlib import Path
import struct

ROOT = Path(__file__).resolve().parent
STUDY = ROOT.parent / "wave5-study" / "results"
result = {}
sections_by_variant = {}
for variant in ("baseline", "candidate"):
    path = STUDY / "programs" / "nbody" / f"{variant}.plan.json"
    plan = json.loads(path.read_text())["plan"]["aot"]
    matches = list(Path(plan["folder"]).glob(plan["module"] + "*.pyd"))
    assert len(matches) == 1
    artifact = matches[0]
    data = artifact.read_bytes()
    pe = struct.unpack_from("<I", data, 0x3c)[0]
    count = struct.unpack_from("<H", data, pe+6)[0]
    optional_size = struct.unpack_from("<H", data, pe+20)[0]
    base = struct.unpack_from("<Q", data, pe+24+24)[0]
    table = pe+24+optional_size
    sections = {}
    raw_sections = {}
    for i in range(count):
        row = table+i*40
        name = data[row:row+8].rstrip(b"\0").decode()
        virtual_size, rva, size, offset = struct.unpack_from("<IIII", data, row+8)
        block = data[offset:offset+size]
        raw_sections[name] = block
        sections[name] = dict(rva=hex(rva), virtual_size=virtual_size, raw_size=size,
                              sha256=hashlib.sha256(block).hexdigest())
    sections_by_variant[variant] = raw_sections
    audit_path = STUDY / "programs" / "nbody" / f"{variant}-forced.audit.json"
    audit = json.loads(audit_path.read_text())
    result[variant] = dict(artifact=str(artifact), artifact_sha256=hashlib.sha256(data).hexdigest(),
                           image_base=hex(base), sections=sections, audit=str(audit_path),
                           audit_totals=audit["totals"], plan=str(path))
result["sections_byte_identical"] = {
    name: block == sections_by_variant["candidate"][name]
    for name, block in sections_by_variant["baseline"].items()
}
result["limitations"] = ["No artifact import/execution/build/timing; compares raw PE sections only.",
                         "Same .text bytes do not establish identical whole-process performance."]
(ROOT / "nbody-sections.json").write_text(json.dumps(result, indent=2)+"\n")
print(json.dumps(result["sections_byte_identical"]))
