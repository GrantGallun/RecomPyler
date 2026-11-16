"""Offline build of the guarded ndarray primitive prototype."""
import ctypes,os,numpy
from setuptools import Extension,setup
if os.name=='nt':ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
setup(name='library-ndarray-probe',packages=[],package_dir={'':'src'},ext_modules=[Extension(
    'recompyler.libraries._numpy_native',['src/recompyler/libraries/_numpy_native.c'],include_dirs=[numpy.get_include()])])
