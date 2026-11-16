"""RED witnesses for original CPython collection mutation operations."""
import sys,weakref,gc
import pytest
from test_ir_existing_frame import frame_entry


def expanded_list(values):return [None,*values,True]
def expanded_set(values):return {None,*values,True}
def delete_attribute(owner):
    del owner.field
    return owner
def delete_item(owner,key):
    del owner[key]
    return owner


@pytest.mark.parametrize('function',[expanded_list,expanded_set])
def test_expanded_literals_follow_cpython_iterator_and_failure_protocol(function):
    call=frame_entry(function)[0];marker=object()
    for values in ([],[marker],(marker,),range(3)):
        assert call(values)==function(values)
    with pytest.raises(TypeError) as expected:function(42)
    with pytest.raises(TypeError) as actual:call(42)
    assert str(actual.value)==str(expected.value)
    def check(target):
        events=[];failure=ValueError('iterate fail')
        class Source:
            count=0
            def __iter__(self):
                frame=sys._getframe(1);events.append(('iter',frame.f_code is function.__code__,frame.f_lasti));return self
            def __next__(self):
                frame=sys._getframe(1);events.append(('next',frame.f_code is function.__code__,frame.f_lasti));self.count+=1
                if self.count==1:return marker
                raise failure
        with pytest.raises(ValueError) as caught:target(Source())
        assert caught.value is failure;failure.__traceback__=None;del caught
        return events
    assert check(call)==check(function)


@pytest.mark.parametrize('function',[delete_attribute,delete_item])
def test_delete_protocol_original_callback_source_and_exact_error(function):
    call=frame_entry(function)[0];key=object()
    def check(target,fails):
        events=[];failure=LookupError('delete failed')
        class Owner:
            def __delattr__(self,name):
                frame=sys._getframe(1);events.append((name,frame.f_code is function.__code__,frame.f_lasti))
                if fails:raise failure
            def __delitem__(self,item):
                frame=sys._getframe(1);events.append((item is key,frame.f_code is function.__code__,frame.f_lasti))
                if fails:raise failure
        owner=Owner()
        if fails:
            with pytest.raises(LookupError) as caught:
                target(owner,key) if function is delete_item else target(owner)
            assert caught.value is failure;failure.__traceback__=None;del caught
        else:assert (target(owner,key) if function is delete_item else target(owner)) is owner
        return events
    for fails in (False,True):assert check(call,fails)==check(function,fails)




def test_real_list_cache_eviction_helper_runs_its_original_dictionary_deletion():
    from recompyler.lift import _ListCache,LIST_CACHE_ENTRIES
    fn=_ListCache.worth_keeping;call,lowered,status=frame_entry(fn);value=[]
    def owner():
        cache=object.__new__(_ListCache)
        cache.seen={index:None for index in range(4*LIST_CACHE_ENTRIES)}
        return cache
    plain=owner();native=owner()
    assert fn(plain,value) is call(native,value) is False
    assert native.seen==plain.seen and 0 not in native.seen and id(value) in native.seen
    assert fn(plain,value) is call(native,value) is True
    assert status.value==1 and lowered.graph.code is fn.__code__


@pytest.mark.parametrize('function',[expanded_list,expanded_set])
def test_expansion_retains_original_typeerror_and_length_hint_failure(function):
    call=frame_entry(function)[0]
    def check(target):
        failure=TypeError('intentional iterator failure')
        class Source:
            def __iter__(self):raise failure
        with pytest.raises(TypeError) as caught:target(Source())
        assert caught.value is failure;failure.__traceback__=None;del caught
    check(function);check(call)
    if function is expanded_list:
        failure=ValueError('hint failed')
        class Iterator:
            def __iter__(self):return self
            def __next__(self):raise StopIteration
            def __length_hint__(self):raise failure
        for target in (function,call):
            with pytest.raises(ValueError) as caught:target(Iterator())
            assert caught.value is failure;failure.__traceback__=None;del caught
