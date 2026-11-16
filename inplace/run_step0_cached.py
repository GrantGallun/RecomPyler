"""Final-source Step0 gates after reviewed immutable F2 cache correction."""
from pathlib import Path
import subprocess,sys,json,shutil,hashlib
D=Path(__file__).resolve().parent;R=D.parent
assert json.loads((D/'logs/integration-f2-green.receipt.json').read_text())['exit_code']==0
assert (D/'f2-cache-preparation/CODE-REVIEW.md').exists(),'Independent review required before timing'
source=D/'bases/integration-cache/src'
assert not source.exists(),'Immutable snapshot already exists'
shutil.copytree(R/'src',source,ignore=shutil.ignore_patterns('__pycache__','*.pyc'))
manifest={p.relative_to(source).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(source.rglob('*')) if p.is_file()}
(source.parent/'source-manifest.json').write_text(json.dumps(manifest,indent=2))
def run(label,*command):
 print('NEXT',label,flush=True)
 subprocess.run([sys.executable,'-B',D/'run_locked.py',label,sys.executable,*command],cwd=R,check=True)
run('integration-f2-achieved','inplace/preparation_phases.py','--output','inplace/preparation-f2-achieved','--integration-source',str(source),'--integration-label','integration-cache')
run('integration-smoke20-v4','inplace/smoke20.py','--variant','integration-cache','--output','integration-smoke20-v4')
smoke=json.loads((D/'integration-smoke20-v4/summary.json').read_text())
assert len(smoke)==2 and all(r['deployed']>=1 and r['ratio']>1 for r in smoke),'Step0 smoke performance not recovered; stop before remaining acceptance'
run('integration-build-cache','inplace/build_all.py','integration-cache')
run('integration-kernel-pairs-v4','inplace/integration_pairs.py','integration-cache','integration-kernel-pairs-v4','3','depth')
run('integration-cache-final-suite','-m','pytest','tests','-q','--basetemp','inplace/temp/integration-cache-final-pytest')
print('STEP0 GATES COMPLETE; coordinator must inspect final evidence and commit before RESULT',flush=True)
