import psutil
from setuptools import Distribution,Extension
from setuptools.command.build_ext import build_ext
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
d=Distribution({'ext_modules':[Extension('recompyler._source_frames_native',['src/recompyler/_source_frames_native.c'])]})
c=build_ext(d);c.initialize_options();c.build_temp='matrix/temp/s70-frame-build';c.build_lib='src';c.finalize_options();c.run()
