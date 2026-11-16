"""Scalar fields and alias-preserving field-passing clones of checked heap IR.

This pass preserves arithmetic, status exits, and all allocations it does not
prove virtual. Every pointer use must belong to a closed checked-IR grammar.
"""
import ast
import copy
from dataclasses import dataclass


class CannotScalar(Exception):pass


def parse_expr(text):return ast.parse(text,mode='eval').body

def unwrap(node):
    while isinstance(node,ast.Call) and isinstance(node.func,ast.Attribute) and ast.unparse(node.func) in ('np.int64','np.uint64') and len(node.args)==1:node=node.args[0]
    return node


def address(node):
    node=unwrap(node);offset=0
    while isinstance(node,ast.BinOp) and isinstance(node.op,ast.Add) and isinstance(node.right,ast.Constant) and type(node.right.value) is int:
        offset+=node.right.value;node=unwrap(node.left)
    return (node.id,offset) if isinstance(node,ast.Name) else (None,None)


@dataclass(eq=False)
class Virtual:
    token: str
    cls: object
    slots: dict


class ScalarReplacer:
    def __init__(self,program,heap,classes=('a',)):
        self.p,self.h,self.classes=program,heap,set(classes)
        self.analysis=program.escape_analysis
        self.infos={i.name:i for i in program.order}
        self.originals={n:ast.parse(f.source).body[0] for n,f in self.analysis.functions.items()}
        self.clones={};self.by_clone={};self.removed=[];self.blocked=[];self.final_locals=None;self.epoch=0;self.proof_reports={}

    def virtual(self,cls,token,prefix):
        if self.p.polymorphic(self.p.family(cls)):raise CannotScalar('polymorphic record layout')
        offsets,size=self.p.layout(cls);slots={};fields=self.p.fields[self.p.family(cls)]
        for attr in self.p.class_fields[cls]:
            kind=fields[attr];offset=offsets[attr]
            if kind==self.h.FLOAT:parts=[('F',offset,self.h.FLOAT)]
            elif kind==self.h.MIXED:parts=[('F',offset,self.h.FLOAT)]+([] if self.p.fast_mixed else [('I',offset+1,self.h.INT)])
            elif kind in (self.h.NPFQ,self.h.NPIQ,self.h.NPBQ) or isinstance(kind,self.h.OptT):raise CannotScalar('optional numeric field representation')
            else:
                if self.h._slots(kind)!=1:raise CannotScalar('multi-slot nonnumeric field')
                parts=[('I',offset,self.h.INT)]
            for space,at,raw in parts:slots[space,at]=(prefix+'_'+space+str(at),raw)
        if not slots:raise CannotScalar('empty record')
        # Sorting makes every clone ABI independent of set/dict construction order.
        return Virtual(token,cls,dict(sorted(slots.items())))

    def run(self):
        originals=list(self.p.order)
        sources={i:i.source for i in originals};calls=self.p.calls
        recursive={i:i.recursive for i in originals}
        try:return self._run()
        except CannotScalar as exc:
            for i in originals:i.source=sources[i];i.recursive=recursive[i]
            self.p.order[:]=originals;self.p.calls=calls
            return {'rule':'R8','removed_sites':[], 'blocked':[{'site':'region','unknown':'F2/F5 '+str(exc)}], 'field_clones':[], 'classes_enabled':sorted(self.classes)}

    def _identity_proof(self):
        """No representable seed means origin transfer cannot create a Virtual.

        Use the same local and fresh-call eligibility as the full pass. Any
        possible seed retains that pass, including its conservative failures.
        """
        blocked=[]
        for name,tree in self.originals.items():
            for token,row in self.analysis.allocations.items():
                if row['function']!=name or row['class'] not in self.classes or row['class'] not in ('a','b'):
                    continue
                try:
                    self.virtual(self.analysis.functions[name].allocations[row['variable']],token,'_sr_'+row['variable'])
                except CannotScalar as exc:
                    blocked.append({'site':token,'unknown':'F2/F5 '+str(exc)})
                else:
                    return None
            if 'c' not in self.classes:
                continue
            for node in ast.walk(tree):
                if isinstance(node,ast.Assign) and len(node.targets)==1 and isinstance(node.targets[0],ast.Name) and isinstance(node.value,ast.Call) and isinstance(node.value.func,ast.Name):
                    cls=self.fresh_class(node.value.func.id)
                    if cls is not None:
                        var=node.targets[0].id
                        try:self.virtual(cls,'@call:'+name+':'+var,'_sr_call_'+var)
                        except CannotScalar:pass
                        else:return None
        return blocked

    def _run(self):
        blocked=self._identity_proof()
        if blocked is not None:
            # Empty local/parameter/fresh sets cannot seed a Virtual. Lower's
            # pointer visitors are therefore identities and no clone is reachable.
            self.p.facts.query('F5',('scalar-identity',tuple(sorted(self.classes)),tuple(self.originals)),
                lambda:self.h._facts.Fact.proven({'virtual_seeds':0,'functions':tuple(self.originals)}))
            all_infos={i.name:i for i in self.p.order}
            self.p.calls={i:{all_infos[n] for n in self.calls(self.originals[i.name]) if n in all_infos} for i in self.p.order}
            self.p.mark_recursive()
            return {'rule':'R8','identity_noop':True,'fresh_sites':[], 'removed_sites':[], 'blocked':blocked,
                    'field_clones':[],'fresh_return_clones':[],'classes_enabled':sorted(self.classes)}
        originals=list(self.p.order);selected={}
        for info in originals:
            candidates=[(token,r) for token,r in self.analysis.allocations.items() if r['function']==info.name and r['class'] in self.classes and r['class'] in ('a','b')]
            accepted={};tree=copy.deepcopy(self.originals[info.name])
            for token,row in candidates:
                try:
                    cls=self.analysis.functions[info.name].allocations[row['variable']]
                    virtual=self.virtual(cls,token,'_sr_'+row['variable'])
                    proposed=dict(accepted);proposed[token]=virtual
                    transformed=self.lower(info.name,tree,proposed,{},None)
                    self.check_clones(transformed)
                except CannotScalar as exc:
                    self.blocked.append({'site':token,'unknown':'F2/F5 '+str(exc)});continue
                self.p.facts.query('F2',('allocation-lifetime',token),lambda row=row:self.h._facts.Fact.proven(row))
                accepted[token]=virtual
                self.removed.append({'site':token,'class':row['class'],'record':row['record']})
            selected[info.name]=accepted
            if accepted or 'c' in self.classes:
                transformed=self.lower(info.name,tree,accepted,{},None)
                info.source=self.analysis.functions[info.name].source.split('def ',1)[0]+ast.unparse(ast.fix_missing_locations(transformed))+'\n'
        # Rebuild once with complete local selections. Otherwise a cloned
        # recursive consumer reintroduces its original local arena allocation
        # and calls back into the handle SCC, enlarging that dispatcher.
        self.final_locals=selected;self.clones={};self.by_clone={};self.epoch=1;self.proof_reports={}
        for info in originals:
            if selected[info.name] or 'c' in self.classes:
                transformed=self.lower(info.name,self.originals[info.name],selected[info.name],{},None)
                self.check_clones(transformed)
                info.source=self.analysis.functions[info.name].source.split('def ',1)[0]+ast.unparse(ast.fix_missing_locations(transformed))+'\n'
        # Only emit clones reachable from accepted original bodies.
        wanted=set();pending=[]
        for info in originals:pending += self.calls(ast.parse(info.source))
        while pending:
            name=pending.pop()
            if name in wanted or name not in self.by_clone:continue
            clone=self.by_clone[name]
            if clone.get('failed'):raise CannotScalar('failed clone became reachable')
            wanted.add(name);pending += self.calls(ast.parse(clone['info'].source))
        for name,clone in self.by_clone.items():
            if name in wanted:self.p.order.append(clone['info'])
        all_infos={i.name:i for i in self.p.order}
        self.p.calls={i:{all_infos[n] for n in self.calls(ast.parse(i.source)) if n in all_infos} for i in self.p.order}
        self.p.mark_recursive()
        contexts={i.name for i in originals}|wanted
        fresh_sites=[row for context,rows in self.proof_reports.items() if context in contexts for row in rows]
        self.blocked += [{'site':r['site'],'unknown':'F5 '+r['unknown']} for r in fresh_sites if r['state']=='blocked']
        return {'rule':'R8','fresh_sites':fresh_sites,'removed_sites':self.removed,'blocked':self.blocked,'field_clones':sorted(wanted),'fresh_return_clones':sorted(n for n in wanted if self.by_clone[n]['fresh_result'] is not None),'classes_enabled':sorted(self.classes)}

    def checked_lower(self,name,tree,locals,params,clone,fresh):
        context=clone['info'].name if clone is not None else name
        key=('scalar-use',self.epoch,context,tuple(sorted(locals)),tuple((i,v.token,v.cls) for i,v in sorted(params.items())),tuple(sorted(fresh)))
        def compute():
            try:
                body=Lower(self,name,copy.deepcopy(tree),locals,params,clone,fresh).lower()
                self.check_clones(body)
                return self.h._facts.Fact.proven(ast.unparse(ast.fix_missing_locations(body)))
            except CannotScalar as exc:return self.h._facts.Fact.unknown(str(exc))
        fact=self.p.facts.query('F5',key,compute)
        if fact.state!='proven':raise CannotScalar(fact.reason)
        body=ast.parse(fact.value).body[0]
        self.check_clones(body)
        return body

    def fresh_class(self,name):
        if name not in self.infos:return None
        old=self.infos[name];summary=self.analysis.summaries[name]
        if not self.analysis.functions[name].object_return or getattr(old.ret,'nullable',False) or summary['return_unknown'] or summary['return_aliases'] or not summary['fresh_returns']:return None
        classes={self.analysis.functions[t.rsplit(':',1)[0]].allocations[t.rsplit(':',1)[1]] for t in summary['fresh_returns']}
        return next(iter(classes)) if len(classes)==1 else None

    def lower(self,name,tree,locals,params,clone):
        locals=dict(locals);fresh={};choices={};reasons={}
        if clone is not None and clone['fresh_result'] is not None:
            for token in self.analysis.summaries[name]['fresh_returns']:
                fn,var=token.rsplit(':',1)
                if fn==name:locals[token]=self.virtual(self.analysis.functions[name].allocations[var],token,'_sr_'+var)
        if 'c' in self.classes:
            for node in ast.walk(tree):
                if isinstance(node,ast.Assign) and len(node.targets)==1 and isinstance(node.targets[0],ast.Name) and isinstance(node.value,ast.Call) and isinstance(node.value.func,ast.Name):
                    cls=self.fresh_class(node.value.func.id)
                    if cls is not None:
                        var=node.targets[0].id
                        try:choices[var]=self.virtual(cls,'@call:'+name+':'+var,'_sr_call_'+var)
                        except CannotScalar:pass
        if clone is not None and clone['fresh_result'] is not None:
            returned={n.value.id for n in ast.walk(tree) if isinstance(n,ast.Return) and isinstance(n.value,ast.Name)}
            changed=True
            while changed:
                changed=False
                for node in ast.walk(tree):
                    if isinstance(node,ast.Assign) and any(isinstance(t,ast.Name) and t.id in returned for t in node.targets) and isinstance(node.value,ast.Name) and node.value.id not in returned:
                        returned.add(node.value.id);changed=True
            fresh={var:v for var,v in choices.items() if var in returned}
        transformed=self.checked_lower(name,tree,locals,params,clone,fresh)
        for var,v in choices.items():
            if var in fresh:continue
            trial=dict(fresh);trial[var]=v
            try:
                candidate=self.checked_lower(name,tree,locals,params,clone,trial)
                self.check_clones(candidate)
            except CannotScalar as exc:reasons[var]=str(exc);continue
            fresh=trial;transformed=candidate
        context=clone['info'].name if clone is not None else name
        self.proof_reports[context]=[{'site':context+':'+var,'fact':'F5','state':'fired' if var in fresh else 'blocked','unknown':reasons.get(var,'')} for var in choices]
        return transformed

    @staticmethod
    def calls(tree):return [x.func.id for x in ast.walk(tree) if isinstance(x,ast.Call) and isinstance(x.func,ast.Name)]

    def check_clones(self,tree):
        pending=self.calls(tree);seen=set()
        while pending:
            name=pending.pop()
            if name in seen or name not in self.by_clone:continue
            seen.add(name);clone=self.by_clone[name]
            if clone.get('failed'):raise CannotScalar('callee clone has unsupported use')
            if not clone.get('building'):pending+=self.calls(ast.parse(clone['info'].source))

    def clone(self,name,actual,fresh=False):
        if name not in self.infos:raise CannotScalar('unknown callee')
        old=self.infos[name];tree=self.originals[name];summary=self.analysis.summaries[name]
        canonical={};shape=[]
        for index,v in sorted(actual.items()):
            group=canonical.setdefault(v.token,len(canonical));shape.append((index,group,v.cls))
            effect=summary['parameters'][index]
            if not effect['object'] or effect['captured'] or effect['identity_observed']:raise CannotScalar('callee captures or observes virtual identity')
        key=name,tuple(shape),fresh
        if key in self.clones:
            clone=self.clones[key]
            if clone.get('failed'):raise CannotScalar('unsupported clone')
            return clone
        clone_name='sr'+str(len(self.clones))+'_'+name
        groups={};params={}
        for index,group,cls in shape:
            if group not in groups:groups[group]=self.virtual(cls,'@group'+str(group),'v_sr'+str(group))
            params[index]=groups[group]
        result_group=None;fresh_result=None
        if fresh:
            cls=self.fresh_class(name)
            if cls is None:raise CannotScalar('not a closed fresh return')
            fresh_result=self.virtual(cls,'@fresh-result','_fresh_result')
        if self.analysis.functions[name].object_return and not fresh:
            virtual_returns=set(params).intersection(summary['return_aliases'])
            if virtual_returns:
                if getattr(old.ret,'nullable',False) or summary['return_unknown'] or summary['fresh_returns']:raise CannotScalar('mixed fresh/virtual alias return')
                returned=[params.get(i) for i in summary['return_aliases']]
                if any(v is None for v in returned) or len({v.token for v in returned})!=1:raise CannotScalar('ambiguous returned virtual alias')
                result_group=returned[0]
            elif summary['return_unknown']:raise CannotScalar('unknown returned object may alias virtual parameter')
            # A disjoint fresh or nonvirtual-parameter return keeps its arena
            # handle ABI; field passing does not scalarize that allocation.
        old_args=[a.arg for a in tree.args.args]
        kinds=['i']*4+self.h._param_kinds(old)
        new_args=old_args[:4];new_kinds=[];seen=set()
        for index,arg in enumerate(old_args[4:],4):
            if index in params:
                v=params[index]
                if v.token in seen:continue
                seen.add(v.token)
                for code,raw in v.slots.values():new_args.append(code);new_kinds.append(raw)
            else:
                new_args.append(arg);new_kinds.append({'i':self.h.INT,'f':self.h.FLOAT,'b':self.h.BOOL}[kinds[index]])
        mutations={v.token:set() for v in groups.values()}
        for index,v in params.items():mutations[v.token].update(summary['parameters'][index]['mutated'])
        updates=[(v,space,at,code,raw) for v in groups.values() for (space,at),(code,raw) in v.slots.items() if f'{space}:{at}' in mutations[v.token]]
        ret_letters=[] if old.ret in (self.h.NONE,self.h.BOTTOM) or result_group is not None else self.h._machine_types(old.ret)
        if fresh_result is not None:ret_letters=['f' if raw==self.h.FLOAT else 'i' for code,raw in fresh_result.slots.values()]
        ret_kinds=[{'i':self.h.INT,'f':self.h.FLOAT,'b':self.h.BOOL}[letter] for letter in ret_letters]+[raw for v,space,at,code,raw in updates]
        info=copy.copy(old);info.scalar_origin=name;info.scalar_fresh=fresh;info.name=clone_name;info.params=[n[2:] if n.startswith('v_') else n for n in new_args[4:]]
        info.vars=dict(zip(info.params,new_kinds));info.ret=self.h.NONE if not ret_kinds else ret_kinds[0] if len(ret_kinds)==1 else self.h.TupT(ret_kinds)
        info.locals=set(info.params);info.flagged=set();info.unbound={};info.object_allocations={};info.source=''
        clone={'info':info,'groups':groups,'params':params,'updates':updates,'return_width':len(ret_letters),'return_group':result_group,'fresh_result':fresh_result,'building':True}
        self.clones[key]=clone;self.by_clone[clone_name]=clone
        try:
            accepted={};body=self.lower(name,tree,{},params,clone)
            if self.final_locals is not None:
                for token,v in self.final_locals.get(name,{}).items():
                    trial=dict(accepted);trial[token]=v
                    try:
                        candidate=self.lower(name,tree,trial,params,clone)
                        self.check_clones(candidate)
                    except CannotScalar:continue
                    accepted=trial;body=candidate
            body=self.lower(name,tree,accepted,params,clone)
            clone['local_sites']=sorted(accepted)
            body.name=clone_name;body.args.args=[ast.arg(arg=a) for a in new_args]
            info.source=self.analysis.functions[name].source.split('def ',1)[0]+ast.unparse(ast.fix_missing_locations(body))+'\n'
            clone['building']=False
        except CannotScalar:
            clone['failed']=True;clone['building']=False;raise
        return clone


