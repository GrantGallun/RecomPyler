"""Compile explicit caller/callee catalogues with source-lived native slots.

This experimental entry preserves managed CPython values and never replays an
entered body. Calls without the canonical source-activation proof, or that miss their
function/code/receiver guard, run the current
Python callable at that site; small admitted children inline by syntax size.
"""
import ast
import types as pytypes
from numba.core import types
from . import _managed_native as refs
from ._structures import _StructureCompiler
from ._call_bridge import CallRegion, UnsupportedCall, _CONTEXT_FUNCTIONS, _read_name
from ._managed_frames import native_activation_available
from ._structure_ops import (ops, same_object, callee_matches, context_matches,
    set_attribute, cached_load, cached_store, keep_alive, fast_getitem,
    fast_setitem, contains_value, compare_value,
    isinstance_builtin, isinstance_value, method_kind, method_value, sequence_matches, unpack_sequence)

class ChainCompiler(_StructureCompiler):
    def __init__(self,fn,shared,child=False):
        if ops is None:
            raise UnsupportedCall('native structure operations require a matching optional extension')
        super().__init__(fn)
        if any(isinstance(n,(ast.Try,ast.ListComp,ast.SetComp,ast.DictComp,ast.GeneratorExp,ast.FunctionDef,ast.Lambda)) for statement in self.node.body for n in ast.walk(statement)):
            raise UnsupportedCall('native slot chain requires ordinary nonsuspended local scope')
        if fn.__code__.co_flags&12 or fn.__code__.co_kwonlyargcount:
            raise UnsupportedCall('native slot chain requires fixed positional parameters')
        self.shared=shared;self.pool=shared['pool'];self.child=child;self.dependencies=set()
        self.slots={name:'_l'+str(i) for i,name in enumerate(sorted(self.locals))}
        self.flags={name:'_b'+str(i) for i,name in enumerate(sorted(self.locals))}
        self.params=[a.arg for a in self.node.args.posonlyargs+self.node.args.args]
        self.local_order=[name for name in fn.__code__.co_varnames if name in self.locals]
        self.live_slots=[]
        self.intrinsics.update(_same_object=same_object,_callee_matches=callee_matches,_context_matches=context_matches,_set_attribute=set_attribute,_cached_load=cached_load,_cached_store=cached_store,_keep_alive=keep_alive,_getitem_object=fast_getitem,_set_item=fast_setitem,_contains_value=contains_value,_compare_value=compare_value,_isinstance_builtin=isinstance_builtin,_isinstance_value=isinstance_value,_method_kind=method_kind,_method_value=method_value,_sequence_matches=sequence_matches,_unpack_sequence=unpack_sequence)

    def set_call_counter_layout(self,layout):
        super().set_call_counter_layout(layout)
        for compiler in self.shared['functions'].values():
            compiler.call_counter_layout=layout

    def line(self,text):
        if text.startswith('return ') and self.live_slots:
            # CPython clears localsplus backwards. Separate last-use sites make
            # NRT release each source slot in that same order, rather than
            # choosing an arbitrary order for one aggregate final use.
            for slot in reversed(self.live_slots):
                super().line('_keep_alive(('+slot+',))')
        super().line(text)

    def cache_address(self):
        cache=ops.new_cache();self.pool.append(cache)
        return str(ops.address(cache))

    def operation(self,name,*args):
        if name=='_getattr_object':
            from ._call_kinds import named_kind
            result=super().operation('_cached_load',*args,self.cache_address())
            attribute=self._constant_strings.get(args[1])
            if attribute is not None:self.register_call_kind(result,named_kind(attribute,method=True))
            return result
        return super().operation(name,*args)

    def effect(self,name,*args):
        ok=self.fresh();self.line(ok+' = '+name+'('+', '.join(args)+')')
        self.line('if not '+ok+':');self.indent+=1
        self.line('_capture_error(_errors)');self.line('return _errors, False');self.indent-=1

    def name(self,name):
        if name not in self.locals:
            from ._call_kinds import named_kind
            expected = self.fn.__globals__.get(name)
            if type(expected) is pytypes.FunctionType and expected in self.shared['functions']:
                result = self.operation('_read_global_owned', '_namespace', '_builtins',
                                        self.constant(name), self.pooled(expected))
            else:
                result=self.operation('_read_name_native','_namespace','_namespace','_builtins',self.constant(name),'False')
            return self.register_call_kind(result,named_kind(name))
        value=self.slots[name]
        self.line('if not '+self.flags[name]+':');self.indent+=1
        frame=self.operation('_dict_object')
        self.operation('_read_name_native',frame,'_namespace','_builtins',self.constant(name),'True')
        self.indent-=1
        result=self.fresh();self.line(result+' = '+value)
        return result

    def assign(self,target,value):
        if isinstance(target,(ast.Tuple,ast.List)) and not any(isinstance(item,ast.Starred) for item in target.elts):
            from ._structures import _unpacker
            selected=self.fresh();self.line(selected+' = _sequence_matches('+value+', '+str(len(target.elts))+')')
            unpacked=self.fresh();self.line('if '+selected+':');self.indent+=1
            actual=self.operation('_unpack_sequence',value);self.line(unpacked+' = '+actual);self.indent-=1
            self.line('else:');self.indent+=1
            actual=self.runtime_call(self.pooled(_unpacker(len(target.elts))),[value])
            self.line(unpacked+' = '+actual);self.indent-=1
            # Consume the temporary container before target callbacks execute.
            parts=[self.operation('_getitem_object',unpacked,self.pooled(index))
                   for index in range(len(target.elts))]
            for item,part in zip(target.elts,parts):
                self.assign(item,part)
            return
        if isinstance(target,ast.Name):
            self.line(self.slots[target.id]+' = '+value);self.line(self.flags[target.id]+' = True')
            if not self.child:
                # The Python carrier owns this original-order Frame through
                # escaped callback/child tracebacks after native SSA is gone.
                self.effect('_store_name_native','_root_frame',self.constant(target.id),value)
            return
        if isinstance(target,ast.Attribute):
            owner=self.expression(target.value);self.effect('_cached_store',owner,self.constant(target.attr),value,self.cache_address());return
        if isinstance(target,ast.Subscript):
            owner=self.expression(target.value);key=self.expression(target.slice);self.effect('_set_item',owner,key,value);return
        return super().assign(target,value)

    def condition(self,node):
        if isinstance(node,ast.Compare) and len(node.ops)==1 and isinstance(node.ops[0],(ast.Is,ast.IsNot)):
            left=self.expression(node.left);right=self.expression(node.comparators[0]);answer=self.fresh()
            self.line(answer+' = _same_object('+left+', '+right+')')
            if isinstance(node.ops[0],ast.IsNot):self.line(answer+' = not '+answer)
            return answer
        return super().condition(node)

    def compare_value(self,op,left,right):
        if isinstance(op,(ast.In,ast.NotIn)):
            return self.operation('_contains_value',right,left,'True' if isinstance(op,ast.NotIn) else 'False')
        number={ast.Lt:0,ast.LtE:1,ast.Eq:2,ast.NotEq:3,ast.Gt:4,ast.GtE:5}.get(type(op))
        if number is not None:return self.operation('_compare_value',left,right,str(number))
        return super().compare_value(op,left,right)

    def snapshot(self):
        frame=self.operation('_dict_object')
        for name in self.local_order:
            self.line('if '+self.flags[name]+':');self.indent+=1
            self.effect('_set_item',frame,self.constant(name),self.slots[name]);self.indent-=1
        return frame

    def runtime_call(self,callee,args,keywords=(),counted=False):
        if not counted:return super().runtime_call(callee,args,keywords,counted=False)
        if len(args)==2 and not keywords:
            selected=self.fresh()
            self.line(selected+' = _isinstance_builtin('+callee+')')
            result=self.fresh();self.line('if '+selected+':');self.indent+=1
            actual=self.operation('_isinstance_value',*args,self.pooled(True),self.pooled(False))
            self.line(result+' = '+actual);self.indent-=1
            self.line('else:');self.indent+=1
            actual=self.method_runtime_call(callee,args,keywords)
            self.line(result+' = '+actual);self.indent-=1
            return result
        return self.method_runtime_call(callee,args,keywords)

    def method_runtime_call(self,callee,args,keywords=()):
        if keywords or len(args) not in (1,2):return self.context_runtime_call(callee,args,keywords)
        kind=self.fresh();self.line(kind+' = _method_kind('+callee+')')
        selected=self.fresh();condition=kind+' > 0' if len(args)==1 else kind+' == 3'
        self.line(selected+' = '+condition)
        result=self.fresh();self.line('if '+selected+':');self.indent+=1
        second=args[1] if len(args)==2 else self.pooled(None)
        actual=self.operation('_method_value',callee,args[0],second,kind)
        self.line(result+' = '+actual);self.indent-=1
        self.line('else:');self.indent+=1
        actual=self.context_runtime_call(callee,args,keywords)
        self.line(result+' = '+actual);self.indent-=1
        return result

    def context_runtime_call(self,callee,args,keywords=()):
        selected=self.fresh();self.line(selected+' = _context_matches('+callee+', '+self.pooled(_CONTEXT_FUNCTIONS)+')')
        result=self.fresh();self.line('if '+selected+':');self.indent+=1
        frame=self.snapshot();self.line('_frame = '+frame)
        actual=super().runtime_call(callee,args,keywords,counted=True);self.line(result+' = '+actual);self.indent-=1
        self.line('else:');self.indent+=1
        actual=super().runtime_call_direct(callee,args,keywords,counted=True);self.line(result+' = '+actual);self.indent-=1
        return result

    def expression(self,node):
        if not isinstance(node,ast.Call):return super().expression(node)
        if any(isinstance(a,ast.Starred) for a in node.args) or any(k.arg is None for k in node.keywords):
            raise UnsupportedCall('expanded native chain calls require argument lowering')
        owner=None
        if isinstance(node.func,ast.Attribute):
            owner=self.expression(node.func.value)
            callee=self.operation('_getattr_object',owner,self.constant(node.func.attr))
            candidates=[fn for fn in self.shared['functions'] if fn.__name__==node.func.attr and fn is not self.fn]
        else:
            expected=self.fn.__globals__.get(node.func.id) if isinstance(node.func,ast.Name) and node.func.id not in self.locals else None
            candidates=[expected] if type(expected) is pytypes.FunctionType and expected in self.shared['functions'] and expected is not self.fn else []
            if candidates:
                callee=self.operation('_read_global_owned','_namespace','_builtins',self.constant(node.func.id),self.pooled(expected))
            else:
                callee=self.expression(node.func)
        args=[self.expression(a) for a in node.args]
        keywords=[(self.constant(k.arg),self.expression(k.value)) for k in node.keywords]
        # A catalogue/code match does not establish an observable CPython frame.
        # Refuse unproved source activations before entering their body; the
        # current callable still executes once at this site with the parent native.
        candidates=[(f, owner is not None and len(args)+1==len(self.shared['functions'][f].params)) for f in candidates if native_activation_available(f) and not keywords and len(self.shared['functions'][f].params) in ((len(args),len(args)+1) if owner is not None else (len(args),))]
        if not candidates:return self.runtime_call(callee,args,keywords,counted=True)
        result=self.fresh()
        for index,(fn,bound) in enumerate(candidates):
            compiler=self.shared['functions'][fn];symbol=self.shared['symbols'][fn]
            expected=self.pooled(fn);saved=self.pooled(self.shared['codes'][fn]);receiver=owner or self.pooled(None)
            matched=self.fresh();self.line(matched+' = _callee_matches('+', '.join([callee,expected,saved,receiver,'True' if bound else 'False'])+')')
            self.line('if '+matched+':');self.indent+=1;self.line('_counts[1] += 1')
            namespace=self.pooled(fn.__globals__);builtins=self.pooled(fn.__builtins__)
            actual=[owner]+args if bound else args
            self.line(result+', _ok = '+symbol+'('+', '.join(['_pool',namespace,builtins,'_errors','_counts']+actual)+')')
            self.line('if not _ok:');self.indent+=1;self.line('return '+result+', False');self.indent-=1
            self.indent-=1;self.line('else:');self.indent+=1;self.dependencies.add(fn)
        actual=self.runtime_call(callee,args,keywords,counted=True);self.line(result+' = '+actual)
        self.indent-=len(candidates)
        return result

    def generate(self):
        if not self.child:self.line('_root_frame = _frame')
        none=self.pooled(None)
        for name in self.local_order:
            self.line(self.slots[name]+' = '+none);self.line(self.flags[name]+' = False');self.live_slots.append(self.slots[name])
        for index,name in enumerate(self.params):
            value='_a'+str(index) if self.child else self.operation('_getitem_object','_frame',self.constant(name))
            self.line(self.slots[name]+' = '+value);self.line(self.flags[name]+' = True')
        body=self.node.body
        if body and isinstance(body[0],ast.Expr) and isinstance(body[0].value,ast.Constant) and isinstance(body[0].value.value,str):body=body[1:]
        self.statements(body);self.line('return '+self.pooled(None)+', True')
        if self.child:
            signature=['_pool','_namespace','_builtins','_errors','_counts']+['_a'+str(i) for i in range(len(self.params))]
            symbol=self.shared['symbols'][self.fn]
        else:signature=['_pool','_frame','_namespace','_builtins','_errors','_counts'];symbol='_run'
        return 'def '+symbol+'('+', '.join(signature)+'):\n'+'\n'.join(self.lines)+'\n'

    def compile(self):
        from numba import njit
        array=types.Array(types.int64,1,'C');parts=[]
        for compiler in self.shared['functions'].values():parts.append(compiler.generate())
        parts.append(self.generate());source='\n'.join(parts);namespace=self.native_namespace()
        exec(compile(source,'<recompyler native structure chain>','exec'),namespace)
        done=set();active=set();dispatchers=[]
        def build(fn):
            if fn in done:return
            if fn in active:raise UnsupportedCall('native chain recursion needs a progress proof')
            active.add(fn);compiler=self.shared['functions'][fn]
            for dependency in compiler.dependencies:build(dependency)
            symbol=self.shared['symbols'][fn]
            signature=(refs.managed,)*4+(array,)+(refs.managed,)*len(compiler.params)
            inline='always' if sum(1 for _ in ast.walk(compiler.node))<=64 else 'never'
            dispatcher=njit(namespace[symbol],inline=inline);dispatcher.compile(signature);namespace[symbol]=dispatcher;dispatchers.append(dispatcher)
            active.remove(fn);done.add(fn)
        for fn in self.dependencies:build(fn)
        run=njit(namespace['_run']);signature=(refs.managed,)*5+(array,);run.compile(signature)
        self.dispatchers=dispatchers+[run]
        return self.root_entry(run,signature),tuple(self.pool),source

class ChainRegion(CallRegion):
    counter_slots=2
    def __init__(self,fn,callees=(),*,call_kinds=False):
        self.native_helper_calls=0;self.catalogue=tuple(callees);self.compiler=None
        super().__init__(fn,call_kinds=call_kinds)
    def make_compiler(self,fn):
        if any(type(child) is not pytypes.FunctionType for child in self.catalogue):
            raise UnsupportedCall('native callees must be plain Python functions')
        shared={'pool':[],'functions':{},'symbols':{},'codes':{f:f.__code__ for f in self.catalogue}}
        for index,child in enumerate(self.catalogue):
            shared['symbols'][child]='_helper'+str(index);shared['functions'][child]=ChainCompiler(child,shared,True)
        self.compiler=ChainCompiler(fn,shared);return self.compiler
    def record_counters(self,counts):
        super().record_counters(counts);self.native_helper_calls+=int(counts[1])
