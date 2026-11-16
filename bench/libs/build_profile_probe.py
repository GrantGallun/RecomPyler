"""Build only the local correctness probe, using installed headers and MSVC."""
import ctypes
import os
from setuptools import Extension, setup
if os.name == 'nt':
    ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(), 0x4000)
setup(name='library-frame-probe', packages=[], package_dir={'': '.'}, ext_modules=[Extension(
    'bench.libs._frame_function_native', ['bench/libs/_frame_function_native.c'])])

