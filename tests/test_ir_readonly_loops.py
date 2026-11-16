"""Read-only loop plans come from SSA operations, never helper names."""
import sys,types
import pytest
from recompyler import heap,_structure_ops_native,_source_frames_native as frames
from recompyler.ir import build
from recompyler.ir.entry import create_callable
from recompyler.ir.lower_llvm import lower
from recompyler.ir.symbols import CPythonSymbols
from recompyler.ir.structure_lowerings import StructureCalls
from recompyler.ir.readonly import plan_readonly_loop


def renamed_walk(value):
    while value.next is not None:
        value=value.next
    return value


def changed_read(value):
    while value.next is not None:
        value=value.other
    return value


def effects(value,events):
    while value.next is not None:
        events.append(value)
        value=value.next
    return value


def readonly_entry(function):
    calls=StructureCalls(CPythonSymbols(),_structure_ops_native)
    result=lower(build(function),structure_calls=calls,readonly_loops=True)
    return create_callable(function,result.body_address,result.keepalive,runner_address=frames.addresses()['run_vectorcall']),result


def test_traversal_plan_is_general_and_retains_original_sites():
    plan=plan_readonly_loop(build(renamed_walk))
    assert plan.kind=='attribute' and plan.state_slot==0 and plan.attribute=='next'
    assert plan.loop_offset>0
    mapping=plan_readonly_loop(build(heap._Program.canon))
    assert mapping.kind=='mapping' and mapping.owner_slot==0 and mapping.state_slot==1
    assert mapping.attribute=='alias'
    assert plan_readonly_loop(build(changed_read)) is None
    assert plan_readonly_loop(build(effects)) is None


def test_borrowed_loop_has_no_frame_or_stackref_housekeeping():
    fast,result=readonly_entry(renamed_walk)
    class Node:pass
    leaf=Node();root=Node();leaf.next=root;root.next=None
    assert fast(leaf) is root
    text=str(result.native_module)
    assert 'rc_ir_frame_enter' not in text
    assert 'word_close' not in text and 'word_from_owned' not in text
    assert 'rc_structure_try_load_attr' in text


def test_late_attribute_miss_falls_back_with_current_source_local():
    fast,result=readonly_entry(renamed_walk);events=[]
    class Plain:pass
    class Observed:
        @property
        def next(self):
            caller=sys._getframe(1)
            events.append((caller.f_code is renamed_walk.__code__,caller.f_locals['value'] is self))
            return None
    tail=Observed();leaf=Plain();leaf.next=tail
    assert fast(leaf) is tail
    assert events==[(True,True)]


def test_fused_mapping_keeps_foreign_collision_effects_on_fallback():
    fast,result=readonly_entry(heap._Program.canon);events=[]
    class Root:pass
    class Last:pass
    class Noise:
        def __hash__(self):return hash(Root)
        def __eq__(self,other):events.append('eq');return False
    class Program:pass
    owner=Program();owner.alias={Noise():Last,Root:Last}
    events.clear();expected=heap._Program.canon(owner,Root);expected_events=list(events)
    events.clear();actual=fast(owner,Root)
    assert actual is expected and events==expected_events


def test_mapping_guard_is_rechecked_each_entry_and_each_current_key():
    fast,result=readonly_entry(heap._Program.canon)
    class Root:pass
    class Last:pass
    class Program:pass
    owner=Program();owner.alias={Root:Last}
    for _ in range(2):assert fast(owner,Root) is Last
    owner.alias={Root:'terminal'}
    assert fast(owner,Root)=='terminal'
    owner.alias={'terminal':Last}
    assert fast(owner,'terminal') is Last


def test_attribute_descriptor_exception_keeps_original_code_and_offset():
    fast,result=readonly_entry(renamed_walk)
    class Node:
        @property
        def next(self):raise ValueError('next unavailable')
    with pytest.raises(ValueError,match='next unavailable') as caught:fast(Node())
    tb=caught.value.__traceback__
    while tb and tb.tb_frame.f_code is not renamed_walk.__code__:tb=tb.tb_next
    assert tb is not None
    graph=build(renamed_walk)
    assert tb.tb_lasti==next(op.offset for b in graph.blocks.values() for op in b.operations if op.name=='load_attr')


def test_guard_miss_after_chunk_preserves_current_local_and_lifetime():
    fast,result=readonly_entry(renamed_walk);events=[]
    class Node:pass
    leaf=Node();cursor=leaf
    for _ in range(150):
        successor=Node();cursor.next=successor;cursor=successor
    class Observed:
        @property
        def next(self):
            caller=sys._getframe(1)
            events.append(caller.f_code is renamed_walk.__code__ and caller.f_locals['value'] is self)
            return None
    tail=Observed();cursor.next=tail
    assert fast(leaf) is tail and events==[True]


def test_mapping_custom_metaclass_fallback_keeps_hash_callbacks():
    fast,result=readonly_entry(heap._Program.canon);events=[]
    class Meta(type):
        def __hash__(self):events.append('hash');return type.__hash__(self)
    class Root(metaclass=Meta):pass
    class Last:pass
    class Program:pass
    owner=Program();owner.alias={Root:Last}
    events.clear();expected=heap._Program.canon(owner,Root);observed=list(events)
    events.clear();actual=fast(owner,Root)
    assert actual is expected and events==observed


def test_fused_mapping_codegen_uses_guarded_one_lookup_and_fixed_scratch():
    fast,result=readonly_entry(heap._Program.canon)
    text=str(result.native_module)
    assert 'rc_structure_identity_dict_guard' in text
    assert text.count('call ptr @_PyDict_GetItem_KnownHash(')==1
    assert 'PyDict_GetItemRef' not in text and 'Py_DecRef' not in text
    assert 'word_close' not in text
    # The scratch array is in entry, rather than allocated on every backedge.
    first_loop=text.index('readonly_loop:')
    assert 'alloca' in text[:first_loop]
    assert 'alloca' not in text[first_loop:]
