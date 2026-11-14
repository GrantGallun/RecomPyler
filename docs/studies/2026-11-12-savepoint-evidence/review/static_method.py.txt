"""Read a PE's named PyMethodDef candidate without importing/executing it."""
import argparse
import hashlib
import json
from pathlib import Path
import struct


def inspect(path, export):
    raw = path.read_bytes()
    pe = struct.unpack_from('<I', raw, 0x3c)[0]
    if raw[pe:pe+4] != b'PE\0\0':
        raise ValueError('Not a PE')
    nsec = struct.unpack_from('<H', raw, pe+6)[0]
    optlen = struct.unpack_from('<H', raw, pe+20)[0]
    opt = pe+24
    if struct.unpack_from('<H', raw, opt)[0] != 0x20b:
        raise ValueError('Only PE32+ supported')
    base = struct.unpack_from('<Q', raw, opt+24)[0]
    sections = []
    for index in range(nsec):
        at = opt+optlen+40*index
        name = raw[at:at+8].split(b'\0')[0].decode('ascii')
        size, rva, rawsize, offset = struct.unpack_from('<IIII', raw, at+8)
        characteristics = struct.unpack_from('<I', raw, at+36)[0]
        sections.append(dict(name=name, rva=rva, size=size, rawsize=rawsize,
                             offset=offset, executable=bool(characteristics & 0x20000000)))
    def address(offset):
        for section in sections:
            if section['offset'] <= offset < section['offset']+section['rawsize']:
                return base+section['rva']+offset-section['offset']
        raise ValueError('Unmapped raw offset')
    def code_address(va):
        return any(s['executable'] and base+s['rva'] <= va < base+s['rva']+s['size'] for s in sections)
    found = []
    needle = export.encode('ascii')+b'\0'
    start = 0
    while True:
        at = raw.find(needle, start)
        if at < 0:
            break
        start = at+1
        try:
            name_address = address(at)
        except ValueError:
            continue
        encoded = struct.pack('<Q', name_address)
        pointer_at = 0
        while True:
            pointer_at = raw.find(encoded, pointer_at)
            if pointer_at < 0:
                break
            if pointer_at+32 <= len(raw):
                fn, flags, doc = struct.unpack_from('<Q I 4x Q', raw, pointer_at+8)
                if code_address(fn) and flags in (1, 2, 3, 4, 8, 0x80, 0x82):
                    found.append(dict(name_file_offset=hex(at), name_address=hex(name_address),
                                      methoddef_file_offset=hex(pointer_at), methoddef_address=hex(address(pointer_at)),
                                      function_address=hex(fn), flags=hex(flags), doc_pointer=hex(doc)))
            pointer_at += 1
    if len(found) != 1:
        raise ValueError('Expected one unambiguous method definition: '+repr(found))
    return dict(artifact=str(path.resolve()), artifact_sha256=hashlib.sha256(raw).hexdigest(),
                export=export, preferred_image_base=hex(base), method=found[0], sections=sections,
                note='Static PyMethodDef candidate only; bind export to independent successful-call digest/plan audit. No artifact imported or executed.')


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('artifact', type=Path)
    p.add_argument('--export', default='r0')
    p.add_argument('--output', type=Path, required=True)
    a = p.parse_args()
    a.output.write_text(json.dumps(inspect(a.artifact, a.export), indent=2)+'\n')
