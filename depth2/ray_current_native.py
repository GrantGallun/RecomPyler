"""Same current body with native-only timer and full default pixel gate."""
from pathlib import Path
import copy,hashlib,importlib.util,json,sys,time
import numpy as np
D=Path(__file__).resolve().parent
from ray_current_common import BASE,heap,program
mode=sys.argv[1];body_mode='float-stream' if mode.startswith('calls-') else mode;r,p,args=program(body_mode)
if mode=='current':
 folder=D/'product-artifacts-v2/raytrace'/BASE;sec=json.loads((folder/'plan.json').read_text())['plan']['aot_regions'];module=sec['module']
 assert p.digest in sec['functions'][0]['exports'];export=sec['functions'][0]['exports'][p.digest]
 assert hashlib.sha256(p.source.encode()).hexdigest()==hashlib.sha256((folder/'r0.generated.py').read_text().encode()).hexdigest()
else:
 folder=D/'ray-current'/mode;meta=json.loads((folder/'build.json').read_text());module=meta['module'];export='r0'
 assert meta['digest']==p.digest and meta['source_sha256']==hashlib.sha256(p.source.encode()).hexdigest()
path=next(folder.glob(module+'*.pyd'));spec=importlib.util.spec_from_file_location(module,path);native=importlib.util.module_from_spec(spec);spec.loader.exec_module(native);p.run=getattr(native,export)
r.slots=1<<22;times=[];high=[]
for rep in range(5):
 fresh=copy.deepcopy(args);loader,passed=r.load(p,fresh);F,I,top,st=r.arrays()
 if loader.float_at:F[np.array(loader.float_at,dtype=np.int64)]=loader.float_values
 if loader.int_at:I[np.array(loader.int_at,dtype=np.int64)]=loader.int_values
 for start,values in loader.blocks:I[start:start+len(values)]=values
 top[0]=loader.top;top[1]=0;top[2]=512;top[3]=-1;st[0]=0
 start=time.perf_counter();p.run(F,I,top,st,*passed);times.append(time.perf_counter()-start)
 assert st[0]==0,(mode,st[0],top[3]);high.append(int(top[0]));heap._Unloader(p,loader,F,I).write_back(loader)
 data=fresh[1].bytes.tobytes();assert hashlib.sha256(data).hexdigest()=='11f2c36b02044f115c3937cae1156e9528b95da70f9d6b737a262f06757c2e6b'
fnv=1469598103934665603
for b in data:fnv=((fnv^b)*1099511628211)&0xffffffffffffffff
print('check byte_sum',sum(data));print('check fnv',fnv);print('seconds_native',min(times));print('NATIVE_CURRENT_CALLS',len(times));print('HIGHWATER',json.dumps(high));assert 'numba' not in sys.modules
