"""An inert graph oracle, deterministic argument domains and failure reduction."""
import ast
import contextlib
import inspect
import io
import math
import random
import struct
import types


_AST_TYPES=frozenset(v for v in vars(ast).values() if type(v) is type and ast.AST in v.__mro__)
_AST_FIELD_TYPES={cls:vars(cls).get('_field_types') for cls in _AST_TYPES}

class UnsupportedOracle(Exception):pass
class IntSubclass(int):pass
class FloatSubclass(float):pass


def fields(value):
    cls=type(value)
    if type(cls) is not type:raise UnsupportedOracle('custom metaclass')
    for base in cls.__mro__:
        if base is object:continue
        namespace=vars(base)
        if any(not k.startswith('__') and type(v) in (list,dict,set,bytearray) and not (base in _AST_TYPES and k=='_field_types' and v is _AST_FIELD_TYPES.get(base)) for k,v in namespace.items()):raise UnsupportedOracle('mutable class state')
        if '__del__' in namespace or '__slots__' in namespace:
            raise UnsupportedOracle('finalizer or slots')
        if base.__module__=='builtins' and base not in (int,float,str,bytes):
            raise UnsupportedOracle('opaque builtin '+cls.__name__)
    try:descriptor=inspect.getattr_static(cls,'__dict__')
    except AttributeError:raise UnsupportedOracle('opaque '+cls.__name__)
    if type(descriptor) is not types.GetSetDescriptorType:
        raise UnsupportedOracle('custom instance dictionary')
    try:result=object.__getattribute__(value,'__dict__')
    except AttributeError:raise UnsupportedOracle('opaque '+cls.__name__)
    if type(result) is not dict or any(type(k) is not str for k in result):
        raise UnsupportedOracle('non-inert instance dictionary')
    return result


def clone(value,memo=None):
    """Copy only a positively supported graph, without application copy hooks."""
    if memo is None:memo={}
    cls=type(value)
    if cls is type and any(not k.startswith('__') and type(v) in (list,dict,set,bytearray) for k,v in vars(value).items()):
        raise UnsupportedOracle('mutable class state')
    if cls is types.FunctionType and value.__dict__:raise UnsupportedOracle('mutable function attributes')
    if cls in (type(None),bool,int,float,complex,str,bytes,type,types.FunctionType,types.ModuleType,types.CodeType):return value
    if id(value) in memo:return memo[id(value)]
    if cls is list:
        answer=[];memo[id(value)]=answer;answer.extend(clone(x,memo) for x in value);return answer
    if cls is dict:
        answer={};memo[id(value)]=answer
        for k,v in value.items():
            if type(k) not in (type(None),bool,int,float,complex,str,bytes):raise UnsupportedOracle('non-inert mapping key')
            answer[k]=clone(v,memo)
        return answer
    if cls is tuple:
        # Recursive immutable -> mutable -> immutable graphs need a fixup layer.
        memo[id(value)]=_PENDING
        answer=tuple(clone(x,memo) for x in value)
        if any(x is _PENDING for x in answer):raise UnsupportedOracle('recursive tuple')
        memo[id(value)]=answer;return answer
    if cls in (set,frozenset):
        if any(type(x) not in (type(None),bool,int,float,complex,str,bytes) for x in value):raise UnsupportedOracle('non-inert set member')
        answer=cls(value);memo[id(value)]=answer;return answer
    if cls is bytearray:answer=bytearray(value)
    elif cls is range:return value
    elif cls is slice:return slice(clone(value.start,memo),clone(value.stop,memo),clone(value.step,memo))
    else:
        data=fields(value)
        if isinstance(value,int):answer=int.__new__(cls,int.__int__(value))
        elif isinstance(value,float):answer=float.__new__(cls,float.__float__(value))
        elif isinstance(value,str):answer=str.__new__(cls,str.__str__(value))
        elif isinstance(value,bytes):answer=bytes.__new__(cls,bytes.__bytes__(value))
        elif cls in _AST_TYPES:answer=ast.AST.__new__(cls)
        elif cls.__base__ is object or all(b is object or b.__module__!='builtins' for b in cls.__mro__):answer=object.__new__(cls)
        else:raise UnsupportedOracle('extension allocation')
        memo[id(value)]=answer
        if id(data) in memo:object.__setattr__(answer,'__dict__',memo[id(data)])
        else:
            newdata=object.__getattribute__(answer,'__dict__');memo[id(data)]=newdata
            for key,child in data.items():newdata[key]=clone(child,memo)
    memo[id(value)]=answer;return answer

_PENDING=object()


def typekey(cls):return (cls.__module__,cls.__qualname__)


