"""Verify retained evidence bytes/checkpoints without loading native artifacts."""
import hashlib
import json
from pathlib import Path
import struct

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
def read(path):
    return json.loads(path.read_text())
def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

proof = ROOT/'wave6-proof-study/results'
manual = ROOT/'wave6-study/results-v2'
result = {'artifact_checks': {}, 'checkpoint_checks': {}}
frozen = read(proof/'aot-artifacts-frozen.json')
manual_frozen = read(manual/'aot-artifacts-frozen.json')
for name in ('current-direct', 'production', 'forceonly-direct', 'fullfloat-direct'):
    p = read(HERE/(name+'-provenance.json'))
    actual = sha(Path(p['artifact']))
    assert actual == p['artifact_sha256']
    assert actual == {**manual_frozen, **frozen}[p['artifact']]
    assert sha(Path(p['audit'])) == p['audit_sha256']
    assert sha(Path(p['plan'])) == p['plan_sha256']
    assert sha(HERE/(name+'.asm')) == p['assembly_sha256']
    result['artifact_checks'][name] = actual
for name, label in (('baseline', 'current-direct'), ('candidate', 'production')):
    m = read(proof/(name+'-aot-map.json'))[0]
    p = read(HERE/(label+'-provenance.json'))
    assert m['artifact_sha256'] == p['artifact_sha256']
    assert m['selected_digest'] == p['digest']
    assert m['wrapper_preferred_address'] == p['method']['function_address']
    assert sha(Path(m['audit'])) == m['audit_sha256']
for name in ('baseline', 'candidate'):
    a = read(proof/'plain-state.json')
    b = read(proof/(name+'-state.json'))
    ac = {r['step']: r for r in a['checkpoints']}
    bc = {r['step']: r for r in b['checkpoints']}
    assert set(ac) == set(bc) and len(ac) == 100
    for step in ac:
        for key in ('numeric_sha256', 'types_sha256', 'aliases_sha256'):
            assert ac[step][key] == bc[step][key]
    result['checkpoint_checks'][name] = 'All 100 numeric/type/alias hashes identical to plain'

c = proof/'bin/barnes_hut.exe'
raw = c.read_bytes()
pe = struct.unpack_from('<I', raw, 0x3c)[0]
opt = pe+24
base = struct.unpack_from('<Q', raw, opt+24)[0]
optlen = struct.unpack_from('<H', raw, pe+20)[0]
constant = None
for i in range(struct.unpack_from('<H', raw, pe+6)[0]):
    at = opt+optlen+i*40
    size, rva, rawsize, offset = struct.unpack_from('<IIII', raw, at+8)
    if base+rva <= 0x1400042f8 < base+rva+rawsize:
        constant = struct.unpack_from('<d', raw, offset+0x1400042f8-base-rva)[0]
assert constant == 0.5
source_excerpt = ROOT/'wave5-instructions/c-force.asm'
(HERE/'c-force.asm').write_bytes(source_excerpt.read_bytes())
result['c'] = {'artifact': str(c), 'artifact_sha256': sha(c),
               'constant_address': '0x1400042f8', 'constant_double': constant,
               'excerpt_source': str(source_excerpt), 'excerpt_sha256': sha(source_excerpt)}
result['proof_manifest_sha256'] = sha(proof/'manifest.json')
result['manual_manifest_sha256'] = sha(manual/'manifest.json')
result['postverification_sha256'] = sha(proof/'checkpoint-postverification.json')
result['native_artifacts_executed'] = False
(HERE/'verification.json').write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps(result, indent=2))
