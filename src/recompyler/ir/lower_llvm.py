"""Common LLVM code generation over the shared bytecode SSA graph.

This module produces native code and keepalives, not semantic admission of
arbitrary arguments. Entry ownership, observer/resume and milestone gates must
pass before a public compile_function may expose a body for general use.
"""
import builtins
import dis
import inspect
import types
from llvmlite import ir,binding
from .builder import UnsupportedBytecode
from .verifier import verify
from dataclasses import dataclass
from .semantics import contract
from .symbols import CPythonSymbols
from .. import _source_frames_native as provider

SUPPORTED={'match_class','load_dict_or_globals','get_aiter','get_anext','get_awaitable','get_yield_from_iter','send','yield','list_append','set_add','list_extend','set_update','delete_attr','delete_subscr','map_add','load_build_class','frame.take','frame.delete','raise','reraise','unary','intrinsic_unary','intrinsic_binary','load_special','resume','nop','frame.borrow','frame.load','frame.load_check','frame.borrow_borrow',
           'frame.load_load','frame.store','frame.store_load','frame.store_store','load_attr','store_attr','store_subscr','contains','binary','branch','jump','return',
           'constant','small_int','null','is','pop','pop_iter','get_iter','for_iter','build_map','build_set','build_list',
           'cell.new','cell.copy_free','cell.get','cell.set','cell.delete',
           'build_slice','binary_slice','store_slice','build_tuple','make_function','set_function_attribute',
           'global.load','global.store','global.delete','dict_update','dict_merge','call_ex','call','call_kw','unpack','unpack_ex','load_super_attr','format_simple','format_spec','convert','build_string','common_constant','copy','swap','to_bool','compare','import_name','import_from'}
BINARY={8:'PyNumber_Power',21:'PyNumber_InPlacePower',0:'PyNumber_Add',1:'PyNumber_And',2:'PyNumber_FloorDivide',3:'PyNumber_Lshift',
        4:'PyNumber_MatrixMultiply',5:'PyNumber_Multiply',6:'PyNumber_Remainder',7:'PyNumber_Or',
        9:'PyNumber_Rshift',10:'PyNumber_Subtract',11:'PyNumber_TrueDivide',12:'PyNumber_Xor',
        13:'PyNumber_InPlaceAdd',14:'PyNumber_InPlaceAnd',15:'PyNumber_InPlaceFloorDivide',
        16:'PyNumber_InPlaceLshift',17:'PyNumber_InPlaceMatrixMultiply',18:'PyNumber_InPlaceMultiply',
        19:'PyNumber_InPlaceRemainder',20:'PyNumber_InPlaceOr',22:'PyNumber_InPlaceRshift',
        23:'PyNumber_InPlaceSubtract',24:'PyNumber_InPlaceTrueDivide',25:'PyNumber_InPlaceXor',
        26:'PyObject_GetItem'}


@dataclass(frozen=True)
class ExecutionOwner:
    """Executable resources only; installed original functions own source life."""
    module: object
    native_module: object
    engine: object
    body_address: int
    providers: tuple
    abi: str
    entry_offset: int
    cold_address: int = 0
    cold_state: object = None
    cold_plans: tuple = ()
    optimization_level: int = 3
    compile_options: tuple = ()

    @property
    def keepalive(self):
        return (self,)


@dataclass
class LoweredFunction:
    graph: object
    module: object
    native_module: object
    engine: object
    body_address: int
    providers: tuple
    abi: str = "vectorcall"
    entry_offset: int = 0
    execution_providers: tuple = ()
    reference_plan: object = None
    refcount_stats: dict | None = None
    optimization_level: int = 3
    compile_options: tuple = ()

    @property
    def keepalive(self):
        return (self,)

    @property
    def execution_owner(self):
        return ExecutionOwner(self.module,self.native_module,self.engine,
                              self.body_address,self.execution_providers,
                              self.abi,self.entry_offset,optimization_level=self.optimization_level,
                              compile_options=self.compile_options)



@dataclass
class EmittedFunction:
    """Parent-owned IR and resources; no executable address exists yet."""
    graph: object
    module: object
    providers: tuple
    execution_providers: tuple
    abi: str
    entry_offset: int
    reference_plan: object
    refcount_stats: dict
    compile_options: tuple


def _link_emitted(emitted,result):
    from .region_workers import NativeObject,request
    item=request(emitted.module)
    if (type(result) is not NativeObject or result.digest!=item.digest
            or result.triple!=item.triple or result.optimization_level!=3 or not result.data):
        raise ValueError('region object identity mismatch')
    symbols=emitted.providers[1]
    externals=[value.name for value in emitted.module.global_values
               if ((isinstance(value,ir.Function) and value.is_declaration)
                   or (isinstance(value,ir.GlobalVariable) and value.initializer is None))
               and not value.name.startswith('llvm.')]
    symbols.install(externals)
    target=binding.Target.from_default_triple().create_target_machine(opt=0)
    engine=binding.create_mcjit_compiler(binding.parse_assembly(''),target)
    obj=binding.ObjectFileRef.from_data(result.data)
    engine.add_object_file(obj);engine.finalize_object()
    address=engine.get_function_address('body')
    if not address:raise RuntimeError('region object has no body')
    resources=(obj,result)
    return LoweredFunction(emitted.graph,emitted.module,None,engine,address,
        emitted.providers+resources,emitted.abi,emitted.entry_offset,
        emitted.execution_providers+resources,emitted.reference_plan,emitted.refcount_stats,
        compile_options=emitted.compile_options)


