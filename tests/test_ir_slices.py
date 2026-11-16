"""Generic slice construction/access/store follow original CPython ownership."""
import dis,sys,weakref
import pytest
from test_ir_existing_frame import frame_entry

def access(owner,start,stop):return owner[start:stop]
def stepped(owner,start,stop,step):return owner[start:stop:step]
def store(owner,start,stop,value):owner[start:stop]=value
def store_stepped(owner,start,stop,step,value):owner[start:stop:step]=value
def fresh(factory):return factory('owner')[factory('start'):factory('stop')]
def fresh_store(factory):factory('owner')[factory('start'):factory('stop')]=factory('value')
def observed(owner,start,stop):
    result=owner[start:stop]
    return result

@pytest.mark.parametrize('source',[access,stepped])
def test_slice_protocol_gets_original_component_objects_and_source_pc(source):
    start,stop,step,marker=(object() for _ in range(4));events=[]
    class Owner:
        def __getitem__(self,key):
            frame=sys._getframe(1)
            events.append((key.start is start,key.stop is stop,key.step is (step if source is stepped else None),frame.f_code is source.__code__,frame.f_lasti))
            return marker
    native,_,_=frame_entry(source);args=(Owner(),start,stop)+((step,) if source is stepped else ())
    assert source(*args) is marker
    expected=list(events);events.clear()
    assert native(*args) is marker and events==expected

@pytest.mark.parametrize('source',[store,store_stepped])
def test_slice_assignment_gets_original_value_and_components(source):
    start,stop,step,marker=(object() for _ in range(4));events=[]
    class Owner:
        def __setitem__(self,key,value):
            frame=sys._getframe(1)
            events.append((key.start is start,key.stop is stop,key.step is (step if source is store_stepped else None),value is marker,frame.f_code is source.__code__,frame.f_lasti))
    native,_,_=frame_entry(source);args=(Owner(),start,stop)+((step,) if source is store_stepped else ())+(marker,)
    assert source(*args) is None
    expected=list(events);events.clear()
    assert native(*args) is None and events==expected

@pytest.mark.parametrize('source',[fresh,fresh_store])
def test_fresh_slice_operands_retire_at_original_source_boundary(source):
    native,_,_=frame_entry(source);marker=object()
    def run(call):
        events=[];refs=[]
        class Value:
            def __init__(self,kind):self.kind=kind;refs.append(weakref.ref(self))
            def __del__(self):
                frame=sys._getframe(1)
                events.append(('drop',self.kind,frame.f_code is source.__code__,frame.f_lasti))
            def __getitem__(self,key):events.append(('get',key.start.kind,key.stop.kind));return marker
            def __setitem__(self,key,value):events.append(('set',key.start.kind,key.stop.kind,value.kind))
        def factory(kind):events.append(('new',kind));return Value(kind)
        result=call(factory)
        assert result is (None if source is fresh_store else marker)
        assert all(ref() is None for ref in refs)
        return events
    assert run(native)==run(source)

@pytest.mark.parametrize('source',[access,store])
def test_slice_error_preserves_original_exception_and_original_pc(source):
    error=LookupError('original slice failure')
    class Owner:
        def __getitem__(self,key):raise error
        def __setitem__(self,key,value):raise error
    native,_,_=frame_entry(source);args=(Owner(),None,None)+((object(),) if source is store else ())
    with pytest.raises(LookupError) as actual:native(*args)
    assert actual.value is error
    tb=actual.value.__traceback__
    while tb and tb.tb_frame.f_code is not source.__code__:tb=tb.tb_next
    assert tb.tb_lasti==next(i.offset for i in dis.get_instructions(source) if i.opname in ('BINARY_SLICE','STORE_SLICE'))

def test_builtin_slice_indices_and_assignment_match_cpython():
    get,_,_=frame_entry(access);set_,_,_=frame_entry(store);step,_,_=frame_entry(stepped)
    for start,stop in [(None,None),(-4,-1),(2,30),(8,1)]:
        expected=list(range(10));actual=expected.copy()
        assert get(actual,start,stop)==access(expected,start,stop)
        assert step(actual,start,stop,-2)==stepped(expected,start,stop,-2)
        set_(actual,start,stop,[20,30]);store(expected,start,stop,[20,30]);assert actual==expected

def test_slice_callback_observer_transition_resumes_original_next_line():
    events=[];marker=object()
    def trace(frame,event,arg):
        if frame.f_code is observed.__code__:events.append((event,frame.f_lineno))
        return trace
    class Owner:
        def __getitem__(self,key):
            frame=sys._getframe(1);frame.f_trace=trace;sys.settrace(trace)
            return marker
    native,_,_=frame_entry(observed)
    try:assert observed(Owner(),None,None) is marker
    finally:sys.settrace(None)
    expected=list(events);events.clear()
    try:assert native(Owner(),None,None) is marker
    finally:sys.settrace(None)
    assert events==expected

def test_real_compiler_signature_helper_executes_slice_body():
    from recompyler import heap
    from recompyler.ir import compile_function,compilation_info
    def positional(a,/,b=None):pass
    def variadic(a,/,b=None,*items,flag=False,**kwargs):pass
    source=heap._signature_names;code=source.__code__
    assert compile_function(source,strict=True) is source
    assert compilation_info(source)['body_address']>0
    native,lowered,_=frame_entry(source)
    for function in (positional,variadic):
        expected=source(function);actual=native(function)
        assert actual==expected and all(left is right for left,right in zip(actual,expected))
    assert source.__code__ is code and lowered.abi=='frame'
