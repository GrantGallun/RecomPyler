"""Constant reads reuse the enclosing tuple owner without hidden caches."""
import gc
import weakref
import pytest


@pytest.fixture(scope='module')
def reads():
    from numba import njit
    from numba.core import types
    from recompyler._managed_native import managed,pool_item,capture_error_into
    signature=types.Tuple((managed,types.boolean))(managed,types.intp,managed)
    @njit(signature)
    def repeat(pool,count,errors):
        value=pool
        for index in range(count):
            value,ok=pool_item(pool,0)
            if not ok:capture_error_into(errors);return errors,False
        return value,True
    @njit(signature)
    def nested(pool,index,errors):
        inner,ok=pool_item(pool,index)
        if not ok:capture_error_into(errors);return errors,False
        value,ok=pool_item(inner,0)
        if not ok:capture_error_into(errors);return errors,False
        return value,True
    return next(iter(repeat.overloads.values())).entry_point,next(iter(nested.overloads.values())).entry_point


class Owner:pass


def test_constant_read_allocation_cost_does_not_grow_with_lookup_count(reads):
    from numba.core.runtime import rtsys,_nrt_python
    _nrt_python.memsys_enable_stats()
    repeat,_=reads;owner=Owner();pool=(owner,)
    def allocations(count):
        before=rtsys.get_allocation_stats().alloc
        result,ok=repeat(pool,count,[None])
        after=rtsys.get_allocation_stats().alloc
        assert ok and result is owner
        return after-before
    assert allocations(1000)==allocations(1)


def test_nested_borrow_selects_the_object_and_retains_it_after_return(reads):
    _,nested=reads;owner=Owner();reference=weakref.ref(owner)
    pool=((owner,),)
    result,ok=nested(pool,0,[None]);assert ok and result is owner
    del owner,pool;gc.collect();assert reference() is result
    del result;gc.collect();assert reference() is None


def test_borrowed_cycle_is_visible_to_python_gc(reads):
    repeat,_=reads;owner=Owner();owner.loop=owner;reference=weakref.ref(owner)
    result,ok=repeat((owner,),2,[None]);assert ok and result is owner
    del owner,result;gc.collect();assert reference() is None


def test_borrow_lookup_errors_keep_exception_and_cleanup_owners(reads):
    _,nested=reads;errors=[None]
    result,ok=nested((),0,errors)
    assert not ok and result is errors
    assert type(errors.pop()) is IndexError
