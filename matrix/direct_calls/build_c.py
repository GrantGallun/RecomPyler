from pathlib import Path
import sys
R=Path(__file__).resolve().parents[2];sys.path.insert(0,str(R/'src'))
from recompyler._pycc.platform import Toolchain
folder=R/'matrix/temp/s34';folder.mkdir(exist_ok=True);t=Toolchain()
objects=t.compile_objects([str(R/'matrix/direct_calls/guarded.c')],str(folder/'objects'),include_dirs=t.get_python_include_dirs(),extra_cflags=['/O2'] if sys.platform=='win32' else ['-O3'])
t.link_shared(str(folder/t.get_ext_filename('wave17_s34')),objects,libraries=t.get_python_libraries(),library_dirs=t.get_python_library_dirs(),export_symbols=['PyInit_wave17_s34'])
print('BUILT wave17_s34')
