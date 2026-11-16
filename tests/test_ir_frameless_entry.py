"""Original functions use a saved vectorcall slot without creating a frame."""
import ctypes
import gc
import sys
import weakref
from types import FunctionType
import pytest
from llvmlite import binding, ir


def identity(value): return value

def original_path(value=42): return ('original', value)


class Body:
    """Five-argument body; cold calls use the saved slot directly."""
    def __init__(self, *, forward=False):
        from recompyler.ir.symbols import CPythonSymbols
        symbols = CPythonSymbols()
        p, n = ir.IntType(8).as_pointer(), ir.IntType(64)
        signature = ir.FunctionType(p, [p, p.as_pointer(), n, p])
        module = ir.Module(name='frameless_entry_fixture')
        fn = ir.Function(module, ir.FunctionType(p, signature.args + (p,)), 'body')
        original, args, nargsf, names, saved = fn.args
        b = ir.IRBuilder(fn.append_basic_block('entry'))
        self.calls = ctypes.c_uint64()
        if not forward:
            count = b.and_(nargsf, ir.Constant(n, (1 << 63) - 1))
            admitted = b.and_(b.icmp_unsigned('==', count, ir.Constant(n, 1)),
                              b.icmp_unsigned('==', names, ir.Constant(p, None)))
            native, cold = fn.append_basic_block('native'), fn.append_basic_block('cold')
            b.cbranch(admitted, native, cold)
            b.position_at_end(native)
            counter = ir.Constant(n, ctypes.addressof(self.calls)).inttoptr(n.as_pointer())
            b.store(b.add(b.load(counter), ir.Constant(n, 1)), counter)
            value = b.load(args)
            inc = symbols.declare(module, 'Py_IncRef', ir.VoidType(), [p])
            b.call(inc, [value]); b.ret(value)
            b.position_at_end(cold)
        b.ret(b.call(b.bitcast(saved, signature.as_pointer()), [original, args, nargsf, names]))
        binding.initialize_native_target(); binding.initialize_native_asmprinter()
        parsed = binding.parse_assembly(str(module)); parsed.verify()
        self.engine = binding.create_mcjit_compiler(parsed, binding.Target.from_default_triple().create_target_machine())
        self.engine.finalize_object()
        self.address = self.engine.get_function_address('body')


def install(fn, body):
    from recompyler.ir.entry import install_vectorcall_entry
    return install_vectorcall_entry(fn, body.address, body)


def test_original_function_identity_descriptor_code_and_warmed_calls():
    body = Body(); fn = FunctionType(original_path.__code__, globals(), argdefs=(42,))
    code, marker = fn.__code__, object()
    for _ in range(100): assert fn(marker) == ('original', marker)
    with install(fn, body) as handle:
        assert isinstance(fn, FunctionType) and fn.__code__ is code
        assert handle.function is fn and handle.active
        class Host: method = fn
        host = Host(); assert host.method() is host
        for _ in range(1000): assert fn(marker) is marker
        assert body.calls.value == 1001
    assert not handle.active and fn(marker) == ('original', marker)


def test_saved_pointer_fallback_keeps_keywords_binding_errors_and_defaults():
    body = Body(); fn = FunctionType(original_path.__code__, globals(), argdefs=(42,))
    with install(fn, body):
        marker = object()
        assert fn(value=marker) == ('original', marker)
        assert fn() == ('original', 42)
        with pytest.raises(TypeError) as got: fn(1, 2)
        expected = FunctionType(original_path.__code__, globals(), argdefs=(42,))
        with pytest.raises(TypeError) as want: expected(1, 2)
        assert str(got.value) == str(want.value)
        assert body.calls.value == 0


@pytest.mark.parametrize('mutation', ['code', 'defaults', 'kwdefaults'])
def test_function_mutation_restores_original_slot(mutation):
    body = Body(); fn = FunctionType(original_path.__code__, globals(), argdefs=(42,))
    with install(fn, body) as handle:
        marker = object(); assert fn(marker) is marker
        if mutation == 'code':
            fn.__code__ = identity.__code__; assert fn(marker) is marker
        elif mutation == 'defaults':
            fn.__defaults__ = (marker,); assert fn() == ('original', marker)
        else:
            fn.__kwdefaults__ = {'unused': marker}; assert fn(marker) == ('original', marker)
        assert not handle.active and body.calls.value == 1


