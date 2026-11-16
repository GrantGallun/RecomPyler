"""Imports use CPython's live builtins hook, package context and exact errors."""
import builtins,dis,sys,types,weakref
import pytest
from test_ir_existing_frame import frame_entry


def absolute():
    import math
    return math


def member():
    from math import sqrt
    return sqrt


def hooked(value):
    import wave18_import_token
    return value,wave18_import_token


def from_hook():
    from wave18_import_token import member
    return member


def relative():
    from . import provenance
    return provenance


def function(source,hook=None,**namespace):
    scope={'__builtins__':dict(vars(builtins)),**namespace}
    if hook is not None:scope['__builtins__']['__import__']=hook
    return types.FunctionType(source.__code__.replace(),scope)


def test_absolute_import_and_import_from_return_original_objects():
    import math
    direct,_,_=frame_entry(absolute);attribute,_,_=frame_entry(member)
    assert direct() is math and attribute() is math.sqrt


def test_import_hook_receives_original_source_context_and_live_locals():
    value=object();replacement=object();imported=object();events=[]
    fn=None
    def hook(name,globals,locals,fromlist,level):
        frame=sys._getframe(1)
        events.append((name,globals is fn.__globals__,locals,fromlist,level,
                       frame.f_code is fn.__code__,frame.f_locals['value'] is value))
        frame.f_locals['value']=replacement
        return imported
    fn=function(hooked,hook)
    native,_,_=frame_entry(fn)
    assert native(value)==(replacement,imported)
    assert events==[('wave18_import_token',True,None,None,0,True,True)]
    another=object()
    fn.__builtins__['__import__']=lambda *args:another
    assert native(value)==(value,another)


def test_import_from_keeps_module_until_pop_at_original_source_state():
    marker=object();events=[];references=[];fn=None
    class Carrier:
        @property
        def member(self):
            frame=sys._getframe(1)
            events.append(('get',frame.f_code is fn.__code__))
            return marker
        def __del__(self):
            frame=sys._getframe(1)
            events.append(('drop',frame.f_code is fn.__code__,frame.f_locals.get('member') is marker))
    def hook(*args):
        result=Carrier();references.append(weakref.ref(result));return result
    fn=function(from_hook,hook)
    native,_,_=frame_entry(fn)
    assert native() is marker
    assert events==[('get',True),('drop',True,True)] and references[0]() is None


def test_relative_import_uses_real_package_context():
    from recompyler import provenance
    fn=function(relative,__package__='recompyler',__name__='recompyler.s78_imports')
    native,_,_=frame_entry(fn)
    assert native() is fn() is provenance


@pytest.mark.parametrize('source,opcode',[(absolute,'IMPORT_NAME'),(from_hook,'IMPORT_FROM')])
def test_import_errors_preserve_original_exception_and_source_offset(source,opcode):
    error=LookupError('original import failure')
    if opcode=='IMPORT_NAME':
        def hook(*args):raise error
    else:
        class Carrier:
            @property
            def member(self):raise error
        def hook(*args):return Carrier()
    fn=function(source,hook);native,_,_=frame_entry(fn)
    with pytest.raises(LookupError) as actual:native()
    assert actual.value is error
    tb=actual.value.__traceback__
    while tb and tb.tb_frame.f_code is not fn.__code__:tb=tb.tb_next
    assert tb and tb.tb_lasti==next(op.offset for op in dis.get_instructions(fn) if op.opname==opcode)


def test_import_from_uses_circular_sys_modules_fallback(monkeypatch):
    parent=types.ModuleType('wave18_import_token');child=types.ModuleType('wave18_import_token.member')
    monkeypatch.setitem(sys.modules,child.__name__,child)
    fn=function(from_hook,lambda *args:parent);native,_,_=frame_entry(fn)
    assert native() is fn() is child


def test_import_hook_observer_transition_resumes_next_original_opcode():
    events=[];fn=None;marker=object()
    def trace(frame,event,arg):
        if frame.f_code is fn.__code__:events.append((event,frame.f_lineno))
        return trace
    def hook(*args):
        frame=sys._getframe(1);frame.f_trace=trace;sys.settrace(trace)
        return marker
    fn=function(absolute,hook);native,_,_=frame_entry(fn)
    try:assert fn() is marker
    finally:sys.settrace(None)
    expected=events.copy();events.clear()
    try:assert native() is marker
    finally:sys.settrace(None)
    assert events==expected
