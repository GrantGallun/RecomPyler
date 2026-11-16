"""Nonescaping local visitors compiled through the shared managed frontend."""
import ast
import builtins
import types
from . import provenance
from ._call_bridge import CallRegion, UnsupportedCall
from ._structures import _StructureCompiler
from ._managed_cells import CellAccess,raise_unbound_local
from ._managed_recursion import recursive_descent, recursion_budget_clear
from ._text_owners import observers_clear
from .managed import _admitted_arguments

_AST = ast.AST
_AST_NAME = ast.Name
_ITER_CHILDREN = ast.iter_child_nodes
_ITER_FIELDS = ast.iter_fields
_ITER_CODES = (_ITER_CHILDREN.__code__, _ITER_FIELDS.__code__)
_AST_CLASSES = frozenset(value for value in vars(ast).values()
    if type(value) is type and _AST in type.__dict__['__mro__'].__get__(value))
_AST_FIELDS = {kind: vars(kind).get('_fields', ()) for kind in _AST_CLASSES}
_AST_DICT = vars(_AST)['__dict__']
_AST_GETATTRIBUTE = vars(_AST)['__getattribute__']
_FIELD_NAMES = {'_fields', '__class__'} | {name for names in _AST_FIELDS.values()
    if type(names) is tuple for name in names if type(name) is str}
_MISSING = object()


def _ast_hash_clear(classes):
    # Compiler metadata uses AST instances as dictionary keys. Application
    # equality/hash hooks must not execute during source analysis or invalidate
    # the later read-only traversal proof.
    for kind in classes:
        for base in type.__dict__['__mro__'].__get__(kind):
            if base is object:continue
            namespace=vars(base)
            for name in ('__hash__','__eq__','__ne__'):
                if name in namespace and namespace[name] is not vars(object).get(name,_MISSING):return False
    return True


def _activation(names, values):
    return dict(zip(names, values))


def _read_free(frame, name):
    if name not in frame:
        raise NameError(f"cannot access free variable '{name}' where it is not associated with a value in enclosing scope", name=name)
    return frame[name]


def _ast_graph(values, physical_fields=(), attributes=()):
    """Only bounded inert syntax trees enter structural native recursion."""
    if not _admitted_arguments(values, _FIELD_NAMES|set(attributes),physical_fields):return False
    pending=list(values);seen=set();budget=4096
    while pending:
        value=pending.pop();budget-=1
        if budget<0:return False
        cls=type(value)
        if type(cls) is not type:return False
        if cls in (str,bytes,int,float,complex,bool,type(None)):continue
        if id(value) in seen:continue
        seen.add(id(value))
        if cls in (list,tuple):pending.extend(value);continue
        if cls not in _AST_CLASSES or not _ast_hash_clear((cls,)):return False
        if vars(cls).get('_fields', ()) is not _AST_FIELDS[cls]:return False
        data=_AST_DICT.__get__(value,cls)
        if '_fields' in data:return False
        if cls is _AST_NAME and 'id' in data and type(data['id']) is not str:return False
        pending.extend(data.values())
    return True


