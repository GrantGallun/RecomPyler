"""Known-valid default-input diagnostics; never product compiler rules."""
from pathlib import Path
import json,re,sys
D=Path(__file__).resolve().parent
BASE=json.loads((D/'ray-current-base.json').read_text())['variant'] if (D/'ray-current-base.json').exists() else 'numeric-final-v2'
sys.path[:0]=[str(D),str(D/'shim'),str(D/'product-sources-v2'/BASE/'src')]
from recompyler import heap
class SourceOnly(dict):
 def __bool__(self):return True
 def get(self,key,default=None):return True

def program(mode='current'):
 fixed=mode.startswith('float')
 script=D/'ray-current-fixed-float.py' if fixed else Path(json.loads((D/'protocol.json').read_text())['programs']['raytrace']['script'])
 text=script.read_text();ns={'__name__':'__main__','__file__':str(script)}
 exec(compile(text.split('import sys as _sys')[0],str(script),'exec'),ns)
 exec(compile(text[text.index('def _render('):text.index('_times = []')],str(script),'exec'),ns)
 cls=ns['Scene'];original=cls.render;calls=[];cls.render=lambda self,c:calls.append((self,c))
 ns['_render'](100,100);cls.render=original
 old=heap._merge_cycles;report=[]
 def transform(p):
  if mode not in ('current','float'):
   for info in p.order:
    source=info.source
    if info.fn.__name__=='rayColour':
     matches=list(re.finditer(r'(?m)^( +)(t[0-9]+) = list_new\(I, top, st, 0, 0\)$',source))
     if not matches:continue
     if 'stream' in mode:
      from ray_stream_diagnostic import stream_source
      info.source=stream_source(source);report.append({'function':info.name,'kind':'stream ordered firstIntersection minimum','all_tuple_payload_stores_removed':True,'intermediate_list_and_consumer_fused':True});continue
     assert len(matches)==1
     m=matches[0];indent,target=m.group(1,2);n='I[I[np.uint64(v_self + 3)]]'
     replacement=f'{indent}{target} = list_new(I, top, st, 0, '+('5 * '+n if 'tuples' in mode else n)+')'
     source=source[:m.start()]+replacement+source[m.end():]
     if 'tuples' in mode:
      assignment=f'{indent}v__c0_list = {target}';assert source.count(assignment)==1
      source=source.replace(assignment,assignment+f'\n{indent}I[{target} + 1] = {n}')
     removed=0
     if 'tuples' in mode:
      source,removed=re.subn(r'alloc\(I, top, st, 4\)', 'I[v__c0_list + 2] + I[v__c0_list + 1] + 4 * (I[v__c0_list] - 1)',source)
      assert removed==1
     report.append({'function':info.name,'kind':'preallocate scene object count','tuple_bump_sites_removed':removed,'tuple_payload_stores_retained':True})
    elif info.fn.__name__=='visibleLights':
     source,count=re.subn(r'list_new\(I, top, st, 0, 0\)', 'list_new(I, top, st, 0, I[I[np.uint64(v_self + 1)]])',source)
     if count:report.append({'function':info.name,'kind':'preallocate light count','sites':count})
    info.source=source
  p._diag_plain_sources={info.name:info.source for info in p.order}
  p._diag_plain_origins={info.name:getattr(info,'scalar_origin',info.name) for info in p.order}
  p._diagnostic_report=report
  return old(p)
 heap._merge_cycles=transform
 try:
  r=heap.Region(original,ahead_of_time=SourceOnly());p=r.program_for(calls[0]);assert p,r.problem
 finally:heap._merge_cycles=old
 return r,p,calls[0]
