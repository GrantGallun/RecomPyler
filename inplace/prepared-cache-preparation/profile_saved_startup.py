"""Diagnostic exclusive startup timers; never a headline latency sample."""
import sys,os,json,time,subprocess
from pathlib import Path
D=Path(__file__).resolve().parents[1]
SOURCE=D/'bases/integration-prepared-v6/src';PLANS=D/'prepared-plans-v6'
def read(p):return json.loads(p.read_text())
def write(p,v):
 with p.open('x') as f:json.dump(v,f,indent=2)
if len(sys.argv)==2:
 out=D/sys.argv[1];assert not out.exists();out.mkdir()
 assert read(PLANS/'summary.json')['complete']
 rows=[]
 for name in ('chaos','richards_super'):
  env=os.environ.copy();env['PYTHONPYCACHEPREFIX']=str(out/'bytecode')
  command=[sys.executable,__file__,str(out),name]
  with (out/(name+'.stdout')).open('xb') as stdout,(out/(name+'.stderr')).open('xb') as stderr:
   child=subprocess.run(command,env=env,stdout=stdout,stderr=stderr)
  write(out/(name+'.receipt.json'),dict(command=command,exit_code=child.returncode))
  assert child.returncode==0
  assert (out/(name+'.stdout')).read_bytes()==(D/'s31-matched-smoke-v1'/name/'plain-0.stdout').read_bytes()
  assert (out/(name+'.stderr')).read_bytes()==(D/'s31-matched-smoke-v1'/name/'plain-0.stderr').read_bytes()
  rows.append(read(out/(name+'.json')))
 write(out/'summary.json',dict(complete=True,diagnostic_only=True,programs=rows))
else:
 out=Path(sys.argv[1]);name=sys.argv[2]
 sys.path[:0]=[str(D/'integration-smoke20-v4/shim'),str(SOURCE)]
 start=time.perf_counter_ns()
 from recompyler import heap,_prepared as pc,_prepared_keys as keys
 from recompyler.runner import run_script
 imports=(time.perf_counter_ns()-start)/1e6
 stats={};stack=[]
 def hook(owner,attr,label):
  original=getattr(owner,attr)
  def wrapped(*a,**kw):
   began=time.perf_counter_ns();frame=[0];stack.append(frame)
   try:return original(*a,**kw)
   finally:
    elapsed=time.perf_counter_ns()-began;stack.pop()
    if stack:stack[-1][0]+=elapsed
    row=stats.setdefault(label,dict(calls=0,inclusive_ms=0.,exclusive_ms=0.))
    row['calls']+=1;row['inclusive_ms']+=elapsed/1e6;row['exclusive_ms']+=(elapsed-frame[0])/1e6
  setattr(owner,attr,wrapped)
 for owner,names,prefix in ((pc,('canonical','digest','file_key','compiler_key','runtime_key','function_key','_class_key','_class_snapshot','_function_snapshot','_restore','open_index','validate_core','core_id'),'prepared.'),(keys,('canonical','digest','file_key','function_key','compiler_key','runtime_key'),'keys.'),(pc.PreparedIndex,('bind',),'index.'),(heap.Region,('load',),'region.')):
  for attr in names:hook(owner,attr,prefix+attr)
 report=read(PLANS/name/'plan.json');script=Path(report['script']);common=D/'integration-smoke20-v4'/name
 command=read(common/'saved-0.receipt.json')['command'];args=command[command.index(str(script))+1:]
 start=time.perf_counter_ns();result=run_script(script,args,PLANS/name/'plan.json',False);elapsed=(time.perf_counter_ns()-start)/1e6
 assert sum(r['aot_calls'] for r in result['functions'])==20 and all(r['jit_calls']==r['fallback_calls']==0 for r in result['functions'])
 write(out/(name+'.json'),dict(name=name,diagnostic_only=True,imports_ms=imports,run_ms=elapsed,stats=stats))
