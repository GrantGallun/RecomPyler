import io
import random
import weakref
import pytest
from recompyler import profiler

class Plain:
    def __init__(self, value=3): self.value=value

@pytest.mark.parametrize('hook', ['__reduce__','__reduce_ex__','__getstate__','__setstate__','__copy__','__deepcopy__'])
def test_snapshot_rejects_hooks_without_calling_them(hook):
    events=[]
    class Hook(Plain): pass
    setattr(Hook,hook,lambda *args:events.append('called'))
    with pytest.raises(ValueError,match='snapshot rule:.*hook'):profiler.snapshot(Hook())
    assert events==[]

def test_snapshot_rejects_weakref_callbacks():
    obj=Plain(); events=[]; ref=weakref.ref(obj,lambda ref:events.append('destroyed'))
    with pytest.raises(ValueError,match='snapshot rule:.*weakref'):profiler.snapshot(obj)
    assert ref() is obj and events==[]

@pytest.mark.parametrize('factory',[lambda:io.BytesIO(b'abc'),lambda:random.Random(1)])
def test_snapshot_rejects_extension_instances(factory):
    with pytest.raises(ValueError,match='snapshot rule:'):profiler.snapshot(factory())

def test_snapshot_checks_static_fields_without_descriptors():
    events=[]
    class Trap:
        def __init__(self): self._value=3
        @property
        def value(self): events.append('descriptor');return self._value
    copied=profiler.snapshot(Trap())
    assert copied._value==3 and events==[]

def test_cached_pickle_rechecks_added_allocator():
    obj=Plain(); copier=profiler._Copies((obj,)); assert copier.blob is not None
    events=[]
    Plain.__new__=staticmethod(lambda cls:events.append('new') or object.__new__(cls))
    try:
        with pytest.raises(ValueError,match='snapshot rule:'):copier((obj,))
        assert events==[]
    finally:del Plain.__new__

def test_snapshot_rejects_custom_instance_dictionary_without_hooks():
    events=[]
    class Mapping(dict):
        def keys(self):events.append('keys');return super().keys()
    obj=Plain();obj.__dict__=Mapping(value=3)
    with pytest.raises(ValueError,match='snapshot rule:.*dictionary'):profiler.snapshot(obj)
    assert events==[]

def test_snapshot_rejects_nonstring_instance_dictionary_keys():
    events=[]
    class Key:
        def __hash__(self):events.append('hash');return 1
    obj=Plain();obj.__dict__[Key()]=7;events.clear()
    with pytest.raises(ValueError,match='snapshot rule:.*dictionary'):profiler.snapshot(obj)
    assert events==[]

def test_cached_pickle_does_not_trust_builtin_module_label():
    class Labeled:
        def __init__(self):self.value=3
    obj=Labeled();copier=profiler._Copies((obj,));assert copier.blob is not None
    Labeled.__module__='builtins';events=[]
    Labeled.__new__=staticmethod(lambda cls:events.append('allocated') or object.__new__(cls))
    with pytest.raises(ValueError,match='snapshot rule:'):copier((obj,))
    assert events==[]

def test_snapshot_rejects_overlapping_slots():
    class Base:
        __slots__=('x',)
    class Child(Base):
        __slots__=('x',)
    obj=Child();Base.x.__set__(obj,1);Child.x.__set__(obj,2)
    with pytest.raises(ValueError,match='snapshot rule:.*slot'):profiler.snapshot(obj)
