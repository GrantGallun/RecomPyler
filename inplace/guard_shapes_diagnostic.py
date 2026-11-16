"""Untimed reach plus cProfile guard attribution; not acceptance samples."""
from pathlib import Path
from collections import Counter
import argparse,cProfile,json,os,pstats,subprocess,sys,types
from step0_final_cohort import seal,sha,write,inventory,D,R,W
from heldout_identity import product_functions,key
NAMES=('barnes_hut','scimark')
VARIANTS=('integration-depth-prepared-v1','integration-native-guards-v2')
def application(raw):
 return b''.join(line for line in raw.splitlines(keepends=True) if not(len(line.split())==2 and line.split()[0].startswith(b'seconds')))
def frozen():
 paths=[Path(__file__),D/'step0_final_cohort.py',D/'heldout_identity.py']+[W/'wave5-study/results/drivers'/(n+'.py') for n in NAMES]+[W/'wave11-ledger/gap-ledger/work'/n/f for n in NAMES for f in ('plain-0.stdout','plain-0.stderr','audit.counts.json')]
 return dict(builds={v:seal(v,require_build=True) for v in VARIANTS},files={str(p):sha(p) for p in paths},shim=inventory(W/'wave5-study/results/shim'))
def child(o):
 sys.path[:0]=[str(D/'bases'/o.variant/'src'),str(W/'wave5-study/results/shim')]
 from recompyler import heap,lift
 from recompyler.runner import run_script
 hits=Counter();unknown=Counter();seen=set()
 if o.variant==VARIANTS[1]:
  native=heap._native;heap_check=native.check_heap_guards;lift_check=lift._NATIVE_GUARDS
  labels=((type,'type'),(str,'str'),(int,'int'),(float,'float'),(bool,'bool'),(tuple,'tuple'),(dict,'dict'),(list,'list'),(type(None),'none'),(types.FunctionType,'function'),(types.BuiltinFunctionType,'builtin'),(types.ModuleType,'module'),(types.MemberDescriptorType,'member'),(types.GetSetDescriptorType,'getset'),(types.WrapperDescriptorType,'wrapper'),(types.MethodDescriptorType,'method'))
  def label(value):
   actual=type(value)
   for known,name in labels:
    if actual is known:return name
   return 'other'
  def inspect_heap(guards):
   answer=heap_check(guards);hits['heap:'+str(answer)]+=1
   if answer is not None or type(guards) is not dict:return answer
   rows=[]
   for g in guards.values():
    if type(g) is not tuple or not g or type(g[0]) is not str:return answer
    rows.append((g[0],tuple(label(v) for v in g[1:])))
   shape=tuple(rows)
   if shape not in seen:
    seen.add(shape)
    for i,g in enumerate(guards.values()):
     if heap_check({i:g}) is None:unknown[str(rows[i])]+=1
   return answer
  def inspect_lift(checks,maths):
   answer=lift_check(checks,maths);hits['lift:'+str(answer)]+=1;return answer
  native.check_heap_guards=inspect_heap;lift._NATIVE_GUARDS=inspect_lift
 profile=cProfile.Profile();profile.enable()
 try:report=run_script(W/'wave5-study/results/drivers'/(o.kernel+'.py'),['5'],D/'artifacts'/o.variant/o.kernel/'plan.json',True)
 finally:profile.disable()
 rows=[dict(file=f,line=line,name=name,calls=nc,self_s=tt,cumulative_s=ct) for (f,line,name),(cc,nc,tt,ct,callers) in pstats.Stats(profile).stats.items() if name in ('guards_hold','_has_finalizer','_plain_allocation','inspect_heap','inspect_lift') or 'check_heap_guards' in name or 'check_lift_guards' in name]
 write(o.report,dict(report=report,hits=dict(hits),unsupported_single_guard_shapes=dict(unknown),profile=rows,diagnostic_only=True,profiler_overhead_retained=True))
def main():
 p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);p.add_argument('--lock-label',required=True);p.add_argument('--child',action='store_true');p.add_argument('--variant',choices=VARIANTS);p.add_argument('--kernel',choices=NAMES);p.add_argument('--report',type=Path);o=p.parse_args()
 assert 'purpose: '+o.lock_label+'\n' in (W/'TIMING.lock/owner.txt').read_text()
 if o.child:child(o);return
 output=o.output.resolve();assert output.is_relative_to(D) and not output.exists();output.mkdir();f=frozen();write(output/'freeze.json',f);summary={}
 try:
  for n in NAMES:
   summary[n]={};expected=json.loads((W/'wave11-ledger/gap-ledger/work'/n/'audit.counts.json').read_text())
   reference=(application((W/'wave11-ledger/gap-ledger/work'/n/'plain-0.stdout').read_bytes()),(W/'wave11-ledger/gap-ledger/work'/n/'plain-0.stderr').read_bytes())
   for v in VARIANTS:
    stem=output/(n+'-'+v);report=stem.with_suffix('.json');cmd=[sys.executable,str(Path(__file__).resolve()),'--output',str(output),'--lock-label',o.lock_label,'--child','--variant',v,'--kernel',n,'--report',str(report)]
    env=os.environ.copy();env['PYTHONWARNINGS']='ignore';env['PYTHONPYCACHEPREFIX']=str(output/'bytecode')
    with stem.with_suffix('.stdout').open('xb') as out,stem.with_suffix('.stderr').open('xb') as err:run=subprocess.run(cmd,cwd=R,env=env,stdout=out,stderr=err)
    write(stem.with_suffix('.receipt.json'),dict(command=cmd,exit_code=run.returncode,timing_eligible=False));assert run.returncode==0,(n,v)
    data=json.loads(report.read_text());r=data['report'];plan=json.loads((D/'artifacts'/v/n/'plan.json').read_text());assert r['exit_code'] in (None,0) and not r['not_found'] and not r['batches'] and not r.get('batch_failures')
    assert {key(x):x['aot_calls'] for x in product_functions(r,plan)}=={key(x):5*x['aot_calls'] for x in product_functions(expected,plan)}
    assert all(x['compiled_calls']==x['aot_calls'] and x['jit_calls']==x['fallback_calls']==0 for x in r['functions'])
    assert (application(stem.with_suffix('.stdout').read_bytes()),stem.with_suffix('.stderr').read_bytes())==reference
    summary[n][v]={k:data[k] for k in ('hits','unsupported_single_guard_shapes','profile')}
  assert f==frozen();write(output/'complete.json',dict(complete=True,diagnostic_only=True,summary=summary));print(json.dumps(summary),flush=True)
 except BaseException as error:write(output/'FAILED.json',dict(error=type(error).__name__+': '+str(error),aggregate_eligible=False));raise
if __name__=='__main__':main()
