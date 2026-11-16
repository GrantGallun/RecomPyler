"""Counter-free raw structure exports for the shared IR backend."""
import ctypes
import pytest
from recompyler import _structure_ops_native as native

_DECREf=ctypes.PYFUNCTYPE(None,ctypes.c_void_p)(ctypes.cast(ctypes.pythonapi.Py_DecRef,ctypes.c_void_p).value)

class Site:
 def __init__(self,counted=False):
  self.cache=native.new_cache();self.address=native.address(self.cache)
  self.library=ctypes.PyDLL(native.__file__)
  suffix='' if counted else '_uncounted'
  self.load=getattr(self.library,'rc_structure_load_attr'+suffix)
  self.load.argtypes=[ctypes.py_object,ctypes.py_object,ctypes.c_void_p];self.load.restype=ctypes.c_void_p
  self.store=getattr(self.library,'rc_structure_store_attr'+suffix)
  self.store.argtypes=[ctypes.py_object,ctypes.py_object,ctypes.py_object,ctypes.c_void_p];self.store.restype=ctypes.c_int
 def get(self,owner,name):
  pointer=self.load(owner,name,self.address)
  result=ctypes.cast(pointer,ctypes.py_object).value
  _DECREf(pointer)
  return result
 def put(self,owner,name,value):return self.store(owner,name,value,self.address)


def test_uncounted_attribute_exports_keep_identity_without_counter_updates():
 class Record:pass
 owner=Record();marker=object();owner.value=marker
 quiet=Site();counted=Site(True)
 for _ in range(3):
  assert quiet.get(owner,'value') is marker
  assert quiet.put(owner,'value',marker)==0
  assert counted.get(owner,'value') is marker
  assert counted.put(owner,'value',marker)==0
 assert native.hits(quiet.cache)==0
 assert native.hits(counted.cache)==6


def test_uncounted_attribute_exports_preserve_layout_and_descriptor_transitions():
 class Record:pass
 class Other:pass
 owner=Record();owner.value=None;site=Site()
 assert site.get(owner,'value') is None
 marker=object();owner.__class__=Other;owner.value=marker
 assert site.get(owner,'value') is marker
 events=[]
 class Descriptor:
  def __get__(self,owner,kind):events.append('get');return False
  def __set__(self,owner,value):events.append(value)
 Other.value=Descriptor()
 assert site.get(owner,'value') is False
 assert site.put(owner,'value',marker)==0 and events==['get',marker]
 with pytest.raises(AttributeError):site.get(owner,'missing')
 assert native.hits(site.cache)==0


def test_uncounted_store_publishes_before_replaced_value_finalizer():
 class Record:pass
 owner=Record();marker=object();events=[];site=Site()
 class Old:
  def __del__(self):events.append(owner.value is marker)
 owner.value=Old()
 assert site.put(owner,'value',marker)==0 and events==[True]
 assert site.get(owner,'value') is marker and native.hits(site.cache)==0
