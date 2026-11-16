"""Build only clone-local optional C helpers for the base and candidate."""
from pathlib import Path
from setuptools import Distribution,Extension
from setuptools.command.build_ext import build_ext
R=Path(__file__).resolve().parents[1]
for label,root in [('base',R/'matrix/temp/bases/base'),('candidate',R)]:
    folder=root/'src/recompyler'
    extensions=[Extension('recompyler.'+name,[str(folder/(name+'.c'))]) for name in ['_heap','_monitor']]
    dist=Distribution({'name':'wave17-local-helpers','ext_modules':extensions})
    cmd=build_ext(dist);cmd.initialize_options();cmd.build_temp=str(R/'matrix/temp/cbuild'/label);cmd.build_lib=str(root/'src');cmd.finalize_options();cmd.run()
    print('BUILT',label,flush=True)
