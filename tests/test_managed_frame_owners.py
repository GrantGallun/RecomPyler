"""A native child must retain source locals while its traceback is alive."""
import weakref
import pytest
from recompyler import heap

def child(action):
    local=action('make')
    action('fail')
    return None

def parent(action):
    return child(action)

def test_native_child_error_traceback_keeps_its_local_owner():
    for native in (False,True):
        events=[];references=[];error=ValueError('original')
        class Token:
            def __del__(self):events.append('drop')
        def action(phase):
            if phase=='make':
                value=Token();references.append(weakref.ref(value));return value
            events.append('fail')
            raise error
        region=heap.lift_calls(parent,callees=(child,)) if native else parent
        if native:assert region.run is not None,region.problem
        with pytest.raises(ValueError) as caught:region(action)
        assert caught.value is error
        if native:assert region.compiled_calls==1 and region.fallback_calls==0
        assert references[0]() is not None and events==['fail']
        error.__traceback__=None
        del caught
        assert references[0]() is None and events==['fail','drop']


def success_child(action):
    local=action('make')
    action('capture')
    return None

def success_parent(action):
    success_child(action)
    action('after')
    return None

def test_native_child_return_keeps_locals_if_callback_traceback_captured_its_caller():
    for native in (False,True):
        events=[];state={}
        class Token:
            def __del__(self):events.append('drop')
        def action(phase):
            if phase=='make':
                value=Token();state['reference']=weakref.ref(value);return value
            if phase=='capture':
                try:raise ValueError('saved')
                except ValueError as error:state['error']=error
                return None
            events.append(('after',state['reference']() is not None))
        region=heap.lift_calls(success_parent,callees=(success_child,)) if native else success_parent
        if native:assert region.run is not None,region.problem
        assert region(action) is None
        if native:assert region.compiled_calls==1 and region.fallback_calls==0
        assert events==[('after',True)]
        state.pop('error').__traceback__=None
        assert state['reference']() is None and events==[('after',True),'drop']


def source_frame(action):
    return action()


@pytest.mark.xfail(strict=True,reason='Native callback source frame is not materialized')
def test_native_callback_observes_original_source_frame_code():
    import sys
    def inspect_parent():return sys._getframe(1).f_code
    expected=source_frame(inspect_parent)
    assert expected is source_frame.__code__
    native=heap.lift_calls(source_frame)
    assert native(inspect_parent) is expected
