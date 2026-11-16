"""Defaults must execute before the real closure tuple exists."""
import gc,types
from recompyler import heap


def default_cell_visibility(probe, owner):
    def read(value=probe(owner)):
        return owner, value
    return read


def test_default_effect_and_closure_preserve_owner_lifetime():
    import weakref
    fast=heap.lift_structures(default_cell_visibility)
    assert fast.run is not None,fast.problem
    def events_for(call):
        events=[]
        class Owner:pass
        owner=Owner();reference=weakref.ref(owner,lambda _:events.append('freed'))
        marker=object()
        def probe(value):
            assert value is reference()
            events.append('default')
            return marker
        function=call(probe,owner)
        assert function()[0] is owner and function()[1] is marker
        del owner;gc.collect()
        assert reference() is not None
        del function;gc.collect()
        assert reference() is None
        return events
    assert events_for(fast)==events_for(default_cell_visibility)==['default','freed']
    assert fast.compiled_calls==1 and fast.fallback_calls==0
