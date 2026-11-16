"""Dependency subscriptions retain weak entry targets without owner cycles."""
import weakref
from types import FunctionType
from recompyler.ir.entry import create_callable
from test_ir_entry import NativeBody,with_default

def test_entry_supports_weak_targets_and_clears_them_before_application_owners():
    events=[]
    class Value:
        def __del__(self):events.append('default')
    class Owner:
        def __init__(self):self.body=NativeBody('forward')
    value=Value();function=FunctionType(with_default.__code__,globals(),argdefs=(value,))
    original=weakref.ref(function);owner=Owner();owner_ref=weakref.ref(owner)
    entry=create_callable(function,owner.body.address,owner)
    def dead(reference):
        assert original() is not None and owner_ref() is not None
        events.append('weak')
    target=weakref.ref(entry,dead);owner.target=target
    assert target() is entry
    del value,function,owner
    del entry
    assert target() is None and original() is None and owner_ref() is None
    assert events==['weak','default']
