"""A queued eval-breaker event must run at the original callee RESUME."""
import ctypes
import pytest
from types import FunctionType
from llvmlite import ir, binding
from recompyler.ir.symbols import CPythonSymbols
from recompyler.ir.frameless import prepare_frameless


def read(owner):
    return owner.parent


@pytest.mark.parametrize('entry_kind', ['certified', 'raw'])
def test_pending_callback_before_vectorcall_observes_original_callee(entry_kind):
    def identity(owner):return owner
    function=FunctionType((read if entry_kind=='certified' else identity).__code__.replace(), {})
    class Owner: pass
    owner=Owner();before=object();after=object()
    events=[]
    @ctypes.PYFUNCTYPE(ctypes.c_int, ctypes.c_void_p)
    def pending(unused):
        import sys
        frame=sys._getframe(1)
        events.append((frame.f_code, frame.f_lasti))
        owner.parent=after
        return 0
    symbols=CPythonSymbols()
    module=ir.Module();module.triple=binding.get_process_triple()
    p=ir.IntType(8).as_pointer();word=ir.IntType(64);i32=ir.IntType(32)
    body=ir.Function(module,ir.FunctionType(p,[p]),'queue_and_call')
    b=ir.IRBuilder(body.append_basic_block('entry'))
    args=b.alloca(p);b.store(body.args[0],args)
    callback=ir.Constant(word,ctypes.cast(pending,ctypes.c_void_p).value).inttoptr(p)
    add=symbols.declare(module,'Py_AddPendingCall',i32,[p,p])
    b.call(add,[callback,ir.Constant(p,None)])
    call=symbols.declare(module,'PyObject_Vectorcall',p,[p,p.as_pointer(),word,p])
    b.ret(b.call(call,[ir.Constant(word,id(function)).inttoptr(p),args,ir.Constant(word,1),ir.Constant(p,None)]))
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    native=binding.parse_assembly(str(module));native.verify()
    target=binding.Target.from_default_triple().create_target_machine()
    engine=binding.create_mcjit_compiler(native,target);engine.finalize_object()
    invoke=ctypes.PYFUNCTYPE(ctypes.py_object,ctypes.py_object)(engine.get_function_address('queue_and_call'))
    owner.parent=before
    expected=invoke(owner);reference=events[:];events.clear()
    assert expected is (after if entry_kind=='certified' else owner)
    assert reference[0][0] is function.__code__
    if entry_kind=='certified':
        candidate=prepare_frameless(function,counted=True)
        assert candidate is not None
        candidate.install()
        native_hits=lambda:candidate.native_calls
    else:
        from test_ir_frameless_entry import Body, install
        raw=Body();candidate=install(function,raw)
        native_hits=lambda:raw.calls.value
    try:
        # Warm the guarded field cache before queueing the event inside C.
        owner.parent=before
        assert function(owner) is (before if entry_kind=='certified' else owner)
        assert native_hits()>0
        actual=invoke(owner)
        assert actual is expected and events==reference
    finally:
        candidate.close()


@pytest.mark.parametrize('retire_owner',[False,True])
def test_pending_work_at_traversal_backedge_uses_current_local(monkeypatch,retire_owner):
    import dis,sys
    from recompyler import _structure_ops_native
    from recompyler.ir import frameless
    from recompyler.ir.structure_lowerings import StructureCalls
    from test_ir_existing_frame import frame_entry
    def walk(owner):
        current=owner
        while current.parent is not None:current=current.parent
        return current
    function=FunctionType(walk.__code__.replace(), {})
    class Node:pass
    leaf=Node();root=Node();after=Node()
    leaf.parent=root;root.parent=None;after.parent=None
    queued=ctypes.c_int();events=[];retire=[];executable=None
    @ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.c_void_p)
    def pending(unused):
        frame=sys._getframe(1)
        events.append((frame.f_code,frame.f_lasti,frame.f_locals.get('current') is root))
        root.parent=after
        if retire:
            import gc
            handle=retire.pop();handle.close();del handle;gc.collect()
            assert executable() is not None,'cold executable retired while running'
        return 0
    class QueueOnRead(StructureCalls):
        def queued_read(self,builder,owner,result):
            word=ir.IntType(64);i32=ir.IntType(32);p=owner.type
            slot=ir.Constant(word,ctypes.addressof(queued)).inttoptr(i32.as_pointer())
            first=builder.and_(builder.icmp_unsigned('==',owner,ir.Constant(word,id(leaf)).inttoptr(p)),
                               builder.icmp_signed('==',builder.load(slot),ir.Constant(i32,0)))
            with builder.if_then(first):
                builder.store(ir.Constant(i32,1),slot)
                callback=ir.Constant(word,ctypes.cast(pending,ctypes.c_void_p).value).inttoptr(p)
                self.capi(builder,'Py_AddPendingCall',i32,[callback,ir.Constant(p,None)])
            return result
        def load_attr(self,builder,owner,name):
            return self.queued_read(builder,owner,super().load_attr(builder,owner,name))
        def try_load_attr(self,builder,owner,name):
            return self.queued_read(builder,owner,super().try_load_attr(builder,owner,name))
    calls=QueueOnRead(CPythonSymbols(),_structure_ops_native)
    from recompyler.ir import build
    from recompyler.ir.structure_lowerings import select_structure_calls
    graph=select_structure_calls(build(function),{'load_attr'})
    reference_entry=frame_entry(function,structure_calls=calls,graph=graph)[0]
    assert reference_entry(leaf) is after
    backedge=next(op.offset for op in dis.get_instructions(function) if op.opname=='JUMP_BACKWARD')
    assert events==[(function.__code__,backedge,True)]
    events.clear();queued.value=0;root.parent=None
    monkeypatch.setattr(frameless,'StructureCalls',QueueOnRead)
    candidate=prepare_frameless(function,counted=True)
    # A refusal is exact fallback; a certificate must also preserve backedges.
    if candidate is None:return
    candidate.install()
    if retire_owner:
        import weakref
        executable=weakref.ref(candidate.owner)
        retire.append(candidate);del candidate
    try:
        actual=function(leaf)
        assert actual is after and events==[(function.__code__,backedge,True)]
    finally:
        if retire:retire.pop().close()
        if not retire_owner:candidate.close()
    if retire_owner:
        import gc
        gc.collect()
        assert executable() is None,'cold executable stayed alive after return'


