"""Independent-review counterexamples, preparation only.

Move to tests/ only after IMPLEMENT. No test in this file has been executed.
"""
import gc
import json
import os
from pathlib import Path
import subprocess
import sys
import weakref

import pytest

from recompyler import heap


class Value:
    def __init__(self, value):
        self.value = value


class Graph:
    def __init__(self, chosen, unrelated):
        self.chosen = chosen
        self.unrelated = unrelated


def read_value(cell):
    return cell.value


def compare_value(cell):
    return cell.value > 0.0


def read_graph(graph):
    return graph.chosen.value


def output_tuple(graph):
    value = graph.chosen.value
    successor = value + 1.0
    # Larger than CPython's small tuple freelist: output allocation must be real.
    return (
        value, successor, value, successor, value, successor,
        value, successor, value, successor, value, successor,
        value, successor, value, successor, value, successor,
        value, successor, value, successor, value, successor,
    )


def allocate_private_list(cell, count):
    return [cell.value] * count


def recursive_read(cell, count):
    if count == 0:
        return cell.value
    return recursive_read(cell, count - 1)


def overflow_read(cell):
    return cell.value + 1


def bounds_read(values, index):
    return values[index]


def divide_read(cell, divisor):
    return cell.value / divisor


def direct_call(fn, *args):
    region = heap.Region(fn)
    actual = region(*args)
    assert region.direct_calls == 1, getattr(region, "direct_problem", None)
    assert region.compiled_calls == 1, region.problem
    return region, actual


def test_managed_inline_record_can_replace_entire_dictionary_between_calls():
    # Existing schema discovery may materialize a sample's __dict__. Warm on a
    # separate sample, then give the cached direct path a fresh untouched owner.
    region, _ = direct_call(read_value, Value(float("1.5")))
    original = float("2.5")
    cell = Value(original)
    assert region(cell) is original
    assert region.direct_calls == 2
    # Accessing __dict__ before this assignment would conceal the inline case.
    replacement = float("91.25")
    cell.__dict__ = {"value": replacement}
    assert region(cell) is replacement
    assert region.direct_calls == 3


def test_dictionary_replacement_at_final_c_boundary_uses_current_storage():
    cell = Value(float("2.5"))
    region, _ = direct_call(read_value, cell)
    replacement = float("91.25")
    replacement_dict = {"value": replacement}
    native_entry = heap._native.direct_execute
    old_profile = sys.getprofile()
    changed = []

    def profile(frame, event, arg):
        if event == "c_call" and arg is native_entry and not changed:
            changed.append(True)
            cell.__dict__ = replacement_dict

    try:
        sys.setprofile(profile)
        actual = region(cell)
    finally:
        sys.setprofile(old_profile)
    assert changed == [True]
    assert cell.__dict__ is replacement_dict
    assert actual is replacement


def test_detaching_nested_owner_at_c_boundary_runs_weakref_immediately():
    graph = Graph(Value(float("2.5")), Value(float("3.5")))
    region, _ = direct_call(read_graph, graph)
    events = []
    original = weakref.ref(graph.chosen, lambda ref: events.append("weakref"))
    native_entry = heap._native.direct_execute
    old_profile = sys.getprofile()

    def profile(frame, event, arg):
        if event == "c_call" and arg is native_entry and not events:
            events.append("enter")
            graph.chosen = graph.unrelated
            events.append("leave")

    try:
        sys.setprofile(profile)
        actual = region(graph)
    finally:
        sys.setprofile(old_profile)
    assert events == ["enter", "weakref", "leave"]
    assert original() is None
    assert actual is graph.chosen.value


