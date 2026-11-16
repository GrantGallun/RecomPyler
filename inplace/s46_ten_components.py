"""S46 single diagnostic pass over ten fixed regions; no selection cohort."""
from pathlib import Path
import argparse,ast,functools,hashlib,inspect,json,os,shutil,subprocess,sys,textwrap
from contextlib import ExitStack
D=Path(__file__).resolve().parent;R=D.parent;W=R.parent
sys.path.insert(0,str(D))
from freeze_build_step0 import inventory
TARGETS={'chaos':('Chaosgame.transform_point','Spline.__call__'),'gc_collect':('create_cycle',),'hexiom':('Hex.link_nodes','Done.filter_tiles'),'richards_super':('Task.qpkt','DeviceTask.fn','HandlerTask.fn','Task.runTask','schedule')}
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def write(p,d):Path(p).write_text(json.dumps(d,indent=2))

def prepare_region(fn,inputs):
 from recompyler import heap,profiler
 assert inputs
 region=heap.lift_region(fn)
 # Match test_region: discover the first contract, then let public calls use
 # the normal latest/retained-variant resolver for subsequent input samples.
 p=region.program_for(tuple(profiler.fresh_copy(inputs[0][0])))
 assert p is not None and not p.broken,(fn.__qualname__,region.problem)
 return region

