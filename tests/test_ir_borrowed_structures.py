"""Callback-free structure guards for the shared S75 loop lowering."""
import ctypes
import pytest
from test_ir_structure_lowerings import Compiled
from recompyler import _structure_ops_native as provider, heap
from recompyler.ir import structure_lowerings as subject

def test_borrowed_attribute_hit_adds_no_owner_and_missing_has_no_error():
    load=Compiled('try_load_attr',2,borrowed=True)
    class Record:pass
    owner=Record();owner.value=object()
    assert load(owner,'value') is owner.value
    assert load(owner,'missing') is subject.GUARD_MISS
    assert all(provider.hits(cache)==0 for cache in load.lowerings.caches)

def test_borrowed_attribute_miss_does_not_invoke_descriptor_or_custom_getter():
    load=Compiled('try_load_attr',2,borrowed=True);events=[]
    class Record:
        @property
        def value(self):events.append('property');return None
    assert load(Record(),'value') is subject.GUARD_MISS and events==[]
    class Custom:
        def __getattribute__(self,name):events.append(name);return None
    assert load(Custom(),'value') is subject.GUARD_MISS and events==[]

def test_borrowed_attribute_dict_and_class_transitions_guard_without_callbacks():
    load=Compiled('try_load_attr',2,borrowed=True)
    class Record:pass
    owner=Record();marker=object();owner.value=marker
    assert load(owner,'value') is marker
    owner.__dict__={'value':marker}
    assert load(owner,'value') is subject.GUARD_MISS
    Record.value=property(lambda self:pytest.fail('guard invoked property'))
    assert load(owner,'value') is subject.GUARD_MISS

def test_identity_dict_guard_rejects_colliding_resident_callback_key():
    guard=Compiled('identity_dict_guard',1,status=True)
    class Root:pass
    class Next:pass
    calls=[]
    class Collision:
        def __hash__(self):return hash(Root)
        def __eq__(self,other):calls.append(other);return True
    key=Collision();mapping={key:Next}
    assert guard(mapping)==0 and calls==[]
    assert guard({Root:Next})==1 and guard({})==1
    class Mapping(dict):pass
    assert guard(Mapping())==0

def test_identity_root_guard_does_not_observe_metaclass_hash_or_equality():
    guard=Compiled('identity_key_guard',1,status=True)
    class Root:pass
    assert guard(Root)==1
    assert guard(object())==0 and guard(1)==0 and guard(None)==0
    class Meta(type):
        def __hash__(self):pytest.fail('guard hashed custom type')
        def __eq__(self,other):pytest.fail('guard compared custom type')
    class Custom(metaclass=Meta):pass
    assert guard(Custom)==0

def test_real_canon_dictionary_guard_is_general_and_rechecked_after_mutation():
    guard=Compiled('identity_dict_guard',1,status=True)
    program=object.__new__(heap._Program)
    class First:pass
    class Last:pass
    program.alias={First:Last}
    assert guard(program.alias)==1
    program.alias['mixed key']=First
    assert guard(program.alias)==0
    del program.alias['mixed key']
    assert guard(program.alias)==1
