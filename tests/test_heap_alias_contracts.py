"""Repeated identities cannot bypass a different saved representation contract."""
import array
import json
import os
from pathlib import Path
import subprocess
import sys

import numpy as np
import pytest

from recompyler import heap


class Holder:
    def __init__(self, values):
        self.values = values
        self.calls = 0


class Pair:
    def __init__(self, left, right):
        self.left = left
        self.right = right
        self.calls = 0


class Node:
    def __init__(self, values):
        self.values = values
        self.next = None


class Base:
    def __init__(self):
        self.value = 1

    def identify(self):
        return 1


class Derived(Base):
    def identify(self):
        return 2


def append_argument(state, alias):
    state.calls += 1
    alias.append(99.0)
    return len(state.values), state.values[-1]


def append_field(pair):
    pair.calls += 1
    pair.right.append(99.0)
    return len(pair.left), pair.left[-1]


def firsts(left, right):
    return left[0], right[0]


def increment_second(left, right):
    right[0] += 1
    return left[0]


def append_same(values, alias):
    alias.append(99.0)
    return len(values), values[-1]


def append_cycle(left, right):
    left.values.append(99.0)
    return left is right, left.next is right, right.values[-1]


def append_tuple(first, second):
    second[0].append(99.0)
    return len(first[0]), first[0][-1]


def append_mapping(first, second):
    second[0].append(99.0)
    return len(first[0]), first[0][-1]


def add_to_second(first, second):
    second.add(99)
    return len(first)


def append_same_mapping(first, second):
    return append_mapping(first, second)


def add_to_same(first, second):
    return add_to_second(first, second)


def array_firsts(first, second):
    return first[0], second[0]


def array_same_firsts(first, second):
    return first[0], second[0]


def object_dispatch(left, right):
    return left.identify(), right.identify()


@pytest.fixture(params=[False, True], ids=["python-loader", "native-loader"])
def loader(request, monkeypatch):
    if request.param:
        require_native()
    monkeypatch.setattr(heap, "NATIVE", request.param)
    return request.param


def require_native():
    native = heap._native
    if native is None or getattr(native, "LOAD_CONTRACTS_VERSION", 0) != 1:
        pytest.skip("versioned native loader extension is unavailable")
    return native


def check_loader(region, args, native, program=None):
    packed, _ = region.load(program or region.latest, args)
    assert packed.native is native
    if native:
        assert getattr(heap._native, "LOAD_CONTRACTS_VERSION", 0) == 1


def test_cached_field_argument_alias_does_not_lose_writeback(loader):
    state, alias = Holder([10.0]), [10.0]
    region = heap.lift_region(append_argument)
    assert region(state, alias) == (1, 10.0)
    shared = Holder([10.0])
    assert region(shared, shared.values) == (2, 99.0)
    assert (shared.calls, shared.values) == (1, [10.0, 99.0])
    assert (region.compiled_calls, region.fallback_calls) == (1, 1)
    check_loader(region, (state, alias), loader)


def test_cached_alias_inside_object_is_guarded_recursively(loader):
    warm = Pair([10.0], [10.0])
    region = heap.lift_region(append_field)
    assert region(warm) == (1, 10.0)
    values = [10.0]
    shared = Pair(values, values)
    assert region(shared) == (2, 99.0)
    assert shared.left is shared.right is values
    assert (shared.calls, values) == (1, [10.0, 99.0])
    assert (region.compiled_calls, region.fallback_calls) == (1, 1)
    check_loader(region, (warm,), loader)


@pytest.mark.parametrize("left,right,shared,expected", [
    ([7], [2.5], [7], (7, 7)), ([2.5], [7], [2.5], (2.5, 2.5)),
])
def test_second_known_list_contract_cannot_reinterpret_layout(loader, left, right, shared, expected):
    region = heap.lift_region(firsts)
    assert region(left, right) == (left[0], right[0])
    program, calls = region.latest, []
    original = program.run

    def old_entry(*args):
        calls.append(True)
        return original(*args)

    program.run = old_entry
    actual = region(shared, shared)
    assert actual == expected
    assert tuple(map(type, actual)) == tuple(map(type, expected))
    assert calls == []  # The unsupported old contract never enters native code.
    assert region.compiled_calls + region.fallback_calls == 2
    check_loader(region, (left, right), loader, program)


