"""New generic operations resume exactly when callbacks enable observation."""
import sys
import pytest
from test_ir_existing_frame import frame_entry
from test_ir_collections import expanded_list,expanded_set,delete_attribute,delete_item


def consume(values):
    result=None
    for value in values:
        result=value
    return result

def unpack(values):
    first,second=values
    return first

def formatted(value):
    return f'{value}'

def converted(value):
    return f'{value!r}'


# A direct EvalFrameDefault restart collapses the previous/NEXT PCs at the
# first new line. Deletion transitions therefore use the actual executor
# observer_deletions case in frame_install_cases.py, with counted native hits.
@pytest.mark.parametrize('kind',['get_iter','next','exhausted','unpack','format','convert','super','list_extend','set_update'])
def test_new_generic_callback_observation_resumes_original_stack_and_successor(kind):
    events=[];marker='observer-marker '+str(object());source=None
    def trace(frame,event,arg):
        if frame.f_code is source.__code__:events.append((event,frame.f_lineno))
        return trace
    def activate():
        frame=sys._getframe(2)
        assert frame.f_code is source.__code__
        frame.f_trace=trace;sys.settrace(trace)
    class Source:
        count=0
        def __iter__(self):
            self.count=0
            if kind=='unpack':activate();return iter((marker,None))
            if kind in ('get_iter','list_extend','set_update'):activate()
            return self
        def __next__(self):
            self.count+=1
            if kind in ('next','exhausted'):activate()
            if kind=='exhausted' or self.count>1:raise StopIteration
            return marker
        def __delattr__(self,name):activate()
        def __delitem__(self,key):activate()
        def __format__(self,spec):activate();return marker
        def __repr__(self):activate();return marker
    class Parent:
        @property
        def field(self):activate();return marker
    class Child(Parent):
        def read(self):
            return super().field
    source=consume if kind in ('get_iter','next','exhausted') else unpack if kind=='unpack' else formatted if kind=='format' else converted if kind=='convert' else Child.read
    source={'list_extend':expanded_list,'set_update':expanded_set,'delete_attr':delete_attribute,'delete_subscr':delete_item}.get(kind,source)
    value=Child() if kind=='super' else Source()
    args=(value,marker) if kind=='delete_subscr' else (value,)
    native,_,_=frame_entry(source)
    try:expected_value=source(*args)
    finally:sys.settrace(None)
    expected=events.copy();events.clear()
    try:actual=native(*args)
    finally:sys.settrace(None)
    if kind in ('list_extend','set_update'):assert actual==expected_value
    else:assert actual is expected_value
    assert events==expected,(kind,expected,events)
