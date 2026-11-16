"""Fresh-process cases: real function identity, owned frames and code lifetime."""
import ctypes,gc,sys,weakref
from types import FunctionType
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
from recompyler import heap
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import install_frame_entry
from llvmlite import ir,binding

class Keepalive:
    def __init__(self,lowered):
        self.lowered=lowered;self.calls=ctypes.c_uint64()
        p=ir.IntType(8).as_pointer();word=ir.IntType(64)
        module=ir.Module();signature=ir.FunctionType(p,[p,word.as_pointer(),p])
        body=ir.Function(module,signature,'counted_body');b=ir.IRBuilder(body.append_basic_block('entry'))
        counter=ir.Constant(word,ctypes.addressof(self.calls)).inttoptr(word.as_pointer())
        b.store(b.add(b.load(counter),ir.Constant(word,1)),counter)
        target=b.inttoptr(ir.Constant(word,lowered.body_address),signature.as_pointer())
        b.ret(b.call(target,list(body.args)))
        self.wrapper=binding.create_mcjit_compiler(binding.parse_assembly(str(module)),binding.Target.from_default_triple().create_target_machine())
        self.wrapper.finalize_object();self.address=self.wrapper.get_function_address('counted_body')


def read(value):
    while value.parent is not None:value=value.parent
    return value

get_field=read
class Value:
    parent=None



def compile_function(function):
    lowered=lower(build(function),frame_entry=True)
    owner=Keepalive(lowered)
    handle=install_frame_entry(function,owner.address,owner,
                              seed_arguments=(None,)*function.__code__.co_argcount)
    return handle,weakref.ref(owner)


def identity():
    fn=FunctionType(read.__code__.replace(),globals(),argdefs=(Value(),))
    code=fn.__code__;bytecode=code.co_code
    handle,owner=compile_function(fn)
    marker=Value()
    assert handle.function is fn and handle.active and not callable(handle)
    assert type(fn) is FunctionType and fn.__code__ is code and code.co_code is bytecode
    assert fn(marker) is marker and fn(value=marker) is marker and isinstance(fn(),Value)
    assert owner().calls.value>=3
    try:fn(unknown=marker)
    except TypeError as error:assert 'unknown' in str(error)
    else:raise AssertionError('missing argument error')
    handle.close();handle.close();gc.collect()
    assert not handle.active and owner() is None and fn(marker) is marker


def lifetime():
    # This is the actual compiler helper, not an isolated equivalent body.
    actual_function=heap._find
    fn=FunctionType(actual_function.__code__.replace(),actual_function.__globals__)
    events=[];references=[]
    class Node:
        def __init__(self,name,parent=None):
            self.name=name;self.target=parent
            references.append(weakref.ref(self,lambda ref:events.append('weakref')))
        @property
        def parent(self):
            frame=sys._getframe(1)
            assert frame.f_code is fn.__code__ and frame.f_locals['cell'] is self
            events.append(self.name+'-read');return self.target
        def __del__(self):events.append(self.name+'-drop')
    root=Node('root')
    def invoke():
        result=fn(Node('leaf',root))
        events.append('returned');return result
    result=invoke();expected=events.copy();events.clear()
    fn=actual_function
    handle,owner=compile_function(fn)
    try:
        actual=invoke();assert actual is result is root
        assert owner().calls.value==1
        assert events==expected==['leaf-read','leaf-read','leaf-drop','weakref','root-read','returned'],(expected,events)
    finally:handle.close()


def error():
    fn=FunctionType(get_field.__code__.replace(),globals())
    class Node:
        @property
        def parent(self):raise LookupError('frame field')
    value=Node()
    def capture():
        try:fn(value)
        except LookupError as error:
            result=[];tb=error.__traceback__
            while tb:
                if tb.tb_frame.f_code is fn.__code__:result.append((tb.tb_lasti,tb.tb_frame.f_locals['value'] is value))
                tb=tb.tb_next
            return result
        raise AssertionError('missing error')
    expected=capture();handle,_=compile_function(fn)
    try:assert capture()==expected
    finally:handle.close()


def defaults():
    old=Value();reference=weakref.ref(old)
    fn=FunctionType(read.__code__.replace(),globals(),argdefs=(old,));del old
    handle,_=compile_function(fn);new=Value()
    fn.__defaults__=(new,);gc.collect()
    assert reference() is None and fn() is new and handle.active
    handle.close()


def code_change():
    old=Value();reference=weakref.ref(old)
    code=read.__code__.replace(co_consts=read.__code__.co_consts+(old,))
    fn=FunctionType(code,globals());del old,code
    handle,owner=compile_function(fn)
    def replacement(value):return 'changed',value
    fn.__code__=replacement.__code__;gc.collect()
    marker=object()
    assert fn(marker)==('changed',marker)
    assert not handle.active and owner() is None and reference() is None
    handle.close()


