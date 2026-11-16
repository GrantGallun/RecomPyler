"""Known native callees reuse their pinned catalogue owner."""
import gc
import weakref
from numba.core.runtime import rtsys,_nrt_python
from recompyler import heap

def leaf(value):
    return value

def direct(value):
    return value

def parent(value):
    return leaf(value)

def guarded(action):
    return leaf(action())

def test_interpreted_child_adds_only_its_result_owner_allocation():
    direct_region=heap.lift_calls(direct,callees=())
    parent_region=heap.lift_calls(parent,callees=(leaf,))
    marker=[]
    assert direct_region(marker) is parent_region(marker) is marker
    _nrt_python.memsys_enable_stats()
    def allocations(region):
        before=rtsys.get_allocation_stats().alloc
        assert region(marker) is marker
        return rtsys.get_allocation_stats().alloc-before
    assert allocations(parent_region)==allocations(direct_region)+1
    assert parent_region.native_helper_calls==0 and parent_region.fallback_calls==0

def test_rebound_callee_keeps_its_own_owner_during_argument_callbacks():
    global leaf
    original=leaf
    region=heap.lift_calls(guarded,callees=(original,))
    assert region.run is not None,region.problem
    events=[];marker=[]
    class Replacement:
        def __call__(self,value):events.append('call');return value
        def __del__(self):events.append('drop')
    replacement=Replacement();reference=weakref.ref(replacement)
    leaf=replacement
    del replacement
    def action():
        global leaf
        leaf=None
        assert reference() is not None
        events.append('argument')
        return marker
    try:
        assert region(action) is marker
        assert events==['argument','call','drop'] and reference() is None
    finally:leaf=original
    assert region.native_helper_calls==0 and region.fallback_calls==0


def test_known_global_lookup_reuses_expected_owner_without_native_child_proof():
    from numba import njit
    from recompyler._managed_native import managed
    from recompyler._managed_names import read_name,read_global_owned
    @njit((managed,managed,managed,managed))
    def cached(namespace,builtins,name,expected):
        return read_global_owned(namespace,builtins,name,expected)
    @njit((managed,managed,managed,managed))
    def ordinary(namespace,builtins,name,expected):
        return read_name(namespace,namespace,builtins,name,False)
    namespace={'leaf':leaf}
    arguments=(namespace,leaf.__builtins__,'leaf',leaf)
    _nrt_python.memsys_enable_stats()
    allocations=[]
    for dispatcher in (cached,ordinary):
        call=dispatcher.overloads[(managed,)*4].entry_point
        assert call(*arguments)==(leaf,True)
        before=rtsys.get_allocation_stats().alloc
        selected,ok=call(*arguments)
        allocations.append(rtsys.get_allocation_stats().alloc-before)
        assert ok and selected is leaf
    assert allocations[0]+1==allocations[1]
