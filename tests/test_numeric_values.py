"""S49 exact numeric type/value controls replacing numeric-box identity demands."""
import math
import struct
import pytest
from recompyler import heap
from numba.core.registry import CPUDispatcher

@pytest.fixture(autouse=True)
def require_actual_native_calls(monkeypatch):
 """A Python fallback or a skipped dispatcher must fail the value gate."""
 original_call=heap.Region.__call__
 original_dispatch=CPUDispatcher.__call__
 entries=[]
 def dispatch(self,*args,**kwargs):
  result=original_dispatch(self,*args,**kwargs)
  entries.append(self)
  return result
 def checked(self,*args,**kwargs):
  before=(self.compiled_calls,self.fallback_calls,len(entries))
  result=original_call(self,*args,**kwargs)
  assert self.compiled_calls==before[0]+1
  assert self.fallback_calls==before[1]
  assert type(self.latest.run) is CPUDispatcher
  assert any(entry is self.latest.run for entry in entries[before[2]:])
  return result
 monkeypatch.setattr(CPUDispatcher,"__call__",dispatch)
 monkeypatch.setattr(heap.Region,"__call__",checked)

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

def observe_value(call,args,expected):
 result=call(*args)
 assert type(result) is type(expected)
 assert result == expected
 if type(expected) is float:assert struct.pack('>d',result)==struct.pack('>d',expected)
 return result

@pytest.mark.parametrize('fn,value',[(forward,int('1000009')),(forward,float('12345.625')),(positive,int('1000009')),(positive,float('12345.625')),(float_exact,float('12345.625')),(magnitude,int('1000009'))])
def test_first_and_warm_scalar_forwarding_preserve_exact_value(fn,value):
 region=heap.lift_region(fn)
 assert type(fn(value)) is type(value) and fn(value)==value
 observe_value(region,(value,),value)
 observe_value(region,(value,),value)

@pytest.mark.parametrize('fn',[code_integer,code_float,folded_integer])
def test_code_constant_and_folded_constant_keep_exact_constant_type_and_value(fn):
 expected=fn();assert type(fn()) is type(expected) and fn()==expected
 region=heap.lift_region(fn)
 observe_value(region,(),expected)
 observe_value(region,(),expected)

@pytest.mark.parametrize('fn,value',[(fresh_integer,int('1000009')),(fresh_float,float('12345.625'))])
def test_distinct_live_fresh_results_keep_exact_type_and_value(fn,value):
 region=heap.lift_region(fn)
 a,b=region(value),region(value)
 expected=fn(value)
 assert type(a) is type(b) is type(expected)
 assert a==b==expected

@pytest.mark.parametrize('flag',[True,False])
def test_existing_fresh_branch_selects_the_right_type_and_value(flag):
 value=int('1000009');region=heap.lift_region(select)
 for _ in range(2):
  actual=region(flag,value);expected=select(flag,value)
  assert type(actual) is type(expected) and actual==expected
  if type(expected) is float:assert struct.pack('>d',actual)==struct.pack('>d',expected)

@pytest.mark.parametrize('value',[-0.0,struct.unpack('>d',struct.pack('>Q',0x7ff8000000000042))[0],struct.unpack('>d',struct.pack('>Q',0xfff8000000001234))[0]])
def test_forwarded_float_keeps_signed_zero_and_nan_payload(value):
 region=heap.lift_region(forward)
 for _ in range(2):
  actual=region(value)
  assert type(actual) is float
  assert struct.pack('>d',actual)==struct.pack('>d',value)
  if math.isnan(value):assert math.isnan(actual)
  else:assert math.copysign(1.0,actual)==math.copysign(1.0,value)
