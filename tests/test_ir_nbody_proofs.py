"""Actual nbody facts are code-derived; profile counts never prove a guard."""
from dataclasses import replace
import gc
import weakref
from bench.libs.programs import _nbody
from recompyler.ir.builder import build
from recompyler.ir.proof_checks import (
    CheckCandidate, graph_digest, prove_checks, consume_counter_rows,
)
from recompyler.ir.memory_proofs import plan_memory
from recompyler.ir.virtual_proofs import plan_virtuals


def index_sites(graph):
    for block in graph.blocks.values():
        for op in block.operations:
            if op.name == 'binary' and op.attributes.get('oparg') == 26:
                yield op, 1
            elif op.name == 'store_subscr':
                yield op, 2


def test_nbody_constant_indices_have_count_free_exact_nonnegative_proofs():
    graph = build(_nbody())
    digest = graph_digest(graph)
    sites = list(index_sites(graph))
    assert len(sites) == 11
    candidates = [CheckCandidate(digest, op.offset, kind, argument)
                  for op, argument in sites for kind in ('exact_int', 'nonnegative')]
    decisions = prove_checks(graph, candidates)
    assert len(decisions) == 22
    assert all(d.action == 'remove' for d in decisions)
    assert all(d.digest == digest for d in decisions)
    # These are only index facts; no container-length or element-type claim.
    bounds = [replace(c, kind='index_in_bounds') for c in candidates]
    assert all(d.action == 'watcher' for d in prove_checks(graph, bounds))


def test_nbody_counter_and_slice_remain_unproved_without_runtime_witnesses():
    graph = build(_nbody())
    digest = graph_digest(graph)
    increment = next(op for block in graph.blocks.values() for op in block.operations
                     if op.name == 'binary' and op.attributes.get('oparg') == 0
                     and op.instruction.positions.lineno == _nbody().__code__.co_firstlineno + 4)
    assert prove_checks(graph, [CheckCandidate(digest, increment.offset,
                        'int64_overflow', 0)])[0].action == 'watcher'
    assert any(op.name == 'binary_slice' for b in graph.blocks.values() for op in b.operations)
    assert not plan_memory(graph).replacements
    assert not plan_virtuals(graph).removable


def test_count_free_certificates_reject_stale_invalid_and_unbound_sites():
    graph = build(_nbody())
    op, argument = next(index_sites(graph))
    candidate = CheckCandidate(graph_digest(graph), op.offset, 'exact_int', argument)
    for changed in (replace(candidate, digest='stale'), replace(candidate, offset=99999),
                    replace(candidate, argument=-1), replace(candidate, argument=True),
                    replace(candidate, offset=True), replace(candidate, argument=100)):
        assert prove_checks(graph, [changed])[0].action != 'remove'


def test_counter_batch_analyzes_once_and_preserves_mixed_row_order(monkeypatch):
    import recompyler.ir.proof_checks as checks
    graph = build(_nbody())
    op, argument = next(index_sites(graph))
    digest = graph_digest(graph)
    row = dict(kind='guard', graph_digest=digest, offset=op.offset,
               check_kind='exact_int', argument=argument, executed=10, taken=0)
    calls = []
    original = checks.analyze_intbounds
    def counted(graph):
        calls.append(graph)
        return original(graph)
    monkeypatch.setattr(checks, 'analyze_intbounds', counted)
    rows = [row, dict(kind='allocation', executed=100, taken=0), row,
            dict(row, taken=1), dict(row, executed=0)]
    assert [d.action for d in consume_counter_rows(graph, rows)] == [
        'remove', 'watcher', 'remove', 'watcher', 'retain']
    assert len(calls) == 1


def test_decisions_keep_no_function_or_graph_alive():
    function = _nbody()
    graph = build(function)
    function_ref, graph_ref = weakref.ref(function), weakref.ref(graph)
    op, argument = next(index_sites(graph))
    decisions = prove_checks(graph, [CheckCandidate(graph_digest(graph), op.offset,
                                                   'exact_int', argument)])
    del function, graph, op
    gc.collect()
    assert function_ref() is None and graph_ref() is None
    assert decisions[0].action == 'remove'


def test_audit_reports_actual_nbody_sites_without_transforming_or_installing():
    from bench.proof_audit import audit_function
    function = _nbody()
    report = audit_function(function)
    index_facts = [d for d in report['decisions']
                   if d['kind'] in ('exact_int', 'nonnegative')]
    assert len(index_facts) == 22
    assert all(d['action'] == 'remove' and d['operand_ids'] for d in index_facts)
    assert all(d['action'] == 'watcher' for d in report['decisions']
               if d['kind'] in ('index_in_bounds', 'int64_overflow'))
    assert not report['heap']['replacements'] and not report['virtual']['removable']
    assert not report['heap']['limited'] and not report['virtual']['limited']
    assert report['installed'] == 0 and report['graph_transformed'] is False
    assert report['graph_digest'] == graph_digest(build(function))


def test_nbody_rebound_enumerate_is_a_real_overflow_counterexample():
    from types import FunctionType
    original = _nbody()
    huge = 1 << 80
    def rebound(bodies):
        yield huge, bodies[0]
    changed = FunctionType(original.__code__, dict(original.__globals__, enumerate=rebound))
    graph = build(changed)
    increment = next(op for block in graph.blocks.values() for op in block.operations
                     if op.name == 'binary' and op.attributes.get('oparg') == 0
                     and op.instruction.positions.lineno == changed.__code__.co_firstlineno + 4)
    assert huge + 1 > (1 << 63) - 1
    assert prove_checks(graph, [CheckCandidate(graph_digest(graph), increment.offset,
                        'int64_overflow', 0)])[0].action == 'watcher'
    assert len(changed()) == 12
