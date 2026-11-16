"""S51 bounded partial diagnostic only. Never imported by the product.

Reuses typed recognisers; refuses arbitrary seed/global inspection, suppresses
source publication and all compilation. BOTTOM is only an adapter: independent
sticky unknowns and structural labels bar completion credit after any refusal.
"""
from pathlib import Path
import ast,copy,inspect,math,re,sys,textwrap,traceback,types
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'src'))
from recompyler import heap as h


def inert(value,depth=0,seen=None,budget=None):
 if depth>12:return False
 seen=set() if seen is None else seen;budget=[5000] if budget is None else budget
 budget[0]-=1
 if budget[0]<0:return False
 t=type(value)
 if any(t is k for k in (int,float,bool,complex,str,bytes,range,type(None))):return True
 if not any(t is k for k in (list,tuple,dict,set)):return False
 if id(value) in seen:return False
 seen.add(id(value))
 try:
  items=(*value.keys(),*value.values()) if t is dict else value
  return all(inert(v,depth+1,seen,budget) for v in items)
 finally:seen.remove(id(value))


def safe_target(value):
 t=type(value)
 if t is type:return True
 if t is not types.FunctionType and t is not types.BuiltinFunctionType:return False
 if type(value.__module__) is not str and value.__module__ is not None:return False
 if t is types.FunctionType:
  original=value.__dict__.get('__recompyler_original__')
  if original is not None and type(original) is not types.FunctionType:return False
 return True


def family(reason):
 if reason.startswith('diagnostic '):return 'analysis unknown'
 if 'C or library function' in reason or (reason.startswith('a call of ') and 'relies on a default' not in reason):return 'C/library calls (scalar/effect eligibility unknown)'
 if 'kwargs' in reason:return 'kwargs binding'
 if 'does more than set attributes' in reason:return 'constructor helper calls (Random/init acceptance)'
 if 'before setting all' in reason or '__init__ does not set' in reason:return 'object entry/constructor acceptance'
 if 'not a numeric constant' in reason or 'used as a value' in reason:return 'function/class/global values (identity guards)'
 if 'declares globals or defines functions' in reason:return 'local definitions/global declarations'
 reason=re.sub(r' at line \d+',' at line N',reason)
 return re.sub(r"'[^']+'", "'<name>'",reason.removeprefix('as a region: '))


def metadata(program,fn,owner,node=None,start=None,scope=None):
 if node is None:
  text,start=inspect.getsourcelines(fn.__code__);node=ast.parse(textwrap.dedent(''.join(text))).body[0]
 code=fn.__code__;info=object.__new__(h._Function)
 info.fn,info.owner,info.node=fn,owner,node
 info.params=[a.arg for a in [*node.args.posonlyargs,*node.args.args,*node.args.kwonlyargs]]
 if node.args.vararg:info.params.append(node.args.vararg.arg)
 if node.args.kwarg:info.params.append(node.args.kwarg.arg)
 info.locals=h._local_names(node)|set(info.params)
 info.coroutine=isinstance(node,ast.AsyncFunctionDef);info.generator=bool(code.co_flags&h._GENERATOR_FLAGS);info.sink=False
 info.unbound=set();info.flagged=set();info.falls_through=not h._terminates(node.body)
 info.vars={};info.ret=h.BOTTOM;info.constant=None;info.name='diag_'+str(len(program.functions))+'_'+node.name
 info.recursive=False;info.source='';info.start=start;info.scope=scope or fn.__qualname__;info.decl_unknown=True
 return info