def lower(graph,*,structure_calls=None,readonly_loops=False,frame_entry=False,entry_offset=None,owned_readonly_loops=False,inline_returns=False,inline_counter_address=0,refcounts=True,builtin_calls=False,constant_words=True,native_calls=None,frameless=False,frameless_deopt=None,allow_async_resume=False,numeric_ops=None,outline_frame_paths=True,library_calls=None,_region=None,_region_targets=None,_region_context=None,_emit_only=False):
    """Generate code; callers separately establish semantic entry admission."""
    if type(_emit_only) is not bool or (_emit_only and _region is None):
        raise UnsupportedBytecode('emit-only lowering requires a bounded region')
    if type(outline_frame_paths) is not bool:raise TypeError('outline_frame_paths must be a bool')
    if type(frameless) is not bool:raise TypeError('frameless must be a bool')
    if frameless and (frame_entry or owned_readonly_loops):
        raise UnsupportedBytecode('frameless body conflicts with the existing-frame ABI')
    if frameless and not builtins.callable(frameless_deopt):
        raise UnsupportedBytecode('frameless traversal requires a cold deopt emitter')
    if type(allow_async_resume) is not bool:
        raise TypeError('allow_async_resume must be bool')
    if allow_async_resume:
        import ctypes
        if not frame_entry or not getattr(ctypes.pythonapi, 'PyUnstable_RPCode_SetNative', None):
            raise UnsupportedBytecode('async native resume requires the fork existing-frame ABI')
    if numeric_ops is not None and (not builtins.callable(getattr(numeric_ops, 'emit_binary', None))
                                    or not isinstance(getattr(numeric_ops, 'keepalive', None), tuple)):
        raise TypeError('numeric_ops requires emit_binary and a keepalive tuple')
    compile_options=tuple(sorted(dict(frame_entry=bool(frame_entry),readonly_loops=bool(readonly_loops),
        owned_readonly_loops=bool(owned_readonly_loops),inline_returns=bool(inline_returns),
        refcounts=bool(refcounts),builtin_calls=bool(builtin_calls),constant_words=bool(constant_words),
        allow_async_resume=allow_async_resume,frameless=frameless,native_calls=bool(native_calls),
        outline_frame_paths=outline_frame_paths,bounded_region=_region is not None,
        library_calls=bool(library_calls),numeric_ops=None if numeric_ops is None else
        type(numeric_ops).__module__+'.'+type(numeric_ops).__qualname__).items()))
    if _region_context is None:verify(graph)
    else:
        from .regions import _RegionContext
        if (type(_region_context) is not _RegionContext or _region_context.graph is not graph
                or _region not in _region_context.members or _region_targets is not _region_context.targets):
            raise UnsupportedBytecode('invalid private region graph context')
    frameless_plan=None
    if frameless:
        from .readonly import plan_readonly_loop
        frameless_plan=plan_readonly_loop(graph)
        if frameless_plan is None:
            raise UnsupportedBytecode('frameless body requires a proved readonly traversal')
        readonly_loops=True
    code=graph.code
    if _region is not None:
        from .regions import Region
        if (type(_region) is not Region or not frame_entry or frameless or not outline_frame_paths
                or readonly_loops or owned_readonly_loops or graph.exceptions
                or graph.code.co_flags & (inspect.CO_GENERATOR|inspect.CO_COROUTINE|inspect.CO_ASYNC_GENERATOR)
                or type(_region_targets) is not types.MappingProxyType
                or not _region.offsets or _region.entry not in _region.offsets
                or any(offset not in graph.blocks for offset in _region.offsets)
                or len(set(_region.offsets))!=len(_region.offsets) or entry_offset!=_region.entry
                or _region.entry not in graph.blocks
                or _region.entry_stack!=graph.blocks[_region.entry].parameters):
            raise UnsupportedBytecode('invalid private bounded-region entry contract')
    native_calls=dict(native_calls or {})
    if native_calls:
        from .native_calls import NativeCandidate
        valid_sites={op.offset for block in graph.blocks.values() for op in block.operations if op.name in ('call','call_kw')}
        if any(type(candidate) is not NativeCandidate or offset not in valid_sites for offset,candidate in native_calls.items()):
            raise UnsupportedBytecode('native children require original call sites and prepared candidates')
    library_calls=dict(library_calls or {})
    if library_calls:
        from ..libraries.c_calls import CFunctionCall
        valid_sites={op.offset for block in graph.blocks.values() for op in block.operations if op.name in ('call','call_kw')}
        if any(type(offset) is not int or type(candidate) is not CFunctionCall or offset not in valid_sites
               for offset,candidate in library_calls.items()):
            raise UnsupportedBytecode('library calls require guarded original call sites')
        if library_calls.keys() & native_calls.keys():
            raise UnsupportedBytecode('a call site cannot select two call providers')
    instructions=list(dis.get_instructions(code))
    next_instruction={left.offset:right.offset for left,right in zip(instructions,instructions[1:])}
    async_scope=bool(code.co_flags & (inspect.CO_COROUTINE|inspect.CO_ASYNC_GENERATOR))
    generator=bool(code.co_flags & (inspect.CO_GENERATOR|inspect.CO_COROUTINE|inspect.CO_ASYNC_GENERATOR))
    if generator and (not frame_entry or entry_offset is None):
        raise UnsupportedBytecode('generator lowering requires an explicit existing-frame resume slice')
    resume=next(i.offset for i in dis.get_instructions(code) if i.opname=='RESUME')
    start=resume if entry_offset is None else entry_offset
    if async_scope and start!=resume and not allow_async_resume:
        raise UnsupportedBytecode('async native-prefix entry requires the first RESUME')
    if entry_offset is not None and not frame_entry:
        raise UnsupportedBytecode('explicit block entry requires the existing-frame ABI')
    if type(start) is not int or start not in graph.blocks:
        raise UnsupportedBytecode('entry offset must identify an original CFG block')
    if generator and not any(i.offset==start and i.opname=='RESUME' for i in instructions):
        raise UnsupportedBytecode('generator entry must identify an original RESUME')
    if graph.blocks[start].parameters and not generator and _region is None:
        raise UnsupportedBytecode('existing-frame block entry requires an empty stack')
    if frame_entry and readonly_loops:
        raise UnsupportedBytecode('borrowed readonly traversal needs an independent owned-frame lifetime proof')
    if owned_readonly_loops and not frame_entry:
        raise UnsupportedBytecode('owned readonly traversal requires the existing-frame ABI')
    if start<resume:
        raise UnsupportedBytecode('cell initialization prelude belongs to CPython before native RESUME')
    if not frame_entry and (graph.exceptions or code.co_kwonlyargcount or code.co_flags & (inspect.CO_VARARGS|inspect.CO_VARKEYWORDS)):
        raise UnsupportedBytecode('probe requires fixed ordinary unprotected scope')
    # Errors leave the actual frame to Tier 1, which reads its original
    # exception table. Native code covers the normal CFG; exception-only
    # handler blocks execute in the interpreter after that error handoff.
    blocks=graph.blocks
    if graph.exceptions or generator:
        root=start if generator else graph.entry
        reachable={root};pending=[root]
        while pending:
            current=graph.blocks[pending.pop()]
            if any(op.name=='send' for op in current.operations):continue
            for edge in current.edges:
                if edge.kind not in ('exception','resume') and edge.target not in reachable:
                    reachable.add(edge.target);pending.append(edge.target)
        blocks={offset:block for offset,block in graph.blocks.items() if offset in reachable}
        if start not in blocks:
            raise UnsupportedBytecode('native entry must reach a normal CFG path')
    if _region is not None:blocks={offset:graph.blocks[offset] for offset in _region.offsets}
    producers={value.id:op for block in blocks.values() for op in block.operations for value in op.results}
    parameters={value.id:(offset,index) for offset,block in blocks.items() for index,value in enumerate(block.parameters)}
    def function_sources(value):
        # Normal CFG parameters transfer the exact object; protected operations
        # commonly split MAKE_FUNCTION and its attributes across such edges.
        pending=[(value,frozenset(),frozenset())];sources=set()
        while pending:
            current,flags,path=pending.pop()
            if current.id in path:return None  # Unknown cyclic provenance stays closed.
            path=path|{current.id};producer=producers.get(current.id)
            if producer is not None:
                if producer.name=='make_function':sources.add((current.id,flags))
                elif producer.name=='set_function_attribute':
                    flag=producer.attributes['oparg']
                    if flag not in (1,2,4,8,16) or flag in flags:return None
                    pending.append((producer.arguments[1],flags|{flag},path))
                else:return None
            elif current.id in parameters:
                target,index=parameters[current.id]
                incoming=[edge.arguments[index] for block in blocks.values() for edge in block.edges
                          if edge.target==target and edge.kind!='exception']
                if not incoming:return None
                pending.extend((argument,flags,path) for argument in incoming)
            else:return None
        return sources or None
    for block in blocks.values():
        for op in block.operations:
            if op.name=='exception_state':continue
            if op.name=='cell.copy_free' and op.offset>=resume:
                raise UnsupportedBytecode('cell initialization must precede native RESUME')
            if op.name=='make_function' and op.arguments[0].type.exact is not types.CodeType:
                raise UnsupportedBytecode('MAKE_FUNCTION requires a proven original code object')
            if op.name=='set_function_attribute':
                flag=op.attributes['oparg'];sources=function_sources(op.arguments[1])
                if flag not in (1,2,4,8,16) or sources is None or any(flag in flags for origin,flags in sources):
                    raise UnsupportedBytecode('function attributes require a fresh original-code function')
            if op.name=='build_slice' and op.attributes['oparg'] not in (2,3):
                raise UnsupportedBytecode('slice construction requires two or three operands')
            if op.name=='call_ex' and not frame_entry:
                raise UnsupportedBytecode('expanded calls require the original existing-frame boundary')
            selected=op.attributes.get('lowering')
            expected={'load_attr':'structure.load_attr','store_attr':'structure.store_attr',
                      'store_subscr':'structure.setitem','contains':'structure.contains',
                      'binary':'structure.getitem' if op.attributes.get('oparg')==26 else None}.get(op.name)
            if selected is not None and (structure_calls is None or selected!=expected):
                raise UnsupportedBytecode('selected lowering requires matching primitive provider: '+str(selected))
            if op.name not in SUPPORTED:
                raise UnsupportedBytecode('probe missing generic lowering: '+op.name)
            if op.name=='compare' and not 0 <= op.attributes['oparg']>>5 <= 5:
                raise UnsupportedBytecode('invalid rich comparison operation')
            if op.name=='binary' and op.attributes['oparg'] not in BINARY:
                raise UnsupportedBytecode('probe missing binary operation')
            if op.name=='branch' and op.instruction.opname not in ('POP_JUMP_IF_NONE','POP_JUMP_IF_NOT_NONE','POP_JUMP_IF_TRUE','POP_JUMP_IF_FALSE'):
                raise UnsupportedBytecode('probe missing branch')
    inline_sites={}
    if inline_returns:
        from .inline_returns import local_return_sites
        inline_sites=local_return_sites(graph)
    frame_plan=None
    if owned_readonly_loops:
        from .readonly import plan_readonly_loop
        candidate=plan_readonly_loop(graph)
        if candidate is not None and start in (graph.entry,candidate.loop_offset):
            if structure_calls is None:
                raise UnsupportedBytecode('owned readonly loop requires guarded structure primitives')
            frame_plan=candidate
    from .refcount_lowering import prepare_reference_plan
    reference_plan=prepare_reference_plan(graph) if refcounts and frame_plan is None and not readonly_loops else None
    reference_stats={'active':reference_plan is not None,'noop_closes':0,'noop_dups':0}
    skip_close_words=frozenset()
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    symbols=CPythonSymbols()
    for name,address in provider.addresses().items():symbols.register_external('rc_ir_frame_'+name,address,provider)
    from .builtin_calls import type_sites
    builtin_type_sites=type_sites(graph) if builtin_calls else frozenset()
    layout=provider.layout()
    immortal_constants={}
    if constant_words:
        try:from .. import _structure_ops_native as constant_provider
        except ImportError:pass
        else:
            predicate=getattr(constant_provider,'is_immortal',None)
            if predicate is not None:
                immortal_constants={index:id(value)|layout['tag_refcnt']
                                    for index,value in enumerate(code.co_consts)
                                    if predicate(value)}
    module=ir.Module(name='generic_floor')
    module.triple=binding.get_process_triple()
    p=ir.IntType(8).as_pointer();word=ir.IntType(64);i32=ir.IntType(32);void=ir.VoidType()
    saved_vectorcall=None
    region_targets=None
    if frame_entry:
        signature=[p,word.as_pointer(),p]+([word.as_pointer()] if _region is not None else [])
        body=ir.Function(module,ir.FunctionType(p,signature),name='body')
        frame,incoming_stack,thread=body.args[:3]
        if _region is not None:region_targets=body.args[3]
    else:
        body=ir.Function(module,ir.FunctionType(p,[p,p.as_pointer(),word,p]+([p] if frameless else [])),name='body')
        if frameless:original,args,nargsf,kwnames,saved_vectorcall=body.args
        else:original,args,nargsf,kwnames=body.args
    builder=ir.IRBuilder(body.append_basic_block('entry'))
    call_pending=builder.alloca(i32,name='call_pending') if any(op.name in ('call','call_kw') for block in blocks.values() for op in block.operations) else None
    mapping_result=builder.alloca(p,name='mapping_lookup_result') if any(op.name=='load_dict_or_globals' for block in blocks.values() for op in block.operations) else None
    values={}
    null_pointer=ir.Constant(p,None)
    zero=ir.Constant(word,0)
    null_word=ir.Constant(word,layout['null_bits'])
    tag=ir.Constant(word,layout['tag_refcnt'])
    def integer(value):return ir.Constant(word,value)
    def pointer(value):return integer(id(value)).inttoptr(p)
    def call(name,result,operands):
        return builder.call(symbols.declare(module,name,result,[x.type for x in operands]),operands)
    def helper(name,result,operands):return call('rc_ir_frame_'+name,result,operands)
    def raw(value):return builder.inttoptr(builder.and_(value,integer((1<<64)-1-layout['tag_refcnt'])),p)
    if not frame_entry:
        native_block=body.append_basic_block('native')
        fallback_block=body.append_basic_block('original')
        count=builder.and_(nargsf,integer((1<<63)-1))
        eligible=builder.and_(builder.icmp_unsigned('==',count,integer(code.co_argcount)),builder.icmp_unsigned('==',kwnames,null_pointer))
        builder.cbranch(eligible,native_block,fallback_block)
        builder.position_at_end(fallback_block)
        if saved_vectorcall is None:
            builder.ret(call('PyObject_Vectorcall',p,[original,args,nargsf,kwnames]))
        else:
            signature=ir.FunctionType(p,[p,p.as_pointer(),word,p])
            target=builder.bitcast(saved_vectorcall,signature.as_pointer())
            builder.ret(builder.call(target,[original,args,nargsf,kwnames]))
        builder.position_at_end(native_block)
        if readonly_loops:
            from .readonly import plan_readonly_loop
            plan=frameless_plan or plan_readonly_loop(graph)
            if plan is not None:
                if structure_calls is None:
                    raise UnsupportedBytecode('readonly loop requires guarded structure primitives')
                feedback=next((op.attributes.get('attribute_plan')
                               for op in graph.blocks[plan.loop_offset].operations
                               if op.name=='load_attr' and op.attributes.get('argval')==plan.attribute),None)
                leases=[]
                _emit_readonly(builder,original,args,code,plan,structure_calls,symbols,feedback,
                    saved_vectorcall=saved_vectorcall,frameless_deopt=frameless_deopt,deopt_owners=leases)
                return _finish(graph,module,structure_calls,symbols,numeric_ops=numeric_ops,compile_options=compile_options,
                    abi='frameless' if frameless else None,execution_owners=tuple(leases))
    llvm_blocks={offset:body.append_basic_block('bytecode_'+str(offset)) for offset in blocks}
    if not frame_entry:
        resume=next(i.offset for i in dis.get_instructions(code) if i.opname=='RESUME')
        frame=helper('enter',p,[original,pointer(code),args,count,integer(resume)])
        with builder.if_then(builder.icmp_unsigned('==',frame,null_pointer)):
            builder.ret(null_pointer)
    if not frame_entry:
        thread=call('PyThreadState_Get',p,[])
    locals_pointer=builder.bitcast(builder.gep(frame,[integer(layout['locals_offset'])]),word.as_pointer())
    stack_base=builder.gep(locals_pointer,[integer(provider.localsplus_count(code))])
    stack_pointer=builder.bitcast(builder.gep(frame,[integer(layout['stackpointer_offset'])]),word.as_pointer().as_pointer())
    instruction_pointer=builder.bitcast(builder.gep(frame,[integer(layout['instrptr_offset'])]),p.as_pointer())
    from .cold_paths import FramePaths
    frame_paths=FramePaths(module,symbols,layout,provider.localsplus_count(code),frame_entry=frame_entry) if outline_frame_paths else None
    if frame_paths is not None:frame_paths.bind(builder,frame,thread)
    def clear_executor():
        executor_pointer=builder.bitcast(builder.gep(thread,[integer(layout['thread_executor_offset'])]),p.as_pointer())
        builder.store(null_pointer,executor_pointer)
    if frame_entry:
        # The interpreter already bound/owns this actual frame. Do not create,
        # unlink or clear it; its normal RETURN_VALUE/error path remains owner.
        builder.store(incoming_stack,stack_pointer)
        executable=builder.load(builder.bitcast(builder.gep(frame,[integer(layout['frame_executable_offset'])]),word.as_pointer()))
        active=builder.load(builder.bitcast(builder.gep(thread,[integer(layout['thread_frame_offset'])]),p.as_pointer()))
        valid=builder.and_(builder.icmp_unsigned('==',raw(executable),pointer(code)),
                           builder.icmp_unsigned('==',active,frame))
        expected_stack=builder.gep(stack_base,[integer(len(graph.blocks[start].parameters))])
        valid=builder.and_(valid,builder.icmp_unsigned('==',incoming_stack,expected_stack))
        with builder.if_then(builder.not_(valid)):
            message=b'invalid existing source frame\0'
            storage=ir.GlobalVariable(module,ir.ArrayType(ir.IntType(8),len(message)),'frame_error')
            storage.global_constant=True;storage.initializer=ir.Constant(storage.type.pointee,bytearray(message))
            call('PyErr_SetString',void,[pointer(SystemError),builder.bitcast(storage,p)])
            clear_executor();builder.ret(null_pointer)
    def sync(stack):
        if frame_paths is not None:
            frame_paths.publish(builder,frame,stack)
        else:
            for n,value in enumerate(stack):builder.store(value,builder.gep(stack_base,[integer(n)]))
            builder.store(builder.gep(stack_base,[integer(len(stack))]),stack_pointer)
    def fail_if(condition,stack,pc):
        if frame_paths is not None:
            frame_paths.conditional(builder,condition,stack,null_pointer,pc)
        else:
            with builder.if_then(condition):
                sync(stack)
                if frame_entry:clear_executor()
                else:helper('leave_raw',i32,[frame,ir.Constant(i32,0),integer(pc)])
                builder.ret(null_pointer)
    def unbound_if(condition,index,pc):
        if frame_paths is not None:
            # Op entry already published its full stack, before this pure load.
            frame_paths.conditional(builder,condition,None,null_pointer,pc,action=1,argument=index)
        else:
            with builder.if_then(condition):
                helper('unbound',void,[frame,integer(index)])
                if frame_entry:clear_executor()
                else:helper('leave_raw',i32,[frame,ir.Constant(i32,0),integer(pc)])
                builder.ret(null_pointer)
    def resume_at(pc,stack=None,condition=None):
        destination=builder.gep(pointer(code),[integer(layout['code_data_offset']+pc)])
        if frame_paths is not None:
            if condition is None:frame_paths.leave(builder,frame,thread,stack,destination,pc)
            else:frame_paths.conditional(builder,condition,stack,destination,pc)
        else:
            def leave():
                if stack is not None:sync(stack)
                if frame_entry:clear_executor();builder.ret(destination)
                else:builder.ret(helper('resume_python',p,[frame]))
            if condition is None:leave()
            else:
                with builder.if_then(condition):leave()
    def observer_resume(stack,continuation):
        if not frame_entry:return
        active=helper('observers_active',i32,[frame])
        condition=builder.icmp_signed('!=',active,ir.Constant(i32,0))
        offset=integer(continuation) if isinstance(continuation,int) else continuation
        destination=builder.gep(pointer(code),[builder.add(integer(layout['code_data_offset']),offset)])
        if frame_paths is not None:
            frame_paths.conditional(builder,condition,stack,destination,0)
        else:
            with builder.if_then(condition):
                sync(stack);clear_executor();builder.ret(destination)
    def periodic(stack,pc,continuation):
        # Match CPython's relaxed event-bit read at RESUME/JUMP_BACKWARD.
        # The source stack/PC are already published before pending Python work.
        breaker=builder.bitcast(builder.gep(thread,[integer(layout['thread_eval_breaker_offset'])]),word.as_pointer())
        events=builder.and_(builder.load_atomic(breaker,'monotonic',8),integer(layout['eval_events_mask']))
        with builder.if_then(builder.icmp_unsigned('!=',events,zero)):
            status=call('_Py_HandlePending',i32,[thread])
            fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),stack,pc)
            observer_resume(stack,continuation)
    def tagged_word(value):
        # Construction proves the tag without owner/lifetime assumptions.
        # PHIs and other expressions conservatively retain canonical helpers.
        if not refcounts or value.type!=word:return False
        if isinstance(value,ir.Constant):
            return type(value.constant) is int and bool(value.constant & layout['tag_refcnt'])
        if getattr(value,'opname',None)=='or':
            return any(tagged_word(operand) for operand in value.operands)
        if getattr(value,'opname',None)=='select':
            return all(tagged_word(operand) for operand in value.operands[1:])
        return False
    def close(value):
        if tagged_word(value) or value in skip_close_words:reference_stats['noop_closes']+=1
        else:helper('word_close',void,[value])
    def edge_target(edge):
        if edge.target in llvm_blocks:return llvm_blocks[edge.target]
        if region_targets is None:raise AssertionError('unresolved source edge')
        index=_region_targets.get(edge.target)
        if type(index) is not int or not 0<=index<len(_region_targets):
            raise UnsupportedBytecode('cross-region edge lacks a linked entry')
        bridge=body.append_basic_block('region_transfer_'+str(edge.target))
        origin=builder.block;builder.position_at_end(bridge)
        words=[values[value.id] for value in edge.arguments];sync(words)
        signature=ir.FunctionType(p,[p,word.as_pointer(),p,word.as_pointer()])
        target=builder.inttoptr(builder.load(builder.gep(region_targets,[integer(index)])),signature.as_pointer())
        result=builder.call(target,[frame,builder.gep(stack_base,[integer(len(words))]),thread,region_targets],tail='musttail')
        builder.ret(result)
        builder.position_at_end(origin)
        return bridge
    entry_predecessor=builder.block
    entry_words=[builder.load(builder.gep(stack_base,[integer(n)]))
                 for n in range(len(graph.blocks[start].parameters))]
    if frame_plan is None:
        builder.branch(llvm_blocks[start])
    else:
        plan=frame_plan
        state_slot=builder.gep(locals_pointer,[integer(plan.state_slot)])
        owner_slot=builder.gep(locals_pointer,[integer(plan.owner_slot)])
        initial=builder.load(state_slot);owner_word=builder.load(owner_slot)
        breaker=builder.bitcast(builder.gep(thread,[integer(layout['thread_eval_breaker_offset'])]),word.as_pointer())
        events=builder.and_(builder.load_atomic(breaker,'monotonic',8),integer(layout['eval_events_mask']))
        ready=builder.and_(builder.icmp_unsigned('!=',initial,null_word),builder.icmp_unsigned('!=',owner_word,null_word))
        ready=builder.and_(ready,builder.icmp_unsigned('==',events,zero))
        hot=body.append_basic_block('owned_readonly_anchor')
        builder.cbranch(ready,hot,llvm_blocks[start]);builder.position_at_end(hot)
        current=raw(initial);owner=raw(owner_word)
        if plan.kind=='attribute':
            # No application callbacks/GIL handoff occur while borrowed. One
            # additional strong ref anchors the initial object and its graph.
            ref_type=ir.IntType(layout['object_refcount_size']*8)
            ref_pointer=builder.bitcast(builder.gep(current,[integer(layout['object_refcount_offset'])]),ref_type.as_pointer())
            count=builder.load(ref_pointer,name='owned_readonly_refcount')
            with builder.if_then(builder.icmp_unsigned('<=',count,ir.Constant(ref_type,1))):
                builder.branch(llvm_blocks[start])
        header=graph.blocks[plan.loop_offset]
        exit_offset=next(edge.target for edge in header.edges if edge.kind=='taken')
        body_offset=next(edge.target for edge in header.edges if edge.kind=='fallthrough')
        backward=graph.blocks[body_offset].operations[-1].offset
        def materialize(value):
            prior=builder.load(state_slot)
            with builder.if_then(builder.icmp_unsigned('!=',raw(prior),value)):
                replacement=helper('word_newref',word,[value])
                builder.store(replacement,state_slot)
                close(prior)
        def miss(value):
            materialize(value);builder.branch(llvm_blocks[plan.loop_offset])
        def done(value):
            materialize(value);builder.branch(llvm_blocks[exit_offset])
        def backedge(value):
            flags=builder.and_(builder.load_atomic(breaker,'monotonic',8),integer(layout['eval_events_mask']))
            with builder.if_then(builder.icmp_unsigned('!=',flags,zero)):
                materialize(value);sync([])
                builder.store(builder.gep(pointer(code),[integer(layout['code_data_offset']+backward)]),instruction_pointer)
                periodic([],backward,plan.loop_offset)
                # Pending work may invalidate any borrowed graph or local.
                builder.branch(llvm_blocks[plan.loop_offset])
        feedback=next((op.attributes.get('attribute_plan') for op in header.operations
                       if op.name=='load_attr' and op.attributes.get('argval')==plan.attribute),None)
        _emit_borrowed_loop(builder,code,plan,structure_calls,symbols,current,owner,miss,done,
                            backedge=backedge,attribute_feedback=feedback)

    for offset,block in blocks.items():
        builder.position_at_end(llvm_blocks[offset])
        for param in block.parameters:values[param.id]=builder.phi(word,name='stack_'+str(param.id))
    for param,value in zip(graph.blocks[start].parameters,entry_words):
        values[param.id].add_incoming(value,entry_predecessor)
    incoming=[]
    for offset,block in blocks.items():
        builder.position_at_end(llvm_blocks[offset])
        stack=[values[v.id] for v in block.parameters]
        for op in block.operations:
            if op.name=='exception_state':continue
            pc=op.offset
            builder.store(builder.gep(pointer(code),[integer(layout['code_data_offset']+pc)]),instruction_pointer)
            before=list(stack)
            sync(before)
            consumed,_,_,_=contract(op.instruction)
            prefix=before[:-consumed] if consumed else before
            operands=[values[v.id] for v in op.arguments]
            skipped=reference_plan.skip_retire.get(pc,()) if reference_plan is not None else ()
            # Preserve a close if an aliased LLVM word also has an owned use.
            skip_close_words=frozenset(operands[i] for i in skipped)-frozenset(value for i,value in enumerate(operands) if i not in skipped)
            results=[]
            name=op.name;arg=op.attributes['oparg'] or 0
            if name=='cell.copy_free' or name=='cell.new' and pc<resume:pass
            elif name=='cell.new':
                # Inlined comprehensions create a fresh cell after saving the
                # outer local. Prelude cells still belong to original CPython.
                slot=builder.gep(locals_pointer,[integer(arg)]);prior=builder.load(slot)
                result=call('PyCell_New',p,[raw(prior)])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),before,pc)
                builder.store(helper('word_from_owned',word,[result]),slot)
                sync(before);close(prior)
            elif name in ('resume','nop','jump'):
                if name=='resume' and (arg&3)<2 or op.instruction.opname=='JUMP_BACKWARD':
                    continuation=next_instruction[pc] if name=='resume' else next(edge.target for edge in block.edges if edge.kind!='exception')
                    periodic(before,pc,continuation)
            elif name in ('frame.borrow','frame.load','frame.load_check','frame.borrow_borrow','frame.load_load'):
                slots=op.attributes.get('slots',(arg,))
                for index in slots:
                    value=builder.load(builder.gep(locals_pointer,[integer(index)]))
                    unbound_if(builder.icmp_unsigned('==',value,null_word),index,pc)
                    value=builder.or_(value,tag) if name in ('frame.borrow','frame.borrow_borrow') else helper('word_dup',word,[value])
                    results.append(value)
            elif name=='frame.take':
                slot=builder.gep(locals_pointer,[integer(arg)])
                results=[builder.load(slot)];builder.store(null_word,slot)
            elif name=='frame.delete':
                slot=builder.gep(locals_pointer,[integer(arg)]);prior=builder.load(slot)
                unbound_if(builder.icmp_unsigned('==',prior,null_word),arg,pc)
                builder.store(null_word,slot);sync(before);close(prior)
            elif name in ('raise','reraise'):
                # do_raise is interpreter-private. Transfer the unchanged actual
                # operands/current PC, preserving context, causes and monitoring.
                resume_at(pc)
            elif name=='load_build_class':
                result=helper('build_class_load',p,[frame])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),before,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='load_special':
                sync(prefix+[null_word,operands[0]])
                source=builder.gep(stack_base,[integer(len(prefix))])
                status=helper('special_load',i32,[source,integer(arg)])
                results=[builder.load(builder.gep(source,[integer(index)])) for index in (0,1)]
                fail_if(builder.icmp_signed('<=',status,ir.Constant(i32,0)),prefix+results,pc)
            elif name in ('unary','intrinsic_unary','intrinsic_binary'):
                if name=='unary' and op.instruction.opname=='UNARY_NOT':
                    results=[builder.select(builder.icmp_unsigned('==',raw(operands[0]),pointer(False)),integer(id(True)|layout['tag_refcnt']),integer(id(False)|layout['tag_refcnt']))]
                else:
                    if name.startswith('intrinsic_'):
                        result=helper(name,p,[integer(arg)]+[raw(value) for value in operands])
                    else:
                        function='PyNumber_Negative' if op.instruction.opname=='UNARY_NEGATIVE' else 'PyNumber_Invert'
                        result=call(function,p,[raw(operands[0])])
                    retiring=list(before)
                    for index in range(len(operands)-1,-1,-1):
                        retiring[len(prefix)+index]=null_word;sync(retiring);close(operands[index])
                    sync(prefix)
                    fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                    results=[helper('word_from_owned',word,[result])]
            elif name=='frame.store_load':
                stored,loaded=op.attributes['slots']
                slot=builder.gep(locals_pointer,[integer(stored)])
                prior=builder.load(slot);builder.store(operands[0],slot)
                # The fused CPython opcode captures the loaded reference BEFORE
                # releasing the old slot, whose finalizer may mutate locals.
                value=builder.load(builder.gep(locals_pointer,[integer(loaded)]))
                value=helper('word_dup',word,[value])
                sync(prefix+[value]);close(prior);results=[value]
            elif name=='frame.store_store':
                # The first old local may mutate the second local before its
                # STORE executes. Publish/shrink and retire each individually.
                first,second=op.attributes['slots']
                for index,slot_index in enumerate((first,second)):
                    slot=builder.gep(locals_pointer,[integer(slot_index)])
                    prior=builder.load(slot)
                    builder.store(operands[1-index],slot)
                    sync(prefix+operands[:1-index]);close(prior)
            elif name=='frame.store':
                slot=builder.gep(locals_pointer,[integer(arg)])
                prior=builder.load(slot);builder.store(operands[0],slot)
                sync(prefix);close(prior)
            elif name=='load_dict_or_globals':
                status=call('PyMapping_GetOptionalItem',i32,[raw(operands[0]),pointer(code.co_names[arg]),mapping_result])
                sync(prefix);close(operands[0])
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),prefix,pc)
                with builder.if_then(builder.icmp_unsigned('==',builder.load(mapping_result),null_pointer)):
                    result=helper('global_load_owned',p,[frame,integer(arg)])
                    fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                    builder.store(result,mapping_result)
                results=[helper('word_from_owned',word,[builder.load(mapping_result)])]
            elif name=='match_class':
                result=call('_PyEval_MatchClass',p,[thread,raw(operands[0]),raw(operands[1]),integer(arg),raw(operands[2])])
                retiring=list(before)
                for index in (2,1,0):
                    retiring[len(prefix)+index]=null_word;sync(retiring);close(operands[index])
                sync(prefix)
                missing=builder.icmp_unsigned('==',result,null_pointer)
                error=call('PyErr_Occurred',p,[])
                fail_if(builder.and_(missing,builder.icmp_unsigned('!=',error,null_pointer)),prefix,pc)
                result_word=helper('word_from_owned',word,[result])
                results=[builder.select(missing,integer(id(None)|layout['tag_refcnt']),result_word)]
            elif name=='global.load':
                value=helper('global_load',word,[frame,integer(arg>>1)])
                fail_if(builder.icmp_unsigned('==',value,null_word),before,pc)
                results=[value]+([null_word] if arg&1 else [])
            elif name=='global.store':
                status=helper('global_store',i32,[frame,integer(arg),operands[0]])
                sync(prefix);close(operands[0])
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),prefix,pc)
            elif name=='global.delete':
                status=helper('global_delete',i32,[frame,integer(arg)])
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),before,pc)
            elif name in ('dict_update','dict_merge'):
                merge_callable=raw(before[-arg-4]) if name=='dict_merge' else null_pointer
                status=helper('dict_expand',i32,[raw(operands[0]),raw(operands[1]),merge_callable])
                sync(prefix);close(operands[1])
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),prefix,pc)
            elif name=='call_ex':
                # CPython's tuple-consuming expanded binder is private. Execute
                # this original instruction in Tier 1 with its original stack;
                # completed native prefix effects are never replayed.
                resume_at(pc,before)
                break
            elif name=='import_name':
                result=call('_PyEval_ImportName',p,[thread,frame,pointer(code.co_names[arg]),raw(operands[1]),raw(operands[0])])
                # IMPORT_NAME clears/closes fromlist, then level, before testing
                # its new result. Preserve the full original visible stack.
                retiring=list(before)
                for index in (1,0):
                    retiring[len(prefix)+index]=null_word
                    sync(retiring);close(operands[index])
                sync(prefix)
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='import_from':
                # The module remains on the original stack on success/error.
                result=call('_PyEval_ImportFrom',p,[thread,raw(operands[0]),pointer(code.co_names[arg])])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),before,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name in ('call','call_kw'):
                call_base=builder.gep(stack_base,[integer(len(prefix))])
                def generic_call():
                    candidate=native_calls.get(pc)
                    arguments=[frame,call_base,integer(arg),ir.Constant(i32,int(name=='call_kw')),call_pending]
                    if candidate is None:
                        library=library_calls.get(pc)
                        if library is None:return helper('call_owned',p,arguments)
                        return helper('call_library_owned',p,arguments+[
                            integer(library.dispatcher_address).inttoptr(p),
                            integer(library.context_address).inttoptr(p)])
                    return helper('call_native_owned',p,arguments+[pointer(candidate.code),integer(candidate.body_address).inttoptr(p),integer(candidate.entry_offset),pointer(candidate)])
                def canonical_call():
                    if pc not in builtin_type_sites:return generic_call()
                    from .builtin_calls import emit_type
                    return emit_type(builder,operands,frame=frame,base=call_base,pending=call_pending,canonical=generic_call,
                                     helper=helper,integer=integer,pointer=pointer,raw=raw,p=p,i32=i32,null_word=null_word)
                if name=='call' and pc in inline_sites:
                    from .inline_returns import emit
                    result=emit(builder,inline_sites[pc],operands,frame=frame,base=call_base,nargs=arg,pending=call_pending,
                                canonical=canonical_call,helper=helper,integer=integer,pointer=pointer,raw=raw,p=p,word=word,i32=i32,
                                counter_address=inline_counter_address)
                else:result=canonical_call()
                resume_at(pc,condition=builder.icmp_signed('<',builder.load(call_pending),ir.Constant(i32,0)))
                sync(prefix)
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
                sync(prefix+results)
                with builder.if_then(builder.icmp_signed('!=',builder.load(call_pending),ir.Constant(i32,0))):
                    periodic(prefix+results,pc,next_instruction[pc])
            elif name=='cell.get':
                value=helper('cell_load',word,[frame,integer(arg)])
                fail_if(builder.icmp_unsigned('==',value,null_word),before,pc)
                results=[value]
            elif name=='cell.set':
                sync(prefix)
                helper('cell_store',void,[frame,integer(arg),operands[0]])
            elif name=='cell.delete':
                status=helper('cell_delete',i32,[frame,integer(arg)])
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),before,pc)
            elif name=='build_slice':
                step=raw(operands[2]) if arg==3 else null_pointer
                result=call('PySlice_New',p,[raw(operands[0]),raw(operands[1]),step])
                retiring=list(before)
                for index in range(len(operands)-1,-1,-1):
                    retiring[len(prefix)+index]=null_word
                    sync(retiring);close(operands[index])
                sync(prefix)
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='binary_slice':
                result=helper('slice_get',p,[frame,builder.gep(stack_base,[integer(len(prefix))])])
                sync(prefix)
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='store_slice':
                status=helper('slice_set',i32,[frame,builder.gep(stack_base,[integer(len(prefix))])])
                sync(prefix)
                fail_if(builder.icmp_signed('!=',status,ir.Constant(i32,0)),prefix,pc)
            elif name=='build_tuple':
                result=call('_PyTuple_FromStackRefStealOnSuccess',p,[builder.gep(stack_base,[integer(len(prefix))]),integer(arg)])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),before,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='make_function':
                value=helper('function_new',word,[frame,operands[0]])
                sync(prefix)
                fail_if(builder.icmp_unsigned('==',value,null_word),prefix,pc)
                results=[value]
            elif name=='set_function_attribute':
                helper('function_attribute',void,[operands[1],operands[0],ir.Constant(i32,arg)])
                results=[operands[1]]
            elif name=='get_yield_from_iter':
                source=builder.gep(stack_base,[integer(len(prefix))])
                status=helper('generator_get_iter',i32,[frame,source])
                # Success replaces/closes the original word in place; failure
                # retains it. Publish that canonical word on either guard edge.
                results=[builder.load(source)]
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),prefix+results,pc)
            elif name=='send':
                # Keep CPython's inline delegation and exception-state linkage.
                # This is the first suspension boundary, with no prefix replay.
                resume_at(pc,before)
                break
            elif name=='get_aiter':
                # GET_AITER closes its input before checking the returned type.
                result=helper('async_iter_get',p,[raw(operands[0])])
                sync(prefix);close(operands[0])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                result=helper('async_iter_check',p,[result])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='get_anext':
                result=call('_PyEval_GetANext',p,[raw(operands[0])])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),before,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='get_awaitable':
                result=call('_PyEval_GetAwaitable',p,[raw(operands[0]),ir.Constant(i32,arg)])
                sync(prefix);close(operands[0])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='get_iter':
                result=call('PyObject_GetIter',p,[raw(operands[0])])
                sync(prefix);close(operands[0])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='for_iter':
                # The canonical adapter retains source StopIteration observation
                # before clearing exhaustion, matching the original FOR_ITER.
                with builder.goto_entry_block():
                    next_slot=builder.alloca(p,name='iterator_result')
                status=helper('iter_next',i32,[frame,raw(operands[0]),next_slot])
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),before,pc)
                condition=builder.icmp_signed('==',status,ir.Constant(i32,0))
                result=builder.load(next_slot)
                results=[helper('word_from_owned',word,[result])]
            elif name=='map_add':
                # CPython consumes BOTH key and value in this helper on both
                # paths, retaining the dictionary below the untouched prefix.
                # Borrowed inputs become owners before Python hash/equality.
                key,value=raw(operands[1]),raw(operands[2])
                for operand,result in zip(operands[1:],(key,value)):
                    with builder.if_then(builder.icmp_unsigned('!=',builder.and_(operand,tag),zero)):
                        call('Py_IncRef',void,[result])
                status=call('_PyDict_SetItem_Take2',i32,[raw(operands[0]),key,value])
                sync(prefix)
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),prefix,pc)
            elif name in ('list_append','set_add'):
                value=raw(operands[1])
                with builder.if_then(builder.icmp_unsigned('!=',builder.and_(operands[1],tag),zero)):
                    call('Py_IncRef',void,[value])
                if name=='list_append':status=helper('list_append_take_ref',i32,[raw(operands[0]),value])
                else:status=call('_PySet_AddTakeRef',i32,[raw(operands[0]),value])
                sync(prefix)
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),prefix,pc)
            elif name in ('list_extend','set_update'):
                if name=='list_extend':status=helper('list_extend',i32,[raw(operands[0]),raw(operands[1])])
                else:status=call('_PySet_Update',i32,[raw(operands[0]),raw(operands[1])])
                sync(prefix);close(operands[1])
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),prefix,pc)
            elif name in ('delete_attr','delete_subscr'):
                if name=='delete_attr':
                    status=call('PyObject_SetAttr',i32,[raw(operands[0]),pointer(code.co_names[arg]),null_pointer])
                    sync(prefix);close(operands[0])
                else:
                    status=call('PyObject_DelItem',i32,[raw(operands[0]),raw(operands[1])])
                    retiring=list(before)
                    for index in (1,0):
                        retiring[len(prefix)+index]=null_word
                        sync(retiring);close(operands[index])
                    sync(prefix)
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),prefix,pc)
            elif name in ('unpack','unpack_ex'):
                count=len(op.results)
                # AsPyObjectSteal converts borrowed words to a real owner before
                # callbacks can replace the source local. The helper owns its
                # partial-result error cleanup; its output runs downwards into
                # the real original stack beyond the temporarily shrunk SP.
                seq=raw(operands[0])
                with builder.if_then(builder.icmp_unsigned('!=',builder.and_(operands[0],tag),zero)):
                    call('Py_IncRef',void,[seq])
                sync(prefix)
                top=builder.gep(stack_base,[integer(len(prefix)+count)])
                before_count=arg if name=='unpack' else arg&255
                after_count=-1 if name=='unpack' else arg>>8
                status=call('_PyEval_UnpackIterableStackRef',i32,
                            [thread,seq,ir.Constant(i32,before_count),ir.Constant(i32,after_count),top])
                call('Py_DecRef',void,[seq])
                fail_if(builder.icmp_signed('==',status,ir.Constant(i32,0)),prefix,pc)
                results=[builder.load(builder.gep(stack_base,[integer(len(prefix)+i)])) for i in range(count)]
            elif name=='load_super_attr':
                with builder.goto_entry_block():
                    super_args=builder.alloca(p,integer(2),name='super_arguments')
                for index,value in enumerate(operands[1:]):
                    builder.store(raw(value),builder.gep(super_args,[integer(index)]))
                super_object=call('PyObject_Vectorcall',p,
                                  [raw(operands[0]),super_args,integer(arg&2),null_pointer])
                retiring=list(before)
                for index in range(2,-1,-1):
                    retiring[len(prefix)+index]=null_word
                    sync(retiring);close(operands[index])
                sync(prefix)
                fail_if(builder.icmp_unsigned('==',super_object,null_pointer),prefix,pc)
                result=call('PyObject_GetAttr',p,[super_object,pointer(code.co_names[arg>>2])])
                call('Py_DecRef',void,[super_object])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
                if op.attributes['method']:results.append(null_word)
            elif name in ('format_simple','format_spec','convert','build_string'):
                if name=='format_simple':
                    result=call('PyObject_Format',p,[raw(operands[0]),null_pointer])
                elif name=='format_spec':
                    result=call('PyObject_Format',p,[raw(operands[0]),raw(operands[1])])
                elif name=='convert':
                    conversion={1:'PyObject_Str',2:'PyObject_Repr',3:'PyObject_ASCII'}[arg]
                    result=call(conversion,p,[raw(operands[0])])
                else:
                    with builder.goto_entry_block():
                        pieces=builder.alloca(p,integer(max(1,arg)),name='string_pieces')
                    for index,value in enumerate(operands):
                        builder.store(raw(value),builder.gep(pieces,[integer(index)]))
                    result=call('_PyUnicode_JoinArray',p,[pointer(''),pieces,integer(arg)])
                if name in ('format_simple','convert'):
                    sync(prefix);close(operands[0])
                else:
                    retiring=list(before)
                    for index in range(len(operands)-1,-1,-1):
                        retiring[len(prefix)+index]=null_word
                        sync(retiring);close(operands[index])
                    sync(prefix)
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='load_attr' and op.attributes['method']:
                # This exact CPython helper steals the owner on both paths and
                # preserves the method/self-or-NULL protocol without wrapping.
                self_slot=builder.gep(stack_base,[integer(len(before))])
                result=call('_Py_LoadAttr_StackRefSteal',word,
                            [thread,operands[0],pointer(code.co_names[arg>>1]),self_slot])
                fail_if(builder.icmp_unsigned('==',result,null_word),prefix,pc)
                results=[result,builder.load(self_slot)]
            elif name=='load_attr':
                if op.attributes.get('lowering')=='structure.load_attr':
                    plan=op.attributes.get('attribute_plan')
                    if plan is not None and hasattr(structure_calls,'load_attr_cached'):
                        result=structure_calls.load_attr_cached(builder,raw(operands[0]),pointer(code.co_names[arg>>1]),plan)
                    else:
                        result=structure_calls.load_attr(builder,raw(operands[0]),pointer(code.co_names[arg>>1]))
                else:
                    result=call('PyObject_GetAttr',p,[raw(operands[0]),pointer(code.co_names[arg>>1])])
                sync(prefix);close(operands[0])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name in ('store_attr','store_subscr'):
                # CPython STORE_* calls the protocol, then clears/closes the
                # original input words top-to-bottom on BOTH success and error.
                # Keep the full stack visible until every input is retired.
                if name=='store_attr':
                    if op.attributes.get('lowering')=='structure.store_attr':
                        status=structure_calls.store_attr(builder,raw(operands[1]),pointer(code.co_names[arg]),raw(operands[0]))
                    else:
                        status=call('PyObject_SetAttr',i32,[raw(operands[1]),pointer(code.co_names[arg]),raw(operands[0])])
                elif op.attributes.get('lowering')=='structure.setitem':
                    status=structure_calls.setitem(builder,raw(operands[1]),raw(operands[2]),raw(operands[0]))
                else:
                    status=call('PyObject_SetItem',i32,[raw(operands[1]),raw(operands[2]),raw(operands[0])])
                retiring=list(before)
                for index in range(len(operands)-1,-1,-1):
                    retiring[len(prefix)+index]=null_word
                    sync(retiring);close(operands[index])
                sync(prefix)
                fail_if(builder.icmp_signed('!=',status,ir.Constant(i32,0)),prefix,pc)
            elif name=='build_map':
                # The interpreter's own constructor preserves table sizing and
                # equality effects; repeated PyDict_SetItem is not equivalent.
                with builder.goto_entry_block():
                    packed=builder.alloca(p,integer(len(operands)),name='map_items')
                for index,value in enumerate(operands):
                    builder.store(raw(value),builder.gep(packed,[integer(index)]))
                result=call('_PyDict_FromItems',p,[packed,integer(2),builder.gep(packed,[integer(1)]),integer(2),integer(arg)])
                retiring=list(before)
                for index in range(len(operands)-1,-1,-1):
                    retiring[len(prefix)+index]=null_word
                    sync(retiring);close(operands[index])
                sync(prefix)
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='build_list':
                # Steal on success, leave original words for error cleanup on
                # allocation failure, exactly like BUILD_LIST.
                source=builder.gep(stack_base,[integer(len(prefix))])
                result=call('_PyList_FromStackRefStealOnSuccess',p,[source,integer(arg)])
                fail_if(builder.icmp_unsigned('==',result,null_pointer),before,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='build_set':
                result=call('PySet_New',p,[null_pointer])
                with builder.if_then(builder.icmp_unsigned('==',result,null_pointer)):
                    retiring=list(before)
                    for index in range(len(operands)-1,-1,-1):
                        retiring[len(prefix)+index]=null_word
                        sync(retiring);close(operands[index])
                    sync(prefix)
                    fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                status=ir.Constant(i32,0);retiring=list(before)
                for index,value in enumerate(operands):
                    retiring[len(prefix)+index]=null_word;sync(retiring)
                    prior=status
                    with builder.if_else(builder.icmp_signed('==',prior,ir.Constant(i32,0))) as (insert,cleanup):
                        with insert:
                            # AsPyObjectSteal promotes only borrowed words.
                            borrowed=builder.icmp_unsigned('!=',builder.and_(value,tag),zero)
                            with builder.if_then(borrowed):call('Py_IncRef',void,[raw(value)])
                            added=call('_PySet_AddTakeRef',i32,[result,raw(value)])
                            insert_end=builder.block
                        with cleanup:
                            close(value);cleanup_end=builder.block
                    status=builder.phi(i32);status.add_incoming(added,insert_end);status.add_incoming(prior,cleanup_end)
                with builder.if_then(builder.icmp_signed('!=',status,ir.Constant(i32,0))):
                    sync(prefix);call('Py_DecRef',void,[result])
                fail_if(builder.icmp_signed('!=',status,ir.Constant(i32,0)),prefix,pc)
                results=[helper('word_from_owned',word,[result])]
            elif name=='binary':
                if op.attributes.get('lowering')=='structure.getitem':
                    result=structure_calls.getitem(builder,raw(operands[0]),raw(operands[1]))
                else:
                    arguments=[raw(operands[0]),raw(operands[1])]+([pointer(None)] if arg in (8,21) else [])
                    def generic_binary():
                        # Specialized float bytecodes may choose a different NaN
                        # payload from the generic number-slot C function. Leave
                        # these exact operands at this original PC, once.
                        if arg in (0,5,10,13,18,23):
                            def field(value,offset,kind):
                                return builder.load(builder.bitcast(builder.gep(value,[integer(offset)]),kind.as_pointer()))
                            exact=builder.and_(
                                builder.icmp_unsigned('==',field(arguments[0],layout['object_type_offset'],p),integer(symbols.resolve('PyFloat_Type')).inttoptr(p)),
                                builder.icmp_unsigned('==',field(arguments[1],layout['object_type_offset'],p),integer(symbols.resolve('PyFloat_Type')).inttoptr(p)))
                            with builder.if_then(exact):
                                exponent=integer(0x7ff0000000000000)
                                bits=[field(value,layout['float_value_offset'],word) for value in arguments[:2]]
                                nonfinite=builder.or_(*(builder.icmp_unsigned('==',builder.and_(value,exponent),exponent) for value in bits))
                                resume_at(pc,before,nonfinite)
                        return call(BINARY[arg],p,arguments)
                    result=(numeric_ops.emit_binary(builder,arg,arguments[0],arguments[1],generic_binary)
                            if numeric_ops is not None and arg in (0,10,5) else generic_binary())
                fail_if(builder.icmp_unsigned('==',result,null_pointer),before,pc)
                value=helper('word_from_owned',word,[result])
                sync(prefix+[value,operands[1]]);close(operands[0])
                sync(prefix+[value,null_word]);close(operands[1])
                results=[value]
            elif name in ('contains','is'):
                if name=='contains':
                    if op.attributes.get('lowering')=='structure.contains':
                        status=structure_calls.contains(builder,raw(operands[1]),raw(operands[0]))
                    else:
                        status=call('PySequence_Contains',i32,[raw(operands[1]),raw(operands[0])])
                else:
                    status=builder.zext(builder.icmp_unsigned('==',raw(operands[0]),raw(operands[1])),i32)
                # IS_OP and CONTAINS_OP retire right, then left, including
                # user finalizers and their original source stack/PC.
                sync(prefix+[operands[0],null_word]);close(operands[1])
                sync(prefix+[null_word,null_word]);close(operands[0])
                sync(prefix)
                if name=='contains':fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),prefix,pc)
                status=builder.xor(status,ir.Constant(i32,arg))
                results=[builder.select(builder.icmp_signed('!=',status,ir.Constant(i32,0)),integer(id(True)|layout['tag_refcnt']),integer(id(False)|layout['tag_refcnt']))]
            elif name=='common_constant':results=[helper('common_constant',word,[integer(arg)])]
            elif name=='copy':
                if tagged_word(operands[0]) or reference_plan is not None and pc in reference_plan.skip_copy:
                    results=[operands[0]];reference_stats['noop_dups']+=1
                else:results=[helper('word_dup',word,[operands[0]])]
            elif name=='swap':prefix[-1],prefix[-arg]=prefix[-arg],prefix[-1]
            elif name=='to_bool':
                status=call('PyObject_IsTrue',i32,[raw(operands[0])])
                sync(prefix);close(operands[0])
                fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),prefix,pc)
                results=[builder.select(builder.icmp_signed('!=',status,ir.Constant(i32,0)),integer(id(True)|layout['tag_refcnt']),integer(id(False)|layout['tag_refcnt']))]
            elif name=='compare':
                result=call('PyObject_RichCompare',p,[raw(operands[0]),raw(operands[1]),ir.Constant(i32,arg>>5)])
                sync(prefix+[operands[0],null_word]);close(operands[1])
                sync(prefix+[null_word,null_word]);close(operands[0]);sync(prefix)
                fail_if(builder.icmp_unsigned('==',result,null_pointer),prefix,pc)
                if arg&16:
                    status=call('PyObject_IsTrue',i32,[result])
                    close(helper('word_from_owned',word,[result]))
                    fail_if(builder.icmp_signed('<',status,ir.Constant(i32,0)),prefix,pc)
                    results=[builder.select(builder.icmp_signed('!=',status,ir.Constant(i32,0)),integer(id(True)|layout['tag_refcnt']),integer(id(False)|layout['tag_refcnt']))]
                else:results=[helper('word_from_owned',word,[result])]
            elif name=='constant':
                # Same word as pinned PyStackRef_FromPyObjectNew's immortal
                # branch. Mortal constants retain the original owning helper.
                bits=immortal_constants.get(arg)
                results=[integer(bits) if bits is not None else
                         helper('word_newref',word,[pointer(code.co_consts[arg])])]
            elif name=='small_int':results=[integer(id(arg)|layout['tag_refcnt'])]
            elif name=='null':results=[null_word]
            elif name in ('pop','pop_iter'):sync(prefix);close(operands[0])
            elif name=='branch':
                spelling=op.instruction.opname
                target_object=None if spelling.endswith(('IF_NONE','IF_NOT_NONE')) else True
                condition=builder.icmp_unsigned('==',raw(operands[0]),pointer(target_object))
                if spelling in ('POP_JUMP_IF_NOT_NONE','POP_JUMP_IF_FALSE'):condition=builder.not_(condition)
                sync(prefix);close(operands[0])
            elif name=='yield':
                # CPython executes the original suspension instruction on its
                # real PyGenObject frame, retaining stack ownership unchanged.
                resume_at(pc,before)
            elif name=='return':
                if frame_entry:
                    # Tier 1 RETURN_VALUE promotes borrowed refs and pops the
                    # existing frame. Publish its original operand and PC.
                    resume_at(pc,before)
                else:
                    sync(prefix)
                    builder.ret(helper('word_return',p,[frame,operands[0],integer(pc)]))
            else:raise AssertionError(name)
            for result,value in zip(op.results,results):values[result.id]=value
            stack=prefix+results
            if name=='for_iter':
                taken=next(edge.target for edge in block.edges if edge.kind=='exhausted')
                fall=next(edge.target for edge in block.edges if edge.kind=='next')
                with builder.if_then(condition):observer_resume(prefix,taken)
                with builder.if_then(builder.not_(condition)):observer_resume(stack,fall)
            if name in {'get_yield_from_iter','cell.new','map_add','frame.delete','unary','intrinsic_unary','intrinsic_binary','load_special','load_build_class',
                        'list_append','set_add','list_extend','set_update','delete_attr','delete_subscr',
                        'frame.store_load','frame.store_store','match_class','load_dict_or_globals','get_aiter','get_anext','get_awaitable','get_iter','for_iter','pop_iter','unpack','unpack_ex',
                        'load_super_attr','format_simple','format_spec','convert','build_string',
                        'frame.store','cell.set','cell.delete','make_function','set_function_attribute',
                        'build_tuple','build_list','build_map','build_set','global.load','call','call_kw',
                        'load_attr','store_attr','store_subscr','binary','contains','is','pop','branch','import_name','import_from','to_bool','compare','global.store','global.delete','dict_update','dict_merge','get_iter','unpack','unpack_ex',
                        'frame.store_load','frame.store_store','pop_iter','load_super_attr','format_simple','format_spec','convert','build_slice','binary_slice','store_slice'}:
                if name=='branch':
                    taken=next(edge.target for edge in block.edges if edge.kind=='taken')
                    fall=next(edge.target for edge in block.edges if edge.kind=='fallthrough')
                    continuation=builder.select(condition,integer(taken),integer(fall))
                else:continuation=next_instruction[pc]
                if name!='for_iter':observer_resume(stack,continuation)
        if builder.block.is_terminated:continue
        normal=[e for e in block.edges if e.kind!='exception']
        if len(normal)==2:
            terminator=next(op for op in reversed(block.operations) if op.name!='exception_state')
            iterating=terminator.name=='for_iter'
            taken=next(e for e in normal if e.kind==('exhausted' if iterating else 'taken'))
            fall=next(e for e in normal if e.kind==('next' if iterating else 'fallthrough'))
            source=builder.block
            builder.cbranch(condition,edge_target(taken),edge_target(fall))
            incoming.extend((e,source) for e in normal if e.target in llvm_blocks)
        else:
            edge=normal[0]
            source=builder.block;builder.branch(edge_target(edge))
            if edge.target in llvm_blocks:incoming.append((edge,source))
    for edge,source in incoming:
        for argument,param in zip(edge.arguments,graph.blocks[edge.target].parameters):
            values[param.id].add_incoming(values[argument.id],source)
    lowered=_finish(graph,module,structure_calls,symbols,frame_entry=frame_entry,entry_offset=start,reference_plan=reference_plan,refcount_stats=reference_stats,numeric_ops=numeric_ops,abi='region-frame' if _region is not None else None,compile_options=compile_options,_emit_only=_emit_only)
    if library_calls:
        candidates=tuple(library_calls.values())
        lowered.providers+=candidates;lowered.execution_providers+=candidates
    if native_calls:
        candidates=tuple(native_calls.values())
        lowered.providers+=candidates;lowered.execution_providers+=candidates
    return lowered


