"""Fresh public prefix/candidate checks use the original Python function."""
import ast,ctypes,sys,types
from types import FunctionType
from recompyler.ir import compile_function,compilation_info
from recompyler.ir.compiler import _install_prepared
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)

def case_keyword_seed_binding():
    from frame_install_cases import Keepalive
    from recompyler.ir import _entry_native
    def source(value,*,required):
        while value is not None:value=value.parent
        return required
    fn=FunctionType(source.__code__.replace(),source.__globals__)
    assert compile_function(fn,strict=True) is fn
    code,owner=_entry_native._compilation_owner(fn)
    counted=Keepalive(owner);counted.body_address=counted.address;counted.entry_offset=owner.entry_offset
    _entry_native.forget_compilation(fn)
    _entry_native.prepare_frame_entry(fn,counted.address,counted,code)
    assert _install_prepared(fn) and compilation_info(fn)['installed']
    try:
        marker=object();assert fn(None,required=marker) is marker and counted.calls.value==1
        try:fn(None)
        except TypeError as error:assert "required keyword-only argument: 'required'" in str(error)
        else:raise AssertionError('missing keyword-only argument was accepted')
        assert counted.calls.value==1
    finally:_entry_native.forget_compilation(fn)


def installed_prefix(source):
    from frame_install_cases import Keepalive
    from recompyler.ir import _entry_native
    fn=FunctionType(source.__code__.replace(),source.__globals__,source.__name__,source.__defaults__,source.__closure__)
    code=fn.__code__
    assert compile_function(fn,strict=True) is fn and fn.__code__ is code
    info=compilation_info(fn)
    assert info['native_prefix'] and info['compilation_kind']=='native-prefix' and not info['installed']
    stored_code,owner=_entry_native._compilation_owner(fn)
    assert stored_code is code
    counted=Keepalive(owner);counted.body_address=counted.address;counted.entry_offset=owner.entry_offset
    _entry_native.forget_compilation(fn)
    _entry_native.prepare_frame_entry(fn,counted.address,counted,code)
    assert _install_prepared(fn) and compilation_info(fn)['installed']
    return fn,counted


def case_generator():
    events=[]
    def source(value):
        events.append(('prefix',value))
        try:
            while value:
                value=yield value
                events.append(('after',value))
        finally:events.append(('finally',sys.exception()))
    fn,counted=installed_prefix(source)
    marker=object();other=object();gen=fn(marker)
    assert type(gen) is types.GeneratorType and gen.gi_code is fn.__code__
    assert not events and counted.calls.value==0
    assert next(gen) is marker and counted.calls.value==1
    assert gen.gi_frame.f_locals['value'] is marker
    assert gen.send(other) is other and counted.calls.value==1
    error=LookupError('same exception')
    try:gen.throw(error)
    except LookupError as caught:
        assert caught is error
        tb=caught.__traceback__
        while tb and tb.tb_frame.f_code is not fn.__code__:tb=tb.tb_next
        assert tb is not None
    else:raise AssertionError('throw lost the original exception')
    assert events==[('prefix',marker),('after',other),('finally',error)]
    assert gen.gi_frame is None and counted.calls.value==1
    error.__traceback__=None


def case_coroutine():
    events=[];marker=object();result=object()
    class Awaitable:
        def __await__(self):
            yield marker
            return result
    async def source(awaitable):
        events.append('prefix')
        try:return await awaitable
        finally:events.append('finally')
    fn,counted=installed_prefix(source)
    coro=fn(Awaitable())
    assert type(coro) is types.CoroutineType and coro.cr_code is fn.__code__
    assert not events and counted.calls.value==0
    assert coro.send(None) is marker and counted.calls.value==1
    assert coro.cr_await is not None
    try:coro.send(None)
    except StopIteration as done:assert done.value is result
    else:raise AssertionError('coroutine did not return')
    assert coro.cr_frame is None and counted.calls.value==1 and events==['prefix','finally']


def case_async_generator():
    events=[]
    async def source(value):
        events.append('prefix')
        try:
            while value:value=yield value
        finally:events.append('finally')
    fn,counted=installed_prefix(source)
    marker=object();other=object();gen=fn(marker)
    assert type(gen) is types.AsyncGeneratorType and gen.ag_code is fn.__code__
    assert not events and counted.calls.value==0
    for step,expected in [(gen.__anext__(),marker),(gen.asend(other),other),(gen.aclose(),None)]:
        try:step.send(None)
        except StopIteration as done:assert done.value is expected
        else:raise AssertionError('async operation did not finish')
        assert counted.calls.value==1
    assert gen.ag_frame is None and events==['prefix','finally']


def case_real_helper():
    from recompyler.depmap import _own_nodes
    tree=ast.parse('x = a + b\nclass Nested:\n    hidden = 1\ny = [n for n in range(3)]')
    expected=list(_own_nodes(tree));fn,counted=installed_prefix(_own_nodes)
    actual=list(fn(tree))
    assert len(actual)==len(expected) and all(a is b for a,b in zip(actual,expected))
    assert counted.calls.value==1
    gen=fn(tree);next(gen);assert counted.calls.value==2;gen.close()
    assert counted.calls.value==2


def case_invalidated_candidate():
    import _testinternalcapi
    from recompyler.ir import _entry_native
    events=[]
    def source(value):
        events.append(value)
        while value:value=yield value
    fn,counted=installed_prefix(source);marker=object();gen=fn(marker)
    assert next(gen) is marker and counted.calls.value==1;gen.close()
    handle=_entry_native._compilation_handle(fn)
    _testinternalcapi.invalidate_executors(fn.__code__)
    assert not handle.active
    info=compilation_info(fn)
    assert info['compiled'] and not info['installed'],info
    # Retiring CPython's trace leaves the same valid LLVM preparation reusable.
    assert _install_prepared(fn) and _entry_native._compilation_handle(fn) is handle
    gen=fn(marker);assert next(gen) is marker and counted.calls.value==2;gen.close()
    # Explicit semantic dependency invalidation must still remain fail-closed.
    from recompyler.ir.watchers import watch_dependencies
    values={'version':1};dependency=watch_dependencies(dicts=(values,))
    dependency.bind(handle,_entry_native.invalidation_api());values['version']=2
    assert not handle.active and _install_prepared(fn) is False
    gen=fn(marker);assert next(gen) is marker and counted.calls.value==2;gen.close()
    _entry_native.forget_compilation(fn)


if __name__=='__main__':
    case=sys.argv[1];globals()['case_'+case]();print('PASS '+case)
