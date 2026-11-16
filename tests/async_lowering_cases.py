"""Fresh actual-frame checks for canonical async opcode lowering."""
import ctypes,dis,sys,types
from recompyler import heap
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import install_frame_entry
from frame_install_cases import Keepalive
from test_ir_protected_paths import _unchanged
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)


def fresh(function):
    return types.FunctionType(function.__code__.replace(),function.__globals__,function.__name__,function.__defaults__,function.__closure__)


def prepare(function,offset=None,seed_arguments=None):
    offset=next(i.offset for i in dis.get_instructions(function) if i.opname=='RESUME') if offset is None else offset
    body=lower(build(function),frame_entry=True,entry_offset=offset)
    owner=Keepalive(body)
    arguments=(None,)*function.__code__.co_argcount if seed_arguments is None else seed_arguments
    handle=install_frame_entry(function,owner.address,owner,seed_arguments=arguments,entry_offset=offset)
    assert owner.calls.value==0 and handle.active
    return owner,handle


def done(iterator):
    try:iterator.send(None)
    except StopIteration as error:return error.value
    raise AssertionError('unexpected suspension')


async def immediate(value,events):
    events.append('body')
    return value

async def await_from(make):
    return await make()

async def collect_from(make):
    return [value async for value in make()]

async def replay_with_entry(values):
    _unchanged(None)
    for value in values:
        yield value


def case_immediate():
    function=fresh(immediate);events=[];marker=object();owner,handle=prepare(function)
    try:
        coroutine=function(marker,events)
        assert type(coroutine) is types.CoroutineType and events==[] and owner.calls.value==0
        assert coroutine.cr_frame.f_code is function.__code__
        assert done(coroutine) is marker and events==['body'] and owner.calls.value==1
        assert coroutine.cr_frame is None
    finally:handle.close()


def case_await_protocol():
    function=fresh(await_from);events=[];marker=object();result=object()
    class Source:
        def __await__(self):
            assert sys._getframe(1).f_code is function.__code__
            events.append('await')
            def values():
                sent=yield marker
                assert sent is result
                return result
            return values()
        def __del__(self):events.append('source-drop')
    owner,handle=prepare(function)
    try:
        coroutine=function(Source)
        assert events==[] and owner.calls.value==0
        assert coroutine.send(None) is marker
        assert events==['await','source-drop'] and owner.calls.value==1
        try:coroutine.send(result)
        except StopIteration as error:assert error.value is result
        else:raise AssertionError('lost await result')
        assert coroutine.cr_frame is None and owner.calls.value==1
    finally:handle.close()


def case_async_iteration():
    function=fresh(collect_from);events=[];left=object();right=object()
    class Awaitable:
        def __init__(self,value):self.value=value
        def __await__(self):
            events.append('await')
            value=self.value
            def immediate():
                if False:yield
                return value
            return immediate()
    class Iterator:
        def __init__(self):self.values=iter([left,right])
        def __anext__(self):
            assert sys._getframe(1).f_code is function.__code__
            events.append('next')
            try:value=next(self.values)
            except StopIteration:raise StopAsyncIteration from None
            return Awaitable(value)
    class Source:
        def __aiter__(self):
            assert sys._getframe(1).f_code is function.__code__
            events.append('aiter');return Iterator()
        def __del__(self):events.append('source-drop')
    owner,handle=prepare(function)
    try:
        coroutine=function(Source)
        assert events==[] and owner.calls.value==0
        result=done(coroutine)
        assert len(result)==2 and result[0] is left and result[1] is right
        assert events==['aiter','source-drop','next','await','next','await','next']
        assert owner.calls.value==1 and coroutine.cr_frame is None
    finally:handle.close()


def case_async_iterator_error():
    original=fresh(collect_from);function=original;events=[]
    class Invalid:
        def __del__(self):events.append('result-drop')
    class Source:
        def __aiter__(self):events.append('aiter');return Invalid()
        def __del__(self):events.append('source-drop')
    def capture():
        coroutine=function(Source)
        try:coroutine.send(None)
        except TypeError as error:
            pcs=[];tb=error.__traceback__
            while tb:
                if tb.tb_frame.f_code is function.__code__:pcs.append(tb.tb_lasti)
                tb=tb.tb_next
            return type(error),str(error),pcs
        raise AssertionError('invalid async iterator accepted')
    expected=capture();expected_events=events.copy();events.clear()
    function=fresh(collect_from);owner,handle=prepare(function)
    try:
        assert capture()==expected
        assert events==expected_events==['aiter','source-drop','result-drop']
        assert owner.calls.value==1
    finally:handle.close()


