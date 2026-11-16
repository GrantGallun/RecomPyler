"""Actual first-suspension prefixes; subsequent execution belongs to CPython."""
import dis,inspect,sys,types,weakref
from recompyler import heap
from recompyler._prepared import PreparedIndex
from generator_resume_cases import install


def delegated(source):
    result=yield from source
    return result


def clone(function):
    return types.FunctionType(function.__code__.replace(),function.__globals__,argdefs=function.__defaults__)


def case_delegation_protocol():
    events=[];a=object();b=object();sent=object();returned=object()
    def child():
        try:
            value=yield a
            events.append(value)
            yield b
            return returned
        finally:events.append('closed')
    owner,handle=install(delegated,((),))
    try:
        generator=delegated(child())
        assert generator.gi_code is delegated.__code__ and owner.calls.value==0
        assert next(generator) is a and owner.calls.value==1
        assert inspect.isgenerator(generator.gi_yieldfrom)
        assert generator.send(sent) is b and events==[sent] and owner.calls.value==1
        try:next(generator)
        except StopIteration as error:assert error.value is returned
        else:raise AssertionError('missing delegated return')
        assert events==[sent,'closed'] and generator.gi_frame is None and owner.calls.value==1
        events.clear();generator=delegated(child());assert next(generator) is a
        count=owner.calls.value;generator.close()
        assert events==['closed'] and owner.calls.value==count and generator.gi_frame is None
    finally:handle.close()


def case_list_iterator():
    source=[11,22]
    owner,handle=install(delegated,((),))
    try:
        generator=delegated(source)
        assert next(generator)==11
        assert type(generator.gi_yieldfrom) is type(iter(source))
        assert list(generator)==[22]
        assert source==[11,22] and owner.calls.value==1
    finally:handle.close()


def delegated_temporary(factory):
    return (yield from factory())


def lifetime_run(function):
    events=[];refs=[];marker=object()
    class Source:
        def __iter__(self):
            frame=sys._getframe(1)
            assert frame.f_code is function.__code__
            events.append(('iter',frame.f_lasti))
            return iter((marker,))
        def __del__(self):events.append(('drop',sys._getframe(1).f_lasti))
    def factory():
        source=Source()
        refs.append(weakref.ref(source,lambda ref:events.append(('weak',))))
        return source
    generator=function(factory)
    assert next(generator) is marker
    assert refs[0]() is None
    events.append(('yielded',generator.gi_frame.f_lasti))
    generator.close()
    return events


def case_iterator_lifetime():
    expected=lifetime_run(clone(delegated_temporary));owner,handle=install(delegated_temporary,(lambda:(),))
    try:
        actual=lifetime_run(delegated_temporary)
        assert actual==expected,(actual,expected)
        assert owner.calls.value==1
    finally:handle.close()


def error_run(function):
    failure=LookupError('iterator identity');events=[]
    class Source:
        def __iter__(self):
            frame=sys._getframe(1)
            assert frame.f_code is function.__code__
            events.append(('iter',frame.f_lasti))
            raise failure
        def __del__(self):events.append(('drop',))
    generator=function(Source())
    try:next(generator)
    except LookupError as error:
        assert error is failure
        tb=error.__traceback__
        while tb and tb.tb_frame.f_code is not function.__code__:tb=tb.tb_next
        assert tb is not None
        events.append(('error',tb.tb_lasti,type(tb.tb_frame.f_locals['source']).__name__))
        failure.__traceback__=None;del tb
    else:raise AssertionError('missing iterator error')
    assert generator.gi_frame is None
    return events


def case_iterator_error():
    expected=error_run(clone(delegated));owner,handle=install(delegated,((),))
    try:
        actual=error_run(delegated)
        assert actual==expected,(actual,expected)
        assert owner.calls.value==1
    finally:handle.close()


def case_coroutine_rejection():
    async def child():return None
    def run(function):
        coro=child();generator=function(coro)
        try:
            try:next(generator)
            except TypeError as error:return str(error)
            else:raise AssertionError('missing coroutine rejection')
        finally:generator.close();coro.close()
    expected=run(clone(delegated));owner,handle=install(delegated,((),))
    try:
        assert run(delegated)==expected and owner.calls.value==1
    finally:handle.close()


def case_original_bind():
    events=[];marker=object();entry=object()
    class Index(PreparedIndex):
        _bind_order=object()
        def _bind_records(self,value,order):
            assert value is entry and order is self._bind_order
            events.append('bind')
            return iter((marker,))
    index=object.__new__(Index)
    owner,handle=install(PreparedIndex.iter_bind,(index,entry))
    try:
        assert events==[]
        generator=index.iter_bind(entry)
        assert next(generator) is marker and events==['bind'] and owner.calls.value==1
        try:next(generator)
        except StopIteration as error:assert error.value is None
        else:raise AssertionError('missing bind completion')
        assert owner.calls.value==1
    finally:handle.close()


def case_original_zero_parts():
    kind=heap.TupT((heap.INT,heap.FLOAT));codes=['left','right']
    expected=list(clone(heap._zero_parts)(kind,codes))
    owner,handle=install(heap._zero_parts,(kind,codes))
    try:
        actual=list(heap._zero_parts(kind,codes))
        assert actual==expected and len(actual)==2
        assert all(a[1] is b[1] for a,b in zip(actual,expected))
        assert owner.calls.value>=1
    finally:handle.close()


if __name__=='__main__':
    name=sys.argv[1];globals()['case_'+name]();print('PASS '+name,flush=True)
