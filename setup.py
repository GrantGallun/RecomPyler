from setuptools import Extension, setup

# The C halves of recompyler.monitor and recompyler.heap. Optional: without a
# compiler both fall back to the same code written in Python.
setup(ext_modules=[Extension("recompyler._monitor", ["src/recompyler/_monitor.c"], optional=True),
                   Extension("recompyler._heap", ["src/recompyler/_heap.c"], optional=True)])
