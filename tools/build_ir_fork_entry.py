"""Build only the optional fork backend in this checkout; never install."""
import ctypes
from setuptools import Extension, setup
if not getattr(ctypes.pythonapi, 'PyUnstable_RPCode_SetNative', None):
    raise RuntimeError('build with the RecomPyler CPython fork')
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
setup(name='recompyler-ir-fork-entry-local',
      ext_modules=[Extension('recompyler.ir._fork_entry_native', ['src/recompyler/ir/_fork_entry_native.c'])],
      script_args=['build_ext','--build-lib','src','--build-temp','.cache/ir-fork-entry/obj'])