def active_close():
    fn=FunctionType(get_field.__code__.replace(),globals());holder=[];marker=object();seen=[]
    class Node:
        @property
        def parent(self):
            handle=holder.pop();handle.close();gc.collect()
            seen.append(reference() is not None)
            return None
    handle,reference=compile_function(fn);holder.append(handle);del handle
    value=Node();result=fn(value);gc.collect()
    assert result is value and seen==[True] and reference() is None


def cycle():
    fn=FunctionType(read.__code__.replace(),globals())
    handle,owner=compile_function(fn);fn.handle=handle
    handle_reference=weakref.ref(handle);function_reference=weakref.ref(fn)
    value=Value();assert fn(value) is value
    del handle,fn;gc.collect();gc.collect()
    assert handle_reference() is function_reference() is owner() is None


def observation():
    fn=FunctionType(read.__code__.replace(),globals());handle,_=compile_function(fn)
    events=[];marker=Value()
    def trace(frame,event,arg):
        if frame.f_code is fn.__code__:events.append(event)
        return trace
    try:
        sys.settrace(trace)
        assert fn(marker) is marker
    finally:sys.settrace(None)
    assert 'call' in events and 'return' in events
    handle.close();assert fn(marker) is marker


def seed_decline():
    def plain(value):return value
    code=plain.__code__;bytecode=code.co_code
    lowered=lower(build(plain),frame_entry=True)
    try:install_frame_entry(plain,lowered.body_address,lowered,seed_arguments=(None,))
    except ValueError as error:assert 'declined' in str(error)
    else:raise AssertionError('root-return-only seed unexpectedly admitted')
    marker=object()
    assert plain(marker) is marker and plain.__code__ is code and code.co_code is bytecode



def automatic_retention():
    from recompyler.ir import _entry_native
    fn=FunctionType(read.__code__.replace(),{})
    lowered=lower(build(fn),frame_entry=True)
    owner=lowered.execution_owner;reference=weakref.ref(owner)
    handle=install_frame_entry(fn,owner.body_address,owner,
        seed_arguments=(None,),entry_offset=owner.entry_offset)
    _entry_native.retain_frame_entry(handle,owner)
    function_reference=weakref.ref(fn);code_reference=weakref.ref(fn.__code__)
    del lowered,owner,handle
    value=Value();assert fn(value) is value
    assert _entry_native.compilation_info(fn)['installed']
    assert reference() is not None
    del fn;gc.collect();gc.collect()
    assert function_reference() is code_reference() is reference() is None


def explicit_resume_offset():
    fn=FunctionType(read.__code__.replace(),{})
    lowered=lower(build(fn),frame_entry=True)
    try:install_frame_entry(fn,lowered.body_address,lowered,seed_arguments=(None,),entry_offset=2)
    except ValueError as error:assert 'RESUME' in str(error)
    else:raise AssertionError('accepted non-RESUME offset')
    value=Value();assert fn(value) is value



def measured_policy():
    from recompyler import ir
    from recompyler.ir.compiler import _record_measurement
    fn=FunctionType(read.__code__.replace(),{})
    assert ir.compile_function(fn) is fn
    assert not ir.compilation_info(fn)['installed']
    # Synthetic policy inputs; this is correctness evidence, not a timing claim.
    _record_measurement(fn,100,101);ir.compile_function(fn)
    assert not ir.compilation_info(fn)['installed']
    _record_measurement(fn,100,90);ir.compile_function(fn)
    assert ir.compilation_info(fn)['installed']
    marker=Value();assert fn(marker) is marker and fn(value=marker) is marker
    fn.__code__=read.__code__.replace()
    assert ir.compilation_info(fn) is None
    ir.compile_function(fn)
    assert not ir.compilation_info(fn)['installed']



def install_code_race():
    from recompyler import ir
    from recompyler.ir import entry
    from recompyler.ir.compiler import _record_measurement
    fn=FunctionType(read.__code__.replace(),{})
    def replacement(value):
        while value.parent is not None:value=value.parent
        return None
    ir.compile_function(fn)
    _record_measurement(fn,100,90)
    original=entry.install_frame_entry
    def racing(*args,**kwargs):
        fn.__code__=replacement.__code__
        return original(*args,**kwargs)
    entry.install_frame_entry=racing
    try:
        assert ir.compile_function(fn) is fn
        assert ir.compilation_info(fn) is None
        assert fn(Value()) is None
    finally:entry.install_frame_entry=original



