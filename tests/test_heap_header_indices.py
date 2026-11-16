"""List predicates share proved header addresses without caching across writes."""
import array
import json
import os
from pathlib import Path
import re
import subprocess
import sys

import numpy as np
import pytest

from recompyler import heap
from recompyler.lift import same


def len_one_first(values):
    if len(values) == 1:
        return values[0]
    return -1.0


def len_one_item(values, index):
    if len(values) == 1:
        return values[index]
    return -1.0


def truth_item(values, index):
    if values:
        return values[index]
    return -1.0


class State:
    def __init__(self, values):
        self.values = values
        self.calls = 0


def len_then_append(state, alias):
    state.calls += 1
    if len(state.values) == 1:
        alias.append(99.0)
        return len(state.values), state.values[-1]
    return len(state.values), -1.0


def truth_then_pop(state):
    state.calls += 1
    if state.values:
        state.values.pop()
        return state.values[0]
    return -1.0


def other_containers(text, mapping, items):
    return len(text), not not text, len(mapping), not not mapping, len(items), not not items


def ndarray_length(values):
    return len(values)


@pytest.fixture(params=[False, True], ids=["python-loader", "native-loader"])
def loader(request, monkeypatch):
    monkeypatch.setattr(heap, "NATIVE", request.param)


@pytest.mark.parametrize("function,args", [(len_one_first, ([2.5],)),
                                           (truth_item, ([1.5, 2.5], -1))])
def test_native_predicate_and_item_share_physical_header(monkeypatch, function, args):
    monkeypatch.setattr(heap, "_cached_module", lambda source: None)
    region = heap.lift_region(function)
    assert region(*args) == 2.5
    assert region.compiled_calls == 1, region.problem
    body = region.latest.run
    signature = body.signatures[0]
    symbol = body.overloads[signature].fndesc.llvm_func_name
    llvm = body.inspect_llvm(signature)
    native = next(block.split("\n}", 1)[0] for block in llvm.split("define ")[1:]
                  if "@" + symbol + "(" in block.splitlines()[0])
    assert "load double" in native
    shape = r"%arg\.[FI]\.(?:2|5\.0)(?:\.\d+)?\b"
    assert not any(re.search(shape, line) for line in native.splitlines()[1:]), native
    if function is len_one_first:
        # The same header load says length == 1, so [0] cannot need a second
        # bounds-error path. This binds the intended read-sharing optimization.
        assert not re.search(r"\bstore i8 1\b", native), native
    else:
        assert re.search(r"icmp s[lg][te] i64 %arg\.v_index(?:\.\d+)?\b", native), native
        assert re.search(r"\bstore i8 1\b", native), native


def test_list_empty_length_truth_and_negative_items(loader):
    regions = [heap.lift_region(function) for function in (len_one_first, len_one_item, truth_item)]
    for values, expected_first, expected_last in [([2.5], 2.5, 2.5),
                                                  ([1.5, 2.5], -1.0, 2.5),
                                                  ([], -1.0, -1.0)]:
        assert regions[0](values) == expected_first
        assert regions[1](values, -1) == expected_first
        assert regions[2](values, -1) == expected_last
    assert all(region.compiled_calls == 3 for region in regions), [r.problem for r in regions]


@pytest.mark.parametrize("function", [len_one_item, truth_item])
def test_dynamic_index_bounds_remain_after_predicate(loader, function):
    region = heap.lift_region(function)
    assert region([2.5], -1) == 2.5
    for index in (-2, 1, -(1 << 63), (1 << 63) - 1):
        with pytest.raises(IndexError):
            region([2.5], index)
    assert (region.compiled_calls, region.fallback_calls) == (1, 4), region.problem


def test_length_predicate_reloads_header_after_alias_append(loader):
    state = State([10.0])
    alias = state.values
    region = heap.lift_region(len_then_append)
    assert region(state, alias) == (2, 99.0)
    assert state.values is alias
    assert (state.calls, state.values) == (1, [10.0, 99.0])
    assert region.compiled_calls == 1, region.problem


def test_truth_predicate_reloads_header_after_pop_and_rolls_back(loader):
    region = heap.lift_region(truth_then_pop)
    state = State([10.0, 20.0])
    assert region(state) == 10.0
    assert (state.calls, state.values) == (1, [10.0])
    empty = State([])
    assert region(empty) == -1.0
    assert empty.calls == 1
    failing = State([10.0])
    alias = failing.values
    assert region.attempt((failing,))[0] is False
    assert failing.values is alias
    assert (failing.calls, failing.values) == (0, [10.0])
    with pytest.raises(IndexError):
        region(failing)
    assert failing.values is alias
    assert (failing.calls, failing.values) == (1, [])
    assert (region.compiled_calls, region.fallback_calls) == (2, 1), region.problem


