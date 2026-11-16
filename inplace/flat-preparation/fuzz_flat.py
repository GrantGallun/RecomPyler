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
# Extract only the existing subject definitions. Pytest-decorated test functions
# carry mutable marker attributes and are outside the oracle's inert globals.
import ast
subject_file=R/'tests/test_flat_protocol.py'
names={'first','total','tuple_read','integer_last','array_store','array_partial',
       'two_owners','return_owner','bool_read','none_store','partial_raise','partial_divide'}
tree=ast.parse(subject_file.read_text(encoding='utf-8-sig'))
definitions=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in names]
m=types.ModuleType('flat_fuzz_subjects');m.__file__=str(subject_file);m.array=array;m.FACTOR=2.0
sys.modules[m.__name__]=m
exec(compile(ast.Module(body=definitions,type_ignores=[]),str(subject_file),'exec'),m.__dict__)
from recompyler._flat import FlatLifted
subjects=[('first',([1.25,-0.0],)),('total',([1.25,2.5],)),('tuple_read',((1,[1.25,2.5]),)),
 ('integer_last',([2,3],)),('array_store',(array('d',[4.5,-0.0]),0,1.25)),
 ('array_partial',(array('d',[4.5]),0)),('two_owners',([1.25],[4.5])),
 ('return_owner',([1.25],)),('bool_read',([1.25],)),('none_store',(array('d',[4.5]),)),
 ('partial_raise',(array('d',[4.5]),False)),('partial_divide',(array('d',[4.5]),2.0))]
wrapped={name:FlatLifted(getattr(m,name)) for name,args in subjects}
seed=5614;rng=random.Random(seed);end=time.monotonic()+float(sys.argv[1])*60
counts=collections.Counter();rounds=0
while time.monotonic()<end:
 for name,base in subjects:
  fn=getattr(m,name);w=wrapped[name]
  for args,kwargs in core.arguments(fn,base,seed=seed+rounds,trials=72):
   result=core.compare(fn,w,args,kwargs,m,warm=2);counts[result['status']]+=1
   if result['status']=='unchecked':
    print(json.dumps(dict(name=name,result=result)),flush=True);raise AssertionError('unchecked oracle domain')
   if result['status']=='wrong':
    print(json.dumps(dict(seed=seed+rounds,name=name,args=repr(args),result=result),default=repr),flush=True);raise AssertionError('differential wrong')
   if time.monotonic()>=end:break
  if time.monotonic()>=end:break
 rounds+=1
 if rounds%10==0:print(json.dumps(dict(rounds=rounds,counts=counts)),flush=True)
print(json.dumps(dict(seed=seed,minutes=sys.argv[1],rounds=rounds,counts=counts,native_counts={n:w.flat_calls for n,w in wrapped.items()})),flush=True)
