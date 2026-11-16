"""Next M5 delegation graph tests; separate from current resume acceptance."""
import dis
import pytest
from recompyler import heap
from recompyler._prepared import PreparedIndex
from recompyler.ir import build,verify


def delegated(source):
    result=yield from source
    return result


@pytest.mark.parametrize('function',[delegated,PreparedIndex.iter_bind,heap._zero_parts])
def test_real_delegation_retains_receiver_and_result_on_both_send_edges(function):
    graph=build(function);verify(graph)
    send=[op for block in graph.blocks.values() for op in block.operations if op.name=='send']
    assert send and graph.code is function.__code__
    instructions=list(dis.get_instructions(function))
    following={a.offset:b.offset for a,b in zip(instructions,instructions[1:])}
    for operation in send:
        normal=[edge for edge in graph.blocks[operation.block].edges if edge.kind!='exception']
        assert len(normal)==2
        assert {edge.target for edge in normal}=={operation.instruction.jump_target,following[operation.offset]}
        assert len(operation.arguments)==2 and len(operation.results)==1
        for edge in normal:
            assert edge.arguments[-2] is operation.arguments[0]
            assert edge.arguments[-1] is operation.results[0]
    assert any(op.name=='end_send' for block in graph.blocks.values() for op in block.operations)
    assert any(op.name=='cleanup_throw' for block in graph.blocks.values() for op in block.operations)
