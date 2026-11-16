"""Simplification queries require proofs without calling application protocols."""
import pytest


def test_type_guard_proof_distinguishes_unknown_disjoint_and_unreachable():
    from recompyler.ir.simplify import type_guard,GuardDecision as G
    from recompyler.ir.type_lattice import exact_builtin,OBJECT,BOTTOM
    assert type_guard(exact_builtin(int),OBJECT) is G.PASS
    assert type_guard(exact_builtin(int),exact_builtin(float)) is G.FAIL
    assert type_guard(OBJECT,exact_builtin(int)) is G.UNKNOWN
    assert type_guard(BOTTOM,OBJECT) is G.UNREACHABLE


@pytest.mark.parametrize('value',[None,False,True,0,3,-0.0,float('nan'),complex(0,0),complex(0,2)])
def test_constant_truth_matches_cpython(value):
    from recompyler.ir.simplify import constant_truth
    from recompyler.ir.type_lattice import constant
    assert constant_truth(constant(value)) is bool(value)


def test_nonconstant_and_unknown_objects_are_not_evaluated():
    from recompyler.ir.simplify import constant_truth
    from recompyler.ir.type_lattice import OBJECT,from_value
    class Value:
        def __bool__(self):raise AssertionError('bool')
    assert constant_truth(OBJECT) is None and constant_truth(from_value(Value())) is None


@pytest.mark.parametrize('length,index,expected',[(4,0,0),(4,-1,3),(4,-4,0),(4,-5,None),(4,4,None),(0,0,None),(4,-2**100,None)])
def test_tuple_bounds_only_fold_proved_exact_indices(length,index,expected):
    from recompyler.ir.simplify import normalize_tuple_index
    assert normalize_tuple_index(length,index)==expected


def test_tuple_bounds_do_not_invoke_index_protocol():
    from recompyler.ir.simplify import normalize_tuple_index
    class Index:
        def __index__(self):raise AssertionError('index')
    with pytest.raises(ValueError):normalize_tuple_index(3,Index())
