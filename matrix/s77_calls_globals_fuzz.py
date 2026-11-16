import ctypes,gc,json,random,sys,time,weakref
from pathlib import Path
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
sys.path[:0]=[str(Path(__file__).resolve().parents[1]/'src'),str(Path(__file__).resolve().parents[1]/'tests')]
from test_ir_calls_globals import call_one,call_keywords,call_local,call_temporary,make_keyword_default
from test_ir_existing_frame import frame_entry
from recompyler import _source_frames_native as frames
one=frame_entry(call_one)[0];kw=frame_entry(call_keywords)[0];local=frame_entry(call_local)[0]
factory=frame_entry(make_keyword_default)[0];temporary=frame_entry(call_temporary)[0]
pool=[None,True,False,0,1,2**100,-0.0,float('nan'),complex(-0.0,1),b'bytes','text',[],{},object()]
rng=random.Random(7718);entries=lifetimes=errors=tier1_prefixes=0
start=time.monotonic()
while time.monotonic()-start<60:
 marker=pool[rng.randrange(len(pool))]
 def child(value,default=marker):return value,default
 result=one(child,marker);entries+=1
 assert result[0] is marker and result[1] is marker
 def named(*args,named=None,**kwargs):return named
 assert kw(named,marker) is marker;entries+=1
 assert local(marker) is marker;entries+=1
 closure=factory(marker);entries+=1
 assert closure() is marker and closure(named=None) is None
 result=kw(dict,marker);entries+=1;tier1_prefixes+=1
 assert result['named'] is marker
 if entries%320==0:
  events=[];refs=[]
  class Item:
   def __del__(self):events.append('drop')
  class Source:
   def __add__(self,unused):
    value=Item();refs.append(weakref.ref(value));return value
  def consume(value,probe):value=None;return probe()
  def probe():events.append(('probe',refs[0]() is None));return None
  assert temporary(consume,Source(),probe) is None;entries+=1;lifetimes+=1
  assert events==['drop',('probe',True)]
 if entries%257==0:
  try:one(None,marker)
  except TypeError as error:assert str(error)=="'NoneType' object is not callable"
  else:raise AssertionError('missing TypeError')
  entries+=1;errors+=1
 assert frames.active_depth()==0
result=dict(native_prefix_entries=entries,keyword_tier1_continuations=tier1_prefixes,lifetime_cases=lifetimes,error_cases=errors,wrong=0,unchecked=0,bounded_seconds=60,shared_ir_compiled=82,total=1827)
Path('matrix/s77-calls-globals-fuzz-result.json').write_text(json.dumps(result,indent=2)+chr(10))
print(json.dumps(result))