def _finish(graph,module,structure_calls,symbols,*,frame_entry=False,entry_offset=None,reference_plan=None,refcount_stats=None,numeric_ops=None,abi=None,execution_owners=(),compile_options=(),_emit_only=False):
    target=binding.Target.from_default_triple().create_target_machine(opt=3)
    module.data_layout=str(target.target_data)
    providers=(provider,symbols)+execution_owners
    execution_providers=(provider,symbols.library)+execution_owners
    if structure_calls is not None:
        providers+=(structure_calls,structure_calls.keepalive)
        execution_providers+=structure_calls.keepalive
    if numeric_ops is not None:
        resources=(numeric_ops,)+numeric_ops.keepalive
        providers+=resources;execution_providers+=resources
    if _emit_only:
        return EmittedFunction(graph,module,providers,execution_providers,abi or ('frame' if frame_entry else 'vectorcall'),
            graph.entry if entry_offset is None else entry_offset,reference_plan,
            refcount_stats or {'active':False,'noop_closes':0,'noop_dups':0},compile_options)
    parsed=binding.parse_assembly(str(module))
    from .llvm_semantics import optimize_module
    optimize_module(parsed,target)
    engine=binding.create_mcjit_compiler(binding.parse_assembly(''),target)
    engine.add_module(parsed);engine.finalize_object()
    return LoweredFunction(graph,module,parsed,engine,engine.get_function_address('body'),providers,abi or ('frame' if frame_entry else 'vectorcall'),graph.entry if entry_offset is None else entry_offset,execution_providers,reference_plan,refcount_stats or {'active':False,'noop_closes':0,'noop_dups':0},compile_options=compile_options)


