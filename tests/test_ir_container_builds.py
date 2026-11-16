"""Container construction calls CPython's own paths and keeps stack lifetimes."""
import sys,weakref
import pytest
from test_ir_existing_frame import frame_entry


def native(function):return frame_entry(function)[0]


def map_pair(a,b,c,d):return {a:b,c:d}
def set_three(a,b,c):return {a,b,c}
def list_three(a,b,c):return [a,b,c]
def empty_map():return {}
def empty_list():return []
def temporary_map(a,b,c,d):return {a+0:b+0,c+0:d+0}
def temporary_set(a,b,c):return {a+0,b+0,c+0}


def test_six_colliding_dictionary_keys_do_not_repeat_equality():
    def dictionary(a,b,c,d,e,f): return {a:0,b:1,c:2,d:3,e:4,f:5}
    class Key:
        def __init__(self): self.compared=set()
        def __hash__(self): return 32
        def __eq__(self,other):
            identity=id(other)
            if identity in self.compared: raise RuntimeError('repeated equality')
            self.compared.add(identity)
            return False
    for target in (dictionary,native(dictionary)):
        assert len(target(*(Key() for _ in range(6))))==6


@pytest.mark.parametrize('function',[empty_map,empty_list])
def test_empty_container_has_exact_type_and_new_identity(function):
    call=native(function);first=call();second=call()
    assert type(first) is type(function()) and first==function() and first is not second


def test_list_and_map_preserve_referenced_object_identity():
    values=[object(),object(),object()]
    result=native(list_three)(*values)
    assert all(actual is expected for actual,expected in zip(result,values))
    first,second=object(),object()
    mapping=native(map_pair)(first,values[0],second,values[1])
    assert list(mapping)==[first,second]
    assert mapping[first] is values[0] and mapping[second] is values[1]


def test_dict_duplicate_temporary_cleanup_is_key_then_replaced_value():
    call=native(temporary_map)
    def check(target):
        events=[]
        class Item:
            def __init__(self,name):self.name=name
            def __hash__(self):return 1
            def __eq__(self,other):return True
            def __del__(self):events.append(self.name)
        class Source:
            def __init__(self,name):self.name=name
            def __add__(self,other):return Item(self.name)
        result=target(*(Source(i) for i in range(4)))
        return events.copy()
    assert check(call)==check(temporary_map)==[2,1]


def test_set_consumes_duplicate_before_later_hash():
    call=native(temporary_set)
    def check(target):
        events=[]
        class Item:
            def __init__(self,name):self.name=name
            def __hash__(self):return 2 if self.name==2 and 1 not in events else 1
            def __eq__(self,other):return True
            def __del__(self):events.append(self.name)
        class Source:
            def __init__(self,name):self.name=name
            def __add__(self,other):return Item(self.name)
        result=target(*(Source(i) for i in range(3)))
        return len(result),events.copy()
    assert check(call)==check(temporary_set)==(1,[1,2])


@pytest.mark.parametrize('mapping',[False,True])
def test_hash_error_retains_original_source_frame_offset_and_identity(mapping):
    function=map_pair if mapping else set_three;call=native(function)
    def check(target):
        failure=LookupError('hash failed');events=[]
        class Key:
            def __hash__(self):
                frame=sys._getframe(1)
                events.append((frame.f_code is function.__code__,frame.f_lasti,frame.f_locals['a'] is self))
                raise failure
        key=Key()
        args=(key,object(),object(),object()) if mapping else (key,object(),object())
        with pytest.raises(LookupError) as caught:target(*args)
        assert caught.value is failure
        tb=caught.value.__traceback__
        while tb and tb.tb_frame.f_code is not function.__code__:tb=tb.tb_next
        assert tb is not None
        result=events,tb.tb_lasti
        failure.__traceback__=None
        del caught,tb
        return result
    assert check(call)==check(function)


def test_list_steal_keeps_values_until_the_list_releases_them():
    call=native(list_three);events=[]
    class Value:
        def __init__(self,index):self.index=index
        def __del__(self):events.append(self.index)
    values=[Value(i) for i in range(3)];references=[weakref.ref(v) for v in values]
    result=call(*values);del values
    assert all(reference() is result[i] for i,reference in enumerate(references))
    del result
    assert events==[2,1,0] and all(reference() is None for reference in references)


def test_set_error_retires_later_inputs_before_releasing_partial_set():
    call=native(temporary_set)
    def check(target):
        events=[];failure=ValueError('hash1')
        class Item:
            def __init__(self,name):self.name=name
            def __hash__(self):
                events.append(('hash',self.name))
                if self.name==1:raise failure
                return 1
            def __del__(self):
                frame=sys._getframe(1)
                events.append(('drop',self.name,frame.f_code is temporary_set.__code__,frame.f_lasti))
        class Source:
            def __init__(self,name):self.name=name
            def __add__(self,other):return Item(self.name)
        with pytest.raises(ValueError) as caught:target(*(Source(i) for i in range(3)))
        assert caught.value is failure
        before=list(events)
        failure.__traceback__=None
        del caught
        return before
    assert check(call)==check(temporary_set)
