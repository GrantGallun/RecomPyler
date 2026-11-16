"""Independent S49 concrete range review regressions, no performance claims."""
import pytest
from recompyler.heap import lift_region


def repeated_range_literal(n):
    return [range(n)] * 2


def repeated_range_local(n):
    r = range(n)
    return [r] * 2


def temporary_range_tuple_owner(n, owner):
    len(range(n))
    return owner


def range_then_direct_extreme(start, stop, step):
    r = range(1)
    result = 99
    for item in range(start, stop, step):
        result = item
        break
    return result


def direct_extreme_then_range(start, stop, step):
    result = 99
    for item in range(start, stop, step):
        result = item
        break
    r = range(1)
    return result


@pytest.mark.parametrize('fn',[repeated_range_literal,repeated_range_local])
def test_repeated_range_container_is_refused_and_alias_exact(fn):
    wrapped=lift_region(fn)
    got=wrapped(3)
    assert type(got) is list and len(got)==2
    assert type(got[0]) is range and got[0] == range(3)
    assert got[0] is got[1]
    assert wrapped.fallback_calls==1


def test_temporary_range_does_not_skip_whole_region_owner_refusal():
    owner=(int('10000'),)
    wrapped=lift_region(temporary_range_tuple_owner)
    assert wrapped(3,owner) is owner
    assert wrapped.fallback_calls==1


@pytest.mark.parametrize('fn',[range_then_direct_extreme,direct_extreme_then_range])
@pytest.mark.parametrize('args',[( -(2**63),2**63-1,1),(2**63-1,-(2**63),-1)])
def test_new_range_region_preserves_extreme_direct_loop(fn,args):
    wrapped=lift_region(fn)
    got=wrapped(*args)
    expected=fn(*args)
    assert type(got) is type(expected) and got==expected
