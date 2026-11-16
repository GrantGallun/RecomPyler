"""S43 one remaining-floor pass using the checkpoint70 scope instrument."""
from pathlib import Path
import ast,hashlib,importlib,inspect,json,statistics,sys,textwrap,time
D=Path(__file__).resolve().parent;sys.path.insert(0,str(D.parent/'src'))
from recompyler import heap
import kernel_phases as kp
from freeze_build_step0 import inventory
source=inventory(D.parent/'src');helpers={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in (Path(__file__),D/'kernel_phases.py',D/'freeze_build_step0.py')}
class Record:
 def __init__(self,value):self.value=value
def field(record):return record.value>0.0
def scalar(value):return value*2+1
cases=[]
for name,fn,arg in [('field',field,Record(1.0)),('scalar',scalar,3)]:
 region=heap.lift_region(fn);expected=fn(arg);assert region(arg)==expected
 for _ in range(100):assert region(arg)==expected
 program=region.latest;assert program.run.signatures and program.run.overloads
 args=(arg,);buffers=region.arrays();passed=[arg] if name=='scalar' else None
 rows=[]
 for repeat in range(3):
  row={}
  calls=[('python',fn),('compiled',region)]
  if name=='scalar':
   # These are separate descriptive envelopes, not additive components/savings.
   calls.extend([('attempt',lambda:region.attempt(args)),('scalar_helper',lambda:region._scalar_attempt(program,args)),('dispatcher_call_envelope',lambda:program.run(*buffers,*passed)),('guards_only',program.guards_hold)])
  if repeat%2:calls.reverse()
  for label,call in calls:
   start=time.perf_counter_ns()
   if label in ('python','compiled'):
    for _ in range(50000):got=call(arg)
   else:
    for _ in range(50000):got=call()
   row[label]=(time.perf_counter_ns()-start)/50000
   if label in ('attempt','scalar_helper'):assert got==(True,expected) and type(got[1]) is type(expected)
   elif label=='guards_only':assert got is True
   else:assert got==expected and type(got) is type(expected)
  rows.append(row)
 assert region.fallback_calls==0
 cases.append((name,region,arg,expected,rows))
kp.LABELS+=('attempt_bookkeeping_ns','scalar_entry_ns','wrapper_dispatch_ns','argument_pack_validate_ns','lifetime_checks_ns','allocation_checks_ns')
# Preserve the old scopes. Add scalar argument packing/validation, reused buffers,
# and residual scalar-helper scopes where the new fast entry bypasses old sites.
class ScalarScopes(kp.AttemptScopes):
 def visit_For(self,node):
  if ast.unparse(node.iter)=='zip(program.entry.params, args)':return self.wrap(node,'argument_pack_validate_ns')
  return super().visit_For(node)
 def visit_Assign(self,node):
  names={part.id for target in node.targets for part in ast.walk(target) if isinstance(part,ast.Name)}
  if names=={'passed'}:return self.wrap(node,'argument_pack_validate_ns')
  if names=={'F','I','top','st'}:return self.wrap(node,'arrays_ns')
  return super().visit_Assign(node)
original_primitive=heap._primitive_result
def primitive(*args):
 with kp.scope('result_ns'):return original_primitive(*args)
heap._primitive_result=primitive
sites={}
for method,transform in [('attempt',kp.AttemptScopes()),('_scalar_attempt',ScalarScopes())]:
 body=textwrap.dedent(inspect.getsource(getattr(heap.Region,method)))
 tree=ast.fix_missing_locations(transform.visit(ast.parse(body)));namespace=dict(heap.__dict__,_s18_scope=kp.scope)
 exec(compile(tree,'<S43 phases>','exec'),namespace);setattr(heap.Region,method,namespace[method]);sites[method]=dict(transform.sites)
for cls,method,label in [(heap.Region,'__call__','wrapper_dispatch_ns'),(heap.Region,'attempt','attempt_bookkeeping_ns'),(heap.Region,'_scalar_attempt','scalar_entry_ns'),(heap.Region,'load','load_ns'),(heap.Region,'arrays','arrays_ns'),(heap._Program,'guards_hold','guards_ns'),(heap._Loader,'argument','load_ns'),(heap._Unloader,'result','result_ns'),(heap._Unloader,'write_back','writeback_ns')]:kp.timed_method(cls,method,label)
lift=importlib.import_module('recompyler.lift')
for method,label in [('_has_finalizer','lifetime_checks_ns'),('_plain_allocation','allocation_checks_ns')]:kp.timed_method(lift,method,label)
results={}
for name,region,arg,expected,rows in cases:
 native=region.latest.run
 def observed(*args,_native=native,_name=name):
  ledger=getattr(kp.ACTIVE,'ledger',None)
  with kp.scope('native_ns'):result=_native(*args)
  if ledger is not None:ledger.native_events.append(dict(mode='jit',function=_name,status_after=int(args[3][0])))
  return result
 region.latest.run=observed;attempts=[];before=(region.compiled_calls,region.jit_calls,region.aot_calls)
 for _ in range(128):
  ledger=kp.Ledger();kp.ACTIVE.ledger=ledger
  got=region(arg);assert got==expected and type(got) is type(expected)
  attempts.append(ledger.finish());kp.ACTIVE.ledger=None
 deltas=dict(compiled_calls=region.compiled_calls-before[0],jit_calls=region.jit_calls-before[1],aot_calls=region.aot_calls-before[2])
 assert deltas==dict(compiled_calls=128,jit_calls=128,aot_calls=0) and region.fallback_calls==0
 assert all(a['native_entries']==1 and a['native_events'][0]['status_after']==0 for a in attempts)
 means={label:sum(a['exclusive_ns'][label] for a in attempts)/len(attempts)/1000 for label in kp.LABELS}
 results[name]=dict(diagnostic_counter_deltas=deltas,ordinary_pairs_ns=rows,ordinary_medians_us={label:statistics.median(row[label] for row in rows)/1000 for label in rows[0]},diagnostic_sorted_us=sorted(means.items(),key=lambda x:-x[1]),attempts=attempts,compiled_calls=region.compiled_calls,aot_calls=region.aot_calls,jit_calls=region.jit_calls,fallback_calls=region.fallback_calls)
assert inventory(D.parent/'src')==source
assert all(hashlib.sha256(Path(p).read_bytes()).hexdigest()==h for p,h in helpers.items())
result=dict(complete=True,source_manifest=source,helper_sha256=helpers,rows=results,inserted_sites=sites,notes='Same checkpoint70 exclusive scope clock; observer overhead retained and values not additive to uninstrumented call. Wrapper bytecode is wrapper_dispatch plus attempt/scalar residual; Python argument tuple/dict packing before the observed method remains in bookkeeping. Scalar pack/validate scope includes per-argument checks and native argument list. Native scope includes CPUDispatcher dispatch and native return boxing; result scope is subsequent primitive conversion. Lifetime/allocation native guard work is included in guards. Ordinary python/compiled rows use direct call(arg), matching the baseline. Other descriptive envelopes are separate measurements and must not be subtracted or summed as causal savings. Dispatcher_call_envelope includes lambda, attribute lookup and stararg packing. Aggregate counters include direct attempt/helper probes (which increment jit but not compiled); the128 diagnostic counter deltas reconcile separately.')
out=D/'s43-remaining-components-v1';out.mkdir(exist_ok=False);(out/'complete.json').write_text(json.dumps(result,indent=2))
print(json.dumps({name:{k:v for k,v in row.items() if k!='attempts'} for name,row in results.items()},indent=2))