class _VisitorCompiler(CellAccess,_StructureCompiler):
    allow_closure_cells = True

    def __init__(self, fn, root=None):
        if not _ast_hash_clear(_AST_CLASSES):raise UnsupportedCall('custom AST hash/equality needs interpreter source analysis')
        super().__init__(fn)
        self.live_slots=[]
        extra_names=list(fn.__code__.co_cellvars)+list(fn.__code__.co_freevars)
        self.names += extra_names
        self.constants += extra_names
        self.parameters = list(fn.__code__.co_varnames[:fn.__code__.co_argcount+fn.__code__.co_kwonlyargcount+bool(fn.__code__.co_flags & 4)])
        self.root = self if root is None else root
        self.is_child = root is not None
        self.dependencies=set()
        if self.is_child:
            self.pool=root.pool
            self.free_names=set(fn.__code__.co_freevars)-set(root.definitions)
            # Carry the shared cells needed by transitive helper calls as well.
            cells=tuple(name for name in root.fn.__code__.co_cellvars if name not in root.definitions)
            self.configure_cells(cells,self.free_names)
            self.configure_locals()
            return
        if fn.__closure__:raise UnsupportedCall('external closure cells are not yet supported by native visitors')
        definitions=[part for part in self.node.body if isinstance(part,ast.FunctionDef)]
        all_definitions=[part for part in ast.walk(self.node) if isinstance(part,ast.FunctionDef) and part is not self.node]
        if not definitions or len(definitions)!=len(all_definitions) or len({part.name for part in definitions})!=len(definitions):
            raise UnsupportedCall('native visitors require distinct statically nonescaping top-level helpers')
        self.definitions={part.name:part for part in definitions}
        self.children={}
        self.symbols={name:'_helper'+str(index) for index,name in enumerate(self.definitions)}
        parents={child:parent for parent in ast.walk(self.node) for child in ast.iter_child_nodes(parent)}
        root_nodes=set(self._scope_nodes(self.node))
        for definition in definitions:
            args=definition.args
            if definition.returns is not None or any(arg.annotation is not None for arg in args.posonlyargs+args.args+args.kwonlyargs):raise UnsupportedCall('local visitor annotations require function creation')
            if definition.decorator_list or args.defaults or any(value is not None for value in args.kw_defaults) or args.vararg or args.kwarg or args.kwonlyargs or getattr(definition,'type_params',()):
                raise UnsupportedCall('local visitor decorators/defaults/variadics require function creation')
            if any(arg.arg in self.definitions for arg in args.posonlyargs+args.args):raise UnsupportedCall('local helper binding is shadowed')
        for part in ast.walk(self.node):
            if isinstance(part,ast.Name) and part.id in self.definitions:
                parent=parents.get(part)
                if not isinstance(part.ctx,ast.Load) or not isinstance(parent,ast.Call) or parent.func is not part:
                    raise UnsupportedCall('local helpers must be statically nonescaping and unrebound')
                if part in root_nodes and part.lineno<=max(definition.end_lineno for definition in definitions):
                    raise UnsupportedCall('root helper calls must follow all helper definitions')
        for name in self.definitions:
            matches=[code for code in fn.__code__.co_consts if type(code) is types.CodeType and code.co_name==name]
            if len(matches)!=1:raise UnsupportedCall('original local helper code is not unique')
            code=matches[0]
            child_fn=types.FunctionType(code,fn.__globals__,closure=tuple(types.CellType(None) for _ in code.co_freevars) or None)
            if child_fn.__builtins__ is not fn.__builtins__:raise UnsupportedCall('nested builtin context requires interpreter fallback')
            self.children[name]=_VisitorCompiler(child_fn,self)
        self._guards=[];self.value_guards=[]
        self._builtin_binding=fn.__globals__.get('__builtins__',_MISSING)
        self.recursive=False;self.guard_fields=set()
        for name,child in self.children.items():
            proof=recursive_descent(child.node,child.parameters,
                lambda target:isinstance(target,ast.Name) and target.id==name,
                lambda target:self._iterator_call(target,child))
            if proof is None:raise UnsupportedCall('native visitor recursive progress is not proved')
            if proof[1]:
                if len(self.children)!=1:raise UnsupportedCall('recursive helper catalogues require a joint progress proof')
                self.recursive=True
                root_proof=recursive_descent(self.node,self.parameters,
                    lambda target:isinstance(target,ast.Name) and target.id==name,
                    lambda target:self._iterator_call(target,self),root_calls=True)
                if root_proof is None:raise UnsupportedCall('recursive visitor root arguments are not proved in the admitted graph')
                self.guard_fields.update(root_proof[0])
            self.guard_fields.update(proof[0])
        self._prove_calls()
        self.configure_cells(fn.__code__.co_cellvars)
        self.configure_locals()

    def set_call_counter_layout(self,layout):
        super().set_call_counter_layout(layout)
        for child in getattr(self,'children',{}).values():child.set_call_counter_layout(layout)

    def configure_locals(self):
        self.local_names=tuple(name for name in self.fn.__code__.co_varnames if name in self.locals and name not in self.fn.__code__.co_cellvars)
        self.local_slots={name:'_native_local'+str(index) for index,name in enumerate(self.local_names)}
        self.local_flags={name:'_native_bound'+str(index) for index,name in enumerate(self.local_names)}
        self.argument_slots={name:'_argument'+str(index) for index,name in enumerate(self.parameters)}
        from . import _managed_native as refs
        from ._structure_ops import keep_alive,ops,method_kind,method_value
        self.intrinsics.update(_isinstance_object=refs.isinstance_object,_bool_object=refs.bool_object,_keep_alive=keep_alive,_concat_object=refs.concat_object)
        if ops is not None:self.intrinsics.update(_method_kind=method_kind,_method_value=method_value)
        self.live_slots=[self.local_slots[name] for name in self.local_names]

    def line(self,text):
        if text.startswith('return '):
            for slot in reversed(self.live_slots):super().line('_keep_alive(('+slot+',))')
        super().line(text)

    def local_prefix(self,lines):
        saved=self.lines,self.indent,self.live_slots
        self.lines=[];self.indent=1;self.live_slots=[]
        try:
            for name in self.local_names:
                if name in self.parameters:
                    value=self.argument_slots[name] if self.is_child else self.operation('_getitem_object','_source_data',self.pooled(name))
                    bound='True'
                else:value='_pool';bound='False'
                self.line(self.local_slots[name]+' = '+value)
                self.line(self.local_flags[name]+' = '+bound)
                self.live_slots.append(self.local_slots[name])
            return self.lines+lines
        finally:self.lines,self.indent,self.live_slots=saved

    def _safe_class_arg(self,node,scope):
        if isinstance(node,ast.Tuple):return all(self._safe_class_arg(item,scope) for item in node.elts)
        if isinstance(node,ast.Name):
            if node.id in scope.locals or node.id in scope.fn.__code__.co_freevars:return False
            return type(self._resolve(node.id)) is type
        if isinstance(node,ast.Attribute) and isinstance(node.value,ast.Name):
            if node.value.id in scope.locals or node.value.id in scope.fn.__code__.co_freevars:return False
            module=self._resolve(node.value.id)
            if module is not ast:return False
            value=vars(ast).get(node.attr,_MISSING)
            self._guards.append((vars(ast),node.attr,value))
            return type(value) is type
        return False

    def _resolve(self, name):
        namespace=self.fn.__globals__ if name in self.fn.__globals__ else self.fn.__builtins__
        if name not in namespace:raise UnsupportedCall('visitor binding is absent: '+name)
        value=namespace[name]
        self._guards.append((namespace,name,value))
        return value

    def _iterator_call(self, target, scope=None):
        scope=scope or self
        if not isinstance(target,ast.Attribute) or target.attr!='iter_child_nodes' or not isinstance(target.value,ast.Name):return False
        if target.value.id in scope.locals or target.value.id in scope.fn.__code__.co_freevars:return False
        namespace=self.fn.__globals__ if target.value.id in self.fn.__globals__ else self.fn.__builtins__
        return namespace.get(target.value.id) is ast

    @staticmethod
    def _scope_nodes(node):
        pending=list(reversed(node.body))
        while pending:
            part=pending.pop()
            yield part
            if isinstance(part,(ast.FunctionDef,ast.ClassDef,ast.Lambda)):continue
            pending.extend(reversed(list(ast.iter_child_nodes(part))))

    def _prove_calls(self):
        scopes=(self,*self.children.values())
        builders={}
        for scope in scopes:
            owned=set();unknown=set()
            for part in self._scope_nodes(scope.node):
                if isinstance(part,ast.For):
                    for target in ast.walk(part.target):
                        if isinstance(target,ast.Name):unknown.add(target.id);owned.discard(target.id)
                if isinstance(part,ast.Assign):
                    safe=isinstance(part.value,ast.List) and all(isinstance(item,ast.Constant) for item in part.value.elts)
                    if isinstance(part.value,ast.Call) and isinstance(part.value.func,ast.Name) and not part.value.args and not part.value.keywords:
                        name=part.value.func.id
                        if name in scope.locals or name in scope.fn.__code__.co_freevars:
                            safe=False
                        else:
                            value=self._resolve(name)
                            safe=value is set or value is list
                    for target in part.targets:
                        if not isinstance(target,ast.Name):raise UnsupportedCall('native visitor cannot mutate the input graph')
                        if safe and target.id not in unknown:owned.add(target.id)
                        else:unknown.add(target.id);owned.discard(target.id)
                if isinstance(part,ast.AugAssign) and (self.recursive or not isinstance(part.target,ast.Name)):
                    raise UnsupportedCall('recursive visitor cannot mutate its admitted graph')
                if isinstance(part,(ast.Delete,ast.Global,ast.Nonlocal,ast.With,ast.Try)):
                    raise UnsupportedCall('visitor effects need an explicit continuation')
            builders[scope]=owned
        for scope in scopes:
            owned=builders[scope] | (builders[self] & scope.free_names if scope.is_child else set())
            for part in self._scope_nodes(scope.node):
                if isinstance(part,ast.Call):
                    target=part.func
                    if isinstance(target,ast.Name):
                        if target.id in self.definitions:continue
                        if target.id in scope.locals or target.id in scope.fn.__code__.co_freevars:
                            raise UnsupportedCall('visitor callee binding is shadowed')
                        value=self._resolve(target.id)
                        if value is builtins.isinstance and len(part.args)==2 and not part.keywords and not self._safe_class_arg(part.args[1],scope):raise UnsupportedCall('native visitor class protocol can invoke callbacks')
                        if not any(value is allowed for allowed in (builtins.isinstance,set,list)):
                            raise UnsupportedCall('recursive visitor call is not proved read-only')
                    elif isinstance(target,ast.Attribute) and isinstance(target.value,ast.Name):
                        if target.value.id in owned and target.attr in ('add','append'):continue
                        if self._iterator_call(target,scope):
                            module=self._resolve(target.value.id)
                            self._guards.append((vars(module),target.attr,_ITER_CHILDREN));continue
                        raise UnsupportedCall('recursive visitor capture/method binding is not proved')
                    else:raise UnsupportedCall('visitor callee requires general function creation')
                if isinstance(part,ast.Attribute) and isinstance(part.value,ast.Name):
                    if part.value.id in scope.locals or part.value.id in scope.fn.__code__.co_freevars:continue
                    namespace=self.fn.__globals__ if part.value.id in self.fn.__globals__ else self.fn.__builtins__
                    if namespace.get(part.value.id) is ast:
                        self._resolve(part.value.id)
                        value=vars(ast).get(part.attr,_MISSING)
                        if part.attr!='iter_child_nodes' and type(value) is not type:
                            raise UnsupportedCall('visitor AST dependency is not a class')
                        self._guards.append((vars(ast),part.attr,value))

        for scope in scopes:
            for part in self._scope_nodes(scope.node):
                if isinstance(part,ast.Attribute) and isinstance(part.value,ast.Name):
                    name=part.value.id
                    if name not in scope.locals and name not in scope.fn.__code__.co_freevars:
                        namespace=self.fn.__globals__ if name in self.fn.__globals__ else self.fn.__builtins__
                        if namespace.get(name,_MISSING) is not ast:
                            raise UnsupportedCall('native global attribute protocol is not proved inert')
                if not isinstance(part,ast.Name) or not isinstance(part.ctx,ast.Load):continue
                name=part.id
                if name in self.definitions or name in scope.locals or name in scope.fn.__code__.co_freevars:continue
                namespace=self.fn.__globals__ if name in self.fn.__globals__ else self.fn.__builtins__
                value=namespace.get(name,_MISSING)
                if any(value is allowed for allowed in (ast,builtins.isinstance,set,list)):continue
                if type(value) is type and any(owner is namespace and key==name and selected is value for owner,key,selected in self._guards):continue
                if not _ast_graph((value,),self.guard_fields):raise UnsupportedCall('native global value may invoke an unproved callback')
                if name not in self.value_guards:self.value_guards.append(name)

    def runtime_call(self,callee,args,keywords=(),counted=False):
        if not counted or keywords or len(args) not in (1,2) or '_method_kind' not in self.intrinsics:
            return super().runtime_call(callee,args,keywords,counted=counted)
        kind=self.fresh();self.line(kind+' = _method_kind('+callee+')')
        condition=kind+' > 0' if len(args)==1 else kind+' == 3'
        result=self.fresh();self.line('if '+condition+':');self.indent+=1
        actual=self.operation('_method_value',callee,args[0],args[1] if len(args)==2 else self.pooled(None),kind)
        self.line(result+' = '+actual);self.indent-=1
        self.line('else:');self.indent+=1
        actual=super().runtime_call(callee,args,keywords,counted=True)
        self.line(result+' = '+actual);self.indent-=1
        return result

    def name(self, name):
        if name in self.local_slots:
            self.line('if not '+self.local_flags[name]+':')
            self.indent+=1
            self.runtime_call(self.pooled(raise_unbound_local),[self.pooled(name)])
            self.indent-=1
            return self.local_slots[name]
        if name in self.cell_slots:return self.read_cell(name)
        namespace=self.fn.__globals__ if name in self.fn.__globals__ else self.fn.__builtins__
        for guarded,key,value in self.root._guards:
            if guarded is namespace and key==name:return self.pooled(value)
        return super().name(name)

    def assign(self,target,value):
        if isinstance(target,ast.Name):
            if target.id in self.local_slots:
                if not self.is_child:
                    # One ordered source frame owns the locals and cells. SSA
                    # temporaries alone cannot order their relative cleanup.
                    self.line('_ok = _store_name_native(_source_data,'+self.pooled(target.id)+','+value+')')
                    self.line('if not _ok:');self.indent+=1
                    self.line('_capture_error(_errors)');self.line('return _errors,False');self.indent-=1
                self.line(self.local_slots[target.id]+' = '+value)
                self.line(self.local_flags[target.id]+' = True')
                return
            if target.id in self.cell_slots:return self.write_cell(target.id,value)
        return super().assign(target,value)

    def _builtin_isinstance(self,node):
        if not isinstance(node,ast.Call) or not isinstance(node.func,ast.Name) or len(node.args)!=2 or node.keywords:return False
        name=node.func.id
        if name in self.locals or name in self.fn.__code__.co_freevars:return False
        namespace=self.fn.__globals__ if name in self.fn.__globals__ else self.fn.__builtins__
        return namespace.get(name) is builtins.isinstance

    def condition(self,node):
        if self._builtin_isinstance(node):return self.operation('_isinstance_object',*[self.expression(arg) for arg in node.args])
        return super().condition(node)

    def expression(self, node):
        if isinstance(node,ast.BinOp) and isinstance(node.op,ast.Add):
            return self.operation('_concat_object',self.expression(node.left),self.expression(node.right))
        if isinstance(node,(ast.ListComp,ast.SetComp,ast.DictComp,ast.GeneratorExp)):
            raise UnsupportedCall('native visitor comprehension scope requires a separate native scope')
        if self._builtin_isinstance(node):
            return self.operation('_bool_object',self.operation('_isinstance_object',*[self.expression(arg) for arg in node.args]))
        if isinstance(node,ast.Attribute) and isinstance(node.value,ast.Name):
            name=node.value.id
            if name not in self.locals and name not in self.fn.__code__.co_freevars:
                namespace=self.fn.__globals__ if name in self.fn.__globals__ else self.fn.__builtins__
                if namespace.get(name) is ast:
                    for guarded,key,value in self.root._guards:
                        if guarded is vars(ast) and key==node.attr:return self.pooled(value)
        if isinstance(node,ast.Call) and isinstance(node.func,ast.Name) and node.func.id in self.root.children:
            child=self.root.children[node.func.id]
            self.dependencies.add(node.func.id)
            if any(isinstance(arg,ast.Starred) for arg in node.args) or any(key.arg is None for key in node.keywords):
                raise UnsupportedCall('expanded local visitor arguments are not supported')
            parameters=child.parameters
            if len(node.args)>len(parameters):raise UnsupportedCall('local visitor argument binding requires interpreter fallback')
            values={name:self.expression(arg) for name,arg in zip(parameters,node.args)}
            for key in node.keywords:
                if key.arg in parameters[:child.fn.__code__.co_posonlyargcount] or key.arg not in parameters or key.arg in values:raise UnsupportedCall('local visitor argument binding requires interpreter fallback')
                values[key.arg]=self.expression(key.value)
            if set(values)!=set(parameters):raise UnsupportedCall('local visitor arguments are incomplete')
            result=self.fresh()
            self.line('_counts[1] += 1')
            cells=[self.cell_slots[name] for name in child.cell_names]
            operands=['_pool','_frame','_namespace','_builtins','_errors','_counts']+[values[name] for name in parameters]+cells
            self.line(result+',_ok = '+self.root.symbols[node.func.id]+'('+','.join(operands)+')')
            self.line('if not _ok:')
            self.indent+=1;self.line('return _errors,False');self.indent-=1
            return result
        return super().expression(node)

    def statements(self, body):
        for statement in body:
            if isinstance(statement,ast.FunctionDef):
                if self.is_child or self.definitions.get(statement.name) is not statement:raise UnsupportedCall('additional local function scope is not supported')
                from ._managed_calls import function_object
                self.intrinsics['_function_object']=function_object
                code=self.children[statement.name].fn.__code__
                closure=self.operation('_tuple_object',*[self.cell_slots[name] for name in code.co_freevars]) if code.co_freevars else self.pooled(None)
                none=self.pooled(None)
                function=self.operation('_function_object',self.pooled(code),'_namespace',closure,none,none)
                self.assign(ast.Name(id=statement.name,ctx=ast.Store()),function)
            else:super().statements([statement])

    def compile(self):
        from numba import njit,types as ntypes
        from ._managed_native import managed
        parts=[]
        for name,child in self.children.items():
            child.statements(child.node.body)
            child.line('return '+child.pooled(None)+',True')
            child.lines=child.local_prefix(child.lines)
            helper_args=['_pool','_frame','_namespace','_builtins','_errors','_counts']+[child.argument_slots[param] for param in child.parameters]+[child.cell_slots[param] for param in child.cell_names]
            parts.append('def '+self.symbols[name]+'('+','.join(helper_args)+'):\n'+'\n'.join(child.lines)+'\n')
        self.statements(self.node.body)
        self.line('return '+self.pooled(None)+',True')
        self.lines=self.local_prefix(self.lines)
        live=self.live_slots;self.live_slots=[]
        try:
            self.lines=self.cell_prefix(self.lines)
            body=self.lines;self.lines=[]
            data=self.operation('_getattr_object','_frame',self.pooled('data'))
            self.line('_source_data = '+data)
            self.lines+=body
        finally:self.live_slots=live
        root_source='def _run(_pool,_frame,_namespace,_builtins,_errors,_counts):\n'+'\n'.join(self.lines)+'\n'
        source='\n'.join(parts+[root_source])
        namespace=self.native_namespace()
        exec(compile(source,'<recompyler native visitor>','exec'),namespace)
        array=ntypes.Array(ntypes.int64,1,'C')
        result_type=ntypes.Tuple((managed,ntypes.boolean))
        done=set();active=set();dispatchers=[]
        def build(name):
            if name in done:return
            if name in active:raise UnsupportedCall('native helper cycle requires a joint progress proof')
            active.add(name);child=self.children[name]
            for dependency in child.dependencies-{name}:build(dependency)
            symbol=self.symbols[name]
            signature=result_type(*([managed]*5+[array]+[managed]*(len(child.parameters)+len(child.cell_names))))
            dispatcher=njit(signature,inline='never' if self.recursive else 'always')(namespace[symbol]);namespace[symbol]=dispatcher
            dispatchers.append(dispatcher);active.remove(name);done.add(name)
        for name in self.children:build(name)
        root_signature=result_type(*([managed]*5+[array]))
        run=njit(root_signature)(namespace['_run'])
        self.helper_dispatchers=dispatchers
        return self.root_entry(run,root_signature.args),tuple(self.pool),source

    def entry_guard(self, passed):
        if self.recursive and not recursion_budget_clear():return False
        if not observers_clear((self.fn,*(child.fn for child in self.children.values()))):return False
        if not provenance._inert_namespaces(self.fn):return False
        if self.fn.__globals__.get('__builtins__',_MISSING) is not self._builtin_binding:return False
        for namespace,name,value in self._guards:
            if namespace.get(name,_MISSING) is not value:return False
            if namespace is self.fn.__builtins__ and name in self.fn.__globals__:return False
        if ast.iter_child_nodes is not _ITER_CHILDREN or ast.iter_fields is not _ITER_FIELDS:return False
        if (_ITER_CHILDREN.__code__,_ITER_FIELDS.__code__)!=_ITER_CODES:return False
        if _ITER_CHILDREN.__globals__.get('iter_fields') is not _ITER_FIELDS:return False
        for namespace in (_ITER_CHILDREN.__globals__,_ITER_FIELDS.__globals__):
            if any(type(key) is not str for key in namespace):return False
            for name,value in (('AST',_AST),('isinstance',builtins.isinstance),('list',list),('getattr',getattr),('AttributeError',AttributeError)):
                if namespace.get(name,self.fn.__builtins__.get(name,_MISSING)) is not value:return False
        if vars(_AST).get('__getattribute__') is not _AST_GETATTRIBUTE:return False
        for name in self.value_guards:
            namespace=self.fn.__globals__ if name in self.fn.__globals__ else self.fn.__builtins__
            if not _ast_graph((namespace.get(name,_MISSING),),self.guard_fields):return False
        return _ast_graph(passed,self.guard_fields,self.fn.__code__.co_names+tuple(name for child in self.children.values() for name in child.fn.__code__.co_names))


class VisitorRegion(CallRegion):
    compiler_type=_VisitorCompiler
    counter_slots=2

    def __init__(self,fn,*,call_kinds=False):
        self.native_helper_calls=0
        self.compiler=None
        super().__init__(fn,call_kinds=call_kinds)

    def make_compiler(self,fn):
        self.compiler=self.compiler_type(fn)
        return self.compiler

    def make_frame(self,passed):
        from ._functions import _Frame
        return _Frame(self.original,zip(self.entry.names,passed))

    def native_frame(self,owner):return owner

    def admit_entry(self,passed):
        return self.compiler.entry_guard(passed)

    def record_counters(self,counts):
        super().record_counters(counts)
        self.native_helper_calls+=int(counts[1])

    @property
    def whole_function_fallback_calls(self):return self.fallback_calls


def lift_visitors(fn,*,call_kinds=False):
    return VisitorRegion(fn,call_kinds=call_kinds)
