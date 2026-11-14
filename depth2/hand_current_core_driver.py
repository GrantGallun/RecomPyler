import sys,json,time,hashlib
from pathlib import Path
import numpy as np
D=Path(__file__).resolve().parent;sys.path.insert(0,str(D.parent.parent/'wave13-depth/depth/ladder/hand-v2'));import depth_hand_ladder as h
mode=sys.argv[1];out=np.empty(30000,dtype=np.uint8);o=np.zeros((8,16));sh=np.zeros(8,dtype=np.int64);su=np.zeros(8,dtype=np.int64);lights=np.empty((2,3));args=(out,100,100,o,sh,su,lights);ar=np.empty(1<<23);top=np.zeros(1,dtype=np.int64);times=[];setup=[];calls=0
for rep in range(5):
 t=time.perf_counter();h.setup(*args);setup.append(time.perf_counter()-t)
 t=time.perf_counter()
 if mode=='arena':h.arena(*args,ar,top)
 else:h.core(*args)
 times.append(time.perf_counter()-t);calls+=1;assert top[0]<len(ar)
data=out.tobytes();fnv=1469598103934665603
for x in data:fnv=((fnv^x)*1099511628211)&0xffffffffffffffff
assert hashlib.sha256(data).hexdigest()=='11f2c36b02044f115c3937cae1156e9528b95da70f9d6b737a262f06757c2e6b'
print('check byte_sum',sum(data));print('check fnv',fnv);print('seconds',min(times));print('seconds_setup',min(setup));print('CORE_AOT_CALLS',calls);print('MODEL_ARENA_VECTORS',int(top[0])//3);assert 'numba' not in sys.modules
