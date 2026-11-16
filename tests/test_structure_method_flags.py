"""Captured builtin aliases retain their actual CPython calling convention."""
import ctypes
from recompyler import heap

def call_one(action,value):return action(value)

def test_c_function_alias_with_different_flags_keeps_actual_argument_packing():
    class Definition(ctypes.Structure):
        _fields_=[('name',ctypes.c_char_p),('function',ctypes.c_void_p),('flags',ctypes.c_int),('doc',ctypes.c_char_p)]
    get_function=ctypes.PYFUNCTYPE(ctypes.c_void_p,ctypes.py_object)(('PyCFunction_GetFunction',ctypes.pythonapi))
    make_function=ctypes.PYFUNCTYPE(ctypes.py_object,ctypes.POINTER(Definition),ctypes.py_object,ctypes.py_object)(('PyCFunction_NewEx',ctypes.pythonapi))
    # The same valid PyCFunction can receive its tuple as an ordinary object.
    # METH_VARARGS=1 wraps the source arguments; list.append's METH_O=8 does not.
    definition=Definition(b'append_packed',get_function([].append),1,None)
    original_values=[];compiled_values=[];marker=object()
    original=make_function(ctypes.byref(definition),original_values,None)
    compiled=make_function(ctypes.byref(definition),compiled_values,None)
    assert call_one(original,marker) is None
    region=heap.lift_structures(call_one,callees=(),call_kinds=True)
    assert region.run is not None,region.problem
    assert region(compiled,marker) is None
    assert len(original_values)==len(compiled_values)==1
    assert type(compiled_values[0]) is type(original_values[0]) is tuple
    assert compiled_values[0][0] is original_values[0][0] is marker
    assert region.compiled_calls==1 and region.fallback_calls==0
    assert region.managed_calls==1
