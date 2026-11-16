"""Remaining integration verification; each workload separately acquires/releases."""
from pathlib import Path
import subprocess,sys,json,shutil,hashlib
D=Path(__file__).resolve().parent;R=D.parent
receipt=json.loads((D/'logs/integration-noop-review-cases.receipt.json').read_text())
assert receipt['exit_code']==0,'Review counterexample tests must pass first'
source=D/'bases/integration-noop/src'
assert not source.exists(),'Never overwrite an immutable source snapshot'
shutil.copytree(R/'src',source,ignore=shutil.ignore_patterns('__pycache__','*.pyc'))
manifest={p.relative_to(source).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(source.rglob('*')) if p.is_file()}
(source.parent/'source-manifest.json').write_text(json.dumps(manifest,indent=2))
def run(label,*command):
 print('NEXT',label,flush=True)
 subprocess.run([sys.executable,'-B',D/'run_locked.py',label,sys.executable,*command],cwd=R,check=True)
run('integration-noop-achieved','inplace/preparation_phases.py','--output','inplace/preparation-noop-achieved','--integration-source',str(source),'--integration-label','integration-noop')
run('integration-build-noop','inplace/build_all.py','integration-noop')
run('integration-kernel-pairs-v3','inplace/integration_pairs.py','integration-noop','integration-kernel-pairs-v3','3','depth')
run('integration-smoke20-v3','inplace/smoke20.py','--variant','integration-noop','--output','integration-smoke20-v3')
run('integration-final-suite','-m','pytest','tests','-q','--basetemp','inplace/temp/integration-final-pytest')
print('STEP0 VALIDATION COMMANDS COMPLETE; coordinator must inspect receipts/evidence and commit before RESULT',flush=True)
