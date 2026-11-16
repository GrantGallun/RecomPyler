from pathlib import Path
import ast,importlib.util,json,types,sys
R=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('oracle',R/'tools/difffuzz/core.py');core=importlib.util.module_from_spec(spec);spec.loader.exec_module(core)
p=R/'tests/test_analysis_cells.py';nodes=[n for n in ast.parse(p.read_text()).body if isinstance(n,ast.ClassDef) and n.name=='Pair' or isinstance(n,ast.FunctionDef) and n.name in ('pair_total','parent_root')]
m=types.ModuleType('tuple_constructor_fuzz');m.__file__=str(p);sys.modules[m.__name__]=m
exec(compile(ast.Module(body=nodes,type_ignores=[]),str(p),'exec'),m.__dict__)
from recompyler import heap
counts={}
for name,base in [('pair_total',(2,3)),('parent_root',(m.Pair(None,2),))]:
 fn=getattr(m,name);region=heap.lift_region(fn)
 for seed in range(20):
  for args,kwargs in core.arguments(fn,base,seed=seed+6116,trials=96):
   result=core.compare(fn,region,args,kwargs,m,warm=2);status=result['status'];counts[status]=counts.get(status,0)+1
   assert status not in ('wrong','unchecked'),(name,seed,repr(args),result)
print(json.dumps(counts))
