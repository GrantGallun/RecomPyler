"""S56 real flat protocol requirements; the existing Lifted path is the red control."""
from array import array
import importlib,struct
import pytest
from recompyler import lift
pytest.importorskip("recompyler._flat_native")

def candidate(fn):
    try:module=importlib.import_module('recompyler._flat')
    except ModuleNotFoundError:return lift.lift(fn)
    return module.FlatLifted(fn)

def bits(v):return struct.pack('!d',v)
def first(values):return values[0]
def total(values):
    result=0.0
    for value in values:result+=value
    return result

def tuple_read(pair):
    i,values=pair
    return values[i]

def integer_last(values):return values[-1]
def array_store(values,index,value):
    previous=values[index]
    values[index]=value
    return previous

def array_partial(values,index):
    values[0]+=1.0
    return values[index]

def two_owners(left,right):return left[0]+right[0]
def return_owner(values):return values

def assert_native(wrapped,calls):
    assert wrapped.compiled_calls==calls and wrapped.fallback_calls==0
    assert getattr(wrapped,'flat_calls',0)==calls
    audit=wrapped.last_audit
    assert audit['native_entries']==1 and audit['commits']==1
    assert audit['open']==audit['close']==1 and audit['active']==0

@pytest.mark.parametrize('pattern',[0x8000000000000000,0x7ff8000000000042,0x7ff8000000001234,0x3ff4000000000000])
def test_exact_float_first_and_warm_native(pattern):
    value=struct.unpack('!d',struct.pack('!Q',pattern))[0]
    values=[value];wrapped=candidate(first)
    for call in (1,2):
        result=wrapped(values)
        assert type(result) is float and bits(result)==bits(value)
        assert_native(wrapped,call)

@pytest.mark.parametrize('value',[-(2**63),2**53+1,2**63-1])
def test_exact_integer_endpoints_native(value):
    wrapped=candidate(integer_last);values=[0,value]
    assert type(wrapped(values)) is int and wrapped(values)==value
    assert_native(wrapped,2)

def test_live_length_iteration_and_no_warm_payload_copy(monkeypatch):
    wrapped=candidate(total);values=[1.25,2.0]
    assert wrapped(values)==3.25
    old=lift._Boundary.copy;copies=[]
    def observed(self,value):
        copies.append(value);return old(self,value)
    monkeypatch.setattr(lift._Boundary,'copy',observed)
    values[:]=[4.0,8.0,16.0]
    assert wrapped(values)==28.0
    assert copies==[]
    assert_native(wrapped,2)

def test_real_tuple_argument_is_preserved():
    wrapped=candidate(tuple_read);values=[2.5,4.0]
    assert wrapped((1,values))==4.0
    assert_native(wrapped,1)

@pytest.mark.parametrize('bad',[True,2**63,1.0])
def test_integer_kind_or_range_miss_declines_before_use(bad):
    wrapped=candidate(integer_last)
    assert wrapped([2,3])==3
    values=[2,bad]
    result=wrapped(values)
    assert type(result) is type(bad) and result==bad
    assert getattr(wrapped,'flat_calls',0)==1
    assert wrapped.fallback_calls==1

def test_array_direct_store_and_balanced_export():
    values=array('d',[4.5,-0.0]);wrapped=candidate(array_store)
    assert wrapped(values,0,1.25)==4.5
    assert bits(values[0])==bits(1.25) and bits(values[1])==bits(-0.0)
    assert_native(wrapped,1)
    values.append(9.0)
    assert wrapped(values,1,8.0)==-0.0
    assert_native(wrapped,2)

def test_partial_array_failure_rolls_back_then_replays_once():
    values=array('d',[4.5]);wrapped=candidate(array_partial)
    assert wrapped(values,0)==5.5
    assert_native(wrapped,1)
    with pytest.raises(IndexError):wrapped(values,9)
    assert values[0]==6.5
    assert wrapped.last_audit['native_entries']==1
    assert wrapped.last_audit['commits']==0 and wrapped.last_audit['rollbacks']==1
    assert wrapped.last_audit['open']==wrapped.last_audit['close']==1
    assert wrapped.last_audit['active']==0
    assert wrapped.flat_calls==1 and wrapped.fallback_calls==1
    values.append(9.0)

def test_multiple_owners_and_aliases_decline_this_increment():
    wrapped=candidate(two_owners);left=[1.25];right=[4.5]
    assert wrapped(left,right)==5.75
    assert wrapped(left,left)==2.5
    assert getattr(wrapped,'flat_calls',0)==0
    assert wrapped.fallback_calls==2

def test_returned_container_keeps_original_owner_through_decline():
    wrapped=candidate(return_owner);values=[1.25]
    assert wrapped(values) is values
    assert getattr(wrapped,'flat_calls',0)==0 and wrapped.fallback_calls==1


