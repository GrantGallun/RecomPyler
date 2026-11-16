"""S67 basic native operation, exact CPython behavior plus reduced callouts."""
import builtins
import pytest
from recompyler import heap

def check(value, kind):
    return isinstance(value, kind)

def via_argument(value, kind, action):
    return action(value, kind)

class Parent: pass
class Child(Parent): pass

@pytest.mark.parametrize('value,kind,want',[(3,int,True),('text',int,False),(Child(),Parent,True),(None,type(None),True),(True,int,True)])
def test_common_isinstance_has_no_managed_source_dispatch(value,kind,want):
    region=heap.lift_structures(check,callees=())
    assert region.run is not None,region.problem
    assert region(value,kind) is want
    assert region.compiled_calls==1 and region.fallback_calls==0
    assert region.managed_calls==0

def test_spoofed_class_and_custom_metaclass_keep_exact_callbacks():
    events=[]
    class Spoof:
        @property
        def __class__(self):
            events.append('class')
            return int
    class Meta(type):
        def __instancecheck__(self,value):
            events.append(value)
            return True
    class Kind(metaclass=Meta): pass
    region=heap.lift_structures(check,callees=())
    assert region.run is not None,region.problem
    value=Spoof()
    assert region(value,int) is True and events==['class']
    events.clear()
    assert region(value,Kind) is True and events==[value]

def test_replaced_callable_keeps_current_result_and_one_effect():
    region=heap.lift_structures(via_argument,callees=())
    assert region.run is not None,region.problem
    events=[];marker=[]
    def changed(value,kind):
        events.append((value,kind))
        return marker
    assert region(3,int,changed) is marker
    assert events==[(3,int)] and region.managed_calls==1

def entry(value):return value

def chain(program,first,second,kind):
    program.unify(first,second)
    program.widen_cell(first,kind)
    return heap._find(first)

def test_inference_chain_reports_interpreted_unproved_children():
    region=heap.lift_structures(chain,callees=(heap._Program.unify,heap._Program.widen_cell,heap._find))
    assert region.run is not None,region.problem
    first,second=heap._Cell(),heap._Cell();second.elem=heap.INT
    assert region(heap._Program(entry),first,second,heap.INT) is first
    assert region.native_helper_calls==0 and region.fallback_calls==0
    assert region.managed_calls==3


def unpack_two(values):
    first,second=values
    return first,second


def unpack_into_object(target,values):
    target.first,target.second=values
    return target


@pytest.mark.parametrize('kind',[tuple,list])
def test_exact_unpack_eliminates_framework_dispatch(kind):
    marker1,marker2=object(),object()
    region=heap.lift_structures(unpack_two,callees=(),call_kinds=True)
    assert region.run is not None,region.problem
    result=region(kind((marker1,marker2)))
    assert result[0] is marker1 and result[1] is marker2
    assert region.compiled_calls==1 and region.fallback_calls==0
    assert region.managed_calls==0
    assert region.managed_dispatch_calls==0,region.managed_dispatch_counts


def test_unpack_snapshots_before_first_store_callback():
    first,second,replacement=object(),object(),object()
    values=[first,second]
    class Target:
        def __setattr__(self,name,value):
            if name=='first':values[1]=replacement
            object.__setattr__(self,name,value)
    target=Target()
    region=heap.lift_structures(unpack_into_object,callees=(),call_kinds=True)
    assert region.run is not None,region.problem
    assert region(target,values) is target
    assert target.first is first and target.second is second
    assert values[1] is replacement
    assert region.managed_dispatch_calls==0,region.managed_dispatch_counts


@pytest.mark.parametrize('values',[(1,),[1,2,3]])
def test_unpack_arity_errors_match_before_target_stores(values):
    class Target:pass
    original,compiled=Target(),Target()
    with pytest.raises(ValueError) as expected:unpack_into_object(original,values)
    region=heap.lift_structures(unpack_into_object,callees=(),call_kinds=True)
    assert region.run is not None,region.problem
    with pytest.raises(type(expected.value)) as actual:region(compiled,values)
    assert actual.value.args==expected.value.args
    assert vars(original)==vars(compiled)=={}
    assert region.compiled_calls==1 and region.fallback_calls==0


def test_general_unpack_keeps_iteration_effect_order():
    events=[];first,second=object(),object()
    class Values:
        def __iter__(self):
            events.append('iter')
            yield first
            events.append('second')
            yield second
            events.append('end')
    region=heap.lift_structures(unpack_two,callees=(),call_kinds=True)
    assert region.run is not None,region.problem
    expected=unpack_two(Values());want=list(events);events.clear()
    actual=region(Values())
    assert all(a is b for a,b in zip(expected,actual)) and events==want
    assert region.compiled_calls==1 and region.fallback_calls==0
    assert region.managed_dispatch_counts=={'helper':1}