def child(name,folder):
 from recompyler import heap,profiler
 from numba.core.registry import CPUDispatcher
 import kernel_phases as kp
 from capture_behavior import ApplicationOutput
 kp.heap=heap
 pending=[];rows=[];nominees=set(TARGETS[name])
 old_monitor=profiler.CallMonitor
 class Monitor(old_monitor):
  def rows(self):return [r for r in super().rows() if r['qualname'] in nominees]
  def __enter__(self):
   self.output=ApplicationOutput(folder/'capture');self.output.__enter__()
   try:return super().__enter__()
   except BaseException:self.output.__exit__(*sys.exc_info());raise
  def __exit__(self,*exc):
   try:return super().__exit__(*exc)
   finally:self.output.__exit__(*exc)
 def capture(fn,inputs,calls,list_reuse=0.0,extra=(),cumulative_s=None):
  assert fn.__qualname__ in nominees
  pending.append((fn,inputs))
  return dict(status='skipped',reason='S46 fixed diagnostic capture only; normal selection is not changed')
 profiler.CallMonitor=Monitor;profiler.test_candidate=capture
 work=json.loads((folder/'work.json').read_text())
 report=profiler.profile_script(folder/'input'/Path(work['script']).name,work['args'],128,8,True)
 assert {fn.__qualname__ for fn,_ in pending}==nominees,('Missing fixed target',name,[fn.__qualname__ for fn,_ in pending])
 for fn,inputs in pending:
  assert inputs and not fn.__code__.co_flags & (profiler._GENERATORS|0x80)
  region=prepare_region(fn,inputs)
  saved=[]
  for p in region.programs.values():
   for namespace,key,_ in p.global_objects:
    value=namespace.get(key)
    if any(value is v for v,_ in saved):continue
    state=profiler._global_state(value)
    if state is not None:saved.append((value,state))
  def reset():
   for value,state in saved:profiler._restore_global(value,state)
  def given_reference(arguments,expected,after):
   reset()
   if saved:
    reference_args=profiler.fresh_copy(arguments)
    try:expected=fn(*reference_args);after=reference_args
    finally:reset()
   return profiler.fresh_copy(arguments),expected,after
  try:
   executed=set()
   # Warm every uniform capture signature outside diagnostic timers; rare extras excluded.
   for _ in range(2):
    for arguments,expected,after in inputs:
     given,expected,after=given_reference(arguments,expected,after)
     before=region.compiled_calls;got=region(*given)
     assert region.compiled_calls==before+1 and profiler._same_result(got,expected) and profiler.same(given,after),(fn.__qualname__,'warm mismatch',region.problem)
     executed.add(region.latest);reset()
   # Every selected variant must share the controlled global-state roots.
   # Do not silently time a newly reached mutable namespace after discovery.
   for p in executed:
    for namespace,key,_ in p.global_objects:
     value=namespace.get(key)
     assert profiler._global_state(value) is None or any(value is v for v,_ in saved),(fn.__qualname__,'uncontrolled mutable global',key)
   attempts=[]
   # Source-transform only existing attempt statements; the public call surrounds it.
   source=textwrap.dedent(inspect.getsource(heap.Region.attempt))
   transform=kp.AttemptScopes();tree=ast.fix_missing_locations(transform.visit(ast.parse(source)))
   namespace=dict(heap.__dict__,_s18_scope=kp.scope);exec(compile(tree,'<S46 attempt scopes>','exec'),namespace)
   with ExitStack() as cleanup:
    old=heap.Region.attempt;heap.Region.attempt=namespace['attempt'];cleanup.callback(setattr,heap.Region,'attempt',old)
    def timed(cls,method,label):
     original=getattr(cls,method)
     @functools.wraps(original)
     def call(*args,**kwargs):
      with kp.scope(label):return original(*args,**kwargs)
     setattr(cls,method,call);cleanup.callback(setattr,cls,method,original)
    for cls,method,label in [(heap.Region,'load','load_ns'),(heap.Region,'arrays','arrays_ns'),(heap._Program,'guards_hold','guards_ns'),(heap._Unloader,'result','result_ns'),(heap._Unloader,'write_back','writeback_ns')]:timed(cls,method,label)
    for p in executed:
     native=p.run;assert type(native) is CPUDispatcher and native.overloads and not p.ahead_of_time
     def observed(*args,_native=native,_digest=p.digest,**kwargs):
      ledger=getattr(kp.ACTIVE,'ledger',None)
      with kp.scope('native_ns'):result=_native(*args,**kwargs)
      if ledger is not None:ledger.native_events.append(dict(digest=_digest,mode='jit',status_after=int(args[3][0]),actual_dispatcher=True))
      return result
     p.run=observed;cleanup.callback(setattr,p,'run',native)
    for arguments,expected,after in inputs:
     given,expected,after=given_reference(arguments,expected,after)
     before=(region.compiled_calls,region.jit_calls,region.aot_calls,region.fallback_calls)
     ledger=kp.Ledger();kp.ACTIVE.ledger=ledger
     try:got=region(*given)
     finally:row=ledger.finish();kp.ACTIVE.ledger=None
     delta=tuple(a-b for a,b in zip((region.compiled_calls,region.jit_calls,region.aot_calls,region.fallback_calls),before))
     row['counter_delta']=delta;row['result_and_arguments_equal']=profiler._same_result(got,expected) and profiler.same(given,after)
     assert delta==(1,1,0,0) and row['result_and_arguments_equal'] and row['native_entries']>=1 and all(e['status_after']==0 for e in row['native_events']),(fn.__qualname__,row)
     attempts.append(row);reset()
   means={k:sum(a['exclusive_ns'][k] for a in attempts)/len(attempts)/1000 for k in kp.LABELS}
   total=sum(a['attempt_ns'] for a in attempts)/len(attempts)/1000
   from recompyler.direct import from_program
   effect_reports=[dict(digest=p.digest,effects=from_program(p).report(),boundary_no_writeback=getattr(p,'boundary_no_writeback',None),functions=[i.fn.__qualname__ for i in p.order]) for p in executed]
   rows.append(dict(function=fn.__qualname__,line=fn.__code__.co_firstlineno,attempts=attempts,mean_complete_us=total,mean_exclusive_us=means,effect_reports=effect_reports,attempt_source_sha256=hashlib.sha256(source.encode()).hexdigest(),inserted_sites=dict(transform.sites),valid=True))
  finally:kp.ACTIVE.ledger=None;reset()
 write(folder/'data.json',dict(complete=True,program=name,rows=rows,source=str(heap.__file__),diagnostic_only=True,replay_context='Uniform sampler inputs only (rare extras excluded); globals reset to post-application snapshot; global-bearing Python references recomputed there. Primitive conversion not separately scoped remains in other. Not additive to prior selection calls.',identity_limit='Exact value/type/argument graph checks use existing profiler oracle; S49 numeric-leaf identity is exempt; exact value/type/bits remain required and this is no new semantic acceptance.'))

