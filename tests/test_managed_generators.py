"""Original Python generator bodies behind compiled construction/control flow."""
import types
import pytest
from recompyler import heap
from recompyler import _comparison,_managed_vector,_managed_frames,_managed_native

def factory(items,events):return (events.append(item) or item for item in items)
def live_factory(items,first,last):
    value=first
    result=(value for item in items)
    value=last
    return result

def compiled(fn):
    region=heap.lift_structures(fn)
    assert region.run is not None,region.problem
    return region

class Iterable:
    def __init__(self,events):self.events=events
    def __iter__(self):self.events.append('iter');return iter((1,2))

def test_eager_iterator_lazy_body_and_original_code():
    region=compiled(factory);events=[]
    result=region(Iterable(events),events)
    assert type(result) is types.GeneratorType
    code=next(value for value in factory.__code__.co_consts if type(value) is types.CodeType)
    assert result.gi_code is code and result.gi_frame.f_globals is factory.__globals__
    assert events==['iter']
    assert next(result)==1 and events==['iter',1]
    assert list(result)==[2] and events==['iter',1,2]
    assert region.compiled_calls==1 and region.fallback_calls==0

def test_live_original_cells_outlive_parent_and_keep_nonnumber_identity():
    region=compiled(live_factory);first,last=[],[]
    result=region([0,1],first,last)
    assert result.gi_frame.f_locals['value'] is last
    assert all(value is last for value in result)
    assert region.compiled_calls==1 and region.fallback_calls==0

def test_real_comparison_is_class():
    region=compiled(_comparison._is_class)
    class Meta(type):pass
    class Record(metaclass=Meta):pass
    for value in (int,Record,Record(),[],None):assert region(value) is _comparison._is_class(value)
    assert region.compiled_calls==5 and region.fallback_calls==0

def test_real_managed_frame_length():
    region=compiled(_managed_frames.Frame.__len__)
    frame=_managed_frames.Frame(factory,{'items':[1],'events':[]})
    assert region(frame)==len(frame)==2
    del frame['items']
    assert region(frame)==len(frame)==1
    assert region.compiled_calls==2 and region.fallback_calls==0

def test_real_vector_argument_type_helper():
    from numba.core import types as nt
    region=compiled(_managed_vector._arguments_type)
    for value in (nt.Tuple((_managed_native.managed,)),nt.Tuple((nt.int64,)),nt.int64):
        assert region(value) is _managed_vector._arguments_type(value)
    assert region.compiled_calls==3 and region.fallback_calls==0


def before_generator(items,events):
    events.append('before')
    return (value for value in items)

def unbound_factory(items,bind):
    result=(value for item in items)
    if bind:value=bind
    return result

def mixed_scope(items,token):
    value=token
    result=(value for item in items)
    values=[value for item in items]
    return result,values

def scoped_cell_comprehension(items):
    return [(value for unused in (0,)) for value in items]

def sum_values(items,offset):return sum(value+offset for value in items if value)
def consume_cells(items,token):
    value=token
    result=(value for item in items)
    value=token
    return list(result)
def all_values(items,flag):return all(value==flag for value in items)

def test_outer_iterator_error_preserves_once_only_parent_effects():
    region=compiled(before_generator);events=[];error=ValueError('iterator')
    class Broken:
        def __iter__(self):events.append('iter');raise error
    with pytest.raises(ValueError) as caught:region(Broken(),events)
    assert caught.value is error and events==['before','iter']
    assert region.compiled_calls==1 and region.fallback_calls==0

def test_unbound_generator_cell_uses_original_python_error():
    region=compiled(unbound_factory)
    errors=[]
    for target in (unbound_factory,region):
        with pytest.raises(NameError) as caught:next(target([0],False))
        errors.append((type(caught.value),str(caught.value),caught.value.name))
    assert errors[0]==errors[1]
    assert region.compiled_calls==1 and region.fallback_calls==0

def test_inline_comprehension_reads_outer_cell_without_binding_it():
    region=compiled(mixed_scope);token=[]
    result,values=region([0,1],token)
    assert values[0] is values[1] is token
    assert all(value is token for value in result)
    assert region.compiled_calls==1 and region.fallback_calls==0

def test_inline_comprehension_cell_binding_refuses_before_effects():
    region=heap.lift_structures(scoped_cell_comprehension)
    assert region.run is None and region.compiled_calls==region.fallback_calls==0


def consume_mixed(items,token):
    value=token
    values=[value for item in items]
    return list(value for item in values)


def cell_mutation(items,make,events):
    value=make()
    def change():
        nonlocal value
        value=None
        events.append('change')
        return 0
    [change() for item in items]
    return events.copy()


def test_comprehension_shares_live_cells_without_pinning_contents():
    class Payload:
        def __init__(self,events):self.events=events
        def __del__(self):self.events.append('del')
    def observe(target):
        events=[]
        def make():return Payload(events)
        return target([0],make,events),events
    region=compiled(cell_mutation)
    assert observe(cell_mutation)==(['del','change'],['del','change'])
    assert observe(region)==observe(cell_mutation)
    assert region.compiled_calls==1 and region.fallback_calls==0
