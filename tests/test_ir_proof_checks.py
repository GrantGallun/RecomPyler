"""Redundancy counts prioritize checks; they never become proof premises."""
from dataclasses import replace
from recompyler.ir.builder import build
from recompyler.ir.proof_checks import CheckObservation, decide_checks, graph_digest, annotate_integer_proofs


def example(flag):
    return (12 if flag is None else 30)+1


def test_proved_and_unknown_checks():
    graph=build(example)
    offsets=[op.offset for b in graph.blocks.values() for op in b.operations if op.name=='binary']
    rows=[CheckObservation(graph_digest(graph),offset,'int64_overflow',0,100,0) for offset in offsets]
    decisions=decide_checks(graph,rows)
    assert all(d.action=='remove' for d in decisions)
    def unknown(x):return x+1
    other=build(unknown)
    offset=next(op.offset for b in other.blocks.values() for op in b.operations if op.name=='binary')
    decision=decide_checks(other,[CheckObservation(graph_digest(other),offset,'int64_overflow',0,10,0)])[0]
    assert decision.action=='watcher'


def test_stale_failed_unknown_and_unobserved_are_retained():
    graph=build(example)
    offset=next(op.offset for b in graph.blocks.values() for op in b.operations if op.name=='binary')
    row=CheckObservation(graph_digest(graph),offset,'int64_overflow',0,100,0)
    for changed in (replace(row,digest='stale'),replace(row,failed=1),replace(row,executed=0),
                    replace(row,kind='unsupported'),replace(row,offset=9999)):
        assert decide_checks(graph,[changed])[0].action!='remove'


def test_annotation_is_a_verified_pass_and_keeps_canonical_operations():
    graph=build(example)
    new=annotate_integer_proofs(graph)
    assert new is not graph
    assert [(o.name,o.offset) for b in new.blocks.values() for o in b.operations]==[
            (o.name,o.offset) for b in graph.blocks.values() for o in b.operations]
    assert any(o.attributes.get('integer_proof') for b in new.blocks.values() for o in b.operations)
    assert not any('integer_proof' in o.attributes for b in graph.blocks.values() for o in b.operations)


def test_actual_wave21_line_counters_cannot_authorize_deletion():
    from recompyler.ir.proof_checks import consume_counter_rows
    graph=build(example)
    rows=[dict(file=example.__code__.co_filename,function=example.__qualname__,
               line=example.__code__.co_firstlineno+1,kind='guard',detail='',
               executed=100,taken=0,never_failed=True,proof_required=True)]
    decisions=consume_counter_rows(graph,rows)
    assert decisions[0].action=='watcher'
    assert 'identity' in decisions[0].reason


def test_digest_binds_instruction_and_value_representation():
    graph=build(example)
    original=graph_digest(graph)
    block=next(b for b in graph.blocks.values() if any(o.results for o in b.operations))
    index=next(n for n,o in enumerate(block.operations) if o.results)
    operation=block.operations[index]
    block.operations[index]=replace(operation,instruction=operation.instruction._replace(opname='NOP'))
    assert graph_digest(graph)!=original


