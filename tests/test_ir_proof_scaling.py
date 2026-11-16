"""Scaling harness math and generated IR fixtures; no timing assertions."""
import pytest
from bench.proof_scaling import growth_exponent, make_case
from recompyler.ir.verifier import verify
from recompyler.ir.raw_passes import optimize_raw_words,optimize_raw_virtuals


def test_growth_fit_has_known_power_and_rejects_invalid_series():
    assert growth_exponent([(x,3*x**1.2) for x in (10,20,40,80)])==pytest.approx(1.2)
    for series in ([],[(1,1)],[(1,1),(1,2)],[(0,1),(2,3)],[(1,0),(2,3)]):
        with pytest.raises(ValueError):growth_exponent(series)


@pytest.mark.parametrize('family',['straight','branchy','raw_words','raw_heap','raw_virtual'])
def test_scaling_fixture_is_verified_and_uses_requested_size(family):
    fn,graph,effects=make_case(4,family)
    verify(graph)
    assert fn.__code__ is graph.code
    if family=='raw_words':
        transformed=optimize_raw_words(graph,effects)
        assert sum(op.name=='nop' for op in transformed.blocks[0].operations)==4
        sinks=[op for op in transformed.blocks[0].operations if op.name=='sink']
        assert len(sinks)==4 and len({op.arguments[0].id for op in sinks})==1
    elif family=='raw_virtual':
        transformed=optimize_raw_virtuals(graph,effects)
        assert sum(op.name=='nop' for op in transformed.blocks[0].operations)==12


def test_budget_exhaustion_is_reported_as_watcher_opportunity(monkeypatch):
    from recompyler.ir import proof_checks
    from recompyler.ir.int_analysis import analyze_intbounds
    from recompyler.ir.builder import build
    def target(flag):return (12 if flag is None else 30)+1
    graph=build(target);limited=analyze_intbounds(graph,work_limit=1)
    monkeypatch.setattr(proof_checks,'analyze_intbounds',lambda graph:limited)
    offset=next(op.offset for b in graph.blocks.values() for op in b.operations if op.name=='binary')
    row=proof_checks.CheckObservation(proof_checks.graph_digest(graph),offset,'int64_overflow',0,100,0)
    assert proof_checks.decide_checks(graph,[row])[0].action=='watcher'
