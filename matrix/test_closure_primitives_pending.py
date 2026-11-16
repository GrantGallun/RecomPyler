"""CPython MAKE_FUNCTION and real-cell primitive regression contracts."""
import gc
import types
import weakref
import pytest


def outer(owner):
    def inner(default=owner, *, tail=None):
        return owner, default, tail
    return inner


def test_function_creation_keeps_original_metadata_and_shared_cell_owners():
    from recompyler import _closure_ops_native as ops
    owner = object()
    template = outer(owner)
    actual = ops.make_function(template.__code__, template.__globals__, template.__closure__,
                               template.__defaults__, template.__kwdefaults__)
    assert type(actual) is types.FunctionType
    for name in ('__code__', '__globals__', '__defaults__', '__kwdefaults__', '__closure__'):
        assert getattr(actual, name) is getattr(template, name)
    assert actual.__name__ == template.__name__ and actual.__qualname__ == template.__qualname__
    assert actual.__module__ == template.__module__
    assert actual()[0] is owner and actual()[1] is owner and actual()[2] is None
    changed = object()
    template.__closure__[0].cell_contents = changed
    assert actual()[0] is changed


def test_function_creation_matches_real_internal_conversion_factory():
    from recompyler import _closure_ops_native as ops
    from recompyler._call_format import _conversion
    code = next(c for c in _conversion.__code__.co_consts if type(c) is types.CodeType)
    symbol = 'PyObject_Repr'
    cell = types.CellType(symbol)
    fn = ops.make_function(code, _conversion.__globals__, (cell,), None, None)
    expected = _conversion(symbol)
    # Numba's decorator keeps the actual original Python definition.
    assert fn.__code__ is expected._defn.__code__
    assert fn.__closure__[0] is cell and fn.__closure__[0].cell_contents is symbol
    assert fn(None, object()) is None


def test_cell_operations_publish_before_releasing_old_owner():
    from recompyler import _closure_ops_native as ops
    seen = []
    cell = types.CellType()
    class Token:
        def __del__(self):seen.append(cell.cell_contents)
    cell.cell_contents = Token()
    marker = object()
    assert ops.cell_set(cell, marker) is None
    assert seen == [marker]
    assert ops.cell_get(cell, 'value', False) is marker
    assert ops.cell_delete(cell, 'value', False) is None
    with pytest.raises(UnboundLocalError) as caught:ops.cell_get(cell, 'value', False)
    assert str(caught.value) == "cannot access local variable 'value' where it is not associated with a value"
    with pytest.raises(NameError) as caught:ops.cell_get(cell, 'value', True)
    assert type(caught.value) is NameError and caught.value.name == 'value'
    assert str(caught.value) == "cannot access free variable 'value' where it is not associated with a value in enclosing scope"


def test_function_constructor_rejects_invalid_closure_without_retaining_owners():
    from recompyler import _closure_ops_native as ops
    class Owner:pass
    value = Owner()
    reference = weakref.ref(value)
    template = outer(value)
    with pytest.raises(ValueError, match='closure length'):
        ops.make_function(template.__code__, template.__globals__, (), template.__defaults__, None)
    with pytest.raises(TypeError, match='cell'):
        ops.make_function(template.__code__, template.__globals__, (value,), template.__defaults__, None)
    del template, value
    gc.collect()
    assert reference() is None


def loop_factory(count, owner):
    for index in range(count):
        def read():
            return owner
    return read


def test_native_make_function_uses_fresh_real_closure_tuples():
    from recompyler._closure_ops import function_from_cells
    from recompyler import _managed_native as refs
    from recompyler._managed_entry import root_argument, as_managed
    from numba import njit
    from numba.core import types as nt
    @njit
    def native(pool, count):
        code, ok = refs.pool_item(pool, 0)
        namespace, ok = refs.pool_item(pool, 1)
        cell, ok = refs.pool_item(pool, 2)
        none, ok = refs.pool_item(pool, 3)
        value = none
        for index in range(count):
            value, ok = function_from_cells(code, namespace, (cell,), none, none)
            if not ok:return none
        return value
    @njit
    def adapter(pool, count):return native(as_managed(pool), count)
    sig = (root_argument, nt.intp)
    adapter.compile(sig)
    entry = adapter.overloads[sig].entry_point
    owner = object()
    template = loop_factory(1, owner)
    original_cell = template.__closure__[0]
    pool = (template.__code__, template.__globals__, original_cell, None)
    first, second = entry(pool, 1), entry(pool, 1)
    assert first.__code__ is second.__code__ is template.__code__
    assert first.__closure__ is not second.__closure__
    assert first.__closure__[0] is second.__closure__[0] is original_cell
    assert first() is second() is owner


def test_native_function_binding_publishes_before_old_function_weakref_callback():
    from recompyler import _closure_ops_native as ops
    owner = object()
    template = outer(owner)
    frame = {'read': template}
    seen = []
    reference = weakref.ref(template, lambda _: seen.append(frame['read'].__code__))
    code, namespace, closure = template.__code__, template.__globals__, template.__closure__
    defaults, keywords = template.__defaults__, template.__kwdefaults__
    del template
    ops.bind_function(frame, 'read', code, namespace, closure, defaults, keywords)
    assert reference() is None and seen == [code]
    assert frame['read']()[0] is owner


def python_rebind_events(events):
    import sys
    frame = sys._getframe()
    def read():return 1
    def old_dropped(_):
        replacement = weakref.ref(frame.f_locals['read'])
        frame.f_locals['read'] = None
        events.append(replacement() is None)
    old = weakref.ref(read, old_dropped)
    def read():return 2
    return old


def test_source_function_binding_matches_cpython_reentrant_weakref_cleanup():
    from recompyler import _closure_ops_native as ops
    expected = []
    python_rebind_events(expected)
    assert expected == [False]
    template = outer(object())
    code, namespace, closure = template.__code__, template.__globals__, template.__closure__
    defaults, keywords = template.__defaults__, template.__kwdefaults__
    frame = {'read': template}
    actual = []
    def old_dropped(_):
        replacement = weakref.ref(frame['read'])
        frame['read'] = None
        actual.append(replacement() is None)
    old = weakref.ref(template, old_dropped)
    del template
    ops.bind_function(frame, 'read', code, namespace, closure, defaults, keywords)
    assert old() is None
    assert actual == expected == [False]
