"""Next capability probes: exact coroutine/async-generator creation and cleanup."""
import ctypes,gc,sys,types,warnings
from pathlib import Path
root=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(root/'src'),str(root/'tests')]
from generator_entry_cases import ResumeBody,resumes,fresh
from recompyler.ir.entry import install_frame_entry
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)

def case_coroutine():
    async def source(value,effects):
        effects.append(value)
        while value is None:value=object()
        return value
    fn=fresh(source);events=[];body=ResumeBody(fn,resumes(fn)[0])
    with warnings.catch_warnings(record=True) as seen:
        warnings.simplefilter('always')
        handle=install_frame_entry(fn,body.address,body,seed_arguments=(None,events))
        gc.collect();assert not seen and not events and body.calls.value==0
        marker=object();coro=fn(marker,events)
        assert type(coro) is types.CoroutineType and coro.cr_code is fn.__code__ and not events and body.calls.value==0
        try:coro.send(None)
        except StopIteration as result:assert result.value is marker
        else:raise AssertionError('coroutine failed to return')
        assert events==[marker] and body.calls.value==1 and coro.cr_frame is None
        handle.close();gc.collect();assert not seen

def case_async_generator():
    async def source(value,effects):
        effects.append('start')
        try:
            while value:value=yield value
        finally:effects.append(sys._getframe().f_code)
    fn=fresh(source);events=[];body=ResumeBody(fn,resumes(fn)[0])
    with warnings.catch_warnings(record=True) as seen:
        warnings.simplefilter('always')
        handle=install_frame_entry(fn,body.address,body,seed_arguments=(None,events))
        gc.collect();assert not seen and not events and body.calls.value==0
        marker=object();gen=fn(marker,events)
        assert type(gen) is types.AsyncGeneratorType and not events
        step=gen.__anext__()
        try:step.send(None)
        except StopIteration as result:assert result.value is marker
        else:raise AssertionError('async generator failed to yield')
        assert events==['start'] and body.calls.value==1
        step=gen.aclose()
        try:step.send(None)
        except StopIteration as result:assert result.value is None
        else:raise AssertionError('async generator failed to close')
        assert events==['start',fn.__code__] and gen.ag_frame is None
        handle.close();gc.collect();assert not seen

def case_coroutine_throw():
    async def source(awaitable,effects):
        effects.append(('start',sys.exception()))
        try:return await awaitable
        finally:effects.append(('finally',sys.exception(),sys._getframe().f_code))
    marker=object()
    class Awaitable:
        def __await__(self):
            yield marker
            return marker
    fn=fresh(source);events=[];body=ResumeBody(fn,resumes(fn)[0])
    handle=install_frame_entry(fn,body.address,body,seed_arguments=(None,events))
    assert events==[] and body.calls.value==0
    error=LookupError('same');coro=fn(Awaitable(),events)
    assert coro.send(None) is marker and body.calls.value==1
    try:coro.throw(error)
    except LookupError as caught:
        assert caught is error
        tb=caught.__traceback__
        while tb and tb.tb_frame.f_code is not fn.__code__:tb=tb.tb_next
        assert tb is not None
        assert events==[('start',None),('finally',error,fn.__code__)]
    else:raise AssertionError('throw lost original exception')
    assert coro.cr_frame is None
    error.__traceback__=None;handle.close()

def case_async_generator_hooks_and_throw():
    async def source(value,effects):
        effects.append('start')
        try:
            while value:value=yield value
        finally:effects.append((sys.exception(),sys._getframe().f_code))
    fn=fresh(source);events=[];hooks=[];body=ResumeBody(fn,resumes(fn)[0])
    previous=sys.get_asyncgen_hooks()
    sys.set_asyncgen_hooks(firstiter=lambda obj:hooks.append(('first',id(obj))),finalizer=lambda obj:hooks.append(('final',id(obj))))
    try:
        handle=install_frame_entry(fn,body.address,body,seed_arguments=(None,events))
        gc.collect();assert hooks==[] and events==[] and body.calls.value==0
        marker=object();gen=fn(marker,events);step=gen.__anext__()
        assert hooks==[('first',id(gen))]
        try:step.send(None)
        except StopIteration as result:assert result.value is marker
        else:raise AssertionError('no yielded value')
        assert body.calls.value==1
        error=LookupError('same');step=gen.athrow(error)
        try:step.send(None)
        except LookupError as caught:
            assert caught is error
            tb=caught.__traceback__
            while tb and tb.tb_frame.f_code is not fn.__code__:tb=tb.tb_next
            assert tb is not None
        else:raise AssertionError('throw lost original exception')
        assert events==['start',(error,fn.__code__)] and gen.ag_frame is None
        error.__traceback__=None;handle.close();del gen,step;gc.collect()
        assert len(hooks)==1
    finally:sys.set_asyncgen_hooks(*previous)

def case_coroutine_seed_decline():
    async def source(value):return value
    fn=fresh(source);body=ResumeBody(fn,resumes(fn)[0])
    previous=sys.get_coroutine_origin_tracking_depth();sys.set_coroutine_origin_tracking_depth(2)
    try:
        with warnings.catch_warnings(record=True) as seen:
            warnings.simplefilter('always')
            try:install_frame_entry(fn,body.address,body,seed_arguments=(None,))
            except ValueError as error:assert 'declined frame entry seed' in str(error)
            else:raise AssertionError('no-progress refusal was bypassed')
            gc.collect();assert not seen and body.calls.value==0
    finally:sys.set_coroutine_origin_tracking_depth(previous)

if __name__=='__main__':
    case=sys.argv[1];globals()['case_'+case]();print('PASS '+case)
