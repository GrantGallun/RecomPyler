"""Internal recursive calls borrow heap storage without changing public values."""
import ast
import json
import os
from pathlib import Path
import random
import re
import subprocess
import sys

import numpy as np
import pytest

from recompyler import heap


def recursive_sum(depth, value):
    if depth < 1:
        return value
    return recursive_sum(depth - 1, value) + recursive_sum(depth - 2, value)


def nonrecursive(value):
    return value + 1.0


class State:
    def __init__(self, value=1.5):
        self.value = value
        self.calls = 0
        self.items = [1.0, 2.0, 3.0]
        self.optional = None


class PointerPayload:
    def __init__(self):
        self.value = 1.5
        self.items = [7]


def recursive_pointer_payload(state, depth):
    if depth <= 0:
        return state.value + state.items[0]
    return recursive_pointer_payload(state, depth - 1)


def even_walk(state, depth, amount=1.0):
    state.calls += 1
    state.value += amount
    if depth <= 0:
        return state.value
    return odd_walk(state, depth - 1)


def odd_walk(state, depth, amount=2.0):
    state.calls += 1
    state.value += amount
    if depth <= 0:
        return state.value
    return even_walk(state, depth - 1)


def recursive_effect(state, alias, depth, index=-1):
    state.calls += 1
    alias.value += 0.5
    state.items[index] += 2.0
    state.optional = (state.value, depth) if depth % 2 else None
    if depth <= 0:
        return state, alias, state.optional, state.items[index]
    return recursive_effect(state, alias, depth - 1, index)


def grow_then_divide(state, depth, count, denominator):
    state.calls += 1
    for index in range(count):
        state.items.append(float(index))
    if depth > 0:
        return grow_then_divide(state, depth - 1, count, denominator)
    state.value += 0.5
    return state.items[-1] / denominator


def recursive_arrays(left, right, depth, index=-2):
    left[1] += 1.0
    right[-2] += 2.0
    if depth > 0:
        return recursive_arrays(left, right, depth - 1, index)
    return right[index]


def recursive_random(rng, depth, denominator):
    total = 0.0
    for index in range(700):
        total += rng.random()
    if depth > 0:
        return total + recursive_random(rng, depth - 1, denominator)
    return total / denominator


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


@pytest.mark.parametrize("function,args", [(recursive_sum, (4, 1.25)),
                                           (even_walk, (State(), 4, 1.0))])
def test_internal_calls_bypass_public_array_adapter_and_compile_stably(function, args):
    program = generated(function, *args)
    before = program.source, program.digest
    program.compile(_SourceOnly())
    assert (program.source, program.digest) == before
    functions = [node for node in ast.parse(program.source).body if isinstance(node, ast.FunctionDef)]
    public = next(node for node in functions if node.name == program.entry.name)
    assert [arg.arg for arg in public.args.args[:4]] == ["F", "I", "top", "st"]
    constructors = [call for call in ast.walk(public) if isinstance(call, ast.Call)
                    and isinstance(call.func, ast.Name) and call.func.id == "_heap_context_pack"]
    assert len(constructors) == 1
    borrowed = {node.name: node for node in functions if node.name.endswith("_borrowed")}
    assert borrowed
    raw = ["_heap_F", "_heap_I", "_heap_top", "_heap_st", "_heap_len"]
    inlined = {name for name, node in borrowed.items() for decorator in node.decorator_list
               if isinstance(decorator, ast.Call) and any(keyword.arg == "inline"
                  and isinstance(keyword.value, ast.Constant) and keyword.value.value == "always"
                  for keyword in decorator.keywords)}
    if function is even_walk:
        assert any(name.startswith("s0_") for name in borrowed)
    for node in borrowed.values():
        context = ["_heap_ctx"] + (raw if node.name in inlined else [])
        assert [arg.arg for arg in node.args.args[:len(context)]] == context
        if node.name not in inlined:
            assert not set(raw).intersection(arg.arg for arg in node.args.args)
        for call in (item for item in ast.walk(node) if isinstance(item, ast.Call)
                     and isinstance(item.func, ast.Name)):
            assert call.func.id != program.entry.name
            assert call.func.id != "_heap_context_pack"
            if call.func.id in borrowed:
                context = ["_heap_ctx"] + (raw if call.func.id in inlined else [])
                assert [arg.id for arg in call.args[:len(context)]] == context


