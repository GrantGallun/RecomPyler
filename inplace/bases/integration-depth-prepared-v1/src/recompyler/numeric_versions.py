"""Guarded fixed numeric versions over immutable typed inputs.

Guards use real logical tags and exact scalar conversion bounds. Unknown origins, mutable fields, nullable or
polymorphic-missing fields and rebound tag parameters retain checked bodies.
"""
import ast
import copy
from collections import defaultdict
from .facts import Fact


def mixed_tags(kind,codes,h):
    if kind==h.MIXED:return [codes[1]]
    if isinstance(kind,h.OptT):return mixed_tags(kind.base,codes[:-1],h)
    if isinstance(kind,h.TupT):
        out=[];at=0
        for item in kind.items:
            width=h._width(item);out+=mixed_tags(item,codes[at:at+width],h);at+=width
        return out
    return []


def mutable_mixed(p,h):
    return any(p.fields[p.family(cls)].get(attr)==h.MIXED for cls,attr in p.written_set())


def possible(p,h):
    if mutable_mixed(p,h):return False
    for info in p.order:
        if getattr(info,'numeric_param_tags',()):return True
        if not getattr(info,'numeric_tags',()):continue
        for name in info.params:
            kind=info.vars.get(name,h.BOTTOM)
            if isinstance(kind,h.ObjT) and not kind.nullable and h.MIXED in p.fields[p.family(kind.cls)].values():return True
    return False


def parse(code):return ast.parse(code,mode='eval').body

def text(node):return ast.unparse(node)


def assignments(tree):
    result=defaultdict(list)
    for x in ast.walk(tree):
        if isinstance(x,ast.Assign):
            for target in x.targets:
                if isinstance(target,ast.Name):result[target.id].append(x.value)
        elif isinstance(x,(ast.AugAssign,ast.AnnAssign)) and isinstance(x.target,ast.Name):result[x.target.id].append(None)
    return result


def address(node):
    while isinstance(node,ast.Call) and text(node.func) in ('np.uint64','np.int64') and len(node.args)==1:node=node.args[0]
    offset=0
    while isinstance(node,ast.BinOp) and isinstance(node.op,ast.Add) and isinstance(node.right,ast.Constant) and type(node.right.value) is int:
        offset+=node.right.value;node=node.left
    return node,offset


def conversion_bound(node):
    if not(isinstance(node,ast.Compare) and len(node.ops)==1 and isinstance(node.ops[0],(ast.Gt,ast.Lt,ast.GtE,ast.LtE)) and len(node.comparators)==1):return False
    try:value=ast.literal_eval(node.comparators[0])
    except (ValueError,TypeError,SyntaxError):return False
    return type(value)in(int,float) and abs(value)==2**53