def test_output_gc_can_detach_unrelated_owner_without_delayed_weakref():
    original_number = float("2.5")
    graph = Graph(Value(original_number), Value(float("3.5")))
    region, _ = direct_call(output_tuple, graph)
    events = []
    unrelated = weakref.ref(graph.unrelated, lambda ref: events.append("weakref"))
    replacement = float("91.25")
    native_entry = heap._native.direct_execute
    old_profile = sys.getprofile()
    old_threshold = gc.get_threshold()
    was_enabled = gc.isenabled()
    armed = [False]
    ran = [False]

    def on_gc(phase, info):
        if phase == "start" and armed[0] and not ran[0]:
            ran[0] = True
            events.append("enter")
            graph.chosen.value = replacement
            graph.unrelated = None
            events.append("leave")

    def profile(frame, event, arg):
        if event == "c_call" and arg is native_entry and not armed[0]:
            # Every setup allocation is finished. The envelope must do no
            # tracked allocation before its raw reads stop and unrelated pins go.
            gc.set_threshold(1, 0, 0)
            gc.enable()
            armed[0] = True

    gc.collect()
    gc.disable()
    gc.callbacks.append(on_gc)
    try:
        sys.setprofile(profile)
        actual = region(graph)
    finally:
        gc.disable()
        sys.setprofile(old_profile)
        gc.callbacks.remove(on_gc)
        gc.set_threshold(*old_threshold)
        if was_enabled:
            gc.enable()
    assert ran == [True], "must observe real output-time GC, not merely arm it"
    assert events == ["enter", "weakref", "leave"]
    assert unrelated() is None
    assert graph.chosen.value is replacement
    assert len(actual) == 24
    assert all(part is original_number for part in actual[::2])
    assert all(part == 3.5 for part in actual[1::2])
    assert all(part is actual[1] for part in actual[1::2])
    assert region.direct_calls == 2


@pytest.mark.parametrize("exhaust", [False, True])
def test_private_capacity_growth_or_decline_releases_all_pins(monkeypatch, exhaust):
    number = float("2.5")
    cell = Value(number)
    region, first = direct_call(allocate_private_list, cell, 1)
    assert first[0] is number
    del first
    # Existing arena capacity controls exercise a real native allocation exit.
    region.slots = 128
    if exhaust:
        monkeypatch.setattr(heap, "MAX_SLOTS", 128)
    before = region.direct_calls
    actual = region(cell, 400)
    assert len(actual) == 400
    assert all(part is number for part in actual)
    assert cell.value is number
    if exhaust:
        assert region.direct_calls == before
        assert region.fallback_calls == 1
    else:
        assert region.direct_calls == before + 1
    released = []
    owner = weakref.ref(cell, lambda ref: released.append(True))
    del cell
    assert owner() is None
    assert released == [True]


def test_recursion_exit_replays_after_releasing_borrowed_owners(monkeypatch):
    number = float("2.5")
    cell = Value(number)
    region, actual = direct_call(recursive_read, cell, 1)
    assert actual is number
    before = region.direct_calls
    monkeypatch.setattr(heap, "MAX_DEPTH", 3)
    assert region(cell, 8) is number
    assert region.direct_calls == before
    assert region.fallback_calls == 1
    assert cell.value is number
    released = []
    owner = weakref.ref(cell, lambda ref: released.append(True))
    del cell
    assert owner() is None
    assert released == [True]


@pytest.mark.parametrize("fn,first_args,failing_args,error,expected", [
    (overflow_read, (Value(2),), (Value(2**63 - 1),), None, 2**63),
    (bounds_read, ([float("2.5")], 0), ([float("2.5")], 3), IndexError, None),
    (divide_read, (Value(2.5), 2.0), (Value(2.5), 0.0), ZeroDivisionError, None),
])
def test_checked_failure_does_not_count_success_or_change_inputs(
        fn, first_args, failing_args, error, expected):
    region, _ = direct_call(fn, *first_args)
    before = region.direct_calls
    value = failing_args[0]
    original = value.value if isinstance(value, Value) else value[0]
    if error is None:
        assert region(*failing_args) == expected
    else:
        with pytest.raises(error):
            region(*failing_args)
    assert region.direct_calls == before
    assert region.fallback_calls == 1
    assert (value.value if isinstance(value, Value) else value[0]) is original
    # A failed direct attempt must not leave stale maps that affect the next call.
    assert region(*first_args) == fn(*first_args)
    assert region.direct_calls == before + 1


