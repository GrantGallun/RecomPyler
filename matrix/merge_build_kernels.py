"""Fresh frozen-source kernel artifacts for S39, never reuse incomplete builds."""
import hashlib,json,subprocess,sys
from pathlib import Path
R=Path(__file__).resolve().parents[1];variant=sys.argv[1]
snapshot=R/'matrix/temp/bases'/variant;s=json.loads((snapshot/'complete.json').read_text());assert s['complete']
assert all(hashlib.sha256((snapshot/f).read_bytes()).hexdigest()==h for f,h in s['source_sha256'].items())
out=R/'matrix/temp/artifacts'/variant;assert not out.exists()
subprocess.run([sys.executable,str(R/'matrix/build_all.py'),variant],cwd=R,check=True)
assert len(list(out.glob('*/plan.json')))==4 and len(list(out.glob('*/*.pyd')))==4
(out/'complete.json').write_text(json.dumps({'complete':True,'snapshot_sha256':hashlib.sha256((snapshot/'complete.json').read_bytes()).hexdigest(),'sha256':{str(f.relative_to(out)):hashlib.sha256(f.read_bytes()).hexdigest() for f in out.rglob('*') if f.is_file()}},indent=2))
