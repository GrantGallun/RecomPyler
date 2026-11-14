"""Array writes must be rolled back before retrying a call in Python."""
import numpy as np
import pytest

from recompyler import heap


def increment_then_read(values, index):
    values[0] += 1.0
    return values[index]


def increment_alias_then_read(left, right, index):
    left[0] += 1.0
    right[0] += 2.0
    return right[index]


def increment_and_collect(values, count):
    values[0] += 1.0
    collected = []
    for i in range(count):
        collected.append(i)
    return collected[-1]


@pytest.mark.parametrize("native", [True, False])
def test_failed_array_attempt_leaves_inputs_unchanged(monkeypatch, native):
    monkeypatch.setattr(heap, "NATIVE", native)
    values = np.array([4.0, 5.0])
    region = heap.lift_region(increment_then_read)
    assert region.attempt((values, 100))[0] is False
    np.testing.assert_array_equal(values, [4.0, 5.0])


@pytest.mark.parametrize("native", [True, False])
def test_array_fallback_applies_python_side_effect_once(monkeypatch, native):
    monkeypatch.setattr(heap, "NATIVE", native)
    values = np.array([4.0, 5.0])
    region = heap.lift_region(increment_then_read)
    with pytest.raises(IndexError):
        region(values, 100)
    np.testing.assert_array_equal(values, [5.0, 5.0])


def test_failed_array_attempt_preserves_overlapping_views():
    values = np.array([4.0, 5.0, 6.0])
    region = heap.lift_region(increment_alias_then_read)
    assert region.attempt((values, values[:2], 100))[0] is False
    np.testing.assert_array_equal(values, [4.0, 5.0, 6.0])


def test_successful_array_attempt_commits_writes():
    values = np.array([4.0, 5.0])
    region = heap.lift_region(increment_then_read)
    ok, result = region.attempt((values, 0))
    assert ok is True
    assert result == 5.0
    np.testing.assert_array_equal(values, [5.0, 5.0])


@pytest.mark.parametrize("native", [True, False])
def test_array_writes_are_not_repeated_when_heap_grows(monkeypatch, native):
    monkeypatch.setattr(heap, "NATIVE", native)
    values = np.array([4.0])
    region = heap.lift_region(increment_and_collect)
    region.slots = 128
    ok, result = region.attempt((values, 300))
    assert ok is True
    assert result == 299
    assert region.slots > 128
    np.testing.assert_array_equal(values, [5.0])
