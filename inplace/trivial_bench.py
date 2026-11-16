"""Complete-call trivial region benchmark, including dispatch/guards/boundary/result."""
from pathlib import Path
import sys,json,time,statistics
D=Path(__file__).resolve().parent
stage=sys.argv[1];source=D/'bases'/stage/'src' if (D/'bases'/stage/'src').exists() else D.parent/'src';sys.path.insert(0,str(source))
from recompyler import heap
class Record:
 def __init__(self,value):self.value=value
def trivial(record):return record.value > 0.0
record=Record(1.0);compiled=heap.lift_region(trivial)
assert compiled(record) is trivial(record) is True
assert compiled.compiled_calls==1 and compiled.fallback_calls==0,(compiled.problem,compiled.gave_up)
for _ in range(100):assert compiled(record) is True
PAIRS=int(sys.argv[2]) if len(sys.argv)>2 else 3
N=50000;rows=[];before=compiled.compiled_calls
for rep in range(PAIRS):
 row={'pair':rep,'order':['python','compiled'] if rep%2==0 else ['compiled','python']}
 for name in row['order']:
  fn=trivial if name=='python' else compiled;start=time.perf_counter_ns()
  for _ in range(N):value=fn(record)
  ns=time.perf_counter_ns()-start;assert value is True;row[name+'_ns_per_call']=ns/N
 rows.append(row)
assert compiled.compiled_calls-before==PAIRS*N and compiled.fallback_calls==0
out={'stage':stage,'source':str(source),'iterations':N,'pairs':rows,'python_ns':statistics.median(x['python_ns_per_call'] for x in rows),'compiled_complete_ns':statistics.median(x['compiled_ns_per_call'] for x in rows),'compiled_calls':compiled.compiled_calls,'fallback_calls':compiled.fallback_calls,'target':'compiled complete call below same Python function; one numeric field read and comparison'}
p=D/('trivial-'+stage+'.json');assert not p.exists();p.write_text(json.dumps(out,indent=2));print(json.dumps(out),flush=True)
