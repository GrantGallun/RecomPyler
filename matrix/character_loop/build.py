"""Fresh C/JIT/AOT behavior attempt; a failed directory is never reused."""
import hashlib, json, shutil, subprocess, sys
from pathlib import Path
D=Path(__file__).resolve().parent;R=D.parents[1]
sys.path.insert(0,str(R/'src'))
from recompyler._pycc.platform import Toolchain
out=R/'matrix/temp'/sys.argv[1];out.mkdir(parents=True,exist_ok=False)
for name in ['char_loop.c','bridge.py','workload.py','behavior.py','fresh.py']:
    shutil.copyfile(D/name,out/name)
inputs=[*(out/name for name in ['char_loop.c','bridge.py','workload.py','behavior.py','fresh.py']),Path(__file__).resolve(),R/'matrix/extension/managed.py']
initial={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs}
(out/'input-seal.json').write_text(json.dumps({'sha256':initial,'python':sys.version,'executable':sys.executable,'flags':['/O2'],'build_helper':str(Path(__file__).resolve())},indent=2))
t=Toolchain();objects=t.compile_objects([str(out/'char_loop.c')],str(out/'obj'),include_dirs=t.get_python_include_dirs(),extra_cflags=['/O2'])
artifact=out/t.get_ext_filename('wave17_charloop')
t.link_shared(str(artifact),objects,libraries=t.get_python_libraries(),library_dirs=t.get_python_library_dirs(),export_symbols=['PyInit_wave17_charloop'])
subprocess.run([sys.executable,str(out/'behavior.py'),str(out)],cwd=R,check=True)
assert json.loads((out/'behavior.json').read_text())['complete']
assert initial=={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs},'source changed during attempt'
files=[p for p in out.rglob('*') if p.is_file() and '__pycache__' not in p.parts]
(out/'complete.json').write_text(json.dumps({'complete':True,'sha256':{str(p.relative_to(out)):hashlib.sha256(p.read_bytes()).hexdigest() for p in files},'managed_model_sha256':hashlib.sha256((R/'matrix/extension/managed.py').read_bytes()).hexdigest()},indent=2))
print('COMPLETE',out,flush=True)
