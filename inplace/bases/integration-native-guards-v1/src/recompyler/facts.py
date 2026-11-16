"""Shared conservative proof facts and declarative guarded rewrite plans.

No profile value is a proof. Integer relations are affine expressions over
ordered induction symbols; guards constrain their entry leaves. Unknown joins,
identity observations and unrecognized updates retain the checked lowering.
"""
import ast
from dataclasses import dataclass
from fractions import Fraction
import inspect
import textwrap

LIMIT = 1 << 24
MIN, MAX = -(1 << 63), (1 << 63) - 1

@dataclass(frozen=True)
class Fact:
    state: str
    value: object = None
    guard: object = None
    reason: str = ''
    @classmethod
    def proven(cls, value): return cls('proven', value)
    @classmethod
    def guarded(cls, value, guard): return cls('guarded', value, guard)
    @classmethod
    def unknown(cls, reason): return cls('unknown', reason=reason)

@dataclass(frozen=True)
class Rule:
    requires: tuple
    emitted: str

RULES = {
    'R2': Rule(('F2', 'F3'), 'reuse dead local array'),
    'R5': Rule(('F1',), 'raw bounded numeric operation'),
    'R6': Rule(('F1',), 'raw nonnegative array access / permutation step'),
    'R7': Rule(('F1','F4','F5'), 'guarded fixed-float function body'),
    'R8': Rule(('F2','F5'), 'virtual scalar fields'),
    'R4': Rule(('F1', 'F2', 'F3', 'F9'), 'stable borrowed copy; one release at each owner exit'),
}

class Facts:
    """One answer per question, including existing backend analyses."""
    def __init__(self): self.answers = {}
    def query(self, fact, key, compute):
        token = fact, key
        if token not in self.answers: self.answers[token] = compute()
        return self.answers[token]
    def known(self, fact, key, value, reason):
        return self.query(fact, key, lambda: Fact.proven(value) if value else Fact.unknown(reason))

@dataclass(frozen=True)
class Affine:
    terms: tuple = ()
    const: Fraction = Fraction(0)
    @classmethod
    def literal(cls, value): return cls((), Fraction(value))
    @classmethod
    def symbol(cls, name): return cls(((name, Fraction(1)),))
    def plus(self, other):
        terms = dict(self.terms)
        for name, value in other.terms: terms[name] = terms.get(name, 0) + value
        return Affine(tuple(sorted((n, c) for n,c in terms.items() if c)), self.const + other.const)
    def scale(self, value):
        return Affine(tuple((n,c*value) for n,c in self.terms if c*value), self.const*value)
    def minus(self, other): return self.plus(other.scale(-1))

@dataclass(frozen=True)
class FloatRange:
    low: float
    high: float

@dataclass(frozen=True)
class Log2:
    extent: Affine


def log_summary(fn):
    """Recognize an inspected exact logarithm algorithm, independent of names."""
    try:
        node = ast.parse(textwrap.dedent(inspect.getsource(fn))).body[0]
    except (TypeError, OSError, SyntaxError): return False
    if not isinstance(node,ast.FunctionDef):return False
    body = list(node.body)
    if body and isinstance(body[0],ast.Expr) and isinstance(body[0].value,ast.Constant) and isinstance(body[0].value.value,str):body.pop(0)
    if len(body)!=5 or len(node.args.args)!=1:return False
    a,b,loop,test,ret=body
    if not all(isinstance(x,ast.Assign) and len(x.targets)==1 and isinstance(x.targets[0],ast.Name) and isinstance(x.value,ast.Constant) for x in (a,b)):return False
    if type(a.value.value) is not int or a.value.value!=1 or type(b.value.value) is not int or b.value.value!=0:return False
    k,l,n=a.targets[0].id,b.targets[0].id,node.args.args[0].arg
    if not (isinstance(loop,ast.While) and not loop.orelse and isinstance(loop.test,ast.Compare) and len(loop.test.ops)==1 and isinstance(loop.test.ops[0],ast.Lt) and ast.unparse(loop.test.left)==k and ast.unparse(loop.test.comparators[0])==n and len(loop.body)==2):return False
    x,y=loop.body
    if not (isinstance(x,ast.AugAssign) and ast.unparse(x.target)==k and isinstance(x.op,ast.Mult) and isinstance(x.value,ast.Constant) and x.value.value==2 and isinstance(y,ast.AugAssign) and ast.unparse(y.target)==l and isinstance(y.op,ast.Add) and isinstance(y.value,ast.Constant) and y.value.value==1):return False
    if not (isinstance(test,ast.If) and not test.orelse and len(test.body)==1 and isinstance(test.body[0],ast.Raise) and isinstance(test.test,ast.Compare) and len(test.test.ops)==1 and isinstance(test.test.ops[0],ast.NotEq) and ast.unparse(test.test.left)==n and ast.unparse(test.test.comparators[0])==f'1 << {l}' and isinstance(ret,ast.Return) and ast.unparse(ret.value)==l):return False
    return True