@pytest.mark.parametrize('mode', ['trace', 'profile', 'handled', 'monitor'])
def test_observation_falls_back_to_real_original_frame(mode):
    body = Body(); fn = FunctionType(original_path.__code__, globals(), argdefs=(42,)); seen = []
    with install(fn, body):
        marker = object()
        if mode == 'handled':
            try: raise ValueError('active')
            except ValueError: assert fn(marker) == ('original', marker)
        elif mode in ('trace', 'profile'):
            setter = sys.settrace if mode == 'trace' else sys.setprofile
            previous = sys.gettrace() if mode == 'trace' else sys.getprofile()
            def callback(frame, event, arg):
                if frame.f_code is fn.__code__: seen.append(event)
                return callback
            try:
                setter(callback); assert fn(marker) == ('original', marker)
            finally: setter(previous)
            assert 'call' in seen
        else:
            tool, event = 4, sys.monitoring.events.PY_START
            sys.monitoring.use_tool_id(tool, 'wave17-frameless-test')
            sys.monitoring.register_callback(tool, event, lambda code, offset: seen.append(code))
            try:
                sys.monitoring.set_local_events(tool, fn.__code__, event)
                assert fn(marker) == ('original', marker)
                assert fn.__code__ in seen
            finally:
                sys.monitoring.set_local_events(tool, fn.__code__, 0)
                sys.monitoring.register_callback(tool, event, None)
                sys.monitoring.free_tool_id(tool)
        assert body.calls.value == 0


def test_function_is_not_retained_and_machine_code_owner_is_released():
    body = Body(); fn = FunctionType(identity.__code__, globals())
    fn_ref, owner_ref = weakref.ref(fn), weakref.ref(body)
    handle = install(fn, body)
    del fn, body
    gc.collect()
    assert fn_ref() is None and not handle.active and handle.function is None
    handle.close(); gc.collect()
    assert owner_ref() is None


def test_close_during_saved_call_keeps_executing_owner_alive():
    def source(action): return action()
    body = Body(forward=True); fn = FunctionType(source.__code__, globals())
    owner_ref = weakref.ref(body); handle = install(fn, body); del body
    marker = object()
    def callback():
        handle.close(); gc.collect()
        assert owner_ref() is not None
        return marker
    assert fn(callback) is marker
    gc.collect(); assert owner_ref() is None


def test_foreign_slot_is_not_overwritten_on_close_and_foreign_install_is_refused():
    prototype = ctypes.PYFUNCTYPE(ctypes.c_void_p, ctypes.py_object, ctypes.POINTER(ctypes.c_void_p), ctypes.c_size_t, ctypes.c_void_p)
    incref = ctypes.PYFUNCTYPE(None, ctypes.py_object)(('Py_IncRef', ctypes.pythonapi))
    setter = ctypes.PYFUNCTYPE(None, ctypes.py_object, ctypes.c_void_p)(('PyFunction_SetVectorcall', ctypes.pythonapi))
    marker = object()
    @prototype
    def custom(original, args, nargsf, names):
        incref(marker); return id(marker)
    body = Body(); fn = FunctionType(identity.__code__, globals()); handle = install(fn, body)
    setter(fn, ctypes.cast(custom, ctypes.c_void_p))
    assert not handle.active
    handle.close(); assert fn(None) is marker
    with pytest.raises(ValueError, match='vectorcall'): install(fn, body)


def test_discarding_handle_restores_slot_and_releases_owner():
    body = Body(); fn = FunctionType(original_path.__code__, globals(), argdefs=(42,))
    handle = install(fn, body); ref = weakref.ref(handle)
    marker = object(); assert fn(marker) is marker
    del handle; gc.collect()
    assert ref() is None and fn(marker) == ('original', marker)


def test_cold_exceptions_and_reentry_keep_original_traceback():
    def source(action): return action()
    body = Body(forward=True); fn = FunctionType(source.__code__, globals())
    with install(fn, body):
        error = ValueError('original failure')
        def fail(): raise error
        with pytest.raises(ValueError) as caught: fn(fail)
        assert caught.value is error
        frames = []; tb = caught.value.__traceback__
        while tb:
            frames.append(tb.tb_frame.f_code); tb = tb.tb_next
        assert frames.count(fn.__code__) == 1
        marker = object(); assert fn(lambda: fn(lambda: marker)) is marker


def test_no_jit_process_installs_original_function():
    import os
    import subprocess
    from pathlib import Path
    root = Path(__file__).resolve().parents[1]
    env = dict(os.environ, PYTHON_JIT='0', PYTHONPATH=str(root / 'src'))
    script = '''import runpy,sys,ctypes
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
assert not sys._jit.is_enabled()
m=runpy.run_path('tests/test_ir_frameless_entry.py')
body=m['Body']();fn=m['FunctionType'](m['original_path'].__code__,globals(),argdefs=(42,))
with m['install'](fn,body):
    marker=object();assert fn(marker) is marker;assert body.calls.value==1
assert fn(marker)==('original',marker)
'''
    result = subprocess.run([sys.executable, '-c', script], cwd=root, env=env,
                            capture_output=True, text=True, timeout=30,
                            creationflags=0x4000 | 0x08000000)
    assert result.returncode == 0, result.stdout + result.stderr


