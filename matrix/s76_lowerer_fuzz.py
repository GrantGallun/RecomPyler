"""Bounded differential check of common generic/selected lowering; no admission."""
import json,random,time,types
from pathlib import Path
import psutil
from recompyler import heap,_source_frames_native as provider,_structure_ops_native
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import create_callable
from recompyler.ir.symbols import CPythonSymbols
from recompyler.ir.structure_lowerings import StructureCalls,select_structure_calls
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
rng=random.Random(76);entries=[]
for function in [heap._find,heap._Program.canon]:
 for selected in [False,True,'readonly']:
  graph=build(function);calls=None
  if selected:
   graph=select_structure_calls(graph,{'load_attr','contains','getitem'})
   calls=StructureCalls(CPythonSymbols(),_structure_ops_native)
  lowered=lower(graph,structure_calls=calls,readonly_loops=selected=='readonly')
  entry=create_callable(function,lowered.body_address,lowered.keepalive,runner_address=provider.addresses()['run_vectorcall'])
  entries.append((function,entry))
started=time.monotonic();count=0
while time.monotonic()-started<60:
 events=[];depth=rng.randrange(12);mode=rng.randrange(4)
 if mode==0:
  class Node:pass
 elif mode==1:
  class Node:
   __slots__=('parent',)
 elif mode==2:
  class Node:
   @property
   def parent(self):events.append('parent');return self._parent
 else:
  class Node:
   def __getattribute__(self,name):
    events.append(name);return object.__getattribute__(self,name)
 target=leaf=Node()
 def assign(node,value):
  if mode==2:node._parent=value
  else:node.parent=value
 for _ in range(depth):
  parent=Node();assign(target,parent);target=parent
 assign(target,None)
 keys=[type('Key'+str(i),(),{}) for i in range(depth+1)]
 alias=dict(zip(keys,keys[1:]));program=types.SimpleNamespace(alias=alias)
 for original,entry in entries:
  args=(leaf,) if original is heap._find else (program,keys[0])
  events.clear();expected=original(*args);expected_events=list(events)
  events.clear();actual=entry(*args)
  assert actual is expected,(depth,mode,original.__name__)
  assert events==expected_events,(depth,mode,events,expected_events)
  count+=1
output={'native_entries':count,'wrong':0,'unchecked':0,'bounded_seconds':60,'shapes':'depth0-11 plain/slots/property/custom-getattribute; class-key dictionaries','known_temporary_call_lifetime':'not covered; separate mandatory RED remains','public_admission':False}
Path('matrix/s76-readonly-fuzz-result.json').write_text(json.dumps(output,indent=2)+'\n');print(json.dumps(output),flush=True)