def test_nonrecursive_region_keeps_existing_array_bodies():
    program = generated(nonrecursive, 1.25)
    functions = [node for node in ast.parse(program.source).body if isinstance(node, ast.FunctionDef)]
    assert not any(node.name.endswith("_borrowed") or node.name == "_heap_data" for node in functions)
    entry = next(node for node in functions if node.name == program.entry.name)
    assert [arg.arg for arg in entry.args.args[:4]] == ["F", "I", "top", "st"]


def test_recursive_native_context_borrows_one_pointer(monkeypatch):
    monkeypatch.setattr(heap, "_cached_module", lambda source: None)
    region = heap.lift_region(recursive_sum)
    assert region(4, 1.25) == 10.0
    assert region.compiled_calls == 1, region.problem
    program = region.latest
    from numba import types

    assert all(isinstance(kind, types.Array) for kind in program.run.signatures[0][:4])
    checked_recursive = False
    for info in program.order:
        body = getattr(program.module, info.name + "_borrowed", None)
        assert body is not None
        for signature in body.signatures:
            context_fields = types.Tuple((types.CPointer(types.float64), types.CPointer(types.int64),
                                          types.CPointer(types.int64), types.CPointer(types.uint8), types.int64))
            assert signature[0] == types.CPointer(context_fields)
            assert sum(isinstance(kind, types.CPointer) for kind in signature) == 1
            assert len(signature) == 3  # one context pointer and two semantic scalars
            llvm = body.inspect_llvm(signature)
            symbol = body.overloads[signature].fndesc.llvm_func_name
            native = next(block.split("\n}", 1)[0] for block in llvm.split("define ")[1:]
                          if "@" + symbol + "(" in block.splitlines()[0])
            assert not re.search(r"call[^\n]*@NRT_(?:incref|decref|MemInfo_alloc)", native)
            declaration = native.splitlines()[0]
            assert re.search(r"ptr[^,\n]*%arg\._heap_ctx(?:\.\d+)?(?=,|\))", declaration)
            assert not re.search(r"%arg\._heap_(?:F|I|top|st|len)(?:\.\d+)?(?=,|\))", declaration)
            # Float and integer arena views overlap. No scoped disjointness
            # promises may be invented while reconstructing their local views.
            assert "!noalias" not in native and "!alias.scope" not in native
            if info.recursive:
                assert re.search(r"\bcall\b[^\n]*@" + re.escape(symbol) + r"\(", native)
                checked_recursive = True
    assert checked_recursive


def test_context_intrinsics_participate_in_generated_source_identity(monkeypatch):
    first = generated(recursive_sum, 4, 1.25)
    monkeypatch.setattr(heap, "_BORROWED_HEAP", heap._BORROWED_HEAP + "\n# context identity check\n")
    second = generated(recursive_sum, 4, 1.25)
    assert first.source != second.source
    assert first.digest != second.digest


@pytest.mark.parametrize("slot,dtype", [(2, np.uint64), (3, np.int8)])
def test_public_adapter_preserves_existing_state_pointer_dtypes(monkeypatch, slot, dtype):
    monkeypatch.setattr(heap, "_cached_module", lambda source: None)
    region = heap.lift_region(recursive_sum)
    assert region(2, 1.0) == 3.0
    arrays = list(region.arrays())
    arrays[slot] = arrays[slot].astype(dtype)
    # These buffers meet the pre-existing shape/stride checks. The internal
    # descriptor must retain their actual pointer types rather than reinterpret
    # their contents using a canonical F/I/top/status schema.
    assert region.latest.run(*arrays, 2, 1.0) == 3.0