def append_value(values,value):
    return values.append(value)


def add_value(values,value):
    return values.add(value)


def get_value(values,key,default):
    return values.get(key,default)


@pytest.mark.parametrize('function,container',[(append_value,[]),(add_value,set())])
def test_exact_mutation_method_has_no_dispatch(function,container):
    marker=object();region=heap.lift_structures(function,callees=(),call_kinds=True)
    assert region.run is not None,region.problem
    assert region(container,marker) is None
    assert next(iter(container)) is marker
    assert region.compiled_calls==1 and region.fallback_calls==0
    assert region.managed_calls==region.managed_dispatch_calls==0,region.managed_dispatch_counts


def test_exact_dict_get_preserves_original_default_without_dispatch():
    marker,default=object(),object()
    region=heap.lift_structures(get_value,callees=(),call_kinds=True)
    assert region.run is not None,region.problem
    assert region({'key':marker},'key',default) is marker
    assert region({},'key',default) is default
    assert region.compiled_calls==2 and region.fallback_calls==0
    assert region.managed_calls==region.managed_dispatch_calls==0,region.managed_dispatch_counts


def test_replaced_methods_keep_custom_callbacks_and_return_objects():
    calls=[];marker=object()
    class Custom:
        def append(self,value):calls.append(value);return marker
        def add(self,value):calls.append(value);return marker
        def get(self,key,default):calls.append((key,default));return marker
    for function,args in [(append_value,(3,)),(add_value,(4,)),(get_value,('key',5))]:
        region=heap.lift_structures(function,callees=(),call_kinds=True)
        assert region.run is not None,region.problem
        assert region(Custom(),*args) is marker
        assert region.managed_calls==region.managed_dispatch_calls==1
    assert calls==[3,4,('key',5)]


def item_value(values,index):
    return values[index]


@pytest.mark.parametrize('kind',[tuple,list])
@pytest.mark.parametrize('index',[0,-1,2,-3,10**100,-10**100,True,slice(None)])
def test_sequence_reads_preserve_value_identity_and_errors(kind,index):
    markers=(object(),object());values=kind(markers)
    region=heap.lift_structures(item_value,callees=(),call_kinds=True)
    assert region.run is not None,region.problem
    expected_error=None
    try:expected=item_value(values,index)
    except Exception as exc:expected_error=(type(exc),exc.args)
    # The public entry intentionally declines under an active handled exception.
    # Leave the reference except block before checking native error propagation.
    if expected_error is not None:
        with pytest.raises(expected_error[0]) as actual:region(values,index)
        assert actual.value.args==expected_error[1]
    else:
        actual=region(values,index)
        if isinstance(index,slice):assert all(a is b for a,b in zip(actual,expected))
        else:assert actual is expected
    assert region.compiled_calls==1 and region.fallback_calls==0


def test_list_subclass_overrides_are_not_bypassed():
    events=[];marker=object()
    class Values(list):
        def append(self,value):events.append(('append',value));return marker
        def __getitem__(self,index):events.append(('getitem',index));return marker
        def __iter__(self):events.append('iter');return iter((marker,marker))
    values=Values([1,2])
    for function,args in [(append_value,(3,)),(item_value,(0,)),(unpack_two,())]:
        region=heap.lift_structures(function,callees=(),call_kinds=True)
        assert region.run is not None,region.problem
        result=region(values,*args)
        if function is unpack_two:assert result[0] is marker and result[1] is marker
        else:assert result is marker
        assert region.compiled_calls==1 and region.fallback_calls==0
    assert events==[('append',3),('getitem',0),'iter']


def test_dict_get_hash_error_preserves_callback_and_original_exception():
    events=[];error=RuntimeError('hash failure')
    class Key:
        def __hash__(self):events.append('hash');raise error
    region=heap.lift_structures(get_value,callees=(),call_kinds=True)
    assert region.run is not None,region.problem
    with pytest.raises(RuntimeError) as actual:region({},Key(),None)
    assert actual.value is error and events==['hash']
    assert region.compiled_calls==1 and region.fallback_calls==0


def test_optional_call_kinds_count_interpreted_child_sites_once():
    region=heap.lift_structures(chain,callees=(heap._Program.unify,heap._Program.widen_cell,heap._find),call_kinds=True)
    assert region.run is not None,region.problem
    first,second=heap._Cell(),heap._Cell();second.elem=heap.INT
    assert region(heap._Program(entry),first,second,heap.INT) is first
    assert region.native_helper_calls==0 and region.fallback_calls==0
    assert region.managed_calls==3==sum(region.managed_call_counts.values())
    assert region.managed_dispatch_calls==3==sum(region.managed_dispatch_counts.values())
    assert region.managed_call_counts=={'method':3}


def number_kind(value):
    return isinstance(value,(int,float,complex))
