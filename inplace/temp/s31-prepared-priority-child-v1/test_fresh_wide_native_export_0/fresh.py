
import importlib.util,json,sys
from pathlib import Path
from recompyler import heap,_prepared as pc
source=Path(sys.argv[1]);section=json.loads((source.parent/'section.json').read_text())
name='_prepared_cache_fixture_'+source.parent.name.replace('-','_')
spec=importlib.util.spec_from_file_location(name,source);module=importlib.util.module_from_spec(spec);sys.modules[name]=module;spec.loader.exec_module(module)
row=next(r for r in section['functions'] if r['function']=='alias')
index=pc.open_index(section,row,plan_snapshot={'mode':'standalone','functions':[],'plan':{'aot_regions':section}});assert index is not None,pc.last_miss()
wide=next(c for c in index.cores if c['variant']=='wide-seed');native=index.exports[wide['generated']['digest']]
events=[]
def observe(frame,event,arg):
 if event=='c_call' and arg is native:events.append('native')
def forbidden(*a,**kw):raise AssertionError('analysis on prepared hit')
heap._Program.__init__=forbidden
for value in (module.Box(10),None):
 region=heap.Region(module.alias,index.exports,prepared=index);shared=[]
 programs=index.bind(module.alias);assert programs, (pc.last_miss(),index.reasons)
 diagnostics=[]
 for candidate in programs:
  try:region.load(candidate,(value,shared,shared));diagnostics.append((candidate.digest,'loaded',candidate.guards_hold()))
  except heap._Mismatch:diagnostics.append((candidate.digest,'mismatch',repr(candidate.entry.vars)))
 assert any(row[1]=='loaded' for row in diagnostics),(value,diagnostics)
 sys.setprofile(observe)
 try:result=region(value,shared,shared)
 finally:sys.setprofile(None)
 assert result[0] is result[1] is shared and result[2] is value and shared[0] is value
 assert region.aot_calls==region.prepared_hits==1 and region.jit_calls==region.fallback_calls==0
 assert region.latest.digest==wide['generated']['digest']
assert events==['native','native'],events
print('two actual wide AOT entries; exact overlapping/nullable aliases')