def case_async_generator():
    function=fresh(replay_with_entry);owner,handle=prepare(function)
    marker=object();other=object()
    try:
        generator=function([marker,other])
        assert type(generator) is types.AsyncGeneratorType and owner.calls.value==0
        assert generator.ag_code is function.__code__
        assert done(generator.asend(None)) is marker and owner.calls.value==1
        assert done(generator.asend(None)) is other and owner.calls.value==1
        assert done(generator.aclose()) is None
        assert generator.ag_frame is None
    finally:handle.close()


def case_real_region_helper():
    function=fresh(heap.Region._resumed);marker=object();events=[]
    class Region:
        compiled_calls=0
        fallback_calls=0
        def __init__(self,mode):self.mode=mode
        def attempt(self,args,kwargs):
            assert sys._getframe(1).f_code is function.__code__
            events.append(('attempt',args,kwargs))
            if self.mode=='recursion':raise RecursionError('original attempt')
            return self.mode=='native',marker
        async def original(self,*args,**kwargs):
            events.append(('original',args,kwargs));return marker
    owner,handle=prepare(function,seed_arguments=(Region('native'),(),{}))
    assert events==[]
    try:
        for mode in ('native','fallback','recursion'):
            region=Region(mode);arguments=(object(),);keywords={'value':object()}
            before=owner.calls.value
            assert done(function(region,arguments,keywords)) is marker
            assert owner.calls.value==before+1
            assert (region.compiled_calls,region.fallback_calls)==((1,0) if mode=='native' else (0,1))
            expected=[('attempt',arguments,keywords)]
            if mode!='native':expected.append(('original',arguments,keywords))
            assert events==expected;events.clear()
        assert sys.exception() is None
    finally:handle.close()


def case_await_error():
    function=fresh(await_from);error=LookupError('original await');events=[]
    class Source:
        def __await__(self):
            assert sys._getframe(1).f_code is function.__code__
            events.append('await');raise error
    owner,handle=prepare(function)
    try:
        coroutine=function(Source)
        try:coroutine.send(None)
        except LookupError as caught:
            assert caught is error
            pcs=[];tb=caught.__traceback__
            while tb:
                if tb.tb_frame.f_code is function.__code__:pcs.append(tb.tb_lasti)
                tb=tb.tb_next
            assert pcs==[next(i.offset for i in dis.get_instructions(function) if i.opname=='GET_AWAITABLE')]
            caught.__traceback__=None
        else:raise AssertionError('lost await exception')
        assert events==['await'] and owner.calls.value==1 and coroutine.cr_frame is None
        assert sys.exception() is None
    finally:handle.close()


def case_async_generator_lifetime():
    events=[]
    class Value:
        def __init__(self,name):self.name=name
        def __del__(self):events.append(self.name)
    def invoke(function):
        generator=function([Value('first'),Value('second')])
        yielded=done(generator.asend(None));assert yielded.name=='first'
        del yielded
        assert events==[]
        assert done(generator.aclose()) is None
        assert generator.ag_frame is None
    invoke(fresh(replay_with_entry));expected=events.copy();events.clear()
    function=fresh(replay_with_entry);owner,handle=prepare(function)
    try:
        invoke(function)
        assert events==expected and sorted(events)==['first','second']
        assert owner.calls.value==1
    finally:handle.close()


def case_original_replay_admission():
    function=fresh(heap._replay);code=function.__code__;marker=object()
    first=next(i.offset for i in dis.get_instructions(function) if i.opname=='RESUME')
    owner=Keepalive(lower(build(function),frame_entry=True,entry_offset=first));handle=None
    try:
        try:handle=install_frame_entry(function,owner.address,owner,seed_arguments=(None,),entry_offset=first)
        except ValueError as error:
            assert 'declined frame entry seed' in str(error)
            assert owner.calls.value==0
        assert function.__code__ is code and owner.calls.value==0
        generator=function([marker]);assert generator.ag_code is code
        assert done(generator.asend(None)) is marker
        assert owner.calls.value==(1 if handle is not None else 0)
        assert done(generator.aclose()) is None and generator.ag_frame is None
        print('original_replay_native_entries='+str(owner.calls.value),flush=True)
    finally:
        if handle is not None:handle.close()


if __name__=='__main__':
    case=sys.argv[1];globals()['case_'+case]();print('PASS '+case,flush=True)