def fold_boolean_flags(tree):
    definitions=assignments(tree);params={a.arg for a in tree.args.args};values={n:set() for n in definitions}
    for name in params:values[name]=None
    parents={child:parent for parent in ast.walk(tree) for child in ast.iter_child_nodes(parent)}
    def pure_bound_boolean(node,use):
        if isinstance(node,ast.Constant):return type(node.value)is bool
        if not isinstance(node,ast.Name) or node.id in params:return False
        defs=definitions.get(node.id,())
        if len(defs)!=1 or not isinstance(defs[0],ast.Compare):return False
        definition=parents.get(defs[0]);statement=use
        while statement in parents and not isinstance(statement,ast.stmt):statement=parents[statement]
        container=parents.get(statement)
        if definition is None or container is None or parents.get(definition)is not container:return False
        for body in (getattr(container,'body',()),getattr(container,'orelse',()),getattr(container,'finalbody',())):
            if definition in body and statement in body:return body.index(definition)<body.index(statement)
        return False
    def evaluate(node):
        if isinstance(node,ast.Constant) and type(node.value)is bool:return {node.value}
        if isinstance(node,ast.Name):return values.get(node.id)
        if isinstance(node,ast.UnaryOp) and isinstance(node.op,ast.Not):
            v=evaluate(node.operand);return None if v is None else {not x for x in v}
        if isinstance(node,ast.BoolOp):
            parts=[]
            for child in node.values:
                value=evaluate(child)
                if value is None and pure_bound_boolean(child,node):value={False,True}
                if value is None:return None
                if not value:return set()
                parts.append(value)
                # Preserve short circuiting: an unreachable unknown operand
                # cannot prevent the leading constant from fixing this flag.
                if isinstance(node.op,ast.And) and value=={False}:return {False}
                if isinstance(node.op,ast.Or) and value=={True}:return {True}
            if isinstance(node.op,ast.And):return {False} if any(x=={False} for x in parts) else {True} if all(x=={True} for x in parts) else {False,True}
            return {True} if any(x=={True} for x in parts) else {False} if all(x=={False} for x in parts) else {False,True}
        return None
    for _ in range(len(values)+1):
        changed=False
        for name,defs in definitions.items():
            parts=[evaluate(x) for x in defs]
            new=None if name in params or any(v is None for v in parts) else set().union(*parts)
            if new!=values[name]:values[name]=new;changed=True
        if not changed:break
    def literal(node):
        value=evaluate(node)
        return next(iter(value)) if value is not None and len(value)==1 else None
    class Fold(ast.NodeTransformer):
        def visit_Name(self,node):
            value=literal(node)
            return ast.copy_location(ast.Constant(value),node) if isinstance(node.ctx,ast.Load) and value is not None else node
        def visit_BoolOp(self,node):
            value=literal(node)
            return ast.copy_location(ast.Constant(value),node) if value is not None else self.generic_visit(node)
        def visit_If(self,node):
            value=literal(node.test)
            if value is not None:
                body=node.body if value else node.orelse
                out=[]
                for x in body:
                    result=self.visit(x);out.extend(result if isinstance(result,list) else [result])
                return out
            return self.generic_visit(node)
        def visit_IfExp(self,node):
            value=literal(node.test)
            return self.visit(node.body if value else node.orelse) if value is not None else self.generic_visit(node)
    return Fold().visit(tree)