def test_byte_array_contract_also_guards_writeback(loader):
    left, right = array.array("B", [10]), array.array("B", [20])
    region = heap.lift_region(increment_second)
    assert region(left, right) == 10
    shared = array.array("B", [10])
    assert region(shared, shared) == 11
    assert shared.tolist() == [11]
    assert (region.compiled_calls, region.fallback_calls) == (1, 1)


def test_captured_same_root_alias_and_cycle_keep_native_execution(loader):
    values = [10.0]
    region = heap.lift_region(append_same)
    assert region(values, values) == (2, 99.0)
    check_loader(region, (values, values), loader)
    node = Node([10.0])
    node.next = node
    cycle = heap.lift_region(append_cycle)
    assert cycle(node, node) == (True, True, 99.0)
    assert node.next is node and node.values == [10.0, 99.0]
    assert region.compiled_calls == cycle.compiled_calls == 1
    check_loader(cycle, (node, node), loader)


def test_tuple_packing_reaches_nested_list_contracts(loader):
    region = heap.lift_region(append_tuple)
    assert region(([10.0],), ([10.0],)) == (1, 10.0)
    values = [10.0]
    wrapped = (values,)
    assert region(wrapped, wrapped) == (2, 99.0)
    assert values == [10.0, 99.0]
    assert (region.compiled_calls, region.fallback_calls) == (1, 1)


def test_mapping_alias_cannot_hide_nested_list_contract(loader):
    region = heap.lift_region(append_mapping)
    assert region({0: [10.0]}, {0: [10.0]}) == (1, 10.0)
    values = [10.0]
    mapping = {0: values}
    assert region(mapping, mapping) == (2, 99.0)
    assert mapping[0] is values and values == [10.0, 99.0]
    assert (region.compiled_calls, region.fallback_calls) == (1, 1)


def test_set_alias_cannot_lose_mutation_role(loader):
    region = heap.lift_region(add_to_second)
    assert region({10}, {20}) == 1
    shared = {10}
    assert region(shared, shared) == 2
    assert shared == {10, 99}
    assert (region.compiled_calls, region.fallback_calls) == (1, 1)


def test_captured_container_and_array_contracts_keep_native_execution(loader):
    values = [10.0]
    mapping = {0: values}
    region = heap.lift_region(append_same_mapping)
    assert region(mapping, mapping) == (2, 99.0)
    assert mapping[0] is values and values == [10.0, 99.0]
    items = {10}
    sets = heap.lift_region(add_to_same)
    assert sets(items, items) == 2 and items == {10, 99}
    values_array = np.array([2.5])
    arrays = heap.lift_region(array_same_firsts)
    result = arrays(values_array, values_array)
    assert result == (np.float64(2.5), np.float64(2.5))
    assert all(r.compiled_calls == 1 for r in (region, sets, arrays))


def test_second_known_ndarray_still_validates_dtype_and_rank(loader):
    region = heap.lift_region(firsts)
    left, right = np.array([2.5]), np.array([7], dtype=np.int64)
    region(left, right)
    assert region.compiled_calls == 1, region.problem
    program, calls = region.latest, []
    original = program.run

    def old_entry(*args):
        calls.append(True)
        return original(*args)

    program.run = old_entry
    actual = region(left, left)
    assert actual == (np.float64(2.5), np.float64(2.5))
    assert tuple(map(type, actual)) == (np.float64, np.float64)
    assert calls == []


@pytest.mark.parametrize("first,second,shared,expected", [
    (Derived, Base, Derived, (2, 2)), (Base, Derived, Base, (1, 1)),
])
def test_known_object_still_validates_allowed_actual_class(loader, first, second, shared, expected):
    region = heap.lift_region(object_dispatch)
    warm = first(), second()
    assert region(*warm) == (warm[0].identify(), warm[1].identify())
    value = shared()
    assert region(value, value) == expected
    # A same-class cached specialization may be regenerated after the mismatch;
    # either safe re-specialization or Python fallback is valid.
    assert region.compiled_calls + region.fallback_calls == 2


