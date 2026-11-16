import sys,os
os.environ["RECOMPYLER_CACHE"]="off"
sys.path.insert(0,'tests')
from test_native_sets import difference
from recompyler.lift import lift
from numba.core import ir
w=lift(difference)
print('result',w({1,2},{2,3}),'native',w.compiled_calls,'problem',w.problem)
for result in w._compiled.overloads.values():
 print('signature',result.signature)
 a=result.type_annotation
 for block in a.blocks.values():
  for st in block.body:
   print(st)
   if isinstance(st,ir.Assign):
    print('TYPE',a.typemap.get(st.target.name))
    v=st.value
    if isinstance(v,ir.Expr) and v.op=='call': print('KEY',getattr(a.typemap.get(v.func.name),'typing_key',None), 'args', [(x.name,str(a.typemap.get(x.name))) for x in v.args])
