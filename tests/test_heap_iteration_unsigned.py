"""Ordinary list iteration preserves aliases while using proved physical slots."""
import array
import ast
import json
import os
from pathlib import Path
import re
import subprocess
import sys

import pytest

from recompyler import heap


def iteration_total(values):
    total = 0.0
    for item in values:
        total += item
    return total


def iteration_nested(left, right):
    total = 0.0
    for a in left:
        for b in right:
            total += a * b
    return total


class State:
    def __init__(self, values):
        self.values = values
        self.calls = 0
        self.steps = 0


def append_during_iteration(state, count):
    alias = state.values
    seen = []
    for item in alias:
        seen.append(item)
        if len(seen) == 1:
            for index in range(count):
                alias.append(float(index) + 10.0)
    return seen, alias


def pop_during_iteration(state):
    seen = []
    for item in state.values:
        seen.append(item)
        if len(state.values) > 1:
            state.values.pop()
    return seen


def clear_during_iteration(state):
    seen = []
    for item in state.values:
        seen.append(item)
        state.values.clear()
    return seen


def rebind_during_iteration(state):
    original = state.values
    seen = []
    for item in state.values:
        seen.append(item)
        state.values = [99.0]
    return seen, original


def nullable_tuple_items(values):
    total = 0.0
    for item in values:
        if item is not None:
            total += item[0]
    return total


class Item:
    def __init__(self, value):
        self.value = value


def nullable_object_items(values):
    total = 0.0
    for item in values:
        if item is not None:
            total += item.value
    return total


def iteration_body_index(values, index):
    total = 0.0
    for item in values:
        total += values[index]
    return total


def mutation_then_error(state, denominator):
    state.calls += 1
    total = 0.0
    for item in state.values:
        state.steps += 1
        if state.steps == 1:
            state.values.append(99.0)
        total += item / denominator
    return total


class _SourceOnly:
    def get(self, digest):
        return object()


def generated(function, *args):
    program = heap._Program(function)
    seen = {}
    for name, value in zip(program.entry.params, args):
        program.entry.vars[name] = heap._seed(program, value, seen)
    program.compile(_SourceOnly())
    return program


@pytest.fixture(params=[False, True], ids=["python-loader", "native-loader"])
def loader(request, monkeypatch):
    monkeypatch.setattr(heap, "NATIVE", request.param)


def test_iterator_generated_physical_reads_are_unsigned():
    # RED on a9b: ordinary for_loop still emits three signed physical reads.
    # Inspect only generated entry, never the runtime helpers' unrelated loops.
    program = generated(iteration_total, [1.5, 2.5])
    entry = next(n for n in ast.parse(program.source).body
                 if isinstance(n, ast.FunctionDef) and n.name == program.entry.name)
    reads = [n for n in ast.walk(entry) if isinstance(n, ast.Subscript)
             and isinstance(n.value, ast.Name) and n.value.id in {"F", "I"}
             and isinstance(n.ctx, ast.Load)]
    assert len(reads) >= 3
    for read in reads:
        assert isinstance(read.slice, ast.Call), ast.unparse(read)
        assert ast.unparse(read.slice.func) == "np.uint64", ast.unparse(read)


def test_iterator_native_llvm_omits_physical_negative_wrapping(monkeypatch):
    # RED independently at native lowering. Pure sum has no nullable payload,
    # dynamic Python index, or body store requiring arena shape/nitems values.
    monkeypatch.setattr(heap, "_cached_module", lambda source: None)
    region = heap.lift_region(iteration_total)
    assert region([1.5, 2.5]) == 4.0
    assert region.compiled_calls == 1, region.problem
    body = region.latest.run
    signature = body.signatures[0]
    symbol = body.overloads[signature].fndesc.llvm_func_name
    native = next(block.split("\n}", 1)[0]
                  for block in body.inspect_llvm(signature).split("define ")[1:]
                  if "@" + symbol + "(" in block.splitlines()[0])
    assert "load double" in native
    shape = r"%arg\.[FI]\.(?:2|5\.0)(?:\.\d+)?\b"
    assert not any(re.search(shape, line) for line in native.splitlines()[1:]), native


