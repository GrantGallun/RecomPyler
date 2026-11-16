"""Bounded differential checks for explicit original-loop CFG entry."""
import gc,json,random,runpy,sys,time,weakref
from pathlib import Path
import psutil
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
api=runpy.run_path('tests/test_ir_existing_frame.py')
source=api['resumed_traversal']
entry,lowered,status=api['frame_entry'](source,entry_offset=api['loop_header'](source))
rng=random.Random(1762);native=0;lifetime=0;errors=0
started=time.monotonic()
while time.monotonic()-started<60:
 events=[]
 class Marker:
  def __iadd__(self,value):events.append('prefix');return self
 marker=Marker();mode=rng.randrange(4);depth=rng.randrange(16)
 if mode==0:
  class Node:pass
 elif mode==1:
  class Node:__slots__=('parent',)
 elif mode==2:
  class Node:
   @property
   def parent(self):events.append('read');return self._parent
 else:
  class Node:
   def __getattribute__(self,name):events.append(name);return object.__getattribute__(self,name)
 def assign(node,value):setattr(node,'_parent' if mode==2 else 'parent',value)
 leaf=tail=Node()
 for _ in range(depth):
  node=Node();assign(tail,node);tail=node
 assign(tail,None)
 events.clear();expected=source(leaf,marker);expected_events=list(events)
 events.clear();marker+=1
 actual=entry(leaf,marker)
 assert actual is expected and events==expected_events
 native+=1
 if native%32==0:
  drops=[];references=[]
  class Root:
   @property
   def parent(self):drops.append('root');return None
  root=Root()
  class Leaf:
   def __init__(self):references.append(weakref.ref(self,lambda _:drops.append('drop')))
   @property
   def parent(self):drops.append('leaf');return root
  result=entry(Leaf(),marker)
  assert result is root and drops==['leaf','leaf','drop','root'] and references[0]() is None
  assert status.value==1
  native+=1;lifetime+=1
 if native%127==0:
  class Broken:
   @property
   def parent(self):raise LookupError('resumed error')
  try:entry(Broken(),marker)
  except LookupError as error:
   trace=error.__traceback__
   while trace and trace.tb_frame.f_code is not source.__code__:trace=trace.tb_next
   assert trace is not None
  else:raise AssertionError('missing original error')
  native+=1;errors+=1
 if native%512==0:gc.collect()
result={'native_entries':native,'temporary_lifetime_cases':lifetime,'error_cases':errors,'wrong':0,'unchecked':0,'bounded_seconds':60,'entry_offset':lowered.entry_offset,'ir_admission':0}
Path('matrix/s76-frame-resume-fuzz-result.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result),flush=True)
