"""Async scopes retain original bytecode and real suspension-edge values."""
import dis
import types
import pytest
from recompyler import heap
from recompyler.ir import build, verify

async def await_one(value):
    return await value

async def collect(values):
    return [value async for value in values]

async def immediate(value):
    return value

@pytest.mark.parametrize('function', [immediate, await_one, collect, heap._replay, heap.Region._resumed])
def test_async_original_scope_builds_without_executing_body(function):
    graph=build(function)
    verify(graph)
    assert graph.function is function and graph.code is function.__code__
    assert any(op.name=='generator.start' for block in graph.blocks.values() for op in block.operations)
    expected={i.offset for i in dis.get_instructions(function) if i.opname=='RESUME'}
    assert expected <= graph.blocks.keys()

@pytest.mark.parametrize('function, family', [(await_one,'get_awaitable'), (collect,'get_aiter'), (collect,'get_anext')])
def test_async_protocol_operations_preserve_iterator_ownership(function,family):
    graph=build(function)
    operation=next(op for block in graph.blocks.values() for op in block.operations if op.name==family)
    assert len(operation.arguments)==1 and len(operation.results)==1
    if family=='get_anext':
        block=graph.blocks[operation.block]
        # The async iterator remains live while its new awaitable is sent.
        outgoing=[edge for edge in block.edges if edge.kind!='exception']
        assert outgoing
        assert operation.arguments[0] in outgoing[0].arguments


def test_async_graph_build_does_not_invoke_or_create_coroutine():
    effects=[]
    async def source():
        effects.append('body')
        return effects
    graph=build(source)
    assert graph.function is source and effects==[]

@pytest.mark.parametrize('function, opcode, family, consumed, produced', [
    (await_one,'GET_AWAITABLE','get_awaitable',1,1),
    (collect,'GET_AITER','get_aiter',1,1),
    (collect,'GET_ANEXT','get_anext',0,1),
    (collect,'END_ASYNC_FOR','end_async_for',2,0),
])
def test_async_stack_contract_preserves_retained_iterator(function,opcode,family,consumed,produced):
    from recompyler.ir.semantics import contract
    instruction=next(i for i in dis.get_instructions(function) if i.opname==opcode)
    count,results,name,attrs=contract(instruction)
    assert (count,len(results),name)==(consumed,produced,family)


@pytest.mark.parametrize('factory_name',['_collected','_drained_async'])
def test_real_profiler_async_helper_uses_original_code_and_live_closure(factory_name):
    from recompyler import profiler
    effects=[]
    async def values():
        effects.append('body')
        yield effects
    wrapper=getattr(profiler,factory_name)(values)
    cells=dict(zip(wrapper.__code__.co_freevars,wrapper.__closure__))
    function=cells['function'].cell_contents
    graph=build(function);verify(graph)
    assert graph.function is function and graph.code is function.__code__
    assert any(op.name=='get_anext' for block in graph.blocks.values() for op in block.operations)
    assert effects==[]
