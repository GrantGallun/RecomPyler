"""Tests first for the fork's opt-in canonical specialization adapter."""
import ctypes
import gc
import sys
import weakref
import pytest
if not getattr(ctypes.pythonapi, 'PyUnstable_RPCode_SetNative', None) or sys._jit.is_enabled():
    pytest.skip('requires the fork native ABI with JIT disabled', allow_module_level=True)
from recompyler.ir.fork_entry import install_function,prepare_function,stats

@pytest.mark.parametrize('value',[None,0,1,object()])
def test_specialization_flag_is_exact_bool(value):
    def target(value):return value
    with pytest.raises(TypeError,match='specialize must be bool'):
        prepare_function(target,specialize=value)

def test_specialized_prepare_does_not_call_source():
    effects=[]
    def target(value):
        effects.append(value)
        return value.x
    compiled=prepare_function(target,specialize=True)
    assert not effects and compiled.entry_count==1

def test_borrowed_traversal_runs_original_frame_and_mutation_fallback():
    def find(cell):
        while cell.parent is not None:cell=cell.parent
        return cell
    class Node:pass
    root=Node();root.parent=None
    leaf=Node();leaf.parent=root
    for _ in range(200):assert find(leaf) is root
    handle=install_function(find,specialize=True,count=True)
    try:
        assert find(leaf) is root
        seen=[]
        class Observed:
            @property
            def parent(self):
                frame=sys._getframe(1)
                seen.append((frame.f_code is find.__code__,frame.f_locals['cell'] is self))
                return None
        assert type(find(Observed())) is Observed
        assert seen==[(True,True)] and stats(handle)['calls']==2
    finally:handle.close()

def test_specialized_traversal_releases_last_owner_at_original_store():
    def find(cell):
        while cell.parent is not None:cell=cell.parent
        return cell
    events=[]
    class Root:
        @property
        def parent(self):events.append('read-root');return None
    root=Root()
    class Leaf:
        @property
        def parent(self):events.append('read-leaf');return root
        def __del__(self):events.append('dead')
    result=find(Leaf())
    assert result is root
    expected=events[:];events.clear()
    handle=install_function(find,specialize=True)
    try:
        result=find(Leaf())
        assert result is root and events==expected
    finally:handle.close()

def test_specialized_suspended_code_stays_exact():
    def producer(value):
        yield value.x
        yield value.x
    class Value:pass
    value=Value();value.x=7
    handle=install_function(producer,specialize=True,count=True)
    try:
        gen=producer(value);assert next(gen)==7
        value.x='changed';assert next(gen)=='changed'
        with pytest.raises(StopIteration):next(gen)
        assert stats(handle)['yield']==2
    finally:handle.close()


@pytest.mark.parametrize('value',[None,0,1,object()])
def test_borrowed_guard_flag_is_exact_bool(value):
    def target(value):return value
    with pytest.raises(TypeError,match='borrow_guards must be bool'):
        prepare_function(target,borrow_guards=value)


def test_frame_pins_borrowed_guards_through_active_close():
    def target(action):return action()
    handle=install_function(target,count=True,borrow_guards=True)
    ref=weakref.ref(target)
    def action():
        handle.close()
        gc.collect()
        frame=sys._getframe(1)
        assert frame.f_code is ref().__code__
        return 42
    assert target(action)==42 and not handle.active


def test_borrowed_guards_do_not_pin_dead_prepared_source():
    from types import FunctionType
    def target(value):return value
    fn=FunctionType(target.__code__.replace(),{})
    ref=weakref.ref(fn);code_ref=weakref.ref(fn.__code__)
    prepared=prepare_function(fn,borrow_guards=True)
    handle=prepared.install()
    assert fn(9)==9
    del fn
    assert ref() is None and code_ref() is None and not handle.active


def test_borrowed_guard_shared_code_uses_original_function_identity():
    from types import FunctionType
    def template():return marker
    first=FunctionType(template.__code__,{'marker':object()})
    second=FunctionType(template.__code__,{'marker':object()})
    handle=install_function(first,count=True,borrow_guards=True)
    try:
        assert first() is first.__globals__['marker']
        assert second() is second.__globals__['marker']
        assert stats(handle)['calls']==1 and stats(handle)['decline']==1
    finally:handle.close()


def test_executed_specialization_cache_does_not_pin_source_code():
    from types import FunctionType
    def template(value):return value.x
    class Value:pass
    value=Value();value.x=7
    fn=FunctionType(template.__code__.replace(),{})
    for _ in range(200):assert fn(value)==7
    ref=weakref.ref(fn);code_ref=weakref.ref(fn.__code__)
    prepared=prepare_function(fn,specialize=True,borrow_guards=True)
    handle=prepared.install()
    assert fn(value)==7
    del fn
    assert ref() is None and code_ref() is None and not handle.active
