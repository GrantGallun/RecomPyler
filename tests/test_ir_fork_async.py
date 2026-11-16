"""S91 fork async-resume contract and stock refusal boundaries."""
import ctypes
import dis
import sys

if not getattr(ctypes.pythonapi, "PyUnstable_RPCode_SetNative", None) or sys._jit.is_enabled():
    import pytest
    pytest.skip("requires the fork native ABI with JIT disabled", allow_module_level=True)
import pytest
from recompyler.ir.fork_entry import install_function, stats
from recompyler.ir.builder import build, UnsupportedBytecode
from recompyler.ir.lower_llvm import lower


@pytest.mark.parametrize('value', [None, 0, 1, 'yes', object()])
def test_async_resume_flag_requires_exact_bool(value):
    def target():return 1
    with pytest.raises(TypeError, match='allow_async_resume must be bool'):
        lower(build(target), allow_async_resume=value)


def test_async_resume_flag_never_calls_truthiness():
    class Flag:
        def __bool__(self):raise AssertionError('truthiness ran')
    def target():return 1
    with pytest.raises(TypeError, match='allow_async_resume must be bool'):
        lower(build(target), allow_async_resume=Flag())


def test_async_resume_opt_in_requires_existing_frame():
    def target():return 1
    with pytest.raises(UnsupportedBytecode, match='fork existing-frame ABI'):
        lower(build(target), allow_async_resume=True)


def test_async_resume_opt_in_requires_fork_export(monkeypatch):
    def target():return 1
    monkeypatch.setattr(ctypes, 'pythonapi', object())
    with pytest.raises(UnsupportedBytecode, match='fork existing-frame ABI'):
        lower(build(target), frame_entry=True, allow_async_resume=True)


def test_default_async_later_resume_still_declines():
    async def target():await Await()
    resume=[i.offset for i in dis.get_instructions(target) if i.opname=='RESUME']
    assert len(resume)>1
    with pytest.raises(UnsupportedBytecode, match='first RESUME'):
        lower(build(target), frame_entry=True, entry_offset=resume[-1])


class Await:
    def __await__(self):
        answer = yield 'pending'
        return answer


def test_coroutine_resumes_native_after_await_without_replay():
    events=[]
    async def target():
        events.append('prefix')
        answer=await Await()
        events.append(answer)
        return answer+1
    handle=install_function(target,count=True)
    coroutine=target();iterator=coroutine.__await__()
    try:
        assert next(iterator)=='pending'
        with pytest.raises(StopIteration) as caught:iterator.send(7)
        assert caught.value.value==8 and events==['prefix',7]
        # SEND delegates in CPython, so its eventual return is interpreted.
        assert stats(handle)['resume']>=1 and stats(handle)['calls']>=2
    finally:
        coroutine.close();handle.close()


def test_async_generator_resumes_native_with_wrapped_values():
    async def target():
        answer=yield 3
        yield answer
    handle=install_function(target,count=True)
    generator=target()
    try:
        with pytest.raises(StopIteration) as caught:generator.__anext__().send(None)
        assert caught.value.value==3
        with pytest.raises(StopIteration) as caught:generator.asend(8).send(None)
        assert caught.value.value==8
        with pytest.raises(StopAsyncIteration):generator.__anext__().send(None)
        assert stats(handle)['resume']>=2 and stats(handle)['yield']==2
    finally:
        closer=generator.aclose()
        try:closer.send(None)
        except StopIteration:pass
        handle.close()


def test_coroutine_throw_runs_original_finally_and_exception_context():
    events=[]
    async def target():
        try:
            await Await()
        finally:
            events.append(sys.exception())
    handle=install_function(target,count=True)
    coroutine=target();iterator=coroutine.__await__();error=LookupError('stop')
    try:
        assert next(iterator)=='pending'
        with pytest.raises(LookupError) as caught:iterator.throw(error)
        assert caught.value is error and events==[error]
    finally:
        coroutine.close();handle.close()


def test_async_generator_aclose_runs_finally_once():
    events=[]
    async def target():
        try:
            yield 3
            yield 4
        finally:
            events.append('closed')
    handle=install_function(target,count=True)
    generator=target()
    try:
        with pytest.raises(StopIteration) as caught:generator.__anext__().send(None)
        assert caught.value.value==3
        with pytest.raises(StopIteration):generator.aclose().send(None)
        assert events==['closed'] and stats(handle)['yield']==1
    finally:
        handle.close()


def test_coroutine_without_suspension_returns_natively():
    async def target(value):return value+1
    handle=install_function(target,count=True)
    coroutine=target(7)
    try:
        with pytest.raises(StopIteration) as caught:coroutine.send(None)
        assert type(caught.value.value) is int and caught.value.value==8
        assert stats(handle)['start']==1 and stats(handle)['return']==1
    finally:
        coroutine.close();handle.close()


def test_coroutine_enters_native_at_each_original_await_resume():
    events=[]
    async def target():
        first=await Await()
        events.append(first)
        second=await Await()
        events.append(second)
        return first+second
    handle=install_function(target,count=True)
    coroutine=target()
    try:
        assert coroutine.send(None)=='pending'
        assert coroutine.send(3)=='pending' and events==[3]
        with pytest.raises(StopIteration) as caught:coroutine.send(7)
        assert caught.value.value==10 and events==[3,7]
        assert stats(handle)['resume']==2
    finally:
        coroutine.close();handle.close()


def test_async_generator_await_then_yield_keeps_exact_protocol():
    events=[]
    async def target():
        value=await Await()
        events.append(value)
        yield value
        events.append('after')
    handle=install_function(target,count=True)
    generator=target();operation=generator.__anext__()
    try:
        assert operation.send(None)=='pending'
        with pytest.raises(StopIteration) as caught:operation.send(9)
        assert caught.value.value==9 and events==[9]
        with pytest.raises(StopAsyncIteration):generator.__anext__().send(None)
        assert events==[9,'after'] and stats(handle)['resume']==2
    finally:
        closer=generator.aclose()
        try:closer.send(None)
        except StopIteration:pass
        handle.close()
