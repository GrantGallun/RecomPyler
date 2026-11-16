"""Bounded M1 original-function/cell identity, sharing and lifetime checks."""
import gc,json,random,runpy,sys,time,types,weakref
from pathlib import Path
import psutil
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
api=runpy.run_path('tests/test_ir_cells_functions.py')
frame_entry=api['frame_entry']
reader,_,_=frame_entry(api['make_reader'])
pair,_,_=frame_entry(api['make_pair'])
default,_,_=frame_entry(api['make_default'])
replacing,_,claim=frame_entry(api['make_replacing'])
stable_read,stable_write=api['make_pair'](None)
read,_,_=frame_entry(stable_read);write,_,_=frame_entry(stable_write)
empty=api['make_empty']();empty_read,_,_=frame_entry(empty)
remove,_=api['make_delete'](None);remove_native,_,_=frame_entry(remove)
rng=random.Random(177);count=0;lifetimes=0;errors=0
values=[None,True,False,0,-1,1.5,float('nan'),-0.0,complex(-0.0,1.0),b'bytes','text',[],{},object()]
started=time.monotonic()
while time.monotonic()-started<60:
 value=rng.choice(values);next_value=rng.choice(values)
 child=reader(value)
 assert type(child) is types.FunctionType and child() is value
 assert child.__closure__[0].cell_contents is value
 first,second=pair(value)
 assert first.__closure__[0] is second.__closure__[0]
 assert second(next_value) is next_value and first() is next_value
 child=default(value)
 assert child.__defaults__[0] is value and child() is value and child(argument=next_value) is next_value
 assert write(value) is value and read() is value
 count+=5
 if count%80==0:
  try:empty_read()
  except NameError as error:assert error.name=='value'
  else:raise AssertionError('empty cell did not raise')
  count+=1;errors+=1
  dropped=[]
  class Owner:
   def __del__(self):dropped.append('drop')
  remove.__closure__[0].cell_contents=Owner()
  assert remove_native() is None and dropped==['drop']
  count+=1;lifetimes+=1
 if count%127==0:
  events=[]
  class Previous:
   def __del__(self):
    frame=sys._getframe(1)
    events.append(frame.f_code is api['make_replacing'].__code__ and frame.f_locals.get('value') is next_value)
  child=replacing(Previous(),next_value)
  assert child() is next_value and events==[True] and claim.value==1
  count+=1;lifetimes+=1
 if count%1024==0:gc.collect()
result={'native_entries':count,'lifetime_cases':lifetimes,'empty_cell_errors':errors,'wrong':0,'unchecked':0,'bounded_seconds':60,'ir_admission':0}
Path('matrix/s77-cells-functions-fuzz-result.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result),flush=True)
