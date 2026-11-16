"""Next general call slice: CPython slice objects and real parameter metadata."""
import pytest
from recompyler import heap


def slice_call(value, lower, upper, step):
    return value[lower():upper():step()]


def whole_slice(value):
    return value[:]


def signature_subject(first, second=3, *items, option=4, **keywords):
    return first


def test_real_signature_names_uses_managed_slices():
    lifted = heap.lift_structures(heap._signature_names)
    result = lifted(signature_subject)
    assert result == heap._signature_names(signature_subject)
    assert all(any(name is original for original in signature_subject.__code__.co_varnames) for name in result)
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_slice_bounds_evaluate_before_getitem_with_original_key():
    events = []
    keys = []
    class Value:
        def __getitem__(self, key):
            events.append('getitem')
            keys.append(key)
            return key
    def lower():
        events.append('lower')
        return 1
    def upper():
        events.append('upper')
        return 8
    def step():
        events.append('step')
        return 2
    lifted = heap.lift_calls(slice_call)
    result = lifted(Value(), lower, upper, step)
    assert type(result) is slice and result is keys[0]
    assert (result.start, result.stop, result.step) == (1, 8, 2)
    assert events == ['lower', 'upper', 'step', 'getitem']
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_slice_bound_exception_has_no_replay():
    events = []
    error = ValueError('upper failed')
    def lower():
        events.append('lower')
        return 0
    def upper():
        events.append('upper')
        raise error
    def step():
        events.append('step')
        return 1
    lifted = heap.lift_calls(slice_call)
    with pytest.raises(ValueError) as caught:
        lifted([], lower, upper, step)
    assert caught.value is error
    assert events == ['lower', 'upper']
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_full_string_slice_keeps_original_owner():
    original = ''.join(['managed', 'slice', 'owner'])
    lifted = heap.lift_calls(whole_slice)
    assert lifted(original) is original
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_literal_slice_key_keeps_original_code_constant():
    class Value:
        def __getitem__(self, key):
            return key
    original = next(value for value in whole_slice.__code__.co_consts if type(value) is slice)
    lifted = heap.lift_calls(whole_slice)
    assert lifted(Value()) is original
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0
