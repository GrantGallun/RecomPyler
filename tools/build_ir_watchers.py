"""Build the watcher extension into this clone without installation."""
import ctypes
from setuptools import Extension, setup
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
setup(name='recompyler-ir-watchers-local', ext_modules=[Extension(
    'recompyler.ir._watchers_native', ['src/recompyler/ir/_watchers_native.c'])],
    script_args=['build_ext','--build-lib','src','--build-temp','build/ir-watchers'])
