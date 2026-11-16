"""Source/test sealed S49 gate; never records performance."""
from pathlib import Path
import hashlib,json,os,sys
r=Path(__file__).resolve().parents[1];d=r/'inplace'
baseline='--baseline' in sys.argv
source=d/'s49-accepted4a-baseline-v1/src' if baseline else r/'src'
sys.path.insert(0,str(source));sys.path.insert(1,str(d))
from freeze_build_step0 import inventory
files=[Path(__file__),d/'s49-policy-preparation/test_numeric_values_native.py']
def seal():return dict(source=inventory(source),files={str(p.relative_to(r)):hashlib.sha256(p.read_bytes()).hexdigest() for p in files})
frozen=seal()
if baseline:
 b=source.parent;f=json.loads((b/'freeze.json').read_text())
 assert all(hashlib.sha256((b/n).read_bytes()).hexdigest()==h for n,h in f['files'].items())
import recompyler.heap as heap
assert Path(heap.__file__).resolve().is_relative_to(source.resolve())
import pytest
code=pytest.main([str(files[1]),'-q','--tb=short'])
assert seal()==frozen,'source or tests changed during gate'
out=d/'correctness'/os.environ['WAVE16_CORRECTNESS_LABEL']
(out/'gate.json').write_text(json.dumps(dict(complete=code==0,baseline_commit='0ef65037' if baseline else None,frozen=frozen,scope='16 cases: exact type/value and bit-exact floats; first/warm compiled count and independently intercepted real CPUDispatcher success on each call',timing_eligible=False),indent=2))
sys.exit(code)
