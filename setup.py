import ctypes
import json
from pathlib import Path
import sys

from setuptools import Extension, setup

# The C halves of recompyler.monitor and recompyler.heap. Optional: without a
# compiler both fall back to the same code written in Python.
extensions=[Extension("recompyler._flat_native", ["src/recompyler/_flat_native.c"], optional=True,
                             define_macros=[("RECOMPYLER_GUARD_BUILD_SIGNATURE", json.dumps(sys.version))]),
            Extension("recompyler._monitor", ["src/recompyler/_monitor.c"], optional=True),
                   Extension("recompyler._heap", ["src/recompyler/_heap.c"], optional=True,
                             define_macros=[("RECOMPYLER_GUARD_BUILD_SIGNATURE", json.dumps(sys.version))]),
                   Extension("recompyler._structure_ops_native", ["src/recompyler/_structure_ops_native.c"], optional=True),
                   Extension("recompyler.ir._preload_native", ["src/recompyler/ir/_preload_native.c"], optional=True),
                   Extension("recompyler.ir._watchers_native", ["src/recompyler/ir/_watchers_native.c"], optional=True),
                   Extension("recompyler.ir._borrowed_native", ["src/recompyler/ir/_borrowed_native.c"], optional=True),
                   Extension("recompyler.ir._deopt_native", ["src/recompyler/ir/_deopt_native.c"], optional=True),
                   Extension("recompyler.ir._entry_native", ["src/recompyler/ir/_entry_native.c"], optional=True),
                   Extension("recompyler._source_frames_native", ["src/recompyler/_source_frames_native.c"], optional=True)]

# Library guards are opt-in. NumPy headers are used only when already installed.
extensions.append(Extension("recompyler.libraries._boundary_native",
                            ["src/recompyler/libraries/_boundary_native.c"],optional=True))
try:
    import numpy
except ImportError:
    pass
else:
    extensions.append(Extension("recompyler.libraries._numpy_native",
                                ["src/recompyler/libraries/_numpy_native.c"],
                                include_dirs=[numpy.get_include()],optional=True))
extensions.append(Extension("recompyler._flat_native", ["src/recompyler/_flat_native.c"], optional=True,
                            define_macros=[("RECOMPYLER_GUARD_BUILD_SIGNATURE", json.dumps(sys.version))]))
if hasattr(ctypes.pythonapi, 'PyUnstable_RPCode_SetNative'):
    extensions.append(Extension("recompyler.ir._fork_entry_native",
                                ["src/recompyler/ir/_fork_entry_native.c"], optional=True))
    for extension in extensions:
        extension.include_dirs.insert(0, str(Path(sys.base_prefix)/'PC'))
        extension.library_dirs.insert(0, str(Path(sys.executable).parent))
setup(ext_modules=extensions)
