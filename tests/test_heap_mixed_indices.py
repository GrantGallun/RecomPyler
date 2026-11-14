"""Numeric-kind joins must retain checked Python list-index semantics."""
import pytest

from recompyler import heap


class State:
    def __init__(self, values):
        self.values = values
        self.calls = 0


class Index:
    def __init__(self, value):
        self.value = value
        self.calls = 0

    def __index__(self):
        self.calls += 1
        return self.value


def mixed_read(state, number, use_int):
    state.calls += 1
    index = number * 1.0
    if use_int:
        index = int(index)
    # Force mixed arithmetic in a function whose only result is an int. The
    # old floats_unseen optimization must not erase the index's kind tag.
    index = index + 0
    return state.values[index]


def mixed_write(state, number, use_int):
    state.calls += 1
    index = number * 1.0
    if use_int:
        index = int(index)
    state.values[index] = 17
    return state.values[index]


def mixed_augment(state, number, use_int):
    state.calls += 1
    index = number * 1.0
    if use_int:
        index = int(index)
    state.values[index] += 17
    return state.values[index]


def custom_index(state, index):
    state.calls += 1
    return state.values[index]


def append_rhs(state):
    state.values.append(99)
    return 3


def mixed_augmented_effect(state, number):
    index = number * 1.0
    index = int(index)
    state.values[index] += append_rhs(state)
    return state.values[-1]


@pytest.fixture(params=[False, True], ids=["python-loader", "native-loader"])
def loader(request, monkeypatch):
    if request.param:
        assert heap._native is not None, "native-loader cases require the support extension"
    monkeypatch.setattr(heap, "NATIVE", request.param)
    return request.param


@pytest.mark.parametrize("function,expected", [(mixed_read, 30), (mixed_write, 17), (mixed_augment, 47)])
def test_integer_tagged_mixed_index_executes_native(loader, function, expected):
    state = State([10, 20, 30])
    alias = state.values
    region = heap.lift_region(function)
    assert region(state, -1, True) == expected
    assert state.calls == 1 and state.values is alias
    assert type(state.values[-1]) is int
    assert (region.compiled_calls, region.fallback_calls) == (1, 0), region.problem
    assert not region.latest.fast_mixed


@pytest.mark.parametrize("number", [0, -1, 1.25, float("nan"), float("inf")])
def test_float_tag_never_becomes_a_python_index(loader, number):
    state = State([10, 20, 30])
    region = heap.lift_region(mixed_read)
    with pytest.raises(TypeError):
        region(state, number, False)
    assert state.calls == 1 and state.values == [10, 20, 30]
    assert region.compiled_calls == 0
    assert region.fallback_calls == 1


@pytest.mark.parametrize("number", [-4, 3, -(1 << 53), 1 << 53, -(1 << 63), (1 << 63) - 1])
def test_mixed_index_bounds_exit_before_visible_writeback(loader, number):
    state = State([10, 20, 30])
    region = heap.lift_region(mixed_write)
    with pytest.raises(IndexError):
        region(state, number, True)
    assert state.calls == 1 and state.values == [10, 20, 30]
    assert region.compiled_calls == 0
    assert region.fallback_calls == 1


def test_custom_index_preserves_python_hook_once(loader):
    state, index = State([10, 20, 30]), Index(-1)
    region = heap.lift_region(custom_index)
    assert region(state, index) == 30
    assert state.calls == index.calls == 1
    assert (region.compiled_calls, region.fallback_calls) == (0, 1)


def test_mixed_augmented_index_keeps_original_index_after_rhs_append(loader):
    state = State([10, 20])
    alias = state.values
    region = heap.lift_region(mixed_augmented_effect)
    assert region(state, -1) == 23
    assert state.values is alias and alias == [10, 20, 23]
    assert (region.compiled_calls, region.fallback_calls) == (1, 0), region.problem


def test_selected_loader_uses_actual_native_pack_when_requested(loader, monkeypatch):
    assert heap._native is not None
    original, calls = heap._native.load, []

    def observed(*args):
        calls.append(args[1])
        return original(*args)

    monkeypatch.setattr(heap._native, "load", observed)
    state = State([10, 20, 30])
    region = heap.lift_region(mixed_read)
    assert region(state, -1, True) == 30
    assert (region.compiled_calls, region.fallback_calls) == (1, 0), region.problem
    assert any(value is state for value in calls) is loader
