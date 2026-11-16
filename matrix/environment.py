from pathlib import Path
import sys, importlib.util, json, keyword, ast, builtins
R=Path(__file__).resolve().parents[1]
print(json.dumps({'python':sys.version,'executable':sys.executable,'modules':{x:importlib.util.find_spec(x) is not None for x in ['numba','numpy','pytest','setuptools']},'keywords':keyword.kwlist,'soft':keyword.softkwlist,'builtins':[x for x in dir(builtins) if not x.startswith('_') and callable(getattr(builtins,x))]},indent=2))
