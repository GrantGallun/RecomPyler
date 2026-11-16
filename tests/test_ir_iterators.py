"""General container iteration uses CPython iterator boundaries and original frames."""
import sys,weakref
import pytest
from test_ir_existing_frame import frame_entry


def last(values):
    result=None
    for value in values:result=value
    return result


def total(values):
    result=0
    for value in values:result+=value
    return result


def nested(rows):
    result=None
    for row in rows:
        for value in row:result=value
    return result


def until_none(values):
    result=None
    for value in values:
        if value is None:break
        result=value
    return result


@pytest.mark.parametrize('function',[last,total,nested,until_none])
def test_general_iteration_over_builtin_values_and_nested_stack_prefix(function):
    call=frame_entry(function)[0]
    values=([[],[[]],[[object()]],[[object()],[object(),object()]]] if function is nested else
            [[],[1,2,3],(1,2,3),range(5)] if function is total else
            [[],[object()],[object(),None,object()]])
    for value in values:
        expected=function(value);actual=call(value)
        if function is total:assert type(actual) is type(expected) and actual==expected
        else:assert actual is expected


@pytest.mark.parametrize('fails',[False,True])
def test_python_iterator_callbacks_keep_source_pc_locals_and_exception(fails):
    call=frame_entry(last)[0]
    def check(target):
        events=[];failure=ValueError('next failed');marker=object();replacement=object()
        class Iterator:
            count=0
            def __iter__(self):
                frame=sys._getframe(1)
                events.append(('iter',frame.f_code is last.__code__,frame.f_lasti))
                return self
            def __next__(self):
                frame=sys._getframe(1)
                events.append(('next',frame.f_code is last.__code__,frame.f_lasti))
                self.count+=1
                if self.count==1:return marker
                frame.f_locals['result']=replacement
                if fails:raise failure
                raise StopIteration('done')
        if fails:
            with pytest.raises(ValueError) as caught:target(Iterator())
            assert caught.value is failure
            failure.__traceback__=None;del caught
        else:assert target(Iterator()) is replacement
        return events
    assert check(call)==check(last)


def test_iterator_is_released_at_original_pop_iter_site():
    call=frame_entry(last)[0]
    def check(target):
        events=[];references=[]
        class Iterator:
            def __init__(self):references.append(weakref.ref(self,lambda ref:events.append('weakref')))
            def __next__(self):raise StopIteration
            def __del__(self):
                frame=sys._getframe(1)
                events.append(('drop',frame.f_code is last.__code__,frame.f_lasti))
        class Source:
            def __iter__(self):return Iterator()
        assert target(Source()) is None
        assert references[0]() is None
        return events
    assert check(call)==check(last)



def test_real_python_generator_return_value_is_retired_at_original_for_iter():
    call=frame_entry(last)[0]
    def check(target):
        events=[];marker=object()
        class Returned:
            def __del__(self):
                frame=sys._getframe(1)
                events.append((frame.f_code is last.__code__,frame.f_lasti))
        def values():
            yield marker
            return Returned()
        assert target(values()) is marker
        return events
    for _ in range(20):assert check(call)==check(last)


def test_fused_store_load_captures_total_before_old_value_finalizer():
    import dis
    call=frame_entry(total)[0]
    fused=next(op.offset for op in dis.get_instructions(total) if op.opname=='STORE_FAST_LOAD_FAST')
    def check(target):
        events=[]
        class Value:
            def __radd__(self,previous):return previous+1
            def __del__(self):
                frame=sys._getframe(1)
                if frame.f_code is total.__code__ and frame.f_lasti==fused:
                    events.append('rewrite')
                    frame.f_locals['result']=1000
        class Iterator:
            count=0
            def __iter__(self):return self
            def __next__(self):
                self.count+=1
                if self.count>3:raise StopIteration
                return Value()
        result=target(Iterator())
        return result,events
    assert check(call)==check(total)==(3,['rewrite','rewrite'])
