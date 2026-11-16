from pathlib import Path
import inspect,runpy,sys,textwrap,types,json
from recompyler import provenance as p
R=Path(__file__).resolve().parents[1];sys.path.insert(0,str(R/'inplace/s46-ten-components-v8/shim'))
space=runpy.run_path(str(R/'inplace/s46-ten-components-v8/richards_super/input/run_benchmark.py'),run_name='wave16_binding_probe')
fn=space['Task'].qpkt
lines,first=inspect.getsourcelines(fn.__code__);source=textwrap.dedent(''.join(lines));rebuilt=next(c for c in compile(source,fn.__code__.co_filename,'exec',dont_inherit=True).co_consts if type(c) is types.CodeType and c.co_name==fn.__name__)
left=p._code_key(fn.__code__);right=p._code_key(rebuilt)
keys=['co_code','co_names','co_varnames','co_cellvars','co_freevars','co_flags','co_stacksize','co_exceptiontable','co_argcount','co_posonlyargcount','co_kwonlyargcount','co_consts']
differences={k:[repr(a),repr(b)] for k,a,b in zip(keys,left,right) if a!=b}
print(json.dumps({'function':fn.__qualname__,'differences':differences,'source':source},indent=2))
