"""Exact CPython from-imports in managed preparation helpers."""
import builtins
import sys
from types import SimpleNamespace
import pytest
from recompyler import heap, _prepared

pytestmark = pytest.mark.skipif(sys.implementation.name != 'cpython' or sys.version_info[:2] != (3, 14), reason='versioned CPython import-from operation')


def imported_fields():
    from math import sin as first, cos as second
    return first, second


def relative_import():
    from recompyler import heap as library
    return library


def test_real_prepared_signature_runs_relative_import():
    program = SimpleNamespace(entry=SimpleNamespace(params=['value'],vars={'value':heap.INT},ret=heap.FLOAT))
    lifted = heap.lift_calls(_prepared._signature)
    assert lifted(program) == _prepared._signature(program)
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_from_import_keeps_original_fromlist_and_name_owners(monkeypatch):
    lifted = heap.lift_calls(imported_fields)
    first,second = object(),object()
    module = SimpleNamespace(sin=first,cos=second)
    seen=[]
    original_import = builtins.__import__
    def importer(name, namespace=None, local_namespace=None, fromlist=(), level=0):
        if name != 'math': return original_import(name,namespace,local_namespace,fromlist,level)
        seen.append((name, namespace, local_namespace, fromlist, level))
        return module
    monkeypatch.setitem(imported_fields.__builtins__,'__import__',importer)
    try: result=lifted()
    finally: monkeypatch.undo()
    assert result[0] is first and result[1] is second
    original_names = next(value for value in imported_fields.__code__.co_consts if type(value) is tuple)
    assert seen[0][0] is next(name for name in imported_fields.__code__.co_names if name=='math')
    assert seen[0][1] is imported_fields.__globals__
    assert seen[0][2] is None and seen[0][3] is original_names and seen[0][4] == 0
    assert lifted.compiled_calls==1 and lifted.fallback_calls==0


def test_missing_imported_field_keeps_cpython_error_details(monkeypatch):
    lifted=heap.lift_calls(imported_fields)
    module=SimpleNamespace(sin=object(),__name__='controlled_import')
    original_import=builtins.__import__
    def importer(name, namespace=None, local_namespace=None, fromlist=(), level=0):
        if name=='math':return module
        return original_import(name,namespace,local_namespace,fromlist,level)
    monkeypatch.setitem(imported_fields.__builtins__,'__import__',importer)
    try:
        with pytest.raises(ImportError) as plain: imported_fields()
        with pytest.raises(ImportError) as native: lifted()
    finally: monkeypatch.undo()
    assert native.value.args==plain.value.args
    assert native.value.name==plain.value.name and native.value.path==plain.value.path
    assert type(native.value.__context__) is type(plain.value.__context__)
    assert lifted.compiled_calls==1 and lifted.fallback_calls==0


def test_circular_import_field_resolves_original_sys_modules_owner(monkeypatch):
    from types import ModuleType
    module=ModuleType('controlled_import')
    module.sin=object()
    second=object()
    monkeypatch.setitem(sys.modules,'controlled_import.cos',second)
    lifted=heap.lift_calls(imported_fields)
    original_import=builtins.__import__
    def importer(name, namespace=None, local_namespace=None, fromlist=(), level=0):
        if name=='math':return module
        return original_import(name,namespace,local_namespace,fromlist,level)
    monkeypatch.setitem(imported_fields.__builtins__,'__import__',importer)
    try: result=lifted()
    finally: monkeypatch.undo()
    assert result[0] is module.sin and result[1] is second
    assert lifted.compiled_calls==1 and lifted.fallback_calls==0


def test_imported_attribute_callback_order_exception_and_name_owners(monkeypatch):
    events=[]
    first=object()
    error=ValueError('second imported attribute')
    class Module:
        def __getattr__(self,name):
            events.append(name)
            if name=='sin':return first
            raise error
    module=Module()
    lifted=heap.lift_calls(imported_fields)
    original_import=builtins.__import__
    def importer(name, namespace=None, local_namespace=None, fromlist=(), level=0):
        if name=='math':return module
        return original_import(name,namespace,local_namespace,fromlist,level)
    monkeypatch.setitem(imported_fields.__builtins__,'__import__',importer)
    try:
        with pytest.raises(ValueError) as caught: lifted()
    finally: monkeypatch.undo()
    assert caught.value is error
    assert events==['sin','cos']
    assert all(any(name is original for original in imported_fields.__code__.co_names) for name in events)
    assert lifted.compiled_calls==1 and lifted.fallback_calls==0
