"""Read-only PE32+ method/RVA mapper. No native binary is loaded here.

Method-discovery approach follows frozen wave9-heap-analysis/static_method.py;
this new copy adds RVA/unwind ranges and is independent of old result paths.
"""
import hashlib
from pathlib import Path
import struct


def inspect_method(path, export):
    path = Path(path)
    raw = path.read_bytes()
    pe = struct.unpack_from("<I", raw, 0x3c)[0]
    assert raw[pe:pe + 4] == b"PE\0\0"
    sections_count = struct.unpack_from("<H", raw, pe + 6)[0]
    opt_size = struct.unpack_from("<H", raw, pe + 20)[0]
    opt = pe + 24
    assert struct.unpack_from("<H", raw, opt)[0] == 0x20b
    base = struct.unpack_from("<Q", raw, opt + 24)[0]
    sections = []
    for index in range(sections_count):
        at = opt + opt_size + index * 40
        size, rva, raw_size, offset = struct.unpack_from("<IIII", raw, at + 8)
        flags = struct.unpack_from("<I", raw, at + 36)[0]
        sections.append({"name": raw[at:at + 8].split(b"\0")[0].decode("ascii"),
                         "size": size, "rva": rva, "raw_size": raw_size, "offset": offset,
                         "executable": bool(flags & 0x20000000)})

    def rva_at(offset):
        for section in sections:
            if section["offset"] <= offset < section["offset"] + section["raw_size"]:
                return section["rva"] + offset - section["offset"]
        raise ValueError("Unmapped PE offset")

    def offset_at(rva):
        for section in sections:
            if section["rva"] <= rva < section["rva"] + section["raw_size"]:
                return section["offset"] + rva - section["rva"]
        raise ValueError("Unmapped PE RVA")

    found = []
    name_start = 0
    while True:
        name_at = raw.find(export.encode("ascii") + b"\0", name_start)
        if name_at < 0:
            break
        name_start = name_at + 1
        name_va = base + rva_at(name_at)
        pointer_start = 0
        while True:
            pointer_at = raw.find(struct.pack("<Q", name_va), pointer_start)
            if pointer_at < 0:
                break
            pointer_start = pointer_at + 1
            if pointer_at + 32 > len(raw):
                continue
            fn, flags, doc = struct.unpack_from("<QI4xQ", raw, pointer_at + 8)
            if flags not in (1, 2, 3, 4, 8, 0x80, 0x82):
                continue
            if any(section["executable"] and base + section["rva"] <= fn < base + section["rva"] + section["size"]
                   for section in sections):
                found.append({"method_rva": fn - base, "function_address": fn,
                              "method_definition_rva": rva_at(pointer_at), "flags": flags})
    assert len(found) == 1, (export, found)
    exception_rva, exception_size = struct.unpack_from("<II", raw, opt + 112 + 3 * 8)
    unwind = []
    if exception_rva:
        offset = offset_at(exception_rva)
        for at in range(offset, offset + exception_size, 12):
            begin, end, data = struct.unpack_from("<III", raw, at)
            unwind.append({"begin_rva": begin, "end_rva": end, "unwind_rva": data})
    return {"binary": str(path.resolve()), "binary_sha256": hashlib.sha256(raw).hexdigest(),
            "export": export, "preferred_base": base, **found[0], "sections": sections,
            "unwind_ranges": unwind,
            "note": "Static candidate becomes selected only when actual successful-call digest/export and runtime RVA agree."}
