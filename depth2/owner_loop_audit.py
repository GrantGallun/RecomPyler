"""LLVM CFG audit: entry-fast loops separately from fallback and cleanup."""
import collections,json,re
from pathlib import Path
D=Path(__file__).resolve().parent

def audit(folder):
 path=next(folder.glob('*.post-module.ll'));source=path.read_text();m=re.search(r'(?m)^define [^\n]*@([^ (]*_rcv[0-9]+_fannkuch[^ (]*)\([^\n]*\)[^\n]*\{\n',source);assert m,path
 body=source[m.end():source.index('\n}',m.end())];blocks={};current=None
 for line in body.splitlines():
  label=re.match(r'^([-a-zA-Z$._0-9]+):',line)
  if label:current=label.group(1);blocks[current]=[]
  elif current:blocks[current].append(line)
 edges={k:set(re.findall(r'label %([-a-zA-Z$._0-9]+)','\n'.join(v))) for k,v in blocks.items()}
 entry=next(iter(blocks));first='\n'.join(blocks[entry]);assert '16777216' in first
 branch=re.search(r'br i1 [^,]+, label %([^, ]+), label %([^, \n]+)',first);assert branch
 fast,fallback=branch.group(1,2)
 def reachable(root):
  todo=[root];seen=set()
  while todo:
   n=todo.pop()
   if n in seen:continue
   seen.add(n);todo+=list(edges[n]-seen)
  return seen
 fastset=reachable(fast);fallbackset=reachable(fallback)
 index=0;indices={};low={};stack=[];active=set();sccs=[]
 def visit(v):
  nonlocal index
  indices[v]=low[v]=index;index+=1;stack.append(v);active.add(v)
  for w in edges[v]:
   if w not in indices:visit(w);low[v]=min(low[v],low[w])
   elif w in active:low[v]=min(low[v],indices[w])
  if low[v]==indices[v]:
   group=[]
   while True:
    w=stack.pop();active.remove(w);group.append(w)
    if w==v:break
   sccs.append(group)
 for v in blocks:
  if v not in indices:visit(v)
 cyclic={n for g in sccs if len(g)>1 or g[0] in edges[g[0]] for n in g}
 calls={k:[line.strip() for line in v if re.search(r'call void @NRT_(?:incref|decref)\(',line)] for k,v in blocks.items()}
 fastloops={k:v for k,v in calls.items() if v and k in fastset&cyclic};fastouter={k:v for k,v in calls.items() if v and k in fastset-cyclic}
 return {'llvm':str(path),'function':m.group(1),'entry_guard_true':fast,'entry_guard_false':fallback,'blocks':len(blocks),'fast_reachable_blocks':len(fastset),'fast_cyclic_blocks':len(fastset&cyclic),'fast_cyclic_nrt_call_sites':sum(map(len,fastloops.values())),'fast_cyclic_nrt_calls_by_block':fastloops,'fast_noncyclic_nrt_calls_by_block':fastouter,'fallback_cyclic_nrt_call_sites':sum(len(v) for k,v in calls.items() if k in fallbackset&cyclic),'full_function_nrt_call_sites':sum(map(len,calls.values())),'note':'static CFG sites, not timings or dynamic execution counts; entry domain selects exact fast region, exits may be shared'}
a=audit(D/'product-artifacts-v2/fannkuch/numeric-owner-capture');b=audit(D/'product-artifacts-v2/fannkuch/owner-v1');out={'baseline':a,'owner':b,'fast_hot_loops_nrt_free':b['fast_cyclic_nrt_call_sites']==0,'ordinary_exit_cleanup_retained':any('NRT_decref' in line for v in b['fast_noncyclic_nrt_calls_by_block'].values() for line in v)}
(D/'owner-loop-llvm-audit.json').write_text(json.dumps(out,indent=2));print(json.dumps(out,indent=2))
