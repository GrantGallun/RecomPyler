"""Generator suspension values belong to resumption edges in the shared SSA."""
from dataclasses import replace
import inspect
import pytest
from recompyler.ir import build,verify
from recompyler.ir.verifier import VerificationError
from recompyler.ir.semantics import UnsupportedBytecode
from recompyler import depmap


def exchange(value):
    sent=yield value
    yield sent


def test_generator_graph_keeps_original_code_and_explicit_resumption_values():
    graph=build(exchange);verify(graph)
    assert graph.function is exchange and graph.code is exchange.__code__
    barriers=[op for b in graph.blocks.values() for op in b.operations if op.name in ('generator.start','yield')]
    assert [op.name for op in barriers]==['generator.start','yield','yield']
    for op in barriers:
        edge=next(edge for edge in graph.blocks[op.block].edges if edge.kind=='resume')
        assert edge.source_offset==op.offset and edge.arguments[-1] is op.results[0]
        assert len(graph.blocks[edge.target].parameters)==1


def test_actual_compiler_node_generator_uses_the_same_graph():
    graph=build(depmap._own_nodes);verify(graph)
    assert graph.function is depmap._own_nodes and graph.code is depmap._own_nodes.__code__
    assert any(op.name=='yield' for b in graph.blocks.values() for op in b.operations)


def test_graph_build_does_not_create_or_start_the_generator():
    effects=[]
    def values():
        effects.append('body')
        yield effects
    graph=build(values)
    assert effects==[] and graph.function is values
    iterator=values();assert inspect.isgenerator(iterator) and effects==[]
    assert next(iterator) is effects and effects==['body'];iterator.close()


def test_resume_values_cannot_be_reclassified_as_an_ordinary_jump():
    graph=build(exchange)
    block=next(b for b in graph.blocks.values() if any(op.name=='yield' for op in b.operations))
    edges=[replace(e,kind='jump') if e.kind=='resume' else e for e in block.edges]
    bad=replace(graph,blocks={**graph.blocks,block.offset:replace(block,edges=edges)})
    with pytest.raises(VerificationError,match='resume|suspension'):verify(bad)


def test_coroutine_graph_preserves_original_code_and_initial_resume():
    async def coroutine():return 1
    graph=build(coroutine);verify(graph)
    assert graph.function is coroutine and graph.code is coroutine.__code__
    assert any(op.name=='generator.start' for block in graph.blocks.values() for op in block.operations)



def test_generator_graph_alone_does_not_admit_a_native_producer():
    from recompyler.ir.lower_llvm import lower
    with pytest.raises(UnsupportedBytecode,match='generator.*resume'):lower(build(exchange),frame_entry=True)
