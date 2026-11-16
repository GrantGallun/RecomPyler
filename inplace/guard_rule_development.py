"""Three-pair two-kernel native-guard development cohort, with immutable input seals.
Run only through run_locked; this wrapper adds no timing repetitions.
"""
from pathlib import Path
import argparse,hashlib,json,subprocess,sys
D=Path(__file__).resolve().parent;R=D.parent;W=R.parent
NAMES=('barnes_hut','fannkuch','scimark','raytrace')
TARGETS=('barnes_hut','scimark')
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def inventory(root):
 return {p.relative_to(root).as_posix():sha(p) for p in sorted(root.rglob('*')) if p.is_file() and '__pycache__' not in p.parts and p.suffix not in ('.pyc','.pyo','.nbi','.nbc')}
def write(p,v):
 with p.open('x',encoding='utf-8') as f:json.dump(v,f,indent=2)
def seal(variant, *, require_build=False):
 root=D/'bases'/variant/'src';manifest=root.parent/'source-manifest.json'
 expected=json.loads(manifest.read_text(encoding='utf-8-sig'));actual=inventory(root)
 if expected and all(k.startswith('src/') for k in expected):actual={'src/'+k:v for k,v in actual.items()}
 assert actual==expected,('source changed',variant)
 artifacts={n:inventory(D/'artifacts'/('integration' if variant=='integration-fixed' else variant)/n) for n in NAMES}
 result=dict(source_manifest_sha256=sha(manifest),source_files=actual,artifacts=artifacts)
 if require_build:
  assert not (root.parent/'FAILED.json').exists()
  complete=root.parent/'complete.json';build=json.loads(complete.read_text(encoding='utf-8-sig'))
  assert build['complete'] and build['variant']==variant and build['artifacts']==artifacts
  assert build['source_manifest_sha256']==sha(manifest)
  receipt=D/'logs'/(build['lock_label']+'.receipt.json');logged=json.loads(receipt.read_text())
  assert logged['exit_code']==0 and logged['label']==build['lock_label']
  helper='inplace/build_committed_depth.py' if build.get('kind')=='committed-depth' else 'inplace/freeze_build_step0.py'
  assert logged['command'][:4]==['python',helper,'--variant',variant]
  if build.get('kind')=='committed-depth':assert build['commit']=='56860c375785c23fbfbb97f85e1589584b4ccaa6'
  assert all(sha(path)==value for path,value in build['union_evidence'].items())
  assert all(sha(path)==value for path,value in build['build_inputs']['files'].items())
  assert inventory(W/'wave5-study/results/shim')==build['build_inputs']['shim']
  result['complete_sha256']=sha(complete);result['build_receipt_sha256']=sha(receipt)
 return result
def main():
 p=argparse.ArgumentParser();p.add_argument('--variant',required=True);p.add_argument('--base',default='depth');p.add_argument('--output',required=True);p.add_argument('--lock-label',required=True);o=p.parse_args()
 for x in (o.variant,o.base,o.output):assert Path(x).name==x and x not in ('.','..')
 owner=(W/'TIMING.lock/owner.txt').read_text();assert 'wave16-inplace' in owner and 'purpose: '+o.lock_label+'\n' in owner
 output=D/o.output;assert not output.exists()
 frozen={v:seal(v,require_build=True) for v in (o.base,o.variant)}
 drivers={n:sha(W/'wave5-study/results/drivers'/(n+'.py')) for n in TARGETS}
 shim=inventory(W/'wave5-study/results/shim')
 references={str(p):sha(p) for n in TARGETS for p in (W/'wave11-ledger/gap-ledger/work'/n/'plain-0.stdout',W/'wave11-ledger/gap-ledger/work'/n/'audit.counts.json')}
 analysis_sha=sha(D/'pair_analysis.py')
 freeze=dict(sources=frozen,drivers=drivers,shim=shim,references=references,analysis_sha256=analysis_sha,pairs=3,kernels=list(TARGETS),self_sha256=sha(Path(__file__)),harness_sha256=sha(D/'guard_rule_pairs.py'))
 write(D/'logs'/(o.lock_label+'.freeze.json'),freeze)
 try:
  subprocess.run([sys.executable,str(D/'guard_rule_pairs.py'),o.variant,o.output,'3',o.base],cwd=R,check=True)
  summary=json.loads((output/'summary.json').read_text());assert set(summary)==set(TARGETS)
  for rows in summary.values():
   assert set(rows)=={o.base,o.variant}
   assert all(len(row['samples_ms'])==3 for row in rows.values())
  assert frozen=={v:seal(v,require_build=True) for v in (o.base,o.variant)}
  assert drivers=={n:sha(W/'wave5-study/results/drivers'/(n+'.py')) for n in TARGETS}
  assert shim==inventory(W/'wave5-study/results/shim')
  assert all(sha(p)==value for p,value in references.items()) and sha(D/'pair_analysis.py')==analysis_sha
  assert sha(D/'guard_rule_pairs.py')==freeze['harness_sha256'] and sha(Path(__file__))==freeze['self_sha256']
  subprocess.run([sys.executable,str(D/'pair_analysis.py'),str(output/'summary.json'),o.base,o.variant],cwd=R,check=True)
  write(output/'complete.json',dict(complete=True,accepted=False,development_only=True,pairs=3,kernels=list(TARGETS),source_and_input_seals_unchanged=True,summary_sha256=sha(output/'summary.json'),analysis_sha256=sha(output/'paired-analysis.json'),freeze_sha256=sha(D/'logs'/(o.lock_label+'.freeze.json')),correctness='Every child exact checks and expected AOT counts; zero JIT/fallback/not-found/batches checked by original harness. Performance acceptance requires coordinator inspection.'))
 except BaseException as exc:
  if output.exists():write(output/'FAILED.json',dict(error=type(exc).__name__+': '+str(exc),aggregate_eligible=False))
  raise
if __name__=='__main__':main()
