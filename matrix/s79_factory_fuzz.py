import ctypes,gc,json,random,struct,sys,time,weakref
from pathlib import Path
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
sys.path[:0]=[str(Path.cwd()/'src'),str(Path.cwd()/'tests')]
import test_ir_factory_scopes as t
import test_ir_existing_frame as fixture
from frame_install_cases import Keepalive
from test_ir_protected_paths import real_frame_entry,_RESOURCES
owners=[]
def counted(function):
 original=fixture.lower
 def wrapped(*args,**kwargs):
  lowered=original(*args,**kwargs);owner=Keepalive(lowered);lowered.test_counter=owner;lowered.body_address=owner.address;owners.append(owner);return lowered
 fixture.lower=wrapped
 try:return fixture.frame_entry(function)[0]
 finally:fixture.lower=original
power=counted(t.power);inplace=counted(t.inplace_power)
real_frame_entry(t.factory);real_frame_entry(t.protected_defaults)
invoke=ctypes.pythonapi.PyObject_CallObject;invoke.argtypes=[ctypes.py_object,ctypes.py_object];invoke.restype=ctypes.py_object
rng=random.Random(791772);pool=[None,True,False,0,-0.0,1j,'text',b'bytes',[],{},object()];sentinel=object();marker=object()
class Number:
 def __pow__(self,other,*modulus):return marker
 def __ipow__(self,other,*modulus):return marker
number=Number();attempts=factory_calls=lifetime_cases=iterations=0;start=time.monotonic()
try:
 while time.monotonic()-start<60:
  iterations+=1
  value=pool[rng.randrange(len(pool))]
  functions,outer=invoke(t.factory,([value,value],sentinel));attempts+=1;factory_calls+=1
  assert outer is sentinel and functions[0]() is functions[1]() is value
  cell=functions[0].__closure__[0];assert cell is functions[1].__closure__[0]
  other,outer=invoke(t.factory,([marker],sentinel));attempts+=1;factory_calls+=1
  assert outer is sentinel and other[0]() is marker and other[0].__closure__[0] is not cell
  function=invoke(t.protected_defaults,(value,));attempts+=1;factory_calls+=1
  result=function();assert result[0] is value and result[1] is value
  assert function.__closure__[0].cell_contents is value
  assert power(number,value) is marker;attempts+=1
  assert inplace(number,value) is marker;attempts+=1
  integer=rng.randrange(-10000,10000);exponent=rng.randrange(0,9)
  result=power(integer,exponent);attempts+=1;assert type(result) is int and result==integer**exponent
  real=rng.choice([0.0,-0.0,1.0,-1.0,1.25]);exponent=rng.randrange(0,8)
  result=inplace(real,exponent);attempts+=1;assert type(result) is float and struct.pack('d',result)==struct.pack('d',real**exponent)
  if iterations%32==0:
   class Item:pass
   payload=Item();reference=weakref.ref(payload)
   retained,outer=invoke(t.factory,([payload],sentinel));attempts+=1;factory_calls+=1;lifetime_cases+=1
   del payload;assert reference() is retained[0]()
   retained.clear();gc.collect();assert reference() is None
 entries=sum(owner.calls.value for owner in owners)+sum(owner.calls.value for owner,handle in _RESOURCES)
 assert 0<entries<=attempts and all(owner.calls.value>0 for owner in owners) and all(owner.calls.value>0 for owner,handle in _RESOURCES)
 result=dict(native_entries=entries,attempted_entries=attempts,python_dispatch_entries=attempts-entries,per_helper_native_entries=[owner.calls.value for owner in owners]+[owner.calls.value for owner,handle in _RESOURCES],factory_calls=factory_calls,lifetime_cases=lifetime_cases,wrong=0,unchecked=0,bounded_seconds=60,shared_ir_compiled=1401,total=1827)
 Path('matrix/s79-factory-fuzz-result.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
finally:
 for owner,handle in _RESOURCES:handle.close()
