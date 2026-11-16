"""Native control flow over NRT-owned, original CPython objects.

The first slice lowers field access, isinstance, list comprehensions, recursion
and explicit raises. It never invokes the original helper as a compiled body.
"""
import ast
import builtins
import inspect
import textwrap
import types
from . import provenance
from .lift import Unsupported
from ._text_owners import observers_clear
from ._call_bridge import handled_exception_clear
from ._managed_recursion import recursion_budget_clear


class _Emitter:
    def __init__(self, fn):
        self.fn = fn
        try:self.binding = provenance.bind_source(fn)
        except (ValueError, OSError, SyntaxError, TypeError) as exc:
            raise Unsupported('managed source binding: '+str(exc)) from None
        self.node = self.binding.node
        if fn.__closure__ or self.node.args.vararg or self.node.args.kwarg:
            raise Unsupported('managed closure/variadic binding is not yet supported')
        self.pool = []
        self.dependencies = []
        self.attribute_dependencies=[]
        self.locals = {}
        self.local_counter = 0
        self.lines = []
        self.depth = 1
        self.counter = 0
        args = self.node.args.posonlyargs+self.node.args.args+self.node.args.kwonlyargs
        self.parameters = [arg.arg for arg in args]
        from ._managed_recursion import recursive_descent
        def recursive(target):
            if not isinstance(target,ast.Name):return False
            namespace=fn.__globals__ if target.id in fn.__globals__ else fn.__builtins__
            return namespace.get(target.id) is fn
        proof=recursive_descent(self.node,self.parameters,recursive)
        if proof is None:raise Unsupported('native recursive progress requires a descending owner')
        self.recursion_fields,self.recursive=proof
        from .flow import analyse,function_locals
        unbound=analyse(self.node,self.parameters).nodes
        if unbound:raise Unsupported('managed local may be read before assignment: '+unbound[0].id)
        for name in self.parameters:self.local(name)
        for name in sorted(function_locals(self.node)):self.local(name)
        self.write('pass')
        self.block(self.node.body)
        self.write('return '+self.constant(None)+',True')
        parameters = ['_pool','_errors']+[self.local(name) for name in self.parameters]
        self.source = 'def _entry('+','.join(parameters)+'):\n'+'\n'.join(self.lines)+'\n'

    def local(self, name):
        if name not in self.locals:
            self.locals[name] = '_v'+str(self.local_counter)
            self.local_counter+=1
        return self.locals[name]

    def fresh(self):
        self.counter += 1
        return '_t'+str(self.counter)

    def write(self, text):self.lines.append('    '*self.depth+text)

    def operation(self, name, *args):
        result = self.fresh()
        joined=','.join(args)
        if name in ('_list','_tuple'):joined='('+joined+(',' if len(args)==1 else '')+')'
        self.write(result+', _ok = '+name+'('+joined+')')
        self.write('if not _ok: _capture(_errors); return _errors,False')
        return result

    def constant(self, value):
        index=len(self.pool)
        self.pool.append(value)
        return self.operation('_pool_item','_pool',str(index))

    def original_literal(self, node):
        bound = self.binding.constants.get(provenance.site(node))
        if bound is not None and not bound.unknown and len(bound.origins)==1:
            origin = next(iter(bound.origins))
            if origin.kind == 'constant':return provenance.resolve_origin(self.fn, origin)
        value = node.value
        if type(value) in (str,bytes):
            # F-string fragments share the complete JoinedStr instruction span.
            # Exact module/code binding plus a unique original pooled literal
            # supplies its original owner, rather than manufacturing equal text.
            matches = [v for v in self.fn.__code__.co_consts if type(v) is type(value) and v == value]
            if matches and all(v is matches[0] for v in matches):return matches[0]
            raise Unsupported('managed literal has no unique original owner')
        return value

    def global_value(self, name):
        namespace=self.fn.__globals__ if name in self.fn.__globals__ else self.fn.__builtins__
        if name not in namespace:raise Unsupported('managed global is absent: '+name)
        value=namespace[name]
        self.dependencies.append((namespace,name,value))
        return value

    def expression(self, node):
        bound=self.binding.constants.get(provenance.site(node))
        if bound is not None and not bound.unknown and len(bound.origins)==1:
            origin=next(iter(bound.origins))
            if origin.kind=='constant':return self.constant(provenance.resolve_origin(self.fn,origin))
        if isinstance(node,ast.Name):
            if node.id in self.locals:return self.local(node.id)
            return self.constant(self.global_value(node.id))
        if isinstance(node,ast.Constant):return self.constant(self.original_literal(node))
        if isinstance(node,ast.Attribute):
            if isinstance(node.value,ast.Name) and node.value.id not in self.locals:
                base=self.global_value(node.value.id)
                if type(base) is types.ModuleType:
                    namespace=types.ModuleType.__getattribute__(base,'__dict__')
                    if node.attr in namespace:self.attribute_dependencies.append((namespace,node.attr,namespace[node.attr]))
            return self.operation('_getattr',self.expression(node.value),self.constant(node.attr))
        if isinstance(node,ast.Subscript) and not isinstance(node.slice,ast.Slice):
            owner=self.expression(node.value)
            if self.recursive:self.write('if not _owned_container('+owner+'): return _errors,False')
            return self.operation('_getitem',owner,self.expression(node.slice))
        if isinstance(node,(ast.List,ast.Tuple)):
            return self.operation('_list' if isinstance(node,ast.List) else '_tuple',*[self.expression(x) for x in node.elts])
        if isinstance(node,ast.Call) and isinstance(node.func,ast.Name):
            target=self.global_value(node.func.id) if node.func.id not in self.locals else None
            if target is self.fn and len(node.args)==len(self.parameters) and not node.keywords:
                result=self.fresh()
                self.write(result+',_ok = _entry(_pool,_errors,'+','.join(self.expression(x) for x in node.args)+')')
                self.write('if not _ok: return '+result+',False')
                return result
            if target is builtins.isinstance and len(node.args)==2 and not node.keywords:
                return self.operation('_bool',self.operation('_isinstance',*[self.expression(x) for x in node.args]))
            raise Unsupported('managed call needs the shared call bridge')
        if isinstance(node,ast.ListComp):
            result=self.operation('_list')
            first_iterable=self.expression(node.generators[0].iter)
            previous=dict(self.locals)
            own={gen.target.id for gen in node.generators if isinstance(gen.target,ast.Name)}
            if len(own)!=len({ast.dump(gen.target) for gen in node.generators}):
                if any(not isinstance(gen.target,ast.Name) for gen in node.generators):raise Unsupported('managed comprehension target')
            for name in sorted(own):
                self.locals.pop(name,None);self.local(name)
            available=set()
            for index,gen in enumerate(node.generators):
                if not isinstance(gen.target,ast.Name):raise Unsupported('managed comprehension target')
                if index and any(isinstance(part,ast.Name) and isinstance(part.ctx,ast.Load) and part.id in own-available for part in ast.walk(gen.iter)):
                    raise Unsupported('managed comprehension local may be read before assignment')
                available.add(gen.target.id)
                if any(isinstance(part,ast.Name) and isinstance(part.ctx,ast.Load) and part.id in own-available for test in gen.ifs for part in ast.walk(test)):
                    raise Unsupported('managed comprehension local may be read before assignment')
            def generate(index):
                if index==len(node.generators):
                    item=self.expression(node.elt)
                    self.write('if not _append('+result+','+item+'): _capture(_errors); return _errors,False')
                    return
                gen=node.generators[index]
                if gen.is_async:raise Unsupported('managed async comprehension')
                self.iteration(gen.target,gen.iter,lambda: filters(gen.ifs,lambda: generate(index+1)),first_iterable if index==0 else None)
            def filters(conditions,body):
                if not conditions:return body()
                condition=self.condition(conditions[0]);self.write('if '+condition+':');self.depth+=1
                filters(conditions[1:],body);self.depth-=1
            generate(0)
            self.locals=previous
            return result
        if isinstance(node,ast.JoinedStr):
            fragments=[]
            for value in node.values:
                if isinstance(value,ast.Constant):fragments.append(self.expression(value))
                elif isinstance(value,ast.FormattedValue) and value.conversion in (-1,115) and value.format_spec is None:
                    item=self.expression(value.value)
                    fragments.append(self.operation('_str',item) if value.conversion==115 else self.operation('_format',item,self.constant('')))
                else:raise Unsupported('managed formatting conversion is not yet supported')
            if not fragments:return self.constant('')
            result=fragments[0]
            for fragment in fragments[1:]:result=self.operation('_concat',result,fragment)
            return result
        raise Unsupported('managed expression: '+type(node).__name__)

    def condition(self,node):
        if isinstance(node,ast.BoolOp):
            result=self.fresh();first=self.condition(node.values[0]);self.write(result+' = '+first)
            for operand in node.values[1:]:
                self.write('if '+('not ' if isinstance(node.op,ast.Or) else '')+result+':');self.depth+=1
                following=self.condition(operand);self.write(result+' = '+following);self.depth-=1
            return result
        # isinstance is a language predicate: it already returns native bool.
        if isinstance(node,ast.Call) and isinstance(node.func,ast.Name) and self.global_value(node.func.id) is builtins.isinstance:
            return self.operation('_isinstance',*[self.expression(x) for x in node.args])
        return self.operation('_truth',self.expression(node))

    def assign(self,target,value):
        if not isinstance(target,ast.Name):raise Unsupported('managed assignment target: '+type(target).__name__)
        self.write(self.local(target.id)+' = '+value)

    def iteration(self,target,iterable,body,prepared=None):
        owner=self.expression(iterable) if prepared is None else prepared
        if self.recursive:self.write('if not _owned_container('+owner+'): return _errors,False')
        iterator=self.operation('_iter',owner)
        self.write('while True:');self.depth+=1
        value=self.fresh();ended=self.fresh()
        self.write(value+','+ended+',_ok = _next('+iterator+')')
        self.write('if not _ok: _capture(_errors); return _errors,False')
        self.write('if '+ended+': break')
        self.assign(target,value);body();self.depth-=1

    def block(self,statements):
        for node in statements:
            if isinstance(node,ast.Expr):
                if isinstance(node.value,ast.Constant) and type(node.value.value) is str:continue
                self.expression(node.value)
            elif isinstance(node,ast.Return):
                self.write('return '+(self.constant(None) if node.value is None else self.expression(node.value))+',True')
            elif isinstance(node,ast.Assign):
                value=self.expression(node.value)
                for target in node.targets:self.assign(target,value)
            elif isinstance(node,ast.If):
                condition=self.condition(node.test);self.write('if '+condition+':');self.depth+=1
                self.block(node.body);self.depth-=1
                if node.orelse:
                    self.write('else:');self.depth+=1;self.block(node.orelse);self.depth-=1
            elif isinstance(node,ast.For) and not node.orelse:
                self.iteration(node.target,node.iter,lambda: self.block(node.body))
            elif isinstance(node,ast.Raise) and node.cause is None and isinstance(node.exc,ast.Call) and len(node.exc.args)==1 and not node.exc.keywords:
                exception=self.expression(node.exc.func);message=self.expression(node.exc.args[0])
                self.write('_raise('+exception+','+message+')');self.write('_capture(_errors)');self.write('return _errors,False')
            elif isinstance(node,ast.Pass):self.write('pass')
            else:raise Unsupported('managed statement: '+type(node).__name__)


