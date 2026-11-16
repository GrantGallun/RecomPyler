"""Execute an effectful native prefix, reify live values, resume in CPython."""
import ctypes
import dis
import sys
import weakref
import pytest
from llvmlite import ir, binding


def effect_source(action):
    saved = action('before')
    action('after')
    return saved


def make_entry(function=effect_source, primitive=None,cell_map=False,return_stack=False,pass_guard=False):
    from recompyler import _source_frames_native as frames
    from recompyler.ir.deopt import FrameState,LiveValue,RefKind,ValueKind,DeoptMetadata,prepare
    from recompyler.ir.entry import create_callable
    from recompyler.ir.symbols import CPythonSymbols
    instructions=list(dis.get_instructions(function))
    store=next(x for x in instructions if x.opname in ('STORE_FAST','STORE_DEREF') and x.argval=='saved')
    pc=next(x.offset for x in instructions if x.opname=='RETURN_VALUE') if return_stack else next(x.offset for x in instructions if x.offset>store.offset)
    value_kind=ValueKind.OBJECT if primitive is None else primitive[0]
    metadata=DeoptMetadata((LiveValue(0,RefKind.BORROWED,ValueKind.OBJECT),
                            LiveValue(1,RefKind.OWNED if primitive is None else RefKind.UNCOUNTED,value_kind)),
                           (FrameState(function.__code__,pc,pc,(0,-1,1) if cell_map else (0,1),(1,) if return_stack else ()),))
    plan=prepare(metadata)
    symbols=CPythonSymbols()
    for name,addr in frames.addresses().items(): symbols.register_external('deopt_test_'+name,addr,frames)
    from recompyler.ir import _deopt_native
    symbols.register_external('deopt_test_reify',_deopt_native.addresses()['reify'],_deopt_native)
    p=ir.IntType(8).as_pointer();n=ir.IntType(64);i=ir.IntType(32)
    module=ir.Module(name='deopt_prefix')
    body=ir.Function(module,ir.FunctionType(p,[p,p.as_pointer(),n,p]),'body')
    original,args,nargs,names=body.args
    b=ir.IRBuilder(body.append_basic_block('entry'))
    def num(x): return ir.Constant(n,x)
    def obj(x): return num(id(x)).inttoptr(p)
    def call(name,result,values): return b.call(symbols.declare(module,name,result,[v.type for v in values]),values)
    null=ir.Constant(p,None)
    resume=next(x.offset for x in instructions if x.opname=='RESUME')
    frame=call('deopt_test_enter',p,[original,obj(function.__code__),args,num(1),num(resume)])
    with b.if_then(b.icmp_unsigned('==',frame,null)): b.ret(null)
    action=b.load(args)
    saved=call('PyObject_CallOneArg',p,[action,obj('before')])
    with b.if_then(b.icmp_unsigned('==',saved,null)):
        call('deopt_test_leave_raw',i,[frame,ir.Constant(i,0),num(pc)]);b.ret(null)
    words=b.alloca(n,num(2))
    b.store(b.ptrtoint(action,n),words)
    raw=b.ptrtoint(saved,n) if primitive is None else num(primitive[1])
    b.store(raw,b.gep(words,[num(1)]))
    if pass_guard:
        from recompyler.ir.deopt import emit_guard
        emit_guard(b,ir.Constant(ir.IntType(1),1),frame=frame,plan=obj(plan),
                   raw=words,count=num(2),reify=lambda:call('deopt_test_reify',i,[frame,obj(None),words,num(2)]),
                   resume=lambda:call('deopt_test_resume_python',p,[frame]),
                   error=lambda:call('deopt_test_leave_raw',i,[frame,ir.Constant(i,0),num(pc)]))
        word=b.ptrtoint(saved,n)
        b.ret(call('deopt_test_word_return',p,[frame,word,num(pc)]))
    else:
        result=call('deopt_test_reify',i,[frame,obj(plan),words,num(2)])
    if not pass_guard: call('Py_DecRef',ir.VoidType(),[saved])
    if not pass_guard:
      with b.if_then(b.icmp_signed('<',result,ir.Constant(i,0))):
        call('deopt_test_leave_raw',i,[frame,ir.Constant(i,0),num(pc)]);b.ret(null)
      b.ret(call('deopt_test_resume_python',p,[frame]))
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    parsed=binding.parse_assembly(str(module));parsed.verify()
    engine=binding.create_mcjit_compiler(parsed,binding.Target.from_default_triple().create_target_machine());engine.finalize_object()
    keepalive=(engine,plan,metadata,'before',symbols)
    return create_callable(function,engine.get_function_address('body'),keepalive,
                           runner_address=frames.addresses()['run_vectorcall'])


