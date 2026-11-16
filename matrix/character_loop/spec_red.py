"""Execute the remaining cached-import context counterexamples before fixing."""
import hashlib, json, shlex, sys, collections
from pathlib import Path
D=Path(__file__).resolve().parent;R=D.parents[1];sys.path.insert(0,str(R/'src'))
from recompyler._pycc.platform import Toolchain
out=R/'matrix/temp/character-spec-red-v1';out.mkdir(parents=True,exist_ok=False)
source=out/'char_loop.c';source.write_bytes((D/'char_loop.c').read_bytes())
t=Toolchain();objects=t.compile_objects([str(source)],str(out/'obj'),include_dirs=t.get_python_include_dirs(),extra_cflags=['/O2'])
artifact=out/t.get_ext_filename('wave17_charloop');t.link_shared(str(artifact),objects,libraries=t.get_python_libraries(),library_dirs=t.get_python_library_dirs(),export_symbols=['PyInit_wave17_charloop'])
sys.path[:0]=[str(out),str(D)]
import wave17_charloop as ext
from workload import token
ext.configure(token)
events=[]
class Spec:
    @property
    def _initializing(self):events.append('spec-property');return False
class Truth:
    def __bool__(self):events.append('spec-bool');return False
spec=collections.__spec__;initializing=spec._initializing
rows=[]
for name,change,restore in [('spec-property',lambda:setattr(collections,'__spec__',Spec()),lambda:setattr(collections,'__spec__',spec)),('initializing-truth',lambda:setattr(spec,'_initializing',Truth()),lambda:setattr(spec,'_initializing',initializing))]:
    change()
    try:
        events.clear();expected=token('abc');reference=list(events)
        events.clear();observed=ext.borrowed('abc');compiled=list(events)
        row={'witness':name,'same_result':expected==observed,'reference':reference,'compiled':compiled};rows.append(row)
        assert reference and not compiled,row
    finally:restore()
(out/'red.json').write_text(json.dumps({'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'artifact_sha256':hashlib.sha256(artifact.read_bytes()).hexdigest(),'witnesses':rows},indent=2))
print(json.dumps(rows),flush=True)
raise AssertionError('RED: borrowed omitted cached-import spec callbacks')
