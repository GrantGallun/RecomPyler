"""One S41 diagnostic phase pass; all phase/scope overhead is retained."""
from pathlib import Path
import ast, importlib, inspect, json, statistics, sys, textwrap, time
D=Path(__file__).resolve().parent; sys.path.insert(0,str(D.parent/'src'))
from recompyler import heap
import kernel_phases as kp
kp.heap=heap
lift_module=importlib.import_module('recompyler.lift')
class Record:
 def __init__(self,value):self.value=value
def trivial(record):return record.value > 0.0
r=Record(1.0); c=heap.lift_region(trivial)
assert c(r) is True and c.compiled_calls==1 and c.fallback_calls==0
for _ in range(100): assert c(r) is True
# Ordinary complete calls before observation.
rows=[]
for rep in range(3):
 row={}
 for name,fn in ([('python',trivial),('compiled',c)] if rep%2==0 else [('compiled',c),('python',trivial)]):
  start=time.perf_counter_ns()
  for _ in range(50000):value=fn(r)
  row[name]=(time.perf_counter_ns()-start)/50000
  assert value is True
 rows.append(row)
kp.LABELS += ('attempt_bookkeeping_ns','lifetime_checks_ns','allocation_checks_ns')
source=textwrap.dedent(inspect.getsource(heap.Region.attempt)); transform=kp.AttemptScopes()
tree=ast.fix_missing_locations(transform.visit(ast.parse(source)))
namespace=dict(heap.__dict__,_s18_scope=kp.scope)
exec(compile(tree,'<S41 phases>','exec'),namespace)
heap.Region.attempt=namespace['attempt']
for cls,method,label in [(heap.Region,'attempt','attempt_bookkeeping_ns'),(heap.Region,'load','load_ns'),(heap.Region,'arrays','arrays_ns'),(heap._Program,'guards_hold','guards_ns'),(heap._Loader,'argument','load_ns'),(heap._Unloader,'result','result_ns'),(heap._Unloader,'write_back','writeback_ns')]:kp.timed_method(cls,method,label)
for method,label in [('_has_finalizer','lifetime_checks_ns'),('_plain_allocation','allocation_checks_ns')]: kp.timed_method(lift_module,method,label)
native=c.latest.run
def run(*args):
 with kp.scope('native_ns'):return native(*args)
c.latest.run=run
attempts=[]; before=c.compiled_calls
for _ in range(128):
 ledger=kp.Ledger();kp.ACTIVE.ledger=ledger
 assert c(r) is True
 attempts.append(ledger.finish());kp.ACTIVE.ledger=None
assert c.compiled_calls-before==128 and c.fallback_calls==0
means={label:sum(a['exclusive_ns'][label] for a in attempts)/len(attempts)/1000 for label in kp.LABELS}
result=dict(complete=True,source=str(D.parent/'src'),ordinary_pairs_ns=rows,python_us=statistics.median(x['python'] for x in rows)/1000,compiled_us=statistics.median(x['compiled'] for x in rows)/1000,diagnostic_sorted_us=sorted(means.items(),key=lambda x:-x[1]),attempts=attempts,inserted_sites=dict(transform.sites),notes='Scope overhead retained; bookkeeping_ns is outer wrapper dispatch/observer envelope; attempt_bookkeeping_ns is residual Python attempt work. Nested lifetime checks inside native guard are included in guards, not separately timed. Not causal or additive to ordinary complete call.')
out=D/'s41-trivial-components-v1';out.mkdir(exist_ok=False);(out/'complete.json').write_text(json.dumps(result,indent=2));print(json.dumps({k:v for k,v in result.items() if k!='attempts'}),flush=True)