def test_iteration_empty_single_many_and_nested(loader):
    region = heap.lift_region(iteration_total)
    for values in ([], [2.5], [1.5, -2.0, 4.5]):
        assert region(values) == iteration_total(values)
    assert region.compiled_calls == 3, region.problem
    nested = heap.lift_region(iteration_nested)
    assert nested([1.0, 2.0], [3.0, 4.0]) == 21.0
    assert nested.compiled_calls == 1, nested.problem


def test_iterator_reloads_header_and_data_after_alias_append_relocation(loader):
    region = heap.lift_region(append_during_iteration)
    state = State([1.0])
    original = state.values
    seen, returned = region(state, 40)
    expected = [1.0] + [float(i) + 10.0 for i in range(40)]
    assert seen == expected
    assert returned is original is state.values
    assert original == expected
    assert region.compiled_calls == 1, region.problem
    # A one-item packed list starts with capacity1. Forty appends must grow its
    # data repeatedly; checking all41 observed items detects stale data/length.


def test_iterator_reloads_length_after_pop_and_clear(loader):
    pop = heap.lift_region(pop_during_iteration)
    state = State([1.0, 2.0, 3.0, 4.0, 5.0])
    original = state.values
    assert pop(state) == [1.0, 2.0, 3.0]
    assert state.values is original and original == [1.0, 2.0]
    assert pop.compiled_calls == 1, pop.problem
    clear = heap.lift_region(clear_during_iteration)
    state = State([1.0, 2.0, 3.0])
    original = state.values
    assert clear(state) == [1.0]
    assert state.values is original and original == []
    assert clear.compiled_calls == 1, clear.problem


def test_iterator_keeps_captured_list_when_source_field_is_rebound(loader):
    region = heap.lift_region(rebind_during_iteration)
    state = State([1.0, 2.0, 3.0])
    original = state.values
    seen, returned = region(state)
    assert seen == [1.0, 2.0, 3.0]
    assert returned is original and original == [1.0, 2.0, 3.0]
    assert state.values is not original and state.values == [99.0]
    assert region.compiled_calls == 1, region.problem


def test_byte_array_iteration_uses_same_address_proof(loader):
    region = heap.lift_region(iteration_total)
    for data in ([], [3], [1, 2, 255]):
        values = array.array("B", data)
        assert region(values) == iteration_total(values)
        assert list(values) == list(data)
    assert region.compiled_calls == 3, region.problem


def test_nullable_item_handle_values_keep_sentinels(loader):
    tuples = heap.lift_region(nullable_tuple_items)
    assert tuples([None, (1.5,), None, (2.5,)]) == 4.0
    assert tuples.compiled_calls == 1, tuples.problem
    objects = heap.lift_region(nullable_object_items)
    assert objects([None, Item(1.5), None, Item(2.5)]) == 4.0
    assert objects.compiled_calls == 1, objects.problem
    # Only list physical slots are proved. A loaded -1 handle and speculative
    # nullable-tuple payload must retain their existing signed/presence rules.


def test_body_logical_negative_indices_and_bounds_stay_checked(loader):
    region = heap.lift_region(iteration_body_index)
    assert region([1.0, 2.0, 3.0], -1) == 9.0
    for index in (-4, 3, -(1 << 63), (1 << 63) - 1):
        with pytest.raises(IndexError):
            region([1.0, 2.0, 3.0], index)
    assert (region.compiled_calls, region.fallback_calls) == (1, 4), region.problem


def test_mutating_iteration_error_rolls_back_then_replays_once(loader):
    region = heap.lift_region(mutation_then_error)
    warm = State([10.0, 20.0])
    assert region(warm, 1.0) == 129.0
    assert (warm.calls, warm.steps, warm.values) == (1, 3, [10.0, 20.0, 99.0])
    failing = State([7.0])
    original = failing.values
    assert region.attempt((failing, 0.0))[0] is False
    assert failing.values is original
    assert (failing.calls, failing.steps, original) == (0, 0, [7.0])
    with pytest.raises(ZeroDivisionError):
        region(failing, 0.0)
    assert failing.values is original
    assert (failing.calls, failing.steps, original) == (1, 1, [7.0, 99.0])
    assert (region.compiled_calls, region.fallback_calls) == (1, 1), region.problem


