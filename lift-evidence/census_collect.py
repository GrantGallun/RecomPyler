"""Capture actual contexts for S51 diagnostic; no candidate execution or timings."""
from pathlib import Path
import ast,contextlib,hashlib,io,json,os,runpy,shutil,subprocess,sys,traceback,types
R=Path(__file__).resolve().parents[1];D=R/'lift-evidence';W=R.parent
sys.path[:0]=[str(R/'src'),str(D)]
from recompyler import profiler
from recompyler.monitor import CallMonitor
from all_blockers import diagnose
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()


def select_sampler(root,candidates,private,original):
 try:
  relative=Path(root['source']).resolve().relative_to(Path(original).resolve())
  expected=(Path(private)/relative).resolve()
  if sha(expected)!=root['source_sha256']:return None,'source_hash_mismatch'
 except (OSError,ValueError,TypeError):return None,'source_identity_unresolved'
 matches=[]
 for key,sampler in candidates:
  fn=sampler.function
  if type(fn) is not types.FunctionType:continue
  code=fn.__code__
  if (Path(key[0]).resolve()==expected and Path(code.co_filename).resolve()==expected and
      code.co_name==root['function'] and code.co_firstlineno==root['line'] and fn.__qualname__==root['qualname']):matches.append(sampler)
 return (matches[0],'matched') if len(matches)==1 else (None,'ambiguous_capture' if matches else 'identity_mismatch_or_missing_capture')


def collect(name,out,population_path):
 out.mkdir(parents=True,exist_ok=False)
 helpers=[Path(__file__),D/'all_blockers.py',D/'census_population.py',D/'run_census.py',population_path]
 before={str(p):sha(p) for p in helpers}
 before.update({str(p):sha(p) for p in (R/'src/recompyler').rglob('*') if p.is_file() and p.suffix in ('.py','.c','.h','.pyd')})
 population=json.loads(population_path.read_text());wanted=[r for r in population['rows'] if r['program']==name]
 inputs=W/'wave14-capture/capture/inputs';manifest=inputs.parent/'input-manifest.json'
 manifest_data=json.loads(manifest.read_text())
 assert population['input_sha256'][str(manifest)]==sha(manifest),'capture recipe detached from frozen population'
 recipe=next(r for r in manifest_data['workloads'] if r['name']==name)
 before[str(manifest)]=sha(manifest)
 try:
  folder=out/'input';shutil.copytree(inputs/name,folder,ignore=shutil.ignore_patterns('__pycache__'))
  off=out/'off-input';shutil.copytree(inputs/name,off,ignore=shutil.ignore_patterns('__pycache__'))
  shim=out/'shim';shutil.copytree(inputs/'shim',shim,ignore=shutil.ignore_patterns('__pycache__'))
  for p,h in recipe['inputs'].items():assert sha(folder/p)==h
  for p,h in manifest_data['shim'].items():assert sha(shim/p)==h
  for p in [*shim.rglob('*.py'),*[folder/p for p in recipe['inputs']]]:before[str(p)]=sha(p)
  arguments=lambda where:[a.replace(str(inputs/name),str(where)) for a in recipe['args']]
  script=folder/Path(recipe['script']).name
  plain=subprocess.run([sys.executable,str(Path(__file__).resolve()),'--plain',str(off/script.name),str(shim),json.dumps(arguments(off))],cwd=off,capture_output=True,text=True,timeout=300,env=os.environ.copy())
  (out/'plain.stdout').write_text(plain.stdout);(out/'plain.stderr').write_text(plain.stderr)
  assert plain.returncode==0,(name,'plain failed',plain.returncode)
  monitor=CallMonitor([folder],8,profiler.snapshot,backend='python',bias=0,yield_bias=0)
  previous=Path.cwd(),sys.argv[:],sys.path[:];stdout=io.StringIO();stderr=io.StringIO()
  try:
   os.chdir(folder);sys.argv=[str(script),*arguments(folder)];sys.path[:0]=[str(folder),str(shim)]
   with contextlib.redirect_stdout(stdout),contextlib.redirect_stderr(stderr),monitor:runpy.run_path(str(script),run_name='__main__')
  finally:os.chdir(previous[0]);sys.argv=previous[1];sys.path[:]=previous[2]
  norm=lambda text,where:text.replace(str(where),'$INPUT').replace(str(where).replace('\\','/'),'$INPUT')
  assert norm(stdout.getvalue(),folder)==norm(plain.stdout,off),'capture stdout changed'
  assert norm(stderr.getvalue(),folder)==norm(plain.stderr,off),'capture stderr changed'
  (out/'capture.stdout').write_text(stdout.getvalue());(out/'capture.stderr').write_text(stderr.getvalue())
  samplers={}
  for key,sampler in monitor.samplers.items():
   if Path(key[0]).name in recipe['inputs']:samplers.setdefault((key[1],key[2]),[]).append((key,sampler))
  results=[]
  for root in wanted:
   row={k:v for k,v in root.items() if k!='source_excerpt'};row['diagnostics']=[]
   if root['already_native']:row['analysis_status']='already_native';results.append(row);continue
   candidates=samplers.get((root['function'],root['line']),[])
   sampler,identity=select_sampler(root,candidates,folder,inputs/name)
   row['capture_identity_status']=identity
   if sampler is None:
    row['analysis_status']='missing_or_ambiguous_capture';row['unknown_remainder']=True;results.append(row);continue
   samples=[*sampler.samples,*sampler.extra()]
   if not samples:
    row['analysis_status']='no_retained_samples';row['unknown_remainder']=True;results.append(row);continue
   row['analysis_status']='analysed';row['sample_count']=len(samples)
   for index,(args,expected,state) in enumerate(samples):
    data=diagnose(sampler.function,args)
    data['sample_index']=index;data['argument_count']=len(args)
    row['diagnostics'].append(data)
   row['unknown_remainder']=bool(row['unknown_remainder'] or any(r['unknown_remainder'] for r in row['diagnostics']))
   results.append(row)
  assert len(results)==len(wanted)
  assert all(sha(Path(p))==h for p,h in before.items()),'source/helper/input changed'
  (out/'results.json').write_text(json.dumps({'program':name,'rows':results,'capture_behavior_identical':True,'timing_claim':False},indent=2))
  (out/'complete.json').write_text(json.dumps({'complete':True,'results_sha256':sha(out/'results.json'),'source_helpers_inputs_unchanged':True,'input_sha256':before},indent=2))
  print(name,len(results),'roots',sum(r['analysis_status']=='analysed' for r in results),'analysed',flush=True)
 except BaseException as exc:
  (out/'failure.receipt.json').write_text(json.dumps({'complete':False,'error_type':type(exc).__name__,'error':str(exc),'traceback':traceback.format_exc(),'input_sha256':before},indent=2));raise


if __name__=='__main__':
 if sys.argv[1]=='--plain':
  script,shim,args=sys.argv[2:];sys.path[:0]=[str(Path(script).parent),shim];sys.argv=[script,*json.loads(args)];runpy.run_path(script,run_name='__main__')
 else:collect(sys.argv[1],Path(sys.argv[2]).resolve(),Path(sys.argv[3]).resolve())
