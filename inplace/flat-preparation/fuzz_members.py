"""Ten-minute flat consumer of wave17's shared exact graph oracle."""
from array import array
import collections,importlib.util,json,random,sys,time,types
from pathlib import Path
R=Path(__file__).resolve().parents[2]
p=R/'tools/difffuzz/core.py'
spec=importlib.util.spec_from_file_location('shared_difffuzz_core',p)
core=importlib.util.module_from_spec(spec);spec.loader.exec_module(core)
# Consumer adapter for exact array exports, which the first shared generic
# oracle does not yet admit. Preserve typecode/itemsize/raw bits and aliases.
clone0,children0,freeze0=core.clone,core.children,core.Graph.freeze
def clone(value,memo=None):
    if type(value) is array:
        if memo is None:memo={}
        if id(value) in memo:return memo[id(value)]
        result=array(value.typecode);result.frombytes(value.tobytes());memo[id(value)]=result;return result
    return clone0(value,memo)
def children(value):
    return tuple(enumerate(value)) if type(value) is array else children0(value)
def freeze(self,value):
    if type(value) is not array:return freeze0(self,value)
    if id(value) in self.seen:return ('ref',self.seen[id(value)])
    number=len(self.seen);self.seen[id(value)]=number
    identity=('external',self.external[id(value)]) if id(value) in self.external else ('fresh',number)
    return ('array',number,identity,value.typecode,value.itemsize,value.tobytes().hex())
core.clone,core.children,core.Graph.freeze=clone,children,freeze

import ast
subject_file=R/'tests/test_flat_members.py'
names={'read_member','store_member','partial_member','scalar_member','two_members','replace_member'}
tree=ast.parse(subject_file.read_text(encoding='utf-8-sig'))
definitions=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in names or isinstance(n,ast.ClassDef) and n.name=='Box']
m=types.ModuleType('member_fuzz_subjects');m.__file__=str(subject_file);m.array=array
sys.modules[m.__name__]=m
exec(compile(ast.Module(body=definitions,type_ignores=[]),str(subject_file),'exec'),m.__dict__)
from recompyler._flat import FlatLifted
subjects=[('read_member',lambda box,index,value:(box,index)),('store_member',lambda box,index,value:(box,index,value)),
 ('partial_member',lambda box,index,value:(box,index)),('scalar_member',lambda box,index,value:(box,)),
 ('two_members',lambda box,index,value:(box,)),('replace_member',lambda box,index,value:(box,value))]
wrapped={name:FlatLifted(getattr(m,name)) for name,make in subjects}
seed=5615;rng=random.Random(seed);end=time.monotonic()+float(sys.argv[1])*60
counts=collections.Counter();rounds=0
values=[0.,-0.,1.25,-2.5,float('inf'),float('-inf'),*map(lambda x:__import__('struct').unpack('!d',bytes.fromhex(x))[0],('7ff8000000000042','fff8000000001234'))]
scalars=[0,1,-1,2**63-1,2**63,-2**63,True,False,None,1.25,-0.,1e300]
while time.monotonic()<end:
 for name,make in subjects:
  box=m.Box(array('d',[rng.choice(values) for _ in range(rng.choice([0,1,2,8,64]))]))
  box.scale=rng.choice(scalars);box.other=box.data if rng.choice([True,False]) else array('d',[1.0])
  if rounds%8==1:box.data=array('f',[1.25])
  elif rounds%8==2:box.data=[rng.choice(scalars)]
  index=rng.choice([-2,-1,0,1,2,63,64,2**63,True,1.5]);value=rng.choice(values+scalars)
  fn=getattr(m,name);w=wrapped[name];base=make(box,index,value)
  for args,kwargs in core.arguments(fn,base,seed=seed+rounds,trials=48):
   result=core.compare(fn,w,args,kwargs,m,warm=2);counts[result['status']]+=1
   if result['status'] in ('wrong','unchecked'):
    print(json.dumps(dict(seed=seed+rounds,name=name,args=repr(args),result=result),default=repr),flush=True);raise AssertionError('differential '+result['status'])
   if time.monotonic()>=end:break
  if time.monotonic()>=end:break
 rounds+=1
 if rounds%10==0:print(json.dumps(dict(rounds=rounds,counts=counts)),flush=True)
print(json.dumps(dict(seed=seed,minutes=sys.argv[1],rounds=rounds,counts=counts,native_counts={n:w.flat_calls for n,w in wrapped.items()})),flush=True)
