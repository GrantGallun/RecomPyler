"""S51 immutable historical population and accepted inclusive-time evidence joins."""
from pathlib import Path
import ast,collections,hashlib,json,math
R=Path(__file__).resolve().parents[1];W=R.parent;D=R/'lift-evidence'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
FLAGS=('artifacts_unchanged','bytecode_unchanged','inputs_unchanged','profile_complete','source_unchanged')

def load_completed(folder):
 c=json.loads((folder/'complete.json').read_text());assert c['complete']
 assert sha(folder/'summary.json')==c['summary_sha256'],folder
 return json.loads((folder/'summary.json').read_text())

def index_rows(rows):
 out=collections.defaultdict(list)
 for r in rows:out[(r['function'],r['line'])].append(r)
 return dict(out)

def weight_value(rows):
 if not rows:return None,'missing_weight_row'
 if len(rows)!=1:return None,'ambiguous_weight_row'
 v=rows[0].get('cumulative_s')
 if type(v) not in (int,float) or not math.isfinite(v) or v<0:return None,'invalid_or_missing_weight'
 return v,'measured'

def resolve_definition(defs,key):
 matches=[d for d in defs if (d['function'],d['line'])==key]
 return (matches[0],'resolved') if len(matches)==1 else (None,'ambiguous_source' if matches else 'missing_source')

def validated_weight_rows(plan,accepted,script):
 try:
  receipt=plan.parent/'complete.json'
  if accepted.get(str(plan))!=sha(plan):return [],'unaccepted_plan'
  if accepted.get(str(receipt))!=sha(receipt):return [],'unaccepted_receipt'
  if not all(json.loads(receipt.read_text()).get(k) for k in FLAGS):return [],'incomplete_weight_receipt'
  data=json.loads(plan.read_text())
  if Path(data['script']).resolve()!=Path(script).resolve():return [],'weight_source_mismatch'
  return data['functions'],'accepted'
 except (OSError,KeyError,ValueError):return [],'missing_or_invalid_weight_plan'

def timer(call):
 return isinstance(call,ast.Call) and isinstance(call.func,ast.Attribute) and isinstance(call.func.value,ast.Name) and call.func.value.id in ('time','pyperf') and call.func.attr=='perf_counter'

def timer_wrapper(node):
 if not node.name.startswith('bench_'):return False
 body=list(node.body)
 starts=[(i,s.targets[0].id) for i,s in enumerate(body) if isinstance(s,ast.Assign) and len(s.targets)==1 and isinstance(s.targets[0],ast.Name) and timer(s.value)]
 ranges={s.targets[0].id for s in body if isinstance(s,ast.Assign) and len(s.targets)==1 and isinstance(s.targets[0],ast.Name) and isinstance(s.value,ast.Call) and isinstance(s.value.func,ast.Name) and s.value.func.id=='range'}
 loops=[i for i,s in enumerate(body) if isinstance(s,ast.For) and ((isinstance(s.iter,ast.Name) and s.iter.id in ranges) or (isinstance(s.iter,ast.Call) and isinstance(s.iter.func,ast.Name) and s.iter.func.id=='range'))]
 for start,name in starts:
  for end,s in enumerate(body):
   v=s.value if isinstance(s,ast.Return) else None
   if isinstance(v,ast.BinOp) and isinstance(v.op,ast.Sub) and timer(v.left) and isinstance(v.right,ast.Name) and v.right.id==name and any(start<i<end for i in loops):return True
 return False

def join_program(name,old,current,defs,timed,source_status='resolved',weight_plan=None):
 by=index_rows(current);rows=[]
 for r in old:
  if not r['captured'] or r['whole_function_native']:continue
  key=(r['function'],r['line']);matches=by.get(key,[])
  current_status='matched' if len(matches)==1 else 'duplicate_current' if matches else 'missing_current'
  cur=matches[0] if len(matches)==1 else None
  definition,resolution=resolve_definition(defs,key)
  if source_status!='resolved':definition,resolution=None,source_status
  wr=[f for f in timed if (f['function'],f['line'])==key]
  if definition and len(wr)==1 and wr[0].get('qualname',definition['qualname'])!=definition['qualname']:wr=[]
  value,weight_status=weight_value(wr)
  if definition is None:value,weight_status=None,'unresolved_source'
  candidate=(cur or {}).get('candidate',{})
  rows.append(dict(key=[name,*key],program=name,function=r['function'],line=r['line'],
   source=definition['source'] if definition else None,source_sha256=definition['source_sha256'] if definition else None,
   qualname=definition['qualname'] if definition else None,source_status=resolution,current_status=current_status,
   current_captured=bool(cur and cur.get('captured')),current_complete=bool(cur and cur.get('retained_complete_calls')),
   already_native=bool(cur and cur['whole_function_native']),current_reason=candidate.get('region_reason') or candidate.get('reason') or 'unknown current result',
   inclusive_s=value,weight_missing=value is None,weight_status=weight_status,weight_plan=str(weight_plan) if value is not None else None,
   wrapper=bool(definition and timer_wrapper(definition['node'])),unknown_remainder=resolution!='resolved' or current_status!='matched',
   source_excerpt=definition['source_excerpt'] if definition else None))
 return rows