class Lower(ast.NodeTransformer):
    def __init__(self,engine,name,tree,locals,params,clone,fresh=None):
        self.e,self.name,self.tree,self.locals,self.params,self.clone=engine,name,tree,locals,params,clone
        self.aliases={};self.writes=set();self.fresh=fresh or {}
        # Recompute local reaching aliases with distinct per-call identities.
        # A global fresh-allocation token cannot distinguish repeated calls.
        env={a.arg:({'?'} if a.arg in engine.analysis.functions[name].object_params else set()) for a in tree.args.args}
        for index,v in params.items():env[tree.args.args[index].arg]={v}
        allocated=engine.analysis.functions[name].allocations
        for var in allocated:env[var]={locals[name+':'+var]} if name+':'+var in locals else {'?'}
        for var,v in self.fresh.items():env[var]={v}
        def origin(node):
            node=unwrap(node)
            if isinstance(node,ast.Name):return env.get(node.id,set())
            if isinstance(node,ast.Subscript):return {'?'}
            if isinstance(node,ast.IfExp):return origin(node.body)|origin(node.orelse)
            if isinstance(node,ast.BinOp):return origin(node.left)|origin(node.right)
            if isinstance(node,ast.UnaryOp):return origin(node.operand)
            if isinstance(node,(ast.Tuple,ast.List)):return set().union(*(origin(x) for x in node.elts)) if node.elts else set()
            if isinstance(node,ast.Call) and isinstance(node.func,ast.Name) and node.func.id in engine.analysis.functions:
                if not engine.analysis.functions[node.func.id].object_return:return set()
                summary=engine.analysis.summaries[node.func.id];values={'?'} if summary['fresh_returns'] or summary['return_unknown'] else set()
                for i in summary['return_aliases']:
                    if i<len(node.args):values |= origin(node.args[i])
                return values
            return set()
        for _ in range(len(list(ast.walk(tree)))+1):
            changed=False
            for node in ast.walk(tree):
                if not isinstance(node,ast.Assign):continue
                for target in node.targets:
                    if not isinstance(target,ast.Name):continue
                    var=target.id
                    if var in self.fresh and isinstance(node.value,ast.Call):continue
                    if var in allocated and isinstance(node.value,ast.Call) and getattr(node.value.func,'id',None)=='alloc':continue
                    old=env.setdefault(var,set());values=old|origin(node.value)
                    if values!=old:env[var]=values;changed=True
            if not changed:break
        for variable,tokens in env.items():
            virtuals=[v for v in tokens if isinstance(v,Virtual)]
            if not virtuals:continue
            if len(tokens)!=1:raise CannotScalar('pointer merge mixes virtual identities')
            self.aliases[variable]=virtuals[0]
        self.validate_dominance()

    def validate_dominance(self):
        positions={};definitions={};uses={}
        def walk(node,path):
            positions[id(node)]=path
            if isinstance(node,ast.Name):
                (definitions if isinstance(node.ctx,ast.Store) else uses).setdefault(node.id,[]).append(node)
            for field,value in ast.iter_fields(node):
                if isinstance(value,list):
                    block=(id(node),field)
                    for index,item in enumerate(value):
                        if isinstance(item,ast.AST):walk(item,path+[(block,index)])
                elif isinstance(value,ast.AST):walk(value,path)
        walk(self.tree,[])
        args={a.arg for a in self.tree.args.args}
        for variable,v in self.aliases.items():
            defs=definitions.get(variable,[])
            if variable in args:
                if defs:raise CannotScalar('virtual parameter rebound')
                continue
            if len(defs)!=1:raise CannotScalar('alias has multiple reaching definitions')
            path=positions[id(defs[0])]
            # Find the defining statement's block, not its target list slot.
            statement=defs[0]
            parent={id(c):p for p in ast.walk(self.tree) for c in ast.iter_child_nodes(p)}
            while not isinstance(statement,ast.stmt):statement=parent[id(statement)]
            defining=positions[id(statement)]
            if not defining:raise CannotScalar('missing definition block')
            prefix,entry=defining[:-1],defining[-1]
            for use in uses.get(variable,[]):
                where=positions[id(use)]
                if where[:len(prefix)]!=prefix or len(where)<=len(prefix) or where[len(prefix)][0]!=entry[0] or where[len(prefix)][1]<=entry[1]:raise CannotScalar('alias may outlive dynamic allocation or precede definition')

    def lower(self):
        self.tree.decorator_list=[]
        self.tree=self.visit(self.tree)
        if self.clone is not None:
            parameter_tokens={v.token for v in self.params.values()}
            parameter_slots={code:(v.token,space,at) for v in self.params.values() for (space,at),(code,raw) in v.slots.items()}
            self.writes.update(parameter_slots[n.id] for n in ast.walk(self.tree) if isinstance(n,ast.Name) and isinstance(n.ctx,ast.Store) and n.id in parameter_slots)
            updates={(v.token,space,at) for v,space,at,code,raw in self.clone['updates']}
            if any(token in parameter_tokens and (token,space,at) not in updates for token,space,at in self.writes):raise CannotScalar('mutation summary omits a rewritten field store')
        return self.tree

    def visit_Name(self,node):
        if node.id in self.aliases:raise CannotScalar('unrecognized pointer use '+node.id)
        return node

    def visit_Subscript(self,node):
        base,offset=address(node.slice)
        if base in self.aliases:
            v=self.aliases[base];space=getattr(node.value,'id',None)
            if (space,offset) not in v.slots:raise CannotScalar('unknown overlapping field/address')
            if isinstance(node.ctx,ast.Store):self.writes.add((v.token,space,offset))
            return ast.copy_location(ast.Name(id=v.slots[space,offset][0],ctx=node.ctx),node)
        return self.generic_visit(node)

    def visit_Compare(self,node):
        left=unwrap(node.left)
        if isinstance(left,ast.Name) and left.id in self.aliases and len(node.ops)==1 and isinstance(node.comparators[0],ast.Constant) and node.comparators[0].value==0:
            if isinstance(node.ops[0],ast.Lt):return ast.Constant(False)
            if isinstance(node.ops[0],ast.GtE):return ast.Constant(True)
        return self.generic_visit(node)

    def call(self,node,target):
        actual={}
        for index,arg in enumerate(node.args):
            value=unwrap(arg)
            if isinstance(value,ast.Name) and value.id in self.aliases:actual[index]=self.aliases[value.id]
        fresh_result=self.fresh.get(target.id) if isinstance(target,ast.Name) else None
        if not actual and fresh_result is None:return None
        if not isinstance(node.func,ast.Name):raise CannotScalar('unknown object callee')
        clone=self.e.clone(node.func.id,actual,fresh=fresh_result is not None)
        args=[];seen=set()
        for index,arg in enumerate(node.args):
            if index in actual:
                v=actual[index]
                if v.token in seen:continue
                seen.add(v.token);args.extend(ast.Name(id=code,ctx=ast.Load()) for code,raw in v.slots.values())
            else:args.append(self.visit(arg))
        original=[]
        if fresh_result is not None:
            original=[ast.Name(id=code,ctx=ast.Store()) for code,raw in fresh_result.slots.values()]
        elif clone['return_width']:
            if target is None:
                original=[ast.Name(id='_sr_discard_'+clone['info'].name+'_'+str(node.lineno)+'_'+str(i),ctx=ast.Store()) for i in range(clone['return_width'])]
            else:
                original=target.elts if isinstance(target,ast.Tuple) else [target]
                if len(original)!=clone['return_width']:raise CannotScalar('clone return ABI mismatch')
                original=[self.visit(x) for x in original]
        elif target is not None:
            if clone['return_group'] is None:raise CannotScalar('unexpected clone return assignment')
            if not isinstance(target,ast.Name) or target.id not in self.aliases:raise CannotScalar('returned alias is not tracked')
            expected=actual[next(index for index,v in clone['params'].items() if v is clone['return_group'])]
            if self.aliases[target.id] is not expected:raise CannotScalar('returned alias identity mismatch')
        updates=[]
        mapped={}
        for index,formal in clone['params'].items():mapped[formal.token]=actual[index]
        for formal,space,at,code,raw in clone['updates']:
            updates.append(ast.Name(id=mapped[formal.token].slots[space,at][0],ctx=ast.Store()))
        targets=original+updates
        value=ast.Call(func=ast.Name(id=clone['info'].name,ctx=ast.Load()),args=args,keywords=[])
        return ast.Assign(targets=[targets[0] if len(targets)==1 else ast.Tuple(elts=targets,ctx=ast.Store())],value=value) if targets else ast.Expr(value=value)

    def visit_Assign(self,node):
        if len(node.targets)==1 and isinstance(node.targets[0],ast.Name):
            target=node.targets[0].id
            if target in self.aliases:
                value=unwrap(node.value);v=self.aliases[target]
                if target in self.e.analysis.functions[self.name].allocations and v.token in self.locals:
                    if not(isinstance(node.value,ast.Call) and getattr(node.value.func,'id',None)=='alloc'):raise CannotScalar('allocation metadata mismatch')
                    return [ast.Assign(targets=[ast.Name(id=code,ctx=ast.Store())],value=parse_expr('0.0' if raw==self.e.h.FLOAT else 'np.int64(0)')) for code,raw in v.slots.values()]
                if isinstance(value,ast.Name) and value.id in self.aliases and self.aliases[value.id] is v:return ast.Pass()
                if isinstance(node.value,ast.Call):
                    transformed=self.call(node.value,node.targets[0])
                    if transformed is not None:return transformed
                raise CannotScalar('non-alias definition of virtual pointer')
        if isinstance(node.value,ast.Call):
            transformed=self.call(node.value,node.targets[0] if len(node.targets)==1 else None)
            if transformed is not None:return transformed
        return self.generic_visit(node)

    def visit_Expr(self,node):
        if isinstance(node.value,ast.Call):
            transformed=self.call(node.value,None)
            if transformed is not None:return transformed
        return self.generic_visit(node)

    def visit_Call(self,node):
        if any(isinstance(unwrap(a),ast.Name) and unwrap(a).id in self.aliases for a in node.args):raise CannotScalar('nested virtual call outside checked call grammar')
        return self.generic_visit(node)

    def visit_Return(self,node):
        if self.clone is None:return self.generic_visit(node)
        values=[]
        if self.clone['fresh_result'] is not None:
            expected=self.clone['fresh_result']
            if isinstance(node.value,ast.Name) and node.value.id in self.aliases:
                v=self.aliases[node.value.id]
                if v.cls is not expected.cls:raise CannotScalar('fresh return field layout differs')
                values=[ast.Name(id=code,ctx=ast.Load()) for code,raw in v.slots.values()]
            elif ast.unparse(node.value)=='-1':values=[parse_expr('0.0' if raw==self.e.h.FLOAT else 'np.int64(0)') for code,raw in expected.slots.values()]
            else:raise CannotScalar('fresh return is not a single tracked identity')
        elif self.clone['return_width']:
            if node.value is None:raise CannotScalar('missing clone return')
            values=node.value.elts if isinstance(node.value,ast.Tuple) else [node.value]
            if len(values)!=self.clone['return_width']:raise CannotScalar('return width differs on a branch')
            values=[self.visit(x) for x in values]
        for v,space,at,code,raw in self.clone['updates']:values.append(ast.Name(id=code,ctx=ast.Load()))
        return ast.Return(value=values[0] if len(values)==1 else ast.Tuple(elts=values,ctx=ast.Load()) if values else None)
