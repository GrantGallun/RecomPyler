"""Local imports across the managed library boundary."""
import builtins
import pytest
from recompyler import heap, lift


def local_import():
    import math as library
    return library


def two_local_imports():
    import math
    import cmath
    return math, cmath


def test_real_runtime_key_executes_local_library_imports():
    original = lift._runtime_key.__wrapped__
    lifted = heap.lift_calls(original)
    assert lifted() == original()
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0
    assert lifted.managed_calls >= 10


def test_local_import_uses_live_original_builtins_and_namespaces(monkeypatch):
    lifted = heap.lift_calls(local_import)
    marker = object()
    seen = []
    original_name = next(name for name in local_import.__code__.co_names if name == 'math')
    original_import = builtins.__import__
    def importer(name, namespace=None, local_namespace=None, fromlist=(), level=0):
        if name != 'math': return original_import(name, namespace, local_namespace, fromlist, level)
        seen.append((name, namespace, local_namespace, fromlist, level))
        return marker
    monkeypatch.setitem(local_import.__builtins__, '__import__', importer)
    try:
        result = lifted()
    finally:
        monkeypatch.undo()
    assert result is marker
    assert len(seen) == 1
    name, namespace, local_namespace, fromlist, level = seen[0]
    assert name is original_name
    assert namespace is local_import.__globals__
    assert local_namespace is None and fromlist is None and level == 0
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_later_import_failure_keeps_effects_once(monkeypatch):
    lifted = heap.lift_calls(two_local_imports)
    events = []
    first = object()
    error = ImportError('later import failed')
    original_import = builtins.__import__
    def importer(name, namespace=None, local_namespace=None, fromlist=(), level=0):
        if name not in ('math', 'cmath'): return original_import(name, namespace, local_namespace, fromlist, level)
        events.append(name)
        if name == 'math': return first
        raise error
    monkeypatch.setitem(two_local_imports.__builtins__, '__import__', importer)
    try:
        with pytest.raises(ImportError) as caught:
            lifted()
    finally:
        monkeypatch.undo()
    assert caught.value is error
    assert events == ['math', 'cmath']
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def dotted_import():
    import xml.etree
    return xml


def dotted_alias_import():
    import xml.etree as tree
    return tree


def test_dotted_import_retains_top_package_binding():
    lifted = heap.lift_calls(dotted_import)
    assert lifted() is dotted_import()
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_dotted_alias_declines_before_import_effects():
    lifted = heap.lift_calls(dotted_alias_import)
    assert lifted() is dotted_alias_import()
    assert lifted.compiled_calls == 0 and lifted.fallback_calls == 1


def test_missing_import_builtin_keeps_original_exception_context():
    from types import FunctionType
    namespace = dict(local_import.__globals__)
    namespace['__builtins__'] = dict(builtins.__dict__)
    del namespace['__builtins__']['__import__']
    original = FunctionType(local_import.__code__, namespace)
    lifted = heap.lift_calls(original)
    with pytest.raises(ImportError) as caught:
        lifted()
    assert str(caught.value) == '__import__ not found'
    assert caught.value.__context__ is None
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_real_llvm_refcount_rewrite_uses_live_instruction_objects():
    from llvmlite import ir
    module = ir.Module(name='managed_boundary_refcounts')
    function = ir.Function(module, ir.FunctionType(ir.VoidType(), []), name='subject')
    block = function.append_basic_block('entry')
    builder = ir.IRBuilder(block)
    operation = ir.Function(module, ir.FunctionType(ir.VoidType(), []), name='NRT_incref')
    removed = builder.call(operation, [])
    returned = builder.ret_void()
    original_instructions = block.instructions
    lifted = heap.lift_structures(lift._drop_refcounts)
    assert lifted(function) is None
    assert block.instructions is original_instructions
    assert len(block.instructions) == 1 and block.instructions[0] is returned
    assert removed not in block.instructions
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0
    assert lifted.managed_calls >= 2