def children(value):
    cls=type(value)
    if cls in (list,tuple):return list(enumerate(value))
    if cls is dict:return [(('key',i),k) for i,k in enumerate(value)]+[(('value',i),v) for i,v in enumerate(value.values())]
    if cls in (set,frozenset):return list(enumerate(sorted(value,key=lambda x:(typekey(type(x)),repr(x)))))
    if cls is slice:return [('start',value.start),('stop',value.stop),('step',value.step)]
    if cls in (type(None),bool,int,float,complex,str,bytes,bytearray,range,type,types.FunctionType,types.ModuleType,types.CodeType):return []
    return [('__dict__',fields(value))]


class _Anchors(dict):
    def __init__(self):
        super().__init__()
        self.keepalive=[]


def anchors(roots,fn):
    answer=_Anchors()
    def visit(value,path):
        if type(value) in (int,float,complex):return
        if id(value) in answer:return
        answer[id(value)]=path
        # An anchored input may be replaced during the call. Retain its owner
        # so a later projection cannot recycle that address as an input alias.
        answer.keepalive.append(value)
        if type(value).__module__!='builtins':answer.setdefault(id(type(value)),path+('<type>',))
        for key,child in children(value):visit(child,path+(str(key),))
    for key,value in roots.items():visit(value,(key,))
    def constants(code,path):
        for i,value in enumerate(code.co_consts):
            if type(value) is types.CodeType:constants(value,path+(str(i),))
            elif type(value) not in (int,float,complex):visit(value,path+(str(i),))
    if type(fn) is types.FunctionType:
        constants(fn.__code__,('code',))
        for name,value in sorted(fn.__globals__.items()):
            if not name.startswith('__') and type(value) in (type,types.FunctionType,types.ModuleType):visit(value,('binding',name))
        for name,value in sorted(fn.__builtins__.items()):
            if type(value) is type:visit(value,('builtin',name))
        if fn.__closure__:
            for i,cell in enumerate(fn.__closure__):
                value=cell.cell_contents
                if type(value) in (list,dict,set,bytearray):raise UnsupportedOracle('mutable closure needs fixture factory')
                visit(value,('closure',str(i)))
    return answer


class Graph:
    def __init__(self,external,*,reference=False):self.external=external;self.seen={};self.keepalive=[];self.reference=reference
    def freeze(self,value):
        cls=type(value);kind=(*typekey(cls),id(cls))
        if self.reference and cls.__module__!='builtins' and id(cls) not in self.external:
            raise UnsupportedOracle('unrooted dynamic result class')
        if cls is int:return ('int',str(value))
        if cls is float:return ('float',struct.pack('!d',value).hex())
        if cls is complex:return ('complex',struct.pack('!dd',value.real,value.imag).hex())
        if cls is bool or value is None:return (cls.__name__,value)
        if id(value) in self.seen:return ('ref',self.seen[id(value)])
        number=len(self.seen);self.seen[id(value)]=number;self.keepalive.append(value)
        identity=('external',self.external[id(value)]) if id(value) in self.external else ('fresh',number)
        if cls in (str,bytes,bytearray):payload=value if cls is str else bytes(value).hex()
        elif cls is type:
            if self.reference and id(value) not in self.external:raise UnsupportedOracle('new dynamic type result')
            payload=(*typekey(value),id(value))
        elif cls is range:payload=(str(value.start),str(value.stop),str(value.step))
        elif cls in (list,tuple,dict,set,frozenset,slice):payload=tuple((key,self.freeze(child)) for key,child in children(value))
        elif cls in (types.FunctionType,types.ModuleType,types.CodeType):
            if id(value) not in self.external:raise UnsupportedOracle('new callable/module/code result')
            payload=None
        else:
            payload=[]
            if isinstance(value,int):payload.append(('int',str(int.__int__(value))))
            elif isinstance(value,float):payload.append(('float',struct.pack('!d',float.__float__(value)).hex()))
            elif isinstance(value,str):payload.append(('str',str.__str__(value)))
            elif isinstance(value,bytes):payload.append(('bytes',bytes.__bytes__(value).hex()))
            payload.extend((key,self.freeze(child)) for key,child in children(value))
            payload=tuple(payload)
        return ('node',number,kind,identity,payload)


def exception(exc,graph,seen=None):
    if seen is None:seen=set()
    if id(exc) in seen:return ('recursive-exception',)
    seen.add(id(exc))
    if type(exc).__str__ is not BaseException.__str__ and type(exc).__module__!='builtins':
        raise UnsupportedOracle('custom exception string protocol')
    result=[typekey(type(exc)),str(exc),graph.freeze(exc.args),bool(exc.__suppress_context__)]
    for linked in (exc.__cause__,exc.__context__):result.append(exception(linked,graph,seen) if linked is not None else None)
    if isinstance(exc,BaseExceptionGroup):result.append([exception(e,graph,seen) for e in exc.exceptions])
    return tuple(result)


