"""Canonical activation ABI tested through real native bodies, not AST admission."""
import dis
import sys
import weakref
import pytest


def source(action):
    local = action('make')
    action('capture')
    return None


@pytest.fixture(scope='module')
def execute():
    from recompyler import _source_frames as frames
    assert frames.available(), 'build the source-frame provider'
    from numba import njit
    from numba.core import types
    from recompyler import _managed_native as refs
    from recompyler._managed_entry import root_argument, as_managed
    from recompyler._managed_calls import capture_error
    from recompyler._managed_vector import call_vector
    from recompyler._structure_ops import keep_alive

    @njit(inline='never')
    def call_slot(frame, phase, errors, load_pc, call_pc):
        if not frames.mark(frame, load_pc):
            capture_error(errors)
            return errors, False
        callee, ok = frames.load(frame, 0)
        if not ok:
            capture_error(errors)
            return errors, False
        if not frames.mark(frame, call_pc):
            capture_error(errors)
            return errors, False
        value, ok = call_vector(callee, (phase,), None, 1)
        if not ok:
            capture_error(errors)
            return errors, False
        return value, True

    @njit(inline='never')
    def store_call(frame, phase, errors, load_pc, call_pc, store_pc):
        value, ok = call_slot(frame, phase, errors, load_pc, call_pc)
        if not ok:
            return False
        if not frames.mark(frame, store_pc) or not frames.store(frame, 1, value):
            capture_error(errors)
            return False
        keep_alive((value,))
        return True

    @njit(inline='never')
    def discard_call(frame, phase, errors, load_pc, call_pc, pop_pc):
        value, ok = call_slot(frame, phase, errors, load_pc, call_pc)
        if not ok:
            return False
        if not frames.mark(frame, pop_pc):
            capture_error(errors)
            return False
        keep_alive((value,))
        return True

    @njit
    def body(pool, action, errors, load1, call1, store_pc, load2, call2, pop_pc, ret, unhandled):
        function, ok = refs.pool_item(pool, 0)
        code, ok = refs.pool_item(pool, 1)
        first, ok = refs.pool_item(pool, 2)
        second, ok = refs.pool_item(pool, 3)
        none, ok = refs.pool_item(pool, 4)
        frame, ok = frames.enter(function, code, (action,), load1)
        if not ok:
            capture_error(errors)
            return errors, False
        if not store_call(frame, first, errors, load1, call1, store_pc):
            if not frames.leave(frame, errors, False, ret):capture_error(errors)
            return errors, False
        if unhandled:raise RuntimeError('unexpected native failure')
        if not discard_call(frame, second, errors, load2, call2, pop_pc):
            if not frames.leave(frame, errors, False, ret):capture_error(errors)
            return errors, False
        if not frames.leave(frame, errors, True, ret):
            capture_error(errors)
            return errors, False
        return none, True

    @njit
    def adapter(pool, action, errors, load1, call1, store_pc, load2, call2, pop_pc, ret, unhandled):
        return body(as_managed(pool), as_managed(action), as_managed(errors),
                    load1, call1, store_pc, load2, call2, pop_pc, ret, unhandled)

    signature = (root_argument,) * 3 + (types.intp,) * 7 + (types.boolean,)
    adapter.compile(signature)
    entry = adapter.overloads[signature].entry_point

    def run(fn, action, *, unhandled=False, bad_pc=None, expected_code=None):
        ins = list(dis.get_instructions(fn))
        phases = [i.argval for i in ins if i.opname == 'LOAD_CONST' and type(i.argval) is str]
        calls = [i.offset for i in ins if i.opname == 'CALL']
        loads = [i.offset for i in ins if i.opname.startswith('LOAD_FAST') and i.argval == 'action']
        store_pc = next(i.offset for i in ins if i.opname == 'STORE_FAST' and i.argval == 'local')
        pop_pc = next(i.offset for i in ins if i.opname == 'POP_TOP')
        pool = (fn, expected_code or fn.__code__, *phases, None)
        errors = [None]
        value, ok = frames.run_entry(entry, (pool, action, errors,
            loads[0] if bad_pc is None else bad_pc, calls[0], store_pc,
            loads[1], calls[1], pop_pc, ins[-1].offset, unhandled))
        if not ok:raise errors.pop()
        return value
    return run


def test_callback_sees_original_code_positions_and_live_locals(execute):
    seen = []
    def action(phase):
        frame = sys._getframe(1)
        assert frame.f_code is source.__code__
        assert frame.f_locals['action'] is action
        seen.append((phase, frame.f_lasti))
    assert execute(source, action) is None
    calls = [i.offset for i in dis.get_instructions(source) if i.opname == 'CALL']
    assert seen == [('make', calls[0]), ('capture', calls[1])]


