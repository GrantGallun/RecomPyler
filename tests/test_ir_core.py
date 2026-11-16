"""Bytecode stack SSA invariants, independent of source parsing or execution."""
import dis
from dataclasses import replace
import pytest

from recompyler.ir.builder import build, UnsupportedBytecode
from recompyler.ir.verifier import verify, VerificationError
from recompyler.ir.types import PYOBJECT, NULL, exact_type, join_types
from recompyler.ir.passes import PassManager


def choose(flag, left, right):
    return (left if flag else right) + left + right + left + right + left + right


def accumulate(items):
    total = 0
    for value in items:
        total += value
    return total


def invoke(function, value):
    return function(value)


def protected(value):
    try:
        return value.member
    except AttributeError:
        return None


def test_stack_phi_join_has_one_parameter_from_each_arm():
    graph = build(choose)
    verify(graph)
    joins = [b for b in graph.blocks.values() if len(b.parameters) == 1
             and len(graph.predecessors(b.offset)) == 2]
    assert len(joins) == 1
    assert all(len(e.arguments) == 1 for _, e in graph.predecessors(joins[0].offset))
    assert graph.code is choose.__code__
    assert graph.function is choose
    assert any(op.name == 'binary' for b in graph.blocks.values() for op in b.operations)


def test_loop_backedge_and_for_iter_exhaustion_skip_end_for():
    graph = build(accumulate)
    verify(graph)
    iterator = next(op for b in graph.blocks.values() for op in b.operations
                    if op.name == 'for_iter')
    block = graph.blocks[iterator.block]
    assert {e.kind for e in block.edges} == {'next', 'exhausted'}
    exhausted = next(e for e in block.edges if e.kind == 'exhausted')
    assert graph.blocks[exhausted.target].operations[0].instruction.opname == 'POP_ITER'
    assert len(exhausted.arguments) == 1
    assert any(e.target <= b.offset for b in graph.blocks.values() for e in b.edges)


def test_null_call_sentinel_is_explicit_and_consumed_by_call():
    graph = build(invoke)
    verify(graph)
    call = next(op for b in graph.blocks.values() for op in b.operations if op.name == 'call')
    assert len(call.arguments) == 3
    assert call.arguments[1].type == NULL
    assert call.attributes['positional'] == 1
    assert call.results[0].type == PYOBJECT


def test_exception_table_is_retained_and_handler_edges_are_explicit():
    graph = build(protected)
    verify(graph)
    entries = list(dis.Bytecode(protected).exception_entries)
    assert [(r.start, r.end, r.target, r.depth, r.lasti) for r in graph.exceptions] == [
        (r.start, r.end, r.target, r.depth, r.lasti) for r in entries]
    assert any(e.kind == 'exception' for b in graph.blocks.values() for e in b.edges)
    attr = next(op for b in graph.blocks.values() for op in b.operations if op.name == 'load_attr')
    assert attr.handler is not None
    assert attr.handler.target == entries[0].target


def test_builder_does_not_require_source_positions_or_source_files():
    namespace = {}
    exec(compile('def hidden(x):\n return x + 1\n', '<no-source>', 'exec'), namespace)
    graph = build(namespace['hidden'])
    verify(graph)
    assert graph.code is namespace['hidden'].__code__


def test_verifier_rejects_edge_stack_depth_mismatch():
    graph = build(choose)
    block = next(b for b in graph.blocks.values() if any(e.arguments for e in b.edges))
    edge = next(e for e in block.edges if e.arguments)
    block.edges[block.edges.index(edge)] = replace(edge, arguments=())
    with pytest.raises(VerificationError, match='stack|argument'):
        verify(graph)


def test_verifier_rejects_use_before_definition():
    graph = build(choose)
    block = next(b for b in graph.blocks.values() if any(op.name == 'binary' for op in b.operations))
    binary = next(op for op in block.operations if op.name == 'binary')
    block.operations[block.operations.index(binary)] = replace(binary, arguments=(binary.results[0],) * 2)
    with pytest.raises(VerificationError, match='definition|dominat'):
        verify(graph)


def test_types_keep_bool_distinct_from_int_and_null_from_none():
    assert exact_type(bool) != exact_type(int)
    assert join_types(exact_type(bool), exact_type(int)) == PYOBJECT
    assert NULL != exact_type(type(None))
    assert join_types(exact_type(int), exact_type(int)) == exact_type(int)