def source_definitions(source,hashes):
 out=[]
 for rel,digest in hashes.items():
  p=source/rel
  if not p.exists() or sha(p)!=digest:return [],'source_hash_mismatch_or_missing'
  try:text=p.read_text(encoding='utf-8');tree=ast.parse(text)
  except (OSError,SyntaxError,UnicodeError):return [],'source_parse_error'
  def walk(nodes,prefix=''):
   for n in nodes:
    if isinstance(n,(ast.FunctionDef,ast.AsyncFunctionDef,ast.ClassDef)):
     qual=prefix+n.name
     if not isinstance(n,ast.ClassDef):
      out.append(dict(function=n.name,line=min([n.lineno,*[a.lineno for a in n.decorator_list]]),source=str(p),source_sha256=digest,qualname=qual,node=n,source_excerpt=ast.get_source_segment(text,n)))
     walk(n.body,qual+('.' if isinstance(n,ast.ClassDef) else '.<locals>.'))
    else:
     for field,value in ast.iter_fields(n):
      if isinstance(value,list):walk([v for v in value if isinstance(v,ast.stmt)],prefix)
  walk(tree.body)
 return out,'resolved'

def validate_input_map(accepted,receipt,manifest_path):
 # The producer calls the canonical ALL-input-map digest input_manifest_sha256.
 canonical=hashlib.sha256(json.dumps(accepted,sort_keys=True,separators=(',',':')).encode()).hexdigest()
 assert canonical==receipt['input_manifest_sha256'],'accepted input-map digest mismatch'
 assert accepted.get(str(manifest_path))==sha(manifest_path),'manifest outside accepted input map'

def population():
 olddir=R/'matrix/sets-heldout-v1';nowdir=D/'range-s49-heldout-v1';base=W/'wave14-capture/capture';weightsdir=base/'final-coverage'
 old=load_completed(olddir);now=load_completed(nowdir);accepted=load_completed(weightsdir)['input_sha256']
 manifest_path=base/'input-manifest.json';c=json.loads((weightsdir/'complete.json').read_text())
 validate_input_map(accepted,c,manifest_path)
 recipes={w['name']:w for w in json.loads(manifest_path.read_text())['workloads']}
 baseline=sum(r['whole_function_native'] for pair in now['programs'].values() for r in pair['after']['rows'])
 assert baseline==now['totals']['after']['whole_function_native']==60
 denominator=now['fixed_all_program_defined'];assert denominator==375
 inputs={str(manifest_path):sha(manifest_path)}
 for folder in (olddir,nowdir,weightsdir):
  for filename in ('complete.json','summary.json'):inputs[str(folder/filename)]=sha(folder/filename)
 rows=[];weight_issues={}
 for name,pair in old['programs'].items():
  source=base/'inputs'/name;historical=pair['after'];current=now['programs'].get(name,{}).get('after',{})
  defs,status=source_definitions(source,historical['source_sha256'])
  recipe=recipes.get(name)
  if not recipe or recipe['inputs']!=historical['source_sha256'] or current.get('source_sha256')!=historical['source_sha256']:defs,status=[],'recipe_or_current_source_mismatch'
  plan=base/'base'/name/'plan.json'
  timed,wstatus=validated_weight_rows(plan,accepted,source/Path(recipe['script']).name) if recipe else ([], 'missing_recipe')
  weight_issues[name]=wstatus
  if wstatus=='accepted':
   for p in (plan,plan.parent/'complete.json'):inputs[str(p)]=sha(p)
  rows+=join_program(name,historical['rows'],current.get('rows',[]),defs,timed,status,plan)
 assert len(rows)==135 and len({tuple(r['key']) for r in rows})==135
 inherited=[r['key'] for r in rows if r['already_native']];assert len(inherited)==1
 return dict(baseline_native=baseline,denominator=denominator,historical_population=len(rows),rows=rows,
  input_sha256=inputs,weight_plan_status=weight_issues,inherited_native_keys=inherited,
  weight_note='Existing measured inclusive cumulative_s; overlapping envelopes, not saved wall time. Invalid/missing/ambiguous weights stay null; unresolved keys remain explicit unknown rows.')

if __name__=='__main__':
 import sys
 out=Path(sys.argv[1]);assert not out.exists();data=population();out.write_text(json.dumps(data,indent=2))
 print(len(data['rows']),'rows',sum(r['inclusive_s'] is not None for r in data['rows']),'weighted',sum(r['wrapper'] for r in data['rows']),'confirmed timing wrappers')