@pytest.mark.parametrize("slot,dtype", [(0, np.int64), (1, np.uint64)])
def test_public_adapter_preserves_arena_pointer_payload_types(monkeypatch, slot, dtype):
    monkeypatch.setattr(heap, "_cached_module", lambda source: None)
    region = heap.lift_region(recursive_pointer_payload)
    assert region(PointerPayload(), 2) == 8.5
    assert region.compiled_calls == 1, region.problem
    program = region.latest
    offsets, _ = program.layout(PointerPayload)
    handle, list_handle, data_handle = 4, 16, 20
    F = np.zeros(64, dtype=np.float64)
    I = np.zeros(64, dtype=np.int64)
    F[handle + offsets["value"]] = 1.5
    I[handle + offsets["items"]] = list_handle
    I[list_handle:list_handle + 3] = (1, 1, data_handle)
    I[data_handle] = 7 if slot == 0 else -(2 ** 63) + 3
    top = np.array([data_handle + 1, 0, 100, -1], dtype=np.int64)
    st = np.zeros(1, dtype=np.uint8)
    arrays = [F, I, top, st]
    # Settle a FLOAT field and INT list item, then exercise actual arena reads.
    # These expectations follow the old typed carray views, rather than viewing
    # every F pointer as double or every I pointer as signed int64.
    canonical = 1.5 + float(I[data_handle])
    assert program.run(*arrays, handle, 2) == canonical
    arrays[slot] = arrays[slot].astype(dtype)
    if slot == 0:
        arrays[0][handle + offsets["value"]] = 5
        expected = 12.0  # int64 F item 5 plus integer list item 7
    else:
        expected = 1.5 + float(2 ** 63 + 3)  # uint64 I item, not its negative signed interpretation
    actual = program.run(*arrays, handle, 2)
    assert actual == expected
    assert type(actual) is float
    assert st[0] == 0 and top[1] == 0


@pytest.mark.parametrize("bad", ["arena-length", "top-length", "status-length", "arena-stride",
                                 "top-stride", "status-stride", "arena-dimensions"])
def test_public_adapter_rejects_invalid_context_before_borrowing(monkeypatch, bad):
    monkeypatch.setattr(heap, "_cached_module", lambda source: None)
    region = heap.lift_region(recursive_sum)
    assert region(2, 1.0) == 3.0
    F, I, top, st = region.arrays()
    if bad == "arena-length":
        I = I[:-1]
    elif bad == "top-length":
        top = top[:3]
    elif bad == "status-length":
        st = st[:0]
    elif bad == "arena-stride":
        F, I = F[::2], I[::2]
    elif bad == "top-stride":
        top = np.zeros(8, dtype=np.int64)[::2]
    elif bad == "status-stride":
        st = np.zeros(2, dtype=np.uint8)[::2]
    else:
        F, I = F.reshape(1, -1), I.reshape(1, -1)
    with pytest.raises(ValueError, match="heap context"):
        region.latest.run(F, I, top, st, 2, 1.0)


def test_merged_mutual_recursion_uses_defaults_and_shared_state(loader):
    region = heap.lift_region(even_walk)
    state = State()
    assert region(state, 4) == 8.5
    assert (state.calls, state.value) == (5, 8.5)
    assert region(state, 3, 4.0) == 17.5
    assert (state.calls, state.value) == (9, 17.5)
    assert region.compiled_calls == 2, region.problem


def test_alias_negative_index_and_nullable_payload_share_recursive_storage(loader):
    state = State()
    region = heap.lift_region(recursive_effect)
    result = region(state, state, 3)
    assert result[:2] == (state, state)
    assert result[0] is result[1] is state
    assert result[2:] == (None, 11.0)
    assert (state.calls, state.value, state.items) == (4, 3.5, [1.0, 2.0, 11.0])
    assert region.compiled_calls == 1, region.problem
    # A Python index error after a native mutation must retry exactly once.
    with pytest.raises(IndexError):
        region(state, state, 3, -4)
    assert (state.calls, state.value) == (5, 4.0)
    assert region.fallback_calls == 1


def test_growth_reborrows_new_storage_and_failure_rolls_back(loader):
    state = State()
    alias = state.items
    region = heap.lift_region(grow_then_divide)
    region.slots = 128
    assert region(state, 2, 100, 1.0) == 99.0
    assert region.slots > 128
    assert state.items is alias
    assert state.calls == 3
    assert state.value == 2.0
    assert len(alias) == 303
    assert alias[3:] == list(map(float, range(100))) * 3
    assert region.compiled_calls == 1, region.problem
    with pytest.raises(ZeroDivisionError):
        region(state, 1, 100, 0.0)
    assert state.items is alias
    assert (state.calls, state.value, len(alias)) == (5, 2.5, 503)
    assert region.fallback_calls == 1


def test_recursion_limit_retains_failure_exit(loader):
    state = State()
    region = heap.lift_region(even_walk)
    assert region(state, 2) == 5.5
    with pytest.raises(RecursionError):
        region(state, 10**6)
    assert region.fallback_calls == 1


