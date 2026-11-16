"""Fresh-process probes for compile-only seeding of real generator frames."""
import ctypes,dis,gc,sys,weakref
from types import FunctionType,GeneratorType
from llvmlite import ir,binding
binding.initialize_native_target();binding.initialize_native_asmprinter()
from recompyler import _source_frames_native
from recompyler.ir.entry import install_frame_entry
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)

class ResumeBody:
    """Count entry and leave all real operands to the original next instruction."""
    def __init__(self,fn,pc):
        self.calls=ctypes.c_uint64();layout=_source_frames_native.layout()
        p=ir.IntType(8).as_pointer();word=ir.IntType(64)
        module=ir.Module();module.triple=binding.get_process_triple()
        body=ir.Function(module,ir.FunctionType(p,[p,word.as_pointer(),p]),'resume_probe')
        frame,stack,thread=body.args;b=ir.IRBuilder(body.append_basic_block('entry'))
        counter=ir.Constant(word,ctypes.addressof(self.calls)).inttoptr(word.as_pointer())
        b.store(b.add(b.load(counter),ir.Constant(word,1)),counter)
        executor=b.bitcast(b.gep(thread,[ir.Constant(word,layout['thread_executor_offset'])]),p.as_pointer())
        b.store(ir.Constant(p,None),executor)
        next_pc=next(op.offset for op in dis.get_instructions(fn) if op.offset>pc)
        target=ir.Constant(word,id(fn.__code__)+layout['code_data_offset']+next_pc).inttoptr(p)
        b.ret(target)
        machine=binding.Target.from_default_triple().create_target_machine()
        self.engine=binding.create_mcjit_compiler(binding.parse_assembly(''),machine)
        self.module=binding.parse_assembly(str(module));self.module.verify()
        self.engine.add_module(self.module);self.engine.finalize_object()
        self.address=self.engine.get_function_address('resume_probe')

def fresh(fn):return FunctionType(fn.__code__.replace(),fn.__globals__,fn.__name__,fn.__defaults__,fn.__closure__)
def resumes(fn):return [op.offset for op in dis.get_instructions(fn) if op.opname=='RESUME']

def case_initial():
    effects=[]
    def producer(value):
        effects.append(('start',value))
        while value:
            value=yield value
        return value
    fn=fresh(producer);code=fn.__code__;body=ResumeBody(fn,resumes(fn)[0])
    handle=install_frame_entry(fn,body.address,body,seed_arguments=(None,))
    assert not effects and body.calls.value==0 and fn.__code__ is code and handle.active
    marker=object();gen=fn(marker)
    assert type(gen) is GeneratorType and not effects and gen.gi_code is code
    assert next(gen) is marker and effects==[('start',marker)] and body.calls.value==1
    assert gen.gi_frame.f_locals['value'] is marker
    try:gen.send(None)
    except StopIteration as error:assert error.value is None
    else:raise AssertionError('generator did not return')
    assert gen.gi_frame is None and body.calls.value==1
    handle.close();assert not handle.active

def case_close_and_error():
    effects=[]
    def producer(value):
        effects.append('start')
        try:
            while value:
                value=yield value
        finally:
            effects.append(sys._getframe().f_code)
    fn=fresh(producer);body=ResumeBody(fn,resumes(fn)[0])
    handle=install_frame_entry(fn,body.address,body,seed_arguments=(None,))
    assert not effects and body.calls.value==0
    marker=object();gen=fn(marker);assert next(gen) is marker
    assert body.calls.value==1;gen.close();assert effects==['start',fn.__code__]
    error=LookupError('original');gen=fn(marker);assert next(gen) is marker
    try:gen.throw(error)
    except LookupError as caught:
        assert caught is error
        tb=caught.__traceback__
        while tb.tb_next:tb=tb.tb_next
        assert tb.tb_frame.f_code is fn.__code__
    else:raise AssertionError('throw lost original error')
    assert effects==['start',fn.__code__,'start',fn.__code__] and body.calls.value==2
    handle.close()

def case_post_yield():
    effects=[]
    def producer(value):
        while value:
            value=yield value
            effects.append(value)
        return value
    fn=fresh(producer);pc=resumes(fn)[1];body=ResumeBody(fn,pc)
    handle=install_frame_entry(fn,body.address,body,seed_arguments=(None,),entry_offset=pc)
    assert body.calls.value==0 and handle.active and not effects
    marker=object();other=object();gen=fn(marker)
    assert next(gen) is marker and body.calls.value==0
    assert gen.send(other) is other and body.calls.value==1
    try:gen.send(None)
    except StopIteration as error:assert error.value is None
    else:raise AssertionError('generator did not return')
    assert body.calls.value==2 and effects==[other,None]
    handle.close()

def case_multiple_offsets():
    effects=[]
    def producer(value):
        effects.append('start')
        while value:
            value=yield value
            effects.append(value)
    fn=fresh(producer);first,second=resumes(fn);a=ResumeBody(fn,first);b=ResumeBody(fn,second)
    ha=install_frame_entry(fn,a.address,a,seed_arguments=(None,))
    hb=install_frame_entry(fn,b.address,b,seed_arguments=(None,),entry_offset=second)
    assert not effects and a.calls.value==b.calls.value==0 and ha.active and hb.active
    marker=object();other=object();gen=fn(marker);assert next(gen) is marker
    assert gen.send(other) is other and a.calls.value==b.calls.value==1
    gen.close();ha.close();assert not ha.active and hb.active
    gen=fn(marker);assert next(gen) is marker and a.calls.value==1
    assert gen.send(other) is other and b.calls.value==2;gen.close()
    fn.__code__=fn.__code__.replace()
    assert not ha.active and not hb.active and hb.function is None
    hb.close()

def case_seed_decline():
    def producer(value):
        while value:
            value=yield value
        return value
    fn=fresh(producer);pc=resumes(fn)[1];body=ResumeBody(fn,pc)
    try:install_frame_entry(fn,body.address,body,seed_arguments=(None,),entry_offset=pc)
    except ValueError as error:assert 'declined frame entry seed' in str(error)
    else:raise AssertionError('canonical no-progress refusal was bypassed')
    assert body.calls.value==0

def case_reject_forged_generator():
    effects=[]
    def ordinary(value):
        effects.append(value)
        while value:
            value=None
        return value
    import inspect
    fn=FunctionType(ordinary.__code__.replace(co_flags=ordinary.__code__.co_flags|inspect.CO_GENERATOR),ordinary.__globals__,closure=ordinary.__closure__)
    body=ResumeBody(fn,resumes(fn)[0])
    try:install_frame_entry(fn,body.address,body,seed_arguments=(None,))
    except (ValueError,TypeError):pass
    else:raise AssertionError('forged producer was admitted')
    assert not effects and body.calls.value==0

if __name__=='__main__':
    case=sys.argv[1];globals()['case_'+case]();print('PASS '+case,flush=True)
