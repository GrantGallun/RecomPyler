"""S49: numeric identity observations must stay in Python."""
import struct
import pytest
from recompyler import heap

def identity(left,right): return left is right
def nonidentity(left,right): return left is not right
def observe_id(value): return id(value)
def identity_helper(left,right): return identity(left,right)
def identity_in_list(values): return values[0] is values[1]
def forward(value): return value

@pytest.mark.parametrize('fn',[identity,nonidentity,identity_helper])
@pytest.mark.parametrize('kind',[int,float])
def test_possible_numeric_identity_observation_declines(fn,kind):
 a=kind('1000009');b=kind('1000009');assert a is not b
 region=heap.lift_region(fn)
 for args in [(a,a),(a,b),(a,a)]:
  assert region(*args) is fn(*args)
 assert region.compiled_calls==0
 assert region.fallback_calls==3

@pytest.mark.parametrize('fn',[identity,nonidentity])
@pytest.mark.parametrize('container',[{1:2},{1,2}])
@pytest.mark.parametrize('kind',[int,float,bool])
def test_numeric_vs_container_identity_cannot_compare_a_handle(fn,container,kind):
 region=heap.lift_region(fn)
 # Numeric payloads must never compare equal to internal arena handles.
 for raw in range(32):
  value=kind(raw)
  for args in [(value,container),(container,value)]:
   before=region.compiled_calls
   assert region(*args) is fn(*args),(fn.__name__,args,region.problem)
   assert region.compiled_calls==before+1
 assert region.fallback_calls==0

@pytest.mark.parametrize('fn,args',[(observe_id,(int('1000009'),)),(identity_in_list,([int('1000009'),int('1000009')],))])
def test_numeric_identity_consumer_declines(fn,args):
 region=heap.lift_region(fn)
 for _ in range(2):
  assert region(*args)==fn(*args)
 assert region.compiled_calls==0

@pytest.mark.parametrize('value',[None,True,False])
def test_singleton_forward_result_keeps_identity(value):
 region=heap.lift_region(forward)
 for _ in range(2):assert region(value) is value

class IntSubclass(int):pass
class FloatSubclass(float):pass
@pytest.mark.parametrize('value',[IntSubclass(1000009),FloatSubclass(123.5)])
def test_numeric_subclass_is_not_exempt(value):
 region=heap.lift_region(forward)
 for _ in range(2):assert region(value) is value

@pytest.mark.parametrize('value',[complex(-0.0,1.5),complex(1.25,-0.0),complex(float('nan'),-0.0)])
def test_complex_type_and_component_bits(value):
 region=heap.lift_region(forward)
 for _ in range(2):
  result=region(value)
  assert type(result) is complex
  assert struct.pack('>dd',result.real,result.imag)==struct.pack('>dd',value.real,value.imag)


def mark_number(events):
 events.append(1)
 return 0

def mark_container(events,container):
 events.append(2)
 return container

def ordered_comparison(events,container):
 return mark_number(events) is mark_container(events,container)

@pytest.mark.parametrize('container',[{1:2},{1,2}])
def test_mixed_identity_keeps_operand_evaluation_order(container):
 region=heap.lift_region(ordered_comparison)
 for _ in range(2):
  expected_events=[];assert ordered_comparison(expected_events,container) is False
  actual_events=[];assert region(actual_events,container) is False
  assert actual_events==expected_events==[1,2]


def mixed_identity(flag,value,container):
 return (value if flag else 0.5) is container

def mixed_nonidentity(flag,value,container):
 return (value if flag else 0.5) is not container

@pytest.mark.parametrize('fn',[identity,nonidentity,mixed_identity,mixed_nonidentity])
@pytest.mark.parametrize('value',[-0.0,float('nan'),float('inf'),float('-inf')])
def test_mixed_and_special_numeric_values_use_type_proof(fn,value):
 region=heap.lift_region(fn);container={1:2}
 cases=[(value,container),(container,value)] if fn in (identity,nonidentity) else [(True,3,container),(False,3,container),(True,value,container)]
 for args in cases:
  expected=fn(*args);before=region.compiled_calls
  assert region(*args) is expected
  assert region.compiled_calls==before+1


def divide_identity(value,denominator,container):
 return (value / denominator) is container

def index_identity(values,index,container):
 return values[index] is container

def key_identity(values,key,container):
 return values[key] is container

@pytest.mark.parametrize('fn,args,error',[(divide_identity,(1.0,0.0,{}),ZeroDivisionError),(index_identity,([1],2,{}),IndexError),(key_identity,({1:2},3,{}),KeyError)])
def test_constant_identity_still_evaluates_raising_operand(fn,args,error):
 region=heap.lift_region(fn)
 for _ in range(2):
  with pytest.raises(error) as expected:fn(*args)
  with pytest.raises(error) as actual:region(*args)
  assert actual.value.args==expected.value.args


def chained_identity(events,container):
 return 0 is container is mark_container(events,container)

def chained_nonidentity(events,container):
 return 0 is not container is mark_container(events,container)

@pytest.mark.parametrize('fn,wanted,events_wanted',[(chained_identity,False,[]),(chained_nonidentity,True,[2])])
def test_chained_identity_preserves_later_operand_short_circuit(fn,wanted,events_wanted):
 region=heap.lift_region(fn)
 for _ in range(2):
  events=[];assert region(events,{1:2}) is wanted
  assert events==events_wanted

@pytest.mark.parametrize('container',[{1:2},{1,2}])
def test_handle_identity_and_none_controls(container):
 for fn in (identity,nonidentity):
  region=heap.lift_region(fn)
  for args in [(container,container),(container,container.copy()),(None,container),(container,None)]:
   assert region(*args) is fn(*args)