def test_invalid_installation_does_not_publish_a_slot():
    from recompyler.ir.entry import install_vectorcall_entry
    with pytest.raises(TypeError, match='function'):
        install_vectorcall_entry(len, 123, None)
    with pytest.raises(ValueError, match='address'):
        install_vectorcall_entry(identity, 0, None)
    body = Body(); fn = FunctionType(identity.__code__, globals())
    with install(fn, body):
        with pytest.raises(ValueError, match='vectorcall'): install(fn, body)


def test_shared_dependency_invalidator_restores_original_slot():
    from recompyler.ir import _entry_native
    from recompyler.ir.watchers import watch_dependencies
    values = {'name': 1}; dependency = watch_dependencies(dicts=(values,))
    body = Body(); fn = FunctionType(original_path.__code__, globals(), argdefs=(42,))
    with install(fn, body) as handle:
        dependency.bind(handle, _entry_native.invalidation_api())
        marker = object(); assert fn(marker) is marker
        values['name'] = 2
        assert not handle.active and fn(marker) == ('original', marker)


@pytest.mark.parametrize('mode', ['active', 'dormant', 'late-registration'])
def test_complete_monitoring_call_events_match_original(mode):
    body = Body(); fn = FunctionType(original_path.__code__, globals(), argdefs=(42,))
    tool = 4; events = []; handle = None
    call = sys.monitoring.events.CALL
    returned = sys.monitoring.events.C_RETURN
    raised = sys.monitoring.events.C_RAISE
    mask = call | returned | raised
    def invoke(value): return fn(value)
    def register():
        for event, name in ((call, 'CALL'), (returned, 'C_RETURN'), (raised, 'C_RAISE')):
            def callback(code, offset, callee, arg, name=name):
                if callee is fn: events.append((name, code, offset))
            sys.monitoring.register_callback(tool, event, callback)
    def unregister():
        for event in (call, returned, raised): sys.monitoring.register_callback(tool, event, None)
    sys.monitoring.use_tool_id(tool, 'wave17-frameless-call-events')
    try:
        register(); sys.monitoring.set_events(tool, mask)
        marker = object(); assert invoke(marker) == ('original', marker)
        expected = list(events); events.clear()
        sys.monitoring.set_events(tool, 0)
        if mode == 'active':
            sys.monitoring.set_events(tool, mask)
            handle = install(fn, body)
        elif mode == 'dormant':
            handle = install(fn, body)
            sys.monitoring.set_events(tool, mask)
        else:
            unregister(); handle = install(fn, body)
            assert handle.active
            register(); sys.monitoring.set_events(tool, mask)
        assert invoke(marker) == ('original', marker)
        assert events == expected
        assert not handle.active and body.calls.value == 0
    finally:
        sys.monitoring.set_events(tool, 0); unregister(); sys.monitoring.free_tool_id(tool)
        if handle is not None: handle.close()


@pytest.mark.parametrize('mode', ['veto', 'mutation'])
def test_audit_registration_cannot_publish_an_unguarded_or_stale_body(mode):
    import os
    import subprocess
    from pathlib import Path
    root = Path(__file__).resolve().parents[1]
    env = dict(os.environ, PYTHON_JIT='0', PYTHONPATH=str(root / 'src'))
    script = '''import ctypes,runpy,sys
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
m=runpy.run_path('tests/test_ir_frameless_entry.py');body=m['Body']()
fn=m['FunctionType'](m['original_path'].__code__,globals(),argdefs=(42,))
def replacement(value):return ('changed',value)
def audit(event,args):
    if event=='sys.addaudithook':
        if sys.argv[1]=='veto':raise RuntimeError('do not register')
        fn.__code__=replacement.__code__
sys.addaudithook(audit)
with m['install'](fn,body) as handle:
    assert not handle.active
    marker=object();expected='original' if sys.argv[1]=='veto' else 'changed'
    assert fn(marker)==(expected,marker)
assert body.calls.value==0
'''
    result = subprocess.run([sys.executable, '-c', script, mode], cwd=root, env=env,
                            capture_output=True, text=True, timeout=30,
                            creationflags=0x4000 | 0x08000000)
    assert result.returncode == 0, result.stdout + result.stderr