def test_byte_array_header_predicates_keep_exact_results(loader):
    first, truth = heap.lift_region(len_one_first), heap.lift_region(truth_item)
    for data, expected_first, expected_last in [([3], 3, 3), ([3, 4], -1.0, 4), ([], -1.0, -1.0)]:
        values = array.array("B", data)
        assert same(first(values), expected_first)
        assert same(truth(values, -1), expected_last)
    assert first.compiled_calls == truth.compiled_calls == 3, (first.problem, truth.problem)


def test_string_mapping_and_set_headers_keep_existing_paths(loader):
    region = heap.lift_region(other_containers)
    assert region("ab", {0: 1}, {2}) == (2, True, 1, True, 1, True)
    assert region("", {}, set()) == (0, False, 0, False, 0, False)
    assert region.compiled_calls == 2, region.problem


def test_ndarray_length_keeps_strided_and_empty_shapes(loader):
    region = heap.lift_region(ndarray_length)
    assert region(np.arange(5.0)[::-1]) == 5
    assert region(np.empty((0, 2))) == 0
    assert region.compiled_calls == 2, region.problem


def test_fresh_aot_header_predicates_reload_mutations_without_numba(tmp_path):
    functions = [(len_one_first, ([2.5],)), (truth_item, ([2.5], -1)),
                 (len_then_append, (State([10.0]), [10.0])),
                 (truth_then_pop, (State([10.0, 20.0]),))]
    entries = []
    for function, args in functions:
        region = heap.lift_region(function)
        region(*args)
        assert region.compiled_calls == 1, region.problem
        entries.append(((function.__name__, function.__code__.co_firstlineno), function, region))
    section = heap.build_regions(entries, tmp_path)
    assert section is not None
    plan = tmp_path / "section.json"
    plan.write_text(json.dumps(section), encoding="utf-8")
    env = dict(os.environ, PYTHONPATH=os.pathsep.join((str(Path(__file__).parent),
                                                     str(Path(heap.__file__).parents[1]))),
               RECOMPYLER_CACHE=str(tmp_path / "cache"), NUMBA_CACHE_DIR=str(tmp_path / "numba"))
    code = '''import json, sys
from recompyler import heap, aot
from recompyler.runner import _AotOnlyExports
from test_heap_header_indices import State, len_one_first, truth_item, len_then_append, truth_then_pop
section = json.load(open(sys.argv[1]))
module = aot.load(section)
functions = {fn.__name__: fn for fn in (len_one_first, truth_item, len_then_append, truth_then_pop)}
count = 0
for native in (False, True):
    heap.NATIVE = native
    for entry in section['functions']:
        fn = functions[entry['function']]
        calls = [0]
        def count_export(export):
            def call(*args):
                calls[0] += 1
                return export(*args)
            return call
        exports = _AotOnlyExports({digest: count_export(getattr(module, name)) for digest, name in entry['exports'].items()})
        region = heap.lift_region(fn, exports, seeds=entry.get('seeds'))
        fallbacks = 0
        if fn is len_one_first:
            assert region([2.5]) == 2.5 and region([]) == -1.0
            expected = entries = 2
        elif fn is truth_item:
            assert region([2.5], -1) == 2.5 and region([], -1) == -1.0
            expected = entries = 2
        elif fn is len_then_append:
            warm, alias = State([10.0]), [10.0]
            assert region(warm, alias) == (1, 10.0)
            assert (region.aot_calls, calls[0], region.fallback_calls) == (1, 1, 0)
            state = State([10.0])
            assert region(state, state.values) == (2, 99.0)
            assert (state.calls, state.values) == (1, [10.0, 99.0])
            # Preserve the previously failing distinct-contract/live-alias case:
            # it is now rejected before an additional native entry.
            expected = entries = fallbacks = 1
        else:
            state = State([10.0, 20.0])
            assert region(state) == 10.0 and (state.calls, state.values) == (1, [10.0])
            failing = State([10.0])
            assert region.attempt((failing,))[0] is False
            assert (failing.calls, failing.values) == (0, [10.0])
            expected, entries = 1, 2
        assert (region.aot_calls, region.jit_calls, region.fallback_calls, calls[0]) == (expected, 0, fallbacks, entries), (fn, region.problem)
        count += region.aot_calls
assert 'numba' not in sys.modules
print(count)
'''
    child = subprocess.run([sys.executable, "-c", code, str(plan)], env=env,
                           capture_output=True, timeout=180)
    (tmp_path / "child.stdout.bin").write_bytes(child.stdout)
    (tmp_path / "child.stderr.bin").write_bytes(child.stderr)
    assert child.returncode == 0, child.stderr.decode(errors="replace")[-6000:]
    assert child.stdout.strip() == b"12"
