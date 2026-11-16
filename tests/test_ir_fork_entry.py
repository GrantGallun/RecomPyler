"""Fork-only backend consumes canonical LLVM real-frame bodies."""
import ctypes
import gc
import inspect
import sys
from types import FunctionType
import weakref
import pytest

if not getattr(ctypes.pythonapi, 'PyUnstable_RPCode_SetNative', None):
    pytest.skip('requires the RecomPyler CPython fork native-frame API', allow_module_level=True)
if sys._jit.is_enabled():
    pytest.skip('fork native-frame backend requires CPython JIT disabled', allow_module_level=True)

from recompyler.ir.fork_entry import install_function, prepare_function, stats


@pytest.fixture
def install():
    handles=[]
    def enter(fn, **options):
        handle=install_function(fn, **options)
        handles.append(handle)
        return handle
    yield enter
    for handle in handles:handle.close()


def test_prepare_never_executes_source_and_original_function_enters_native(install):
    effects=[]
    def target(value, *, option=2):
        effects.append(value)
        return value+option
    code=target.__code__
    prepared=prepare_function(target)
    assert not effects and prepared.entry_count>=1
    handle=install(target,count=True)
    assert target(3,option=4)==7 and effects==[3]
    assert target.__code__ is code
    assert stats(handle)['start']==1 and stats(handle)['return']==1
    assert str(inspect.signature(target))=='(value, *, option=2)'


def test_all_generator_resumes_and_yields_are_native_on_real_frame(install):
    effects=[]
    def exchange(value):
        effects.append('start')
        sent=yield value
        effects.append(sent)
        yield sent
    code=exchange.__code__
    handle=install(exchange,count=True)
    gen=exchange(7)
    assert inspect.isgenerator(gen) and gen.gi_code is code
    assert next(gen)==7 and effects==['start']
    assert gen.gi_frame.f_locals['value']==7
    assert gen.send(9)==9 and effects==['start',9]
    assert gen.gi_frame.f_locals['sent']==9
    with pytest.raises(StopIteration):next(gen)
    assert gen.gi_frame is None
    measured=stats(handle)
    assert measured['yield']==2 and measured['resume']>=2
    assert measured['return']==1


def test_sent_finalizer_matches_cpython_send_argument_lifetime(install):
    events=[]
    def producer():
        yield 0
        events.append('after-pop')
        yield 1
    class Sent:
        def __del__(self):events.append('dead')
    handle=install(producer,count=True)
    gen=producer();assert next(gen)==0
    assert gen.send(Sent())==1
    assert events==['after-pop','dead'] and stats(handle)['yield']==2
    gen.close()


def test_throw_close_and_saved_traceback_keep_original_source(install):
    events=[]
    def producer():
        try:
            yield 1
            yield 2
        finally:
            events.append('finally')
    install(producer,count=True)
    gen=producer();assert next(gen)==1
    error=LookupError('stop')
    with pytest.raises(LookupError) as caught:gen.throw(error)
    assert caught.value is error and events==['finally']
    tb=error.__traceback__
    while tb and tb.tb_frame.f_code is not producer.__code__:tb=tb.tb_next
    assert tb and tb.tb_lineno==producer.__code__.co_firstlineno+2
    gen=producer();next(gen);gen.close()
    assert events==['finally','finally']


def test_shared_code_different_function_globals_declines_exactly(install):
    def template():return token
    first=FunctionType(template.__code__,{'token':object()})
    second=FunctionType(template.__code__,{'token':object()})
    handle=install(first,count=True)
    assert first() is first.__globals__['token']
    before=stats(handle)['calls']
    assert second() is second.__globals__['token']
    assert stats(handle)['calls']==before and stats(handle)['decline']>=1


def test_prepared_and_installed_owners_do_not_pin_source_code(install):
    def identity(value):return value
    fn=FunctionType(identity.__code__.replace(),{})
    code_ref=weakref.ref(fn.__code__);fn_ref=weakref.ref(fn)
    prepared=prepare_function(fn)
    handle=install(fn,count=True)
    assert fn(9)==9
    del fn
    assert fn_ref() is None and code_ref() is None
    assert not handle.active
    with pytest.raises(ReferenceError):prepared.install()


def test_code_change_and_close_return_to_original_interpreter(install):
    def target(value):return value+1
    def replacement(value):return value*3
    handle=install(target,count=True)
    assert target(2)==3
    target.__code__=replacement.__code__
    assert target(2)==6
    handle.close()
    assert not handle.active and target(4)==12