class DiagnosticProgram(h._Program):
 def __init__(self,fn):
  self.declarations=[];self.pass_events=[];self.raw_passes=[];self.final_states=[];self.tainted=set();self.pass_index=0;self.observed_fields={}
  super().__init__(fn)
 def compile(self,*a,**k):raise AssertionError('diagnostic cannot compile')
 def function(self,fn,owner=None,key=None,sink=False):
  if type(fn) is not types.FunctionType:raise h.Unsupported('diagnostic non-function target omitted')
  slot=(fn,key,'sink') if sink else (fn,key)
  if slot in self.functions:return self.functions[slot]
  try:
   info=h._Function(self,fn,owner);info.start=inspect.getsourcelines(fn.__code__)[1];info.scope=fn.__qualname__;info.decl_unknown=False
  except h.Unsupported as exc:
   info=metadata(self,fn,owner)
   self.declarations.append(self.event(info,info.node,str(exc),'declaration',False,False))
  self.functions[slot]=info
  if sink:info.make_sink()
  return info
 def event(self,info,node,reason,category='unsupported',after=False,structural=False):
  line=getattr(node,'lineno',1)
  return dict(scope=info.scope,source=info.fn.__code__.co_filename,relative_line=line,
   absolute_line=info.start+line-1,reason=reason,family=family(reason),category=category,
   after_unknown=bool(after),structural=bool(structural),pass_index=self.pass_index)
 def register(self,cls):
  if cls in self.class_fields:return self.fields[self.family(cls)]
  raise h.Unsupported('diagnostic class field view unavailable; constructor body remains unknown')
 def global_value(self,namespace,name,value,key=None):
  if not inert(value):raise h.Unsupported('diagnostic unsafe global value omitted: '+name)
  return super().global_value(namespace,name,value,key)
 def settle(self,limit=10):
  settled=False
  for turn in range(limit):
   self.pass_index=turn;self.changed=False;self.order=[self.entry];self.calls={};self.specialized={};self.pass_events=[];states=[]
   position=0
   while position<len(self.order) and position<100:
    info=self.order[position];gen=DiagnosticGen(self,info)
    try:gen.run()
    except BaseException as exc:
     if isinstance(exc,(KeyboardInterrupt,SystemExit)):raise
     self.pass_events.append(self.event(info,info.node,'diagnostic analysis_error '+type(exc).__name__+': '+str(exc),'analysis_error',True,gen.structural))
     gen.unknown=True
    states.append({'scope':info.scope,'depth':gen.depth,'loop_depth':gen.loop_depth,'finals':list(gen.finals)})
    if gen.unknown:self.tainted.add(info.fn)
    position+=1
   if position>=100:
    self.pass_events.append(self.event(self.entry,self.entry.node,'diagnostic function cap reached','analysis_gap',True,True))
   self.raw_passes.append(list(self.pass_events));self.final_states=states
   if not self.changed and position==len(self.order):settled=True;break
  return settled


