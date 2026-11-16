"""Fail-first positive in-memory runtime lifetime obligations (S46/S49).

Compilation must keep local classes eligible without retaining them afterward.
No direct execution is claimed by these ordinary-boundary witnesses.
"""
import gc
import weakref
import pytest
from recompyler import heap

def read_plain(value):return value.value > 0.0
def read_method(value):return value.read() > 0.0

def make_plain():
 class Local:
  def __init__(self,value):self.value=value
 return Local

def make_class_closure():
 class Local:
  bias=1.0
  def __init__(self,value):self.value=value
  def read(self):return self.value+__class__.bias
 return Local

@pytest.mark.parametrize('factory,reader',[(make_plain,read_plain),(make_class_closure,read_method)])
def test_successful_dynamic_class_collects_with_warm_cache_alive(factory,reader):
 cls=factory();events=[];watch=weakref.ref(cls,lambda ref:events.append('class'))
 item=cls(2.5);region=heap.lift_region(reader)
 assert reader(item) is True
 assert region(item) is True
 assert region.compiled_calls==1 and region.fallback_calls==0,region.problem
 # Observe retained cache/diagnostics while dropping all natural owners.
 assert region.latest is not None and region.programs
 del item,cls
 gc.collect()
 assert watch() is None
 assert events==['class']
 assert region.compiled_calls==1 and region.latest is not None

@pytest.mark.parametrize('factory,reader',[(make_plain,read_plain),(make_class_closure,read_method)])
def test_collected_same_name_class_is_replaced_without_old_executable_binding(factory,reader):
 region=heap.lift_region(reader)
 cls=factory();item=cls(2.5);watch=weakref.ref(cls)
 assert region(item) is True and region.compiled_calls==1
 del cls,item
 gc.collect();assert watch() is None
 replacement=factory();item=replacement(-2.5)
 assert region(item) is False
 assert region.compiled_calls==2 and region.fallback_calls==0,region.problem