def _argument_signature(fn):
    code=fn.__code__;parameters=[];defaults=fn.__defaults__ or ()
    ordinary=code.co_argcount
    for index,name in enumerate(code.co_varnames[:ordinary+code.co_kwonlyargcount]):
        if index<code.co_posonlyargcount:kind=inspect.Parameter.POSITIONAL_ONLY
        elif index<ordinary:kind=inspect.Parameter.POSITIONAL_OR_KEYWORD
        else:kind=inspect.Parameter.KEYWORD_ONLY
        default=inspect.Parameter.empty
        if index<ordinary and index>=ordinary-len(defaults):default=defaults[index-(ordinary-len(defaults))]
        elif index>=ordinary:default=(fn.__kwdefaults__ or {}).get(name,inspect.Parameter.empty)
        parameters.append(inspect.Parameter(name,kind,default=default))
    return inspect.Signature(parameters)


def _admitted_arguments(values, attributes=None, physical_fields=()):
    """Read-only owners: native allocation is legal; unknown callbacks decline.

    Cycles and deep graphs stay Python before entry, protecting native recursive
    helpers without changing Python's own RecursionError behavior.
    """
    pending=[(value,0,False) for value in values]
    seen=set();active=set();budget=4096
    dictionaries=type.__dict__['__dict__']
    mros=type.__dict__['__mro__']
    descriptors=(types.GetSetDescriptorType,types.MemberDescriptorType,
                 types.FunctionType,staticmethod,classmethod,types.WrapperDescriptorType,
                 types.MethodDescriptorType,types.ClassMethodDescriptorType)
    while pending:
        value,depth,leaving=pending.pop()
        identity=id(value)
        if leaving:
            active.remove(identity);seen.add(identity);continue
        budget-=1
        if budget<0 or depth>128:return False
        cls=type(value)
        if type(cls) is not type:return False
        # A class-level descriptor/value may return the same object forever;
        # only actual owned fields may discharge recursive descent.
        if physical_fields:
            namespaces=[dictionaries.__get__(base) for base in mros.__get__(cls)]
            own=None
            for namespace in namespaces:
                if '__dict__' in namespace:
                    descriptor=namespace['__dict__']
                    if type(descriptor) is types.GetSetDescriptorType:
                        own=descriptor.__get__(value,cls)
                    break
            if own is not None and (type(own) is not dict or any(type(key) is not str for key in own)):return False
            for field in physical_fields:
                if own is not None and field in own:continue
                descriptor=next((namespace[field] for namespace in namespaces if field in namespace),None)
                if descriptor is not None and type(descriptor) is not types.MemberDescriptorType:return False
        if cls in (str,bytes,int,float,complex,bool,type(None),object):continue
        if identity in active:return False
        if identity in seen:continue
        active.add(identity);pending.append((value,depth,True))
        if cls in (tuple,list):
            if len(value)>budget:return False
            pending.extend((child,depth+1,False) for child in value)
            continue
        if type(cls) is not type:return False
        mro=mros.__get__(cls)
        module=cls.__module__
        if ast.AST not in mro and type(module) is str and module=='builtins':return False
        fields=[];dictionary=None
        for base in mro:
            namespace=dictionaries.__get__(base)
            if base is object or base is ast.AST:
                pass
            else:
                hooks=('__del__','__getattribute__','__getattr__','__bool__',
                       '__len__','__iter__','__getitem__','__index__','__format__','__str__')
                if any(name in namespace for name in hooks):return False
                for key,item in namespace.items():
                    if attributes is not None and key not in attributes and key!='__class__':continue
                    if type(item) in descriptors:continue
                    if any('__get__' in dictionaries.__get__(part) for part in mros.__get__(type(item))):return False
            if '__dict__' in namespace and dictionary is None:
                descriptor=namespace['__dict__']
                if type(descriptor) is not types.GetSetDescriptorType:return False
                dictionary=descriptor
            for key,descriptor in namespace.items():
                if type(descriptor) is types.MemberDescriptorType:
                    try:fields.append(descriptor.__get__(value,cls))
                    except AttributeError:pass
                    except TypeError:return False
        if dictionary is not None:
            data=dictionary.__get__(value,cls)
            if type(data) is not dict or any(type(key) is not str for key in data):return False
            if len(data)>budget:return False
            fields.extend(dict.values(data))
        pending.extend((child,depth+1,False) for child in fields)
    return True