class GeneratorRun:
    def __init__(self,values,result=None,error=None):self.values,self.result,self.error=values,result,error


def drive(value,limit=256):
    if inspect.isgenerator(value):
        result=[]
        for _ in range(limit):
            try:result.append(next(value))
            except StopIteration as stop:return GeneratorRun(result,stop.value)
            except BaseException as exc:return GeneratorRun(result,error=exc)
        value.close();raise UnsupportedOracle('generator iteration limit')
    if inspect.isawaitable(value):
        if inspect.iscoroutine(value):value.close()
        raise UnsupportedOracle('async result')
    return value


def global_data(module):
    return {k:v for k,v in vars(module).items() if not k.startswith('__')}


def compare(fn,compiled,args,kwargs,module,*,warm=2):
    """Compare actual cold/warm public calls, including fallback calls.

    Unknown oracle domains are explicitly unchecked, never counted as passed.
    Restoring a trusted fixture's globals permits exact independent replays.
    """
    def argument_graph(value,seen=None):
        if seen is None:seen=set()
        if id(value) in seen:return
        seen.add(id(value))
        if type(value) in (type,types.FunctionType,types.ModuleType,types.CodeType):raise UnsupportedOracle('opaque callable/module/type argument')
        for key,child in children(value):argument_graph(child,seen)
    try:argument_graph((args,kwargs))
    except UnsupportedOracle as exc:return {'status':'unchecked','reason':str(exc)}
    original=global_data(module)
    defaults=fn.__defaults__ if type(fn) is types.FunctionType else None
    kwdefaults=fn.__kwdefaults__ if type(fn) is types.FunctionType else None
    try:saved=clone({'args':args,'kwargs':kwargs,'globals':original,'defaults':defaults,'kwdefaults':kwdefaults})
    except UnsupportedOracle as exc:return {'status':'unchecked','reason':str(exc)}
    native_before=getattr(compiled,'compiled_calls',0)
    def run(target):
        state=clone(saved)
        for key in set(global_data(module))-set(original):vars(module).pop(key,None)
        vars(module).update(state['globals'])
        if type(fn) is types.FunctionType:fn.__defaults__,fn.__kwdefaults__=state['defaults'],state['kwdefaults']
        roots={'args':state['args'],'kwargs':state['kwargs'],'globals':state['globals'],'defaults':state['defaults'],'kwdefaults':state['kwdefaults']}
        external=anchors(roots,fn);graph=Graph(external,reference=target is fn)
        stdout=io.StringIO();stderr=io.StringIO()
        with contextlib.redirect_stdout(stdout),contextlib.redirect_stderr(stderr):
            try:result=drive(target(*state['args'],**state['kwargs']))
            except UnsupportedOracle:raise
            except BaseException as exc:outcome=('exception',exception(exc,graph))
            else:
                if type(result) is GeneratorRun:
                    terminal=('exception',exception(result.error,graph)) if result.error is not None else ('return',graph.freeze(result.result))
                    outcome=('generator',graph.freeze(result.values),terminal)
                else:outcome=('result',graph.freeze(result))
        return {'outcome':outcome,'args':graph.freeze(state['args']),'kwargs':graph.freeze(state['kwargs']),
                'globals':graph.freeze(global_data(module)),'defaults':graph.freeze((state['defaults'],state['kwdefaults'])),'stdout':stdout.getvalue(),'stderr':stderr.getvalue()}
    try:
        for phase in range(warm):
            expected=run(fn);actual=run(compiled)
            if expected!=actual:return {'status':'wrong','phase':phase,'expected':expected,'actual':actual,
                                         'native_calls':getattr(compiled,'compiled_calls',0)-native_before}
        calls=getattr(compiled,'compiled_calls',0)-native_before
        return {'status':'native' if calls else 'declined','native_calls':calls,'reference_exception':expected['outcome'][1][0] if expected['outcome'][0]=='exception' else None}
    except UnsupportedOracle as exc:return {'status':'unchecked','reason':str(exc)}
    finally:
        for key in set(global_data(module))-set(original):vars(module).pop(key,None)
        vars(module).update(original)
        if type(fn) is types.FunctionType:fn.__defaults__,fn.__kwdefaults__=defaults,kwdefaults


