"""Physical object slots are nonnegative; Python indices and sentinels are not."""
import re

import numpy as np
import pytest

from recompyler import heap


class Cell:
    def __init__(self, value):
        self.value = value


class Box:
    def __init__(self, payload):
        self.payload = payload
        self.calls = 0


class Extra(Cell):
    def __init__(self, value):
        super().__init__(value)
        self.extra = value + 1.0


def field_read(cell):
    return cell.value


def field_write(cell, value):
    cell.value = value
    return cell


def negative_items(box, index):
    box.calls += 1
    box.payload[index] += 2
    return box.payload[-1], box.payload[-3:-1], "abcd"[index]


def optional_tuple(box, enabled):
    box.payload = (2.5, 7) if enabled else None
    return box.payload


def missing_child(box):
    box.calls += 1
    return box.payload.value


def unbound_child(box, enabled):
    box.calls += 1
    if enabled:
        child = box.payload
    return child.value


def grow_fields(box, count):
    box.calls += 1
    for i in range(count):
        box.payload.append(Cell(float(i)))
    return box.payload[-1]


def overflowing_field(box):
    box.calls += 1
    box.payload.value += 1
    return box.payload


def strided_array(box):
    box.calls += 1
    box.payload[-1] += 2.0
    return box.payload[0], box.payload[-1]


def partial_field(box, index):
    box.calls += 1
    return box.payload[index].extra


def numeric_choice(cell, mode):
    if mode == 0:
        cell.value = None
    elif mode == 1:
        cell.value = -0.0
    else:
        cell.value = 3
    return cell.value


@pytest.fixture(params=[False, True], ids=["python-loader", "native-loader"])
def loader(request, monkeypatch):
    monkeypatch.setattr(heap, "NATIVE", request.param)


@pytest.mark.parametrize("fn,args,result", [
    (field_read, (Cell(3.5),), 3.5),
    (field_write, (Cell(3.5), 4.5), None),
])
def test_object_slot_machine_code_has_no_negative_index_adjustment(monkeypatch, fn, args, result):
    # Reintroducing signed physical indexing adds a sign test/select to the real
    # native entry. Disable disk reuse so inspect_llvm sees the compiled body.
    monkeypatch.setattr(heap, "_cached_module", lambda source: None)
    region = heap.lift_region(fn)
    actual = region(*args)
    if fn is field_read:
        assert actual == result
    else:
        assert actual is args[0] and actual.value == 4.5
    assert region.compiled_calls == 1, region.problem
    llvm = region.latest.run.inspect_llvm(region.latest.run.signatures[0])
    native = llvm.split("define ", 1)[1].split("\n}", 1)[0]
    assert re.search(r"load double|store double", native)
    assert not re.search(r"icmp slt i64 %arg\.v_cell[^,]*,", native), native


def test_python_negative_indices_and_bounds_keep_single_effect(loader):
    box = Box([10, 20, 30])
    region = heap.lift_region(negative_items)
    assert region(box, -1) == (32, [10, 20], "d")
    assert region.compiled_calls == 0 and region.fallback_calls == 1
    assert "str/bytes result ownership" in region.problem
    with pytest.raises(IndexError):
        region(box, -4)
    assert box.calls == 2
    assert box.payload == [10, 20, 32]
    assert region.fallback_calls == 2


def test_nullable_tuple_field_payload_remains_safe(loader):
    box = Box(None)
    region = heap.lift_region(optional_tuple)
    for enabled in (False, True, False, True):
        result = region(box, enabled)
        assert result == ((2.5, 7) if enabled else None)
        assert box.payload == result
    assert region.compiled_calls == 4, region.problem


@pytest.mark.parametrize("fn,args,error", [
    (missing_child, (), AttributeError),
    (unbound_child, (False,), UnboundLocalError),
])
def test_missing_or_unbound_handle_falls_back_before_access(loader, fn, args, error):
    box = Box(None if fn is missing_child else Cell(1.5))
    region = heap.lift_region(fn)
    with pytest.raises(error):
        region(box, *args)
    assert box.calls == 1
    assert region.compiled_calls == 0
    assert region.fallback_calls == 1


@pytest.mark.parametrize("exhaust", [False, True])
def test_object_allocation_growth_or_exhaustion_keeps_identity_and_single_effect(loader, monkeypatch, exhaust):
    if exhaust:
        monkeypatch.setattr(heap, "MAX_SLOTS", 128)
    box = Box([])
    alias = box.payload
    region = heap.lift_region(grow_fields)
    region.slots = 128
    result = region(box, 200)
    assert box.calls == 1
    assert box.payload is alias
    assert result is alias[-1]
    assert [cell.value for cell in alias] == list(map(float, range(200)))
    assert region.compiled_calls == (0 if exhaust else 1), region.problem
    assert region.fallback_calls == (1 if exhaust else 0)


def test_field_integer_overflow_rolls_back_before_python(loader):
    child = Cell((1 << 63) - 1)
    box = Box(child)
    region = heap.lift_region(overflowing_field)
    assert region(box) is child
    assert child.value == 1 << 63
    assert box.calls == 1
    assert region.compiled_calls == 0
    assert region.fallback_calls == 1


def test_negative_ndarray_stride_is_unchanged(loader):
    backing = np.arange(5.0)
    box = Box(backing[::-1])
    region = heap.lift_region(strided_array)
    assert region(box) == (4.0, 2.0)
    assert box.calls == 1
    assert np.array_equal(backing, [2.0, 1.0, 2.0, 3.0, 4.0])
    assert region.compiled_calls == 1, region.problem


def test_partial_class_field_tag_guards_before_load(loader):
    box = Box([Extra(4.0), Cell(2.0)])
    region = heap.lift_region(partial_field)
    assert region(box, 0) == 5.0
    assert region.compiled_calls == 1, region.problem
    with pytest.raises(AttributeError):
        region(box, 1)
    assert box.calls == 2
    assert region.fallback_calls == 1


def test_optional_mixed_field_flags_preserve_python_types_and_signed_zero(loader):
    cell = Cell(None)
    region = heap.lift_region(numeric_choice)
    for mode, expected in [(0, None), (1, -0.0), (2, 3), (0, None)]:
        result = region(cell, mode)
        assert type(result) is type(expected)
        assert type(cell.value) is type(expected)
        assert result == cell.value == expected
        if type(expected) is float:
            assert np.signbit(result) and np.signbit(cell.value)
    assert region.compiled_calls == 4, region.problem