class ManagedLifted:
    def __init__(self,fn, *, compiled=None):
        if type(fn) is not types.FunctionType:raise Unsupported('managed entry requires an exact Python function')
        if fn.__defaults__ is not None and type(fn.__defaults__) is not tuple:raise Unsupported('managed defaults must be an exact tuple')
        if fn.__kwdefaults__ is not None and (type(fn.__kwdefaults__) is not dict or any(type(key) is not str for key in fn.__kwdefaults__)):raise Unsupported('managed keyword defaults must be inert')
        self.original=fn;self._emitter=_Emitter(fn);self.source=self._emitter.source
        self._code=fn.__code__;self._defaults=fn.__defaults__;self._kwdefaults=fn.__kwdefaults__
        self._attributes={node.attr for node in ast.walk(self._emitter.node) if isinstance(node,ast.Attribute)}
        self._keyword_values=dict.copy(fn.__kwdefaults__) if fn.__kwdefaults__ is not None else {}
        self._signature=_argument_signature(fn);self._pool=tuple(self._emitter.pool)
        self.compiled_calls=self.fallback_calls=self.whole_function_fallback_calls=self.managed_calls=0
        self.problem=None
        if compiled is None:
            from numba import njit
            from . import _managed_native as native
            scope={'_pool_item':native.pool_item,'_getattr':native.getattr_object,'_getitem':native.getitem_object,
                   '_list':native.list_object,'_tuple':native.tuple_object,'_isinstance':native.isinstance_object,
                   '_truth':native.truth_object,'_iter':native.getiter_object,'_next':native.next_object,
                   '_append':native.append_object,'_str':native.str_object,'_concat':native.concat_object,
                   '_raise':native.raise_object,'_capture':native.capture_error_into,'_bool':native.bool_object,'_format':native.format_object,'_owned_container':native.owned_container}
            exec(compile(self.source,'<recompyler-managed>','exec'),scope)
            from numba.core import types as ntypes
            signature=ntypes.Tuple((native.managed,ntypes.boolean))(*([native.managed]*(len(self._signature.parameters)+2)))
            dispatcher=njit(signature)(scope['_entry'])
            scope['_entry']=dispatcher
            self._compiled=dispatcher
            self._entry=next(iter(dispatcher.overloads.values())).entry_point
        else:self._compiled=self._entry=compiled

    def __call__(self,*args,**kwargs):
        valid=handled_exception_clear() and self.original.__code__ is self._code and self.original.__defaults__ is self._defaults and self.original.__kwdefaults__ is self._kwdefaults
        valid=valid and observers_clear((self.original,)) and provenance._inert_namespaces(self.original)
        valid=valid and (not self._emitter.recursive or recursion_budget_clear())
        valid=valid and all(type(key) is str for key in kwargs)
        valid=valid and all(namespace.get(name) is value for namespace,name,value in self._emitter.attribute_dependencies)
        dependencies=[value for _,_,value in self._emitter.dependencies]
        dependencies.extend(value for _,_,value in self._emitter.attribute_dependencies)
        valid=valid and all(value is self.original or value is builtins.isinstance or type(value) is types.ModuleType or type(value) is type or _admitted_arguments((value,),self._attributes,self._emitter.recursion_fields) for value in dependencies)
        valid=valid and all((self.original.__globals__ if name in self.original.__globals__ else self.original.__builtins__) is namespace and namespace.get(name) is value for namespace,name,value in self._emitter.dependencies)
        current=self.original.__kwdefaults__
        valid=valid and (current is None or type(current) is dict and len(current)==len(self._keyword_values) and all(type(key) is str for key in current) and all(current.get(key) is value for key,value in self._keyword_values.items()))
        if valid:
            try:
                bound=self._signature.bind(*args,**kwargs);bound.apply_defaults();full=tuple(bound.arguments[name] for name in self._emitter.parameters)
            except TypeError:valid=False
            else:valid=_admitted_arguments(full,self._attributes,self._emitter.recursion_fields)
        if not valid:
            self.fallback_calls+=1;self.whole_function_fallback_calls+=1
            return self.original(*args,**kwargs)
        self.compiled_calls+=1
        errors=[None]
        result,ok=self._entry(self._pool,errors,*full)
        if not ok:
            if errors[0] is None:
                # This frontend has no external call/mutation sites before a
                # guard: only read-only protocols over proved inert owners.
                self.compiled_calls-=1
                self.fallback_calls+=1;self.whole_function_fallback_calls+=1
                self.problem='native recursive descent requires an owned list/tuple'
                return self.original(*args,**kwargs)
            raise errors.pop()
        return result

    def map(self,calls,backend='cpu'):return [self(*args) for args in calls]


