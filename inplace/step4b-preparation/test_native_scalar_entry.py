"""Actual callable-boundary counterexamples for S43 Step4b.

These observations leave Region and its methods intact on a native hit.
"""
import sys
import pytest
from recompyler import heap


def arithmetic(value):
    return value * 3 + 7


def defaulted(value=4):
    return value * 3 + 7


def snapshot(region):
    assert heap._native is not None
    assert hasattr(heap._native, 'scalar_entry_snapshot'), 'real C scalar entry is absent'
    return heap._native.scalar_entry_snapshot(region)


def test_warm_deployed_callable_enters_no_python_bytecode():
    region = heap.lift_region(arithmetic)
    assert region(1000) == arithmetic(1000)
    assert region(1001) == arithmetic(1001)
    before = snapshot(region)
    seen = []
    def observe(frame, event, arg):
        if event == 'call':
            seen.append(frame.f_code)
    previous = sys.getprofile()
    try:
        sys.setprofile(observe)
        result = region(1002)
    finally:
        sys.setprofile(previous)
    assert result == arithmetic(1002)
    assert not seen, [code.co_qualname for code in seen]
    state = snapshot(region)
    assert state['vectorcall_enabled'] is True
    assert state['raw_entries'] == before['raw_entries'] + 1
    assert state['native_completions'] == before['native_completions'] + 1
    assert region.compiled_calls == region.jit_calls
    assert region.fallback_calls == 0


def test_checked_overflow_is_not_a_native_completion_and_next_call_resets():
    region = heap.lift_region(arithmetic)
    region(1000); region(1001)
    before = snapshot(region)
    compiled, fallback = region.compiled_calls, region.fallback_calls
    value = (1 << 63) - 1
    assert region(value) == arithmetic(value)
    failed = snapshot(region)
    # A proven pre-entry overflow rejection is also valid reference dispatch.
    entered = failed['raw_entries'] - before['raw_entries']
    assert entered in (0, 1)
    assert failed['checked_exits'] - before['checked_exits'] == entered
    assert failed['native_completions'] == before['native_completions']
    assert region.compiled_calls == compiled
    assert region.fallback_calls == fallback + 1
    assert region(1002) == arithmetic(1002)
    after = snapshot(region)
    assert after['native_completions'] == before['native_completions'] + 1


def test_instance_attempt_override_is_observed_after_binding():
    region = heap.lift_region(arithmetic)
    region(1000); region(1001)
    calls = []
    def replacement(args, kwargs=None, **options):
        calls.append((args, kwargs))
        return True, 99999
    region.attempt = replacement
    assert region(1002) == 99999
    assert len(calls) == 1


def test_same_method_object_with_changed_code_invalidates_native_hit():
    region = heap.lift_region(arithmetic)
    region(1000); region(1001)
    original = heap.Region.attempt.__code__
    def replacement(self, args, kwargs=None, *, _bound_entry=False):
        return True, 99999
    try:
        heap.Region.attempt.__code__ = replacement.__code__
        assert region(1002) == 99999
    finally:
        heap.Region.attempt.__code__ = original
    assert region(1003) == arithmetic(1003)


def test_live_original_code_mutation_deopts_and_restores():
    region = heap.lift_region(arithmetic)
    region(1000); region(1001)
    code = arithmetic.__code__
    def replacement(value):
        return value - 100
    try:
        arithmetic.__code__ = replacement.__code__
        assert region(1002) == 902
    finally:
        arithmetic.__code__ = code
    assert region(1003) == arithmetic(1003)


def test_keyword_default_wrong_type_and_large_integer_keep_reference_behavior():
    region = heap.lift_region(defaulted)
    region(1000); region(1001)
    assert region() == defaulted()
    assert region(value=1002) == defaulted(value=1002)
    assert region(1002.5) == defaulted(1002.5)
    assert region(1 << 100) == defaulted(1 << 100)
    with pytest.raises(TypeError):
        region(unexpected=2)
    assert region(1003) == defaulted(1003)


def test_counter_assignment_keeps_public_integer_storage():
    region = heap.lift_region(arithmetic)
    region(1000); region(1001)
    region.compiled_calls = 2000
    region.jit_calls = 3000
    assert region(1002) == arithmetic(1002)
    assert region.__dict__['compiled_calls'] == 2001
    assert region.__dict__['jit_calls'] == 3001