@pytest.mark.parametrize('jit', ['0', '1'])
def test_warmed_callers_keep_exercising_every_original_function_entry(jit):
    import os
    import subprocess
    from pathlib import Path
    root = Path(__file__).resolve().parents[1]
    env = dict(os.environ, PYTHON_JIT=jit, PYTHONPATH=str(root / 'src'))
    script = '''import ctypes,runpy
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
m=runpy.run_path('tests/test_ir_frameless_entry.py');body=m['Body']()
fn=m['FunctionType'](m['original_path'].__code__,globals(),argdefs=(42,))
def global_loop(value):
    for _ in range(120000):result=fn(value)
    return result
def parameter_loop(call,value):
    for _ in range(120000):result=call(value)
    return result
marker=object()
assert global_loop(marker)==('original',marker)
assert parameter_loop(fn,marker)==('original',marker)
with m['install'](fn,body) as handle:
    assert global_loop(marker) is marker
    assert body.calls.value==120000 and handle.active
    assert parameter_loop(fn,marker) is marker
    assert body.calls.value==240000 and handle.active
'''
    result = subprocess.run([sys.executable, '-c', script], cwd=root, env=env,
                            capture_output=True, text=True, timeout=30,
                            creationflags=0x4000 | 0x08000000)
    assert result.returncode == 0, result.stdout + result.stderr


def test_internal_observer_does_not_disable_existing_native_guards():
    from recompyler import _heap
    target = FunctionType(identity.__code__, globals())
    code = target.__code__; guards = {0: ('code', target, code)}
    body = Body(); fn = FunctionType(original_path.__code__, globals(), argdefs=(42,))
    with install(fn, body):
        assert _heap.check_heap_guards(guards) is True
        target.__code__ = original_path.__code__
        assert _heap.check_heap_guards(guards) is False
    assert _heap.check_heap_guards({}) is True


def test_python_replacement_cannot_claim_passive_native_audit_registration():
    import os
    import subprocess
    from pathlib import Path
    root = Path(__file__).resolve().parents[1]
    env = dict(os.environ, PYTHON_JIT='0', PYTHONPATH=str(root / 'src'))
    script = '''import ctypes,runpy
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
from recompyler import _heap
_heap._register_passive_attribute_audit=lambda capsule:True
m=runpy.run_path('tests/test_ir_frameless_entry.py');body=m['Body']()
fn=m['FunctionType'](m['original_path'].__code__,globals(),argdefs=(42,))
with m['install'](fn,body) as handle:
    assert not handle.active
    marker=object();assert fn(marker)==('original',marker)
assert _heap.check_heap_guards({}) is True
'''
    result = subprocess.run([sys.executable, '-c', script], cwd=root, env=env,
                            capture_output=True, text=True, timeout=30,
                            creationflags=0x4000 | 0x08000000)
    assert result.returncode == 0, result.stdout + result.stderr


def test_borrowed_c_api_caller_keeps_original_function_alive_until_body_returns():
    from recompyler.ir.entry import install_vectorcall_entry
    from recompyler.ir.symbols import CPythonSymbols
    events = []; holder = {}; reference = None
    def clear(): holder.clear()
    def witness(): events.append(reference() is not None)
    namespace = {'clear': clear, 'witness': witness}
    exec('def source():\n clear()\n witness()\n', namespace)
    fn = namespace.pop('source'); holder['source'] = fn
    reference = weakref.ref(fn); address = id(fn)
    symbols = CPythonSymbols(); p = ir.IntType(8).as_pointer(); n = ir.IntType(64)
    module = ir.Module(name='borrowed_function_owner')
    body = ir.Function(module, ir.FunctionType(p, [p, p.as_pointer(), n, p, p]), 'body')
    builder = ir.IRBuilder(body.append_basic_block('entry'))
    invoke = symbols.declare(module, 'PyObject_CallNoArgs', p, [p])
    close = symbols.declare(module, 'Py_DecRef', ir.VoidType(), [p])
    for callback in (clear, witness):
        result = builder.call(invoke, [ir.Constant(n, id(callback)).inttoptr(p)])
        builder.call(close, [result])
    inc = symbols.declare(module, 'Py_IncRef', ir.VoidType(), [p])
    none = ir.Constant(n, id(None)).inttoptr(p)
    builder.call(inc, [none]); builder.ret(none)
    binding.initialize_native_target(); binding.initialize_native_asmprinter()
    parsed = binding.parse_assembly(str(module)); parsed.verify()
    engine = binding.create_mcjit_compiler(parsed, binding.Target.from_default_triple().create_target_machine())
    engine.finalize_object()
    # A valid C API caller may borrow from a container. The callee's real
    # Python frame ordinarily supplies its own function reference during calls.
    call = ctypes.pythonapi.PyObject_CallNoArgs
    previous = call.argtypes, call.restype
    call.argtypes = [ctypes.c_void_p]; call.restype = ctypes.py_object
    try:
        assert call(address) is None and events == [True]
        holder['source'] = fn; events.clear()
        with install_vectorcall_entry(fn, engine.get_function_address('body'), (engine, symbols, clear, witness)):
            del fn
            assert call(address) is None
            assert events == [True]
        assert reference() is None
    finally:
        call.argtypes, call.restype = previous
