import math
import weakref
import gc
import pytest


def provider():
    from recompyler.libraries import _boundary_native
    return _boundary_native


def test_exact_builtin_meth_o_and_fastcall_execute_directly():
    native=provider()
    for function,args in [(math.sin,(0.5,)),(math.gcd,(48,18,30)),(len,([1,2],))]:
        guard=native.new_guard(function)
        value,hit=native.invoke(guard,function,args)
        expected=function(*args)
        assert hit is True
        assert type(value) is type(expected) and value==expected


def test_identity_miss_and_keywords_keep_the_original_call_behavior():
    native=provider();guard=native.new_guard(math.sin);events=[]
    def replacement(value):events.append(value);return ('replacement',value)
    assert native.invoke(guard,replacement,(3,))==(('replacement',3),False)
    assert events==[3]
    for args,kwargs in [((),None),((1,2),None),((1,),{'x':2})]:
        def error(call):
            try:call()
            except Exception as exc:return type(exc),exc.args
            raise AssertionError('expected an error')
        assert error(lambda:native.invoke(guard,math.sin,args,kwargs))==error(lambda:math.sin(*args,**(kwargs or {})))
    other=native.new_guard(sum)
    assert native.invoke(other,sum,([1,2],))==(3,False)


def test_guard_does_not_keep_a_bound_receiver_or_callable_alive():
    native=provider();events=[]
    class Owner(list):
        def __del__(self):events.append('freed')
    owner=Owner();function=owner.append
    owner_ref=weakref.ref(owner);function_ref=weakref.ref(function)
    guard=native.new_guard(function)
    del owner,function
    gc.collect()
    assert owner_ref() is None and function_ref() is None and events==['freed']
    assert native.invoke(guard,len,([1],))==(1,False)


def test_fastcall_conversion_callbacks_execute_once_and_propagate_errors():
    native=provider();guard=native.new_guard(math.gcd);events=[]
    class Index:
        def __index__(self):events.append('index');return 18
    assert native.invoke(guard,math.gcd,(48,Index()))==(6,True)
    assert events==['index']
    class Failure:
        def __index__(self):events.append('failure');raise LookupError('exact')
    with pytest.raises(LookupError,match='exact'):native.invoke(guard,math.gcd,(48,Failure()))
    assert events==['index','failure']
