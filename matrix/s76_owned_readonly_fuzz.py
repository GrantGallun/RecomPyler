"""Bounded existing-frame exact-value/effect/lifetime differential checks."""
import gc,json,random,runpy,sys,time,types,weakref
from pathlib import Path
import psutil
from recompyler import heap
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
api=runpy.run_path('tests/test_ir_existing_frame.py')
from recompyler import _structure_ops_native as structure_provider
from recompyler.ir.structure_lowerings import StructureCalls
from recompyler.ir.symbols import CPythonSymbols
original_frame_entry=api['frame_entry']
def owned_frame_entry(function):
 calls=StructureCalls(CPythonSymbols(),structure_provider)
 return original_frame_entry(function,lowering_options={'structure_calls':calls,'owned_readonly_loops':True})
api['frame_entry']=owned_frame_entry
find,_,find_status=api['frame_entry'](heap._find)
canon,_,canon_status=api['frame_entry'](heap._Program.canon)
release,_,release_status=api['frame_entry'](api['release_owner'])
rng=random.Random(176);count=0;lifetime_count=0

def temporary_events(call):
 events=[];references=[]
 class Root:
  @property
  def parent(self):events.append('root-read');return None
 root=Root()
 class Leaf:
  def __init__(self):references.append(weakref.ref(self,lambda _:events.append('drop')))
  @property
  def parent(self):events.append('leaf-read');return root
 result=call(Leaf())
 assert result is root and references[0]() is None
 events.append('returned');return events

started=time.monotonic()
while time.monotonic()-started<60:
 events=[];depth=rng.randrange(12);mode=rng.randrange(4)
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
 events.clear();expected=heap._find(leaf);expected_events=list(events)
 events.clear();actual=find(leaf)
 assert actual is expected and events==expected_events
 count+=1
 keys=[type('Key'+str(i),(),{}) for i in range(depth+1)]
 owner=types.SimpleNamespace(alias=dict(zip(keys,keys[1:])))
 assert canon(owner,keys[0]) is heap._Program.canon(owner,keys[0]);count+=1
 if count%64==0:
  assert temporary_events(find)==temporary_events(heap._find)==['leaf-read','leaf-read','drop','root-read','returned']
  assert find_status.value==1;lifetime_count+=1
  dropped=[]
  class Owner:
   def __del__(self):dropped.append('drop')
  result=release(Owner());dropped.append('returned')
  assert result is None and dropped==['drop','returned'] and release_status.value==1
  count+=2
 if count%512==0:gc.collect()
result={'native_entries':count,'temporary_lifetime_cases':lifetime_count,'wrong':0,'unchecked':0,'bounded_seconds':60,'abi':'owned-frame anchored shared traversal; no executor installation','ir_admission':0}
Path('matrix/s76-owned-readonly-fuzz-result.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)
