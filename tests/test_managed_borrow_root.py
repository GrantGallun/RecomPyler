"""Borrowed roots require a synchronous caller that pins the Python inputs."""
import gc
import sys
import weakref
import pytest


@pytest.fixture(scope='module')
def pinned_read():
    from numba import njit
    from numba.extending import intrinsic
    from numba.core import types
    from recompyler._managed_native import managed,borrow_root,borrowed_object,pool_item
    @intrinsic
    def borrow(typing_context,value):
        if value!=managed:return
        def codegen(context,builder,signature,args):
            return borrow_root(context,builder,borrowed_object(context,builder,args[0]))
        return managed(value),codegen
    @njit(types.Tuple((managed,types.boolean))(managed))
    def select(pool):
        root=borrow(pool)
        return pool_item(root,0)
    return next(iter(select.overloads.values())).entry_point


class Owner:pass


def test_pinned_borrow_boxes_exact_selected_owner_before_root_release(pinned_read):
    owner=Owner();reference=weakref.ref(owner);pool=(owner,)
    for _ in range(100):
        result,ok=pinned_read(pool)
        assert ok and result is owner
        del result
    result,ok=pinned_read(pool)
    del owner,pool;gc.collect()
    assert reference() is result
    del result;gc.collect();assert reference() is None


def test_pinned_borrow_keeps_python_cycles_visible(pinned_read):
    owner=Owner();pool=(owner,);owner.pool=pool;reference=weakref.ref(owner)
    result,ok=pinned_read(pool);assert ok and result is owner
    del owner,pool,result;gc.collect();assert reference() is None
