import sys,json,time,hashlib
from pathlib import Path
import numpy as np
D=Path(__file__).resolve().parent;sys.path.insert(0,str(D.parent.parent/'wave13-depth/depth/hand-ceiling-v4'));import depth_hand as h
n=sys.argv[1];mode=sys.argv[2] if len(sys.argv)>2 else 'time';m=json.loads((D/'protocol.json').read_text());script=Path(m['programs'][n]['script']);ns={'__name__':'__main__','__file__':str(script)}
exec(compile(script.read_text().split('import sys as _sys')[0],str(script),'exec'),ns)
if n=='scimark':
 original=ns['Random'](7).RandomVector(2048);initial=np.asarray(original,dtype=np.float64).copy();times=[]
 for rep in range(5):
  t=time.perf_counter();a=initial.copy()
  for i in range(50):h.fft_transform(2048,a);h.fft_inverse(2048,a)
  times.append(time.perf_counter()-t)
 if mode=='verify':
  b=original[:]
  for i in range(50):ns['FFT_transform'](2048,b);ns['FFT_inverse'](2048,b)
  assert a.tobytes()==b.tobytes()
  print('FULL_VECTOR_MATCH',hashlib.sha256(a.tobytes()).hexdigest())
 # Entire original driver prints all subkernel checks. The ceiling times only FFT;
 # store exact FFT checks here and compare only the FFT subset in this cohort.
 print('check fft_sum',float(sum(a)).hex());print('seconds_fft',min(times));print('HAND_AOT_CALLS',500)
elif n=='fannkuch':
 times=[]
 for rep in range(5):
  t=time.perf_counter();value=h.fann(9);times.append(time.perf_counter()-t)
 assert value==ns['fannkuch'](9) if mode=='verify' else value==30
 print('check max_flips',value);print('seconds',min(times));print('HAND_AOT_CALLS',5)
else:
 times=[]
 for rep in range(5):
  t=time.perf_counter();a=np.empty(30000,dtype=np.uint8);h.render(a,100,100);times.append(time.perf_counter()-t)
 if mode=='verify':
  # Reuse the original driver's default scene builder from its suffix, without timing loop.
  text=script.read_text();begin=text.index('def _render(width, height):');end=text.index('\n_times = []',begin);exec(compile(text[begin:end],str(script),'exec'),ns);b=ns['_render'](100,100).bytes.tobytes();assert a.tobytes()==b
  print('FULL_PIXEL_MATCH',hashlib.sha256(b).hexdigest())
 data=a.tobytes();fnv=1469598103934665603
 for x in data:fnv=((fnv^x)*1099511628211)&0xffffffffffffffff
 print('check byte_sum',sum(data));print('check fnv',fnv);print('seconds',min(times));print('HAND_AOT_CALLS',5)
assert 'numba' not in sys.modules
