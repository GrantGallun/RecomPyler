"""Read PE unwind ranges and correlate direct call targets; no execution."""
import json
from pathlib import Path
import re
import struct

ROOT = Path(__file__).resolve().parent

for case in ('current-direct', 'forceonly-direct', 'fullfloat-direct', 'production'):
    meta = json.loads((ROOT/(case+'-provenance.json')).read_text())
    base = int(meta['preferred_image_base'], 16)
    raw = Path(meta['artifact']).read_bytes()
    sec = next(s for s in meta['sections'] if s['name'] == '.pdata')
    functions = []
    for off in range(sec['offset'], sec['offset']+sec['size'], 12):
        begin, end, unwind = struct.unpack_from('<III', raw, off)
        functions.append((base+begin, base+end, base+unwind))
    lines = []
    for line in (ROOT/(case+'.asm')).read_text().splitlines():
        match = re.match(r'\s*([0-9a-f]+):\s+(\w+)\s*(.*)', line)
        if match:
            lines.append((int(match[1],16), match[2], match[3], line))
    rows = []
    for begin, end, unwind in functions:
        body = [l for l in lines if begin <= l[0] < end]
        calls = [(l[0], int(m[1],16)) for l in body if l[1] == 'callq'
                 and (m := re.match(r'0x([0-9a-f]+)',l[2]))]
        rows.append(dict(begin=hex(begin), end=hex(end), unwind=hex(unwind),
                         bytes=end-begin, instructions=len(body),
                         calls=[dict(at=hex(at), target=hex(target)) for at,target in calls],
                         self_calls=sum(target==begin for _,target in calls)))
    (ROOT/(case+'-ranges.json')).write_text(json.dumps(rows,indent=2)+'\n')
    wrapper = int(meta['method']['function_address'],16)
    print(case, 'wrapper', next(r for r in rows if int(r['begin'],16)==wrapper))
    print(case, 'recursive', [r for r in rows if r['self_calls']])
