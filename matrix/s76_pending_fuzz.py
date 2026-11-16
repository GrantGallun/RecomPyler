"""Bounded native pending-call frame, PC, local-write and interrupt checks."""
import ctypes,json,random,runpy,sys,time
from pathlib import Path
import psutil
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
api=runpy.run_path('tests/test_ir_existing_frame.py');frames=api['frames'];source=api['resumed_traversal']
backward=next(op.offset for op in api['dis'].get_instructions(source) if op.opname=='JUMP_BACKWARD')
context={};seen=[]
@ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.c_void_p)
def callback(unused):
 frame=sys._getframe(1)
 seen.append((frames.active_depth(),frame.f_code is source.__code__,frame.f_lasti,frame.f_locals.get('cell') is context['expected_cell']))
 if frame.f_code is source.__code__:frame.f_locals['cell']=context['replacement']
 return 0
entry,_,status=api['frame_entry'](source,entry_offset=api['loop_header'](source),pending_callback=callback)
from recompyler import heap
interrupt,_,_=api['frame_entry'](heap._find,interrupt=True)
rng=random.Random(1763);native=0;interrupts=0
class Node:pass
started=time.monotonic()
while time.monotonic()-started<60:
 nodes=[Node() for _ in range(rng.randrange(2,18))]
 for left,right in zip(nodes,nodes[1:]):left.parent=right
 nodes[-1].parent=None
 context.update(expected_cell=nodes[1],replacement=rng.choice(nodes))
 seen.clear();result=entry(nodes[0],0)
 assert result is nodes[-1] and seen==[(1,True,backward,True)]
 assert frames.active_depth()==0
 native+=1
 if native%64==0:
  try:interrupt(nodes[-1])
  except KeyboardInterrupt as error:
   trace=error.__traceback__
   while trace and trace.tb_frame.f_code is not heap._find.__code__:trace=trace.tb_next
   assert trace is not None and trace.tb_lasti==0
  else:raise AssertionError('interrupt lost')
  assert frames.active_depth()==0
  native+=1;interrupts+=1
result={'native_entries':native,'interrupt_cases':interrupts,'wrong':0,'unchecked':0,'bounded_seconds':60,'pending_callback_source_pc':backward,'ir_admission':0}
Path('matrix/s76-pending-fuzz-result.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result),flush=True)