def test_closing_handle_inside_llvm_callback_keeps_executable_alive(install):
    def target(action):return action()
    handle=install(target,count=True)
    effects=[]
    def action():
        handle.close()
        gc.collect()
        effects.append('once')
        return 23
    assert target(action)==23 and effects==['once'] and not handle.active


def test_trace_enabled_inside_body_hands_off_before_return(install):
    events=[]
    def target(action):
        action()
        marker=7
        return marker
    install(target,count=True)
    def trace(frame,event,arg):
        if frame.f_code is target.__code__:events.append(event)
        return trace
    def enable():
        sys.settrace(trace)
        sys._getframe(1).f_trace=trace
    try:assert target(enable)==7
    finally:sys.settrace(None)
    assert 'return' in events


def test_osr_enters_from_backedge_without_replaying_effect_prefix(install):
    effects=[]
    def target(n):
        effects.append('prefix')
        i=0
        while i<n:
            effects.append(i)
            i+=1
        return i
    handle=install(target,count=True,include_osr=True,start=False)
    assert target(4)==4 and effects==['prefix',0,1,2,3]
    measured=stats(handle)
    assert measured['start']==0 and measured['backedge']>=1
    assert measured['return']==1


def test_delegation_keeps_real_yieldfrom_send_and_return(install):
    def child():
        sent=yield 3
        return sent
    def parent():
        value=yield from child()
        yield value
    handle=install(parent,count=True)
    gen=parent();assert next(gen)==3
    assert inspect.isgenerator(gen.gi_yieldfrom)
    assert gen.send(8)==8
    assert gen.gi_yieldfrom is None
    with pytest.raises(StopIteration):next(gen)
    assert stats(handle)['calls']>=1


def test_counters_are_disabled_by_default(install):
    def target(value):return value
    handle=install(target)
    assert target(7)==7
    assert all(v==0 for v in stats(handle).values())


def test_native_error_uses_original_pc_and_traceback_owns_argument(install):
    class Token:pass
    def target(token, divisor):
        return 10 // divisor
    handle=install(target,count=True)
    token=Token();ref=weakref.ref(token)
    try:target(token,0)
    except ZeroDivisionError as error:
        saved=error.__traceback__
    else:pytest.fail('native division did not raise')
    del token
    tb=saved
    while tb and tb.tb_frame.f_code is not target.__code__:tb=tb.tb_next
    assert tb and tb.tb_lineno==target.__code__.co_firstlineno+1
    assert tb.tb_frame.f_locals['token'] is ref() and ref() is not None
    assert stats(handle)['calls']==1
    import traceback
    traceback.clear_frames(saved)
    del tb,saved
    assert ref() is None


def test_changed_source_cannot_install_a_prepared_old_body():
    def target(value):return value+1
    def replacement(value):return value*3
    code=target.__code__
    prepared=prepare_function(target)
    target.__code__=replacement.__code__
    with pytest.raises(ValueError,match='unchanged'):
        prepared.install()
    import _testinternalcapi
    assert _testinternalcapi.rp_native_layout(code)[-1]==0
    assert target(5)==15


def test_monitoring_enabled_inside_native_body_observes_original_yield(install):
    mon=sys.monitoring;tool=5;seen=[]
    if mon.get_tool(tool) is not None:pytest.skip('monitoring tool 5 already in use')
    def enable():mon.set_local_events(tool,producer.__code__,mon.events.PY_YIELD)
    def producer():
        enable()
        yield 7
    def run():
        mon.use_tool_id(tool,'fork-adapter-test')
        mon.register_callback(tool,mon.events.PY_YIELD,lambda code,offset,value:seen.append((offset,value)))
        try:return list(producer())
        finally:
            mon.set_local_events(tool,producer.__code__,0)
            mon.register_callback(tool,mon.events.PY_YIELD,None)
            mon.free_tool_id(tool)
    assert run()==[7]
    expected=seen[:];seen.clear()
    install(producer,count=True)
    assert run()==[7] and seen==expected and len(seen)==1


def test_null_observer_address_is_rejected_before_installation():
    from recompyler.ir import _fork_entry_native
    from recompyler import _source_frames_native as frames
    def target(value):return value
    prepared=prepare_function(target)
    with pytest.raises(ValueError,match='observer'):
        _fork_entry_native.install(target,target.__code__,prepared.entries,0,frames,False)
    import _testinternalcapi
    assert _testinternalcapi.rp_native_layout(target.__code__)[-1]==0
