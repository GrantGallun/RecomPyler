"""Vectorcall preserves original keyword tuple owners and argument order."""
import ctypes
import pytest
from recompyler import heap


class MethodDef(ctypes.Structure):
    _fields_ = [('name', ctypes.c_char_p), ('method', ctypes.c_void_p),
                ('flags', ctypes.c_int), ('doc', ctypes.c_char_p)]


_CCALL = ctypes.PYFUNCTYPE(ctypes.c_void_p, ctypes.c_void_p,
    ctypes.POINTER(ctypes.c_void_p), ctypes.c_ssize_t, ctypes.c_void_p)
_INCREF = ctypes.PYFUNCTYPE(None, ctypes.py_object)(('Py_IncRef', ctypes.pythonapi))


@_CCALL
def _capture_keywords(self, args, nargs, names):
    value = ctypes.cast(names, ctypes.py_object).value if names else None
    _INCREF(value)
    return id(value)


_METHOD = MethodDef(b'keyword_owner', ctypes.cast(_capture_keywords, ctypes.c_void_p), 0x0080 | 0x0002, None)
_NEW_FUNCTION = ctypes.PYFUNCTYPE(ctypes.py_object, ctypes.POINTER(MethodDef),
    ctypes.py_object, ctypes.py_object)(('PyCFunction_NewEx', ctypes.pythonapi))
CAPTURE = _NEW_FUNCTION(ctypes.byref(_METHOD), None, __name__)


def keyword_owner(value):
    return CAPTURE(value=value)


def two_keyword_owners(first, second):
    return CAPTURE(first=first, second=second)


def no_keyword_owner(value):
    return CAPTURE(value)


@pytest.mark.parametrize('function,args', [(keyword_owner, (object(),)),
    (two_keyword_owners, (object(), object()))])
def test_original_keyword_tuple_owner_reaches_fastcall_callee(function, args):
    original = next(value for value in function.__code__.co_consts if type(value) is tuple)
    assert function(*args) is original
    region = heap.lift_calls(function)
    assert region(*args) is original
    assert region.compiled_calls == 1 and region.managed_calls == 1 and region.fallback_calls == 0


def test_positional_vectorcall_has_no_keyword_tuple():
    region = heap.lift_calls(no_keyword_owner)
    assert region(object()) is None
    assert region.compiled_calls == 1 and region.managed_calls == 1 and region.fallback_calls == 0