FACTOR=2.0
def global_read(values):return values[0]*FACTOR
def replacement(values):return values[0]+8.0
def helper(values):return values[0]
def helper_read(values):return helper(values)
def bool_read(values):return values[0]>0.0
def none_store(values):values[0]+=1.0

def _at_entry(wrapped,action):
    import sys
    hit=[]
    def profile(frame,event,arg):
        if not hit and event=='call' and frame.f_code is type(wrapped)._invoke.__code__:
            hit.append(True);action()
    sys.setprofile(profile)
    return hit


def test_profile_mutates_list_after_holder_before_native_read():
    import sys
    wrapped=candidate(first);values=[1.25]
    assert wrapped(values)==1.25
    hit=_at_entry(wrapped,lambda: values.__setitem__(0,True))
    try:assert wrapped(values) is True
    finally:sys.setprofile(None)
    assert hit and wrapped.flat_calls==1 and wrapped.fallback_calls==1
    assert wrapped.last_audit['native_entries']==1 and wrapped.last_audit['commits']==0
    assert wrapped.last_audit['open']==wrapped.last_audit['close']==1


def test_profile_mutates_global_after_python_guard_before_native_open():
    import sys
    global FACTOR
    FACTOR=2.0;wrapped=candidate(global_read);values=[1.25]
    assert wrapped(values)==2.5
    hit=_at_entry(wrapped,lambda: globals().__setitem__('FACTOR',4.0))
    try:assert wrapped(values)==5.0
    finally:sys.setprofile(None);FACTOR=2.0
    assert hit and wrapped.flat_calls==1 and wrapped.fallback_calls==1
    assert wrapped.last_audit['native_entries']==0
    assert wrapped.last_audit['open']==wrapped.last_audit['close']==1


def test_profile_changes_original_code_before_native_open():
    import sys
    old=helper.__code__;wrapped=candidate(helper_read);values=[1.25]
    assert wrapped(values)==1.25
    hit=_at_entry(wrapped,lambda: setattr(helper,'__code__',replacement.__code__))
    try:assert wrapped(values)==9.25
    finally:sys.setprofile(None);helper.__code__=old
    assert hit and wrapped.flat_calls==1 and wrapped.fallback_calls==1
    assert wrapped.last_audit['native_entries']==0
    assert wrapped.last_audit['open']==wrapped.last_audit['close']==1


def test_profile_changes_array_before_export_and_undo_capture():
    import sys
    values=array('d',[4.5]);wrapped=candidate(array_partial)
    assert wrapped(values,0)==5.5
    hit=_at_entry(wrapped,lambda: values.append(7.25))
    try:assert wrapped(values,1)==7.25
    finally:sys.setprofile(None)
    assert hit and values.tolist()==[6.5,7.25]
    assert_native(wrapped,2)
    values.append(9.0)


def test_guard_failure_releases_array_without_copying_uninitialised_undo():
    import sys
    old=array_partial.__code__;values=array('d',[4.5]);wrapped=candidate(array_partial)
    assert wrapped(values,0)==5.5
    hit=_at_entry(wrapped,lambda: setattr(array_partial,'__code__',tuple_read.__code__))
    try:
        # The replacement receives two arguments, matching Python's TypeError.
        with pytest.raises(TypeError):wrapped(values,0)
    finally:sys.setprofile(None);array_partial.__code__=old
    assert hit and values.tolist()==[5.5]
    assert wrapped.last_audit['native_entries']==0
    assert wrapped.last_audit['open']==wrapped.last_audit['close']==1
    assert wrapped.last_audit['rollbacks']==0
    values.append(8.0)


def test_postcommit_profile_error_never_replays_array_store():
    import sys
    from recompyler.lift import Unsupported
    values=array('d',[4.5]);wrapped=candidate(array_partial)
    assert wrapped(values,0)==5.5
    hit=[]
    def profile(frame,event,arg):
        if not hit and event=='return' and frame.f_code is type(wrapped)._invoke.__code__:
            hit.append(True);raise Unsupported('after committed native return')
    sys.setprofile(profile)
    try:
        with pytest.raises(Unsupported,match='after committed'):wrapped(values,0)
    finally:sys.setprofile(None)
    assert hit and values.tolist()==[6.5]
    assert wrapped.flat_calls==1 and wrapped.fallback_calls==0
    assert wrapped.last_audit['commits']==1 and wrapped.last_audit['active']==0
    values.append(8.0)


