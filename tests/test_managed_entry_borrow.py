import gc
import weakref
import pytest
from numba.core.runtime import rtsys,_nrt_python
from recompyler import heap

def entry_value(value):
    return value

def entry_action(action):
    return action()

def borrowed_region(function):
    region=heap.lift_calls(function,callees=())
    assert region.run is not None,region.problem
    return region

@pytest.mark.parametrize('factory', [heap.lift_calls, heap.lift_structures])
def test_root_entry_uses_at_most_two_native_owner_allocations(factory):
    region=factory(entry_value)
    marker=[]
    assert region(marker) is marker
    _nrt_python.memsys_enable_stats()
    before=rtsys.get_allocation_stats().alloc
    assert region(marker) is marker
    allocated=rtsys.get_allocation_stats().alloc-before
    assert allocated<=2
    assert region.compiled_calls==2 and region.fallback_calls==0


def test_borrowed_pool_remains_pinned_when_callback_replaces_region_pool():
    region=borrowed_region(entry_action)
    events=[]
    class Token:
        def __del__(self):events.append('drop')
    token=Token();reference=weakref.ref(token)
    region.pool=region.pool+(token,)
    del token
    def action():
        region.pool=()
        assert reference() is not None
        events.append('inside')
        return None
    assert region(action) is None
    assert events==['inside','drop'] and reference() is None

def test_borrowed_root_result_and_error_owners_do_not_linger():
    region=borrowed_region(entry_action)
    class Token:pass
    token=Token();reference=weakref.ref(token)
    def result():return token
    assert region(result) is token
    del token
    assert reference() is None
    error=ValueError('original')
    def fail():raise error
    with pytest.raises(ValueError) as caught:region(fail)
    assert caught.value is error
    assert region.compiled_calls==2 and region.fallback_calls==0

def test_borrowed_root_reentry_keeps_private_counter_slots():
    region=borrowed_region(entry_action)
    marker=[]
    def inner():return marker
    def outer():return region(inner)
    assert region(outer) is marker
    assert region.compiled_calls==2 and region.managed_calls==2
    assert region.fallback_calls==0
