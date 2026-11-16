"""Next S90 slice: exact ordinary type keys use CPython's known-hash lookup."""
import random
from recompyler import heap,_structure_ops_native as provider,_source_frames_native as frames
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import create_callable
from recompyler.ir.symbols import CPythonSymbols
from recompyler.ir.structure_lowerings import StructureCalls,specialize_structure_calls


def prepared(owner,key):
    for _ in range(2000):heap._Program.canon(owner,key)
    calls=StructureCalls(CPythonSymbols(),provider)
    body=lower(specialize_structure_calls(build(heap._Program.canon),immediate_offsets=True),structure_calls=calls,readonly_loops=True)
    return create_callable(heap._Program.canon,body.body_address,body.execution_owner,runner_address=frames.addresses()['run_vectorcall']),body


def test_proved_identity_loop_uses_one_known_hash_lookup():
    class First:pass
    class Last:pass
    owner=object.__new__(heap._Program);owner.alias={First:Last}
    native,body=prepared(owner,First)
    assert native(owner,First) is Last
    text=str(body.native_module)
    assert text.count('call ptr @_PyDict_GetItem_KnownHash(')==1
    assert 'call ptr @PyDict_GetItemWithError(' not in text


def test_known_hash_chain_matches_original_for_dynamic_and_builtin_types():
    keys=[int,float,complex,tuple,str,bytes,type,object]+[type('Key'+str(i),(),{}) for i in range(600)]
    rng=random.Random(9017);rng.shuffle(keys)
    owner=object.__new__(heap._Program);owner.alias=dict(zip(keys,keys[1:]))
    native,_=prepared(owner,keys[0])
    for key in rng.sample(keys,80):assert native(owner,key) is heap._Program.canon(owner,key) is keys[-1]
    owner.alias.clear();owner.alias.update(zip(reversed(keys),reversed(keys[:-1])))
    for key in rng.sample(keys,80):assert native(owner,key) is heap._Program.canon(owner,key) is keys[0]


def test_known_hash_domain_miss_keeps_foreign_collision_effects():
    events=[]
    class First:pass
    class Last:pass
    class Noise:
        def __hash__(self):events.append('hash');return hash(First)
        def __eq__(self,other):events.append('equal');return False
    owner=object.__new__(heap._Program);owner.alias={First:Last}
    native,_=prepared(owner,First);assert native(owner,First) is Last
    owner.alias={Noise():None,First:Last}
    events.clear();expected=heap._Program.canon(owner,First);oracle=list(events);events.clear()
    assert native(owner,First) is expected and events==oracle