class DiagnosticGen(h._Gen):
 CONTROLS=('depth','counter','line','loop_depth','loop_flags','finals','inlining','zero_codes','zero_locals','object_allocations','numeric_tags','numeric_tag_expressions','math_used','me','awaited')
 def __init__(self,program,info):
  super().__init__(program,info);self.seen=set();self.unknown=bool(info.decl_unknown or getattr(info,'seed_unknown',False));self.structural=False
 def emit(self,line):pass
 def where(self):return 0
 def generate(self):
  self.body(self.info.node.body)
  self.info.math_used=set();self.info.object_allocations={};self.info.numeric_tags=frozenset();self.info.numeric_param_tags=()
  return ''
 def snapshot(self):
  return {k:copy.copy(getattr(self,k)) for k in self.CONTROLS if hasattr(self,k)}
 def restore(self,snapshot):
  for k in self.CONTROLS:
   if k in snapshot:setattr(self,k,snapshot[k])
   elif hasattr(self,k):delattr(self,k)
 def record(self,node,exc,category='unsupported'):
  event=self.program.event(self.info,node,str(exc),category,self.unknown,self.structural)
  if isinstance(node,ast.Name) and 'used as a value' in str(exc) and node.id in self.namespace:
   kind=type(self.namespace[node.id])
   kinds=((types.FunctionType,'identity-guarded function values'),(type,'class values'),(bytes,'bytes globals'),(str,'str globals'),(list,'aggregate/global values'),(dict,'aggregate/global values'),(tuple,'aggregate/global values'))
   event['family']=next((label for exact,label in kinds if kind is exact),event['family'])
  if isinstance(node,ast.Constant) and type(node.value) is bytes:event['family']='bytes literals'
  if self.inlining and self.inlining[-1] is not self.info.fn:
   fn=self.inlining[-1];event['location_kind']='inlined callsite';event['inlined_callee_source']=fn.__code__.co_filename;event['inlined_callee_firstline']=fn.__code__.co_firstlineno
  else:event['location_kind']='original source'
  if category=='analysis_error':event['traceback']=traceback.format_exc()
  self.program.pass_events.append(event);self.unknown=True
 def expr_Name(self,node):
  if node.id not in self.info.locals and node.id in self.namespace:
   value=self.namespace[node.id];t=type(value)
   if not inert(value) and not any(t is k for k in (types.FunctionType,types.BuiltinFunctionType,types.ModuleType,type)):
    self.unsupported('diagnostic unsafe global value omitted: '+node.id,node)
  return super().expr_Name(node)
 def key_tag(self,kind,node):
  tag=h._key_tag(kind)
  if tag is None:self.unsupported('dict or set keys that are '+h._describe(kind),node)
  return tag
 def do_If(self,node):
  # No generated-test evaluator: both conditional bodies are structural evidence.
  self.expr(node.test)
  old=self.structural;self.structural=True
  try:self.body(node.body);self.body(node.orelse)
  finally:self.structural=old
 def call_expr(self,node):
  func=node.func
  if isinstance(func,ast.Name) and func.id not in self.info.locals:
   target=self.namespace.get(func.id)
   if func.id in self.cells():
    try:target=self.cells()[func.id].cell_contents
    except ValueError:self.unsupported('diagnostic empty callable closure cell',node)
   if (func.id in self.namespace or func.id in self.cells()) and not safe_target(target):
    self.unsupported('diagnostic unsafe callable metadata omitted: '+func.id,node)
  if isinstance(func,ast.Attribute):
   owner=self.class_named(func.value)
   if owner is not None:
    found=next((vars(k)[func.attr] for k in owner.__mro__ if func.attr in vars(k)),None)
    if not safe_target(found):self.unsupported('diagnostic unsafe class callable metadata omitted',node)
  return super().call_expr(node)
 def module_value(self,module,value,node):
  if not inert(value) and not safe_target(value) and type(value) is not types.ModuleType:
   self.unsupported('diagnostic unsafe module payload omitted',node)
  return super().module_value(module,value,node)
 def class_attribute(self,owner,attr,node):
  value=next((vars(k)[attr] for k in owner.__mro__ if attr in vars(k)),None)
  if not inert(value) and not safe_target(value) and type(value) is not types.ModuleType:
   self.unsupported('diagnostic unsafe class payload omitted',node)
  return super().class_attribute(owner,attr,node)
 def construct(self,cls,node):
  if type(cls) is not type:self.unsupported('diagnostic unsafe constructor class omitted',node)
  init=next((vars(k)['__init__'] for k in cls.__mro__ if '__init__' in vars(k)),None)
  if init is not object.__init__ and not (type(init) is types.FunctionType and safe_target(init)):
   self.unsupported('diagnostic unsafe constructor descriptor omitted',node)
  return super().construct(cls,node)
 def generator_source(self,iterable,is_async=False):
  if isinstance(iterable,ast.Call) and isinstance(iterable.func,ast.Name) and iterable.func.id in self.namespace:
   if not safe_target(self.namespace[iterable.func.id]):self.unsupported('diagnostic unsafe generator callable metadata omitted',iterable)
  return super().generator_source(iterable,is_async)
 def method_call(self,kind,receiver,name,args,node,keywords=(),after=None):
  for cls in kind.classes:
   found=next((vars(k)[name] for k in cls.__mro__ if name in vars(k)),None)
   if type(found) is not types.FunctionType or not safe_target(found):
    self.unsupported('diagnostic unsafe method descriptor omitted: '+name,node)
  return super().method_call(kind,receiver,name,args,node,keywords,after)
 def resolve_method(self,kind,name):
  if isinstance(kind,h.ObjT):
   for cls in kind.classes:
    found=next((vars(k)[name] for k in cls.__mro__ if name in vars(k)),None)
    if type(found) is not types.FunctionType or not safe_target(found):return None
  return super().resolve_method(kind,name)
 def class_named(self,node):
  if isinstance(node,ast.Name) and node.id not in self.info.locals:
   value=self.namespace.get(node.id)
   if type(value) is type:return value
  return None
 def module_member(self,node):
  if not isinstance(node,ast.Attribute):return None
  base=node.value
  if isinstance(base,ast.Name):
   if base.id in self.info.locals:return None
   module=self.namespace.get(base.id)
  else:
   outer=self.module_member(base)
   if outer is None:return None
   module=outer[1]
  if type(module) is not types.ModuleType:return None
  space=types.ModuleType.__getattribute__(module,'__dict__')
  if node.attr not in space:self.unsupported('diagnostic absent module member: '+node.attr,node)
  return module,space[node.attr]
 def call_value(self,target,label,node):
  if not safe_target(target):
   self.unsupported('diagnostic unsafe callable metadata omitted: '+label,node)
  if type(target) is type:return self.construct(target,node)
  return super().call_value(target,label,node)
 def cell_name(self,node):
  names=self.info.fn.__code__.co_freevars
  if node.id in names:
   cell=self.info.fn.__closure__[names.index(node.id)]
   try:value=cell.cell_contents
   except ValueError:self.unsupported('diagnostic empty closure cell',node)
   if not inert(value):self.unsupported('diagnostic non-inert closure cell omitted: '+node.id,node)
  return super().cell_name(node)
 def call(self,callee,args,node,keywords=()):
  result=super().call(callee,args,node,keywords)
  if callee.fn in self.program.tainted:self.unknown=True
  return result
 def expr(self,node):
  self.seen.add(id(node));saved=self.snapshot();failed=False
  try:
   method=getattr(self,'expr_'+type(node).__name__,None)
   if method is None:self.unsupported(type(node).__name__,node)
   result=method(node)
  except h._Pending:
   self.program.changed=True;result=(h.BOTTOM,['0']);failed=True;self.restore(saved)
  except h.Unsupported as exc:
   self.record(node,exc);result=(h.BOTTOM,['0']);failed=True;self.restore(saved)
  except Exception as exc:
   self.record(node,'diagnostic analysis_error '+type(exc).__name__+': '+str(exc),'analysis_error')
   result=(h.BOTTOM,['0']);failed=True;self.restore(saved)
  if failed or self.unknown:
   self.scan_children(node,skip_func=not failed or isinstance(node,ast.Call))
  return result
 def body(self,statements):
  for statement in statements:
   self.seen.add(id(statement));saved=self.snapshot();self.line=statement.lineno;failed=False
   try:
    method=getattr(self,'do_'+type(statement).__name__,None)
    if method is None:self.unsupported(type(statement).__name__,statement)
    method(statement)
   except h._Pending:
    self.program.changed=True;failed=True;self.restore(saved)
   except h.Unsupported as exc:
    self.record(statement,exc);failed=True;self.restore(saved)
   except Exception as exc:
    self.record(statement,'diagnostic analysis_error '+type(exc).__name__+': '+str(exc),'analysis_error');failed=True;self.restore(saved)
   if failed or self.unknown:
    if isinstance(statement,(ast.FunctionDef,ast.AsyncFunctionDef,ast.ClassDef)):
     self.seen.discard(id(statement));self.structural_node(statement)
    else:self.scan_children(statement)
 def scan_children(self,node,skip_func=False):
  old=self.structural;self.structural=True
  try:
   for child in ast.iter_child_nodes(node):
    if skip_func and isinstance(node,ast.Call) and child is node.func:continue
    self.structural_node(child)
  finally:self.structural=old
 def structural_node(self,node):
  if id(node) in self.seen:return
  if isinstance(node,(ast.FunctionDef,ast.AsyncFunctionDef)):
   self.seen.add(id(node))
   declarations=[*node.decorator_list,*node.args.defaults,*[x for x in node.args.kw_defaults if x is not None]]
   declarations += [a.annotation for a in [*node.args.posonlyargs,*node.args.args,*node.args.kwonlyargs] if a.annotation is not None]
   if node.args.vararg and node.args.vararg.annotation:declarations.append(node.args.vararg.annotation)
   if node.args.kwarg and node.args.kwarg.annotation:declarations.append(node.args.kwarg.annotation)
   if node.returns is not None:declarations.append(node.returns)
   for expression in declarations:self.expr(expression)
   scope=self.info.scope+('.' if getattr(self,'class_scope',False) else '.<locals>.')+node.name
   nested=metadata(self.program,self.info.fn,None,node,self.info.start,scope)
   gen=DiagnosticGen(self.program,nested);gen.structural=True;gen.unknown=True;gen.body(node.body)
  elif isinstance(node,ast.ClassDef):
   self.seen.add(id(node))
   for expression in [*node.decorator_list,*node.bases,*[k.value for k in node.keywords]]:self.expr(expression)
   saved_scope=self.info.scope;saved_class=getattr(self,'class_scope',False)
   self.info.scope=saved_scope+'.<locals>.'+node.name;self.class_scope=True
   try:
    for child in node.body:self.structural_node(child)
   finally:self.info.scope=saved_scope;self.class_scope=saved_class
  elif isinstance(node,ast.expr):
   if isinstance(getattr(node,'ctx',None),(ast.Store,ast.Del)):
    self.seen.add(id(node));self.scan_children(node)
   else:self.expr(node)
  elif isinstance(node,ast.stmt):self.body([node])
  else:
   self.seen.add(id(node));self.scan_children(node)


