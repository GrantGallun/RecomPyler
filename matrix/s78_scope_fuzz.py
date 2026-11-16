import ctypes,gc,json,math,random,struct,sys,time,types,weakref
from pathlib import Path
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
sys.path[:0]=[str(Path.cwd()/'src'),str(Path.cwd()/'tests')]
import test_ir_scope_boundaries as t
import test_ir_existing_frame as fixture
from frame_install_cases import Keepalive
owners=[]
def counted(function):
 original=fixture.lower
 def wrapped(*args,**kwargs):
  lowered=original(*args,**kwargs);owner=Keepalive(lowered)
  lowered.testing_counter=owner;lowered.body_address=owner.address;owners.append(owner)
  return lowered
 fixture.lower=wrapped
 try:return fixture.frame_entry(function)[0]
 finally:fixture.lower=original
params=types.FunctionType(next(value for value in t.generic_factory.__code__.co_consts if isinstance(value,types.CodeType)),t.generic_factory.__globals__)
positive=counted(t.positive);negate=counted(t.negate);invert=counted(t.invert);take=counted(t.raw_take_function());delete=counted(t.delete_local);generic=counted(params);alias=counted(t.alias_factory);class_factory=counted(t.class_factory);raise_cause=counted(t.raise_cause)
marker=object();events=[]
class Number:
 def __pos__(self):return marker
class Temporary:
 def __pos__(self):return marker
 def __del__(self):events.append('drop')
number=Number();pool=[None,True,False,0,1.5,1j,b'x','x',[],{},marker]
rng=random.Random(7817009);attempts=errors=lifetimes=generic_cases=0;start=time.monotonic()
while time.monotonic()-start<60:
 value=pool[rng.randrange(len(pool))]
 assert take(value) is value;attempts+=1
 assert delete(value,marker) is marker;attempts+=1
 assert positive(number) is marker;attempts+=1
 integer=rng.randrange(-2**100,2**100);result=invert(integer);attempts+=1
 assert type(result) is int and result==~integer
 real=rng.choice([0.0,-0.0,math.inf,-math.inf,float('nan'),rng.random()]);result=negate(real);attempts+=1
 assert type(result) is float and struct.pack('d',result)==struct.pack('d',-real)
 if attempts%160==0:
  result=generic();attempts+=1;generic_cases+=1
  parameter,=result.__type_params__;assert result.__annotations__=={'value':parameter,'return':parameter}
  assert result(marker) is marker
  result=alias();attempts+=1;assert result.__value__ is int
  result=class_factory();attempts+=1;assert type(result) is type and result.__name__=='Result'
  result=positive(Temporary());attempts+=1;lifetimes+=1
  assert result is marker and events==['drop'];events.clear()
  error=ValueError('same');cause=LookupError('cause')
  try:raise_cause(error,cause)
  except ValueError as actual:assert actual is error and actual.__cause__ is cause
  else:raise AssertionError('missing raise')
  attempts+=1;errors+=1;error.__traceback__=None
entries=sum(owner.calls.value for owner in owners)
assert 0<entries<=attempts,(entries,attempts)
assert all(owner.calls.value>0 for owner in owners)
result=dict(native_entries=entries,attempted_entries=attempts,python_dispatch_entries=attempts-entries,per_helper_native_entries=[owner.calls.value for owner in owners],actual_intrinsic_binary_helpers=generic_cases,lifetime_cases=lifetimes,raise_continuations=errors,wrong=0,unchecked=0,bounded_seconds=60,shared_ir_compiled=1086,total=1827)
Path('matrix/s78-scope-fuzz-result.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