def main():
 p=argparse.ArgumentParser();p.add_argument('--child',choices=TARGETS);p.add_argument('--folder',type=Path);p.add_argument('--output',type=Path);p.add_argument('--lock-label');o=p.parse_args()
 if o.child:child(o.child,o.folder.resolve());return
 owner=(W/'TIMING.lock/owner.txt').read_text();assert 'wave16-inplace' in owner and 'purpose: '+o.lock_label+'\n' in owner
 out=o.output.resolve();assert out.is_relative_to(D) and not out.exists();out.mkdir()
 frozen=inventory(R/'src');helpers={str(p):sha(p) for p in (Path(__file__),D/'kernel_phases.py',D/'freeze_build_step0.py',D/'capture_behavior.py')}
 selection=D/'s43-selection-full33-v1';selection_hash=sha(selection/'complete.json');prior=json.loads((selection/'complete.json').read_text());assert prior['complete'] and prior['cohort_complete']
 baselines={str(selection/name/('plain'+suffix)):sha(selection/name/('plain'+suffix)) for name in TARGETS for suffix in ('.stdout','.stderr')}
 manifest_path=W/'wave14-capture/capture/input-manifest.json';manifest_hash=sha(manifest_path);assert manifest_hash==prior['input_manifest_sha256'];manifest=json.loads(manifest_path.read_text())
 shutil.copytree(selection/'shim',out/'shim');assert inventory(out/'shim')==prior['shim_manifest']
 def verify():
  assert inventory(R/'src')==frozen and sha(manifest_path)==manifest_hash and inventory(out/'shim')==prior['shim_manifest']
  assert all(sha(p)==h for p,h in helpers.items())
  assert sha(selection/'complete.json')==selection_hash and all(sha(p)==h for p,h in baselines.items())
 all_rows=[]
 for work in manifest['workloads']:
  name=work['name']
  if name not in TARGETS:continue
  verify();folder=out/name;folder.mkdir();shutil.copytree(work['cwd'],folder/'input',ignore=shutil.ignore_patterns('__pycache__'))
  expected={k:v for k,v in work['inputs'].items() if '__pycache__' not in k and not k.endswith(('.pyc','.pyo','.nbi','.nbc'))};assert inventory(folder/'input')==expected
  write(folder/'work.json',work);work_hash=sha(folder/'work.json')
  env=os.environ.copy();env.update(PYTHONPATH=os.pathsep.join((str(out/'shim'),str(R/'src'),str(D))),PYTHONPYCACHEPREFIX=str(folder/'bytecode'),RECOMPYLER_CACHE=str(folder/'cache'),RECOMPYLER_CACHE_DIR=str(folder/'cache'),NUMBA_CACHE_DIR=str(folder/'numba'))
  command=[sys.executable,str(Path(__file__).resolve()),'--child',name,'--folder',str(folder)]
  with (folder/'child.stdout').open('wb') as stdout,(folder/'child.stderr').open('wb') as stderr:result=subprocess.run(command,cwd=folder/'input',env=env,stdout=stdout,stderr=stderr)
  write(folder/'child.receipt.json',dict(command=command,exit_code=result.returncode));assert result.returncode==0,name
  assert sha(folder/'work.json')==work_hash
  from capture_behavior import extract
  application=extract(folder/'capture',folder/'child');assert application['exit_code']==0 and application['exception'] is None
  assert Path(str(folder/'capture')+'.application.stdout').read_bytes()==(selection/name/'plain.stdout').read_bytes(),name
  assert Path(str(folder/'capture')+'.application.stderr').read_bytes()==(selection/name/'plain.stderr').read_bytes(),name
  data=json.loads((folder/'data.json').read_text());assert data['complete'] and len(data['rows'])==len(TARGETS[name]) and all(r['valid'] for r in data['rows'])
  assert inventory(folder/'input')==expected;verify();all_rows.extend(dict(r,program=name) for r in data['rows']);write(folder/'complete.json',dict(complete=True,data_sha256=sha(folder/'data.json'),behavior_equal=True));print('COMPLETE',name,len(data['rows']),flush=True)
 assert len(all_rows)==10;verify()
 write(out/'complete.json',dict(complete=True,rows=all_rows,source_manifest=frozen,helper_sha256=helpers,input_manifest_sha256=manifest_hash,scope='One fresh capture and one observer-retaining warm complete-call phase pass per fixed region over uniform samples (rare extras excluded); globals reset to post-application snapshot and global-bearing Python references recomputed there; no new selection cohort or timing savings claim; native includes CPUDispatcher/boxing. Primitive conversion outside _Unloader is in other.',prior_selection_sha256=selection_hash,plain_baseline_sha256=baselines,diagnostic_only=True))
if __name__=='__main__':main()