def observed_seed(program,value,seen):
 """Only called after profiler's positive whole-graph inert validation.

 No loader/layout/owner certificate is created. Every observed-record root is
 explicitly tainted and cannot earn completion credit.
 """
 t=type(value)
 if id(value) in seen:return seen[id(value)]
 if t is list:
  made=seen[id(value)]=h.ListT()
  for item in value:program.widen_cell(made.cell,observed_seed(program,item,seen))
  return made
 if t is tuple:return h.TupT(observed_seed(program,item,seen) for item in value)
 if t is dict:
  made=seen[id(value)]=h.DictT()
  for key,item in value.items():
   program.widen_cell(made.kcell,observed_seed(program,key,seen));program.widen_cell(made.vcell,observed_seed(program,item,seen))
  return made
 if t is set:
  made=seen[id(value)]=h.SetT()
  for item in value:program.widen_cell(made.cell,observed_seed(program,item,seen))
  return made
 if inert(value):return h._seed(program,value,seen,allow_range=True)
 from recompyler import profiler
 fields=profiler._object_fields(value,4096)
 root=program.family(t)
 program.class_fields[t]=program.class_fields.get(t,frozenset())|frozenset(fields)
 shared=program.fields.setdefault(root,{})
 for name in fields:shared.setdefault(name,h.BOTTOM)
 if t not in program.members.setdefault(root,[]):program.members[root].append(t)
 made=seen[id(value)]=h.ObjT(t)
 for name,item in fields.items():program.widen(shared,name,observed_seed(program,item,seen))
 program.observed_fields[t.__qualname__]={name:h._describe(kind) for name,kind in shared.items()}
 return made


