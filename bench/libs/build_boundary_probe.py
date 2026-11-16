"""Offline build of the experimental borrowed C-call dispatcher."""
import ctypes,os
from setuptools import Extension,setup
if os.name=='nt':ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
setup(name='library-boundary-probe',packages=[],package_dir={'':'src'},ext_modules=[Extension(
    'recompyler.libraries._boundary_native',['src/recompyler/libraries/_boundary_native.c'])])
