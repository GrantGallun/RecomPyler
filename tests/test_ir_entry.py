"""Raw LLVM body calls use a native vectorcall slot, exact guards and owners."""
import ctypes,gc,sys,weakref
from types import FunctionType
import pytest
from llvmlite import ir,binding


class NativeBody:
    def __init__(self,kind='identity'):
        from recompyler.ir.symbols import CPythonSymbols
        capi=CPythonSymbols();pointer=ir.IntType(8).as_pointer();size=ir.IntType(64)
        module=ir.Module(name='entry_fixture')
        fn=ir.Function(module,ir.FunctionType(pointer,[pointer,pointer.as_pointer(),size,pointer]),'test_body')
        builder=ir.IRBuilder(fn.append_basic_block('entry'))
        if kind=='identity':
            value=builder.load(fn.args[1]);inc=capi.declare(module,'Py_IncRef',ir.VoidType(),[pointer]);builder.call(inc,[value]);builder.ret(value)
        else:
            call=capi.declare(module,'PyObject_Vectorcall',pointer,[pointer,pointer.as_pointer(),size,pointer]);builder.ret(builder.call(call,list(fn.args)))
        guard=ir.Function(module,ir.FunctionType(ir.IntType(32),[pointer]),'reject_guard')
        ir.IRBuilder(guard.append_basic_block('entry')).ret(ir.Constant(ir.IntType(32),0))
        error_guard=ir.Function(module,ir.FunctionType(ir.IntType(32),[pointer]),'error_guard')
        eb=ir.IRBuilder(error_guard.append_basic_block('entry'))
        capi.install(['PyExc_ValueError'])
        exception=ir.GlobalVariable(module,pointer,'PyExc_ValueError')
        message=ir.GlobalVariable(module,ir.ArrayType(ir.IntType(8),6),'guard_message')
        message.initializer=ir.Constant(message.value_type,bytearray(b'guard\x00'))
        seterror=capi.declare(module,'PyErr_SetString',ir.VoidType(),[pointer,pointer])
        zero=ir.Constant(ir.IntType(32),0)
        eb.call(seterror,[eb.load(exception),eb.gep(message,[zero,zero])])
        eb.ret(ir.Constant(ir.IntType(32),-1))
        runner=ir.Function(module,ir.FunctionType(pointer,[pointer,pointer,pointer.as_pointer(),size,pointer]),'test_runner')
        rb=ir.IRBuilder(runner.append_basic_block('entry'))
        forward=capi.declare(module,'PyObject_Vectorcall',pointer,[pointer,pointer.as_pointer(),size,pointer])
        rb.ret(rb.call(forward,list(runner.args)[1:]))
        binding.initialize_native_target();binding.initialize_native_asmprinter()
        target=binding.Target.from_default_triple().create_target_machine()
        parsed=binding.parse_assembly(str(module));parsed.verify()
        self.engine=binding.create_mcjit_compiler(parsed,target);self.engine.finalize_object()
        self.address=self.engine.get_function_address('test_body')
        self.reject=self.engine.get_function_address('reject_guard')
        self.runner=self.engine.get_function_address('test_runner')
        self.error_guard=self.engine.get_function_address('error_guard')


def identity(value):return value

def original_path(value):return 'original',value

def with_default(value=42):return value

def invoke(action):return action()


def test_llvm_body_runs_without_python_bridge_and_preserves_owned_result():
    from recompyler.ir.entry import create_callable
    body=NativeBody();entry=create_callable(original_path,body.address,body)
    marker=object()
    assert entry(marker) is marker
    assert entry.__wrapped__ is original_path
    assert entry.__name__==original_path.__name__
    class Host:method=entry
    instance=Host()
    assert instance.method() is instance
    for _ in range(20):assert entry(marker) is marker


def test_native_guard_miss_original_vectorcalls_exactly_once():
    from recompyler.ir.entry import create_callable
    body=NativeBody();entry=create_callable(original_path,body.address,body,guards=(body.reject,))
    marker=object();assert entry(marker)==('original',marker)
    # Keywords and binding errors stay CPython's own when routed to original.
    assert entry(value=marker)==('original',marker)
    with pytest.raises(TypeError) as native:entry()
    with pytest.raises(TypeError) as expected:original_path()
    assert str(native.value)==str(expected.value)


def test_changed_code_and_defaults_invalidate_before_effects():
    from recompyler.ir.entry import create_callable
    body=NativeBody('forward')
    fn=FunctionType(with_default.__code__,globals(),argdefs=(42,))
    entry=create_callable(fn,body.address,body)
    assert entry()==42
    fn.__defaults__=(1234,);assert entry()==1234
    fn.__code__=original_path.__code__
    marker=object();assert entry(marker)==('original',marker)


def test_real_capi_error_owner_propagates_once_and_reentrant_calls_work():
    from recompyler.ir.entry import create_callable
    body=NativeBody('forward');entry=create_callable(invoke,body.address,body)
    events=[];error=ValueError('owned')
    def fail():events.append('once');raise error
    with pytest.raises(ValueError) as caught:entry(fail)
    assert caught.value is error and events==['once']
    marker=object()
    assert entry(lambda:entry(lambda:marker)) is marker


def test_entry_keeps_machine_code_alive_and_collects_reference_cycles():
    from recompyler.ir.entry import create_callable
    body=NativeBody();ref=weakref.ref(body)
    fn=FunctionType(identity.__code__,globals())
    entry=create_callable(fn,body.address,body)
    fn.entry_cycle=entry
    del body
    gc.collect();assert ref() is not None
    marker=object();assert entry(marker) is marker
    del entry,fn;gc.collect();assert ref() is None


