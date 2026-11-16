from pathlib import Path
import sys,subprocess,json,hashlib
R=Path(__file__).resolve().parents[1]; D=R/'lift-evidence'; out=D/'kernel-build-s49-v1';out.mkdir(exist_ok=False)
records=[]
for label in ('lift-range-base-s49-v1','lift-range-s49-v1'):
 for name in ('barnes_hut','fannkuch','scimark','raytrace'):
  stem=out/(label+'-'+name);cmd=[sys.executable,'matrix/build_kernels.py',label,name]
  with stem.with_suffix('.stdout').open('wb') as o,stem.with_suffix('.stderr').open('wb') as e:
   done=subprocess.run(cmd,cwd=R,stdout=o,stderr=e)
  entry={'command':cmd,'exit_code':done.returncode,'stdout_sha256':hashlib.sha256(stem.with_suffix('.stdout').read_bytes()).hexdigest(),'stderr_sha256':hashlib.sha256(stem.with_suffix('.stderr').read_bytes()).hexdigest()}
  stem.with_suffix('.receipt.json').write_text(json.dumps(entry,indent=2));records.append(entry)
  assert done.returncode==0,entry
  print('BUILT',label,name,flush=True)
artifacts=R/'matrix/temp/artifacts'
files={str(p.relative_to(R)):hashlib.sha256(p.read_bytes()).hexdigest() for label in ('lift-range-base-s49-v1','lift-range-s49-v1') for p in sorted((artifacts/label).rglob('*')) if p.is_file()}
(out/'complete.json').write_text(json.dumps({'complete':True,'commands':records,'artifact_sha256':files,'note':'Correctness/build only; no timing claims'},indent=2))
