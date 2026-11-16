"""Characterize the actual generated executable owner closure separately from Program."""
import gc
import weakref
from recompyler import heap

def read(cell):return cell.value>0.0

def make_class():
 class Local:
  def __init__(self,value):self.value=value
 return Local

def test_real_native_executable_can_outlive_an_argument_class():
 cls=make_class();watch=weakref.ref(cls);item=cls(2.5)
 region=heap.lift_region(read)
 assert region(item) is True and region.compiled_calls==1
 executable=region.latest.run
 assert executable.overloads
 # Retain dispatcher/cres/library/environment through their real owner graph.
 del region,item,cls
 gc.collect()
 assert watch() is None
 assert executable.overloads
