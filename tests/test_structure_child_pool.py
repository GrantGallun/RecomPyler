"""Native child calls reuse existing catalogue owners."""
from recompyler import heap
from numba.core.runtime import rtsys,_nrt_python

def leaf(value):return value

def direct(value):return value

def parent(value):return leaf(value)

def test_interpreted_child_still_reuses_its_live_catalogue_owner():
    _nrt_python.memsys_enable_stats()
    direct_region=heap.lift_structures(direct,callees=())
    parent_region=heap.lift_structures(parent,callees=(leaf,))
    marker=object()
    for region in (direct_region,parent_region):
        assert region.run is not None,region.problem
        assert region(marker) is marker
    def allocations(region):
        before=rtsys.get_allocation_stats().alloc
        assert region(marker) is marker
        return rtsys.get_allocation_stats().alloc-before
    # Live lookup still reuses its catalogue owner; the interpreter child
    # result now receives the ordinary managed result owner (+1).
    assert allocations(parent_region)==allocations(direct_region)+1
    assert parent_region.compiled_calls==2 and parent_region.fallback_calls==0
    assert parent_region.native_helper_calls==0 and parent_region.managed_calls==2
