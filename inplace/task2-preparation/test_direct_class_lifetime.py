"""Class lifetime counterexamples, preparation only and never executed.

The compiled parameter exposes existing persistent Program/cache retention.
Do not mark it xfail or skip; successful direct calls also need the full fix.
"""
import gc
import importlib
from pathlib import Path
import weakref

import pytest

from recompyler import heap


def _ephemeral_init(self, value):
    self.value = value


def _ephemeral_read(cell):
    return cell.value > 0.0


def _make_bound_class(name, metaclass=type):
    assert name not in globals()
    cls = metaclass(name, (), {"__module__": __name__, "__init__": _ephemeral_init})
    globals()[name] = cls
    return cls


def _drop_binding(name):
    del globals()[name]


@pytest.mark.parametrize("mode", ["python", "compiled", "direct"])
def test_unbound_argument_class_collects_while_region_remains_alive(mode):
    name = "_Task2EphemeralClass"
    cls = _make_bound_class(name)
    events = []
    watch = weakref.ref(cls, lambda ref: events.append("class"))
    instance = cls(2.5)
    region = None
    try:
        if mode == "python":
            assert _ephemeral_read(instance) is True
        else:
            region = heap.Region(_ephemeral_read)
            assert region(instance) is True
            assert region.compiled_calls == 1
            if mode == "direct":
                assert region.direct_calls == 1
    finally:
        _drop_binding(name)
    del instance, cls
    gc.collect()
    assert watch() is None
    assert events == ["class"]
    if region is not None:
        # The Region itself remains a live caller-owned object throughout.
        assert region.compiled_calls == 1


def test_direct_audit_report_does_not_retain_unbound_class(monkeypatch):
    clone = Path(heap.__file__).resolve().parents[2]
    monkeypatch.syspath_prepend(str(clone / "inplace"))
    audit_module = importlib.import_module("capture_audit")
    name = "_Task2AuditedEphemeralClass"
    cls = _make_bound_class(name)
    events = []
    watch = weakref.ref(cls, lambda ref: events.append("class"))
    instance = cls(2.5)
    region = heap.Region(_ephemeral_read)
    auditor = audit_module.Auditor(("direct_calls",))
    auditor.patch_region(heap.Region)
    auditor.start_profile()
    try:
        assert region(instance) is True
        assert region.direct_calls == 1
        report = auditor.result()
        _drop_binding(name)
        del instance, cls
        gc.collect()
        assert watch() is None
        assert events == ["class"]
        assert report["audit_valid"] is True
        assert region.direct_calls == 1
    finally:
        globals().pop(name, None)
        auditor.restore()


def test_custom_metaclass_finalizer_declines_and_class_can_collect():
    events = []

    class FinalizingMeta(type):
        def __del__(cls):
            events.append("meta-finalized")

    name = "_Task2MetaclassFinalizerClass"
    cls = _make_bound_class(name, FinalizingMeta)
    watch = weakref.ref(cls, lambda ref: events.append("class-weakref"))
    instance = cls(2.5)
    region = heap.Region(_ephemeral_read)
    try:
        assert region(instance) is True
        assert region.compiled_calls == 0
        assert getattr(region, "direct_calls", 0) == 0
        assert region.fallback_calls == 1
    finally:
        _drop_binding(name)
    del instance, cls
    gc.collect()
    assert watch() is None
    assert events.count("meta-finalized") == 1
    assert events.count("class-weakref") == 1
