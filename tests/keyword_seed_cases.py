"""Keyword seeds bind through CPython without invoking target bodies."""
import ctypes,dis,inspect,sys
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import install_frame_entry
from frame_install_cases import Keepalive
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)


def prepare(function, arguments, keywords):
    suspended = function.__code__.co_flags & (inspect.CO_GENERATOR|inspect.CO_COROUTINE|inspect.CO_ASYNC_GENERATOR)
    offset = next(op.offset for op in dis.get_instructions(function) if op.opname=='RESUME') if suspended else None
    owner = Keepalive(lower(build(function),frame_entry=True,entry_offset=offset))
    handle = install_frame_entry(function,owner.address,owner,seed_arguments=arguments,seed_keywords=keywords,entry_offset=offset)
    assert owner.calls.value == 0 and handle.active
    return owner,handle


def required_ordinary():
    events=[];marker=object();result=object();seed=object()
    def source(action,value,/,*,required):
        while value is not None:
            action(value,required)
            value=None
        return required
    def action(value,required):
        frame=sys._getframe(1)
        assert frame.f_code is source.__code__ and frame.f_locals['required'] is result
        events.append((value,required))
    code=source.__code__;owner,handle=prepare(source,(action,marker),{'required':seed})
    assert not events
    try:
        assert source(action,marker,required=result) is result
        assert owner.calls.value==1 and events==[(marker,result)] and source.__code__ is code
        try:source(action,marker)
        except TypeError as error:assert "required keyword-only argument: 'required'" in str(error)
        else:raise AssertionError('missing binding error')
        assert owner.calls.value==1
    finally:handle.close()


def variadic_keywords():
    events=[];marker=object();result=object();extra=object();default=object()
    def source(action,value,/,*items,required,flag=default,**keywords):
        while value is not None:
            action(value,items,required,flag,keywords)
            value=None
        return required
    def action(*args):events.append(args)
    owner,handle=prepare(source,(action,marker,extra),{'required':None,'other':None})
    assert not events
    try:
        assert source(action,marker,extra,required=result,other=extra) is result
        assert events==[(marker,(extra,),result,default,{'other':extra})] and owner.calls.value==1
    finally:handle.close()


def positional_by_keyword():
    events=[];marker=object()
    def source(value,action):
        while value is not None:
            action(value);value=None
        return value
    owner,handle=prepare(source,(),{'value':None,'action':None})
    assert not events
    try:
        assert source(marker,events.append) is None and events==[marker] and owner.calls.value==1
    finally:handle.close()


def suspended_keywords():
    events=[];marker=object();result=object()
    def generator(value,*,required):
        events.append(('gen',value));yield required
    async def coroutine(value,*,required):
        events.append(('coro',value));return required
    async def async_generator(value,*,required):
        events.append(('agen',value));yield required
    def done(iterator):
        try:iterator.send(None)
        except StopIteration as complete:return complete.value
        raise AssertionError('unexpected suspension')
    for function,kind in ((generator,'gen'),(coroutine,'coro'),(async_generator,'agen')):
        owner,handle=prepare(function,(None,),{'required':None})
        assert not events
        try:
            value=function(marker,required=result)
            assert owner.calls.value==0
            if kind=='gen':assert next(value) is result;value.close()
            elif kind=='coro':assert done(value) is result
            else:assert done(value.__anext__()) is result;assert done(value.aclose()) is None
            assert owner.calls.value==1 and events==[(kind,marker)]
        finally:handle.close();events.clear()


def invalid_keywords():
    events=[]
    def source(value,*,required):
        while value is not None:events.append(value);value=None
        return required
    owner=Keepalive(lower(build(source),frame_entry=True))
    for keywords in ({'unknown':None},{1:None}):
        try:install_frame_entry(source,owner.address,owner,seed_arguments=(None,),seed_keywords=keywords)
        except TypeError as error:
            assert "source() got an unexpected keyword argument 'unknown'" in str(error) or 'keywords must be strings' in str(error),str(error)
        else:raise AssertionError('invalid keyword accepted')
        assert owner.calls.value==0 and not events




def seed_owner_lifetime():
    import weakref
    events=[]
    class Token:
        def __del__(self):events.append('seed-drop')
    def source(value,*,required):
        while value is not None:value=None
        return required
    def seed():
        value=Token();reference=weakref.ref(value)
        owner,handle=prepare(source,(None,),{'required':value})
        return owner,handle,reference
    owner,handle,reference=seed()
    try:
        assert reference() is None and events==['seed-drop'] and owner.calls.value==0
    finally:handle.close()


def public_candidate():
    from recompyler.ir import compile_function,_entry_native
    from recompyler.ir.compiler import _install_prepared
    sys.path.insert(0,str(__import__('pathlib').Path(__file__).resolve().parents[1]/'tools'))
    from ir_self_host import CountedBody
    def source(value,*,required):
        while value is not None:value=None
        return required
    compile_function(source,strict=True)
    code,original=_entry_native._compilation_owner(source)
    owner=CountedBody(original)
    _entry_native.forget_compilation(source)
    _entry_native.prepare_frame_entry(source,owner.body_address,owner,code)
    assert _install_prepared(source) and owner.calls.value==0
    marker=object()
    try:
        assert source(object(),required=marker) is marker
        assert owner.calls.value==1 and source.__code__ is code
    finally:_entry_native.forget_compilation(source)


def real_helper():
    from recompyler.ir.inlining import plan_inlining
    def leaf(value):return value
    expected=plan_inlining(leaf.__code__,(),cost_limit=100)
    owner=Keepalive(lower(build(plan_inlining),frame_entry=True))
    handle=install_frame_entry(plan_inlining,owner.address,owner,seed_arguments=(None,None),seed_keywords={'cost_limit':None})
    assert owner.calls.value==0
    try:
        assert plan_inlining(leaf.__code__,(),cost_limit=100)==expected
        assert owner.calls.value==1
    finally:handle.close()


if __name__=='__main__':
    case=sys.argv[1];globals()[case]();print('PASS '+case,flush=True)
