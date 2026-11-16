"""Reject incorrect, vacuous, partial and unchecked integer rewrites."""
import pytest
from recompyler.ir.ruleproof import Rule, ProofFailure, prove, prove_catalogue


def test_catalogue_is_proved_before_use():
    rules=prove_catalogue(width=64)
    assert len(rules)>=8
    assert all(rule.digest and rule.width==64 for rule in rules)


def test_wrong_rule_has_counterexample():
    with pytest.raises(ProofFailure,match='counterexample'):
        prove(Rule('bad','x + 1','x'),width=8)


def test_checked_overflow_is_part_of_semantics():
    with pytest.raises(ProofFailure,match='counterexample'):
        prove(Rule('cancellation','(x + 1) - 1','x'),width=8)
    assert prove(Rule('guarded','(x + 1) - 1','x','x < 127'),width=8)


def test_vacuous_and_unsupported_rules_fail_closed():
    with pytest.raises(ProofFailure,match='vacuous'):
        prove(Rule('empty','x','x','x < -128'),width=8)
    for expression in ('f(x)','x.attr','x / 0','x << 64','__import__("os")'):
        with pytest.raises(ProofFailure):
            prove(Rule('unsupported',expression,'x'),width=8)


def test_proofs_bind_entire_rule_and_word_width():
    a=prove(Rule('add','x + 0','x'),width=8)
    b=prove(Rule('add','x + 0','x'),width=64)
    c=prove(Rule('add','x | 0','x'),width=8)
    assert len({a.digest,b.digest,c.digest})==3

