"""An active source call pins its function until return, even if replaced."""
from types import FunctionType,SimpleNamespace
import weakref
from recompyler import heap

def active_function(action):
    return action()

def test_native_entry_pins_active_original_function_like_a_cpython_frame():
    expected=[]
    holder=SimpleNamespace(original=FunctionType(active_function.__code__,globals()))
    reference=weakref.ref(holder.original,lambda _:expected.append('drop'))
    def interpreted_action():
        holder.original=None
        expected.append('inside')
        return None
    assert holder.original(interpreted_action) is None
    assert reference() is None and expected==['inside','drop']
    actual=[]
    region=heap.lift_calls(FunctionType(active_function.__code__,globals()))
    assert region.run is not None,region.problem
    reference=weakref.ref(region.original,lambda _:actual.append('drop'))
    def compiled_action():
        region.original=None
        actual.append('inside')
        return None
    assert region(compiled_action) is None
    assert region.compiled_calls==1 and region.fallback_calls==0
    assert reference() is None and actual==expected


def test_active_function_owner_survives_in_its_exception_traceback():
    import pytest
    for native in (False,True):
        events=[]
        function=FunctionType(active_function.__code__,globals())
        subject=heap.lift_calls(function) if native else SimpleNamespace(original=function)
        reference=weakref.ref(function,lambda _:events.append('drop'))
        del function
        error=ValueError('original')
        def action():
            subject.original=None
            events.append('inside')
            raise error
        with pytest.raises(ValueError) as caught:
            if native:subject(action)
            else:subject.original(action)
        assert caught.value is error
        assert reference() is not None and events==['inside']
        error.__traceback__=None
        del caught
        assert reference() is None and events==['inside','drop']