def observer_transition():
    def observe(fn,mode):
        events=[]
        def trace(frame,event,arg):
            if frame.f_code is fn.__code__:events.append((event,frame.f_lineno))
            return trace
        class Node:
            @property
            def parent(self):
                if mode=='trace':
                    frame=sys._getframe(1);frame.f_trace=trace;sys.settrace(trace)
                elif mode=='profile':sys.setprofile(trace)
                elif mode=='monitor':
                    sys.monitoring.register_callback(5,sys.monitoring.events.LINE,
                        lambda code,line:events.append(('line',line)) if code is fn.__code__ else None)
                    sys.monitoring.set_events(5,sys.monitoring.events.LINE)
                return None
        if mode=='monitor':sys.monitoring.use_tool_id(5,'native observer transition')
        value=Node()
        try:assert fn(value) is value
        finally:
            sys.settrace(None);sys.setprofile(None)
            if mode=='monitor':sys.monitoring.set_events(5,0);sys.monitoring.free_tool_id(5)
        return events
    for mode in ('trace','profile','monitor'):
        oracle=FunctionType(heap._find.__code__.replace(),heap._find.__globals__)
        fn=FunctionType(heap._find.__code__.replace(),heap._find.__globals__)
        expected=observe(oracle,mode)
        from recompyler.ir import compile_function
        from recompyler.ir.compiler import _install_prepared
        compile_function(fn,strict=True);assert _install_prepared(fn)
        actual=observe(fn,mode)
        assert actual==expected,(mode,expected,actual)



def observer_finalizers():
    def observe(fn,mode):
        events=[]
        def trace(frame,event,arg):
            if frame.f_code is fn.__code__:events.append((event,frame.f_lineno))
            return trace
        def enable():
            frame=sys._getframe(2)
            assert frame.f_code is fn.__code__
            frame.f_trace=trace;sys.settrace(trace)
        root=Value()
        class Leaf:
            parent=root
            def __del__(self):enable()
        class Marker:
            def __del__(self):enable()
        class Holder:
            calls=0
            @property
            def parent(self):
                self.calls+=1
                return Marker() if self.calls==1 else root
        try:
            if mode=='store':assert fn(Leaf()) is root
            else:assert fn(Holder()) is root
        finally:sys.settrace(None)
        return events
    from recompyler.ir import compile_function
    from recompyler.ir.compiler import _install_prepared
    for mode in ('store','branch'):
        oracle=FunctionType(heap._find.__code__.replace(),heap._find.__globals__)
        fn=FunctionType(heap._find.__code__.replace(),heap._find.__globals__)
        expected=observe(oracle,mode)
        compile_function(fn,strict=True);assert _install_prepared(fn)
        actual=observe(fn,mode)
        assert actual==expected,(mode,expected,actual)


def observer_deletions():
    def delete_attr(owner):
        result=owner
        while owner is not None:
            del owner.field
            owner=None
        return result
    def delete_subscr(owner,key):
        result=owner
        while owner is not None:
            del owner[key]
            owner=None
        return result
    def observe(fn,kind,native):
        events=[];handle=None;owner=None
        def trace(frame,event,arg):
            if frame.f_code is fn.__code__:events.append((event,frame.f_lineno))
            return trace
        def activate():
            frame=sys._getframe(2)
            assert frame.f_code is fn.__code__
            frame.f_trace=trace;sys.settrace(trace)
        class Value:
            def __delattr__(self,name):activate()
            def __delitem__(self,key):activate()
        value=Value();args=(value,) if kind=='attr' else (value,object())
        if native:
            owner=Keepalive(lower(build(fn),frame_entry=True))
            handle=install_frame_entry(fn,owner.address,owner,seed_arguments=args)
        try:assert fn(*args) is value
        finally:
            sys.settrace(None)
            if handle is not None:handle.close()
        if native:assert owner.calls.value==1,owner.calls.value
        return events
    for source,kind in ((delete_attr,'attr'),(delete_subscr,'subscr')):
        oracle=FunctionType(source.__code__.replace(),source.__globals__)
        fn=FunctionType(source.__code__.replace(),source.__globals__)
        assert observe(fn,kind,True)==observe(oracle,kind,False)


def observer_unary_scope():
    def source(value):
        result=None
        while value is not None:
            result=(
                -value
                + 1
            )
            value=None
        return result
    def observe(fn,native):
        events=[];handle=None;owner=None;negations=[]
        def trace(frame,event,arg):
            if frame.f_code is fn.__code__:events.append((event,frame.f_lineno))
            return trace
        class Value:
            def __neg__(self):
                frame=sys._getframe(1);assert frame.f_code is fn.__code__
                negations.append(frame.f_lasti);frame.f_trace=trace;sys.settrace(trace);return 10
        value=Value()
        if native:
            owner=Keepalive(lower(build(fn),frame_entry=True))
            handle=install_frame_entry(fn,owner.address,owner,seed_arguments=(value,))
        try:assert fn(value)==11
        finally:
            sys.settrace(None)
            if handle is not None:handle.close()
        assert len(negations)==1
        if native:assert owner.calls.value==1
        return events
    oracle=FunctionType(source.__code__.replace(),source.__globals__)
    fn=FunctionType(source.__code__.replace(),source.__globals__)
    assert observe(fn,True)==observe(oracle,False)


if __name__=='__main__':
    case=sys.argv[1];globals()[case]();print('PASS '+case,flush=True)