def test_guard_after_effect_resumes_without_replaying_prefix():
    entry=make_entry();events=[];marker=object()
    def action(phase): events.append(phase);return marker
    assert entry(action) is marker
    assert events==['before','after']


def test_resumed_callback_sees_original_frame_and_live_locals():
    entry=make_entry();marker=object();seen=[]
    def action(phase):
        if phase=='after':
            frame=sys._getframe(1)
            seen.append((frame.f_code is effect_source.__code__,frame.f_locals['saved'] is marker))
        return marker
    assert entry(action) is marker
    assert seen==[(True,True)]


def test_resumed_exception_retains_original_local_and_original_pc():
    entry=make_entry();refs=[];events=[]
    class Token:
        def __del__(self): events.append('drop')
    def action(phase):
        if phase=='before':
            token=Token();refs.append(weakref.ref(token));return token
        raise LookupError('after guard')
    with pytest.raises(LookupError) as caught: entry(action)
    trace=caught.value.__traceback__
    while trace and trace.tb_frame.f_code is not effect_source.__code__: trace=trace.tb_next
    assert trace is not None and refs[0]() is not None and events==[]
    assert trace.tb_lasti==[x.offset for x in dis.get_instructions(effect_source) if x.opname=='CALL'][1]
    del trace
    error=caught.value
    del caught
    error.__traceback__=None
    assert refs[0]() is None and events==['drop']


@pytest.mark.parametrize('kind,bits,expected', [('SIGNED',(1<<64)-7,-7),('UNSIGNED',1<<63,1<<63),('DOUBLE',0x8000000000000000,-0.0),('BOOL',1,True)])
def test_unboxed_resume_preserves_exact_numeric_type_and_value(kind,bits,expected):
    from recompyler.ir.deopt import ValueKind
    entry=make_entry(primitive=(ValueKind[kind],bits))
    result=entry(lambda phase: None)
    assert type(result) is type(expected) and result==expected
    if kind=='DOUBLE':
        import math
        assert math.copysign(1,result)==-1

def cell_source(action):
    saved=action('before')
    def child(): return saved
    action('after')
    return saved


def test_reify_rejects_non_cell_before_interpreter_can_dereference_it():
    entry=make_entry(cell_source,cell_map=True)
    events=[]
    def action(phase): events.append(phase);return object()
    with pytest.raises(RuntimeError,match='cell|stale'): entry(action)
    assert events==['before']

def stack_source(action):
    saved=action('before')
    return saved


def test_reify_value_stack_preserves_alias_with_local():
    entry=make_entry(stack_source,return_stack=True)
    marker=object();events=[]
    def action(phase): events.append(phase);return marker
    assert entry(action) is marker and events==['before']


def test_successful_guard_never_calls_reification_or_allocates_a_plan_at_runtime():
    entry=make_entry(stack_source,return_stack=True,pass_guard=True)
    marker=object();events=[]
    def action(phase): events.append(phase);return marker
    assert entry(action) is marker and events==['before']

