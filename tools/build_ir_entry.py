"""Build only the shared IR native entry into this checkout, without installs."""
import ctypes
from setuptools import Extension,setup
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
setup(name='recompyler-ir-entry-local',ext_modules=[Extension('recompyler.ir._entry_native',['src/recompyler/ir/_entry_native.c'])],script_args=['build_ext','--build-lib','src','--build-temp','.cache/build/ir-entry'])
