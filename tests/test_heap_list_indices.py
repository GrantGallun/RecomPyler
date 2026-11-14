"""Checked physical list addresses retain signed Python indexing semantics."""
import array
import json
import os
from pathlib import Path
import re
import subprocess
import sys

import pytest

from recompyler import heap
from recompyler.lift import same


def read_item(values, index):
    return values[index]


def write_item(values, index, value):
    values[index] = value
    return values[index]


def augment_item(values, index, value):
    values[index] += value
    return values[index]


def recursive_item(values, index, depth):
    value = values[index]
    if depth > 0:
        return value + recursive_item(values, index, depth - 1)
    return value


class Cell:
    def __init__(self, value):
        self.value = value


class State:
    def __init__(self, values):
        self.values = values
        self.calls = 0


def effect_read(state, index):
    state.calls += 1
    return state.values[index]


def effect_write(state, index, value):
    state.calls += 1
    state.values[index] = value
    return state.values[index]


def grow_alias(state, alias, count, index):
    state.calls += 1
    for value in range(count):
        alias.append(float(value))
    return state.values[index]


@pytest.fixture(params=[False, True], ids=["python-loader", "native-loader"])
def loader(request, monkeypatch):
    monkeypatch.setattr(heap, "NATIVE", request.param)


@pytest.mark.parametrize("function,args,expected", [
    (read_item, ([1.5, 2.5], -1), 2.5),
    (write_item, ([1.5, 2.5], -1, 4.5), 4.5),
    (augment_item, ([1.5, 2.5], -1, 4.5), 7.0),
    (recursive_item, ([1.5, 2.5], -1, 2), 7.5),
])
def test_native_list_access_uses_no_arena_shape_for_physical_wrapping(monkeypatch, function, args, expected):
    # Reintroducing any signed header/final slot lookup makes a read depend on
    # the arena's shape, independently of the checked logical list index.
    monkeypatch.setattr(heap, "_cached_module", lambda source: None)
    region = heap.lift_region(function)
    assert region(*args) == expected
    assert region.compiled_calls == 1, region.problem
    program = region.latest
    if function is recursive_item:
        info = next(info for info in program.order if info.recursive)
        body = getattr(program.module, info.name + "_borrowed")
    else:
        body = program.run
    signature = body.signatures[0]
    symbol = body.overloads[signature].fndesc.llvm_func_name
    llvm = body.inspect_llvm(signature)
    native = next(block.split("\n}", 1)[0] for block in llvm.split("define ")[1:]
                  if "@" + symbol + "(" in block.splitlines()[0])
    assert re.search(r"load double|store double", native)
    assert re.search(r"icmp s[lg][te] i64 %arg\.v_index(?:\.\d+)?\b", native), native
    shape = r"%arg\.(?:[FI]\.(?:2|5\.0)|_heap_len)(?:\.\d+)?\b"
    for line in native.splitlines()[1:]:
        if re.search(shape, line):
            # The borrowed recursive ABI still forwards its common arena length.
            assert function is recursive_item and re.search(r"\bcall\b", line), line
    if function is recursive_item:
        assert re.search(r"\bcall\b[^\n]*@" + re.escape(symbol) + r"\(", native)


def test_signed_index_range_and_empty_list_keep_single_effect(loader):
    state = State([10.0, 20.0, 30.0])
    region = heap.lift_region(effect_read)
    for index, expected in [(0, 10.0), (2, 30.0), (-1, 30.0), (-3, 10.0)]:
        assert region(state, index) == expected
    for index in (-4, 3, -(1 << 63), (1 << 63) - 1):
        with pytest.raises(IndexError):
            region(state, index)
    assert (state.calls, state.values) == (8, [10.0, 20.0, 30.0])
    assert (region.compiled_calls, region.fallback_calls) == (4, 4), region.problem
    empty = State([])
    with pytest.raises(IndexError):
        region(empty, -1)
    assert empty.calls == 1