def compile_frame_deopt(function, *, pending=False):
    """Test-only frame-ABI prefix; use the existing entry and interpreter cleanup."""
    from recompyler import _source_frames_native as frames
    from recompyler.ir import _deopt_native
    from recompyler.ir.deopt import FrameState,LiveValue,RefKind,ValueKind,DeoptMetadata,prepare
    from recompyler.ir.entry import install_frame_entry
    from recompyler.ir.symbols import CPythonSymbols
    instructions=list(dis.get_instructions(function))
    calls=[op for op in instructions if op.opname=='CALL']
    store=next(op for op in instructions if op.opname=='STORE_FAST' and op.argval=='saved')
    pc=calls[1].offset if pending else next(op.offset for op in instructions if op.offset>store.offset)
    phase=next(op.argval for op in instructions if op.offset<calls[1].offset and op.opname=='LOAD_CONST' and op.argval in ('after','guard'))
    live=(LiveValue(0,RefKind.BORROWED,ValueKind.OBJECT),LiveValue(1,RefKind.OWNED,ValueKind.OBJECT),LiveValue(2,RefKind.BORROWED,ValueKind.OBJECT))
    plan=prepare(DeoptMetadata(live,(FrameState(function.__code__,pc,pc,(0,1),(0,-1,2) if pending else ()),)))
    symbols=CPythonSymbols();symbols.register_external('frame_deopt_reify',_deopt_native.addresses()['reify'],_deopt_native)
    p=ir.IntType(8).as_pointer();n=ir.IntType(64);i=ir.IntType(32)
    module=ir.Module(name='actual_frame_deopt')
    body=ir.Function(module,ir.FunctionType(p,[p,n.as_pointer(),p]),'body')
    frame,stack,thread=body.args;b=ir.IRBuilder(body.append_basic_block('entry'))
    def num(x):return ir.Constant(n,x)
    def obj(x):return num(id(x)).inttoptr(p)
    def call(name,result,args):return b.call(symbols.declare(module,name,result,[x.type for x in args]),args)
    layout=frames.layout();null=ir.Constant(p,None)
    ip=b.bitcast(b.gep(frame,[num(layout['instrptr_offset'])]),p.as_pointer())
    codebase=b.gep(obj(function.__code__),[num(layout['code_data_offset'])])
    localsbase=b.bitcast(b.gep(frame,[num(layout['locals_offset'])]),n.as_pointer())
    action=b.inttoptr(b.and_(b.load(localsbase),num((1<<64)-2)),p)
    calls_counter=ctypes.c_uint64()
    counter=num(ctypes.addressof(calls_counter)).inttoptr(n.as_pointer())
    b.store(b.add(b.load(counter),num(1)),counter)
    b.store(b.gep(codebase,[num(calls[0].offset)]),ip)
    saved=call('PyObject_CallOneArg',p,[action,obj('before')])
    with b.if_then(b.icmp_unsigned('==',saved,null)):b.ret(null)
    if pending:
        # The original source local owns the result while the second call runs.
        # This raw pointer is already a NEW reference, transferred to its slot.
        b.store(b.ptrtoint(saved,n),b.gep(localsbase,[num(1)]))
        b.store(b.gep(codebase,[num(pc)]),ip)
        ignored=call('PyObject_CallOneArg',p,[action,obj(phase)])
        with b.if_then(b.icmp_unsigned('!=',ignored,null)):
            call('Py_DecRef',ir.VoidType(),[ignored])
            call('PyErr_SetString',ir.VoidType(),[obj(SystemError),obj('expected pending test exception')])
    words=b.alloca(n,num(3))
    for index,value in enumerate((action,saved,obj(phase))):b.store(b.ptrtoint(value,n),b.gep(words,[num(index)]))
    result=call('frame_deopt_reify',i,[frame,obj(plan),words,num(3)])
    if not pending:call('Py_DecRef',ir.VoidType(),[saved])
    with b.if_then(b.icmp_signed('<',result,ir.Constant(i,0))):b.ret(null)
    b.ret(null if pending else b.gep(codebase,[num(pc)]))
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    parsed=binding.parse_assembly(str(module));parsed.verify()
    engine=binding.create_mcjit_compiler(parsed,binding.Target.from_default_triple().create_target_machine());engine.finalize_object()
    class Owner:pass
    owner=Owner();owner.engine=engine;owner.plan=plan;owner.phase=phase;owner.before='before';owner.calls=calls_counter;owner.symbols=symbols
    handle=install_frame_entry(function,engine.get_function_address('body'),owner,seed_arguments=(None,))
    return handle,owner
