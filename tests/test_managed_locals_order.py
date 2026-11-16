import pytest
from recompyler import heap

def ordered(flag):
    if flag:
        later=1
    earlier=2
    later=3
    return locals()

@pytest.mark.parametrize('factory',[heap.lift_structures])
def test_locals_snapshot_uses_original_slot_order_after_skipped_assignment(factory):
    region=factory(ordered)
    assert region.run is not None,region.problem
    expected=ordered(False);actual=region(False)
    assert region.compiled_calls==1 and region.fallback_calls==0
    assert actual==expected and list(actual)==list(expected)


def flat():
    first=1
    second=2
    first=3
    return locals()


def test_plain_call_locals_snapshot_keeps_source_slot_order():
    region=heap.lift_calls(flat)
    assert region.run is not None,region.problem
    expected=flat();actual=region()
    assert actual==expected and list(actual)==list(expected)
    assert region.compiled_calls==1 and region.fallback_calls==0