def test_item_kinds_keep_python_types_and_object_identity(loader):
    cell, replacement = Cell(1.5), Cell(2.5)
    cases = [([10, 20], 30), ([1.5, 2.5], -0.0), ([cell], replacement),
             ([(1.5, 2), (3.5, 4)], (5.5, 6)), ([None, (1.5, 2)], None)]
    for values, value in cases:
        read, write = heap.lift_region(read_item), heap.lift_region(write_item)
        expected = values[-1]
        actual = read(values, -1)
        assert same(actual, expected), (actual, expected, read.problem)
        if isinstance(expected, Cell):
            assert actual is expected
        actual = write(values, -1, value)
        assert same(actual, value), (actual, value, write.problem)
        assert same(values[-1], value)
        if isinstance(value, Cell):
            assert actual is values[-1] is value
        assert read.compiled_calls == write.compiled_calls == 1, (read.problem, write.problem)


def test_absent_tuple_payload_keeps_safe_signed_speculative_reads(loader):
    values = [None, (2.5, 7)]
    read = heap.lift_region(read_item)
    assert read(values, 0) is None
    assert read(values, -1) == (2.5, 7)
    assert read.compiled_calls == 2, read.problem
    write = heap.lift_region(write_item)
    assert write(values, -1, None) is None
    assert values == [None, None]
    assert write.compiled_calls == 1, write.problem


def test_array_byte_stores_keep_range_and_index_failures(loader):
    state = State(array.array("B", [3, 4]))
    region = heap.lift_region(effect_write)
    assert region(state, -1, 255) == 255
    for value in (-1, 256):
        with pytest.raises(OverflowError):
            region(state, -1, value)
    with pytest.raises(IndexError):
        region(state, 2, 7)
    assert state.calls == 4
    assert state.values.tolist() == [3, 255]
    assert (region.compiled_calls, region.fallback_calls) == (1, 3), region.problem


@pytest.mark.parametrize("exhaust", [False, True])
def test_alias_growth_reloads_current_header_and_retries_once(loader, monkeypatch, exhaust):
    if exhaust:
        monkeypatch.setattr(heap, "MAX_SLOTS", 128)
    state = State([1.0, 2.0, 3.0])
    alias = state.values
    region = heap.lift_region(grow_alias)
    region.slots = 128
    assert region(state, alias, 200, -1) == 199.0
    assert state.values is alias
    assert state.calls == 1
    assert alias == [1.0, 2.0, 3.0] + list(map(float, range(200)))
    assert region.compiled_calls == (0 if exhaust else 1), region.problem
    assert region.fallback_calls == (1 if exhaust else 0)
    if not exhaust:
        assert region.slots > 128


def test_fresh_aot_list_reads_and_stores_use_checked_indices_without_numba(tmp_path):
    entries = []
    for function, args in [(read_item, ([1.5, 2.5], -1)),
                           (write_item, ([1.5, 2.5], -1, 4.5)),
                           (recursive_item, ([1.5, 2.5], -1, 2))]:
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
from test_heap_list_indices import read_item, write_item, recursive_item
section = json.load(open(sys.argv[1]))
module = aot.load(section)
functions = {fn.__name__: fn for fn in (read_item, write_item, recursive_item)}
count = 0
for native in (False, True):
    heap.NATIVE = native
    for entry in section['functions']:
        fn = functions[entry['function']]
        exports = _AotOnlyExports({digest: getattr(module, name) for digest, name in entry['exports'].items()})
        region = heap.lift_region(fn, exports, seeds=entry.get('seeds'))
        values = [1.5, 2.5]
        if fn is write_item:
            assert region(values, -1, 4.5) == 4.5 and values == [1.5, 4.5]
        elif fn is recursive_item:
            assert region(values, -1, 2) == 7.5
        else:
            assert region(values, -1) == 2.5
        assert (region.aot_calls, region.jit_calls, region.fallback_calls) == (1, 0, 0), region.problem
        count += 1
assert 'numba' not in sys.modules
print(count)
'''
    child = subprocess.run([sys.executable, "-c", code, str(plan)], env=env,
                           capture_output=True, text=True, timeout=180)
    assert child.returncode == 0, child.stderr[-6000:]
    assert child.stdout.strip() == "6"
