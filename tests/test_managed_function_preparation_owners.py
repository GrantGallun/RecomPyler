"""Source binding and compiler preparation do not defer function release to GC."""
import gc
from types import FunctionType
import weakref
import pytest
from recompyler import provenance
from recompyler._call_bridge import _Compiler

def preparation_identity(value):
    return value

@pytest.mark.parametrize('prepare',[provenance.bind_source,_Compiler])
def test_preparation_does_not_leave_recursive_closure_owners(prepare):
    enabled=gc.isenabled()
    gc.disable()
    try:
        function=FunctionType(preparation_identity.__code__,globals())
        reference=weakref.ref(function)
        prepared=prepare(function)
        del prepared,function
        assert reference() is None
    finally:
        if enabled:gc.enable()
