"""Build only the deopt runtime into this clone without installing."""
import ctypes
from setuptools import Extension,setup
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
setup(name='recompyler-ir-deopt-local',ext_modules=[Extension(
    'recompyler.ir._deopt_native',['src/recompyler/ir/_deopt_native.c'])],
    script_args=['build_ext','--build-lib','src','--build-temp','build/ir-deopt'])
