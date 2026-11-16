"""Native name operations preserve CPython binding and error metadata."""
import builtins
import pytest
from recompyler import heap
from recompyler._call_bridge import _read_name, _store_name

REAL_NAME_ERROR = NameError
REAL_UNBOUND_ERROR = UnboundLocalError
GLOBAL_OWNER = object()


def local_value(value):
    assigned = value
    return assigned


def absent_global():
    return native_missing_identifier


def conditional_local(assign, value):
    if assign:
        stored = value
    return stored


def rebound_global(action):
    first = GLOBAL_OWNER
    action()
    return first, GLOBAL_OWNER


def rebound_builtin(action, value):
    first = len(value)
    action()
    return first, len(value)


def observe_failure(call, *args):
    try:
        call(*args)
    except Exception as error:
        return type(error), error.args, getattr(error, 'name', None), error.__context__
    raise AssertionError('missing exception')


def test_plain_local_read_and_store_use_native_operations():
    region = heap.lift_calls(local_value)
    value = object()
    assert region(value) is value
    assert region.compiled_calls == 1 and region.fallback_calls == 0
    assert not any(item is _read_name or item is _store_name for item in region.pool)


def test_global_name_error_uses_interpreter_exception_type(monkeypatch):
    region = heap.lift_calls(absent_global)
    expected = observe_failure(absent_global)
    assert expected[0] is REAL_NAME_ERROR
    monkeypatch.setattr(builtins, 'NameError', ValueError)
    observed = observe_failure(region)
    assert observed == expected
    assert observed[2] is absent_global.__code__.co_names[0]
    assert region.compiled_calls == 1 and region.fallback_calls == 0


def test_unbound_local_uses_interpreter_exception_type(monkeypatch):
    region = heap.lift_structures(conditional_local)
    expected = observe_failure(conditional_local, False, object())
    assert expected[0] is REAL_UNBOUND_ERROR
    monkeypatch.setattr(builtins, 'UnboundLocalError', ValueError)
    assert observe_failure(region, False, object()) == expected
    assert region.compiled_calls == 1 and region.fallback_calls == 0


def test_global_result_owner_is_live_after_callback_rebinding():
    region = heap.lift_calls(rebound_global)
    first, second = object(), object()
    original = globals()['GLOBAL_OWNER']
    try:
        globals()['GLOBAL_OWNER'] = first
        def change(): globals()['GLOBAL_OWNER'] = second
        result = region(change)
        assert result[0] is first and result[1] is second
    finally:
        globals()['GLOBAL_OWNER'] = original
    assert region.compiled_calls == 1 and region.fallback_calls == 0


def test_builtin_lookup_is_live_after_callback_rebinding():
    region = heap.lift_calls(rebound_builtin)
    marker = object()
    def change(): globals()['len'] = lambda value: marker
    try:
        result = region(change, [])
        assert result[0] == 0 and result[1] is marker
    finally:
        globals().pop('len', None)
    assert region.compiled_calls == 1 and region.fallback_calls == 0


def test_custom_local_frame_keeps_mapping_get_and_set_protocols():
    from collections import UserDict
    import numpy as np
    events = []
    class Frame(UserDict):
        def get(self, key, default=None):
            events.append(('get', key))
            return super().get(key, default)
        def __setitem__(self, key, value):
            events.append(('set', key))
            return super().__setitem__(key, value)
    region = heap.lift_calls(local_value)
    marker = object()
    frame = Frame(value=marker)
    events.clear()
    result, ok = region.run(region.pool, frame, local_value.__globals__,
                            local_value.__builtins__, [None], np.zeros(1, dtype=np.int64))
    assert ok and result is marker and frame['assigned'] is marker
    assert events == [('get', 'value'), ('set', 'assigned'), ('get', 'assigned')]


def collision_lookup(action):
    action()
    return COLLISION_VALUE


def test_global_lookup_preserves_post_callback_key_errors():
    region = heap.lift_calls(collision_lookup)
    error = RuntimeError('key equality')
    class Key:
        def __hash__(self): return hash('COLLISION_VALUE')
        def __eq__(self, other): raise error
    key = Key()
    def change(): globals()[key] = 42
    try:
        with pytest.raises(RuntimeError) as caught: region(change)
        assert caught.value is error
    finally:
        globals().pop(key, None)
    assert region.compiled_calls == 1 and region.fallback_calls == 0
