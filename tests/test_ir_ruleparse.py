"""A ruleopt-compatible surface accepts only the proved checked-word subset."""
import pytest
from recompyler.ir.ruleproof import ProofFailure
from recompyler.ir.ruleparse import parse_rules, parse_proved_rules


def test_ruleopt_syntax_is_proved_before_registration():
    rules=parse_proved_rules("""
# Ported ruleopt surface.
add_zero: int_add(x, 0)
    => x
and_self: int_and(a, a)
    => a
""")
    assert len(rules)==2 and all(rule.digest for rule in rules)


def test_wrapping_reassociation_is_refused_for_checked_python_words():
    with pytest.raises(ProofFailure,match='counterexample'):
        parse_proved_rules("""
sub_add: int_sub(int_add(x, y), y)
    => x
""")


def test_guarded_rule_and_unsupported_dsl_fail_closed():
    assert parse_proved_rules("""
cancel: int_sub(int_add(x, 1), 1)
    check x < 127
    => x
""",width=8)
    for source in ('bad: int_div(x, 0)\n => x','bad: int_add(x, 0)\n C = 1\n => x',
                   'bad: int_add(x, 0)','bad: int_add(x, 0)\n => x\n => x'):
        with pytest.raises(ProofFailure):parse_proved_rules(source)


def test_duplicate_names_cannot_replace_a_proved_rule():
    with pytest.raises(ProofFailure,match='duplicate'):
        parse_rules('same: int_add(x, 0)\n => x\nsame: int_sub(x, 0)\n => x')

