"""Exercise original profiler coroutine closures with counted first-prefix entry."""
import ctypes,sys
sys.path.insert(0,'tests')
from async_lowering_cases import prepare
from recompyler import profiler
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
case=sys.argv[1]
events=[];left=object();right=object()
async def values(*args):
    events.append(('body',args))
    for value in args:
        events.append(('yield',value));yield value
    events.append(('done',))
wrapper=(profiler._collected if case=='collect' else profiler._drained_async)(values)
function=dict(zip(wrapper.__code__.co_freevars,wrapper.__closure__))['function'].cell_contents
code=function.__code__;owner,handle=prepare(function)
assert events==[] and function.__code__ is code and owner.calls.value==0
try:
    result=wrapper(left,right)
    if case=='collect':assert type(result) is list and len(result)==2 and result[0] is left and result[1] is right
    else:assert result is None
    assert events==[('body',(left,right)),('yield',left),('yield',right),('done',)]
    assert owner.calls.value==1 and function.__code__ is code and sys.exception() is None
    print('PASS original_profiler_'+case+' native_prefix_entries=1 original_code=1',flush=True)
finally:handle.close()
