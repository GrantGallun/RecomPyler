"""Previously compiled alternating specializations must not re-run preparation."""
import gc
import weakref
from unittest.mock import patch
from recompyler import heap

def plus_one(value):return value+1
class Record:
 def __init__(self,value):self.value=value
def present(record):return record.value is not None

def forbidden(*args,**kwargs):raise AssertionError('retained specialization repeated program preparation')

def test_alternating_scalar_specializations_reuse_retained_programs():
 region=heap.lift_region(plus_one)
 assert region(1)==2 and region(1.5)==2.5
 assert region.compiled_calls==2 and region.fallback_calls==0
 with patch.object(region,'_make_program',forbidden):
  assert region(3)==4
  assert region(2.5)==3.5
 assert region.compiled_calls==4 and region.fallback_calls==0

def test_alternating_object_layout_specializations_reuse_retained_programs():
 region=heap.lift_region(present)
 assert region(Record(1.0)) is True
 assert region(Record(None)) is False
 assert region.compiled_calls==2
 with patch.object(region,'_make_program',forbidden):
  assert region(Record(2.0)) is True
  assert region(Record(None)) is False
 assert region.compiled_calls==4 and region.fallback_calls==0

def test_variant_cache_does_not_own_cleared_programs():
 region=heap.lift_region(plus_one);region(1);region(1.5)
 old=weakref.ref(next(p for p in region.programs.values() if p is not region.latest))
 region.programs.clear();region.latest=None;gc.collect()
 assert old() is None

def test_retained_variant_still_obeys_live_code_invalidation():
 region=heap.lift_region(plus_one);region(1);region(1.5);original=plus_one.__code__
 try:
  plus_one.__code__=(lambda value:-7).__code__
  assert region(3)==-7
 finally:plus_one.__code__=original

def test_cleared_program_membership_is_not_resurrected_by_external_owner():
 region=heap.lift_region(plus_one);region(1);region(1.5)
 old=next(p for p in region.programs.values() if p is not region.latest)
 region.programs.clear();region.latest=None
 assert region(3)==4
 assert region.latest is not old and any(p is region.latest for p in region.programs.values())

def test_instance_resolver_override_is_observed_after_latest_mismatch():
 region=heap.lift_region(plus_one);region(1);region(1.5);region(2)
 calls=[]
 def resolve(args):calls.append(args);return None
 with patch.object(region,'program_for',resolve):assert region(2.5)==3.5
 assert calls==[(2.5,)] and region.fallback_calls==1

def test_class_resolver_override_is_observed_after_latest_mismatch():
 region=heap.lift_region(plus_one);region(1);region(1.5);region(2)
 calls=[]
 def resolve(self,args):calls.append(args);return None
 with patch.object(heap.Region,'program_for',resolve):assert region(2.5)==3.5
 assert calls==[(2.5,)] and region.fallback_calls==1

def test_subclass_resolver_override_is_observed_after_latest_mismatch():
 class Custom(heap.Region):
  def program_for(self,args):
   if getattr(self,'deny',False):self.seen=args;return None
   return super().program_for(args)
 region=Custom(plus_one);region(1);region(1.5);region(2);region.deny=True
 assert region(2.5)==3.5 and region.seen==(2.5,) and region.fallback_calls==1

def test_unseen_shape_still_uses_ordinary_preparation():
 region=heap.lift_region(plus_one);region(1);region(1.5);region(2)
 original=region._make_program;calls=[]
 def make():calls.append(True);return original()
 with patch.object(region,'_make_program',make):assert region(True)==2
 assert calls and type(region(True)) is int

def test_broken_retained_program_is_never_invoked():
 region=heap.lift_region(plus_one);region(1);region(1.5)
 old=next(p for p in region.programs.values() if p is not region.latest);old.broken=True
 with patch.object(old,'run',forbidden):assert region(3)==4
 assert region.fallback_calls==1

def same_record(record):return record

def test_retained_variant_preserves_returned_input_identity():
 region=heap.lift_region(same_record)
 a,b=Record(1.0),Record(None)
 assert region(a) is a and region(b) is b
 with patch.object(region,'_make_program',forbidden):
  c,d=Record(2.0),Record(None)
  assert region(c) is c and region(d) is d
 assert region.compiled_calls==4 and region.fallback_calls==0

def test_retained_variant_checked_overflow_replays_and_resets():
 region=heap.lift_region(plus_one);region(1);region(1.5)
 result=region(heap.INT_MAX)
 assert type(result) is int and result==plus_one(heap.INT_MAX)
 assert region.fallback_calls==1
 assert region(3)==4 and region.compiled_calls==3