def call_chains(program,events):
 graph={}
 for caller,callees in program.calls.items():graph.setdefault(caller.scope,set()).update(c.scope for c in callees)
 root=program.entry.scope;paths={root:[root]};queue=[root]
 for current in queue:
  for target in sorted(graph.get(current,())):
   if target not in paths:paths[target]=[*paths[current],target];queue.append(target)
 for event in events:
  scope=event['scope'];event['call_chain']=paths.get(scope,[root,scope] if scope!=root else [root])


def diagnose(fn,args,pass_limit=10):
 try:program=DiagnosticProgram(fn)
 except Exception as exc:
  return dict(events=[dict(scope=fn.__qualname__,source=fn.__code__.co_filename,absolute_line=fn.__code__.co_firstlineno,relative_line=1,
    reason='diagnostic source/declaration unavailable: '+type(exc).__name__,family='analysis unknown',category='analysis_gap',after_unknown=True,structural=True,pass_index=0)],
    settled=False,unknown_remainder=True,forecast_eligible=False,generated_source_bytes=0,final_states=[],raw_passes=[])
 seeds=[]
 for name,value in zip(program.entry.params,args):
  try:
   if inert(value):kind=h._seed(program,value,{},allow_range=True)
   else:
    from recompyler import profiler
    try:profiler._snapshot_graph(value,4096)
    except (ValueError,TypeError):raise h.Unsupported('diagnostic unsafe argument omitted before seeding') from None
    kind=observed_seed(program,value,{})
    program.entry.seed_unknown=True
    seeds.append(program.event(program.entry,program.entry.node,'diagnostic observed field view; constructor/ownership permission unknown','analysis_gap',True,False))
   program.widen(program.entry.vars,name,kind)
  except h.Unsupported as exc:
   program.entry.seed_unknown=True
   seeds.append(program.event(program.entry,program.entry.node,str(exc),'seed',False,False))
 settled=program.settle(pass_limit)
 events=[*program.declarations,*seeds,*program.pass_events]
 if not settled:events.append(program.event(program.entry,program.entry.node,'diagnostic not settled within pass cap','analysis_gap',True,True))
 unique={}
 for e in events:
  key=(e['source'],e['scope'],e['absolute_line'],e['reason'],e['category'],e['structural'])
  unique.setdefault(key,e)
 call_chains(program,list(unique.values()))
 unknown=bool(unique) or not settled
 assert all(not info.source for info in program.functions.values())
 return dict(events=list(unique.values()),settled=settled,unknown_remainder=unknown,forecast_eligible=not unknown,
  generated_source_bytes=sum(len(info.source) for info in program.functions.values()),helper_source_bytes=sum(len(v) for v in program.__dict__.get('helpers',{}).values()),final_states=program.final_states,raw_passes=program.raw_passes,observed_fields=program.observed_fields)


