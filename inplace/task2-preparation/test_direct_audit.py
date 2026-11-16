"""Staged native-audit tests. Preparation only; never imported or run yet.

Move into tests/ only after IMPLEMENT. Synthetic recorder tests establish
exceptional bookkeeping, while the real Region cases require actual C evidence.
"""
import importlib
from pathlib import Path
from types import SimpleNamespace
import weakref

import pytest

from recompyler import heap


class AuditCell:
    def __init__(self, value):
        self.value = value


def audit_read(cell):
    return cell.value


def audit_compare(cell):
    return cell.value > 0.0


def audit_divide(cell, divisor):
    return cell.value / divisor


class _StopAudit(BaseException):
    pass


@pytest.fixture
def audit_module(monkeypatch):
    clone = Path(heap.__file__).resolve().parents[2]
    monkeypatch.syspath_prepend(str(clone / "inplace"))
    return importlib.import_module("capture_audit")


def _row(report, fn):
    rows = [row for row in report["independent_functions"]
            if row["qualname"] == fn.__qualname__
            and row["line"] == fn.__code__.co_firstlineno]
    assert len(rows) == 1
    return rows[0]


def _warm(fn, *args):
    region = heap.Region(fn)
    region(*args)
    assert region.direct_calls == 1
    return region


def _synthetic_native_for_recorder_test():
    return 0


class _RaisingRecorderUnit:
    """Only a control-flow fixture; this is not proof of actual C execution."""
    def __init__(self, marker):
        self.original = audit_compare
        self.marker = marker
        self.latest = SimpleNamespace(
            run=_synthetic_native_for_recorder_test,
            digest="synthetic-exception-bookkeeping",
            source="def synthetic():\n    return 0\n",
            ahead_of_time=False,
        )

    def load(self, program, args):
        return None

    def attempt(self, args):
        self.load(self.latest, args)
        self.latest.run()
        raise self.marker

    def __call__(self, *args):
        return self.attempt(args)


def test_recorder_finally_keeps_entry_when_attempt_raises(audit_module):
    marker = _StopAudit("original recorder-test exception")
    region = _RaisingRecorderUnit(marker)
    auditor = audit_module.Auditor()
    auditor.patch_region(_RaisingRecorderUnit)
    auditor.start_profile()
    try:
        with pytest.raises(_StopAudit) as caught:
            region(AuditCell(2.5))
        assert caught.value is marker
        report = auditor.result()
    finally:
        auditor.restore()
    row = _row(report, audit_compare)
    assert row["native_entries"] == 1
    assert row["raised_attempts"] == 1
    assert row["aot_calls"] == row["jit_calls"] == 0
    # The evidence belongs under a rejected/raising attempt too.
    assert row["programs"]["synthetic-exception-bookkeeping"]["native_events"]


@pytest.mark.parametrize("kind", ["float", "large-int"])
def test_real_direct_audit_preserves_box_and_owner_lifetime(audit_module, kind):
    number = float("2.5") if kind == "float" else int("9007199254740993")
    cell = AuditCell(number)
    region = _warm(audit_read, cell)
    events = []
    owner = weakref.ref(cell, lambda ref: events.append("released"))
    auditor = audit_module.Auditor(("direct_calls",))
    auditor.patch_region(heap.Region)
    auditor.start_profile()
    try:
        actual = region(cell)
        assert actual is number
        report = auditor.result()
        del cell
        assert owner() is None
        assert events == ["released"]
    finally:
        auditor.restore()
    row = _row(report, audit_read)
    counters = row["direct_native"]
    assert counters["adapter_entries"] == 1
    assert counters["adapter_returns"] == counters["native_ok"] == 1
    assert counters["cleanup_completed"] == 1
    assert counters["dropped_records"] == 0
    assert row["jit_calls"] == 1 and row["aot_calls"] == 0
    assert row["rule_counters"]["direct_calls"]["successful_calls"] == 1
    assert report["audit_valid"] is True
    native_events = [event for program in row["programs"].values()
                     for event in program["native_events"]]
    assert native_events
    assert all(event["abi_digest"] and event["compiled_c_sha256"]
               and event["direct_variant_digest"] for event in native_events)


def test_real_direct_entry_survives_exception_after_c_return(monkeypatch, audit_module):
    cell = AuditCell(2.5)
    region = _warm(audit_compare, cell)
    real_execute = heap._native.direct_execute
    marker = _StopAudit("raised after genuine direct C return")

    def execute_then_raise(*args, **kwargs):
        real_execute(*args, **kwargs)
        raise marker

    monkeypatch.setattr(heap._native, "direct_execute", execute_then_raise)
    auditor = audit_module.Auditor(("direct_calls",))
    auditor.patch_region(heap.Region)
    auditor.start_profile()
    try:
        with pytest.raises(_StopAudit) as caught:
            region(cell)
        assert caught.value is marker
        report = auditor.result()
    finally:
        auditor.restore()
    row = _row(report, audit_compare)
    counters = row["direct_native"]
    assert counters["adapter_entries"] == counters["native_ok"] == 1
    assert counters["cleanup_completed"] == 1
    assert row["raised_attempts"] == row["postnative_python_errors"] == 1
    assert row["aot_calls"] == row["jit_calls"] == row["unknown_native_calls"] == 0
    assert row["rule_counters"]["direct_calls"]["successful_calls"] == 0
    assert region.direct_calls == 1  # only the pre-audit warm call completed
    assert report["audit_valid"] is True


def test_real_checked_exit_has_cleanup_and_zero_complete_count(audit_module):
    cell = AuditCell(2.5)
    region = _warm(audit_divide, cell, 1.0)
    auditor = audit_module.Auditor(("direct_calls",))
    auditor.patch_region(heap.Region)
    auditor.start_profile()
    try:
        with pytest.raises(ZeroDivisionError):
            region(cell, 0.0)
        report = auditor.result()
    finally:
        auditor.restore()
    row = _row(report, audit_divide)
    counters = row["direct_native"]
    assert counters["adapter_entries"] == counters["adapter_returns"] == 1
    assert counters["checked_exits"] == counters["cleanup_completed"] == 1
    assert counters["native_ok"] == counters["native_errors"] == 0
    assert row["fallback_calls"] == 1
    assert row["aot_calls"] == row["jit_calls"] == 0
    assert row["rule_counters"]["direct_calls"]["successful_calls"] == 0
    assert region.direct_calls == 1


def test_secondary_audit_error_preserves_original_and_native_evidence(monkeypatch, audit_module):
    cell = AuditCell(2.5)
    region = _warm(audit_compare, cell)
    real_execute = heap._native.direct_execute
    marker = _StopAudit("original exception must survive auditor failure")

    def execute_then_raise(*args, **kwargs):
        real_execute(*args, **kwargs)
        raise marker

    def fail_rule_recording(*args, **kwargs):
        raise ValueError("secondary audit reconciliation failure")

    monkeypatch.setattr(heap._native, "direct_execute", execute_then_raise)
    auditor = audit_module.Auditor(("direct_calls",))
    monkeypatch.setattr(auditor, "record_rule", fail_rule_recording)
    auditor.patch_region(heap.Region)
    auditor.start_profile()
    try:
        with pytest.raises(_StopAudit) as caught:
            region(cell)
        assert caught.value is marker
        report = auditor.result()
    finally:
        auditor.restore()
    row = _row(report, audit_compare)
    assert row["direct_native"]["adapter_entries"] == 1
    assert row["direct_native"]["cleanup_completed"] == 1
    assert report["audit_valid"] is False
    assert report["audit_errors"]
