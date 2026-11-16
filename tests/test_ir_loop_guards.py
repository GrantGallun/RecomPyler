"""Loop metadata is guarded once, with current-state exits and pending polls."""
import ctypes,dis,sys
from recompyler import _structure_ops_native as provider,_source_frames_native as frames
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.symbols import CPythonSymbols
from recompyler.ir.structure_lowerings import StructureCalls,specialize_structure_calls
from test_ir_existing_frame import frame_entry


def walk(value):
    while value.next is not None:value=value.next
    return value


def warmed():
    class Node:pass
    leaf=Node();root=Node();leaf.next=root;root.next=None
    for _ in range(2000):walk(leaf)
    graph=specialize_structure_calls(build(walk),immediate_offsets=True)
    return Node,leaf,root,graph


def prepared(graph,calls=None):
    calls=calls or StructureCalls(CPythonSymbols(),provider)
    return frame_entry(walk,graph=graph,structure_calls=calls,lowering_options={'owned_readonly_loops':True})


def test_type_version_is_hoisted_and_polling_loop_needs_no_chunk_counter():
    _,leaf,root,graph=warmed();native,body,_=prepared(graph)
    assert native(leaf) is root
    instructions=[instruction for block in body.module.get_global('body').blocks for instruction in block.instructions]
    assert sum(instruction.name=='readonly_attr_type_version' for instruction in instructions)==1
    assert not any(instruction.opname=='phi' and instruction.name=='chunk' for instruction in instructions)
    assert 'loop_attribute_storage' in str(body.module)


def test_late_type_miss_publishes_current_original_local():
    Node,leaf,_,graph=warmed();seen=[]
    class Observed:
        @property
        def next(self):
            frame=sys._getframe(1);seen.append((frame.f_code is walk.__code__,frame.f_locals['value'] is self));return None
    tail=Observed();leaf.next=tail
    native,_,_=prepared(graph)
    assert native(leaf) is tail and seen==[(True,True)]


def test_type_mutation_between_entries_uses_the_original_descriptor():
    Node,leaf,root,graph=warmed();native,_,_=prepared(graph)
    assert native(leaf) is root
    seen=[]
    def observed(self):
        frame=sys._getframe(1);seen.append((frame.f_code is walk.__code__,frame.f_locals['value'] is self));return None
    Node.next=property(observed)
    assert native(leaf) is leaf and seen==[(True,True)]


def test_pending_work_leaves_the_hoisted_interval_before_source_local_changes():
    from llvmlite import ir
    Node,leaf,root,graph=warmed();replacement=Node();replacement.next=None;seen=[]
    @ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.c_void_p)
    def pending(unused):
        frame=sys._getframe(1);seen.append((frame.f_code is walk.__code__,frame.f_locals.get('value') is root,frame.f_lasti))
        frame.f_locals['value']=replacement
        return 0
    class QueueOnHoisted(StructureCalls):
        def try_load_attr_loop(self,builder,owner,context):
            result=super().try_load_attr_loop(builder,owner,context)
            p=ir.IntType(8).as_pointer();word=ir.IntType(64)
            with builder.if_then(builder.icmp_unsigned('==',owner,ir.Constant(word,id(leaf)).inttoptr(p))):
                callback=ir.Constant(word,ctypes.cast(pending,ctypes.c_void_p).value).inttoptr(p)
                self.capi(builder,'Py_AddPendingCall',ir.IntType(32),[callback,ir.Constant(p,None)])
            return result
    native,_,_=prepared(graph,QueueOnHoisted(CPythonSymbols(),provider))
    assert native(leaf) is replacement
    backward=next(op.offset for op in dis.get_instructions(walk) if op.opname=='JUMP_BACKWARD')
    assert seen==[(True,True,backward)] and frames.active_depth()==0