def lift_managed(fn):
    """Compile managed control flow, using native visitors where proved safe."""
    try:return ManagedLifted(fn)
    except Unsupported as original:
        if type(fn) is not types.FunctionType:raise
        try:binding=provenance.bind_source(fn)
        except (ValueError,OSError,SyntaxError,TypeError):raise original from None
        # An original whole-helper self-call is not a substitute for proving
        # native recursion. Keep those declined rather than counting replay.
        for part in ast.walk(binding.node):
            if isinstance(part,ast.Call) and isinstance(part.func,ast.Name):
                name=part.func.id
                namespace=fn.__globals__ if name in fn.__globals__ else fn.__builtins__
                if namespace.get(name) is fn:raise original from None
        if any(isinstance(part,ast.FunctionDef) and part is not binding.node for part in ast.walk(binding.node)):
            from ._visitors import lift_visitors
            region=lift_visitors(fn)
            if region.run is not None:return region
        from ._functions import lift_functions
        region=lift_functions(fn)
        if region.run is None:raise Unsupported(region.problem) from None
        return region


def _managed_key(source):
    import hashlib
    from pathlib import Path
    digest=hashlib.sha256(source.encode())
    for name in ('managed.py','_managed_native.py','_managed_recursion.py','provenance.py'):
        digest.update(Path(__file__).with_name(name).read_bytes())
    return digest.hexdigest()


def build_managed_aot(fn, folder):
    """Build the same typed managed body; retain no application object in the artifact."""
    from pathlib import Path
    from ._pycc import CC
    lifted=ManagedLifted(fn)
    signature=next(iter(lifted._compiled.overloads.values())).signature
    identity=_managed_key(lifted.source)
    module='rcmanaged_'+identity[:24]
    folder=Path(folder).resolve();folder.mkdir(parents=True,exist_ok=True)
    cc=CC(module);cc.output_dir=str(folder)
    cc.export('entry',signature)(lifted._compiled.py_func)
    cc.compile()
    return {'module':module,'folder':str(folder),'digest':identity}


def load_managed_aot(fn, section):
    """Rebuild live source/dependency/owner bindings; use only an exact source match."""
    import importlib
    import sys
    emitter=_Emitter(fn)
    if _managed_key(emitter.source)!=section['digest']:
        raise Unsupported('managed AOT source or interface changed')
    added=section['folder'] not in sys.path
    if added:sys.path.insert(0,section['folder'])
    try:module=importlib.import_module(section['module'])
    finally:
        if added:sys.path.remove(section['folder'])
    return ManagedLifted(fn,compiled=module.entry)
