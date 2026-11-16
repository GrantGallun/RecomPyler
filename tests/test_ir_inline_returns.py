"""M2 inlines only callback-free local return paths, with canonical fallback."""
import ctypes,types
import pytest
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from test_ir_existing_frame import frame_entry

def checked_loop(count,condition,message):
    def check(condition,message):
        if not condition:raise ValueError(message)
    for _ in range(count):check(condition,message)
    return message

def identity_loop(count,value):
    def identity(value):return value
    for _ in range(count):value=identity(value)
    return value

def local_code(function,name):
    return next(c for c in function.__code__.co_consts if type(c) is types.CodeType and c.co_name==name)

def test_real_verifier_require_has_a_pure_true_return_path():
    from recompyler.ir.inline_returns import return_paths
    from recompyler.ir.verifier import verify
    paths=return_paths(local_code(verify,'require'))
    assert len(paths)==1
    assert paths[0].conditions==((0,True),) and paths[0].result==('constant',None)

def test_raising_branch_and_suspending_scopes_are_not_inlined():
    from recompyler.ir.inline_returns import return_paths
    def outer():
        def always_raise(value):raise ValueError(value)
        def generator(value):yield value
        return always_raise,generator
    assert not return_paths(local_code(outer,'always_raise'))
    assert not return_paths(local_code(outer,'generator'))

def test_inline_true_path_executes_and_false_path_retains_original_exception():
    counter=ctypes.c_uint64()
    native,lowered,_=frame_entry(checked_loop,lowering_options=dict(inline_returns=True,inline_counter_address=ctypes.addressof(counter)))
    assert native(7,True,'answer')=='answer' and counter.value==7
    with pytest.raises(ValueError,match='bad'):native(1,False,'bad')
    assert counter.value==7

def test_custom_truth_and_retirement_stay_on_original_child_frame():
    import sys
    events=[]
    class Truth:
        def __bool__(self):events.append(sys._getframe(1).f_code.co_name);return True
    counter=ctypes.c_uint64()
    native,_,_=frame_entry(checked_loop,lowering_options=dict(inline_returns=True,inline_counter_address=ctypes.addressof(counter)))
    marker=object()
    assert native(2,Truth(),marker) is marker
    assert events==['check','check'] and counter.value==0

def test_inlined_identity_returns_original_inert_value():
    counter=ctypes.c_uint64()
    native,_,_=frame_entry(identity_loop,lowering_options=dict(inline_returns=True,inline_counter_address=ctypes.addressof(counter)))
    value='a string made at runtime '+str(id(counter))
    assert native(3,value) is value and counter.value==3


def test_real_verifier_body_inlines_calls_and_keeps_original_errors():
    # The stock optimizer refuses this helper's root seed (known S82 family).
    # Invoke the unchanged original source body through the same existing-frame
    # ABI; this is a measured component, never public installation evidence.
    from recompyler.ir.verifier import verify,VerificationError
    counter=ctypes.c_uint64();graph=build(identity_loop)
    assert verify(graph) is None
    native,_,_=frame_entry(verify,allow_protected=True,
        lowering_options=dict(inline_returns=True,inline_counter_address=ctypes.addressof(counter)))
    assert native(graph) is None and counter.value>20
    graph.entry=-1
    with pytest.raises(VerificationError,match='missing entry block'):native(graph)


def replaced_loop(condition,message,replace):
    def check(condition,message):
        if not condition:raise ValueError(message)
    check=replace(check)
    check(condition,message)
    return message

def test_rebound_local_function_uses_original_call_and_new_code():
    events=[];counter=ctypes.c_uint64()
    def replace(original):
        def changed(condition,message):events.append(message);return None
        return changed
    native,_,_=frame_entry(replaced_loop,lowering_options=dict(inline_returns=True,inline_counter_address=ctypes.addressof(counter)))
    assert native(True,'changed',replace)=='changed' and events==['changed'] and counter.value==0

def test_finalizing_message_remains_in_the_original_child_frame():
    import sys
    events=[];counter=ctypes.c_uint64()
    class Message:
        def __del__(self):events.append(sys._getframe(1).f_code.co_name)
    native,_,_=frame_entry(checked_loop,lowering_options=dict(inline_returns=True,inline_counter_address=ctypes.addressof(counter)))
    result=native(1,True,Message())
    assert counter.value==0 and events==[]
    del result
    assert len(events)==1


def test_profile_observer_keeps_original_local_call_events():
    import sys
    counter=ctypes.c_uint64();events=[]
    native,_,_=frame_entry(checked_loop,lowering_options=dict(inline_returns=True,inline_counter_address=ctypes.addressof(counter)))
    code=local_code(checked_loop,'check')
    def profile(frame,event,arg):
        if frame.f_code is code:events.append(event)
    sys.setprofile(profile)
    try:assert native(3,True,'value')=='value'
    finally:sys.setprofile(None)
    assert events==['call','return']*3 and counter.value==0

def test_unused_finalizing_argument_keeps_cpython_retirement_order():
    import sys
    events=[];counter=ctypes.c_uint64()
    def outer(make):
        def discard(value):return None
        discard(make())
    class Message:
        def __del__(self):events.append(sys._getframe(1).f_code.co_name)
    outer(Message);expected=events.copy();events.clear()
    native,_,_=frame_entry(outer,lowering_options=dict(inline_returns=True,inline_counter_address=ctypes.addressof(counter)))
    assert native(Message) is None
    assert events==expected and counter.value==0