def choose(rows,baseline=60,limit=10,weighted=False):
 keys=[tuple(r['key']) if type(r['key']) is list else r['key'] for r in rows]
 if len(keys)!=len(set(keys)):raise ValueError('duplicate root key')
 eligible=[r for r in rows if r.get('forecast_eligible') and not r.get('already_native') and r.get('families')]
 selected=set();completed=set();result=[]
 for _ in range(limit):
  candidates=sorted({f for r in eligible for f in r['families']}-selected)
  if not candidates:break
  options=[]
  for candidate in candidates:
   done={i for i,r in enumerate(eligible) if set(r['families'])<=selected|{candidate}}
   new=done-completed;known=[eligible[i].get('inclusive_s') for i in new]
   seconds=sum(v for v in known if type(v) in (int,float) and math.isfinite(v) and v>=0)
   missing=sum(not(type(v) in (int,float) and math.isfinite(v) and v>=0) for v in known)
   incidence=sum(candidate in r['families'] for i,r in enumerate(eligible) if i not in completed)
   score=(seconds,len(new),incidence) if weighted else (len(new),seconds,incidence)
   options.append((score,candidate,done,missing,seconds))
  score,candidate,done,missing,seconds=sorted(options,key=lambda o:tuple(-v for v in o[0])+(o[1],))[0]
  selected.add(candidate)
  result.append(dict(family=candidate,marginal=len(done-completed),cumulative_native=baseline+len(done),weighted_s=seconds,missing_weight_functions=missing,selected=sorted(selected)))
  completed=done
 return result
