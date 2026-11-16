import psutil
from setuptools import Distribution,Extension
from setuptools.command.build_ext import build_ext
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
d=Distribution({'ext_modules':[Extension('recompyler._closure_ops_native',['matrix/closure_ops_native_pending.c'])]})
c=build_ext(d);c.initialize_options();c.build_temp='matrix/temp/s71-closure-build';c.build_lib='src';c.finalize_options();c.run()
