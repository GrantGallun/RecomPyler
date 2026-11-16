from pathlib import Path
import shutil,subprocess,sys,json,hashlib
R=Path(__file__).resolve().parents[1]; D=R/'lift-evidence/frozen/range-s49-original'
D.mkdir(parents=True,exist_ok=False)
shutil.copytree(R/'src',D/'src',ignore=shutil.ignore_patterns('__pycache__'))
for name in ('heap.py','_region_seed.py','_prepared.py'):
 data=subprocess.run(['git','-c','safe.directory=*','show','HEAD:src/recompyler/'+name],cwd=R,capture_output=True,check=True).stdout
 (D/'src/recompyler'/name).write_bytes(data)
manifest={str(p.relative_to(D)):hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted((D/'src').rglob('*')) if p.is_file()}
(D/'complete.json').write_text(json.dumps({'complete':True,'source_sha256':manifest},indent=2))
