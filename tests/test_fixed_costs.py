"""S41 general fixed-cost rules: retain errors, writes and live invalidation."""
import sys
from unittest.mock import patch
from recompyler import heap
class Record:
 def __init__(self,value):self.value=value
def compare(record):return record.value > 0.0
def scalar(x):return x * 2 + 1
def recurse(n):return 0 if n == 0 else recurse(n-1)+1
def mutate(record):
 record.value += 1.0
 return record.value > 0.0
def mixed(x):return x * 1.5

def warmed(fn,*args):
 region=heap.lift_region(fn)
 region(*args)
 assert region.compiled_calls == 1 and region.fallback_calls == 0, region.problem
 return region

def forbidden(*args,**kwargs):raise AssertionError('unneeded boundary operation executed')

def test_acyclic_call_does_not_walk_python_frames():
 region=warmed(compare,Record(1.0))
 with patch.object(sys,'_getframe',forbidden):
  assert region(Record(2.0)) is True
 assert region.compiled_calls==2 and region.fallback_calls==0

def test_readonly_scalar_result_needs_no_unloader():
 region=warmed(compare,Record(1.0))
 with patch.object(heap,'_Unloader',forbidden):
  assert region(Record(-2.0)) is False
 assert region.compiled_calls==2 and region.fallback_calls==0

def test_mutating_scalar_result_still_publishes_input_stores():
 record=Record(0.0);region=warmed(mutate,record)
 assert record.value==1.0
 assert region(record) is True and record.value==2.0

def test_recursive_calls_keep_depth_budget_and_python_replay():
 region=warmed(recurse,4)
 old=sys.getrecursionlimit()
 try:
  sys.setrecursionlimit(150)
  assert region(20)==20
  try:region(300)
  except RecursionError:pass
  else:raise AssertionError('recursion limit lost')
 finally:sys.setrecursionlimit(old)

def test_scalar_numeric_results_and_overflow_keep_existing_fallback():
 region=warmed(scalar,2)
 assert region(3)==7
 huge=2**63-1
 assert region(huge)==2*huge+1
 assert region.fallback_calls==1

def test_live_method_code_invalidation_is_checked_after_warmup():
 region=warmed(compare,Record(1.0))
 original=compare.__code__
 try:
  compare.__code__=(lambda record:False).__code__
  assert region(Record(3.0)) is False
  assert region.fallback_calls==1
 finally:compare.__code__=original

def test_scalar_only_warm_entry_needs_no_graph_loader():
 region=warmed(scalar,2)
 with patch.object(region,'load',forbidden),patch.object(heap,'_Unloader',forbidden),patch.object(sys,'_getframe',forbidden):
  assert region(4)==9
 assert region.compiled_calls==2 and region.fallback_calls==0

def defaulted(x=2,*,scale=3):return x*scale

def test_scalar_entry_preserves_keyword_binding_and_new_specializations():
 region=warmed(defaulted,2)
 assert region(scale=4)==8
 assert region(x=1.5,scale=2.0)==3.0
 assert region.fallback_calls==0

def inline_container(x):return len([x])+x

def divide(x,y):return x/y

def helper_store(record):record.value += 2.0

def transitive_store(record):
 helper_store(record)
 return record.value > 0.0

def test_inline_temporary_container_is_not_a_scalar_entry():
 region=warmed(inline_container,2)
 assert not getattr(region.latest,'scalar_entry',False)
 assert region(3)==4

def test_transitive_store_retains_writeback():
 record=Record(0.0);region=warmed(transitive_store,record)
 assert record.value==2.0
 assert region(record) is True and record.value==4.0

def test_scalar_entry_error_then_success_resets_native_status():
 region=warmed(divide,4.0,2.0)
 try:region(1.0,0.0)
 except ZeroDivisionError:pass
 else:raise AssertionError('native failure did not replay Python')
 assert region(6.0,2.0)==3.0
 assert region.fallback_calls==1

def test_late_finalizer_still_declines_object_copy():
 record=Record(1.0);region=warmed(compare,record)
 try:
  Record.__del__=lambda self:None
  assert region(record) is True
  assert region.fallback_calls==1
 finally:del Record.__del__

def scalar_compare(x):return x > 0.0

def test_scalar_entry_rechecks_exact_types_and_float_edges():
 region=warmed(scalar_compare,1.0)
 assert region(-0.0) is False
 assert region(float('nan')) is False
 assert region(True) is True
 class Number(float):pass
 assert region(Number(-1.0)) is False
 assert region.fallback_calls>=1

def unused_random(generator,x):return x+1

def used_random(generator):return generator.randrange(100)

def inline_string(n):return len('ab'*n)

def test_unused_random_input_needs_no_state_export():
 import random
 from recompyler import _rng
 generator=random.Random(42);state=generator.getstate();region=warmed(unused_random,generator,2)
 assert not getattr(region.latest,'rng_used',False)
 with patch.object(_rng,'store',forbidden):assert region(generator,3)==4
 assert generator.getstate()==state

def test_used_random_input_preserves_exact_python_state():
 import random
 generator=random.Random(42);reference=random.Random(42);region=warmed(used_random,generator)
 assert reference.randrange(100) in range(100)
 assert getattr(region.latest,'rng_used',False)
 assert generator.getstate()==reference.getstate()
 assert region(generator)==reference.randrange(100)
 assert generator.getstate()==reference.getstate()

def test_inline_string_temporary_keeps_graph_boundary():
 region=warmed(inline_string,2)
 assert not getattr(region.latest,'scalar_entry',False)
 assert region(3)==6

def test_scalar_entry_rejects_rebound_root_before_native_or_loader():
 region=warmed(scalar,2);original=scalar.__code__
 try:
  scalar.__code__=(lambda x:-123).__code__
  with patch.object(region,'load',forbidden):assert region(3)==-123
  assert region.fallback_calls==1
 finally:scalar.__code__=original

def test_missing_flags_use_conservative_legacy_path():
 region=warmed(scalar,2)
 del region.latest.scalar_entry
 del region.latest.boundary_no_writeback
 del region.latest.needs_recursion_budget
 assert region(3)==7 and region.compiled_calls==2
