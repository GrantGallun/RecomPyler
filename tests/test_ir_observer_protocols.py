"""Merged generic protocols preserve observers enabled by their callbacks."""
import sys
import pytest
from test_ir_existing_frame import frame_entry

def branch(value):
    if value:
        return True
    return False

def relation(left,right):
    result=left<right
    return result

def relation_truth(left,right):
    if left<right:
        return True
    return False

@pytest.mark.parametrize('kind',['truth','compare','compare_truth'])
def test_observer_enabled_inside_generic_protocol_resumes_source(kind):
    events=[]
    source=branch if kind=='truth' else relation_truth if kind=='compare_truth' else relation
    def trace(frame,event,arg):
        if frame.f_code is source.__code__:events.append((event,frame.f_lineno))
        return trace
    def activate():
        frame=sys._getframe(2);frame.f_trace=trace;sys.settrace(trace)
    class Verdict:
        def __bool__(self):activate();return True
    class Left:
        def __lt__(self,other):
            if kind=='compare_truth':return Verdict()
            activate()
            return True
    value=Verdict() if kind=='truth' else Left()
    args=(value,) if kind=='truth' else (value,object())
    native,_,_=frame_entry(source)
    try:expected_value=source(*args)
    finally:sys.settrace(None)
    expected=list(events);events.clear()
    try:actual=native(*args)
    finally:sys.settrace(None)
    assert actual is expected_value
    assert events==expected

def iteration(values):
    result=None
    for value in values:
        result=value
    return result

@pytest.mark.parametrize('site',['iter','next','stop'])
def test_observer_enabled_inside_iterator_resumes_original_edge(site):
    events=[];marker=object()
    def trace(frame,event,arg):
        if frame.f_code is iteration.__code__:events.append((event,frame.f_lineno))
        return trace
    def activate():
        frame=sys._getframe(2);frame.f_trace=trace;sys.settrace(trace)
    class Values:
        def __init__(self):self.done=False
        def __iter__(self):
            if site=='iter':activate()
            return self
        def __next__(self):
            if self.done:raise StopIteration
            self.done=True
            if site in ('next','stop'):activate()
            if site=='stop':raise StopIteration
            return marker
    native,_,_=frame_entry(iteration)
    try:expected_value=iteration(Values())
    finally:sys.settrace(None)
    expected=list(events);events.clear()
    try:actual=native(Values())
    finally:sys.settrace(None)
    assert actual is expected_value
    assert events==expected

def formatted(value):
    result=f'{value}'
    return result

def formatted_spec(value):
    result=f'{value:marker}'
    return result

def converted(value):
    result=f'{value!s}'
    return result

@pytest.mark.parametrize('source',[formatted,formatted_spec,converted])
def test_observer_enabled_inside_format_callback_resumes_next_original_line(source):
    events=[]
    def trace(frame,event,arg):
        if frame.f_code is source.__code__:events.append((event,frame.f_lineno))
        return trace
    def activate():
        frame=sys._getframe(2);frame.f_trace=trace;sys.settrace(trace)
        return 'same result'
    class Value:
        def __format__(self,spec):return activate()
        def __str__(self):return activate()
    native,_,_=frame_entry(source)
    try:expected_value=source(Value())
    finally:sys.settrace(None)
    expected=list(events);events.clear()
    try:actual=native(Value())
    finally:sys.settrace(None)
    assert actual==expected_value
    assert events==expected

def test_observer_enabled_inside_super_descriptor_resumes_original_source():
    events=[];marker=object();source=None
    def trace(frame,event,arg):
        if frame.f_code is source.__code__:events.append((event,frame.f_lineno))
        return trace
    class Parent:
        @property
        def item(self):
            frame=sys._getframe(1);frame.f_trace=trace;sys.settrace(trace)
            return marker
    class Child(Parent):
        def pick(self):
            result=super().item
            return result
    source=Child.pick;value=Child();native,_,_=frame_entry(source)
    try:assert source(value) is marker
    finally:sys.settrace(None)
    expected=list(events);events.clear()
    try:assert native(value) is marker
    finally:sys.settrace(None)
    assert events==expected
