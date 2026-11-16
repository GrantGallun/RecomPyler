"""Namespace writes, mapping expansion, and canonical expanded-call boundaries."""
import builtins,dis,sys,types,weakref
import pytest
from test_ir_existing_frame import frame_entry

def put(value):
    global token
    token=value
    return token

def remove():
    global token
    del token

def mapping(value):return {**value}
def merged(left,right):return {**left,**right}
def expanded(func,args,left,right):return func(*args,**left,**right)
def expanded_fresh(func,factory):return func(*factory())
def source_copy(source,**scope):return types.FunctionType(source.__code__.replace(),{'__builtins__':vars(builtins),**scope})

def test_global_store_live_globals_and_retirement_context():
    marker=object();events=[];fn=None
    class Old:
        def __del__(self):
            caller=sys._getframe(1)
            events.append((caller.f_code is fn.__code__,fn.__globals__['token'] is marker,caller.f_locals['value'] is marker))
    fn=source_copy(put,token=Old());native,_,_=frame_entry(fn)
    assert native(marker) is marker and fn.__globals__['token'] is marker
    assert events==[(True,True,True)]

def test_global_delete_error_name_and_original_pc():
    fn=source_copy(remove,token=object());native,_,_=frame_entry(fn)
    assert native() is None and 'token' not in fn.__globals__
    with pytest.raises(NameError) as expected:fn()
    with pytest.raises(NameError) as actual:native()
    assert str(actual.value)==str(expected.value) and actual.value.name==expected.value.name=='token'
    tb=actual.value.__traceback__
    while tb and tb.tb_frame.f_code is not fn.__code__:tb=tb.tb_next
    assert tb.tb_lasti==next(i.offset for i in dis.get_instructions(fn) if i.opname=='DELETE_GLOBAL')

def test_dict_update_mapping_protocol_and_original_member_identity():
    marker=object();events=[]
    class Mapping:
        def keys(self):events.append('keys');return ['item']
        def __getitem__(self,key):events.append(('get',key));return marker
    native,_,_=frame_entry(mapping)
    assert native(Mapping())=={'item':marker} and events==['keys',('get','item')]
    combined,_,_=frame_entry(merged)
    assert combined({'item':object()},{'item':marker})['item'] is marker

@pytest.mark.parametrize('error',[None,AttributeError('keys unavailable'),LookupError('original mapping error')])
def test_dict_update_errors_match_interpreter(error):
    class Mapping:
        def keys(self):
            if error:raise error
            return None
    native,_,_=frame_entry(mapping)
    with pytest.raises(Exception) as expected:mapping(Mapping())
    with pytest.raises(type(expected.value)) as actual:native(Mapping())
    assert str(actual.value)==str(expected.value)
    if type(error) is LookupError:assert actual.value is error

def test_dict_merge_duplicate_error_does_not_call_target():
    calls=[]
    def target(**kwargs):calls.append(kwargs)
    native,_,_=frame_entry(expanded)
    with pytest.raises(TypeError) as expected:expanded(target,(),{'a':1},{'a':2})
    with pytest.raises(TypeError) as actual:native(target,(),{'a':1},{'a':2})
    assert str(actual.value)==str(expected.value) and calls==[]

def test_expanded_boundary_retains_canonical_binding_and_single_prefix_effect():
    native,lowered,_=frame_entry(expanded);events=[];marker=object()
    class Mapping:
        def keys(self):events.append('keys');return ['item']
        def __getitem__(self,key):events.append(('get',key));return marker
    def target(value,/,*,item):
        frame=sys._getframe(1)
        events.append(('target',frame.f_code is expanded.__code__))
        return value,item
    assert native(target,(marker,),Mapping(),{})==(marker,marker)
    assert events==['keys',('get','item'),('target',True)]

def test_expanded_boundary_does_not_retain_fresh_argument_tuple_in_child():
    native,_,_=frame_entry(expanded_fresh)
    def run(call):
        events=[];refs=[]
        class Leaf:
            def __del__(self):events.append('drop')
        def factory():
            events.append('factory');value=Leaf();refs.append(weakref.ref(value));return (value,)
        def child(value):
            del value
            events.append(('child',refs[0]() is None))
        assert call(child,factory) is None
        return events
    assert run(native)==run(expanded_fresh)==['factory','drop',('child',True)]
