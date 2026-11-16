"""Bounded original-frame async-prefix differential checks with honest counters."""
import ctypes,json,struct,sys,time
sys.path.insert(0,'tests')
from async_lowering_cases import fresh,prepare,done,immediate,await_from,collect_from,replay_with_entry
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)


def normalized(value):
    if type(value) is int:return ('int',value)
    if type(value) is float:return ('float',struct.pack('>d',value))
    if type(value) is complex:return ('complex',struct.pack('>dd',value.real,value.imag))
    if type(value) is list:return ('list',tuple(normalized(x) for x in value))
    return ('identity',id(value))


def execute(function,family,mode,marker,reply,error):
    events=[]
    try:
        if family==0:
            value=(marker,None,True,-0.0,complex(-0.0,1.0))[mode%5]
            result=done(function(value,events))
        elif family==1:
            class Missing:
                def __del__(self):events.append('source-drop')
            class Source:
                def __await__(self):
                    assert sys._getframe(1).f_code is function.__code__
                    events.append('await')
                    if mode==2:return object()
                    if mode==3:raise error
                    def values():
                        sent=yield marker
                        assert sent is reply
                        return reply
                    return values()
                def __del__(self):events.append('source-drop')
            coroutine=function(Missing if mode==1 else Source)
            first=coroutine.send(None);assert first is marker
            try:coroutine.send(reply)
            except StopIteration as complete:result=complete.value
            else:raise AssertionError('await did not complete')
            assert coroutine.cr_frame is None
        elif family==2:
            class Awaitable:
                def __init__(self,value):self.value=value
                def __await__(self):
                    events.append('await')
                    value=self.value
                    def values():
                        if False:yield
                        return value
                    return values()
            class Iterator:
                def __init__(self):self.values=iter([marker,reply])
                def __anext__(self):
                    assert sys._getframe(1).f_code is function.__code__
                    events.append('next')
                    if mode==3:return object()
                    if mode==4:raise error
                    try:value=next(self.values)
                    except StopIteration:raise StopAsyncIteration from None
                    return Awaitable(value)
                def __del__(self):events.append('iterator-drop')
            class Invalid:
                def __del__(self):events.append('invalid-drop')
            class Missing:
                def __del__(self):events.append('source-drop')
            class Source:
                def __aiter__(self):
                    assert sys._getframe(1).f_code is function.__code__
                    events.append('aiter')
                    return Invalid() if mode==2 else Iterator()
                def __del__(self):events.append('source-drop')
            result=done(function(Missing if mode==1 else Source))
        else:
            generator=function([marker,reply]);result=[]
            result.append(done(generator.asend(None)))
            if mode%2:
                done(generator.aclose())
            else:
                result.append(done(generator.asend(None)))
                try:generator.asend(None).send(None)
                except StopAsyncIteration:pass
                else:raise AssertionError('async generator did not finish')
            assert generator.ag_frame is None
        outcome=('return',normalized(result))
    except BaseException as caught:
        pcs=[];tb=caught.__traceback__
        while tb:
            if tb.tb_frame.f_code is function.__code__:pcs.append(tb.tb_lasti)
            tb=tb.tb_next
        cause=caught.__cause__
        context=caught.__context__
        outcome=('raise',type(caught).__name__,str(caught),caught is error,tuple(pcs),
                 None if cause is None else (type(cause).__name__,str(cause)),
                 None if context is None else (type(context).__name__,str(context)),caught.__suppress_context__)
        caught.__traceback__=None
        if cause is not None:cause.__traceback__=None
        if context is not None:context.__traceback__=None
        tb=None
    assert sys.exception() is None
    return outcome,tuple(events)


sources=[immediate,await_from,collect_from,replay_with_entry]
compiled=[];oracles=[fresh(source) for source in sources]
for source in sources:
    function=fresh(source);owner,handle=prepare(function);compiled.append([function,owner,handle])
start=time.monotonic();duration=float(sys.argv[1]) if len(sys.argv)>1 else 60
iterations=0;native=0;fallback=0;families=[0]*4;errors=0;reseeds=0
try:
    while time.monotonic()-start<duration:
        family=iterations%4;mode=(iterations//4)%5
        function,owner,handle=compiled[family]
        if not handle.active:
            handle.close();function=fresh(sources[family]);owner,handle=prepare(function)
            compiled[family]=[function,owner,handle];reseeds+=1
        marker=object();reply=object();error=LookupError('original protocol error')
        expected=execute(oracles[family],family,mode,marker,reply,error)
        before=owner.calls.value
        actual=execute(function,family,mode,marker,reply,error)
        delta=owner.calls.value-before
        assert delta in (0,1),(family,delta)
        native+=delta;families[family]+=delta;fallback+=delta==0
        assert actual==expected,(family,mode,expected,actual)
        errors+=actual[0][0]=='raise';iterations+=1
    assert all(families),families
finally:
    for function,owner,handle in compiled:handle.close()
print(json.dumps(dict(seconds=round(time.monotonic()-start,3),differential_cases=iterations,
    counted_native_prefix_entries=native,python_dispatch_cases=fallback,
    native_by_family=families,error_cases=errors,reseeds=reseeds,wrong=0,unchecked=0)),flush=True)