class NumericVersions:
    def __init__(self,program,heap):
        self.p,self.h=program,heap
        self.infos={i.name:i for i in program.order}
        self.trees={n:ast.parse(i.source).body[0] for n,i in self.infos.items()}
        self.defs={n:assignments(t) for n,t in self.trees.items()}
        self.params={n:{a.arg for a in t.args.args} for n,t in self.trees.items()}
        self.guards={};self.certified={};self.direct=[];self.blocked=[]
        self.ctor_safe=self.constructor_calls_are_fresh()
        self.fields_readonly=not mutable_mixed(program,heap)

    def constructor_calls_are_fresh(self):
        ea=self.p.escape_analysis
        ctors={n for n,f in ea.functions.items() if f.constructor}
        for name in ctors:
            info=self.infos.get(name)
            if info and info.params:
                receiver=info.params[0]
                if any(isinstance(x,ast.Name) and isinstance(x.ctx,ast.Store) and x.id==receiver for x in ast.walk(info.node)):return False
        # Expand formal origins across the actual checked call graph. A base
        # constructor forwarding its fresh self is safe; a region input or
        # uncertain field receiver is not fresh.
        passed=defaultdict(set)
        entry=self.p.entry.name
        for index,item in enumerate(ea.summaries[entry]['parameters']):
            if item['object']:passed[entry,index].add('external')
        def origins(name,node):
            if isinstance(node,ast.Name):values=ea.origins[name].get(node.id,set())
            elif isinstance(node,ast.Call) and isinstance(node.func,ast.Name) and node.func.id in ea.summaries:
                summary=ea.summaries[node.func.id];values=set(summary['fresh_returns'])
                if summary['return_unknown']:values.add('?')
                for index in summary['return_aliases']:
                    if index<len(node.args):values.update(origins(name,node.args[index]))
            else:return {'?'} if isinstance(node,ast.Subscript) else set()
            out=set()
            for value in values:
                if value.startswith('@'):out.update(passed[name,int(value[1:])])
                else:out.add(value)
            return out
        for _ in range(len(ea.functions)*10+1):
            changed=False
            for name,tree in ea.trees.items():
                for call in ast.walk(tree):
                    if not(isinstance(call,ast.Call) and isinstance(call.func,ast.Name) and call.func.id in ea.functions):continue
                    for index,arg in enumerate(call.args):
                        before=len(passed[call.func.id,index]);passed[call.func.id,index].update(origins(name,arg))
                        changed|=len(passed[call.func.id,index])!=before
            if not changed:break
        else:return False
        for name,tree in ea.trees.items():
            for call in ast.walk(tree):
                if not(isinstance(call,ast.Call) and isinstance(call.func,ast.Name) and call.func.id in ctors):continue
                if len(call.args)<=4:return False
                values=origins(name,call.args[4])
                if not values or any(value not in ea.allocations for value in values):return False
        return True

    def readonly(self,info):
        origin=getattr(info,'scalar_origin',info.name)
        def compute():
            summary=self.p.escape_analysis.summaries.get(origin)
            good=summary is not None and not any(x['object'] and (x['mutated'] or x['identity_observed']) for x in summary['parameters'])
            return Fact.proven(True) if good else Fact.unknown('F5 input mutation or identity effect')
        return self.p.facts.query('F5',('numeric-readonly',origin),compute).state=='proven'

    def valid_offsets(self,info):
        h,p=self.h,self.p;out={}
        for name in info.params:
            kind=info.vars.get(name,h.BOTTOM)
            if not isinstance(kind,h.ObjT) or kind.nullable:continue
            classes=tuple(kind.classes)
            common=set.intersection(*(set(p.class_fields[c]) for c in classes)) if classes else set()
            layout=p.layout(kind.cls)[0];fields=p.fields[p.family(kind.cls)]
            out['v_'+name]={layout[a]+1 for a in common if fields[a]==h.MIXED}
        return out

    def resolve(self,name,node,seen=frozenset()):
        if isinstance(node,ast.Name):
            if node.id in self.params[name]:
                if self.defs[name][node.id]:return None
                return copy.deepcopy(node)
            values=self.defs[name][node.id]
            if node.id in seen or len(values)!=1 or values[0] is None:return None
            return self.resolve(name,values[0],seen|{node.id})
        if isinstance(node,ast.Constant):return copy.deepcopy(node)
        if isinstance(node,ast.Call) and text(node.func) in ('np.uint64','np.int64') and len(node.args)==1:
            value=self.resolve(name,node.args[0],seen)
            if value is not None:return ast.Call(func=copy.deepcopy(node.func),args=[value],keywords=[])
        if isinstance(node,ast.Subscript) and isinstance(node.value,ast.Name) and node.value.id=='I':
            value=self.resolve(name,node.slice,seen)
            if value is not None:return ast.Subscript(value=ast.Name(id='I',ctx=ast.Load()),slice=value,ctx=ast.Load())
        if isinstance(node,ast.BinOp) and isinstance(node.op,ast.Add) and isinstance(node.right,ast.Constant) and type(node.right.value) is int:
            left=self.resolve(name,node.left,seen)
            if left is not None:return ast.BinOp(left=left,op=ast.Add(),right=copy.deepcopy(node.right))
        if isinstance(node,ast.Compare) and (conversion_bound(node) or (len(node.ops)==1 and isinstance(node.ops[0],ast.NotEq) and len(node.comparators)==1 and isinstance(node.comparators[0],ast.Constant) and node.comparators[0].value==0)):
            left=self.resolve(name,node.left,seen)
            if left is not None:return ast.Compare(left=left,ops=copy.deepcopy(node.ops),comparators=copy.deepcopy(node.comparators))
        return None

    def safe_guard(self,name,guard):
        if conversion_bound(guard):return isinstance(guard.left,ast.Name) and guard.left.id in self.params[name]-{'F','I','top','st'} and not self.defs[name][guard.left.id]
        if isinstance(guard,ast.Name):return guard.id in self.params[name] and not self.defs[name][guard.id]
        if isinstance(guard,ast.Compare) and len(guard.ops)==1 and isinstance(guard.ops[0],ast.NotEq) and len(guard.comparators)==1 and isinstance(guard.comparators[0],ast.Constant) and guard.comparators[0].value==0:
            left=guard.left
            while isinstance(left,ast.Call) and text(left.func) in ('np.int64','np.uint64') and len(left.args)==1:left=left.args[0]
            if isinstance(left,ast.Name) and left.id in self.params[name] and not self.defs[name][left.id]:return True
        if not(self.ctor_safe and self.fields_readonly and self.readonly(self.infos[name])):return False
        if not(isinstance(guard,ast.Compare) and isinstance(guard.left,ast.Subscript)):return False
        base,offset=address(guard.left.slice)
        return isinstance(base,ast.Name) and offset in self.valid_offsets(self.infos[name]).get(base.id,set())

    def own_guards(self,name):
        info=self.infos[name]
        origin=getattr(info,'scalar_origin',name)
        if info.generator or info.coroutine or self.p.escape_analysis.functions[origin].constructor:return set()
        guards=set();certified=set()
        for variable in tuple(getattr(info,'numeric_tags',()))+tuple(getattr(info,'numeric_param_tags',())):
            guard=self.resolve(name,parse(variable))
            if guard is None or isinstance(guard,ast.Constant):continue
            if self.safe_guard(name,guard):guards.add(text(guard));certified.add(variable)
        parents={child:parent for parent in ast.walk(self.trees[name]) for child in ast.iter_child_nodes(parent)}
        for node in ast.walk(self.trees[name]):
            if not conversion_bound(node):continue
            parent=parents.get(node)
            while isinstance(parent,ast.BoolOp):parent=parents.get(parent)
            if not isinstance(parent,ast.If):continue
            status=any(isinstance(x,ast.Assign) and any(isinstance(t,ast.Subscript) and text(t.value)=='st' and isinstance(t.slice,ast.Constant) and t.slice.value==0 for t in x.targets) for x in parent.body)
            guard=self.resolve(name,node)
            if status and guard is not None and self.safe_guard(name,guard):guards.add(text(guard))
        self.certified[name]=certified
        return guards

    def substitute(self,node,mapping):
        class Substitute(ast.NodeTransformer):
            def visit_Name(self,n):return copy.deepcopy(mapping.get(n.id,n)) if isinstance(n.ctx,ast.Load) else n
        return Substitute().visit(copy.deepcopy(node))

    def inherited(self,caller,call,callee):
        if len(call.args)!=len(self.trees[callee].args.args):return None
        mapping={p.arg:a for p,a in zip(self.trees[callee].args.args,call.args)};out=set()
        for code in self.guards.get(callee,()):
            expr=self.substitute(parse(code),mapping)
            expr=self.resolve(caller,expr)
            if isinstance(expr,ast.Constant) and expr.value is False:continue
            if expr is None or not self.safe_guard(caller,expr):return None
            out.add(text(expr))
        return out

    def run(self):
        report={'rule':'R7','versions':[],'direct_edges':[],'blocked':[]}
        if not self.ctor_safe:
            raise self.h.Unsupported('constructor receiver/rebinding is not proved fresh for native writeback')
        if self.p.fast_mixed:
            report['blocked']=[{'unknown':'legacy observability mode has no real input tags'}];return report
        for name in self.infos:
            guards=self.own_guards(name)
            if guards:self.guards[name]=guards
        # Grow requirements only along pure forwarding edges, never through a
        # produced object or a rebound scalar. Finite parameter fields/flags.
        for _ in range(len(self.infos)+1):
            changed=False
            for name,tree in self.trees.items():
                origin=getattr(self.infos[name],'scalar_origin',name)
                if self.infos[name].generator or self.infos[name].coroutine or self.p.escape_analysis.functions[origin].constructor:continue
                for call in ast.walk(tree):
                    if not(isinstance(call,ast.Call) and isinstance(call.func,ast.Name) and call.func.id in self.guards):continue
                    requirements=self.inherited(name,call,call.func.id)
                    if requirements and not requirements<=self.guards.get(name,set()):
                        self.guards.setdefault(name,set()).update(requirements);changed=True
            if not changed:break
        # Only a numeric/check consumer or a forwarding wrapper is worth a
        # version. Constructors stay checked; immutable scalar guards may forward through mutating bodies.
        for name in tuple(self.guards):
            if not self.guards[name]:self.guards.pop(name,None)
        fast_names={n:'_kf_'+n for n in self.guards}
        originals=list(self.p.order);new=[]
        for name,guards in self.guards.items():
            info=self.infos[name];tree=copy.deepcopy(self.trees[name]);tree.name=fast_names[name]
            known={code:False for code in guards}
            for variable in self.certified.get(name,()):known[variable]=False
            outer=self
            class Fixed(ast.NodeTransformer):
                def visit_Name(self,node):
                    if isinstance(node.ctx,ast.Load) and node.id in known:return ast.copy_location(ast.Constant(False),node)
                    return node
                def visit_Compare(self,node):
                    resolved=outer.resolve(name,node)
                    if resolved is not None and text(resolved) in guards:return ast.copy_location(ast.Constant(False),node)
                    return self.generic_visit(node)
                def visit_Call(self,node):
                    if isinstance(node.func,ast.Name) and node.func.id in fast_names:
                        callee=node.func.id;requirements=outer.inherited(name,node,callee)
                        if requirements is not None and requirements<=guards:
                            outer.direct.append((name,callee));node.func.id=fast_names[callee]
                    return self.generic_visit(node)
            tree=fold_boolean_flags(Fixed().visit(tree))
            fast=copy.copy(info);fast.name=tree.name;fast.numeric_origin=name;fast.numeric_fixed=True
            prefix=info.source.split('\ndef ',1)[0]
            tree.decorator_list=[]
            fast.source=prefix+'\n'+ast.unparse(ast.fix_missing_locations(tree))+'\n';new.append(fast)
            wrapper=copy.deepcopy(self.trees[name]);args=[ast.Name(id=a.arg,ctx=ast.Load()) for a in wrapper.args.args]
            condition=ast.UnaryOp(op=ast.Not(),operand=ast.BoolOp(op=ast.Or(),values=[parse(c) for c in sorted(guards)])) if len(guards)>1 else ast.UnaryOp(op=ast.Not(),operand=parse(next(iter(guards))))
            call=ast.Call(func=ast.Name(id=tree.name,ctx=ast.Load()),args=args,keywords=[])
            width=0 if info.ret in (self.h.NONE,self.h.BOTTOM) else self.h._width(info.ret)
            if width==0:
                dispatch=[ast.Expr(value=call),ast.Return(value=None)]
            elif width==1:dispatch=[ast.Return(value=call)]
            else:
                used={n.id for n in ast.walk(wrapper) if isinstance(n,ast.Name)}
                base='_kf_result'
                while any(base+str(i) in used for i in range(width)):base+='_' 
                stores=[ast.Name(id=base+str(i),ctx=ast.Store()) for i in range(width)]
                loads=[ast.Name(id=base+str(i),ctx=ast.Load()) for i in range(width)]
                dispatch=[ast.Assign(targets=[ast.Tuple(elts=stores,ctx=ast.Store())],value=call),ast.Return(value=ast.Tuple(elts=loads,ctx=ast.Load()))]
            wrapper.body=[ast.If(test=condition,body=dispatch,orelse=wrapper.body)]
            wrapper.decorator_list=[]
            info.source=prefix+'\n'+ast.unparse(ast.fix_missing_locations(wrapper))+'\n'
            ranges=[c for c in sorted(guards) if conversion_bound(parse(c))]
            tags=tuple(c for c in sorted(guards) if c not in ranges)
            fact=self.p.facts.query('F4',('numeric-version',name),lambda tags=tags:Fact.guarded('float input tags',tags) if tags else Fact.proven('statically typed conversion operands'))
            self.p.facts.query('F5',('numeric-entry-stability',name),lambda:Fact.proven('immutable primitive arguments or readonly validated fields'))
            for code in ranges:self.p.facts.query('F1',('numeric-entry-conversion',name,code),lambda code=code:Fact.guarded('exact conversion',code))
            report['versions'].append({'function':name,'fixed_function':tree.name,'guards':sorted(guards),'range_guards':ranges,'kind':'fixed-inputs' if tags else 'entry-conversions','fact_state':fact.state})
        self.p.order.extend(new)
        all_infos={i.name:i for i in self.p.order}
        self.p.calls={i:{all_infos[x.func.id] for x in ast.walk(ast.parse(i.source)) if isinstance(x,ast.Call) and isinstance(x.func,ast.Name) and x.func.id in all_infos} for i in self.p.order}
        self.p.mark_recursive()
        report['direct_edges']=[list(x) for x in sorted(set(self.direct))]
        if not report['versions']:report['blocked']=[{'unknown':'F4/F5 no immutable nonnullable input tag guard'}]
        return report
