"""Frameless loop bodies use saved vectorcall and caller-supplied cold reification."""
import ctypes,dis
import pytest
from llvmlite import ir,binding
from recompyler import _structure_ops_native as provider,_source_frames_native as frames
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.structure_lowerings import StructureCalls,specialize_structure_calls
from recompyler.ir.symbols import CPythonSymbols
from recompyler.ir.entry import create_callable
from recompyler.ir.builder import UnsupportedBytecode


def walk(value):
    while value.next is not None:value=value.next
    return value


def graph():
    class Node:pass
    leaf=Node();root=Node();leaf.next=root;root.next=None
    for _ in range(2000):walk(leaf)
    return leaf,root,specialize_structure_calls(build(walk),immediate_offsets=True)


def cold_saved(builder,**state):
    # Test adapter only: production admission supplies canonical reify/resume,
    # including pending-work cause PC and original argument ownership.
    p=ir.IntType(8).as_pointer();word=ir.IntType(64)
    signature=ir.FunctionType(p,[p,p.as_pointer(),word,p])
    target=builder.bitcast(state['saved_vectorcall'],signature.as_pointer())
    builder.ret(builder.call(target,[state['original'],state['fallback_args'],ir.Constant(word,state['code'].co_argcount),ir.Constant(p,None)]))


def body_for(selected,emitter=cold_saved):
    return lower(selected,structure_calls=StructureCalls(CPythonSymbols(),provider),frameless=True,frameless_deopt=emitter)


def test_frameless_loop_requires_a_cold_source_frame_emitter():
    _,_,selected=graph()
    with pytest.raises(UnsupportedBytecode,match='cold.*deopt'):
        lower(selected,structure_calls=StructureCalls(CPythonSymbols(),provider),frameless=True)


def test_five_argument_body_has_ssa_loop_and_no_hot_frame_or_stackrefs():
    _,_,selected=graph();states=[]
    def emit(builder,**state):states.append(state);return cold_saved(builder,**state)
    body=body_for(selected,emit);function=body.module.get_global('body');text=str(body.module)
    assert body.abi=='frameless' and body.execution_owner.abi=='frameless' and len(function.args)==5
    assert 'readonly_loop' in text and 'rc_ir_frame_enter' not in text
    assert 'PyObject_Vectorcall' not in text and 'word_close' not in text
    backward=next(op.offset for op in dis.get_instructions(walk) if op.opname=='JUMP_BACKWARD')
    assert any(state['cause_offset']==backward and state['next_offset']>0 for state in states)
    assert all(len(state['localsplus'])==walk.__code__.co_nlocals for state in states)


def callable_for(body):
    p=ir.IntType(8).as_pointer();word=ir.IntType(64);module=ir.Module()
    signature=ir.FunctionType(p,[p,p.as_pointer(),word,p]);extended=ir.FunctionType(p,list(signature.args)+[p])
    function=ir.Function(module,signature,'test_adapter');builder=ir.IRBuilder(function.append_basic_block('entry'))
    get_saved=ctypes.pythonapi.PyVectorcall_Function;get_saved.argtypes=[ctypes.py_object];get_saved.restype=ctypes.c_void_p
    saved=ir.Constant(word,get_saved(walk)).inttoptr(p)
    target=builder.inttoptr(ir.Constant(word,body.body_address),extended.as_pointer());builder.ret(builder.call(target,list(function.args)+[saved]))
    engine=binding.create_mcjit_compiler(binding.parse_assembly(str(module)),binding.Target.from_default_triple().create_target_machine());engine.finalize_object()
    return create_callable(walk,engine.get_function_address('test_adapter'),(body.execution_owner,engine),runner_address=frames.addresses()['run_vectorcall'])


def test_five_argument_body_preserves_original_saved_binding_and_late_guard_locals():
    leaf,root,selected=graph();native=callable_for(body_for(selected))
    assert native(leaf) is root and native(value=leaf) is root
    with pytest.raises(TypeError):native(leaf,None)
    seen=[]
    class Observed:
        @property
        def next(self):
            import sys
            frame=sys._getframe(1);seen.append((frame.f_code is walk.__code__,frame.f_locals['value'] is self));return None
    tail=Observed();leaf.next=tail
    assert native(leaf) is tail and seen==[(True,True)]


def test_frameless_declines_nonloop_graph_and_conflicting_frame_mode():
    def identity(value):return value
    with pytest.raises(UnsupportedBytecode,match='readonly|traversal'):
        lower(build(identity),frameless=True,frameless_deopt=cold_saved)
    _,_,selected=graph()
    with pytest.raises(UnsupportedBytecode,match='frame'):
        lower(selected,frameless=True,frame_entry=True,frameless_deopt=cold_saved)


def test_frameless_mortal_return_owns_exactly_the_result_lifetime():
    import gc,weakref
    leaf,root,selected=graph();reference=weakref.ref(root)
    native=callable_for(body_for(selected));result=native(leaf)
    assert result is root
    del leaf,root;gc.collect()
    assert reference() is result
    del result;gc.collect()
    assert reference() is None
