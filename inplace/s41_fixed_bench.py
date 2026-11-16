"""Three alternating source-pinned complete-call development pairs, no observer in timed loop."""
from pathlib import Path
import argparse, hashlib, json, os, statistics, subprocess, sys, time
D=Path(__file__).resolve().parent;R=D.parent
class Record:
 def __init__(self,value):self.value=value
def field(record):return record.value > 0.0
def scalar(value):return value*2+1

def child(source,output):
 sys.path.insert(0,str(source))
 from recompyler import heap
 from freeze_build_step0 import inventory
 assert json.loads((source.parent/'complete.json').read_text())['complete']
 frozen=inventory(source);assert frozen==json.loads((source.parent/'source-manifest.json').read_text())
 helper_hash=hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
 rows={}
 for name,fn,arg in [('field',field,Record(1.0)),('scalar',scalar,3)]:
  compiled=heap.lift_region(fn);expected=fn(arg);assert compiled(arg)==expected and type(compiled(arg)) is type(expected)
  assert compiled.fallback_calls==0 and compiled.compiled_calls==2,compiled.problem
  for _ in range(100):assert compiled(arg)==expected
  program=compiled.latest;native=program.run
  assert native.signatures and native.overloads,'actual compiled dispatcher required'
  # Independent instrumentation is confined to this untimed audit.
  calls=[]
  def observe(*args):
   result=native(*args);calls.append((int(args[3][0]),result));return result
  program.run=observe;before=compiled.jit_calls
  for _ in range(3):assert compiled(arg)==expected
  program.run=native
  assert len(calls)==3 and all(status==0 for status,_ in calls) and compiled.jit_calls-before==3
  samples=[];before=compiled.compiled_calls;N=50000
  for repeat in range(3):
   row={}
   for kind,call in ([('python',fn),('compiled',compiled)] if repeat%2==0 else [('compiled',compiled),('python',fn)]):
    start=time.perf_counter_ns()
    for _ in range(N):value=call(arg)
    row[kind]=(time.perf_counter_ns()-start)/N
    assert value==expected and type(value) is type(expected)
   samples.append(row)
  assert compiled.compiled_calls-before==3*N and compiled.fallback_calls==0
  rows[name]=dict(samples_ns=samples,python_ns=statistics.median(r['python'] for r in samples),compiled_ns=statistics.median(r['compiled'] for r in samples),independent_native_audit_entries=len(calls),compiled_calls=compiled.compiled_calls,jit_calls=compiled.jit_calls,aot_calls=compiled.aot_calls,fallback_calls=compiled.fallback_calls)
 assert inventory(source)==frozen and hashlib.sha256(Path(__file__).read_bytes()).hexdigest()==helper_hash
 output.write_text(json.dumps(dict(complete=True,rows=rows,source_manifest=frozen,helper_sha256=helper_hash),indent=2))

if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--child',action='store_true');p.add_argument('--source',type=Path);p.add_argument('--output',type=Path,required=True);p.add_argument('--before');p.add_argument('--after');o=p.parse_args()
 if o.child:child(o.source,o.output)
 else:
  out=o.output.resolve();assert out.is_relative_to(D);out.mkdir(exist_ok=False);results={}
  from freeze_build_step0 import inventory
  pins={v:inventory(D/'bases'/v/'src') for v in (o.before,o.after)}
  helper_hash=hashlib.sha256(Path(__file__).read_bytes()).hexdigest();children={}
  for pair in range(3):
   for variant in ([o.before,o.after] if pair%2==0 else [o.after,o.before]):
    source=D/'bases'/variant/'src';target=out/f'{variant}-{pair}.json'
    env=os.environ.copy();env['PYTHONPATH']=str(source)
    child_result=subprocess.run([sys.executable,__file__,'--child','--source',str(source),'--output',str(target)],cwd=R,env=env,capture_output=True)
    (out/f'{variant}-{pair}.stdout').write_bytes(child_result.stdout);(out/f'{variant}-{pair}.stderr').write_bytes(child_result.stderr)
    assert child_result.returncode==0,(variant,pair,child_result.stderr.decode(errors='replace'))
    data=json.loads(target.read_text());assert data['complete']
    assert data['source_manifest']==pins[variant] and data['helper_sha256']==helper_hash
    children[target.name]=hashlib.sha256(target.read_bytes()).hexdigest()
    results.setdefault(variant,[]).append(data['rows'])
  assert all(inventory(D/'bases'/variant/'src')==manifest for variant,manifest in pins.items())
  assert hashlib.sha256(Path(__file__).read_bytes()).hexdigest()==helper_hash
  summary={name:{variant:statistics.median(r[name]['compiled_ns'] for r in rows) for variant,rows in results.items()} for name in ('field','scalar')}
  (out/'complete.json').write_text(json.dumps(dict(complete=True,summary_compiled_ns=summary,pairs=results,source_manifests=pins,helper_sha256=helper_hash,child_receipts_sha256=children),indent=2));print(json.dumps(summary),flush=True)