@pytest.mark.parametrize('raises', [False, True])
def test_source_local_lives_until_error_or_success_traceback_is_released(execute, raises):
    events, state = [], {}
    error = ValueError('original')
    class Token:
        def __del__(self):events.append('drop')
    def action(phase):
        if phase == 'make':
            value = Token();state['ref'] = weakref.ref(value);return value
        if raises:raise error
        try:raise ValueError('saved')
        except ValueError as saved:state['error'] = saved
    if raises:
        with pytest.raises(ValueError) as caught:execute(source, action)
        assert caught.value is error
        del caught
        retained = error
    else:
        assert execute(source, action) is None
        retained = state.pop('error')
    assert state['ref']() is not None and events == []
    retained.__traceback__ = None
    assert state['ref']() is None and events == ['drop']


def test_callback_locals_rebind_changes_next_load(execute):
    logs = []
    for call in (source, lambda action: execute(source, action)):
        events = []
        def replacement(phase):events.append(('replacement', phase))
        def action(phase):
            events.append(('original', phase))
            if phase == 'make':sys._getframe(1).f_locals['action'] = replacement
        assert call(action) is None
        logs.append(events)
    assert logs == [[('original', 'make'), ('replacement', 'capture')]] * 2


def test_saved_frame_finishes_at_original_return(execute):
    saved = []
    def action(phase):
        if phase == 'capture':saved.append(sys._getframe(1))
    assert execute(source, action) is None
    assert saved[0].f_lasti == list(dis.get_instructions(source))[-1].offset


def test_discard_finalizer_sees_pop_top_before_frame_leaves(execute):
    seen = []
    class Token:
        def __del__(self):
            frame = sys._getframe(1);seen.append((frame.f_code, frame.f_lasti))
    def action(phase):
        if phase == 'capture':return Token()
    assert execute(source, action) is None
    pop = next(i.offset for i in dis.get_instructions(source) if i.opname == 'POP_TOP')
    assert seen == [(source.__code__, pop)]


def test_native_failure_unwinds_source_stack_before_next_entry(execute):
    refs, events = [], []
    class Token:
        def __del__(self):events.append('drop')
    def action(phase):
        assert phase == 'make'
        value = Token();refs.append(weakref.ref(value));return value
    with pytest.raises(RuntimeError, match='unexpected native failure') as caught:
        execute(source, action, unhandled=True)
    assert refs[0]() is not None and events == []
    caught.value.__traceback__ = None
    del caught
    assert refs[0]() is None and events == ['drop']
    assert execute(source, lambda phase: None) is None


@pytest.mark.parametrize('pc', [-2, 1, 10**6])
def test_invalid_instruction_refuses_before_callback_effects(execute, pc):
    events = []
    with pytest.raises(ValueError, match='instruction'):execute(source, events.append, bad_pc=pc)
    assert events == []


def test_changed_function_code_refuses_before_effects(execute):
    def other(action):return action('wrong')
    events = []
    with pytest.raises(TypeError, match='code changed'):
        execute(source, events.append, expected_code=other.__code__)
    assert events == []

@pytest.fixture(scope='module')
def slot_entry():
    from recompyler import _source_frames as frames, _managed_native as refs
    from recompyler._managed_entry import root_argument, as_managed
    from recompyler._managed_calls import capture_error
    from numba import njit
    from numba.core import types

    @njit
    def body(pool, argument, errors, pc, ret, index, mode):
        fn, ok = refs.pool_item(pool, 0)
        code, ok = refs.pool_item(pool, 1)
        frame, ok = frames.enter(fn, code, (argument,), pc)
        if not ok:
            capture_error(errors)
            return errors, False
        if mode == 1:
            ok = frames.store(frame, index, argument)
        elif mode == 2:
            ok = frames.delete(frame, index)
        if not ok:
            capture_error(errors)
            if not frames.leave(frame, errors, False, ret):capture_error(errors)
            return errors, False
        if mode == 3:
            value, ok = frames.cell(frame, index)
        elif mode == 4:
            value, ok = frames.pop(frame)
        elif mode == 5:
            ok = frames.push(frame, argument)
            if not ok:
                capture_error(errors)
                if not frames.leave(frame, errors, False, ret):capture_error(errors)
                return errors, False
            value, ok = frames.pop(frame)
        else:
            value, ok = frames.load(frame, index)
        if not ok:
            capture_error(errors)
            if not frames.leave(frame, errors, False, ret):capture_error(errors)
            return errors, False
        if not frames.leave(frame, errors, True, ret):
            capture_error(errors)
            return errors, False
        return value, True

    @njit
    def adapter(pool, argument, errors, pc, ret, index, mode):
        return body(as_managed(pool), as_managed(argument), as_managed(errors), pc, ret, index, mode)

    sig = (root_argument,) * 3 + (types.intp,) * 4
    adapter.compile(sig)
    entry = adapter.overloads[sig].entry_point
    def run(fn, argument, index, mode=0):
        ins = list(dis.get_instructions(fn))
        pc = next(i.offset for i in ins if i.opname == 'RESUME')
        errors = [None]
        result, ok = frames.run_entry(entry, ((fn, fn.__code__), argument, errors, pc, ins[-1].offset, index, mode))
        if not ok:raise errors.pop()
        return result
    return run


