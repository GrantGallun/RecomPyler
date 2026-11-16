"""Bounded differential binding checks through original native frame entries."""
import ctypes,json,struct,sys,time,types
sys.path.insert(0,'tests')
from frame_install_cases import Keepalive
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import install_frame_entry
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
DEFAULT=object()
def fixed(action,value,/,*,flag=DEFAULT):return action(value,(),flag,{})
def variadic(action,value,/,*items,flag=DEFAULT,**keywords):return action(value,items,flag,keywords)
def clone(function):
    result=types.FunctionType(function.__code__.replace(),function.__globals__,function.__name__,function.__defaults__,function.__closure__)
    result.__kwdefaults__=function.__kwdefaults__.copy()
    return result

def norm(value):
    if type(value) is float:return ('float',struct.pack('>d',value))
    if type(value) is complex:return ('complex',struct.pack('>dd',value.real,value.imag))
    if type(value) is int:return ('int',value)
    return ('identity',id(value))

def execute(function,mode,marker,extra,flag,error):
    events=[]
    def action(value,items,option,keywords):
        assert sys._getframe(1).f_code is function.__code__
        events.append((norm(value),tuple(norm(x) for x in items),norm(option),tuple((k,norm(v)) for k,v in keywords.items())))
        if mode==6:raise error
        return option
    args=(action,marker);keywords={}
    if mode==1:args+=(extra,)
    elif mode==2:args=(action,)
    elif mode==3:keywords={'other':extra}
    elif mode==4:keywords={'value':extra}
    elif mode==5:keywords={'flag':flag}
    try:outcome=('return',norm(function(*args,**keywords)))
    except BaseException as caught:
        pcs=[];tb=caught.__traceback__
        while tb:
            if tb.tb_frame.f_code is function.__code__:pcs.append(tb.tb_lasti)
            tb=tb.tb_next
        outcome=('raise',type(caught).__name__,str(caught),caught is error,tuple(pcs))
        caught.__traceback__=None;tb=None
    assert sys.exception() is None
    return outcome,events

sources=[fixed,variadic];compiled=[]
for source in sources:
    function=clone(source);owner=Keepalive(lower(build(function),frame_entry=True))
    handle=install_frame_entry(function,owner.address,owner,seed_arguments=(lambda *args:None,None))
    assert owner.calls.value==0
    compiled.append([function,owner,handle])
start=time.monotonic();duration=float(sys.argv[1]) if len(sys.argv)>1 else 60
cases=0;native=0;fallback=0;reseeds=0;errors=0;per_family=[0,0]
try:
    while time.monotonic()-start<duration:
        family=cases%2;mode=(cases//2)%7;marker=object();extra=object();error=LookupError('original callback')
        flag=(None,True,False,-0.0,complex(-0.0,1.0),1<<100)[(cases//14)%6]
        function,owner,handle=compiled[family]
        if not handle.active:
            handle.close();function=clone(sources[family]);owner=Keepalive(lower(build(function),frame_entry=True))
            handle=install_frame_entry(function,owner.address,owner,seed_arguments=(lambda *args:None,None))
            compiled[family]=[function,owner,handle];reseeds+=1
        expected=execute(sources[family],mode,marker,extra,flag,error);error.__traceback__=None
        before=owner.calls.value;actual=execute(function,mode,marker,extra,flag,error);entered=owner.calls.value-before
        assert actual==expected,(family,mode,actual,expected)
        assert entered in (0,1),entered
        native+=entered;per_family[family]+=entered;fallback+=not entered;errors+=actual[0][0]=='raise';cases+=1
    assert all(per_family),per_family
    print(json.dumps(dict(seconds=round(time.monotonic()-start,3),cases=cases,counted_native_entries=native,python_dispatch_cases=fallback,native_by_family=per_family,error_cases=errors,reseeds=reseeds,wrong=0,unchecked=0)),flush=True)
finally:
    for function,owner,handle in compiled:handle.close()
