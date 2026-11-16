"""Ten-minute shared-oracle consumer for inference container expressions."""
import ast,collections,importlib.util,json,random,sys,time,types
from pathlib import Path
R=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('shared_structure_oracle',R/'tools/difffuzz/core.py')
core=importlib.util.module_from_spec(spec);spec.loader.exec_module(core)
from recompyler import heap
p=R/'tests/test_program_structures.py'
names={'merge_records','selected_pairs','scoped_pairs','raise_after_store','global_after_comprehension','global_comprehension_iterable'}
m=types.ModuleType('inference_fuzz_subjects');m.__file__=str(p);sys.modules[m.__name__]=m
exec(compile(p.read_text(),str(p),'exec'),m.__dict__)
wrapped={name:heap.lift_structures(getattr(m,name)) for name in names}
for name,w in wrapped.items():assert w.run is not None,(name,w.problem)
seed=6116; rng=random.Random(seed);end=time.monotonic()+float(sys.argv[1])*60
counts=collections.Counter();unchecked=collections.Counter();rounds=0
while time.monotonic()<end:
    shared=[]
    pairs=[(rng.choice(['a','b','c']),rng.choice([None,True,0,-0.0,1.5])) for _ in range(rng.randrange(6))]
    subjects=[('merge_records',({'a':shared},{'a':None,'b':shared})),('selected_pairs',(pairs,)),('scoped_pairs',(pairs,'outer')),('raise_after_store',({},shared)),('global_after_comprehension',(pairs,)),('global_comprehension_iterable',())]
    for name,base in subjects:
        for args,kwargs in core.arguments(getattr(m,name),base,seed=seed+rounds,trials=64):
            result=core.compare(getattr(m,name),wrapped[name],args,kwargs,m,warm=2)
            counts[result['status']]+=1
            if result['status']=='unchecked':unchecked[result['reason']]+=1
            if result['status']=='wrong':
                print(json.dumps(dict(seed=seed+rounds,name=name,args=repr(args),result=result),default=repr),flush=True)
                raise AssertionError('wrong differential result')
            if time.monotonic()>=end:break
        if time.monotonic()>=end:break
    rounds+=1
    if rounds%10==0:print(json.dumps(dict(rounds=rounds,counts=counts,unchecked=unchecked)),flush=True)
print(json.dumps(dict(seed=seed,minutes=sys.argv[1],rounds=rounds,counts=counts,unchecked=unchecked,native={n:w.compiled_calls for n,w in wrapped.items()})),flush=True)
