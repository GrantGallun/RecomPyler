"""A watched constant invalidated by a callback resumes after that callback."""
import ctypes
import dis
import gc
from types import FunctionType
from llvmlite import ir,binding


def template(action):
    action()
    return watched


def make_entry(namespace):
    from recompyler import _source_frames_native as frames
    from recompyler.ir import _watchers_native,_deopt_native,_entry_native
    from recompyler.ir.watchers import watch_dependencies
    from recompyler.ir.deopt import FrameState,LiveValue,RefKind,ValueKind,DeoptMetadata,prepare,emit_guard
    from recompyler.ir.entry import create_callable
    from recompyler.ir.symbols import CPythonSymbols
    fn=FunctionType(template.__code__.replace(),namespace)
    handle=watch_dependencies(dicts=(namespace,))
    cached=namespace['watched']
    ins=list(dis.get_instructions(fn));pc=next(x.offset for x in ins if x.opname=='LOAD_GLOBAL')
    call_pc=next(x.offset for x in ins if x.opname=='CALL')
    pop_pc=next(x.offset for x in ins if x.opname=='POP_TOP')
    return_pc=next(x.offset for x in ins if x.opname=='RETURN_VALUE')
    plan=prepare(DeoptMetadata((LiveValue(0,RefKind.BORROWED,ValueKind.OBJECT),),
                              (FrameState(fn.__code__,pc,pc,(0,),()),)))
    symbols=CPythonSymbols()
    for name,address in frames.addresses().items():symbols.register_external('watch_deopt_'+name,address,frames)
    symbols.register_external('watch_deopt_valid',_watchers_native.addresses()['valid'],_watchers_native)
    symbols.register_external('watch_deopt_reify',_deopt_native.addresses()['reify'],_deopt_native)
    p=ir.IntType(8).as_pointer();n=ir.IntType(64);i=ir.IntType(32)
    module=ir.Module();body=ir.Function(module,ir.FunctionType(p,[p,p.as_pointer(),n,p]),'body')
    original,args,nargs,names=body.args;b=ir.IRBuilder(body.append_basic_block('entry'))
    def num(x):return ir.Constant(n,x)
    def obj(x):return num(id(x)).inttoptr(p)
    def call(name,result,values):return b.call(symbols.declare(module,name,result,[v.type for v in values]),values)
    null=ir.Constant(p,None)
    frame=call('watch_deopt_enter',p,[original,obj(fn.__code__),args,num(1),num(ins[0].offset)])
    with b.if_then(b.icmp_unsigned('==',frame,null)):b.ret(null)
    call('watch_deopt_mark',i,[frame,num(call_pc)])
    value=call('PyObject_CallNoArgs',p,[b.load(args)])
    with b.if_then(b.icmp_unsigned('==',value,null)):
        call('watch_deopt_leave_raw',i,[frame,ir.Constant(i,0),num(call_pc)]);b.ret(null)
    call('watch_deopt_mark',i,[frame,num(pop_pc)]);call('Py_DecRef',ir.VoidType(),[value])
    valid=call('watch_deopt_valid',i,[obj(handle)])
    def reify():
        words=b.alloca(n,num(1));b.store(b.ptrtoint(b.load(args),n),words)
        return call('watch_deopt_reify',i,[frame,obj(plan),words,num(1)])
    emit_guard(b,b.icmp_signed('!=',valid,ir.Constant(i,0)),frame=frame,plan=obj(plan),raw=None,count=None,
               reify=reify,resume=lambda:call('watch_deopt_resume_python',p,[frame]),
               error=lambda:call('watch_deopt_leave_raw',i,[frame,ir.Constant(i,0),num(pc)]))
    call('Py_IncRef',ir.VoidType(),[obj(cached)])
    b.ret(call('watch_deopt_word_return',p,[frame,b.ptrtoint(obj(cached),n),num(return_pc)]))
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    parsed=binding.parse_assembly(str(module));parsed.verify()
    engine=binding.create_mcjit_compiler(parsed,binding.Target.from_default_triple().create_target_machine());engine.finalize_object()
    # cached is borrowed from watched storage, never pinned by compilation.
    entry=create_callable(fn,engine.get_function_address('body'),(engine,handle,plan,symbols),
                          runner_address=frames.addresses()['run_vectorcall'])
    handle.bind(entry,_entry_native.invalidation_api())
    return entry,handle


def test_global_mutation_after_effect_deopts_without_replaying_effect():
    old=object();new=object();namespace={'watched':old};entry,handle=make_entry(namespace);events=[]
    def effect():events.append('effect');namespace['watched']=new
    assert entry(effect) is new and events==['effect'] and not handle.valid
    assert entry(lambda:events.append('fallback')) is new
    assert events==['effect','fallback']


def test_unchanged_global_uses_native_constant_without_owning_it():
    value=object();namespace={'watched':value};entry,handle=make_entry(namespace);events=[]
    assert entry(lambda:events.append('once')) is value
    assert events==['once'] and handle.valid


def test_invalidated_constant_dies_at_original_dict_mutation():
    events=[]
    class Token:
        def __del__(self):events.append('drop')
    namespace={'watched':Token()};entry,handle=make_entry(namespace);marker=object()
    def effect():namespace['watched']=marker;events.append('after mutation')
    assert entry(effect) is marker
    assert events==['drop','after mutation']
