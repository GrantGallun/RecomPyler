"""Build S52 query data from whole, unmodified real module sources."""
import ast,hashlib,json,pprint
from pathlib import Path
R=Path(__file__).resolve().parents[2]
inputs=R.parent/'wave14-capture/capture/inputs'
files={name:inputs/name/'run_benchmark.py' for name in ('richards_super','hexiom','chaos','gc_collect','regex_effbot','regex_dna','base64')}
files['shlex']=Path('C:/Python314/Lib/shlex.py')
sources={name:{'path':str(path.relative_to(R.parent)) if path.is_relative_to(R.parent) else str(path),'sha256':hashlib.sha256(path.read_bytes()).hexdigest(),'text_sha256':hashlib.sha256(path.read_text(encoding='utf-8').encode()).hexdigest(),'text':path.read_text(encoding='utf-8')} for name,path in files.items()}
queries=[]
def add(module,fn,expr,kind,root,consumer,missing,action='origin',occurrence=0):
 queries.append(dict(id=f'{module}.{fn}.{len(queries)+1}',module=module,function=fn,expression=expr,occurrence=occurrence,expected_kind=kind,argument=root,consumer=consumer,missing_fact=missing,action=action))
add('richards_super','Task.qpkt','self.ident','attribute',0,'direct field read selects original self.ident under inert-layout guard','guarded field origin')
add('richards_super','Task.qpkt','pkt.link','attribute',1,'direct store identifies original destination field','guarded field location')
add('richards_super','Task.qpkt','t.addPacket(pkt, self)',None,None,'returned method object owner needs callee-to-caller transfer','callee allocation tags','callee')
add('richards_super','Task.runTask','self.input','attribute',0,'borrow original packet selected from self.input','guarded field origin')
add('richards_super','Task.runTask','msg.link','attribute',0,'selected packet successor remains rooted through self','physical roots','physical')
add('richards_super','Task.runTask','self.fn(msg, self.handle)',None,None,'resolve selected task returned by direct method call','callee return transfer','callee')
add('richards_super','DeviceTask.fn','r','argument',2,'formal r aliases local d before pending-field reads','nested __class__ closure')
add('richards_super','DeviceTask.fn','d.pending','attribute',2,'load original pending packet through record argument','nested __class__ closure')
add('richards_super','DeviceTask.fn','d.pending','attribute',2,'retire old pending field only after publication is safe','journal topology','journal')
add('richards_super','HandlerTask.fn','h.work_in','attribute',2,'borrow original work packet from argument record','nested __class__ closure')
add('richards_super','HandlerTask.fn','work.data[count]','element',2,'preserve packet data element origin at managed transfer','nested __class__ closure')
add('richards_super','HandlerTask.fn','h.device_in','attribute',2,'transfer changed device queue through R8 virtual field','virtual-field transfer','virtual')
add('richards_super','schedule','taskWorkArea.taskList','attribute',None,'guard and pin global task-list owner','global field origin')
add('richards_super','schedule','t.link','attribute',None,'loop-selected task field needs dynamic owner correlation','loop-carried selected owner')
add('richards_super','schedule','t','argument',None,'prove current loop task remains physically rooted across call','physical roots','physical')
add('hexiom','Hex.link_nodes','node.pos','attribute',0,'borrow position of each node from caller-owned nodes list','borrowed iterable element')
add('hexiom','Hex.link_nodes','node.links','attribute',0,'pin original links list across native append','physical roots','physical')
add('hexiom','Hex.link_nodes','self.nodes_by_pos[nx, ny]','element',0,'read caller dictionary element through original self','guarded element origin')
add('hexiom','Done.filter_tiles','tiles[v]','element',1,'read exact caller tiles element under integer-index guard','guarded element origin')
add('hexiom','Done.filter_tiles','tiles','argument',1,'pin tiles through remove_all callbacks','physical roots','physical')
add('chaos','Chaosgame.transform_point','point.x','attribute',1,'original point field feeds guarded numeric read','guarded field origin')
add('chaos','Chaosgame.transform_point','self.splines[trafo[0]]','element',0,'select borrowed spline from caller object','guarded element origin')
add('chaos','Chaosgame.transform_point','basepoint',None,None,'returned point from spline call needs dynamic allocation/owner tag','callee allocation tags','callee')
add('chaos','Spline.__call__','self.points[0]','element',0,'endpoint returns exact original point instead of rebuilding it','comprehension CFG')
add('chaos','Spline.__call__','d',None,None,'local comprehension list is fresh but contains borrowed point owners','comprehension CFG')
add('chaos','Spline.__call__','d[0]',None,None,'join endpoints and generated point with callee allocation tag','callee allocation tags','callee')
add('gc_collect','create_cycle','node','argument',0,'original starting node passed into final link_next','argument identity')
add('gc_collect','create_cycle','Node()',None,None,'separate dynamic node allocations from repeated same source site','callee allocation tags','callee')
add('gc_collect','create_cycle','current',None,None,'link updates preserve cycles and retire prior journal owners safely','journal topology','journal')
add('regex_effbot','gen_string_table','strings',None,None,'fresh local strings list escapes with every appended owner','nested closure and fresh-list contents')
add('regex_effbot','gen_string_table','strings.append',None,None,'closure captures same list across eager append calls','nested closure')
add('regex_effbot','gen_string_table','s',None,None,'forward original string input through local helper before optional encode','nested closure')
add('regex_dna','run_benchmarks','seq','argument',0,'forward original bytes into first re.sub call','argument identity')
add('regex_dna','run_benchmarks','re.sub(b\'>.*\\n|\\n\', b\'\', seq)',None,None,'result bytes need object call owner transfer','callee return transfer','callee')
add('shlex','shlex.read_token','self.token','attribute',0,'selected token field must keep original str owner on return','unsupported CFG')
add('shlex','shlex.read_token','nextchar',None,None,'character owner selected by stream read needs call transfer','callee return transfer','callee')
add('base64','bench_b64_small','base64.b64encode(DATA_TINY)',None,None,'borrow bytes input and materialize exact output owner','callee return transfer','callee')
add('base64','bench_b64_small','DATA_TINY',None,None,'global bytes owner remains live across encode/decode callback','physical roots','physical')
# Auxiliary existing parked fixture: not counted as a real held-out positive.
p=R.parent/'wave18-lift/lift-evidence/next-local-s49-tests.py'
t=p.read_text(encoding='utf-8-sig');node=next(n for n in ast.parse(t).body if isinstance(n,ast.FunctionDef) and n.name=='borrowed')
aux={'source':ast.get_source_segment(t,node),'path':str(p.relative_to(R.parent)),'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'consumer':'parked local-call borrowed-list pop preserves surviving caller list and argument evaluation order','missing_fact':'nested closure plus mutable element transfer'}
# Pin each query to its intended consumer operation, including Load/Store context.
for case in queries:
 tree=ast.parse(sources[case['module']]['text']);fn=tree
 for name in case['function'].split('.'):
  fn=next(n for n in fn.body if isinstance(n,(ast.ClassDef,ast.FunctionDef)) and n.name==name)
 ordinal=int(case['id'].rsplit('.',1)[1])
 targets=[n for n in ast.walk(fn) if isinstance(n,ast.expr) and ast.unparse(n)==case['expression']]
 if ordinal in (2,9,12):targets=[n for n in targets if isinstance(getattr(n,'ctx',None),ast.Store)]
 elif ordinal in (23,30):targets=[n.value for n in ast.walk(fn) if isinstance(n,ast.Return) and isinstance(n.value,ast.Name) and n.value.id in ('basepoint','strings')]
 elif ordinal==15:targets=[n.func.value for n in ast.walk(fn) if isinstance(n,ast.Call) and ast.unparse(n.func)=='t.runTask']
 elif ordinal==25:
  targets=[n for n in ast.walk(fn) if isinstance(n,ast.ListComp)];case['expected_kind']='allocation';case['action']='aggregate'
 elif ordinal==27:targets=[n.args[0] for n in ast.walk(fn) if isinstance(n,ast.Call) and ast.unparse(n.func)=='current.link_next' and ast.unparse(n.args[0])=='node']
 elif ordinal==29:targets=[n.func.value for n in ast.walk(fn) if isinstance(n,ast.Call) and ast.unparse(n.func)=='current.link_next' and ast.unparse(n.args[0])=='node']
 elif ordinal==31:targets=[n.func for n in ast.walk(fn) if isinstance(n,ast.Call) and ast.unparse(n.func)=='strings.append' and ast.unparse(n.args[0])=='s'];case['expected_kind']='attribute';case['required_parent']='closure-cell:strings';case['missing_fact']='nested-scope closure-cell transfer'
 elif ordinal==32:targets=[n.args[0] for n in ast.walk(fn) if isinstance(n,ast.Call) and ast.unparse(n.func)=='strings.append' and ast.unparse(n.args[0])=='s'];case['expected_kind']='argument';case['argument']=0;case['lexical_function']='append';case['missing_fact']='nested-scope formal substitution'
 elif ordinal==33:targets=[n.args[2] for n in ast.walk(fn) if isinstance(n,ast.Call) and ast.unparse(n.func)=='re.sub' and len(n.args)==3 and isinstance(n.args[0],ast.Constant)]
 elif ordinal==36:targets=[n for n in ast.walk(fn) if isinstance(n,ast.Call) and ast.unparse(n.func)=='self.instream.read'];case['expected_kind']='operation'
 else:
  loads=[n for n in targets if isinstance(getattr(n,'ctx',None),ast.Load)]
  if loads:targets=loads
 if ordinal==3:case['missing_fact']='callee selected-return transfer'
 if ordinal==30:case['expected_kind']='allocation';case['action']='aggregate';case['required_members']='all 21 appended str/bytes owners, recursively escaped'
 if ordinal==25:case['required_members']='initial comprehension members borrowed from self.points, before replacement loop'
 assert targets,case['id']
 target=sorted(targets,key=lambda n:(n.lineno,n.col_offset))[0]
 case['expression']=ast.unparse(target)
 case['site']=[target.lineno-fn.lineno+1,target.col_offset-fn.col_offset,target.end_lineno-fn.lineno+1,target.end_col_offset-fn.col_offset,type(target).__name__]
 case['context']=type(target.ctx).__name__ if hasattr(target,'ctx') else None
 case['original_line']=target.lineno
 case['expected_roots']=([['argument',case['argument']]] if case['argument'] is not None else [['global','global','taskWorkArea']] if ordinal==13 else [])
 case['expected_fields']={1:['ident'],2:['link'],4:['input'],5:['input','link'],8:['pending'],9:['pending'],10:['work_in'],11:['work_in','data'],12:['device_in'],13:['taskList'],14:['link'],16:['nodes_by_id','pos'],17:['nodes_by_id','links'],18:['nodes_by_pos'],19:[],21:['x'],22:['splines'],24:['points']}.get(ordinal,[])
 if ordinal==25:case['expected_roots']=[['argument',0]];case['expected_fields']=['points']
 case['expected_scope']='original function code' if not case.get('lexical_function') else 'nested append original code and caller actual substitution'
shim=R.parent/'wave14-capture/capture/inputs/shim/pyperf.py'
shim_text=shim.read_text(encoding='utf-8')
support={'path':str(shim.relative_to(R.parent)),'raw_sha256':hashlib.sha256(shim.read_bytes()).hexdigest(),'text_sha256':hashlib.sha256(shim_text.encode()).hexdigest(),'text':shim_text}
out=R.parent/'provenance-cases/wave17-matrix-should-prove.py'
header='"""S52 positive consumer queries from unchanged original held-out modules.\n\nEach CASES entry names the original function and required consumer query.\nSOURCES retains whole original modules and their source hashes, preserving\nclass scopes, closures, evaluation order, and every unsupported construct.\nThese are desired proofs, not declarations of current support. Source origin\nanswers still require consumer type/layout/effect guards. No timings.\n"""\n'
out.write_text(header+'\nSOURCES = '+pprint.pformat(sources,sort_dicts=False,width=110)+'\n\nCASES = '+pprint.pformat(queries,sort_dicts=False,width=110)+'\n\nSUPPORT = '+pprint.pformat(support,sort_dicts=False,width=110)+'\n\nAUXILIARY = '+pprint.pformat(aux,sort_dicts=False,width=110)+'\n',encoding='utf-8')
print(json.dumps({'queries':len(queries),'functions':len({(x['module'],x['function']) for x in queries}),'source_modules':len(sources),'auxiliary':1,'path':str(out)}))
