"""S60 time-boxed consumer of the shared exact differential oracle."""
import ast, collections, importlib.util, json, random, sys, time, types
from pathlib import Path
R=Path(__file__).resolve().parents[1]
root=R.parent
import recompyler
for peer in ('wave17-matrix','wave18-lift'):
    recompyler.__path__.append(str(root/peer/'src/recompyler'))
spec=importlib.util.spec_from_file_location('shared_core',R/'tools/difffuzz/core.py')
core=importlib.util.module_from_spec(spec);spec.loader.exec_module(core)
from recompyler import heap
p=R/'tests/test_managed_structures.py'
names={'other_root','mutate','iterate_keys','assign_pair','partial_then_error','nested_targets','short_circuit','compare_chain'}
nodes=[node for node in ast.parse(p.read_text()).body if isinstance(node,ast.FunctionDef) and node.name in names or isinstance(node,ast.ClassDef) and node.name=='Record']
m=types.ModuleType('structure_fuzz_subjects');m.__file__=str(p);sys.modules[m.__name__]=m
exec(compile(ast.Module(body=nodes,type_ignores=[]),str(p),'exec'),m.__dict__)
wrapped={name:heap.lift_structures(getattr(m,name)) for name in names}
for name,w in wrapped.items():assert w.run is not None,(name,w.problem)
seed=6016;rng=random.Random(seed);end=time.monotonic()+float(sys.argv[1])*60
counts=collections.Counter();unchecked=collections.Counter();rounds=0
while time.monotonic()<end:
    root=m.Record();leaf=m.Record();leaf.parent=root
    record=m.Record();marker=[]
    subjects=[('other_root',(rng.choice([root,leaf]),)),('mutate',({},set(),'item',marker)),('iterate_keys',({'first':marker,'second':None},)),('assign_pair',(record,(marker,marker))),('partial_then_error',({},'item',marker)),('nested_targets',(record,(marker,[None,False]))),('short_circuit',(rng.choice([None,False,marker,[1]]),0)),('compare_chain',(rng.randrange(-5,6),0,1))]
    for name,base in subjects:
        fn=getattr(m,name);w=wrapped[name]
        for args,kwargs in core.arguments(fn,base,seed=seed+rounds,trials=48):
            result=core.compare(fn,w,args,kwargs,m,warm=2)
            counts[result['status']]+=1
            if result['status']=='unchecked':unchecked[result['reason']]+=1
            if result['status']=='wrong':
                print(json.dumps(dict(seed=seed+rounds,name=name,args=repr(args),result=result),default=repr),flush=True)
                raise AssertionError('wrong differential result')
            if time.monotonic()>=end:break
        if time.monotonic()>=end:break
    rounds+=1
    if rounds%10==0:print(json.dumps(dict(rounds=rounds,counts=counts,unchecked=unchecked)),flush=True)
print(json.dumps(dict(seed=seed,minutes=sys.argv[1],rounds=rounds,counts=counts,unchecked=unchecked,native={name:w.compiled_calls for name,w in wrapped.items()})),flush=True)
