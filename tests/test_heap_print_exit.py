"""A reached print statement exits a transaction before observable effects."""
import builtins
import random

import numpy as np
import pytest

from recompyler import heap


class State:
    def __init__(self):
        self.values = [1]
        self.calls = 0


def print_argument(state):
    state.calls += 1
    return state.calls


def conditional_print(state, emit):
    state.values.append(2)
    if emit:
        print(print_argument(state), end="!")
    return state.values[-1]


def array_rng_print(values, rng, emit):
    values[0] += 1.0
    found = rng.random()
    if emit:
        print(found)
    return found


def bad_print_keyword(state, emit):
    state.values.append(2)
    if emit:
        print(print_argument(state), unknown=True)
    return 3


def custom_print(value, *, end="!"):
    return value + 4


def local_print(value):
    # This is a normal callable local, not the builtin observable statement.
    print = value
    print(3)
    return value.calls


class LocalPrinter:
    def __init__(self):
        self.calls = 0

    def __call__(self, value):
        self.calls += value


@pytest.fixture(params=[False, True], ids=["python-loader", "native-loader"])
def loader(request, monkeypatch):
    if request.param:
        assert heap._native is not None, "native-loader cases require the support extension"
    monkeypatch.setattr(heap, "NATIVE", request.param)


def test_unreached_print_statement_allows_positive_native_entry(loader, capsys):
    state = State()
    alias = state.values
    region = heap.lift_region(conditional_print)
    assert region(state, False) == 2
    assert state.values is alias and alias == [1, 2] and state.calls == 0
    assert capsys.readouterr().out == ""
    assert (region.compiled_calls, region.fallback_calls) == (1, 0), region.problem


def test_reached_print_rolls_back_and_evaluates_arguments_once(loader, capsys):
    state = State()
    alias = state.values
    region = heap.lift_region(conditional_print)
    assert region(state, False) == 2
    assert region(state, True) == 2
    assert state.values is alias and alias == [1, 2, 2] and state.calls == 1
    assert capsys.readouterr().out == "1!"
    assert (region.compiled_calls, region.fallback_calls) == (1, 1), region.problem
    assert region.gave_up[0] == conditional_print.__qualname__


def test_print_exit_restores_array_and_rng_before_python_replay(loader, capsys):
    values, rng = np.array([4.0]), random.Random(42)
    expected = random.Random(42).random()
    region = heap.lift_region(array_rng_print)
    assert region(values, rng, False) == expected
    rng.seed(42)
    assert region(values, rng, True) == expected
    assert values.tolist() == [6.0]
    reference = random.Random(42)
    reference.random()
    assert rng.getstate() == reference.getstate()
    assert capsys.readouterr().out == f"{expected}\n"
    assert (region.compiled_calls, region.fallback_calls) == (1, 1), region.problem


def test_print_error_and_argument_effect_happen_once(loader, capsys):
    state = State()
    region = heap.lift_region(bad_print_keyword)
    assert region(state, False) == 3
    with pytest.raises(TypeError):
        region(state, True)
    assert state.values == [1, 2, 2] and state.calls == 1
    assert capsys.readouterr().out == ""
    assert (region.compiled_calls, region.fallback_calls) == (1, 1), region.problem


def test_local_callable_named_print_still_executes_native(loader):
    target = LocalPrinter()
    region = heap.lift_region(local_print)
    assert region(target) == 3
    assert (region.compiled_calls, region.fallback_calls) == (1, 0), region.problem


def test_rebound_builtin_print_is_called_by_python_once(loader, monkeypatch):
    state, observed = State(), []
    region = heap.lift_region(conditional_print)
    assert region(state, False) == 2
    monkeypatch.setattr(builtins, "print", lambda value, **kwargs: observed.append((value, kwargs)))
    assert region(state, True) == 2
    assert state.calls == 1 and state.values == [1, 2, 2]
    assert observed == [(1, {"end": "!"})]
    assert (region.compiled_calls, region.fallback_calls) == (1, 1), region.problem


def test_global_function_named_print_keeps_normal_dispatch_and_rebinding(loader, monkeypatch, capsys):
    state = State()
    monkeypatch.setitem(globals(), "print", custom_print)
    region = heap.lift_region(conditional_print)
    assert region(state, True) == 2
    assert state.values == [1, 2] and state.calls == 1
    assert capsys.readouterr().out == ""
    assert (region.compiled_calls, region.fallback_calls) == (1, 0), region.problem
    monkeypatch.setitem(globals(), "print", builtins.print)
    assert region(state, True) == 2
    assert state.values == [1, 2, 2] and state.calls == 2
    assert capsys.readouterr().out == "2!"
    assert (region.compiled_calls, region.fallback_calls) == (1, 1)
