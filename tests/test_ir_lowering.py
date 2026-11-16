"""The common LLVM lowerer produces code, not semantic admission of inputs."""
from dataclasses import replace
import gc,weakref
import pytest
from llvmlite import ir
from recompyler import heap,_source_frames_native as provider
from recompyler.ir import build,verify
from recompyler.ir.entry import create_callable
from recompyler.ir.lower_llvm import lower
from recompyler.ir.symbols import CPythonSymbols


def callable_for(function,graph=None,structure_calls=None):
    result=lower(graph or build(function),structure_calls=structure_calls)
    entry=create_callable(function,result.body_address,result.keepalive,
        runner_address=provider.addresses()['run_vectorcall'])
    return entry,result


def test_generic_lowering_uses_shared_graph_and_raw_entry():
    fast,result=callable_for(heap._find)
    root=heap._Cell();leaf=heap._Cell();leaf.parent=root
    assert fast(leaf) is root
    assert result.graph.function is heap._find
    assert 'NRT' not in str(result.module)
    assert result.body_address>0


class TrackingCalls:
    def __init__(self):self.symbols=CPythonSymbols();self.seen=[]
    @property
    def keepalive(self):return (self,)
    def load_attr(self,builder,owner,name):
        self.seen.append('load_attr')
        pointer=ir.IntType(8).as_pointer()
        function=self.symbols.declare(builder.module,'PyObject_GetAttr',pointer,[pointer,pointer])
        return builder.call(function,[owner,name])


def selected(graph):
    for block in graph.blocks.values():
        block.operations=[replace(op,attributes={**op.attributes,'lowering':'structure.load_attr'})
                          if op.name=='load_attr' else op for op in block.operations]
    verify(graph)
    return graph


def test_selected_primitive_uses_common_opcode_retirement_and_pins_adapter():
    calls=TrackingCalls();reference=weakref.ref(calls)
    fast,lowered=callable_for(heap._find,selected(build(heap._find)),calls)
    assert calls.seen==['load_attr','load_attr']
    root=heap._Cell()
    del calls;gc.collect()
    assert reference() is not None
    assert fast(root) is root
    del fast,lowered;gc.collect()
    assert reference() is None


def test_selected_lowering_without_provider_declines_before_execution():
    from recompyler.ir.builder import UnsupportedBytecode
    with pytest.raises(UnsupportedBytecode,match='provider|lowering'):
        lower(selected(build(heap._find)))


def test_generic_dictionary_ops_have_same_original_error_site():
    fast,result=callable_for(heap._Program.canon)
    class Program:
        @property
        def alias(self):raise ValueError('alias unavailable')
    with pytest.raises(ValueError) as caught:fast(Program(),object())
    tb=caught.value.__traceback__
    while tb and tb.tb_frame.f_code is not heap._Program.canon.__code__:tb=tb.tb_next
    assert tb is not None
    assert tb.tb_lasti==next(op.offset for b in result.graph.blocks.values() for op in b.operations if op.name=='load_attr')


def test_actual_adaptive_selected_helpers_run_through_common_lowerer():
    from recompyler import _structure_ops_native
    from recompyler.ir.structure_lowerings import StructureCalls,specialize_structure_calls
    for function,args in ((heap._find,(heap._Cell(),)),):
        graph=build(function)
        profiles={op.offset:(heap._Cell,) for b in graph.blocks.values() for op in b.operations if op.name=='load_attr'}
        graph=specialize_structure_calls(graph,profiles)
        operations=[op for b in graph.blocks.values() for op in b.operations]
        assert any(op.attributes.get('lowering')=='structure.load_attr' for op in operations)
        ops=StructureCalls(CPythonSymbols(),_structure_ops_native)
        fast,code=callable_for(function,graph,ops)
        root=args[0]
        assert fast(root) is root
        # A changed receiver type takes the generic path at the same opcode.
        class Other:parent=None
        other=Other()
        assert fast(other) is other


def test_selected_contains_and_getitem_keep_both_collision_effects():
    from recompyler import _structure_ops_native
    from recompyler.ir.structure_lowerings import StructureCalls,select_structure_calls
    graph=select_structure_calls(build(heap._Program.canon),{'load_attr','contains','getitem'})
    calls=StructureCalls(CPythonSymbols(),_structure_ops_native)
    fast,code=callable_for(heap._Program.canon,graph,calls)
    events=[]
    class Root:pass
    class Terminal:pass
    class Noise:
        def __hash__(self):return hash(Root)
        def __eq__(self,other):events.append('eq');return False
    program=object.__new__(heap._Program)
    program.alias={Noise():Terminal,Root:Terminal}
    events.clear();expected=heap._Program.canon(program,Root);expected_events=list(events)
    events.clear();actual=fast(program,Root)
    assert actual is expected and events==expected_events
