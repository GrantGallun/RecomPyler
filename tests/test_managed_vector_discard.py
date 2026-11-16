"""Unused vectorcall results follow POP_TOP ownership without an NRT owner."""
import gc
from types import SimpleNamespace
import pytest
from numba.core.runtime import rtsys, _nrt_python
from recompyler import heap


def discard_call(action):
    action()


def discard_keywords(action, value):
    action(value, flag=value)


def test_discarded_callback_result_adds_no_native_owner_allocation():
    region = heap.lift_calls(discard_call)
    events = []
    class Token:
        def __del__(self): events.append('drop')
    assert region(Token) is None
    _nrt_python.memsys_enable_stats()
    before = rtsys.get_allocation_stats().alloc
    assert region(Token) is None
    allocated = rtsys.get_allocation_stats().alloc - before
    assert allocated <= 2
    assert events == ['drop', 'drop']
    assert region.compiled_calls == 2 and region.managed_calls == 2 and region.fallback_calls == 0


def test_discard_keeps_variadic_closure_values_and_effects():
    marker = object()
    events = []
    def make_closure():
        def action(*args, **kwargs): events.append((args, kwargs))
        return action
    action = make_closure()
    region = heap.lift_calls(discard_keywords)
    assert region(action, marker) is None
    assert events == [((marker,), {'flag': marker})]
    assert region.compiled_calls == 1 and region.fallback_calls == 0


def test_discard_error_is_propagated_once_with_original_owner():
    error = ValueError('owned')
    events = []
    def action(): events.append('call'); raise error
    region = heap.lift_calls(discard_call)
    with pytest.raises(ValueError) as caught: region(action)
    assert caught.value is error and events == ['call']
    assert region.compiled_calls == 1 and region.fallback_calls == 0


def test_real_compiler_line_helper_discards_append_result():
    from recompyler._call_bridge import _Compiler
    state = SimpleNamespace(lines=[], indent=2)
    region = heap.lift_calls(_Compiler.line)
    assert region(state, 'value = 1') is None
    assert state.lines == ['        value = 1']
    assert region.compiled_calls == 1 and region.fallback_calls == 0


def test_bare_discard_operation_has_zero_native_allocations_inside_loop():
    from numba import njit, types
    from recompyler._managed_native import managed
    from recompyler._managed_vector import call_vector_discard
    def run(action, count):
        for index in range(count):
            if not call_vector_discard(action, (), None, 0): return False
        return True
    native = njit(run)
    signature = (managed, types.int64)
    native.compile(signature)
    native = native.overloads[signature].entry_point
    events = []
    def action(): events.append(1)
    assert native(action, 1) is True
    _nrt_python.memsys_enable_stats()
    before = rtsys.get_allocation_stats().alloc
    assert native(action, 10) is True
    # One managed input unbox owner; no per-call or return owner allocation.
    assert rtsys.get_allocation_stats().alloc - before == 1
    assert len(events) == 11

_DISCARD_EVENTS = []
class _DiscardArg:
    def __del__(self): _DISCARD_EVENTS.append('arg-drop')
class _DiscardResult:
    def __del__(self): _DISCARD_EVENTS.append('result-drop')
class _DiscardCallee:
    def __call__(self):
        _DISCARD_EVENTS.append('call')
        return _DiscardResult()
    def __del__(self): _DISCARD_EVENTS.append('callee-drop')


def _discard_action(value):
    _DISCARD_EVENTS.append('call')
    return _DiscardResult()


def discarded_argument():
    _discard_action(_DiscardArg())
    _DISCARD_EVENTS.append('after')


def discarded_callee():
    _DiscardCallee()()
    _DISCARD_EVENTS.append('after')


@pytest.mark.parametrize('function,expected', [
    (discarded_argument, ['call','arg-drop','result-drop','after']),
    (discarded_callee, ['call','callee-drop','result-drop','after']),
])
def test_call_temporaries_are_released_before_discarded_result(function, expected):
    _DISCARD_EVENTS.clear()
    function()
    assert _DISCARD_EVENTS == expected
    _DISCARD_EVENTS.clear()
    region = heap.lift_calls(function)
    assert region() is None
    assert _DISCARD_EVENTS == expected
    assert region.compiled_calls == 1 and region.fallback_calls == 0
