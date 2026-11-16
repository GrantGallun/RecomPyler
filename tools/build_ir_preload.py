"""Build the optional preloader namespace reader into this clone."""
import ctypes
from setuptools import Extension,setup
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
setup(name='recompyler-ir-preload-local',ext_modules=[Extension(
    'recompyler.ir._preload_native',['src/recompyler/ir/_preload_native.c'])],
    script_args=['build_ext','--build-lib','src','--build-temp','build/ir-preload'])
