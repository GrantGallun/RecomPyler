"""Freeze current source and build four kernels after the sealed green union.
Use a new variant under run_locked; partial builds are never reusable.
"""
from pathlib import Path
import argparse,hashlib,json,shutil,subprocess,sys
D=Path(__file__).resolve().parent;R=D.parent;W=R.parent
NAMES=('barnes_hut','fannkuch','scimark','raytrace')
def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()
def read(path):return json.loads(Path(path).read_text(encoding='utf-8-sig'))
def inventory(root):
 return {p.relative_to(root).as_posix():sha(p) for p in sorted(root.rglob('*')) if p.is_file() and '__pycache__' not in p.parts and p.suffix not in ('.pyc','.pyo','.nbi','.nbc')}
def write(path,value):
 with path.open('x',encoding='utf-8') as stream:json.dump(value,stream,indent=2)
def inputs():
 paths=[Path(__file__),D/'build_all.py',D/'build_kernels.py']
 paths += [W/'wave5-study/results/drivers'/(n+'.py') for n in NAMES]
 paths += [W/'wave11-ledger/gap-ledger/work'/n/'plan.json' for n in NAMES]
 return dict(files={str(p):sha(p) for p in paths},shim=inventory(W/'wave5-study/results/shim'))
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--variant',required=True);p.add_argument('--tests-receipt',type=Path,required=True);p.add_argument('--union-proof',type=Path,required=True);p.add_argument('--lock-label',required=True);o=p.parse_args()
 assert Path(o.variant).name==o.variant and o.variant not in ('.','..')
 owner=(W/'TIMING.lock/owner.txt').read_text();assert 'wave16-inplace' in owner and 'purpose: '+o.lock_label+'\n' in owner
 receipt=o.tests_receipt.resolve();proof=o.union_proof.resolve();assert receipt.is_relative_to(D/'logs') and proof.is_relative_to(D) and proof.name=='complete.json'
 r=read(receipt);u=read(proof);assert r['exit_code']==0 and u['complete'] and not (proof.parent/'FAILED.json').exists()
 expected=['python','inplace/step0_union.py','--output',proof.parent.relative_to(R).as_posix(),'--lock-label',u['lock_label']]
 assert r['command']==expected and r['label']==u['lock_label'],('Unexpected union command',r['command'],expected)
 assert u['command']==[sys.executable,'-m','pytest','tests','-q','--basetemp',str(proof.parent/'pytest-temp')]
 assert sha(proof.parent/'freeze.json')==u['freeze_sha256']
 union_freeze=read(proof.parent/'freeze.json')
 assert union_freeze['harness_sha256']==sha(D/'step0_union.py')
 assert union_freeze['source']==u['source'] and union_freeze['tests']==u['tests']
 frozen=inventory(R/'src');assert frozen==u['source'] and inventory(R/'tests')==u['tests']
 evidence={str(path):sha(path) for path in (receipt,proof,proof.parent/'freeze.json',D/'step0_union.py')}
 base=D/'bases'/o.variant;artifacts=D/'artifacts'/o.variant;assert not base.exists() and not artifacts.exists()
 shutil.copytree(R/'src',base/'src',ignore=shutil.ignore_patterns('__pycache__','*.pyc','*.pyo','*.nbi','*.nbc'))
 write(base/'source-manifest.json',frozen);build_inputs=inputs()
 try:
  subprocess.run([sys.executable,str(D/'build_all.py'),o.variant],cwd=R,check=True)
  assert inventory(base/'src')==frozen and inventory(R/'src')==frozen,'Source changed during build'
  assert build_inputs==inputs() and all(sha(path)==value for path,value in evidence.items())
  for name in NAMES:
   assert (artifacts/name/'plan.json').is_file()
   assert any(p.suffix in ('.pyd','.so') for p in (artifacts/name).iterdir())
  write(base/'complete.json',dict(complete=True,variant=o.variant,lock_label=o.lock_label,union_evidence=evidence,build_inputs=build_inputs,source_manifest_sha256=sha(base/'source-manifest.json'),artifacts={n:inventory(artifacts/n) for n in NAMES}))
 except BaseException as exc:
  write(base/'FAILED.json',dict(error=type(exc).__name__+': '+str(exc),aggregate_eligible=False));raise
if __name__=='__main__':main()
