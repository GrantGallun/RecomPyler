"""A callback-free native lane materializes its canonical frame only on deopt."""
import ctypes
import dis
import sys
from llvmlite import ir,binding


def source(value):
    result=value+1
    return result


def lazy_entry():
    from recompyler import _source_frames_native as frames
    from recompyler.ir import _deopt_native
    from recompyler.ir.deopt import FrameState,LiveValue,RefKind,ValueKind,DeoptMetadata,prepare,emit_lazy_guard
    from recompyler.ir.entry import create_callable
    from recompyler.ir.symbols import CPythonSymbols
    instructions=list(dis.get_instructions(source));resume=instructions[0].offset;pc=instructions[1].offset
    plan=prepare(DeoptMetadata((LiveValue(0,RefKind.BORROWED,ValueKind.OBJECT),),
                              (FrameState(source.__code__,pc,pc,(0,-1),(),lazy=True),)))
    symbols=CPythonSymbols()
    for name,address in frames.addresses().items():symbols.register_external('lazy_test_'+name,address,frames)
    symbols.register_external('lazy_test_reify',_deopt_native.addresses()['reify'],_deopt_native)
    p=ir.IntType(8).as_pointer();n=ir.IntType(64);i=ir.IntType(32)
    module=ir.Module(name='lazy_frame_guard');body=ir.Function(module,ir.FunctionType(p,[p,p.as_pointer(),n,p]),'body')
    original,args,nargs,names=body.args;b=ir.IRBuilder(body.append_basic_block('entry'))
    def num(x):return ir.Constant(n,x)
    def obj(x):return num(id(x)).inttoptr(p)
    def call(name,result,values):return b.call(symbols.declare(module,name,result,[v.type for v in values]),values)
    count=ctypes.c_uint64()
    def materialize():
        counter=num(ctypes.addressof(count)).inttoptr(n.as_pointer())
        b.store(b.add(b.load(counter),num(1)),counter)
        return call('lazy_test_enter',p,[original,obj(source.__code__),args,num(1),num(resume)])
    def reify(frame):
        words=b.alloca(n,num(1));b.store(b.ptrtoint(b.load(args),n),words)
        return call('lazy_test_reify',i,[frame,obj(plan),words,num(1)])
    emit_lazy_guard(b,b.icmp_unsigned('==',b.load(args),obj(1)),materialize=materialize,reify=reify,
                    resume=lambda frame:call('lazy_test_resume_python',p,[frame]),
                    error=lambda frame:call('lazy_test_leave_raw',i,[frame,ir.Constant(i,0),num(pc)]))
    call('Py_IncRef',ir.VoidType(),[obj(2)]);b.ret(obj(2))
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    parsed=binding.parse_assembly(str(module));parsed.verify()
    engine=binding.create_mcjit_compiler(parsed,binding.Target.from_default_triple().create_target_machine());engine.finalize_object()
    entry=create_callable(source,engine.get_function_address('body'),(engine,plan,count,symbols),
                          runner_address=frames.addresses()['run_vectorcall'])
    return entry,count,str(module)


def test_successful_guard_never_materializes_a_frame():
    entry,count,module=lazy_entry()
    for _ in range(20):assert entry(1)==2
    assert count.value==0
    assert 'lazy_test_enter' not in module.split('br i1')[0]


def test_guard_failure_materializes_once_and_resumes_original_code():
    entry,count,_=lazy_entry()
    assert entry(9)==10 and count.value==1
    assert entry(1)==2 and count.value==1


def test_lazy_resume_callback_observes_original_frame_and_exact_local():
    entry,count,_=lazy_entry();seen=[];marker=object()
    class Spy:
        def __add__(self,other):
            frame=sys._getframe(1)
            seen.append((frame.f_code is source.__code__,frame.f_locals['value'] is self,other))
            return marker
    value=Spy()
    assert entry(value) is marker
    assert count.value==1 and seen==[(True,True,1)]