def test_abi_mismatch_is_rejected_before_entry_and_keeps_arena_fallback(monkeypatch):
    native = heap._native
    bind = native.direct_bind
    seen = []

    def mismatched(capsule, expected_abi, expected_source_digest, owner):
        invalid = dict(expected_abi)
        invalid["version"] = expected_abi["version"] + 1
        seen.append(True)
        return bind(capsule, invalid, expected_source_digest, owner)

    monkeypatch.setattr(native, "direct_bind", mismatched)
    region = heap.Region(compare_value)
    assert region(Value(2.5)) is True
    assert seen, "must exercise descriptor binding, not an earlier decline"
    assert region.direct_calls == 0
    assert region.compiled_calls == 1
    assert "abi" in region.direct_problem.lower()


def test_saved_direct_aot_works_in_fresh_process_that_rejects_numba(tmp_path):
    # All subprocesses are children of the coordinator's locked test command.
    # Nothing in this preparation artifact has run yet.
    src = str(Path(heap.__file__).resolve().parent.parent)
    (tmp_path / "direct_case.py").write_text(
        "class Cell:\n"
        "    def __init__(self, value):\n"
        "        self.value = value\n"
        "\n"
        "def read(cell):\n"
        "    return cell.value\n",
        encoding="utf-8",
    )
    build = """
import json, sys
sys.path[:0] = [sys.argv[1], sys.argv[2]]
import direct_case
from recompyler.heap import Region, build_regions
number = float("7.25")
region = Region(direct_case.read)
assert region(direct_case.Cell(number)) is number
assert region.direct_calls == 1
section = build_regions([(("read", 5), direct_case.read, region)], sys.argv[1])
assert section is not None
print(json.dumps(section))
"""
    use = """
import json, sys
sys.path[:0] = [sys.argv[1], sys.argv[2]]
class NoNumba:
    def find_spec(self, fullname, path=None, target=None):
        if fullname == "numba" or fullname.startswith("numba."):
            raise ImportError("the saved direct artifact must not import Numba")
sys.meta_path.insert(0, NoNumba())
import direct_case
from recompyler.heap import Region
from recompyler.aot import load
section = json.loads(sys.argv[3])
module = load(section)
assert module is not None
row = section["functions"][0]
exports = {digest: getattr(module, name) for digest, name in row["exports"].items()}
region = Region(direct_case.read, ahead_of_time=exports, seeds=row.get("seeds"))
number = float("7.25")
actual = region(direct_case.Cell(number))
assert actual is number
assert region.compiled_calls == 1
assert region.direct_calls == 1
assert region.aot_calls == 1
assert region.jit_calls == 0
assert not any(name == "numba" or name.startswith("numba.") for name in sys.modules)
print("DIRECT_AOT_WITHOUT_NUMBA")
"""
    env = dict(os.environ, RECOMPYLER_CACHE=str(tmp_path / "cache"))
    made = subprocess.run(
        [sys.executable, "-c", build, str(tmp_path), src],
        text=True, capture_output=True, env=env, timeout=600,
    )
    assert made.returncode == 0, made.stderr[-4000:]
    section = made.stdout.strip().splitlines()[-1]
    json.loads(section)
    run = subprocess.run(
        [sys.executable, "-c", use, str(tmp_path), src, section],
        text=True, capture_output=True, env=env, timeout=300,
    )
    assert run.returncode == 0, run.stderr[-4000:]
    assert run.stdout.strip() == "DIRECT_AOT_WITHOUT_NUMBA"



def folded_arithmetic(cell):
    return cell.value, 1.25 + 2.5


def folded_unary(cell):
    return cell.value, -9007199254740993


@pytest.mark.parametrize("fn", [folded_arithmetic, folded_unary])
def test_original_bytecode_folded_expression_keeps_code_constant_identity(fn):
    cell = Value(float("2.5"))
    expected = fn(cell)
    region, actual = direct_call(fn, cell)
    assert actual[0] is cell.value
    assert actual[1] is expected[1]
    again = region(cell)
    assert again[1] is actual[1]
    assert region.direct_calls == 2

