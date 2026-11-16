"""Fresh-process ownership/finalizer checks for the active no-op consumer."""
import dis,sys,types,weakref
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.entry import install_frame_entry
from recompyler.ir.types import ValueType,PYOBJECT,INT64
from frame_install_cases import Keepalive


def install(function,args):
    lowered=lower(build(function),frame_entry=True)
    assert lowered.refcount_stats['active'] and lowered.refcount_stats['noop_closes']>0
    owner=Keepalive(lowered)
    handle=install_frame_entry(function,owner.address,owner,seed_arguments=args)
    return owner,handle


def oracle(function):return types.FunctionType(function.__code__.replace(),function.__globals__,argdefs=function.__defaults__)


def case_profile_hot_equality():
    function=ValueType.__eq__;baseline=oracle(function)
    pairs=[(PYOBJECT,ValueType()),(PYOBJECT,INT64),(INT64,ValueType('int64')),(ValueType('object',int),ValueType('object',int)),(PYOBJECT,object())]
    expected=[baseline(*args) for args in pairs]
    owner,handle=install(function,pairs[0])
    try:
        assert [function(*args) for args in pairs]==expected
        events=[]
        class Answer:
            def __bool__(self):events.append('bool');return False
        marker=Answer()
        class Kind:
            def __eq__(self,other):events.append('eq');return marker
        left=ValueType(Kind());right=ValueType()
        assert function(left,right) is marker and events==['eq','bool']
        assert owner.calls.value==len(pairs)+1
        assert function.__code__ is owner.lowered.graph.code
    finally:handle.close()


def fields(left,right,gate=False):
    # A real backedge supplies CPython's canonical seed; no body is run by
    # compilation. The observed lifetime path uses the ordinary false gate.
    while gate:gate=False
    return left.value is right.value


def execute(function,fail):
    events=[];references=[];failure=LookupError('owned field failure')
    class Item:
        def __init__(self,label):self.label=label;references.append(weakref.ref(self))
        def __contains__(self,item):
            frame=sys._getframe(1)
            events.append(('contains',self.label,item.label,frame.f_code is function.__code__,frame.f_lasti))
            return False
        def __del__(self):
            frame=sys._getframe(1)
            events.append(('drop',self.label,frame.f_code is function.__code__,frame.f_lasti))
    class Owner:
        def __init__(self,label):self.label=label
        @property
        def value(self):
            frame=sys._getframe(1)
            events.append(('read',self.label,frame.f_code is function.__code__,frame.f_lasti))
            if fail and self.label=='right':raise failure
            return Item(self.label)
    try:result=function(Owner('left'),Owner('right'))
    except LookupError as error:
        assert fail and error is failure
        tb=error.__traceback__
        while tb and tb.tb_frame.f_code is not function.__code__:tb=tb.tb_next
        assert tb is not None
        events.append(('error',tb.tb_lasti))
        failure.__traceback__=None;del tb
    else:assert not fail and result is False
    assert all(reference() is None for reference in references)
    return events


def contains_fields(left,right,gate=False):
    while gate:gate=False
    return left.value in right.value


def compare_fields(fail,function=fields):
    expected=execute(oracle(function),fail)
    owner,handle=install(function,(None,None,True))
    try:
        actual=execute(function,fail)
        assert actual==expected,(actual,expected)
        assert owner.calls.value==1
    finally:handle.close()


def case_owned_finalizers():compare_fields(False)
def case_owned_error():compare_fields(True)
def case_contains_finalizers():compare_fields(False,contains_fields)


if __name__=='__main__':
    name=sys.argv[1];globals()['case_'+name]();print('PASS '+name,flush=True)
