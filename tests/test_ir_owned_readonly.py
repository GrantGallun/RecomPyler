"""Borrowed traversal on owned frames requires a stable source-lifetime anchor."""
import ctypes,dis,sys,weakref
import pytest
from recompyler import heap,_structure_ops_native as provider
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.symbols import CPythonSymbols
from recompyler.ir.structure_lowerings import StructureCalls
from test_ir_existing_frame import frame_entry


def owned(function,**kwargs):
 calls=StructureCalls(CPythonSymbols(),provider)
 return frame_entry(function,lowering_options={'structure_calls':calls,'owned_readonly_loops':True},**kwargs)


def test_owned_frame_fast_loop_has_explicit_anchor_and_same_generic_cold_cfg():
 entry,lowered,status=owned(heap._find)
 class Node:pass
 leaf=Node();middle=Node();root=Node()
 leaf.parent=middle;middle.parent=root;root.parent=None
 assert entry(leaf) is root
 text=str(lowered.native_module)
 assert 'readonly_loop' in text and 'owned_readonly_anchor' in text
 assert 'readonly_original_current_state' not in text
 assert 'PyObject_Vectorcall' not in text


def test_unanchored_temporary_uses_generic_original_lifetime_order():
 entry,lowered,status=owned(heap._find)
 def observe(call):
  events=[];references=[]
  class Root:
   @property
   def parent(self):events.append('root-read');return None
  root=Root()
  class Leaf:
   def __init__(self):self.parent=root;references.append(weakref.ref(self,lambda _:events.append('weakref')))
   def __del__(self):
    frame=sys._getframe(1)
    events.append(('drop',frame.f_code is heap._find.__code__,frame.f_locals.get('cell') is root))
  result=call(Leaf());events.append('returned')
  assert result is root and references[0]() is None
  return events
 assert observe(entry)==observe(heap._find)==[('drop',True,True),'weakref','root-read','returned']
 assert status.value==1


def test_owned_guard_miss_publishes_current_local_before_property_and_retained_frame():
 entry,lowered,status=owned(heap._find);seen=[]
 class Root:
  @property
  def parent(self):
   current=sys._getframe(1);seen.append((current,current.f_locals['cell'] is self))
   return None
 class Node:pass
 root=Root();middle=Node();leaf=Node();middle.parent=root;leaf.parent=middle
 assert entry(leaf) is root
 assert len(seen)==1 and seen[0][1]
 frame=seen[0][0]
 assert frame.f_code is heap._find.__code__ and frame.f_locals['cell'] is root
 assert frame.f_lasti==next(op.offset for op in dis.get_instructions(heap._find) if op.opname=='RETURN_VALUE')


def test_owned_mapping_uses_dictionary_anchor_and_keeps_current_error_local():
 entry,lowered,status=owned(heap._Program.canon)
 class First:pass
 class Last:pass
 class Program:pass
 owner=Program();owner.alias={First:Last}
 assert entry(owner,First) is Last
 owner.alias={First:[]}
 with pytest.raises(TypeError) as caught:entry(owner,First)
 trace=caught.value.__traceback__
 while trace and trace.tb_frame.f_code is not heap._Program.canon.__code__:trace=trace.tb_next
 assert trace is not None and trace.tb_frame.f_locals['root'] is owner.alias[First]
 assert trace.tb_lasti==next(op.offset for op in dis.get_instructions(heap._Program.canon) if op.opname=='CONTAINS_OP')


def test_owned_mapping_foreign_collision_keeps_both_original_lookup_effects():
 entry,lowered,status=owned(heap._Program.canon);events=[]
 class First:pass
 class Last:pass
 class Noise:
  def __hash__(self):return hash(First)
  def __eq__(self,other):events.append(other);return False
 class Program:pass
 owner=Program();owner.alias={Noise():None,First:Last}
 events.clear();expected=heap._Program.canon(owner,First);reference=list(events)
 events.clear();assert entry(owner,First) is expected
 assert events==reference


def test_owned_traversal_does_not_keep_borrowed_state_over_pending_work():
 seen=[]
 @ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.c_void_p)
 def pending(unused):
  frame=sys._getframe(1);seen.append(frame.f_code is heap._find.__code__)
  frame.f_locals['cell']=replacement
  return 0
 class Node:pass
 leaf=Node();root=Node();replacement=Node();leaf.parent=root;root.parent=replacement.parent=None
 entry,lowered,status=owned(heap._find,pending_callback=pending)
 assert entry(leaf) is replacement and seen==[True]


def test_owned_traversal_chunk_returns_to_same_generic_frame_without_replaying_entry():
 entry,lowered,status=owned(heap._find)
 class Node:pass
 nodes=[Node() for _ in range(300)]
 for left,right in zip(nodes,nodes[1:]):left.parent=right
 nodes[-1].parent=None
 assert entry(nodes[0]) is nodes[-1]


def test_owned_traversal_flag_requires_existing_frame():
 from recompyler.ir.builder import UnsupportedBytecode
 with pytest.raises(UnsupportedBytecode,match='existing.frame|frame ABI'):
  lower(build(heap._find),owned_readonly_loops=True)


@pytest.mark.parametrize('mapping',[False,True])
def test_pending_work_arriving_inside_borrowed_loop_materializes_and_reloads(mapping):
 from llvmlite import ir
 from recompyler import _source_frames_native as frames
 seen=[]
 if mapping:
  function=heap._Program.canon
  class First:pass
  class Last:pass
  class Replacement:pass
  class Program:pass
  owner=Program();owner.alias={First:Last}
  arguments=(owner,First);initial_owner=owner;current=Last;replacement=Replacement;slot='root'
 else:
  function=heap._find
  class Node:pass
  leaf=Node();root=Node();replacement=Node();leaf.parent=root;root.parent=replacement.parent=None
  arguments=(leaf,);initial_owner=leaf;current=root;slot='cell'
 @ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.c_void_p)
 def pending(unused):
  frame=sys._getframe(1)
  seen.append((frames.active_depth(),frame.f_code is function.__code__,frame.f_lasti,frame.f_locals.get(slot) is current))
  if frame.f_code is function.__code__:frame.f_locals[slot]=replacement
  return 0
 class QueueOnGuard(StructureCalls):
  def try_load_attr(self,builder,owner,name):
   result=super().try_load_attr(builder,owner,name)
   pointer=ir.IntType(8).as_pointer();number=ir.IntType(64)
   target=ir.Constant(number,id(initial_owner)).inttoptr(pointer)
   with builder.if_then(builder.icmp_unsigned('==',owner,target)):
    callback=ir.Constant(number,ctypes.cast(pending,ctypes.c_void_p).value).inttoptr(pointer)
    self.capi(builder,'Py_AddPendingCall',ir.IntType(32),[callback,ir.Constant(pointer,None)])
   return result
 calls=QueueOnGuard(CPythonSymbols(),provider)
 entry,lowered,status=frame_entry(function,lowering_options={'structure_calls':calls,'owned_readonly_loops':True})
 assert entry(*arguments) is replacement
 backward=next(op.offset for op in dis.get_instructions(function) if op.opname=='JUMP_BACKWARD')
 assert seen==[(1,True,backward,True)]
 assert frames.active_depth()==0