def test_old_native_capability_uses_guarded_python_packing(monkeypatch):
    native = heap._native
    if native is None:
        pytest.skip("optional native loader extension is unavailable")
    monkeypatch.setattr(heap, "NATIVE", True)
    monkeypatch.delattr(native, "LOAD_CONTRACTS_VERSION", raising=False)

    def forbidden(*args):
        raise AssertionError("old native loader must not pack arguments")

    monkeypatch.setattr(native, "load", forbidden)
    values = [10.0]
    region = heap.lift_region(append_same)
    assert region(values, values) == (2, 99.0)
    packed, _ = region.load(region.latest, (values, values))
    assert packed.native is False
    assert region.compiled_calls == 1, region.problem


def test_native_contract_map_reuses_only_matching_canonical_kind():
    native = require_native()
    region = heap.lift_region(firsts)
    assert region([1.5], [2.5]) == (1.5, 2.5)
    program = region.latest
    left, right = (program.c_kind(program.entry.vars[name]) for name in ("left", "right"))
    F = np.zeros(128)
    I = F.view(np.int64)
    handles, objects, lists, contracts = {}, [], [], {}
    values = [1.5]
    handle, top = native.load(left, values, F, I, 0, handles, objects, lists, contracts)
    assert native.load(left, values, F, I, top, handles, objects, lists, contracts) == (handle, top)
    assert len(lists) == 1 and isinstance(handles[id(values)], int)
    assert contracts[id(values)] is left[3]
    with pytest.raises(native.Mismatch):
        native.load(right, values, F, I, top, handles, objects, lists, contracts)


def test_legacy_eight_argument_call_rejects_unknown_contract():
    native = require_native()
    region = heap.lift_region(firsts)
    assert region([1.5], [2.5]) == (1.5, 2.5)
    kind = region.latest.c_kind(region.latest.entry.vars["left"])
    F = np.zeros(128)
    I = F.view(np.int64)
    handles, objects, lists = {}, [], []
    values = [1.5]
    handle, top = native.load(kind, values, F, I, 0, handles, objects, lists)
    assert isinstance(handle, int)
    with pytest.raises(native.Mismatch):
        native.load(kind, values, F, I, top, handles, objects, lists)


