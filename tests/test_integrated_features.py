"""Regression checks for interactions between the merged coverage tracks."""
import types
import pytest
from recompyler.heap import lift_region


def keyword_helper(value, *, offset=2):
    return value + offset


module = types.ModuleType("integration_helpers")
module.keyword_helper = keyword_helper


def module_keyword_call(value):
    return module.keyword_helper(value, offset=7)


def conditional_values(flag):
    if flag:
        value = 5
    yield value


def consume_conditional(flags):
    result = []
    for flag in flags:
        for value in conditional_values(flag):
            result.append(value)
    return result


def variadic_values(first, *rest):
    yield rest


def consume_variadic():
    result = []
    for item in variadic_values(1, 2):
        result.append(item)
    return result


def recursive_values(n):
    if n:
        yield n
        yield from recursive_values(n - 1)


def consume_recursive(n):
    return sum(recursive_values(n))


def test_module_call_preserves_keywords():
    assert lift_region(module_keyword_call).attempt((3,)) == (True, 10)


def test_generator_unbound_read_preserves_exception():
    for flags in ([False], [True, False]):
        region = lift_region(consume_conditional)
        assert region.attempt((flags,))[0] is False
        with pytest.raises(UnboundLocalError):
            region(flags)


def test_generator_variadic_binding_preserves_tuple():
    region = lift_region(consume_variadic)
    assert region() == [(2,)]


def test_recursive_generator_collecting_call():
    assert lift_region(recursive_values).attempt((4,)) == (True, [4, 3, 2, 1])
    assert lift_region(consume_recursive)(4) == 10


def test_generator_entry_preserves_keyword_interface():
    assert lift_region(conditional_values).attempt((), {"flag": True}) == (True, [5])


_PICKLE_EFFECTS = []


class ReduceHook:
    def __init__(self):
        self.value = 3

    def __reduce__(self):
        _PICKLE_EFFECTS.append("reduce")
        return ReduceHook, ()


class ReduceExHook:
    def __init__(self):
        self.value = 3

    def __reduce_ex__(self, protocol):
        _PICKLE_EFFECTS.append("reduce_ex")
        return ReduceExHook, ()


class StateHook:
    def __init__(self):
        self.value = 3

    def __getstate__(self):
        _PICKLE_EFFECTS.append("getstate")
        return self.__dict__

    def __setstate__(self, state):
        _PICKLE_EFFECTS.append("setstate")
        self.__dict__.update(state)


class SetStateHook:
    def __init__(self):
        self.value = 3

    def __setstate__(self, state):
        _PICKLE_EFFECTS.append("setstate")
        self.__dict__.update(state)


class PlainCopy:
    def __init__(self, value):
        self.value = value


@pytest.mark.parametrize("kind", [ReduceHook, ReduceExHook, StateHook, SetStateHook])
def test_copy_optimization_does_not_run_nested_pickle_hooks(kind):
    from recompyler.profiler import _Copies
    _PICKLE_EFFECTS.clear()
    original = (PlainCopy({"nested": [kind()]}),)
    copier = _Copies(original)
    assert _PICKLE_EFFECTS == []
    assert copier.blob is None
    with pytest.raises(ValueError, match="snapshot rule:.*hook"):
        copier(original)
    assert _PICKLE_EFFECTS == []


def test_plain_copy_optimization_preserves_cycles_and_aliases():
    from recompyler.profiler import _Copies
    obj = PlainCopy([])
    obj.value.extend([obj, obj])
    arguments = (obj,)
    copier = _Copies(arguments)
    assert copier.blob is not None
    copied = copier(arguments)[0]
    assert copied is not obj
    assert copied.value[0] is copied
    assert copied.value[1] is copied


_ROOT = [[1]]
_ALIAS = _ROOT[0]


def read_nested_global(n):
    return _ROOT[0][0] + n


def mutate_nested_global(n):
    _ROOT[0].append(n)
    return len(_ROOT[0])


def first_row(array):
    return array[0]


def changed_first_row(array):
    array[0, 0] += 1.0
    return array[0]


def test_quiet_generator_loop_preserves_target_interleaving(tmp_path, capsys):
    import json
    from recompyler.runner import run_script
    script = tmp_path / "quiet.py"
    script.write_text("x = 0\ndef values():\n    for i in range(3):\n        yield x + 1\nfor x in values():\n    pass\nprint(x)\n")
    plan = tmp_path / "plan.json"
    plan.write_text(json.dumps({"plan": {"worth_running": True}, "functions": [
        {"function": "values", "line": 2, "generator": True,
         "candidate": {"status": "verified", "recommended": True, "engine": "region"}}]}))
    run_script(script, [], plan)
    assert capsys.readouterr().out == "3\n"


@pytest.mark.parametrize("native", [True, False])
@pytest.mark.parametrize("function", [first_row, changed_first_row])
def test_strided_returned_array_view_preserves_effects(native, function, monkeypatch):
    import numpy as np
    from recompyler import heap
    monkeypatch.setattr(heap, "NATIVE", native)
    actual = np.arange(12.0).reshape(3, 4)[:, ::-1]
    expected = actual.copy()
    expected_result = function(expected)
    region = lift_region(function)
    result = region(actual)
    np.testing.assert_array_equal(actual, expected)
    np.testing.assert_array_equal(result, expected_result)
    assert np.shares_memory(result, actual)
    assert result.strides == actual[0].strides


@pytest.mark.parametrize("function,expected", [(read_nested_global, 3), (mutate_nested_global, 2)])
def test_global_verification_preserves_nested_aliases(function, expected, monkeypatch):
    from recompyler import profiler
    monkeypatch.setattr(profiler, "warm_time", lambda *a, **k: 1.0)
    monkeypatch.setattr(profiler, "warm_start_time", lambda *a, **k: 0.0)
    _ROOT[:] = [_ALIAS]
    _ALIAS[:] = [1]
    result = profiler.test_region(function, [((2,), expected, (2,))], 1)
    assert result["status"] == "verified"
    assert _ROOT[0] is _ALIAS
    assert _ALIAS == [1]



def test_global_restore_preserves_cycles_and_original_nodes():
    from recompyler.profiler import _global_state, _restore_global
    child = []
    obj = PlainCopy(child)
    root = [child, obj]
    child.append(root)
    saved = _global_state(root)
    root[:] = [99]
    child[:] = [3]
    obj.value = [5]
    _restore_global(root, saved)
    assert root[0] is child
    assert root[1] is obj
    assert obj.value is child
    assert child[0] is root


def conversion_result(log, array):
    log.append(1)
    array[0, 0] += 1.0
    return array[0]


@pytest.mark.parametrize("native", [True, False])
def test_result_conversion_failure_rolls_back_before_heap_writeback(native, monkeypatch):
    import numpy as np
    from recompyler import heap
    monkeypatch.setattr(heap, "NATIVE", native)
    def reject_conversion(*args):
        raise heap._Mismatch
    monkeypatch.setattr(heap._Unloader, "result", reject_conversion)
    array = np.arange(6.0).reshape(2, 3)
    log = []
    region = lift_region(conversion_result)
    assert region.attempt((log, array))[0] is False
    assert log == []
    assert array[0, 0] == 0.0
    result = region(log, array)
    assert log == [1]
    assert array[0, 0] == 1.0
    assert np.shares_memory(result, array)