@pytest.mark.parametrize('values',[[],[1.0],[1.0,2.0]])
def test_empty_and_resized_iteration(values):
    wrapped=candidate(total)
    was_empty=not values
    assert wrapped(values)==sum(values)
    if was_empty:
        assert wrapped.flat_calls==0 and wrapped.fallback_calls==1
    else:assert_native(wrapped,1)
    values[:]=[4.0,8.0]
    assert wrapped(values)==12.0
    assert wrapped.flat_calls==(1 if was_empty else 2)
    values.clear()
    assert wrapped(values)==0.0
    assert wrapped.last_audit['commits']==1


@pytest.mark.parametrize('fn,expected',[(bool_read,True),(none_store,None)])
def test_singleton_results_native(fn,expected):
    values=array('d',[4.5]);wrapped=candidate(fn)
    assert wrapped(values) is expected
    assert_native(wrapped,1)
    values.append(2.0)


def test_cold_preparation_never_deepcopies_unread_application_object():
    events=[]
    class Unread:
        def __deepcopy__(self,memo):
            events.append("deepcopy");raise RuntimeError("unexpected input hook")
    values=[1.25,Unread()];wrapped=candidate(first)
    assert wrapped(values)==1.25
    assert events==[]
    # A warmed exact-list path also never inspects that unread leaf.
    warmed=candidate(first);assert warmed([2.5])==2.5
    assert warmed(values)==1.25
    assert_native(warmed,2)



def test_preentry_profile_exception_propagates_without_replay():
    import sys
    values=array('d',[4.5]);wrapped=candidate(array_partial)
    assert wrapped(values,0)==5.5
    def action():raise KeyboardInterrupt('before native open')
    hit=_at_entry(wrapped,action)
    try:
        with pytest.raises(KeyboardInterrupt,match='before native'):wrapped(values,0)
    finally:sys.setprofile(None)
    assert hit and values.tolist()==[5.5]
    assert wrapped.flat_calls==1 and wrapped.fallback_calls==0


def test_postcommit_audit_profile_exception_propagates_without_replay():
    import sys
    from recompyler import _flat_native
    values=array('d',[4.5]);wrapped=candidate(array_partial)
    assert wrapped(values,0)==5.5
    hit=[]
    def profile(frame,event,arg):
        if not hit and event=='c_call' and arg is _flat_native.audit:
            hit.append(True);raise lift.Unsupported('before postcommit audit')
    sys.setprofile(profile)
    try:
        with pytest.raises(lift.Unsupported,match='postcommit audit'):wrapped(values,0)
    finally:sys.setprofile(None)
    assert hit and values.tolist()==[6.5]
    assert wrapped.flat_calls==1 and wrapped.fallback_calls==0
    values.append(8.0)



def partial_raise(values,stop):
    values[0]+=1.0
    if stop:raise ValueError('after store')
    return values[0]

def partial_divide(values,divisor):
    values[0]+=1.0
    return values[0]/divisor

@pytest.mark.parametrize('fn,bad,error,message',[
    (partial_raise,True,ValueError,'after store'),
    (partial_divide,0.0,ZeroDivisionError,'division by zero')])
def test_checked_exception_rolls_back_before_once_only_python_effect(fn,bad,error,message):
    values=array('d',[4.5]);wrapped=candidate(fn)
    good=False if fn is partial_raise else 2.0
    wrapped(values,good);assert_native(wrapped,1)
    with pytest.raises(error) as expected:fn(array('d',[5.5]),bad)
    with pytest.raises(type(expected.value)) as actual:wrapped(values,bad)
    assert str(actual.value)==str(expected.value)
    assert values.tolist()==[6.5]
    assert wrapped.flat_calls==1 and wrapped.fallback_calls==1
    assert wrapped.last_audit['rollbacks']==1 and wrapped.last_audit['commits']==0
    values.append(2.0)


def test_unaccessed_mixed_leaf_and_accessed_subclass_preserve_identity():
    class Number(float):pass
    value=Number(1.25);wrapped=candidate(first)
    assert wrapped([2.5])==2.5
    assert wrapped([value]) is value
    assert wrapped.flat_calls==1 and wrapped.fallback_calls==1


def entry_raise(values,index):raise ValueError("entry replacement")

def test_preparation_decline_does_not_leak_internal_exception_context():
    wrapped=candidate(first)
    with pytest.raises(TypeError) as actual:wrapped(-1)
    assert actual.value.__context__ is None


def test_native_entry_decline_does_not_leak_internal_exception_context():
    import sys
    old=array_partial.__code__;values=array('d',[4.5]);wrapped=candidate(array_partial)
    wrapped(values,0);assert_native(wrapped,1)
    hit=_at_entry(wrapped,lambda: setattr(array_partial,'__code__',entry_raise.__code__))
    try:
        with pytest.raises(ValueError,match="entry replacement") as actual:wrapped(values,0)
        assert actual.value.__context__ is None
    finally:sys.setprofile(None);array_partial.__code__=old
    assert hit and values.tolist()==[5.5]