def test_pass_manager_verifies_each_transform():
    graph = build(choose)
    seen = []
    def identity(graph):
        seen.append(graph.code)
        return graph
    assert PassManager([identity]).run(graph) is graph
    assert seen == [choose.__code__]
    def broken(graph):
        graph.blocks[graph.entry].edges.clear()
        return graph
    with pytest.raises(VerificationError):
        PassManager([broken]).run(graph)



def closure_factory(owner, default):
    def read(value=default):
        return owner, value
    return read


def variadic_call(function, args, kwargs):
    return function(*args, **kwargs)


def method_call(owner, value):
    return owner.method(value)


@pytest.mark.parametrize('function', [closure_factory, variadic_call, method_call])
def test_function_cell_and_call_shapes_keep_original_bytecode(function):
    graph=build(function)
    verify(graph)
    original={i.offset:i.opname for i in dis.get_instructions(function)}
    for block in graph.blocks.values():
        for operation in block.operations:
            assert operation.instruction.opname==original[operation.offset]
    assert all(len(e.arguments)==len(graph.blocks[e.target].parameters)
               for b in graph.blocks.values() for e in b.edges)


def test_builds_actual_compiler_helpers_without_invoking_them():
    from recompyler import heap,lift
    for function in (heap._find,heap._Program.canon,lift._local_names):
        graph=build(function)
        verify(graph)
        assert graph.function is function and graph.code is function.__code__
        assert len(graph.blocks)>1


def test_generator_graph_does_not_execute_any_body_effect():
    effects=[]
    def suspended():
        effects.append(1)
        yield 1
    graph=build(suspended)
    assert any(op.name=='yield' for block in graph.blocks.values() for op in block.operations)
    assert effects==[]


def test_exception_only_values_cannot_be_used_on_normal_path():
    graph=build(protected)
    block=next(b for b in graph.blocks.values() if any(op.name=='exception_state' for op in b.operations))
    exceptional=next(op for op in block.operations if op.name=='exception_state')
    ordinary=next(op for op in block.operations if op.name!='exception_state')
    block.operations.append(replace(ordinary,name='pop',arguments=exceptional.results,results=()))
    with pytest.raises(VerificationError,match='exception'):
        verify(graph)


def test_edge_type_must_match_block_parameter_type():
    from recompyler.ir.types import exact_type
    graph=build(choose)
    block=next(b for b in graph.blocks.values() if b.parameters)
    original=block.parameters[0]
    block.parameters=(replace(original,type=exact_type(str)),)+block.parameters[1:]
    with pytest.raises(VerificationError,match='type|value'):
        verify(graph)


def comprehension(items):
    return [x for x in items]


def protected_finally(owner):
    try:
        return owner.member
    finally:
        owner.cleanup()


def test_cleared_unbound_local_remains_nullable_stack_value():
    graph=build(comprehension)
    take=next(op for b in graph.blocks.values() for op in b.operations if op.name=='frame.take')
    assert take.results[0].type.kind=='object-or-null'
    assert take.results[0].type.maybe_unbound


def test_reraise_records_saved_lasti_dependency():
    graph=build(protected_finally)
    operation=next(op for b in graph.blocks.values() for op in b.operations
                   if op.name=='reraise' and op.instruction.arg==1)
    assert len(operation.arguments)==2
    assert operation.arguments[1].type.kind=='int64'


def test_failing_operation_result_cannot_supply_exception_edge():
    graph=build(comprehension)
    block=next(b for b in graph.blocks.values() if any(o.name=='build_list' for o in b.operations))
    operation=next(o for o in block.operations if o.name=='build_list')
    index,edge=next((i,e) for i,e in enumerate(block.edges) if e.kind=='exception')
    block.edges[index]=replace(edge,arguments=(operation.results[0],)+edge.arguments[1:])
    with pytest.raises(VerificationError,match='definition|exception'):
        verify(graph)


def test_exact_type_lattice_uses_identity_without_metaclass_callbacks():
    calls=[]
    class Meta(type):
        def __eq__(cls,other):
            calls.append((id(cls),id(other)))
            raise RuntimeError('type comparison executed user code')
        def __hash__(cls):
            raise RuntimeError('type hashing executed user code')
    class Left(metaclass=Meta):pass
    class Right(metaclass=Meta):pass
    left=exact_type(Left);right=exact_type(Right)
    assert join_types(left,right)==PYOBJECT
    assert hash(left)==hash(exact_type(Left))
    assert left==exact_type(Left)
    assert calls==[]
