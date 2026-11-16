"""Root activation clears source locals in CPython's reverse slot order."""
import pytest
from recompyler import heap

def cleanup(make):
    first=make('first')
    second=make('second')
    third=make('third')
    return None

@pytest.mark.parametrize('factory',[heap.lift_calls,heap.lift_structures])
def test_root_cleanup_uses_source_slot_order(factory):
    logs=[]
    for call in (cleanup,factory(cleanup)):
        events=[]
        class Token:
            def __init__(self,name):self.name=name
            def __del__(self):events.append(self.name)
        def make(name):return Token(name)
        assert call(make) is None
        logs.append(events)
    assert logs[0]==['third','second','first']
    assert logs[1]==logs[0]
