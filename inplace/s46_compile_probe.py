"""Correctness-only probe of the Richards capture/compile precondition."""
from pathlib import Path
import json,os,shutil,sys
from recompyler import heap,profiler
r=Path(__file__).resolve().parents[1];w=r.parent;out=r/'inplace/correctness'/os.environ['WAVE16_CORRECTNESS_LABEL']
sys.path.insert(0,str(r/'inplace'))
from freeze_build_step0 import inventory
selection=r/'inplace/s43-selection-full33-v1';sealed=json.loads((selection/'complete.json').read_text())
assert sealed['complete'] and inventory(selection/'shim')==sealed['shim_manifest']
sys.path.insert(0,str(selection/'shim'))
manifest=json.loads((w/'wave14-capture/capture/input-manifest.json').read_text())
work=next(x for x in manifest['workloads'] if x['name']=='richards_super')
shutil.copytree(work['cwd'],out/'input',ignore=shutil.ignore_patterns('__pycache__'))
pending=[];old=profiler.CallMonitor
class Monitor(old):
 def rows(self):return [x for x in super().rows() if x['qualname']=='HandlerTask.fn']
profiler.CallMonitor=Monitor
def capture(fn,inputs,calls,*args,**kwargs):
 pending.append((fn,inputs));return dict(status='skipped',reason='correctness-only compile probe')
profiler.test_candidate=capture
profiler.profile_script(out/'input'/Path(work['script']).name,work['args'],128,8,True)
assert len(pending)==1
from s46_ten_components import prepare_region
fn,inputs=pending[0];region=prepare_region(fn,inputs);first=next(p for p in region.programs.values() if p is not None)
report=dict(function=fn.__qualname__,first_program=first is not None,first_problem=region.problem,fresh_candidates=[],normal_calls=[],timing_eligible=False)
if first is not None:
 saved=[]
 for namespace,key,_ in first.global_objects:
  value=namespace.get(key)
  if any(value is v for v,_ in saved):continue
  state=profiler._global_state(value)
  if state is not None:saved.append((value,state))
 def reset():
  for v,state in saved:profiler._restore_global(v,state)
 for index,(arguments,expected,after) in enumerate(inputs):
  fresh=heap.lift_region(fn);p=fresh.program_for(tuple(profiler.fresh_copy(arguments)))
  report['fresh_candidates'].append(dict(index=index,available=p is not None,problem=fresh.problem))
  reset()
  if saved:
   reference=profiler.fresh_copy(arguments)
   try:expected=fn(*reference);after=reference
   finally:reset()
  given=profiler.fresh_copy(arguments);before=region.compiled_calls;got=region(*given)
  row=dict(index=index,compiled=region.compiled_calls-before,problem=region.problem,result_equal=profiler._same_result(got,expected),arguments_equal=profiler.same(given,after))
  report['normal_calls'].append(row);reset()
report['complete']=True
(out/'data.json').write_text(json.dumps(report,indent=2));print(json.dumps(report),flush=True)
