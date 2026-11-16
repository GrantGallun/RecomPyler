"""Bounded differential GET_AITER adapter checks; not whole native bodies."""
import ctypes,json,sys,time
sys.path.insert(0,'tests')
from test_ir_async_protocols import adapters
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
get,check,release=adapters()

async def python_loop(make):
    async for value in make():
        break

def run(mode,native):
    events=[];error=LookupError('slot-error')
    class Iterator:
        def __anext__(self):raise StopAsyncIteration
        def __del__(self):events.append('iterator-drop')
    class Invalid:
        def __del__(self):events.append('invalid-drop')
    class Source:
        def __aiter__(self):
            events.append('slot')
            if mode==2:return Invalid()
            if mode==3:raise error
            return Iterator()
        def __del__(self):
            events.append('source-drop')
            if mode==4:del Iterator.__anext__
    class Missing:
        def __del__(self):events.append('source-drop')
    make=Missing if mode==1 else Source
    pointer=None
    try:
        if native:
            source=make()
            try:pointer=get(source)
            finally:del source
            pointer=check(pointer)
            release(pointer);pointer=None
        else:
            coroutine=python_loop(make)
            try:coroutine.send(None)
            except StopIteration:pass
        result=('ok',)
    except BaseException as caught:
        result=(type(caught).__name__,str(caught),caught is error)
        caught.__traceback__=None
        pointer=None  # Result-validation failure consumes its result.
    return result,events

start=time.monotonic();duration=float(sys.argv[1]) if len(sys.argv)>1 else 60
iterations=0
while time.monotonic()-start<duration:
    mode=iterations%5
    expected=run(mode,False);actual=run(mode,True)
    assert actual==expected,(mode,expected,actual)
    iterations+=1
print(json.dumps(dict(seconds=round(time.monotonic()-start,3),differential_cases=iterations,canonical_slot_calls=iterations,wrong=0,unchecked=0,scope='C GET_AITER adapters only; no native-body entry claim')),flush=True)
