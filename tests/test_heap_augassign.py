"""List augmented assignment captures operands once and sets after RHS effects."""
import pytest

from recompyler import heap


class State:
    def __init__(self, values):
        self.values = values
        self.base_calls = 0
        self.index_calls = 0
        self.rhs_calls = 0
        self.order = 0


def append_fives(values, count):
    for index in range(count):
        values.append(99.0)
    return 5.0


def augment_alias(values, alias, index, count):
    values[index] += append_fives(alias, count)
    return values[index]


def augment_spare_capacity(values, alias):
    alias.append(77.0)
    alias.pop()
    values[-1] += append_fives(alias, 1)
    return values[-1]


def original_base(state):
    state.base_calls += 1
    state.order = state.order * 10 + 1
    return state.values


def original_index(state, index):
    state.index_calls += 1
    state.order = state.order * 10 + 2
    return index


def append_rhs(state, count):
    state.rhs_calls += 1
    state.order = state.order * 10 + 3
    return append_fives(state.values, count)


def augment_evaluation_order(state, index, count):
    original_base(state)[original_index(state, index)] += append_rhs(state, count)
    return state.values[index]


def replace_index(state, index):
    state.index_calls += 1
    state.values = [99.0]
    return index


def augment_base_before_index_rebinding(state, index):
    original = state.values
    state.values[replace_index(state, index)] += 5.0
    return original, state.values


def replace_rhs(state):
    state.rhs_calls += 1
    state.values = [99.0]
    return 5.0


def augment_base_before_rhs_rebinding(state, index):
    original = state.values
    state.values[index] += replace_rhs(state)
    return original, state.values


def pop_rhs(state):
    state.rhs_calls += 1
    state.values.pop()
    return 5.0


def augment_after_shrink(state, index):
    state.values[index] += pop_rhs(state)
    return state.values


@pytest.fixture(params=[False, True], ids=["python-loader", "native-loader"])
def loader(request, monkeypatch):
    monkeypatch.setattr(heap, "NATIVE", request.param)


@pytest.mark.parametrize("index", [0, -1], ids=["positive", "negative"])
def test_augmented_store_reindexes_after_rhs_relocates_list(loader, index):
    values, expected = [10.0], [10.0]
    reference = augment_alias(expected, expected, index, 40)
    region = heap.lift_region(augment_alias)
    assert region(values, values, index, 40) == reference
    assert values == expected
    assert values == ([15.0] + [99.0] * 40 if index == 0 else [10.0] + [99.0] * 39 + [15.0])
    assert region.compiled_calls == 1, region.problem


def test_negative_augmented_store_renormalizes_when_capacity_is_unchanged(loader):
    values = [10.0]
    region = heap.lift_region(augment_spare_capacity)
    assert region(values, values) == 15.0
    assert values == [10.0, 15.0]
    assert region.compiled_calls == 1, region.problem


def test_base_index_and_rhs_run_once_in_python_order(loader):
    state = State([10.0])
    region = heap.lift_region(augment_evaluation_order)
    assert region(state, -1, 40) == 15.0
    assert state.values == [10.0] + [99.0] * 39 + [15.0]
    assert (state.base_calls, state.index_calls, state.rhs_calls, state.order) == (1, 1, 1, 123)
    assert region.compiled_calls == 1, region.problem


@pytest.mark.parametrize("function,counter", [
    (augment_base_before_index_rebinding, "index_calls"),
    (augment_base_before_rhs_rebinding, "rhs_calls"),
])
def test_original_base_survives_binding_changes(loader, function, counter):
    original = [10.0]
    state = State(original)
    region = heap.lift_region(function)
    before, after = region(state, 0)
    assert before is original
    assert after is state.values
    assert after is not original
    assert (original, state.values) == ([15.0], [99.0])
    assert getattr(state, counter) == 1
    assert region.compiled_calls == 1, region.problem


@pytest.mark.parametrize("index", [0, -1])
def test_shrinking_rhs_invalidates_setter_and_fallback_applies_effects_once(loader, index):
    state = State([10.0])
    original = state.values
    region = heap.lift_region(augment_after_shrink)
    # A native attempt must fail transactionally when the later setter is invalid.
    assert region.attempt((state, index))[0] is False
    assert state.values is original
    assert (state.values, state.rhs_calls) == ([10.0], 0)
    with pytest.raises(IndexError):
        region(state, index)
    assert state.values is original
    assert (state.values, state.rhs_calls) == ([], 1)
    assert region.fallback_calls == 1