def make_reader(value):
    def reader(dummy):
        return value
    return reader


def cell_argument(arg):
    def child():
        return arg
    return child.__closure__[0]


def test_free_cell_load_store_and_escape_share_original_cell(slot_entry):
    first, second = [], []
    reader = make_reader(first)
    index = reader.__code__.co_nlocals
    assert slot_entry(reader, None, index) is first
    assert slot_entry(reader, second, index, 1) is second
    assert reader(None) is second
    assert slot_entry(reader, None, index, 3) is reader.__closure__[0]


def test_cell_argument_initialization_preserves_owner_and_cell_escape(slot_entry):
    marker = []
    actual = slot_entry(cell_argument, marker, 0, 3)
    assert type(actual) is type(cell_argument(marker))
    assert actual.cell_contents is marker


def test_deleted_live_free_cell_raises_exact_name_error(slot_entry):
    reader = make_reader([])
    index = reader.__code__.co_nlocals
    with pytest.raises(NameError) as caught:slot_entry(reader, None, index, 2)
    with pytest.raises(NameError) as expected:reader(None)
    assert type(caught.value) is type(expected.value)
    assert str(caught.value) == str(expected.value)
    assert caught.value.name == expected.value.name == 'value'
    assert reader.__closure__[0] is slot_entry(reader, None, index, 3)


def test_unbound_local_load_and_invalid_slot_are_checked(slot_entry):
    with pytest.raises(UnboundLocalError) as caught:slot_entry(source, None, 1)
    assert str(caught.value) == "cannot access local variable 'local' where it is not associated with a value"
    with pytest.raises(IndexError, match='source local index'):slot_entry(source, None, 9999)
    with pytest.raises(TypeError, match='not a cell'):slot_entry(source, None, 0, 3)


def test_operand_roundtrip_preserves_identity_and_checks_underflow(slot_entry):
    marker = []
    assert slot_entry(source, marker, 0, 5) is marker
    with pytest.raises(IndexError, match='operand stack empty'):slot_entry(source, None, 0, 4)


def test_profile_and_monitoring_guards_refuse_before_application_effects(execute):
    events = []
    previous = sys.getprofile()
    try:
        sys.setprofile(lambda *args: None)
        with pytest.raises(RuntimeError, match='unobserved interpreter'):
            execute(source, events.append)
    finally:
        sys.setprofile(previous)
    assert events == []
    monitoring = sys.monitoring
    tool = monitoring.PROFILER_ID
    if monitoring.get_tool(tool) is not None:pytest.skip('monitoring tool occupied')
    monitoring.use_tool_id(tool, 'source-frame-test')
    try:
        monitoring.set_local_events(tool, source.__code__, monitoring.events.LINE)
        with pytest.raises(RuntimeError, match='unobserved interpreter'):
            execute(source, events.append)
    finally:
        monitoring.set_local_events(tool, source.__code__, 0)
        monitoring.free_tool_id(tool)
    assert events == []


def test_reentrant_native_entries_restore_original_back_chain(execute):
    seen = []
    def inner(phase):
        frame = sys._getframe(1)
        assert frame.f_code is source.__code__
        assert any(f.f_code is source.__code__ for f in _back_chain(frame.f_back))
        seen.append(('inner', phase))
    def outer(phase):
        assert sys._getframe(1).f_code is source.__code__
        seen.append(('outer', phase))
        if phase == 'capture':execute(source, inner)
    assert execute(source, outer) is None
    assert seen == [('outer', 'make'), ('outer', 'capture'), ('inner', 'make'), ('inner', 'capture')]


def _back_chain(frame):
    while frame is not None:
        yield frame
        frame = frame.f_back


def test_entry_barrier_rejects_python_carriers_before_effects():
    from recompyler import _source_frames as frames
    events = []
    with pytest.raises(TypeError, match='native entry'):
        frames.run_entry(lambda: events.append('effect'), ())
    assert events == []
