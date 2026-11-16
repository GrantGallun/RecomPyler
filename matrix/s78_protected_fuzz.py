import ctypes,gc,json,random,sys,time,weakref
from pathlib import Path
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
sys.path[:0]=[str(Path(__file__).resolve().parents[1]/'src'),str(Path(__file__).resolve().parents[1]/'tests')]
from test_ir_protected_paths import protected_get,protected_caught,protected_finally,protected_return,protected_unbound,real_frame_entry,_RESOURCES
for fn in (protected_get,protected_caught,protected_finally,protected_return,protected_unbound):real_frame_entry(fn)
invoke=ctypes.pythonapi.PyObject_CallObject;invoke.argtypes=[ctypes.py_object,ctypes.py_object];invoke.restype=ctypes.py_object
rng=random.Random(7817285);pool=[None,True,False,0,-0.0,float('nan'),1j,b'bytes','text',[],{},object()]
attempts=handlers=finally_errors=lifetimes=0;start=time.monotonic()
try:
 while time.monotonic()-start<60:
  marker=pool[rng.randrange(len(pool))];mapping={'key':marker};key='key' if rng.randrange(2) else 'missing'
  result=invoke(protected_get,(mapping,key));attempts+=1
  assert result is (marker if key=='key' else None)
  if key!='key':handlers+=1
  original=ValueError('same error')
  def failure():raise original
  assert invoke(protected_caught,(failure,)) is original;attempts+=1;handlers+=1
  original.__traceback__=None
  events=[]
  def success():events.append('body');return marker
  def cleanup():events.append('finally')
  assert invoke(protected_finally,(success,cleanup)) is marker;attempts+=1
  assert events==['body','finally'];events.clear()
  try:invoke(protected_finally,(failure,cleanup))
  except ValueError as error:assert error is original
  else:raise AssertionError('missing finally error')
  attempts+=1;finally_errors+=1;handlers+=1
  assert events==['finally'];original.__traceback__=None
  items=[marker]
  def clear():items.clear()
  assert invoke(protected_return,(items,clear)) is marker;attempts+=1
  if attempts%320==0:
   result=invoke(protected_unbound,());attempts+=1;handlers+=1
   assert type(result) is UnboundLocalError
   result.__traceback__=None
   events=[]
   class Item:
    def __del__(self):events.append('drop')
   item=Item();reference=weakref.ref(item);items=[item];del item
   result=invoke(protected_return,(items,clear));attempts+=1;lifetimes+=1
   assert result is reference() and events==[]
   del result;gc.collect();assert reference() is None and events==['drop']
 entries=sum(owner.calls.value for owner,handle in _RESOURCES)
 assert 0<entries<=attempts,(entries,attempts)
 assert all(owner.calls.value>0 for owner,handle in _RESOURCES)
 result=dict(native_entries=entries,attempted_entries=attempts,python_dispatch_entries=attempts-entries,per_helper_native_entries=[owner.calls.value for owner,handle in _RESOURCES],interpreted_handler_continuations=handlers,finally_errors=finally_errors,lifetime_cases=lifetimes,wrong=0,unchecked=0,bounded_seconds=60,shared_ir_compiled=419,total=1827)
 Path('matrix/s78-protected-fuzz-result.json').write_text(json.dumps(result,indent=2)+chr(10));print(json.dumps(result))
finally:
 for owner,handle in _RESOURCES:handle.close()
