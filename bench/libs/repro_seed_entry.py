"""Literal S89 RED: a hot ordinary attribute path cannot obtain a seed."""
import ctypes
import os
from types import SimpleNamespace
import jinja2
from recompyler.ir import compile_function
from tools.ir_self_host import install_candidate
if os.name=='nt':
    ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
function=jinja2.Environment.getattr
environment=jinja2.Environment()
example=SimpleNamespace(value=7)
for _ in range(32): assert function(environment,example,'value')==7
compile_function(function,strict=True)
assert install_candidate(function), 'hot attribute function cannot obtain a canonical entry seed'
assert function(environment,example,'value')==7