def _emit_readonly(builder,original,args,code,plan,calls,symbols,attribute_feedback=None,
                   *,saved_vectorcall=None,frameless_deopt=None,deopt_owners=None):
    """Borrowed vectorcall producer; semantic admission belongs to its entry.

    The saved-pointer ABI requires a cold emitter, which must terminate the
    block and may return a tuple of executable resource leases. It receives
    borrowed live locals and original byte offsets; it owns frame reification,
    caller-argument claims and source-independent plan lifetime.
    """
    pointer=ir.IntType(8).as_pointer();size=ir.IntType(64)
    null=ir.Constant(pointer,None)
    def integer(value):return ir.Constant(size,value)
    def capi(name,result,arguments):
        return builder.call(symbols.declare(builder.module,name,result,[v.type for v in arguments]),arguments)
    current=builder.load(builder.gep(args,[integer(plan.state_slot)]))
    owner=builder.load(builder.gep(args,[integer(plan.owner_slot)]))
    with builder.goto_entry_block():
        packed=builder.alloca(pointer,integer(code.co_argcount),name='resume_arguments')
    def saved_call(arguments):
        signature=ir.FunctionType(pointer,[pointer,pointer.as_pointer(),size,pointer])
        target=builder.bitcast(saved_vectorcall,signature.as_pointer())
        return builder.call(target,[original,arguments,integer(code.co_argcount),null])
    def done(value):
        if saved_vectorcall is not None and hasattr(calls,'new_reference'):
            builder.ret(calls.new_reference(builder,value))
        else:builder.ret(capi('Py_NewRef',pointer,[value]))
    def miss(value,*,cause_offset=None,next_offset=None):
        live=[]
        for index in range(code.co_argcount):
            item=builder.load(builder.gep(args,[integer(index)]))
            live.append(value if index==plan.state_slot else item)
            builder.store(live[-1],builder.gep(packed,[integer(index)]))
        if saved_vectorcall is None:
            builder.ret(capi('PyObject_Vectorcall',pointer,[original,packed,integer(code.co_argcount),null]))
            return
        leases=frameless_deopt(builder,original=original,args=args,fallback_args=packed,
            saved_vectorcall=saved_vectorcall,code=code,localsplus=tuple(live),symbols=symbols,
            cause_offset=plan.loop_offset if cause_offset is None else cause_offset,
            next_offset=plan.loop_offset if next_offset is None else next_offset)
        if not builder.block.is_terminated:
            raise ValueError('cold deopt emitter must terminate its block')
        if leases is not None:
            if type(leases) is not tuple:raise TypeError('cold deopt leases must be a tuple')
            deopt_owners.extend(leases)
    backedge=None
    if saved_vectorcall is not None:
        layout=provider.layout()
        thread=capi('PyThreadState_Get',pointer,[])
        breaker=builder.bitcast(builder.gep(thread,[integer(layout['thread_eval_breaker_offset'])]),size.as_pointer())
        def pending():
            flags=builder.and_(builder.load_atomic(breaker,'monotonic',8),integer(layout['eval_events_mask']))
            return builder.icmp_unsigned('!=',flags,integer(0))
        # Before any native iteration, the saved original entry preserves its
        # ordinary RESUME/binding/observation behavior.
        with builder.if_then(pending()):builder.ret(saved_call(args))
        backward=next(op.offset for op in dis.get_instructions(code) if op.opname=='JUMP_BACKWARD')
        def backedge(value):
            with builder.if_then(pending()):
                miss(value,cause_offset=backward,next_offset=backward)
    _emit_borrowed_loop(builder,code,plan,calls,symbols,current,owner,miss,done,
        backedge=backedge,attribute_feedback=attribute_feedback,
        fallback_name='readonly_original_current_state')


