"""Rebuild only the accepted merged C helpers in an isolated attempt."""
import hashlib,json,subprocess,sys
from pathlib import Path
R=Path(__file__).resolve().parents[1]
out=R/'matrix/temp/merge-native-build-v1';out.mkdir(parents=True,exist_ok=False)
cmd=[sys.executable,'setup.py','build_ext','--inplace','--force','--build-lib',str(out/'lib'),'--build-temp',str(out/'obj')]
subprocess.run(cmd,cwd=R,check=True)
probe=subprocess.run([sys.executable,'-c',"from recompyler import _heap; assert _heap.GUARD_CHECKS_VERSION==1; assert _heap.GUARD_ATTRIBUTES_VERSION==1; print(_heap.__file__)"],cwd=R,check=True,text=True,capture_output=True)
files=[R/'setup.py',R/'src/recompyler/_heap.c',R/'src/recompyler/_guards.h',R/'src/recompyler/_monitor.c',*sorted((R/'src/recompyler').glob('*.pyd'))]
(out/'complete.json').write_text(json.dumps({'complete':True,'command':cmd,'probe':probe.stdout,'sha256':{str(f.relative_to(R)):hashlib.sha256(f.read_bytes()).hexdigest() for f in files}},indent=2))
print(probe.stdout,flush=True)
