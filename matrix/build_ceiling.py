from pathlib import Path
import sys
R=Path(__file__).resolve().parents[1];sys.path.insert(0,str(R/'src'))
from recompyler._pycc.platform import Toolchain
name=sys.argv[1];stem='wave17_ceiling_'+name;source=R/'matrix/ceilings'/(name+'.c');folder=R/'matrix/temp/ceilings';folder.mkdir(exist_ok=True)
t=Toolchain();objects=t.compile_objects([str(source)],str(folder/name),include_dirs=t.get_python_include_dirs(),extra_cflags=['/O2'] if sys.platform=='win32' else ['-O3'])
t.link_shared(str(folder/t.get_ext_filename(stem)),objects,libraries=t.get_python_libraries(),library_dirs=t.get_python_library_dirs(),export_symbols=['PyInit_'+stem])
print('BUILT',stem,flush=True)