@pytest.mark.parametrize("array_case", [False, True], ids=["containers", "ndarrays"])
def test_fresh_aot_unknown_alias_guards_before_native_entry_and_known_aliases_work(tmp_path, array_case):
    values = [10.0]
    node = Node([10.0])
    node.next = node
    cases = [(append_argument, (Holder([10.0]), [10.0])),
             (append_field, (Pair([10.0], [10.0]),)),
             (firsts, ([7], [2.5])), (append_same, (values, values)), (append_cycle, (node, node)),
             (append_mapping, ({0: [10.0]}, {0: [10.0]})),
             (add_to_second, ({10}, {20})),
             (array_firsts, (np.array([2.5]), np.array([7], dtype=np.int64)))]
    mapping, items, values_array = {0: [10.0]}, {10}, np.array([2.5])
    cases += [(append_same_mapping, (mapping, mapping)), (add_to_same, (items, items)),
              (array_same_firsts, (values_array, values_array))]
    array_functions = (array_firsts, array_same_firsts)
    cases = [(fn, args) for fn, args in cases if (fn in array_functions) == array_case]
    entries = []
    for function, args in cases:
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
import numpy as np
from test_heap_alias_contracts import Holder, Pair, Node, append_argument, append_field, firsts, append_same, append_cycle, append_mapping, add_to_second, array_firsts, append_same_mapping, add_to_same, array_same_firsts
section = json.load(open(sys.argv[1])); module = aot.load(section)
array_case = sys.argv[2] == 'True'
functions = {fn.__name__: fn for fn in (append_argument, append_field, firsts, append_same, append_cycle, append_mapping, add_to_second, array_firsts, append_same_mapping, add_to_same, array_same_firsts)}
rows = []
for native in (False, True):
    heap.NATIVE = native
    for entry in section['functions']:
        fn = functions[entry['function']]; calls = [0]
        def count_export(export):
            def call(*args):
                calls[0] += 1
                return export(*args)
            return call
        exports = _AotOnlyExports({digest: count_export(getattr(module, name)) for digest, name in entry['exports'].items()})
        region = heap.lift_region(fn, exports, seeds=entry.get('seeds'))
        def warm_done():
            assert (region.aot_calls, region.fallback_calls, calls[0]) == (1, 0, 1)
        if fn is append_argument:
            warm, alias = Holder([10.0]), [10.0]
            assert region(warm, alias) == (1, 10.0); warm_done()
            state = Holder([10.0]); assert region(state, state.values) == (2, 99.0)
            assert (state.calls, state.values) == (1, [10.0, 99.0]); expected = (1, 1, 1)
        elif fn is append_field:
            warm = Pair([10.0], [10.0]); assert region(warm) == (1, 10.0); warm_done()
            values = [10.0]; pair = Pair(values, values); assert region(pair) == (2, 99.0)
            assert pair.left is pair.right is values and (pair.calls, values) == (1, [10.0, 99.0]); expected = (1, 1, 1)
        elif fn is firsts:
            assert region([7], [2.5]) == (7, 2.5); warm_done()
            values = [7]; result = region(values, values)
            assert result == (7, 7) and tuple(map(type, result)) == (int, int); expected = (1, 1, 1)
        elif fn is append_same:
            values = [10.0]; assert region(values, values) == (2, 99.0)
            assert values == [10.0, 99.0]; expected = (1, 0, 1)
        elif fn is append_cycle:
            node = Node([10.0]); node.next = node
            assert region(node, node) == (True, True, 99.0) and node.next is node
            assert node.values == [10.0, 99.0]; expected = (1, 0, 1)
        elif fn in (append_mapping, append_same_mapping):
            if fn is append_mapping:
                assert region({0: [10.0]}, {0: [10.0]}) == (1, 10.0); warm_done()
            values = [10.0]; mapping = {0: values}
            assert region(mapping, mapping) == (2, 99.0) and mapping[0] is values
            assert values == [10.0, 99.0]
            expected = (1, 1, 1) if fn is append_mapping else (1, 0, 1)
        elif fn in (add_to_second, add_to_same):
            if fn is add_to_second:
                assert region({10}, {20}) == 1; warm_done()
            items = {10}; assert region(items, items) == 2 and items == {10, 99}
            expected = (1, 1, 1) if fn is add_to_second else (1, 0, 1)
        else:
            if fn is array_firsts:
                assert region(np.array([2.5]), np.array([7], dtype=np.int64)) == (np.float64(2.5), np.int64(7)); warm_done()
            values = np.array([2.5]); result = region(values, values)
            assert result == (np.float64(2.5), np.float64(2.5))
            assert tuple(map(type, result)) == (np.float64, np.float64)
            expected = (1, 1, 1) if fn is array_firsts else (1, 0, 1)
        assert (region.aot_calls, region.fallback_calls, calls[0]) == expected, (fn, region.problem, calls)
        assert region.jit_calls == 0
        rows.append((native, fn.__name__, region.aot_calls, region.fallback_calls, calls[0]))
if not array_case:
    assert 'numba' not in sys.modules
# NdT source regeneration currently imports _nd/Numba even on an AOT hit;
# preserve that existing limitation separately from zero JIT execution.
print(json.dumps({'rows': rows, 'existing_numba_imported': 'numba' in sys.modules}))
'''
    child = subprocess.run([sys.executable, "-c", code, str(plan), str(array_case)], env=env,
                           capture_output=True, timeout=180)
    (tmp_path / "child.stdout.bin").write_bytes(child.stdout)
    (tmp_path / "child.stderr.bin").write_bytes(child.stderr)
    assert child.returncode == 0, child.stderr.decode(errors="replace")[-6000:]
    report = json.loads(child.stdout.splitlines()[-1])
    rows = report["rows"]
    assert len(rows) == (4 if array_case else 18)
    assert sum(row[4] for row in rows) == len(rows)
    if not array_case:
        assert report["existing_numba_imported"] is False
