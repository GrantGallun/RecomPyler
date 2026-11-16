"""External numeric-box observations for the native scalar boundary (S42/S43)."""
import math
import pytest
from recompyler import heap

def forward(value):return value
def positive(value):return +value
def float_exact(value):return float(value)
def magnitude(value):return abs(value)
def code_integer():return 1000003
def code_float():return 12345.625
def folded_integer():return 1000003+2
def fresh_integer(value):return value+1000003
def fresh_float(value):return value+0.125
def select(flag,value):return value if flag else value+1

def observe_identity(call,args,expected):
 result=call(*args)
 assert type(result) is type(expected)
 assert result is expected
 return result

@pytest.mark.parametrize('fn,value',[(forward,int('1000009')),(forward,float('12345.625')),(positive,int('1000009')),(positive,float('12345.625')),(float_exact,float('12345.625')),(magnitude,int('1000009'))])
def test_first_and_warm_scalar_forwarding_preserve_python_box(fn,value):
 region=heap.lift_region(fn)
 assert fn(value) is value
 observe_identity(region,(value,),value)
 observe_identity(region,(value,),value)

@pytest.mark.parametrize('fn',[code_integer,code_float,folded_integer])
def test_code_constant_and_folded_constant_keep_the_actual_constant_box(fn):
 expected=fn();assert fn() is expected
 region=heap.lift_region(fn)
 observe_identity(region,(),expected)
 observe_identity(region,(),expected)

@pytest.mark.parametrize('fn,value',[(fresh_integer,int('1000009')),(fresh_float,float('12345.625'))])
def test_distinct_live_fresh_results_are_not_merged(fn,value):
 region=heap.lift_region(fn)
 a,b=region(value),region(value)
 expected=fn(value)
 assert type(a) is type(b) is type(expected)
 assert a==b==expected and a is not b and a is not value and b is not value

@pytest.mark.parametrize('flag',[True,False])
def test_existing_fresh_branch_selects_the_right_identity_origin(flag):
 value=int('1000009');region=heap.lift_region(select)
 for _ in range(2):
  actual=region(flag,value);expected=select(flag,value)
  assert type(actual) is type(expected) and actual==expected
  assert (actual is value)==flag

@pytest.mark.parametrize('value',[-0.0,float('nan')])
def test_forwarded_float_box_keeps_signed_zero_nan_and_identity(value):
 region=heap.lift_region(forward)
 for _ in range(2):
  actual=region(value)
  assert type(actual) is float and actual is value
  if math.isnan(value):assert math.isnan(actual)
  else:assert math.copysign(1.0,actual)==math.copysign(1.0,value)
