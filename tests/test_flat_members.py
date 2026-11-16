from array import array
import gc,struct,weakref,sys
import pytest
from recompyler._flat import FlatLifted

def read_member(box,index):return box.data[index]
def store_member(box,index,value):
 old=box.data[index];box.data[index]=value;return old
def partial_member(box,index):
 box.data[0]+=1.0;return box.data[index]
def scalar_member(box):return box.scale*box.data[0]
class Box:
 def __init__(self,data):self.data=data;self.scale=2.0

def bits(v):return struct.pack('!d',v)
def native(w,calls):
 assert w.compiled_calls==calls and w.flat_calls==calls and w.fallback_calls==0,w.problem
 assert w.last_audit['commits']==1 and w.last_audit['active']==0

@pytest.mark.parametrize('pattern',[0x8000000000000000,0x7ff8000000000042,0x3ff4000000000000])
def test_exact_member_read_first_warm(pattern):
 value=struct.unpack('!d',struct.pack('!Q',pattern))[0];box=Box(array('d',[value]));w=FlatLifted(read_member)
 for count in (1,2):assert bits(w(box,0))==bits(value);native(w,count)
 box.data.append(8.0)

def test_member_write_and_partial_rollback():
 box=Box(array('d',[4.5,-0.0]));w=FlatLifted(store_member)
 assert w(box,0,1.25)==4.5;native(w,1)
 assert box.data.tolist()==[1.25,-0.0]
 p=FlatLifted(partial_member);assert p(box,0)==2.25;native(p,1)
 with pytest.raises(IndexError):p(box,9)
 assert box.data[0]==3.25 and p.fallback_calls==1 and p.last_audit['rollbacks']==1
 box.data.append(8.0)

def test_scalar_fields_and_fresh_array_root_after_profile_entry():
 box=Box(array('d',[1.25]));w=FlatLifted(scalar_member)
 assert w(box)==2.5;native(w,1)
 replacement=array('d',[4.0]);hit=[]
 def profile(frame,event,arg):
  if not hit and event=='call' and frame.f_code is type(w)._invoke.__code__:
   hit.append(True);box.data=replacement;box.scale=3.0
 sys.setprofile(profile)
 try:assert w(box)==12.0
 finally:sys.setprofile(None)
 assert hit;native(w,2);replacement.append(8.0)

def test_local_instance_class_not_retained_by_compiled_member_metadata():
 def make():
  class Local:
   def __init__(self):self.data=array('d',[1.25])
  instance=Local();return instance,weakref.ref(Local)
 box,ref=make();w=FlatLifted(read_member)
 assert w(box,0)==1.25;native(w,1)
 del box;gc.collect();assert ref() is None


def test_properties_and_custom_getters_decline_without_extra_observation():
 events=[]
 class Descriptor:
  @property
  def data(self):events.append('property');return array('d',[1.25])
 w=FlatLifted(read_member);assert w(Descriptor(),0)==1.25
 assert events==['property'] and w.flat_calls==0 and w.fallback_calls==1


def test_warm_member_descriptor_change_declines_without_extra_getter():
 events=[]
 class Plain:pass
 box=Plain();box.data=array('d',[1.25]);w=FlatLifted(read_member)
 assert w(box,0)==1.25;native(w,1)
 def getter(self):events.append('get');return array('d',[8.5])
 Plain.data=property(getter)
 assert w(box,0)==8.5 and events==['get']
 assert w.compiled_calls==1 and w.fallback_calls==1


def test_profile_changes_getter_before_final_member_open():
 events=[]
 class Plain:pass
 box=Plain();box.data=array('d',[1.25]);w=FlatLifted(read_member)
 assert w(box,0)==1.25;native(w,1)
 def getter(self,name):
  if name=='data':events.append('data')
  return object.__getattribute__(self,name)
 hit=[]
 def profile(frame,event,arg):
  if not hit and event=='call' and frame.f_code is type(w)._invoke.__code__:
   hit.append(True);Plain.__getattribute__=getter
 sys.setprofile(profile)
 try:assert w(box,0)==1.25
 finally:sys.setprofile(None)
 assert events==['data'] and w.fallback_calls==1 and w.compiled_calls==1
 assert w.last_audit['failed']==1 and w.last_audit['close']==1
 box.data.append(8.0)


def test_member_dictionary_is_not_materialized_and_unread_values_are_inert():
 class Untouched:
  def __getattribute__(self,name):raise AssertionError('unused value touched')
 box=Box(array('d',[1.25]));box.other=Untouched();w=FlatLifted(read_member)
 assert w(box,0)==1.25;native(w,1)
 # Explicit dictionary materialisation on a later call is supported too.
 assert vars(box)['data'] is box.data
 assert w(box,0)==1.25;native(w,2)


def test_nonstring_dictionary_key_declines_without_extra_equality_calls():
 events=[]
 class Key:
  def __hash__(self):return hash('data')
  def __eq__(self,other):events.append('eq');return False
 box=Box(array('d',[1.25]));box.__dict__[Key()]=3
 events.clear();expected=read_member(box,0);before=events.copy();events.clear()
 w=FlatLifted(read_member);assert w(box,0)==expected
 assert events==before and w.fallback_calls==1 and w.flat_calls==0


def test_member_array_alias_occurrences_and_field_stores_decline():
 class Two:pass
 box=Two();box.data=array('d',[1.25]);box.other=box.data
 w=FlatLifted(two_members);assert w(box)==2.5
 assert w.flat_calls==0 and w.fallback_calls==1
 w=FlatLifted(replace_member);assert w(box,4.0)==4.0
 assert box.scale==4.0 and w.flat_calls==0 and w.fallback_calls==1


def two_members(box):return box.data[0]+box.other[0]

def replace_member(box,value):box.scale=value;return box.scale
