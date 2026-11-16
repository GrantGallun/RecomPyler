"""Rebuild unchanged selection with exact wave16 generated source; no forced inference."""
from pathlib import Path
import sys,json,copy,hashlib,os
D=Path(__file__).resolve().parent;R=D.parent;W=R.parent
variant,name=sys.argv[1:];source=D/'bases'/variant
sys.path[:0]=[str(source/'src'),str(W/'wave5-study/results/shim')]
from recompyler import heap,lift,aot
from recompyler._region_seed import restore
class SourceOnly(dict):
 def __bool__(self):return True
 def get(self,k,default=None):return True
old=W/'wave11-ledger/gap-ledger/work'/name/'plan.json';plan=json.loads(old.read_text());out=D/'artifacts'/variant/name;out.mkdir(parents=True,exist_ok=False)
script=W/'wave5-study/results/drivers'/(name+'.py');text=script.read_text();ns={'__name__':'__main__','__file__':str(script)};exec(compile(text.split('import sys as _sys')[0],str(script),'exec'),ns)
if name in ['barnes_hut','raytrace']:
 from recompyler._pycc import CC
 from numba import types
 programs=[]
 for row in plan['plan']['aot_regions']['functions']:
  fn=ns
  for part in row['qualname'].split('.'):fn=fn[part] if isinstance(fn,dict) else getattr(fn,part)
  exports={};seeds={}
  if row['seeds']:
   for seed in row['seeds'].values():
    p=restore(fn,seed);p.compile(SourceOnly());export='r'+str(len(programs));programs.append((p,export));exports[p.digest]=export;seeds[p.digest]=seed
  else:
   assert name=='raytrace'
   exec(compile(text[text.index('def _render('):text.index('_times = []')],str(script),'exec'),ns)
   cls=ns['Scene'];original=cls.render;captured=[];cls.render=lambda self,c:captured.append((self,c))
   ns['_render'](ns['DEFAULT_WIDTH'],ns['DEFAULT_HEIGHT']);cls.render=original
   region=heap.Region(original,ahead_of_time=SourceOnly());p=region.program_for(captured[0]);assert p,region.problem
   export='r'+str(len(programs));programs.append((p,export));exports[p.digest]=export
  row['exports'],row['seeds']=exports,seeds
 module='inplace_'+hashlib.sha256((variant+name+''.join(p.digest for p,e in programs)).encode()).hexdigest()[:20]
 cc=CC(module);cc.output_dir=str(out);cc.target_cpu='generic'
 for p,export in programs:
  p.check_math();raw={'i':types.int64,'f':types.float64,'b':types.boolean};letters=[] if p.entry.ret in (heap.NONE,heap.BOTTOM) else heap._machine_types(p.entry.ret)
  ret=types.void if not letters else raw[letters[0]] if len(letters)==1 else types.Tuple(tuple(raw[x] for x in letters))
  args=[types.Array(types.float64,1,'C'),types.Array(types.int64,1,'C'),types.Array(types.int64,1,'C'),types.Array(types.uint8,1,'C')]+[raw[x] for x in heap._param_kinds(p.entry)]
  cc.export(export,ret(*args))(heap._inlined_entry(p));(out/(export+'.generated.py')).write_text(p.source)
 cc.compile();section=plan['plan']['aot_regions'];section['folder']=str(out);section['module']=module
else:
 entries=[]
 for row in plan['plan']['aot']['functions']:
  fn=ns[row['qualname']];lifted=lift.lift(fn)
  if row['promote']:lifted._promote={id(ns[k]):set(names) for k,names in row['promote'].items()};lifted._build()
  if name=='fannkuch':args=(9,)
  else:
   data=ns['Random'](7).RandomVector(2048);args=(2048,data,-1) if fn.__name__=='FFT_transform_internal' else (2048,data)
  lifted(*copy.deepcopy(args));assert lifted.compiled_calls and not lifted.fallback_calls
  entries.append(((row['function'],row['line']),fn,lifted,[args]));(out/(fn.__name__+'.generated.py')).write_text(lifted.source)
 section=aot.build(entries,out);assert section;plan['plan']['aot']=section
(out/'plan.json').write_text(json.dumps(plan,indent=2));print('BUILT',variant,name,flush=True)
