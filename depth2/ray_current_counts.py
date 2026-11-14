"""Exact diagnostic bump removal; separate from uninstrumented timing."""
from pathlib import Path
import copy,hashlib,json,sys
D=Path(__file__).resolve().parent
from ray_current_common import program
from allocation_count_scalar_c import plain_module,execute
result={}
for mode in ('current','lists','tuples','float-tuples','float-stream'):
 r,p,args=program(mode);p._count_sources=p._diag_plain_sources;p._count_origins=p._diag_plain_origins
 ns,counts=plain_module(p);offargs=copy.deepcopy(args);onargs=copy.deepcopy(args)
 wrapped=ns['alloc'];original=next(c.cell_contents for c in wrapped.__closure__ if callable(c.cell_contents));ns['alloc']=original
 off=execute(r,p,offargs,ns);assert not counts;ns['alloc']=wrapped;on=execute(r,p,onargs,ns)
 a=offargs[1].bytes.tobytes();b=onargs[1].bytes.tobytes();assert a==b and off==on and hashlib.sha256(a).hexdigest()=='11f2c36b02044f115c3937cae1156e9528b95da70f9d6b737a262f06757c2e6b'
 result[mode]={'successful_bumps':sum(counts.values()),'by_source':dict(counts),'highwater_slots':on,'all_pixel_bytes_equal':True,'source_report':p._diagnostic_report}
 print(mode,sum(counts.values()),on,flush=True)
(D/'ray-current-counts.json').write_text(json.dumps(result,indent=2))