def _emit_borrowed_loop(builder,code,plan,calls,symbols,current,owner,on_miss,on_done,
                        *,backedge=None,attribute_feedback=None,fallback_name='readonly_generic_current_state'):
    """One guarded SSA traversal for both separately proved lifetime envelopes."""
    pointer=ir.IntType(8).as_pointer();size=ir.IntType(64);status=ir.IntType(32)
    function=builder.function;null=ir.Constant(pointer,None)
    def integer(value):return ir.Constant(size,value)
    def address(value):return integer(id(value)).inttoptr(pointer)
    def capi(name,result,arguments):
        return builder.call(symbols.declare(builder.module,name,result,[v.type for v in arguments]),arguments)
    loop_attribute=None
    def guarded_attribute(value):
        if loop_attribute is not None:return calls.try_load_attr_loop(builder,value,loop_attribute)
        if attribute_feedback is not None and hasattr(calls,'try_load_attr_cached'):
            return calls.try_load_attr_cached(builder,value,address(plan.attribute),attribute_feedback)
        return calls.try_load_attr(builder,value,address(plan.attribute))
    loop=function.append_basic_block('readonly_loop')
    fallback=function.append_basic_block(fallback_name)
    done=function.append_basic_block('readonly_return')
    misses=[]
    def miss_if(condition,value):
        continuation=function.append_basic_block('readonly_guard_hit')
        origin=builder.block;builder.cbranch(condition,fallback,continuation)
        misses.append((value,origin));builder.position_at_end(continuation)
        from .llvm_semantics import assume
        assume(builder,builder.not_(condition))
    if plan.kind=='mapping':
        mapping=guarded_attribute(owner)
        miss_if(builder.icmp_unsigned('==',mapping,null),current)
        proof=calls.identity_dict_guard(builder,mapping)
        miss_if(builder.icmp_signed('==',proof,ir.Constant(status,0)),current)
    if plan.kind=='attribute' and attribute_feedback is not None and hasattr(calls,'prepare_attribute_loop'):
        loop_attribute,ready=calls.prepare_attribute_loop(builder,current,attribute_feedback)
        miss_if(builder.not_(ready),current)
    origin=builder.block;builder.branch(loop);builder.position_at_end(loop)
    state=builder.phi(pointer,name='current');state.add_incoming(current,origin)
    count=None
    if backedge is None:
        count=builder.phi(size,name='chunk');count.add_incoming(integer(0),origin)
        miss_if(builder.icmp_unsigned('>=',count,integer(128)),state)
    if plan.kind=='attribute':
        next_value=guarded_attribute(state)
        miss_if(builder.icmp_unsigned('==',next_value,null),state)
        exhausted=builder.icmp_unsigned('==',next_value,address(None))
    else:
        key_proof=calls.identity_key_guard(builder,state)
        miss_if(builder.icmp_signed('==',key_proof,ir.Constant(status,0)),state)
        # Exact identity-hash/equality keys and resident domain: no allocation,
        # callbacks or exceptions. The unchanged dictionary pins the value.
        if hasattr(calls,'identity_dict_getitem'):
            next_value=calls.identity_dict_getitem(builder,mapping,state)
        else:next_value=capi('PyDict_GetItemWithError',pointer,[mapping,state])
        exhausted=builder.icmp_unsigned('==',next_value,null)
    advance=function.append_basic_block('readonly_advance')
    builder.cbranch(exhausted,done,advance);builder.position_at_end(advance)
    if backedge is not None:backedge(next_value)
    next_count=builder.add(count,integer(1)) if count is not None else None
    back=builder.block;builder.branch(loop);state.add_incoming(next_value,back)
    if count is not None:count.add_incoming(next_count,back)
    builder.position_at_end(done);on_done(state)
    builder.position_at_end(fallback)
    resume=builder.phi(pointer,name='resume_local')
    for value,block in misses:resume.add_incoming(value,block)
    on_miss(resume)