class FunctionFacts(Facts):
    def __init__(self, node, params, builtin, fixed_arrays=(), aliases=None, namespace=None, owner_initializations=None):
        super().__init__()
        self.node,self.params=node,set(params)
        self.builtin=builtin
        self.namespace=namespace or {}
        self.fixed=set(fixed_arrays);self.aliases=aliases or {}
        self.owner_initializations=dict(owner_initializations or {})
        self.copy_sites={}
        self.index_sites,self.operation_sites,self.slice_sites,self.rotate_sites={},{},{},{}
        self.guards={};self.limits={};self.env={};self.geometric={}
        self.array_extents={};self.permutations={};self.control={}
        self.parents={c:p for p in ast.walk(node) for c in ast.iter_child_nodes(p)}
        self.stores={x.id for x in ast.walk(node) if isinstance(x,ast.Name) and isinstance(x.ctx,ast.Store)}
        self.builtin=lambda name: name not in self.params|self.stores and builtin(name)
        for name in sorted(self.params-self.stores):
            self.env[name]=Affine.symbol(name)
            self.limits[name]=(Affine.literal(-LIMIT),Affine.literal(LIMIT))
        self._local_arrays()
        self._control_induction()
        self.body(node.body,self.env.copy())

    def bound(self, value, high):
        if not isinstance(value,Affine):return None
        result=value
        # Newer symbols depend only on older ones; substitution preserves
        # correlation and cancels terms before older symbols are bounded.
        for name,(lo,hi) in reversed(list(self.limits.items())):
            coefficient=dict(result.terms).get(name,0)
            if coefficient:
                rest=Affine(tuple((n,c) for n,c in result.terms if n!=name),result.const)
                result=rest.plus((hi if (coefficient>0)==high else lo).scale(coefficient))
        return None if result.terms else result.const

    def safe(self,value):
        if isinstance(value,Affine):
            lo,hi=self.bound(value,False),self.bound(value,True)
            return lo is not None and hi is not None and MIN<=lo<=hi<=MAX
        return isinstance(value,FloatRange) and all(__import__('math').isfinite(x) for x in (value.low,value.high))

    def need(self,value):
        if not isinstance(value,Affine):return
        pending=list(dict(value.terms));seen=set()
        while pending:
            name=pending.pop()
            if name in seen:continue
            seen.add(name)
            if name in self.params:
                lo,hi=self.limits[name]
                self.guards['int:'+name]=('int',name,int(lo.const),int(hi.const))
            elif name.startswith('len:'):
                array=name[4:]
                self.guards['array:'+array]=('array',array,None)
            elif name in self.limits:
                for v in self.limits[name]:pending.extend(n for n,c in v.terms)

    def mark_op(self,node,value,*inputs):
        if self.safe(value) and all(self.safe(v) for v in inputs):
            self.operation_sites[id(node)]=Fact.guarded(value,'entry domains')
            for v in (value,*inputs):self.need(v)

    def _extent(self,expr):
        if isinstance(expr,ast.Name) and expr.id in self.env:return self.env[expr.id]
        if isinstance(expr,ast.Constant) and type(expr.value) is int and MIN<=expr.value<=MAX:return Affine.literal(expr.value)
        if isinstance(expr,ast.BinOp) and isinstance(expr.op,(ast.Add,ast.Sub)):
            a,b=self._extent(expr.left),self._extent(expr.right)
            if isinstance(a,Affine) and isinstance(b,Affine):
                result=a.plus(b) if isinstance(expr.op,ast.Add) else a.minus(b)
                return result if self.safe(a) and self.safe(b) and self.safe(result) else None
        return None

    def constrain(self,name,low,high):
        old_low,old_high=self.limits[name]
        low=max(low,int(old_low.const));high=min(high,int(old_high.const))
        self.limits[name]=(Affine.literal(low),Affine.literal(high))
        self.guards['int:'+name]=('int',name,low,high)

    def nonnegative_extent(self,value):
        if not value.terms:return 0<=value.const<=LIMIT
        if len(value.terms)!=1:return False
        name,coefficient=value.terms[0]
        if name not in self.params or not coefficient:return False
        import math
        if coefficient>0:self.constrain(name,math.ceil(-value.const/coefficient),math.floor((LIMIT-value.const)/coefficient))
        else:self.constrain(name,math.ceil((LIMIT-value.const)/coefficient),math.floor(-value.const/coefficient))
        return True

    def _local_arrays(self):
        assignments={n:[] for n in self.fixed}
        valid={n:True for n in self.fixed}
        stable={n:True for n in self.fixed}
        for x in ast.walk(self.node):
            if isinstance(x,ast.Assign) and len(x.targets)==1 and isinstance(x.targets[0],ast.Name) and x.targets[0].id in assignments:
                assignments[x.targets[0].id].append(x.value)
            if isinstance(x,ast.Subscript) and isinstance(x.ctx,ast.Store) and isinstance(x.value,ast.Name) and x.value.id in valid:
                p=self.parents.get(x)
                if not self.prefix_flip(p):
                    valid[x.value.id]=False
                    if isinstance(x.slice,ast.Slice):stable[x.value.id]=False
                else:
                    k=p.value.slice.lower
                    definitions=[d for d in ast.walk(self.node) if isinstance(d,ast.Assign) and any(isinstance(t,ast.Name) and isinstance(k,ast.Name) and t.id==k.id for t in d.targets)]
                    stores=[d for d in ast.walk(self.node) if isinstance(d,ast.Name) and isinstance(d.ctx,ast.Store) and isinstance(k,ast.Name) and d.id==k.id]
                    content=isinstance(k,ast.Name) and k.id not in self.params and bool(definitions) and len(stores)==len(definitions) and all(
                        isinstance(d.value,ast.Subscript) and isinstance(d.value.value,ast.Name)
                        and d.value.value.id==x.value.id and isinstance(d.value.slice,ast.Constant)
                        and type(d.value.slice.value) is int and d.value.slice.value==0 for d in definitions)
                    if not content:stable[x.value.id]=False;valid[x.value.id]=False
        for _ in range(len(assignments)+1):
            for name,values in assignments.items():
                extents=[];perm=True
                for v in values:
                    if isinstance(v,ast.Call) and isinstance(v.func,ast.Name) and v.func.id=='list' and self.builtin('list') and len(v.args)==1:
                        r=v.args[0]
                        if not(isinstance(r,ast.Call) and isinstance(r.func,ast.Name) and r.func.id=='range' and self.builtin('range') and len(r.args) in (1,2)):perm=False;break
                        lo=Affine.literal(0) if len(r.args)==1 else self._extent(r.args[0]);hi=self._extent(r.args[-1])
                        if not isinstance(lo,Affine) or not isinstance(hi,Affine):perm=False;break
                        extents.append(hi.minus(lo));perm=perm and lo==Affine.literal(0)
                    elif isinstance(v,ast.Subscript) and isinstance(v.slice,ast.Slice) and all(getattr(v.slice,f) is None for f in ('lower','upper','step')) and isinstance(v.value,ast.Name) and v.value.id in self.array_extents:
                        extents.append(self.array_extents[v.value.id]);perm=perm and v.value.id in self.permutations
                    else:perm=False;break
                if stable[name] and extents and all(e==extents[0] for e in extents) and len(extents)==len(values) and self.nonnegative_extent(extents[0]):
                    self.array_extents[name]=extents[0]
                    if perm and valid[name]:self.permutations[name]=extents[0]

    def _control_induction(self):
        # A name initialized from an unchanged extent, updated only by unit
        # steps toward the tested endpoints. Break preserves the closed range.
        for s in self.node.body:
            if not(isinstance(s,ast.Assign) and len(s.targets)==1 and isinstance(s.targets[0],ast.Name) and isinstance(s.value,ast.Name) and s.value.id in self.params-self.stores):continue
            name,n=s.targets[0].id,s.value.id
            updates=[x for x in ast.walk(self.node) if isinstance(x,ast.AugAssign) and isinstance(x.target,ast.Name) and x.target.id==name]
            other=[x for x in ast.walk(self.node) if isinstance(x,ast.Name) and isinstance(x.ctx,ast.Store) and x.id==name]
            if not updates or len(other)!=len(updates)+1:continue
            good=True
            for u in updates:
                if not(isinstance(u.value,ast.Constant) and type(u.value.value) is int and u.value.value==1 and isinstance(u.op,(ast.Add,ast.Sub))):good=False;break
                p=self.parents.get(u)
                repeated=False
                while p is not None and not isinstance(p,ast.While):
                    if isinstance(p,(ast.For,ast.AsyncFor)):repeated=True
                    p=self.parents.get(p)
                if repeated:good=False;break
                expected=n if isinstance(u.op,ast.Add) else '1'
                if not(p and isinstance(p.test,ast.Compare) and len(p.test.ops)==1 and isinstance(p.test.ops[0],ast.NotEq) and ast.unparse(p.test.left)==name and ast.unparse(p.test.comparators[0])==expected):good=False;break
            if good:
                loops={}
                for u in updates:
                    parent=self.parents.get(u)
                    while parent is not None and not isinstance(parent,ast.While):parent=self.parents.get(parent)
                    loops[id(parent)]=loops.get(id(parent),0)+1
                good=all(count==1 for count in loops.values())
            if good:
                self.control[name]=(Affine.literal(1),Affine.symbol(n))
                self.constrain(n,1,LIMIT)

    @staticmethod
    def prefix_flip(s):
        if not(isinstance(s,ast.Assign) and len(s.targets)==1 and isinstance(s.targets[0],ast.Subscript) and isinstance(s.value,ast.Subscript)):return False
        a,b=s.targets[0],s.value
        if not(isinstance(a.value,ast.Name) and isinstance(b.value,ast.Name) and a.value.id==b.value.id and isinstance(a.slice,ast.Slice) and isinstance(b.slice,ast.Slice)):return False
        return a.slice.lower is None and a.slice.step is None and isinstance(a.slice.upper,ast.BinOp) and isinstance(a.slice.upper.op,ast.Add) and isinstance(a.slice.upper.right,ast.Constant) and a.slice.upper.right.value==1 and ast.dump(a.slice.upper.left)==ast.dump(b.slice.lower) and b.slice.upper is None and isinstance(b.slice.step,ast.UnaryOp) and isinstance(b.slice.step.op,ast.USub) and isinstance(b.slice.step.operand,ast.Constant) and b.slice.step.operand.value==1

    def expression(self,node,env):
        if isinstance(node,ast.Constant):
            if type(node.value) is int:return Affine.literal(node.value)
            if type(node.value) is float:return FloatRange(node.value,node.value)
            return None
        if isinstance(node,ast.Name):return env.get(node.id)
        if isinstance(node,ast.UnaryOp) and isinstance(node.op,ast.USub):
            v=self.expression(node.operand,env)
            result=v.scale(-1) if isinstance(v,Affine) else FloatRange(-v.high,-v.low) if isinstance(v,FloatRange) else None
            if not self.safe(result) or not self.safe(v):return None
            self.mark_op(node,result,v);return result
        if isinstance(node,ast.BinOp):
            a,b=self.expression(node.left,env),self.expression(node.right,env);result=None
            if isinstance(a,Affine) and isinstance(b,Affine):
                if isinstance(node.op,ast.Add):result=a.plus(b)
                elif isinstance(node.op,ast.Sub):result=a.minus(b)
                elif isinstance(node.op,ast.Mult):
                    if not a.terms:result=b.scale(a.const)
                    elif not b.terms:result=a.scale(b.const)
                elif isinstance(node.op,(ast.LShift,ast.RShift)) and not b.terms and 0<=b.const<63 and b.const.denominator==1:
                    scale=Fraction(2**int(b.const));result=a.scale(scale) if isinstance(node.op,ast.LShift) else self.divide(a,scale)
                elif isinstance(node.op,ast.FloorDiv) and not b.terms and b.const>0:result=self.divide(a,b.const)
            if isinstance(a,(Affine,FloatRange)) and isinstance(b,(Affine,FloatRange)) and (isinstance(a,FloatRange) or isinstance(b,FloatRange)):
                def span(v):return (float(self.bound(v,False)),float(self.bound(v,True))) if isinstance(v,Affine) else (v.low,v.high)
                if all(not isinstance(v,Affine) or max(abs(self.bound(v,False)),abs(self.bound(v,True)))<=2**53 for v in (a,b)):
                    al,ah=span(a);bl,bh=span(b)
                    if isinstance(node.op,ast.Add):result=FloatRange(al+bl,ah+bh)
                    elif isinstance(node.op,ast.Sub):result=FloatRange(al-bh,ah-bl)
                    elif isinstance(node.op,ast.Mult):
                        p=[x*y for x in (al,ah) for y in (bl,bh)];result=FloatRange(min(p),max(p))
                    elif isinstance(node.op,ast.Div) and not bl<=0<=bh:
                        p=[x/y for x in (al,ah) for y in (bl,bh)];result=FloatRange(min(p),max(p))
            if not self.safe(result) or not self.safe(a) or not self.safe(b):return None
            self.mark_op(node,result,a,b);return result
        if isinstance(node,ast.Attribute) and isinstance(node.value,ast.Name) and node.value.id not in self.params|self.stores and self.namespace.get(node.value.id) is __import__('math') and node.attr in ('pi','e','tau'):
            value=getattr(__import__('math'),node.attr);return FloatRange(value,value)
        if isinstance(node,ast.NamedExpr):
            for x in ast.walk(node.target):
                if isinstance(x,ast.Name):env[x.id]=None
            self.expression(node.value,env);return None
        if isinstance(node,ast.Subscript):
            index=self.expression(node.slice,env)
            if isinstance(node.value,ast.Name):
                name=node.value.id
                if name in env:self.index(node,name,index)
                if name in self.permutations and id(node) in self.index_sites:
                    symbol='value:'+str(id(node));self.limits[symbol]=(Affine.literal(0),self.permutations[name].minus(Affine.literal(1)))
                    return Affine.symbol(symbol)
            return None
        if isinstance(node,ast.Call):
            args=[self.expression(a,env) for a in node.args]
            if isinstance(node.func,ast.Name):
                name=node.func.id
                if name=='len' and self.builtin('len') and len(node.args)==1 and isinstance(node.args[0],ast.Name):
                    array=node.args[0].id
                    if array in env and array in self.array_extents:return self.array_extents[array]
                    if array in self.params-self.stores:
                        symbol='len:'+array;self.limits.setdefault(symbol,(Affine.literal(0),Affine.literal(LIMIT)));return Affine.symbol(symbol)
                fn=self.namespace.get(name) if name not in self.params|self.stores else None
                if len(args)==1 and isinstance(args[0],Affine) and callable(fn) and log_summary(fn):
                    if self.power_guard(args[0]):return Log2(args[0])
                    return None
                if name=='float' and self.builtin('float') and len(args)==1 and isinstance(args[0],Affine) and self.safe(args[0]):
                    self.need(args[0]);return FloatRange(float(self.bound(args[0],False)),float(self.bound(args[0],True)))
            if isinstance(node.func,ast.Attribute) and isinstance(node.func.value,ast.Name) and node.func.value.id not in self.params|self.stores and self.namespace.get(node.func.value.id) is __import__('math') and node.func.attr=='sin' and len(args)==1 and self.safe(args[0]):
                self.need(args[0]);self.operation_sites[id(node)]=Fact.guarded(FloatRange(-1,1),'finite argument');return FloatRange(-1,1)
            return None
        for c in ast.iter_child_nodes(node):self.expression(c,env)
        return None

    def divide(self,a,b):
        # Exact symbolic half needs the corresponding divisibility guard.
        if b==2 and len(a.terms)==1 and a.const==0 and a.terms[0][1]==1 and a.terms[0][0] in self.params:
            name=a.terms[0][0];self.guards['even:'+name]=('even',name);return a.scale(Fraction(1,2))
        lo,hi=self.bound(a,False),self.bound(a,True)
        return None if lo is None or hi is None else Affine.symbol(self.fresh_bound(lo//b,hi//b))

    def fresh_bound(self,low,high):
        name='bound:'+str(len(self.limits));self.limits[name]=(Affine.literal(low),Affine.literal(high));return name

    def power_guard(self,value):
        # Extent must be an unchanged parameter, optionally divided by two.
        if len(value.terms)!=1 or value.const:return False
        name,coefficient=value.terms[0]
        if name not in self.params or coefficient not in (1,Fraction(1,2)):return False
        divisor=1 if coefficient==1 else 2
        self.constrain(name,divisor,LIMIT)
        self.guards['power:'+name]=('power',name,divisor)
        self.need(value);return True

    def index(self,node,array,index):
        if not isinstance(index,Affine):return
        extent=self.array_extents.get(array)
        if extent is None and array in self.params-self.stores:
            # Pick the input extent whose relation makes the access safe.
            candidates=[(n,Affine.symbol(n)) for n in sorted(self.params-self.stores) if n!=array]
            candidates.append(('len:'+array,Affine.symbol('len:'+array)))
            for n,e in candidates:
                if n.startswith('len:'):self.limits.setdefault(n,(Affine.literal(0),Affine.literal(LIMIT)))
                low=self.bound(index,False);high=self.bound(index.minus(e),True)
                if low is not None and low>=0 and high is not None and high<=-1:
                    extent=e
                    self.guards['extent:'+array+':'+n]=('extent',array,n)
                    break
        if extent is None:return
        low=self.bound(index,False);high=self.bound(index.minus(extent),True)
        if low is not None and low>=0 and high is not None and high<=-1 and self.safe(index):
            self.index_sites[id(node)]=Fact.guarded((array,index),'stable extent')
            self.need(index);self.need(extent)

    def copy_owner(self, node, env):
        """A full private permutation copy cannot replace either physical owner."""
        if not (len(node.targets)==1 and isinstance(node.targets[0],ast.Name)
                and isinstance(node.value,ast.Subscript) and isinstance(node.value.value,ast.Name)
                and isinstance(node.value.slice,ast.Slice)
                and all(getattr(node.value.slice,k) is None for k in ('lower','upper','step'))):return
        target,source=node.targets[0].id,node.value.value.id
        if any(name not in self.fixed or name not in self.permutations or name not in env
               or self.owner_initializations.get(name,node.lineno)>=node.lineno
               for name in (target,source)):return
        extent=self.permutations[target]
        if extent!=self.permutations[source] or not self.safe(extent):return
        # These are the existing F2/F3 answers, not a second liveness analysis.
        self.query('F2',('copy-owner',id(node)),lambda:Fact.proven((target,source)))
        self.query('F3',('copy-owner',id(node)),lambda:Fact.proven(
            {name:self.owner_initializations[name] for name in (target,source)}))
        self.need(extent)
        answer=Fact.guarded((target,source,extent),'stable equal physical permutation extents')
        self.query('F1',('copy-owner',id(node)),lambda:answer)
        # An earlier unrelated checked error cannot change either physical extent.
        self.copy_sites[id(node)]=self.query('F9',('copy-owner',id(node)),lambda:answer)

    def assigned(self,body):
        return {x.id for s in body for x in ast.walk(s) if isinstance(x,ast.Name) and isinstance(x.ctx,ast.Store)}

    def body(self,body,env):
        for s in body:
            if isinstance(s,ast.Assign):
                self.copy_owner(s,env)
                value=self.expression(s.value,env)
                for t in s.targets:
                    if isinstance(t,ast.Name):env[t.id]=value
                    elif isinstance(t,ast.Subscript):
                        if self.prefix_flip(s) and isinstance(t.value,ast.Name) and t.value.id in self.permutations:
                            k=self.expression(s.value.slice.lower,env);extent=self.permutations[t.value.id]
                            if isinstance(k,Affine) and self.bound(k,False)>=0 and self.bound(k.minus(extent),True)<=-1:
                                self.slice_sites[id(s)]=Fact.guarded(True,'permutation prefix');self.need(k)
                        elif not isinstance(t.slice,ast.Slice):self.expression(t,env)
            elif isinstance(s,ast.AugAssign):
                a=self.expression(s.target,env);b=self.expression(s.value,env)
                synthetic=ast.BinOp(left=s.target,op=s.op,right=s.value)
                value=self.expression(synthetic,env)
                if id(synthetic) in self.operation_sites:self.operation_sites[id(s)]=self.operation_sites.pop(id(synthetic))
                if isinstance(s.target,ast.Name):env[s.target.id]=value
            elif isinstance(s,ast.For):self.for_loop(s,env)
            elif isinstance(s,ast.While):self.while_loop(s,env)
            elif isinstance(s,ast.If):
                self.expression(s.test,env);a,b=env.copy(),env.copy();self.body(s.body,a);self.body(s.orelse,b)
                for n in self.assigned(s.body+s.orelse):
                    if n not in a or n not in b:env.pop(n,None)
                    else:env[n]=a.get(n) if a.get(n)==b.get(n) else None
            elif isinstance(s,ast.Expr):
                self.expression(s.value,env);self.rotation(s.value,env)
            else:
                for x in ast.walk(s):
                    if isinstance(x,ast.Name) and isinstance(x.ctx,ast.Store):env[x.id]=None
                self.expression(s,env)
        return env

    def for_loop(self,s,env):
        r=s.iter
        assigned=self.assigned(s.body)
        if not(isinstance(s.target,ast.Name) and isinstance(r,ast.Call) and isinstance(r.func,ast.Name) and r.func.id=='range' and self.builtin('range') and 1<=len(r.args)<=3) or s.target.id in assigned:
            inner=env.copy()
            for n in assigned|{x.id for x in ast.walk(s.target) if isinstance(x,ast.Name)}:inner[n]=None
            self.body(s.body,inner)
        else:
            args=[self.expression(x,env) for x in r.args]
            start,stop,step=([Affine.literal(0),args[0],Affine.literal(1)] if len(args)==1 else [*args,Affine.literal(1)] if len(args)==2 else args)
            deps={n for v in (start,stop,step) if isinstance(v,Affine) for n,c in v.terms}
            if any(n in assigned for n in deps) or not all(isinstance(v,Affine) for v in (start,stop,step)) or self.bound(step,False) is None or self.bound(step,False)<=0:
                inner=env.copy()
                for n in assigned|{s.target.id}:inner[n]=None
                self.body(s.body,inner)
            else:
                saved=self.limits.copy();inner=env.copy()
                for n in assigned:inner[n]=None
                upper=stop.minus(Affine.literal(1))
                for symbol,extent in self.geometric.items():
                    if start==Affine.literal(0) and stop==extent and step==Affine.symbol(symbol).scale(2):upper=stop.minus(step)
                self.limits[s.target.id]=(start,upper);inner[s.target.id]=Affine.symbol(s.target.id)
                self.body(s.body,inner);self.limits=saved
        for n in assigned|{getattr(s.target,'id','')}:env[n]=None
        self.body(s.orelse,env)

    def while_loop(self,s,env):
        assigned=self.assigned(s.body);inner=env.copy();saved=self.limits.copy();geom=self.geometric.copy()
        for n in assigned:inner[n]=None
        for name,bounds in self.control.items():
            self.limits[name]=bounds;inner[name]=Affine.symbol(name)
        # Bounded unit-step control loops use strict body inequalities.
        t=s.test
        if isinstance(t,ast.Compare) and len(t.ops)==1 and isinstance(t.ops[0],ast.NotEq) and isinstance(t.left,ast.Name) and t.left.id in self.control:
            name=t.left.id;lo,hi=self.control[name]
            if ast.unparse(t.comparators[0])=='1':self.limits[name]=(Affine.literal(2),hi)
            elif self.expression(t.comparators[0],env)==hi:self.limits[name]=(lo,hi.minus(Affine.literal(1)))
        # Exact logarithm counted doubling, or a directly tested geometric IV.
        extent=None
        if (isinstance(t,ast.Compare) and len(t.ops)==1 and isinstance(t.ops[0],ast.Lt) and isinstance(t.left,ast.Name)
                and not any(isinstance(x,ast.Continue) for x in ast.walk(s))
                and not ({x.id for x in ast.walk(t.comparators[0]) if isinstance(x,ast.Name)} & assigned)):
            count=env.get(t.left.id);end=self.expression(t.comparators[0],env)
            if count==Affine.literal(0) and isinstance(end,Log2):extent=end.extent
            elif count==Affine.literal(1) and isinstance(end,Affine) and self.power_guard(end):extent=end
            for update in s.body:
                if not(isinstance(update,ast.AugAssign) and isinstance(update.target,ast.Name) and isinstance(update.op,(ast.Mult,ast.LShift)) and isinstance(update.value,ast.Constant) and type(update.value.value) is int):continue
                factor=update.value.value if isinstance(update.op,ast.Mult) else 2**update.value.value
                name=update.target.id
                writes=[x for x in ast.walk(s) if isinstance(x,ast.Name) and isinstance(x.ctx,ast.Store) and x.id==name]
                counter_writes=[x for x in ast.walk(s) if isinstance(x,ast.Name) and isinstance(x.ctx,ast.Store) and x.id==t.left.id]
                counter_ok=name==t.left.id or (len(counter_writes)==1 and any(isinstance(x,ast.AugAssign) and isinstance(x.target,ast.Name) and x.target.id==t.left.id and isinstance(x.op,ast.Add) and isinstance(x.value,ast.Constant) and type(x.value.value) is int and x.value.value==1 for x in s.body))
                if extent is not None and factor==2 and env.get(name)==Affine.literal(1) and len(writes)==1 and counter_ok:
                    self.limits[name]=(Affine.literal(1),extent.scale(Fraction(1,2)));inner[name]=Affine.symbol(name);self.geometric[name]=extent
                    if name!=t.left.id:
                        self.limits[t.left.id]=(Affine.literal(0),Affine.literal(24));inner[t.left.id]=Affine.symbol(t.left.id)
        # A permutation-read loop variable has a stable content interval on every
        # iteration. Refine its nonzero body to a positive prefix extent.
        if isinstance(t,ast.Name) and isinstance(env.get(t.id),Affine):
            assignments=[x for x in ast.walk(s) if isinstance(x,ast.Assign) and any(isinstance(y,ast.Name) and y.id==t.id for y in x.targets)]
            carried_writes=[x for x in ast.walk(s) if isinstance(x,ast.Name) and isinstance(x.ctx,ast.Store) and x.id==t.id]
            if assignments and len(carried_writes)==len(assignments) and all(isinstance(x.value,ast.Subscript) and isinstance(x.value.value,ast.Name) and x.value.value.id in self.permutations for x in assignments):
                e=self.permutations[assignments[0].value.value.id]
                initial=env[t.id]
                valid_initial=(self.bound(initial,False) is not None and self.bound(initial,False)>=0 and self.bound(initial.minus(e),True) is not None and self.bound(initial.minus(e),True)<=-1)
                if not valid_initial or any(self.permutations[x.value.value.id]!=e for x in assignments):
                    self.body(s.body,inner);self.limits=saved;self.geometric=geom
                    for name in assigned:env[name]=None
                    return
                self.limits[t.id]=(Affine.literal(1),e.minus(Affine.literal(1)));inner[t.id]=Affine.symbol(t.id)
        self.body(s.body,inner)
        self.limits=saved;self.geometric=geom
        for n in assigned:env[n]=None
        for name,bounds in self.control.items():
            self.limits[name]=bounds;env[name]=Affine.symbol(name)
        self.body(s.orelse,env)

    def rotation(self,c,env):
        if not(isinstance(c,ast.Call) and len(c.args)==2 and isinstance(c.args[1],ast.Call)):return
        base=c.func.value.id if isinstance(c.func,ast.Attribute) and c.func.attr=='insert' and isinstance(c.func.value,ast.Name) else self.aliases.get(getattr(c.func,'id',None))
        if base not in self.permutations:return
        inner=c.args[1]
        inner_base=inner.func.value.id if isinstance(inner.func,ast.Attribute) and inner.func.attr=='pop' and isinstance(inner.func.value,ast.Name) else self.aliases.get(getattr(inner.func,'id',None))
        if inner_base!=base:return
        i=self.expression(c.args[0],env);j=self.expression(inner.args[0],env) if inner.args else Affine.literal(-1);e=self.permutations[base]
        if all(isinstance(x,Affine) and self.bound(x,False)>=0 and self.bound(x.minus(e),True)<=-1 for x in (i,j)):
            self.rotate_sites[id(c)]=Fact.guarded(True,'permutation rotation');self.need(i);self.need(j)

    def report(self):
        total_index=sum(isinstance(x,ast.Subscript) and not isinstance(x.slice,ast.Slice) for x in ast.walk(self.node))
        total_op=sum(isinstance(x,(ast.BinOp,ast.AugAssign,ast.UnaryOp)) for x in ast.walk(self.node))
        total_copy=sum(isinstance(x,ast.Assign) and len(x.targets)==1 and isinstance(x.targets[0],ast.Name) and x.targets[0].id in self.fixed and isinstance(x.value,ast.Subscript) and isinstance(x.value.slice,ast.Slice) and all(getattr(x.value.slice,k) is None for k in ('lower','upper','step')) for x in ast.walk(self.node))
        return {'function':self.node.name,'rules':{
            'R4':{'fired':len(self.copy_sites),'blocked':max(0,total_copy-len(self.copy_sites)),'unknown':'F1/F2/F3/F9 equal kind/extent or dominating owners'},
            'R5':{'fired':len(self.operation_sites),'blocked':max(0,total_op-len(self.operation_sites)),'unknown':'F1 loop-carried or numeric domain'},
            'R6':{'fired':len(self.index_sites)+len(self.slice_sites)+len(self.rotate_sites),'blocked':max(0,total_index-len(self.index_sites)),'unknown':'F1 extent, content or carry relation'}},'guards':list(self.guards.values())}
