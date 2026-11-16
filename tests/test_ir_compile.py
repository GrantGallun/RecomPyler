"""Public compilation creates native code without executing application bodies."""
import gc
from types import FunctionType
import weakref
from recompyler import ir


def identity(value):
    return value


def test_compile_returns_original_function_and_real_native_code():
    fn=FunctionType(identity.__code__.replace(),{})
    code=fn.__code__;attributes=fn.__dict__.copy()
    assert ir.compile_function(fn) is fn
    info=ir.compilation_info(fn)
    assert info['compiled'] and type(info['body_address']) is int and info['body_address']>0
    assert info['abi']=='frame' and not info['installed']
    assert fn.__code__ is code and fn.__dict__==attributes
    marker=object();assert fn(marker) is marker
    assert ir.compile_function(fn) is fn
    assert ir.compilation_info(fn)['body_address']==info['body_address']


def test_unsupported_function_stays_python_without_executing_it():
    # Suspended functions now admit a labelled first-suspension prefix (S80).
    # Mapping-pattern bytecodes still exercise a genuine unsupported function.
    def target(action):
        match action():
            case {'value': result}:return result
    events=[];marker=object()
    def action():events.append('called');return {'value':marker}
    code=target.__code__
    assert ir.compile_function(target) is target
    assert ir.compilation_info(target) is None and target.__code__ is code
    assert not events and target(action) is marker and events==['called']


def test_machine_code_owner_does_not_keep_function_or_code_cycles_alive():
    class Constant:pass
    constant=Constant()
    fn=FunctionType(identity.__code__.replace(co_consts=(constant,)),{})
    fn.__globals__['self']=fn;fn.__globals__['sentinel']=constant
    references=[weakref.ref(item) for item in (fn,fn.__code__,constant)]
    assert ir.compile_function(fn) is fn
    assert ir.compilation_info(fn)['compiled']
    del fn,constant
    gc.collect();gc.collect()
    assert all(ref() is None for ref in references)


def test_code_change_retires_prepared_code_and_its_constants():
    class Constant:pass
    constant=Constant();reference=weakref.ref(constant)
    fn=FunctionType(identity.__code__.replace(co_consts=(constant,)),{})
    ir.compile_function(fn);del constant
    fn.__code__=identity.__code__.replace()
    gc.collect()
    assert reference() is None and ir.compilation_info(fn) is None


def test_compilation_never_invokes_getters_or_user_body():
    events=[]
    def target(value):
        while value.parent is not None:value=value.parent
        return value
    class Value:
        @property
        def parent(self):events.append('called');raise AssertionError('executed during compilation')
    ir.compile_function(target)
    assert ir.compilation_info(target)['compiled'] and events==[]


def test_code_change_during_lowering_cannot_prepare_stale_body(monkeypatch):
    from recompyler.ir import compiler
    fn=FunctionType(identity.__code__.replace(),{})
    def replacement(value):return None
    original=compiler.lower
    def racing(*args,**kwargs):
        lowered=original(*args,**kwargs)
        fn.__code__=replacement.__code__
        return lowered
    monkeypatch.setattr(compiler,'lower',racing)
    assert ir.compile_function(fn) is fn
    assert ir.compilation_info(fn) is None and fn(object()) is None


def test_code_change_at_native_registration_cannot_prepare_stale_body(monkeypatch):
    from recompyler.ir import _entry_native
    fn=FunctionType(identity.__code__.replace(),{})
    def replacement(value):return None
    original=_entry_native.prepare_frame_entry
    def racing(*args,**kwargs):
        fn.__code__=replacement.__code__
        return original(*args,**kwargs)
    monkeypatch.setattr(_entry_native,'prepare_frame_entry',racing)
    assert ir.compile_function(fn) is fn
    assert ir.compilation_info(fn) is None and fn(object()) is None
