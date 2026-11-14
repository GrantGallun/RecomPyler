"""Partial call/ABI diagnostic: specialize merged dispatch and inline one edge."""
import hashlib,json,re,sys
from pathlib import Path
D=Path(__file__).resolve().parent
sys.path[:0]=[str(D/'product-sources-v2/numeric-final-v2/src')]
from numba.core import codegen
from llvmlite import binding as ll
from recompyler._pycc import CC
from recompyler._pycc.platform import Toolchain
origin=D/'ray-current/float-stream';meta=json.loads((origin/'build.json').read_text());module=meta['module'];base=(origin/'post-module.ll').read_text()
match=re.search(r'(?m)^define [^\n]*@([^ (]*s0_[^ (]*rayColour[^ (]*)\([^\n]*\) [^\n]*\{\n',base);assert match
name=match.group(1);start=match.start();end=base.index('\n}',match.end())+2;definition=base[start:end];header,body=definition.split('\n',1)
which=re.search(r'i64 (%arg\.which[.a-zA-Z0-9_]*)',header).group(1)

def redirect(source):
 count=[0,0]
 def call(m):
  fields=m.group(1).split(',');choice=re.fullmatch(r'\s*i64 ([01])\s*',fields[3]);assert choice,m.group(0)
  k=int(choice.group(1));count[k]+=1
  return '@'+name+'_diag'+str(k)+'('+m.group(1)+')'
 source=re.sub('@'+re.escape(name)+r'\(([^\n]*)\)',call,source)
 return source,count
for mode in ('calls-replay','calls-inline'):
 out=D/'ray-current'/mode;out.mkdir(parents=True,exist_ok=False);source=base;counts=None
 if mode=='calls-inline':
  clones=[]
  for k in (0,1):
   h=header.replace('@'+name+'(', '@'+name+'_diag'+str(k)+'(')
   if k==1:h=h[:-1]+'alwaysinline {'
   b=re.sub(re.escape(which)+r'(?![a-zA-Z0-9_.$])',str(k),body)
   clones.append(h+'\n'+b)
  source=base[:start]+'\n\n'.join(clones)+base[end:]
  # Definitions retain original-typed formals. Only actual call lines are redirected.
  lines=[];counts=[0,0]
  for line in source.splitlines():
   if ' call ' in line and '@'+name+'(' in line:
    line,c=redirect(line);counts=[a+b for a,b in zip(counts,c)]
   lines.append(line)
  source='\n'.join(lines)+'\n';assert sum(counts)>=3
 (out/'input.ll').write_text(source);cg=codegen.AOTCPUCodegen(module,cpu_name='generic');lib=cg.create_library(module);lib._final_module=ll.parse_assembly(source);lib._final_module.verify();lib._optimize_final_module();optimized=str(lib._final_module);(out/'optimized.ll').write_text(optimized)
 obj=out/'module.obj';obj.write_bytes(cg._tm.emit_object(lib._final_module));tc=Toolchain();cc=CC(module);mixdir=out/'mixins';mixdir.mkdir();objs=cc._compile_mixins(str(mixdir));tc.link_shared(str(out/(module+'.pyd')),[str(obj),*objs],tc.get_python_libraries(),tc.get_python_library_dirs(),export_symbols=['PyInit_'+module])
 info=dict(meta);info.update(mode=mode,underlying_mode='float-stream',diagnostic_only=True,redirected_calls_by_dispatch=counts,remaining_dispatch1_call_sites=len(re.findall(r'call[^\n]*@'+re.escape(name)+r'_diag1\(',optimized)),remaining_dispatch0_call_sites=len(re.findall(r'call[^\n]*@'+re.escape(name)+r'_diag0\(',optimized)),scope='Eliminate only colourAt dispatch/packed-return edge; rayColour recursive calls remain, not a full call-free ceiling')
 if mode=='calls-inline':
  f=re.search(r'(?m)^define [^\n]*@'+re.escape(name)+r'_diag0\([^\n]*\)[^\n]*\{\n',optimized);assert f
  body0=optimized[f.end():optimized.index('\n}',f.end())]
  info['remaining_recursive_self_call_sites']=len(re.findall(r'call[^\n]*@'+re.escape(name)+r'_diag0\(',body0))
  assert info['remaining_dispatch1_call_sites']==0 and info['remaining_recursive_self_call_sites']>=1,info
 (out/'build.json').write_text(json.dumps(info,indent=2));print('BUILT',mode,info['remaining_dispatch1_call_sites'],flush=True)