def test_recursive_numpy_overlapping_negative_stride_views_roll_back(loader):
    values = np.array([4.0, 5.0, 6.0, 7.0])
    left, right = values[::-1], values[1:]
    region = heap.lift_region(recursive_arrays)
    assert region(left, right, 2) == 15.0
    np.testing.assert_array_equal(values, [4.0, 5.0, 15.0, 7.0])
    assert region.compiled_calls == 1, region.problem
    assert any(info.recursive for info in region.latest.order)
    assert region.attempt((left, right, 2, 100))[0] is False
    np.testing.assert_array_equal(values, [4.0, 5.0, 15.0, 7.0])
    with pytest.raises(IndexError):
        region(left, right, 2, 100)
    np.testing.assert_array_equal(values, [4.0, 5.0, 24.0, 7.0])


def test_recursive_random_state_matches_and_failed_attempt_restores_rng(loader):
    rng, reference = random.Random(31), random.Random(31)
    region = heap.lift_region(recursive_random)
    assert region(rng, 2, 1.0) == recursive_random(reference, 2, 1.0)
    assert rng.getstate() == reference.getstate()
    assert region.compiled_calls == 1, region.problem
    assert any(info.recursive for info in region.latest.order)
    before = rng.getstate()
    assert region.attempt((rng, 2, 0.0))[0] is False
    assert rng.getstate() == before
    with pytest.raises(ZeroDivisionError):
        region(rng, 2, 0.0)
    with pytest.raises(ZeroDivisionError):
        recursive_random(reference, 2, 0.0)
    assert rng.getstate() == reference.getstate()
    assert region.fallback_calls == 1


def test_fresh_process_aot_reborrows_context_without_numba(tmp_path):
    regions = []
    for function, args in [(recursive_sum, (4, 1.25)), (even_walk, (State(), 4)),
                           (recursive_effect, (State(), State(), 3)),
                           (grow_then_divide, (State(), 2, 100, 1.0))]:
        region = heap.lift_region(function)
        region(*args)
        assert region.compiled_calls == 1, region.problem
        regions.append(((function.__name__, function.__code__.co_firstlineno), function, region))
    section = heap.build_regions(regions, tmp_path)
    assert section is not None
    plan = tmp_path / "artifact.json"
    plan.write_text(json.dumps(section), encoding="utf-8")
    env = dict(os.environ, PYTHONPATH=os.pathsep.join((str(Path(__file__).parent),
                                                     str(Path(heap.__file__).parents[1]))),
               RECOMPYLER_CACHE=str(tmp_path / "cache"), NUMBA_CACHE_DIR=str(tmp_path / "numba"))
    code = '''import json, sys
from recompyler import heap, aot
from recompyler.runner import _AotOnlyExports
from test_heap_compact_abi import State, recursive_sum, even_walk, recursive_effect, grow_then_divide
section = json.load(open(sys.argv[1]))
module = aot.load(section)
functions = {fn.__name__: fn for fn in (recursive_sum, even_walk, recursive_effect, grow_then_divide)}
counts = []
for native in (False, True):
    heap.NATIVE = native
    for entry in section['functions']:
        fn = functions[entry['function']]
        exports = _AotOnlyExports({digest: getattr(module, export) for digest, export in entry['exports'].items()})
        region = heap.lift_region(fn, exports, seeds=entry.get('seeds'))
        state = State()
        if fn is recursive_sum:
            assert region(4, 1.25) == 10.0
        elif fn is even_walk:
            assert region(state, 4) == 8.5
            assert (state.calls, state.value) == (5, 8.5)
        elif fn is recursive_effect:
            result = region(state, state, 3)
            assert result[0] is result[1] is state
            assert result[2:] == (None, 11.0)
            assert (state.calls, state.value, state.items) == (4, 3.5, [1.0, 2.0, 11.0])
        else:
            region.slots = 128
            assert region(state, 2, 100, 1.0) == 99.0
            assert state.calls == 3 and len(state.items) == 303 and region.slots > 128
        assert region.aot_calls == 1 and region.jit_calls == region.fallback_calls == 0, (fn, region.problem)
        counts.append((native, fn.__name__, region.aot_calls, region.jit_calls, region.fallback_calls))
assert 'numba' not in sys.modules
print(json.dumps(counts))
'''
    child = subprocess.run([sys.executable, "-c", code, str(plan)], env=env,
                           capture_output=True, text=True, timeout=240)
    assert child.returncode == 0, child.stderr[-6000:]
    counts = json.loads(child.stdout.splitlines()[-1])
    assert len(counts) == 8
    assert all(row[2:] == [1, 0, 0] for row in counts)
