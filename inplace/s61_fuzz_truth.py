"""Exact stateful truth replay for the single-review counterexamples."""
import ast,collections,importlib.util,json,sys,types
from pathlib import Path
R=Path(__file__).resolve().parents[1]
import runpy
runpy.run_path(str(R/'inplace/s61_development_provider.py'))
spec=importlib.util.spec_from_file_location('shared_truth_oracle',R/'tools/difffuzz/core.py');core=importlib.util.module_from_spec(spec);spec.loader.exec_module(core)
p=R/'tests/test_managed_structures.py'
names={'and_three','or_three','condition_and','condition_or','condition_chain','nested_and','nested_mixed','nested_not'}
nodes=[n for n in ast.parse(p.read_text()).body if isinstance(n,ast.FunctionDef) and n.name in names or isinstance(n,ast.ClassDef) and n.name in ('StatefulTruth','ComparisonResult')]
m=types.ModuleType('truth_fuzz_subjects');m.__file__=str(p);sys.modules[m.__name__]=m
exec(compile(ast.Module(body=nodes,type_ignores=[]),str(p),'exec'),m.__dict__)
from recompyler import heap
counts=collections.Counter()
for name in sorted(names):
 fn=getattr(m,name);region=heap.lift_structures(fn);assert region.run is not None,region.problem
 for first in (False,True):
  truth=m.StatefulTruth(first)
  if name=='condition_chain':base=(m.ComparisonResult(truth),None,None)
  elif name in ('condition_and','condition_or','nested_not'):base=(truth,None)
  else:base=(truth,None,True)
  for seed in range(10):
   for args,kwargs in core.arguments(fn,base,seed=seed+6160,trials=64):
    result=core.compare(fn,region,args,kwargs,m,warm=2);counts[result['status']]+=1
    assert result['status'] not in ('wrong','unchecked'),(name,first,seed,repr(args),result)
print(json.dumps(counts))
