"""S50 two-program whole-process control, 20-loop shim, unmodified selection."""
from pathlib import Path
import hashlib,json,os,shutil,statistics,subprocess,sys,time
R=Path(__file__).resolve().parents[1];W=R.parent;D=R/'lift-evidence';LABEL=sys.argv[1] if len(sys.argv)>1 else 'range-s49-s50-long-v1'
OUT=D/LABEL;OUT.mkdir(exist_ok=False)
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
manifest=json.loads((W/'wave3-study/results-v2/manifest.json').read_text());recipes={w['name']:w for w in manifest['workloads']}
shim=OUT/'shim';shutil.copytree(W/'wave3-study/results-long-v2/shim',shim,ignore=shutil.ignore_patterns('__pycache__'))
results=[];all_receipts=[]
manifest_path=W/'wave3-study/results-v2/manifest.json'
harness_path=Path(__file__).resolve()
fixed_inputs={str(p.resolve()):sha(p) for p in [manifest_path,harness_path,D/'run_s50_locked.py',D/'run_locked.py',*sorted(shim.rglob('*.py'))]}

def failure_hook(kind, value, tb):
 import traceback
 (OUT/'failure.receipt.json').write_text(json.dumps({'complete':False,'error_type':kind.__name__,
   'error':str(value),'traceback':''.join(traceback.format_exception(kind,value,tb)),
   'commands':all_receipts,'fixed_inputs_start_sha256':fixed_inputs},indent=2))
 sys.__excepthook__(kind,value,tb)
sys.excepthook=failure_hook

def verify_fixed():
 assert all(sha(Path(p))==h for p,h in fixed_inputs.items()),'fixed input changed'

def artifact_seal(cache, plan):
 paths=[plan,*sorted((cache/'rp').rglob('*'))]
 return {str(p.resolve()):sha(p) for p in paths if p.is_file() and '__pycache__' not in p.parts}

def verify_artifacts(seal):
 assert all(sha(Path(p))==h for p,h in seal.items()),'plan/AOT artifact changed'


def execute(command,cwd,env,stem,timeout):
 verify_fixed();started=time.perf_counter();failure=None;code=None
 try:
  with stem.with_suffix('.stdout').open('wb') as stdout,stem.with_suffix('.stderr').open('wb') as stderr:
   done=subprocess.run(command,cwd=cwd,env=env,stdout=stdout,stderr=stderr,timeout=timeout)
  code=done.returncode
 except BaseException as exc:
  failure={'type':type(exc).__name__,'message':str(exc)}
 finally:
  wall=time.perf_counter()-started
  record={'command':command,'cwd':str(cwd),'exit_code':code,'wall_s':wall,'failure':failure,'python_executable':sys.executable,'python_version':sys.version,
          'controlled_env':{k:env.get(k) for k in ('PYTHONPATH','PYTHONHASHSEED','PYTHONPYCACHEPREFIX','RECOMPYLER_CACHE','RECOMPYLER_CACHE_DIR','NUMBA_CACHE_DIR','TEMP','TMP','OMP_NUM_THREADS','OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','NUMBA_NUM_THREADS')},
          'stdout_sha256':sha(stem.with_suffix('.stdout')) if stem.with_suffix('.stdout').exists() else None,
          'stderr_sha256':sha(stem.with_suffix('.stderr')) if stem.with_suffix('.stderr').exists() else None}
  stem.with_suffix('.receipt.json').write_text(json.dumps(record,indent=2));all_receipts.append(record)
 verify_fixed()
 assert failure is None and code==0,(command,code,failure,str(stem))
 return wall,stem.with_suffix('.stdout').read_bytes()

for name in ('scimark','spectral_norm'):
 w=recipes[name];original=Path(w['cwd']);folder=OUT/'inputs'/name
 shutil.copytree(original,folder,ignore=shutil.ignore_patterns('__pycache__','.recompyler'))
 script=folder/Path(w['script']).relative_to(original)
 args=[str(a).replace(str(original),str(folder)) for a in w['args']]
 cache=OUT/'cache'/name;tmp=cache/'tmp';tmp.mkdir(parents=True,exist_ok=True)
 env=os.environ.copy();env.update(PYTHONPATH=os.pathsep.join([str(shim),str(R/'matrix/temp/bases/lift-range-s49-v1/src'),*w.get('include',[])]),PYTHONHASHSEED='0',PYTHONPYCACHEPREFIX=str(OUT/'bytecode'),RECOMPYLER_CACHE=str(cache/'rp'),RECOMPYLER_CACHE_DIR=str(cache/'rp'),NUMBA_CACHE_DIR=str(cache/'numba'),TEMP=str(tmp),TMP=str(tmp),OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1',NUMBA_NUM_THREADS='1')
 inputs={str(p.relative_to(OUT)):sha(p) for p in sorted(folder.rglob('*')) if p.is_file()}
 plan=OUT/(name+'.plan.json')
 profile_s,profile_stdout=execute([sys.executable,'-m','recompyler','profile','--json',str(plan),'--limit','40','--samples','8',str(script),*args],folder,env,OUT/(name+'-profile'),1800)
 assert plan.exists(),name
 artifacts=artifact_seal(cache,plan)
 (OUT/(name+'.artifacts.before.json')).write_text(json.dumps(artifacts,indent=2))
 samples={'python':[],'recompyler':[]};reference=None;counts=[]
 for pair in range(3):
  for mode in (('python','recompyler') if pair%2==0 else ('recompyler','python')):
   stem=OUT/(name+'-'+mode+'-'+str(pair));count=OUT/(name+'-'+str(pair)+'.counts.json')
   command=[sys.executable,str(script),*args] if mode=='python' else [sys.executable,'-m','recompyler','run','--json',str(count),'--plan',str(plan),str(script),*args]
   verify_artifacts(artifacts)
   wall,stdout=execute(command,folder,env,stem,900);samples[mode].append(wall)
   verify_artifacts(artifacts)
   if reference is None:reference=stdout
   assert stdout==reference,(name,mode,'stdout differs')
   if mode=='recompyler':
    c=json.loads(count.read_text());assert not c.get('not_found'),c
    assert not any(f.get('jit_calls',0) for f in c['functions']),c
    counts.append(c)
 for p,h in inputs.items():assert sha(OUT/p)==h,'input changed'
 result={'program':name,'loops':20,'pairs':3,'samples_s':samples,'median_python_s':statistics.median(samples['python']),'median_recompyler_s':statistics.median(samples['recompyler']),'python_over_recompyler':statistics.median(samples['python'])/statistics.median(samples['recompyler']),'stdout_identical':True,'counts':counts,'selection_profile_s':profile_s,'source_inputs_sha256':inputs,'plan_sha256':sha(plan),'artifact_sha256':artifacts,'note':'Unmodified profile/selection; whole-process wall includes startup; no PyPy rerun or speed claim for range.'}
 results.append(result);print(name,result['median_python_s'],result['median_recompyler_s'],result['python_over_recompyler'],flush=True)
verify_fixed()
(OUT/'summary.json').write_text(json.dumps({'results':results,'shim_files_sha256':{str(p.relative_to(OUT)):sha(p) for p in shim.rglob('*.py')}},indent=2))
(OUT/'complete.json').write_text(json.dumps({'complete':True,'summary_sha256':sha(OUT/'summary.json'),'commands':all_receipts,'runner_sha256':sha(Path(__file__)),'fixed_inputs_start_end_sha256':fixed_inputs},indent=2))