def test_loop_cold_handoff_can_reenter_the_same_entry():
    import sys
    def walk(owner):
        current=owner
        while current.parent is not None:current=current.parent
        return current
    function=FunctionType(walk.__code__.replace(), {})
    seen=[];inner=None
    class Node:pass
    class Cold:
        @property
        def parent(self):
            frame=sys._getframe(1)
            assert frame.f_code is function.__code__ and frame.f_locals['current'] is self
            seen.append(self)
            if self is outer_tail:assert function(inner) is inner_tail
            return None
    outer_tail=Cold();inner_tail=Cold()
    outer=Node();outer.parent=outer_tail
    inner=Node();inner.parent=inner_tail
    candidate=prepare_frameless(function)
    assert candidate is not None
    candidate.install()
    try:
        assert function(outer) is outer_tail
        assert seen==[outer_tail,inner_tail]
    finally:candidate.close()


@pytest.mark.parametrize('bound',[False,True])
def test_source_retained_argument_can_be_released_by_a_frame_observer(bound):
    def observe(installed):
        events=[]
        def chain(owner):return owner.child.parent
        function=FunctionType(chain.__code__.replace(), {})
        class Child:
            @property
            def parent(self):
                import sys
                frame=sys._getframe(1)
                frame.f_locals['owner']=None
                events.append('cleared')
                return 42
        class Leaf:
            search=function
            def __init__(self):self.child=Child()
            def __del__(self):events.append('drop')
        candidate=prepare_frameless(function) if installed else None
        if installed:assert candidate is not None
        if candidate:candidate.install()
        try:
            result=Leaf().search() if bound else function(Leaf())
            assert result==42
            events.append('returned')
            return events
        finally:
            if candidate:candidate.close()
    assert observe(True)==observe(False)


def test_borrowed_context_uses_the_existing_entry_registry():
    import gc,weakref
    from recompyler.ir import _entry_native
    def identity(value):return value
    function=FunctionType(identity.__code__.replace(),{})
    candidate=prepare_frameless(function)
    assert candidate is not None
    address=_entry_native._callback_free_addresses()['owner']
    lookup=ctypes.PYFUNCTYPE(ctypes.c_void_p,ctypes.py_object)(address)
    assert lookup(function) is None
    candidate.install()
    executable=weakref.ref(candidate.owner)
    assert lookup(function)==id(candidate.owner)
    candidate.close()
    assert lookup(function) is None
    del candidate;gc.collect()
    assert executable() is None


@pytest.mark.parametrize('bound',[False,True])
def test_temporary_callable_outlives_discarded_argument_cleanup(bound):
    import weakref
    from types import MethodType
    def discard(value):return None
    def observe(installed):
        events=[];references={};candidates=[]
        class Argument:
            def __del__(self):
                events.append(('argument',references['function']() is not None,
                               references['code']() is not None))
        def factory():
            function=FunctionType(discard.__code__.replace(),{})
            references['function']=weakref.ref(function,lambda ref:events.append('function'))
            references['code']=weakref.ref(function.__code__,lambda ref:events.append('code'))
            if installed:
                candidate=prepare_frameless(function)
                assert candidate is not None
                candidate.install();candidates.append(candidate)
            return MethodType(function,Argument()) if bound else function
        try:
            result=factory()() if bound else factory()(Argument())
            assert result is None
            events.append('returned')
            return events
        finally:
            for candidate in candidates:candidate.close()
    assert observe(True)==observe(False)



def test_callable_metadata_finalizer_keeps_executable_code_alive():
    import weakref
    def identity(value):return value
    def observe(installed):
        events=[];references={};candidates=[]
        class Metadata:
            def __del__(self):
                events.append(('metadata',references['code']() is not None))
        def factory():
            function=FunctionType(identity.__code__.replace(),{})
            references['code']=weakref.ref(function.__code__,lambda ref:events.append('code'))
            function.metadata=Metadata()
            if installed:
                candidate=prepare_frameless(function)
                assert candidate is not None
                candidate.install();candidates.append(candidate)
            return function
        try:
            assert factory()(None) is None
            events.append('returned')
            return events
        finally:
            for candidate in candidates:candidate.close()
    assert observe(True)==observe(False)
