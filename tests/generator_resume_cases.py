"""Fresh-process real-PyGen acceptance for explicit first-resume IR slices."""
import ast,dis,inspect,sys,types
from recompyler import depmap
from recompyler.ir import build
from recompyler.ir.entry import install_frame_entry
from recompyler.ir.lower_llvm import lower
from frame_install_cases import Keepalive


def install(function,args):
    offset=next(i.offset for i in dis.get_instructions(function) if i.opname=='RESUME')
    owner=Keepalive(lower(build(function),frame_entry=True,entry_offset=offset))
    handle=install_frame_entry(function,owner.address,owner,seed_arguments=args,entry_offset=offset)
    return owner,handle


def exchange(value,events):
    events.append('first')
    sent=yield value
    events.append('second')
    yield sent


def case_creation_and_send():
    marker=object();sent=object();events=[]
    owner,handle=install(exchange,(marker,events))
    try:
        assert events==[] and owner.calls.value==0
        generator=exchange(marker,events)
        assert inspect.isgenerator(generator) and generator.gi_code is exchange.__code__
        assert events==[] and owner.calls.value==0
        assert next(generator) is marker and owner.calls.value==1
        assert events==['first'] and not generator.gi_running
        assert generator.send(sent) is sent and events==['first','second']
        assert owner.calls.value==1  # explicit first segment; later resume is Python
        generator.close();assert generator.gi_frame is None
    finally:handle.close()


def case_original_own_nodes():
    tree=ast.parse('def outer(x):\n    y=x+1\n    return y\nvalue=outer(4)')
    original=types.FunctionType(depmap._own_nodes.__code__.replace(),depmap._own_nodes.__globals__)
    expected=list(original(tree));owner,handle=install(depmap._own_nodes,(tree,))
    try:
        generator=depmap._own_nodes(tree);assert owner.calls.value==0
        result=list(generator)
        assert len(result)==len(expected) and all(a is b for a,b in zip(result,expected))
        assert owner.calls.value==1 and generator.gi_frame is None
    finally:handle.close()


def failing(error,events):
    events.append('effect')
    raise error
    yield None


def case_error_before_yield():
    failure=ValueError('original generator failure');events=[]
    owner,handle=install(failing,(failure,events))
    try:
        assert events==[]
        generator=failing(failure,events)
        try:next(generator)
        except ValueError as error:
            assert error is failure and owner.calls.value==1 and events==['effect']
            tb=error.__traceback__
            while tb and tb.tb_frame.f_code is not failing.__code__:tb=tb.tb_next
            assert tb is not None and tb.tb_frame.f_locals['error'] is failure
            assert generator.gi_frame is None
            del tb;failure.__traceback__=None
        else:raise AssertionError('missing original failure')
    finally:handle.close()


def cycling(value,events):
    events.append('start')
    while value:
        value=yield value
        events.append(value)
    return value


def case_multiple_resume_values():
    marker=object();other=object();events=[];resources=[]
    try:
        for instruction in dis.get_instructions(cycling):
            if instruction.opname!='RESUME':continue
            owner=Keepalive(lower(build(cycling),frame_entry=True,entry_offset=instruction.offset))
            handle=install_frame_entry(cycling,owner.address,owner,seed_arguments=(None,events),entry_offset=instruction.offset)
            resources.append((owner,handle))
        assert events==[] and all(owner.calls.value==0 for owner,handle in resources)
        generator=cycling(marker,events)
        assert next(generator) is marker and [owner.calls.value for owner,handle in resources]==[1,0]
        assert generator.send(other) is other and [owner.calls.value for owner,handle in resources]==[1,1]
        try:generator.send(None)
        except StopIteration as error:assert error.value is None
        else:raise AssertionError('missing exact return')
        assert events==['start',other,None] and [owner.calls.value for owner,handle in resources]==[1,2]
        assert generator.gi_frame is None
    finally:
        for owner,handle in resources:handle.close()


def retained_values(values,events):
    for value in values:
        sent=yield value
        events.append(sent)


def case_retained_iterator_and_sent_ownership():
    a=object();b=object();sent=object();events=[]
    pc=next(i.offset for i in dis.get_instructions(retained_values) if i.opname=='RESUME' and i.arg)
    owner=Keepalive(lower(build(retained_values),frame_entry=True,entry_offset=pc))
    handle=install_frame_entry(retained_values,owner.address,owner,seed_arguments=([a,b],events),entry_offset=pc)
    try:
        assert events==[]
        generator=retained_values([a,b],events)
        assert next(generator) is a and owner.calls.value==0
        assert generator.send(sent) is b and owner.calls.value==1 and events==[sent]
        try:generator.send(None)
        except StopIteration as error:assert error.value is None
        else:raise AssertionError('missing final iterator exhaustion')
        assert owner.calls.value==2 and events==[sent,None]
    finally:handle.close()


if __name__=='__main__':
    name=sys.argv[1];globals()['case_'+name]();print('PASS '+name,flush=True)
