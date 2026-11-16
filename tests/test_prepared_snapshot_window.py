"""Fail-first observer mutations between fingerprinting and guard attachment."""
import pytest
from test_prepared_cache import artifact,row_for,standalone


def test_function_change_after_fingerprint_cannot_be_captured_as_new_guard(artifact,monkeypatch):
    pc,heap,module,source,section=artifact
    index=pc.open_index(section,row_for(section),plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.work)
    original=pc.function_key
    changed=[]
    def observer(fn,refs):
        result=original(fn,refs)
        if fn is module.work and not changed:
            changed.append(True)
            monkeypatch.setattr(fn,'__code__',module.read.__code__)
        return result
    monkeypatch.setattr(pc,'function_key',observer)
    assert index.bind(module.work)==[]
    assert changed


def test_class_change_after_fingerprint_cannot_be_captured_as_new_guard(artifact,monkeypatch):
    pc,heap,module,source,section=artifact
    index=pc.open_index(section,row_for(section),plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.work)
    original=pc._class_key
    changed=[]
    def observer(cls,refs):
        result=original(cls,refs)
        if cls is module.Box and not changed:
            changed.append(True)
            monkeypatch.setattr(cls,'value',property(lambda self:999),raising=False)
        return result
    monkeypatch.setattr(pc,'_class_key',observer)
    assert index.bind(module.work)==[]
    assert changed
