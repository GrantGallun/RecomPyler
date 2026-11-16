"""Real original child frames use canonical binding and the shared SSA body."""
import ctypes,dis,gc,sys,weakref
import pytest
from test_ir_existing_frame import frame_entry


def invoke(function,value):return function(value)
def invoke_keyword(function,value):return function(flag=value)
def invoke_temporary(function,make):return function(make())


def with_child(parent,function):
    from dataclasses import replace
    from recompyler.ir.native_calls import prepare_native_child
    from frame_install_cases import Keepalive
    candidate=prepare_native_child(function.__code__)
    assert candidate is not None and candidate.code is function.__code__
    # Only the diagnostic body has a counter; the default candidate does not.
    from recompyler.ir.builder import build_code
    from recompyler.ir.lower_llvm import lower
    counted=Keepalive(lower(build_code(function.__code__),frame_entry=True))
    candidate=replace(candidate,body_address=counted.address,owner=(candidate.owner,counted))
    sites={i.offset:candidate for i in dis.get_instructions(parent) if i.opname in ('CALL','CALL_KW')}
    entry,lowered,_=frame_entry(parent,lowering_options={'native_calls':sites})
    return entry,counted,lowered,candidate


def test_original_compiler_nested_helper_gets_a_real_native_child():
    from recompyler.ir.verifier import verify
    from recompyler.ir.native_calls import prepare_native_child
    import types
    code=next(c for c in verify.__code__.co_consts if type(c) is types.CodeType and c.co_name=='require')
    candidate=prepare_native_child(code)
    assert candidate.code is code and candidate.body_address>0
    def child(value):return value
    entry,counted,lowered,_=with_child(invoke,child)
    marker=object();assert entry(child,marker) is marker and counted.calls.value==1
    assert 'rc_ir_frame_call_native_owned' in str(lowered.native_module)


def test_original_live_cells_and_cpp_keyword_defaults_are_used():
    def factory(value):
        def child(*,flag=False):return value,flag
        return child
    marker=object();replacement=object();child=factory(marker)
    entry,counted,_,_=with_child(invoke_keyword,child)
    assert entry(child,True)==(marker,True) and counted.calls.value==1
    child.__closure__[0].cell_contents=replacement
    assert entry(child,False)==(replacement,False) and counted.calls.value==2


def test_rebound_code_and_foreign_callable_keep_original_call():
    def child(value):return value
    def replacement(value):return 'changed'
    entry,counted,_,_=with_child(invoke,child)
    child.__code__=replacement.__code__
    assert entry(child,1)=='changed' and counted.calls.value==0
    class Callable:
        def __call__(self,value):return value+2
    assert entry(Callable(),3)==5 and counted.calls.value==0


def test_child_observes_its_original_parent_frame_and_bound_self():
    class Receiver:
        def child(self,value):
            parent=sys._getframe(1)
            return parent.f_code is invoke.__code__,parent.f_locals['value'] is value
    receiver=Receiver();entry,counted,_,_=with_child(invoke,Receiver.child)
    marker=object();assert entry(receiver.child,marker)==(True,True) and counted.calls.value==1


def test_child_error_uses_original_traceback_and_never_replays_effect():
    events=[]
    def child(value):
        events.append(value)
        raise ValueError(value)
    entry,counted,_,_=with_child(invoke,child)
    with pytest.raises(ValueError) as caught:entry(child,'once')
    frames=[];tb=caught.value.__traceback__
    while tb:
        frames.append(tb.tb_frame.f_code);tb=tb.tb_next
    assert frames[-2:]==[invoke.__code__,child.__code__]
    assert events==['once'] and counted.calls.value==1


def test_temporary_lifetime_is_owned_by_real_child():
    def child(value):return None
    entry,counted,_,_=with_child(invoke_temporary,child)
    def check(call):
        events=[]
        class Marker:
            def __del__(self):
                frame=sys._getframe(1)
                events.append((frame.f_code.co_name,tuple(sorted(frame.f_locals))))
        call(child,Marker)
        return events
    assert check(entry)==check(invoke_temporary)
    assert counted.calls.value==1


def test_suspending_and_protected_children_remain_cpp_fallback():
    from recompyler.ir.native_calls import prepare_native_child
    def generator(value):yield value
    async def coroutine(value):return value
    def protected(value):
        try:return 1/value
        except ZeroDivisionError:return 0
    for function in (generator,coroutine,protected):assert prepare_native_child(function.__code__) is None