def test_fresh_aot_iteration_mutations_and_sentinels_without_numba(tmp_path):
    entries = []
    for function, args in (
        (iteration_total, ([1.5, 2.5],)),
        (append_during_iteration, (State([1.0]), 40)),
        (pop_during_iteration, (State([1.0, 2.0, 3.0, 4.0, 5.0]),)),
        (rebind_during_iteration, (State([1.0, 2.0, 3.0]),)),
        (nullable_tuple_items, ([None, (1.5,), None, (2.5,)],)),
        (mutation_then_error, (State([10.0, 20.0]), 1.0)),
    ):
        region = heap.lift_region(function)
        region(*args)
        assert region.compiled_calls == 1, region.problem
        entries.append(((function.__name__, function.__code__.co_firstlineno), function, region))
    section = heap.build_regions(entries, tmp_path)
    assert section is not None
    plan = tmp_path / "artifact.json"
    plan.write_text(json.dumps(section), encoding="utf-8")
    env = dict(os.environ, PYTHONPATH=os.pathsep.join((str(Path(__file__).parent),
                                                     str(Path(heap.__file__).parents[1]))),
               RECOMPYLER_CACHE=str(tmp_path / "cache"), NUMBA_CACHE_DIR=str(tmp_path / "numba"))
    code = '''import json, sys
from recompyler import heap, aot
from recompyler.runner import _AotOnlyExports
from test_heap_iteration_unsigned import State, iteration_total, append_during_iteration, pop_during_iteration, rebind_during_iteration, nullable_tuple_items, mutation_then_error
section = json.load(open(sys.argv[1]))
module = aot.load(section)
functions = {fn.__name__: fn for fn in (iteration_total, append_during_iteration, pop_during_iteration, rebind_during_iteration, nullable_tuple_items, mutation_then_error)}
total = 0
for native in (False, True):
    heap.NATIVE = native
    for entry in section['functions']:
        fn = functions[entry['function']]
        exports = _AotOnlyExports({digest: getattr(module, name) for digest, name in entry['exports'].items()})
        region = heap.lift_region(fn, exports, seeds=entry.get('seeds'))
        if fn is iteration_total:
            assert region([1.5, 2.5]) == 4.0
        elif fn is append_during_iteration:
            state = State([1.0]); original = state.values
            seen, returned = region(state, 40)
            assert seen == [1.0] + [float(i) + 10.0 for i in range(40)]
            assert returned is original is state.values
        elif fn is pop_during_iteration:
            state = State([1.0, 2.0, 3.0, 4.0, 5.0]); original = state.values
            assert region(state) == [1.0, 2.0, 3.0]
            assert state.values is original and original == [1.0, 2.0]
        elif fn is rebind_during_iteration:
            state = State([1.0, 2.0, 3.0]); original = state.values
            seen, returned = region(state)
            assert seen == [1.0, 2.0, 3.0] and returned is original
            assert state.values is not original and state.values == [99.0]
        elif fn is nullable_tuple_items:
            assert region([None, (1.5,), None, (2.5,)]) == 4.0
        else:
            warm = State([10.0, 20.0]); assert region(warm, 1.0) == 129.0
            state = State([7.0]); original = state.values
            assert region.attempt((state, 0.0))[0] is False
            assert (state.calls, state.steps, original) == (0, 0, [7.0])
            try:
                region(state, 0.0)
            except ZeroDivisionError:
                pass
            else:
                raise AssertionError('missing Python exception')
            assert state.values is original
            assert (state.calls, state.steps, original) == (1, 1, [7.0, 99.0])
        assert region.aot_calls == 1 and region.jit_calls == 0, (fn, region.problem)
        assert region.fallback_calls == (1 if fn is mutation_then_error else 0)
        total += region.aot_calls
assert 'numba' not in sys.modules
print(total)
'''
    child = subprocess.run([sys.executable, "-c", code, str(plan)], env=env,
                           capture_output=True, timeout=240)
    (tmp_path / "child.stdout.bin").write_bytes(child.stdout)
    (tmp_path / "child.stderr.bin").write_bytes(child.stderr)
    assert child.returncode == 0, child.stderr.decode(errors="replace")[-6000:]
    assert child.stdout.strip() == b"12"
