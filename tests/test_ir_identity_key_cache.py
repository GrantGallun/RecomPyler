"""Non-owning identity-key-domain proofs follow CPython key-state versions."""
import ctypes,gc,weakref
from recompyler import _structure_ops_native as provider


def guard():
    cache=provider.new_identity_cache()
    library=ctypes.PyDLL(provider.__file__)
    function=ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.c_void_p,ctypes.c_void_p)(ctypes.cast(library.rc_structure_identity_dict_guard_cached,ctypes.c_void_p).value)
    address=provider.identity_cache_address(cache)
    return lambda value:function(id(value),address),cache


def test_positive_key_domain_reuses_state_across_value_changes():
    check,cache=guard()
    class First:pass
    class Last:pass
    mapping={First:Last}
    assert check(mapping)==1
    state=provider.identity_cache_state(cache)
    assert state[0]>=0 and state[1]>0
    mapping[First]=object()
    assert check(mapping)==1 and provider.identity_cache_state(cache)==state


def test_key_changes_invalidate_the_positive_domain_without_callbacks():
    check,cache=guard();events=[]
    class First:pass
    class Noise:
        def __hash__(self):events.append('hash');return hash(First)
        def __eq__(self,other):events.append('equal');return False
    mapping={First:object()}
    assert check(mapping)==1
    mapping[Noise()]=None;events.clear()
    assert check(mapping)==0 and events==[]
    mapping.clear()
    assert check(mapping)==1 and provider.identity_cache_state(cache)[1]>0
    mapping[First]=None
    assert check(mapping)==1


def test_cache_never_retains_dictionary_keys_or_values():
    check,cache=guard()
    class Marker:pass
    def observe():
        class Key:pass
        value=Marker();mapping={Key:value}
        references=weakref.ref(Key),weakref.ref(value)
        assert check(mapping)==1
        return references
    references=observe();gc.collect()
    assert all(reference() is None for reference in references)
    assert provider.identity_cache_state(cache)[1]>0


def test_nonexact_dict_and_custom_metaclass_keys_remain_conservative():
    check,_=guard();events=[]
    class Mapping(dict):
        def __iter__(self):raise AssertionError('user iterator')
    class Meta(type):
        def __hash__(self):events.append('hash');return type.__hash__(self)
    class Key(metaclass=Meta):pass
    mapping={Key:None};events.clear()
    assert check(Mapping())==0 and check(mapping)==0 and events==[]


def test_shared_split_keys_do_not_share_live_key_domain_proofs():
    check,_=guard()
    class Node:pass
    empty=Node();populated=Node();populated.key=1
    assert check(empty.__dict__)==1
    assert check(populated.__dict__)==0
    populated.__dict__.clear()
    assert check(populated.__dict__)==1
    empty.other=2
    assert check(empty.__dict__)==0