def test_candidate_does_not_retain_dynamic_function_or_closure_values():
    from recompyler.ir.native_calls import prepare_native_child
    class Marker:pass
    value=Marker()
    def factory(value):
        def child():return value
        return child
    function=factory(value);ref=weakref.ref(value);function_ref=weakref.ref(function)
    candidate=prepare_native_child(function.__code__)
    del function,value;gc.collect()
    assert candidate is not None and ref() is None and function_ref() is None


def test_monitoring_enabled_by_failing_protocol_gets_raise_and_unwind_not_throw():
    def child(value):return value.field
    entry,counted,_,_=with_child(invoke,child)
    def check(call):
        events=[];tool=next(i for i in range(5,-1,-1) if sys.monitoring.get_tool(i) is None)
        class Value:
            @property
            def field(self):
                sys.monitoring.use_tool_id(tool,'native-child-regression')
                flags=0
                for name in ('RAISE','PY_UNWIND','PY_THROW'):
                    flag=getattr(sys.monitoring.events,name);flags|=flag
                    def callback(code,offset,error,name=name):
                        if code is child.__code__:events.append((name,offset))
                    sys.monitoring.register_callback(tool,flag,callback)
                sys.monitoring.set_events(tool,flags)
                raise ValueError('once')
        try:
            with pytest.raises(ValueError,match='once'):call(child,Value())
        finally:
            if sys.monitoring.get_tool(tool) is not None:
                sys.monitoring.set_events(tool,0);sys.monitoring.free_tool_id(tool)
        return events
    expected=check(invoke)
    assert [name for name,offset in expected]==['RAISE','PY_UNWIND']
    assert check(entry)==expected and counted.calls.value==1


def test_binding_errors_are_cpp_errors_before_the_native_body():
    def child(*,flag):return flag
    entry,counted,_,_=with_child(invoke,child)
    with pytest.raises(TypeError) as expected:invoke(child,1)
    with pytest.raises(TypeError) as actual:entry(child,1)
    assert str(actual.value)==str(expected.value) and counted.calls.value==0


def test_live_defaults_and_code_mutation_during_a_protocol_are_not_cached():
    def defaulted(value,other=1):return other
    entry,counted,_,_=with_child(invoke,defaulted)
    assert entry(defaulted,None)==1
    defaulted.__defaults__=(object(),)
    assert entry(defaulted,None) is defaulted.__defaults__[0] and counted.calls.value==2
    def child(value):return value.field
    def replacement(value):return 'new'
    entry,counted,_,_=with_child(invoke,child)
    class Value:
        @property
        def field(self):child.__code__=replacement.__code__;return 'old'
    assert entry(child,Value())=='old' and counted.calls.value==1
    assert entry(child,Value())=='new' and counted.calls.value==1


def test_recursive_child_keeps_cpp_limit_traceback_and_releases_activation():
    from recompyler import _source_frames_native as frames
    def child(value):
        if value:return child(value-1)
        return value
    entry,counted,_,_=with_child(invoke,child)
    def check(call):
        try:call(child,10000)
        except RecursionError as error:
            count=0;tb=error.__traceback__
            while tb:
                count+=tb.tb_frame.f_code is child.__code__;tb=tb.tb_next
            return str(error),count
        raise AssertionError('missing recursion error')
    limit=sys.getrecursionlimit()
    try:
        sys.setrecursionlimit(150)
        expected=check(invoke)
        assert check(entry)==expected
    finally:sys.setrecursionlimit(limit)
    assert counted.calls.value==1 and frames.active_depth()==0
    assert entry(child,0)==0 and counted.calls.value==2


def test_profile_enabled_in_failing_protocol_sees_original_child_unwind():
    def child(value):return value.field
    entry,counted,_,_=with_child(invoke,child)
    def check(call):
        events=[]
        def profile(frame,event,arg):
            if frame.f_code is child.__code__:events.append((event,frame.f_lasti))
        class Value:
            @property
            def field(self):sys.setprofile(profile);raise ValueError('once')
        try:
            with pytest.raises(ValueError,match='once'):call(child,Value())
        finally:sys.setprofile(None)
        return events
    assert check(entry)==check(invoke) and counted.calls.value==1


def test_cell_creation_stays_with_the_original_cpp_prologue():
    from recompyler.ir.native_calls import prepare_native_child
    def factory(value):
        def child():return value
        return child
    assert factory.__code__.co_cellvars and prepare_native_child(factory.__code__) is None
