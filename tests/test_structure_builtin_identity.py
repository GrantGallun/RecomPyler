"""Builtin specialization authenticates the interpreter callable, not metadata."""
import os
from pathlib import Path
import subprocess
import sys

PROBE = r'''
import builtins
import ctypes
import importlib
import operator
import sys
import types
import numba
import llvmlite.ir
import llvmlite.binding
from recompyler import heap, _managed_native, _structures, _call_bridge
assert 'recompyler._structure_ops' not in sys.modules

class Definition(ctypes.Structure):
    _fields_=[('name',ctypes.c_char_p),('function',ctypes.c_void_p),('flags',ctypes.c_int),('doc',ctypes.c_char_p)]
get_function=ctypes.PYFUNCTYPE(ctypes.c_void_p,ctypes.py_object)(('PyCFunction_GetFunction',ctypes.pythonapi))
get_flags=ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.py_object)(('PyCFunction_GetFlags',ctypes.pythonapi))
make_function=ctypes.PYFUNCTYPE(ctypes.py_object,ctypes.POINTER(Definition),ctypes.py_object,ctypes.py_object)(('PyCFunction_NewEx',ctypes.pythonapi))
replacement=types.ModuleType('builtins')
replacement.__dict__.update(vars(builtins))
definition=Definition(b'isinstance',get_function(operator.is_),get_flags(operator.is_),None)
action=make_function(ctypes.byref(definition),replacement,'builtins')
replacement.isinstance=action
sys.modules['builtins']=replacement
try:
    ops=importlib.import_module('recompyler._structure_ops')
finally:
    sys.modules['builtins']=builtins

def invoke(action,value,kind):
    return action(value,kind)

region=heap.lift_structures(invoke,callees=())
assert region.run is not None,region.problem
expected=invoke(action,42,int)
actual=region(action,42,int)
assert expected is False
assert actual is expected, (expected,actual)
assert region.compiled_calls==1 and region.fallback_calls==0
'''

def test_metadata_compatible_builtin_alias_keeps_its_actual_behavior(tmp_path):
    child=tmp_path/'builtin_identity.py'
    child.write_text(PROBE)
    env=os.environ.copy()
    env['PYTHONPATH']=str(Path(__file__).resolve().parents[1]/'src')
    result=subprocess.run([sys.executable,str(child)],env=env,capture_output=True,text=True,timeout=120)
    assert result.returncode==0,result.stdout+result.stderr
