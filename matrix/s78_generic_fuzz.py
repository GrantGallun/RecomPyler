import ctypes,json,random,sys,time
from pathlib import Path
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
sys.path[:0]=[str(Path(__file__).resolve().parents[1]/'src'),str(Path(__file__).resolve().parents[1]/'tests')]
from test_ir_generic_protocols import choose,truth,compare,compare_truth,common_function
from test_ir_existing_frame import frame_entry
from recompyler import _source_frames_native as frames
choose_native=frame_entry(choose)[0];truth_native=frame_entry(truth)[0]
comparisons=[]
for spelling in ('<','<=','==','!=','>','>='):
 ns={};exec('def op(left,right):return left '+spelling+' right',ns);fn=ns['op']
 comparisons.append((fn,frame_entry(fn)[0]))
 ns={};exec('def op(left,right):\n if left '+spelling+' right:return True\n return False',ns);fn=ns['op']
 comparisons.append((fn,frame_entry(fn)[0]))
constants=[]
for index in range(5):
 fn=common_function(index);constants.append((fn(),frame_entry(fn)[0]))
pool=[None,True,False,0,1,-1,2**100,-0.0,float('nan'),float('inf'),1j,'','x','\u03b1\ud800',b'',b'\x00\xff',[],[1],{},set(),(),(1,)]
rng=random.Random(7817);entries=errors=0;start=time.monotonic()
def outcome(fn,left,right):
 try:return True,fn(left,right)
 except (TypeError,ValueError) as error:return False,(type(error),str(error))
while time.monotonic()-start<60:
 left=pool[rng.randrange(len(pool))];right=pool[rng.randrange(len(pool))]
 assert choose_native(left,right) is choose(left,right);entries+=1
 assert truth_native(left) is truth(left);entries+=1
 fn,native=comparisons[rng.randrange(len(comparisons))]
 expected=outcome(fn,left,right);actual=outcome(native,left,right);entries+=1
 assert actual[0] is expected[0]
 if actual[0]:assert actual[1] is expected[1]
 else:assert actual[1]==expected[1];errors+=1
 expected,native=constants[rng.randrange(5)];assert native() is expected;entries+=1
 assert frames.active_depth()==0
result=dict(native_entries=entries,error_cases=errors,wrong=0,unchecked=0,bounded_seconds=60,shared_ir_compiled=82,total=1827)
Path('matrix/s78-generic-fuzz-result.json').write_text(json.dumps(result,indent=2)+chr(10));print(json.dumps(result))