@pytest.mark.parametrize('mode',['trace','profile','handled','monitor-global','monitor-local'])
def test_observation_guards_fallback_before_body(mode):
    from recompyler.ir.entry import create_callable
    body=NativeBody();entry=create_callable(original_path,body.address,body)
    marker=object();events=[]
    if mode=='handled':
        try:raise ValueError('active')
        except ValueError:assert entry(marker)==('original',marker)
    elif mode in ('trace','profile'):
        setter=sys.settrace if mode=='trace' else sys.setprofile
        previous=sys.gettrace() if mode=='trace' else sys.getprofile()
        def callback(frame,event,arg):
            if frame.f_code is original_path.__code__:events.append(event)
            return callback
        try:
            setter(callback);assert entry(marker)==('original',marker)
        finally:setter(previous)
        assert 'call' in events
    else:
        tool=4
        sys.monitoring.use_tool_id(tool,'wave18-ir-entry-test')
        sys.monitoring.register_callback(tool,sys.monitoring.events.PY_START,lambda code,offset:events.append(code))
        try:
            if mode=='monitor-local':sys.monitoring.set_local_events(tool,original_path.__code__,sys.monitoring.events.PY_START)
            else:sys.monitoring.set_events(tool,sys.monitoring.events.PY_START)
            assert entry(marker)==('original',marker)
            assert original_path.__code__ in events
        finally:
            sys.monitoring.set_events(tool,0)
            sys.monitoring.set_local_events(tool,original_path.__code__,0)
            sys.monitoring.register_callback(tool,sys.monitoring.events.PY_START,None)
            sys.monitoring.free_tool_id(tool)


def test_invalid_machine_entry_is_rejected_before_call():
    from recompyler.ir.entry import create_callable
    with pytest.raises(ValueError,match='address'):create_callable(identity,0,None)
    with pytest.raises(TypeError,match='function'):create_callable(len,123,None)

def test_invalidated_entry_does_not_pin_retired_default_owners():
    from recompyler.ir.entry import create_callable
    events=[]
    class Owner:
        def __del__(self):events.append('drop-default')
    body=NativeBody('forward')
    fn=FunctionType(with_default.__code__,globals(),argdefs=(Owner(),))
    entry=create_callable(fn,body.address,body)
    enabled=gc.isenabled();gc.disable()
    try:
        fn.__defaults__=None
        assert events==['drop-default']
        marker=object();assert entry(marker) is marker
    finally:
        if enabled:gc.enable()


def test_canonical_native_runner_hook_receives_original_vectorcall_inputs():
    from recompyler.ir.entry import create_callable
    body=NativeBody()
    entry=create_callable(original_path,body.address,body,runner_address=body.runner)
    marker=object()
    assert entry(marker)==('original',marker)
    assert entry(value=marker)==('original',marker)


def test_code_guard_prevents_obsolete_machine_body_execution():
    from recompyler.ir.entry import create_callable
    body=NativeBody()
    fn=FunctionType(original_path.__code__,globals())
    entry=create_callable(fn,body.address,body)
    marker=object();assert entry(marker) is marker
    def replaced(value):return ('replaced',value)
    fn.__code__=replaced.__code__
    assert entry(marker)==('replaced',marker)


def test_recursive_error_unwinds_native_entry_and_next_call_works():
    from recompyler.ir.entry import create_callable
    body=NativeBody('forward');entry=create_callable(invoke,body.address,body)
    def recurse():return entry(recurse)
    with pytest.raises(RecursionError):entry(recurse)
    marker=object();assert entry(lambda:marker) is marker


def test_native_guard_error_propagates_without_original_effects():
    from recompyler.ir.entry import create_callable
    body=NativeBody();entry=create_callable(original_path,body.address,body,guards=(body.error_guard,))
    with pytest.raises(ValueError,match='^guard$'):entry(object())


def test_two_native_calls_keep_separate_reentrant_operands():
    from concurrent.futures import ThreadPoolExecutor
    import threading
    from recompyler.ir.entry import create_callable
    body=NativeBody('forward');entry=create_callable(invoke,body.address,body)
    barrier=threading.Barrier(2)
    markers=object(),object()
    def run(marker):
        def callback():barrier.wait(timeout=10);return marker
        return entry(callback)
    with ThreadPoolExecutor(max_workers=2) as executor:
        jobs=[executor.submit(run,marker) for marker in markers]
        assert all(job.result(timeout=20) is marker for job,marker in zip(jobs,markers))

@pytest.mark.parametrize('before_creation',[False,True])
def test_changed_function_vectorcall_does_not_enter_obsolete_machine_body(before_creation):
    from recompyler.ir.entry import create_callable
    marker=object();replacement=object()
    prototype=ctypes.PYFUNCTYPE(ctypes.c_void_p,ctypes.py_object,ctypes.POINTER(ctypes.c_void_p),ctypes.c_size_t,ctypes.c_void_p)
    incref=ctypes.PYFUNCTYPE(None,ctypes.py_object)(('Py_IncRef',ctypes.pythonapi))
    @prototype
    def custom(original,args,nargsf,names):
        incref(replacement)
        return id(replacement)
    setter=ctypes.PYFUNCTYPE(None,ctypes.py_object,ctypes.c_void_p)(('PyFunction_SetVectorcall',ctypes.pythonapi))
    fn=FunctionType(identity.__code__,globals())
    if before_creation:setter(fn,ctypes.cast(custom,ctypes.c_void_p))
    body=NativeBody();entry=create_callable(fn,body.address,body)
    if not before_creation:
        assert entry(marker) is marker
        setter(fn,ctypes.cast(custom,ctypes.c_void_p))
    assert fn(marker) is replacement
    assert entry(marker) is replacement
