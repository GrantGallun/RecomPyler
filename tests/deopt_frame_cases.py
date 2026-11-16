import ctypes
import sys
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
from test_ir_deopt_runtime import compile_frame_deopt


def normal_source(action):
    saved=action('before')
    action('after')
    return saved


def protected_source(action):
    saved=action('before')
    try:
        action('guard')
    except LookupError:
        action('handled')
    return saved


def normal():
    events=[];marker=object()
    def action(phase):events.append(phase);return marker
    handle,owner=compile_frame_deopt(normal_source)
    try:
        assert normal_source(action) is marker
        assert events==['before','after'] and owner.calls.value==1
    finally:handle.close()


def pending():
    events=[];marker=object()
    def action(phase):
        events.append(phase)
        if phase=='guard':raise LookupError('native callback')
        return marker
    handle,owner=compile_frame_deopt(protected_source,pending=True)
    try:
        assert protected_source(action) is marker
        assert events==['before','guard','handled'] and owner.calls.value==1
    finally:handle.close()


def pending_uncaught():
    import dis
    events=[]
    def action(phase):
        events.append(phase)
        if phase=='after':raise LookupError('native callback')
        return object()
    handle,owner=compile_frame_deopt(normal_source,pending=True)
    try:
        try:normal_source(action)
        except LookupError as error:
            trace=error.__traceback__
            while trace and trace.tb_frame.f_code is not normal_source.__code__:trace=trace.tb_next
            assert trace is not None
            expected=[op.offset for op in dis.get_instructions(normal_source) if op.opname=='CALL'][1]
            assert trace.tb_lasti==expected,(trace.tb_lasti,expected)
        else:raise AssertionError('missing error')
        assert events==['before','after'] and owner.calls.value==1
    finally:handle.close()



def generator_source(action):
    saved=action('before')
    yield saved
    action('after')


def pending_generator_source(action):
    saved=action('before')
    try:
        action('guard')
    except LookupError:
        yield saved
        action('after')


def generator_normal():
    events=[];marker=object()
    def action(phase):events.append(phase);return marker
    handle,owner=compile_frame_deopt(generator_source)
    try:
        gen=generator_source(action)
        assert events==[] and owner.calls.value==0
        assert next(gen) is marker and events==['before'] and owner.calls.value==1
        try:gen.send(None)
        except StopIteration:pass
        else:raise AssertionError('generator did not return')
        assert events==['before','after'] and owner.calls.value==1
    finally:handle.close()


def generator_pending():
    events=[];marker=object();error=LookupError('native pending')
    def action(phase):
        events.append(phase)
        if phase=='guard':raise error
        if phase=='after':assert sys.exception() is error
        return marker
    handle,owner=compile_frame_deopt(pending_generator_source,pending=True)
    try:
        gen=pending_generator_source(action)
        assert next(gen) is marker
        assert events==['before','guard'] and owner.calls.value==1
        assert sys.exception() is None
        try:gen.send(None)
        except StopIteration:pass
        else:raise AssertionError('generator did not return')
        assert events==['before','guard','after'] and sys.exception() is None
        error.__traceback__=None
    finally:handle.close()

if __name__=='__main__':
    case=sys.argv[1];globals()[case]();print('PASS '+case)