def boundaries():
    nan=struct.unpack('!d',bytes.fromhex('7ff8000000001234'))[0]
    return [0,-1,1,2,2**63-1,2**63,-2**63,-2**63-1,2**100,True,False,None,
            0.,-0.,1.5,float('inf'),-float('inf'),nan,complex(-0.,1.),IntSubclass(2),FloatSubclass(-0.),
            '', 'a','A','\u00e9','\u03a9','\U0001f642','a\x00b',b'',b'a',b'\x00\xff',
            [],[0],[1,2],[[1],[1]],(),(0,),{}, {'x':[1]},set(),{1},bytearray(b''),range(0),range(2)]


def arguments(fn,base=(),kwargs=None,*,seed=1,trials=40):
    """Deterministic boundary-first mutations, aliasing and nested aliasing."""
    kwargs={} if kwargs is None else kwargs
    rng=random.Random(seed);signature=inspect.signature(fn,eval_str=False)
    if not base and not kwargs:
        required=[p for p in signature.parameters.values() if p.default is p.empty and p.kind in (p.POSITIONAL_ONLY,p.POSITIONAL_OR_KEYWORD)]
        base=tuple(1 for p in required)
        kwargs={p.name:1 for p in signature.parameters.values() if p.default is p.empty and p.kind is p.KEYWORD_ONLY}
    yield clone((base,kwargs))
    slots=[('arg',i) for i in range(len(base))]+[('kw',k) for k in kwargs]
    if not slots:return
    all_values=boundaries()
    def domain(value):
        kind=type(value)
        if kind in _AST_TYPES:
            examples=[ast.parse(code).body[0].targets[0] for code in ('a=1','a,b=x','[a,[b,c]]=x','obj.field=1','obj[0]=1')]
            return examples+[ast.Name(),ast.Tuple(elts=[]),ast.Name(id='\u03bb'),None,0,'x']
        if kind in (list,tuple):
            scalar=[v for v in all_values if type(v) in (int,float,bool,str,bytes,type(None))]
            values=[[],[0],[1,2],[[1],[1]]]+[[v] for v in scalar]
            return [tuple(v) for v in values] if kind is tuple else values
        if kind is str:return [v for v in all_values if type(v) in (str,bytes,bool,type(None))]+[0,1,[],['a']]
        if kind in (bytes,bytearray):return [b'',b'a',b'\x00\xff',[],[0],[255],[-1],[256],0,-1,True,None,'', '\u03a9']
        return all_values
    domains=[domain(base[key] if scope=='arg' else kwargs[key]) for scope,key in slots]
    for trial in range(max(0,trials-1)):
        a,k=clone((base,kwargs));a=list(a)
        offset=2 if len(a)>1 else 1 if a else 0
        if len(a)>1 and trial==0:
            shared=[0];a[0]=shared;a[1]=shared
        elif a and trial==(1 if len(a)>1 else 0):
            shared=[];a[0]=[shared,shared]
            if len(a)>1:a[1]=a[0]
        else:
            position=trial-offset
            scope,key=slots[position%len(slots)]
            chosen=domains[position%len(slots)]
            value=clone(chosen[(position//len(slots))%len(chosen)])
            if scope=='arg':a[key]=value
            else:k[key]=value
        if trial>=len(all_values)*len(slots) and len(a)>1:
            a[rng.randrange(len(a))]=clone(rng.choice(all_values))
        yield tuple(a),k


def reductions(value,seen=None):
    if seen is None:seen=set()
    if id(value) in seen:return
    seen=seen|{id(value)}
    cls=type(value)
    if cls is int:
        for x in (0,1,-1,value//2):
            if abs(x)<abs(value):yield x
    elif cls in (list,tuple,str,bytes):
        if len(value):yield value[:0]
        for i in range(len(value)):yield value[:i]+value[i+1:]
        if cls in (list,tuple):
            for i,item in enumerate(value):
                for small in reductions(item,seen):
                    result=list(value);result[i]=small;yield result if cls is list else tuple(result)
    elif cls is dict:
        for key in value:
            result=dict(value);result.pop(key);yield result


def shrink(args,kwargs,fails,*,budget=80):
    """Greedy bounded reduction; never accepts a non-reproducing candidate."""
    args,kwargs=clone((args,kwargs));attempts=0
    changed=True
    while changed and attempts<budget:
        changed=False
        for scope,key in [('arg',i) for i in range(len(args))]+[('kw',k) for k in kwargs]:
            value=args[key] if scope=='arg' else kwargs[key]
            for reduced in reductions(value):
                a,k=clone((args,kwargs));a=list(a)
                if scope=='arg':a[key]=reduced
                else:k[key]=reduced
                attempts+=1
                if fails(tuple(a),k):args,kwargs=tuple(a),k;changed=True;break
                if attempts>=budget:break
            if changed or attempts>=budget:break
    return args,kwargs
