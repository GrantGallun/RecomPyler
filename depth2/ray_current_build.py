from pathlib import Path
import hashlib,json,sys
D=Path(__file__).resolve().parent
from ray_current_common import heap,program
from recompyler._pycc import CC
from numba import types
mode=sys.argv[1];r,p,args=program(mode)
out=D/'ray-current'/mode;out.mkdir(parents=True,exist_ok=False)
module='ray_current_'+hashlib.sha256((mode+p.digest).encode()).hexdigest()[:16]
cc=CC(module);cc.target_cpu='generic';cc.output_dir=str(out)
raw={'i':types.int64,'f':types.float64,'b':types.boolean}
letters=[] if p.entry.ret in (heap.NONE,heap.BOTTOM) else heap._machine_types(p.entry.ret)
ret=types.void if not letters else raw[letters[0]] if len(letters)==1 else types.Tuple(tuple(raw[x] for x in letters))
sig=[types.Array(types.float64,1,'C'),types.Array(types.int64,1,'C'),types.Array(types.int64,1,'C'),types.Array(types.uint8,1,'C')]+[raw[x] for x in heap._param_kinds(p.entry)]
p.check_math();cc.export('r0',ret(*sig))(heap._inlined_entry(p))
from numba.core import codegen
old=codegen.CPUCodeLibrary._optimize_final_module
def capture(lib):
 if isinstance(lib._codegen,codegen.AOTCPUCodegen):(out/'pre-module.ll').write_text(str(lib._final_module))
 value=old(lib)
 if isinstance(lib._codegen,codegen.AOTCPUCodegen):(out/'post-module.ll').write_text(str(lib._final_module))
 return value
codegen.CPUCodeLibrary._optimize_final_module=capture
cc.compile();(out/'generated.py').write_text(p.source)
(out/'build.json').write_text(json.dumps({'mode':mode,'module':module,'digest':p.digest,'source_sha256':hashlib.sha256(p.source.encode()).hexdigest(),'generic':True,'fastmath':False,'diagnostic_only':True,'report':p._diagnostic_report,'fast_mixed':p.fast_mixed,'saw_mixed':p.saw_mixed,'mixed_fields':{c.__qualname__:[a for a,k in fs.items() if k==heap.MIXED] for c,fs in p.fields.items()},'numeric_versions':len(p.numeric_report.get('versions',[])),'scalar_return_abi':{i.name:heap._machine_types(i.ret) for i in p.order if i.name.startswith('sr') and i.fn.__qualname__ in ('Vector.scale','Point.__sub__','Vector.cross')} },indent=2))
print('BUILT',mode,flush=True)
