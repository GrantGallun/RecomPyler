"""Optional managed-call kinds expose source and internal dispatch separately."""
import ast
import pytest
from recompyler import heap


def counted_operations(values, value, action):
    before = len(values)
    values.append(value)
    action()
    return before + 1


def failure_operation(action):
    return action()


def program_identity(value):
    return value


def counted_visitor(tree):
    found = []
    def visit(item):
        found.append(item.id)
    visit(tree)
    return found


def test_source_kinds_and_internal_dispatches_have_exact_totals():
    region = heap.lift_calls(counted_operations, call_kinds=True)
    values = []
    marker = object()
    events = []
    assert region(values, marker, lambda: events.append('action')) == 1
    assert values[0] is marker and events == ['action']
    assert region.compiled_calls == 1 and region.managed_calls == 3
    assert region.managed_call_counts == {'len': 1, 'append': 1, 'function': 1}
    assert region.managed_dispatch_counts == {'len': 1, 'append': 1, 'function': 1, 'arithmetic': 1}
    assert region.managed_dispatch_calls == 4 and region.fallback_calls == 0


def test_kind_counts_survive_error_and_reused_scratch():
    region = heap.lift_calls(failure_operation, call_kinds=True)
    error = ValueError('owned')
    def failure(): raise error
    with pytest.raises(ValueError) as caught: region(failure)
    assert caught.value is error
    marker = object()
    assert region(lambda: marker) is marker
    assert region.compiled_calls == region.managed_calls == 2
    assert region.managed_call_counts == region.managed_dispatch_counts == {'function': 2}
    assert region.managed_dispatch_calls == 2 and region.fallback_calls == 0


def test_profiled_structure_entry_keeps_native_root_counter_slots():
    program = heap._Program(program_identity)
    cell = heap._Cell()
    region = heap.lift_structures(heap._Program.unify, call_kinds=True)
    assert region(program, cell, cell) is None
    assert region.managed_calls == 2 and region.managed_call_counts == {'function': 2}
    assert region.managed_dispatch_calls >= 2 and region.fallback_calls == 0


def test_native_visitor_child_shares_optional_kind_layout():
    from recompyler._visitors import VisitorRegion
    region = VisitorRegion(counted_visitor, call_kinds=True)
    node = ast.Name(id='owned')
    result = region(node)
    assert result[0] is node.id
    assert region.native_helper_calls == 1 and region.managed_calls == 0
    assert region.managed_call_counts == {}
    assert region.managed_dispatch_calls == 0 and region.fallback_calls == 0


def test_default_entry_does_not_collect_kind_counters():
    region = heap.lift_calls(failure_operation)
    marker = object()
    assert region(lambda: marker) is marker
    assert region.managed_calls == 1 and region.counter_slots == 1
    assert region.managed_call_counts == region.managed_dispatch_counts == {}
    assert region.managed_dispatch_calls == 0


def test_public_managed_backend_exposes_optional_kind_counts():
    region = heap.lift_region(failure_operation, backend='managed', call_kinds=True)
    marker = object()
    assert region(lambda: marker) is marker
    assert region.managed_call_counts == {'function': 1}
    assert region.managed_dispatch_calls == 1
