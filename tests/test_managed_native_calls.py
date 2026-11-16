"""Public managed entry consumes the shared native child compiler."""
import pytest
from recompyler import heap


def entry(value):
    return value


@pytest.mark.parametrize("factory", [
    lambda fn, callees: heap.lift_calls(fn, callees=callees, call_kinds=True),
    lambda fn, callees: heap.lift_region(fn, backend="managed", callees=callees, call_kinds=True),
])
def test_real_unify_interprets_unproved_children_in_compiled_parent(factory):
    region = factory(heap._Program.unify, (heap._find,))
    assert region.run is not None, region.problem
    program, cell = heap._Program(entry), heap._Cell()
    assert region(program, cell, cell) is None
    assert region.compiled_calls == 1 and region.fallback_calls == 0
    assert region.native_helper_calls == 0
    assert region.managed_calls == 2 and region.managed_call_counts == {"function": 2}
    assert region.managed_dispatch_calls == 2
    assert region.managed_dispatch_counts == {"function": 2}


def child(values, action):
    values.append(action())
    return len(values)


def parent(values, action):
    return child(values, action)


def test_child_fallback_counters_share_the_root_layout():
    region = heap.lift_calls(parent, callees=(child,), call_kinds=True)
    assert region.run is not None, region.problem
    marker, values = [], []
    assert region(values, lambda: marker) == 1
    assert values[0] is marker
    assert region.native_helper_calls == 0 and region.fallback_calls == 0
    assert region.managed_calls == 1
    assert region.managed_call_counts == {"function": 1}
    assert region.managed_dispatch_counts == region.managed_call_counts


def test_managed_options_require_managed_backend():
    with pytest.raises(ValueError):
        heap.lift_region(entry, callees=())
