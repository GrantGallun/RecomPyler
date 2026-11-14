"""Address-bounded static excerpts; no workload or artifact execution."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
import struct

ROOT = Path(__file__).resolve().parent
RANGES = {
 'current-direct': {'force': (0x180003c20,0x180004a80), 'first-return': (0x180004101,0x180004170),
                    'fields': (0x180003d2a,0x180003e44), 'call-marshalling': (0x180003f7a,0x180004106)},
 'production': {'force': (0x180003c20,0x180004870), 'first-return': (0x1800040fe,0x180004176),
                'fields': (0x180003d2a,0x180003e44), 'call-marshalling': (0x180003f7a,0x180004103)},
 'forceonly-direct': {'force': (0x180003bf0,0x1800046f0)},
 'fullfloat-direct': {'force': (0x180003b40,0x180004550), 'fields': (0x180003c37,0x180003c72),
                      'call-marshalling': (0x180003d58,0x180003ed5), 'first-return': (0x180003ed0,0x180003f2c)},
}

def parse(path):
    rows=[]
    for line in path.read_text().splitlines():
        m=re.match(r'\s*([0-9a-f]+):\s+(\w+)\s*(.*)',line)
        if m: rows.append((int(m[1],16),m[2],m[3],line))
    return rows

result={}
for case,ranges in RANGES.items():
    meta=json.loads((ROOT/(case+'-provenance.json')).read_text())
    raw=Path(meta['artifact']).read_bytes()
    assert hashlib.sha256(raw).hexdigest()==meta['artifact_sha256']
    base=int(meta['preferred_image_base'],16)
    def double(va):
        for sec in meta['sections']:
            at=va-base-sec['rva']
            if 0<=at<=sec['rawsize']-8:
                return struct.unpack_from('<d',raw,sec['offset']+at)[0]
        return None
    rows=parse(ROOT/(case+'.asm'))
    summaries={}
    for name,(start,end) in ranges.items():
        selected=[r for r in rows if start<=r[0]<end]
        (ROOT/(case+'-'+name+'.asm')).write_text(
            f'# {case} {name}: [{start:#x}, {end:#x})\n'
            '# Source/call-target inferred range; padding may be included. Static evidence, not cycles.\n'
            +'\n'.join(r[3] for r in selected)+'\n')
        counts=Counter(r[1] for r in selected)
        thresholds=[]
        for r in selected:
            m=re.search(r'# (0x[0-9a-f]+)',r[2])
            if m and double(int(m[1],16)) in (float(2**53),-float(2**53)):
                thresholds.append(dict(at=hex(r[0]), instruction=r[1], constant_address=m[1], value=double(int(m[1],16))))
        summaries[name]=dict(begin=hex(start),end=hex(end),span_bytes=end-start,
                            instruction_lines=len(selected),stack_operand_lines=sum('%rsp' in r[2] for r in selected),
                            recursive_calls=[hex(r[0]) for r in selected if r[1]=='callq' and r[2].startswith(hex(start)+' ')],
                            frame_reservations=[r[3].strip() for r in selected if r[1]=='subq' and r[2].endswith('%rsp') or r[1]=='subq' and ', %rsp ' in r[2]],
                            exact_threshold_rip_references=thresholds,
                            mnemonic_counts=dict(counts))
    result[case]=summaries
    print(case, {k:v for k,v in summaries['force'].items() if k!='mnemonic_counts'})
(ROOT/'static-counts.json').write_text(json.dumps(result,indent=2)+'\n')
