"""Stable source arguments admit a guarded frameless body, including cold misses."""
import gc
import sys
import weakref
from types import FunctionType
import pytest


def read(owner): return owner.child.parent

def walk(owner):
    current = owner
    while current.parent is not None: current = current.parent
    return current

def rebind(owner):
    while owner.parent is not None: owner = owner.parent
    return owner

class Node: pass

def chain(depth):
    root = Node(); root.parent = None
    owner = root
    for _ in range(depth):
        item = Node(); item.parent = owner; owner = item
    return owner, root

def prepare(fn, **kwargs):
    from recompyler.ir.frameless import prepare_frameless
    result = prepare_frameless(fn, **kwargs)
    assert result is not None
    return result

@pytest.mark.parametrize('source', [read, walk])
def test_admitted_body_executes_original_function_with_counted_native_hits(source):
    fn = FunctionType(source.__code__.replace(), {})
    candidate = prepare(fn, counted=True)
    owner, root = chain(4)
    owner.child = owner
    expected = fn(owner)
    handle = candidate.install()
    try:
        assert handle.active and candidate.active
        assert fn(owner) is expected
        assert candidate.native_calls == 1
        assert 'PyObject_Vectorcall' not in str(candidate.owner.native_module)
    finally: candidate.close()
    assert not handle.active and fn(owner) is expected

@pytest.mark.parametrize('source', [rebind, lambda action: action()])
def test_argument_rebinding_and_callbacks_are_not_certified(source):
    from recompyler.ir.frameless import prepare_frameless
    assert prepare_frameless(source) is None

@pytest.mark.parametrize('bound', [False, True])
def test_temporary_argument_lifetime_and_weakref_order_match_cpython(bound):
    def observe(installed):
        events = []; references = []
        class Root:
            @property
            def parent(self):
                frame = sys._getframe(1)
                events.append(('read', frame.f_code is fn.__code__, isinstance(frame.f_locals['owner'], Leaf)))
                return None
        root = Root()
        class Leaf:
            search = fn
            def __init__(self):
                self.parent = root
                references.append(weakref.ref(self, lambda _: events.append('weakref')))
            def __del__(self): events.append('drop')
        candidate = prepare(fn, counted=True) if installed else None
        if candidate: candidate.install()
        try:
            result = Leaf().search() if bound else fn(Leaf())
            assert result is root and references[0]() is None
            events.append('returned')
            return events
        finally:
            if candidate: candidate.close()
    fn = FunctionType(walk.__code__.replace(), {})
    assert observe(False) == observe(True) == [('read', True, True), 'drop', 'weakref', 'returned']


def test_cold_descriptor_keeps_real_frame_and_original_locals_alive():
    held = []
    fn = FunctionType(read.__code__.replace(), {})
    class Child:
        @property
        def parent(self):
            frame = sys._getframe(1); held.append(frame)
            return frame.f_locals['owner']
    owner = Node(); owner.child = Child()
    candidate = prepare(fn, counted=True); candidate.install()
    try:
        assert fn(owner) is owner
        assert held[0].f_code is fn.__code__ and held[0].f_locals['owner'] is owner
        assert candidate.native_calls == 0
    finally: candidate.close(); held.clear()


def test_preparation_never_invokes_target_and_does_not_retain_source():
    fn = FunctionType(read.__code__.replace(), {})
    candidate = prepare(fn)
    references = weakref.ref(fn), weakref.ref(fn.__code__)
    del fn
    gc.collect(); gc.collect()
    assert all(ref() is None for ref in references)
    with pytest.raises(ValueError): candidate.install()

@pytest.mark.parametrize('mutation', ['code', 'defaults', 'kwdefaults'])
def test_mutation_restores_saved_slot(mutation):
    fn = FunctionType(read.__code__.replace(), {})
    candidate = prepare(fn, counted=True); handle = candidate.install()
    if mutation == 'code': fn.__code__ = (lambda owner: owner).__code__
    elif mutation == 'defaults': fn.__defaults__ = (None,)
    else: fn.__kwdefaults__ = {'unused': None}
    assert not handle.active and not candidate.active
    candidate.close()


def test_profile_registration_restores_original_source_events():
    fn = FunctionType(read.__code__.replace(), {})
    candidate = prepare(fn); handle = candidate.install(); seen = []
    owner = Node(); owner.child = Node(); owner.child.parent = None
    previous = sys.getprofile()
    try:
        sys.setprofile(lambda frame, event, arg: seen.append(event) if frame.f_code is fn.__code__ else None)
        assert fn(owner) is None and not handle.active
    finally: sys.setprofile(previous); candidate.close()
    assert seen == ['call', 'return']


def test_source_change_at_native_install_is_refused(monkeypatch):
    from recompyler.ir import _entry_native
    fn = FunctionType(read.__code__.replace(), {})
    candidate = prepare(fn)
    original = _entry_native._install_callback_free_entry
    def racing(*args):
        fn.__code__ = (lambda owner: owner).__code__
        return original(*args)
    monkeypatch.setattr(_entry_native, '_install_callback_free_entry', racing)
    with pytest.raises((ValueError, RuntimeError)): candidate.install()
    marker = object()
    assert fn(marker) is marker and not candidate.active


def test_fallback_can_close_candidate_after_machine_code_has_returned():
    fn = FunctionType(read.__code__.replace(), {})
    candidate = prepare(fn)
    owner_ref = weakref.ref(candidate.owner)
    class Child:
        @property
        def parent(self):
            candidate.close()
            gc.collect()
            return 42
    owner = Node(); owner.child = Child()
    candidate.install()
    assert fn(owner) == 42 and not candidate.active
    assert owner_ref() is candidate.owner


def test_call_binding_defaults_and_error_messages_match_original():
    fn = FunctionType(read.__code__.replace(), {})
    candidate = prepare(fn, counted=True); candidate.install()
    owner = Node(); owner.child = Node(); owner.child.parent = 42
    try:
        assert fn(owner=owner) == 42 and candidate.native_calls == 0
        for args, kwargs in [((), {}), ((owner, owner), {}), ((), {'unexpected': owner})]:
            stock = FunctionType(fn.__code__, {})
            with pytest.raises(TypeError) as expected: stock(*args, **kwargs)
            with pytest.raises(TypeError) as actual: fn(*args, **kwargs)
            assert str(actual.value) == str(expected.value)
    finally: candidate.close()


def test_public_compile_prepares_without_installing_then_measured_winner_uses_frameless():
    from recompyler.ir import compile_function, compilation_info
    from recompyler.ir.compiler import _record_measurement
    fn = FunctionType(read.__code__.replace(), {})
    compile_function(fn, strict=True)
    info = compilation_info(fn)
    assert info['frameless_eligible'] and not info['installed']
    assert info['deployment_abi'] == 'callback-free-vectorcall'
    assert info['deployment_body_address'] > 0
    _record_measurement(fn, 100, 101); compile_function(fn)
    assert not compilation_info(fn)['installed']
    _record_measurement(fn, 100, 100); compile_function(fn)
    assert not compilation_info(fn)['installed']
    # Synthetic policy inputs test selection only, never establish a speed claim.
    _record_measurement(fn, 100, 90); compile_function(fn)
    assert compilation_info(fn)['installed'] and compilation_info(fn)['abi'] == 'callback-free-vectorcall'
    owner = Node(); owner.child = Node(); owner.child.parent = 42
    assert fn(owner) == 42
    fn.__code__ = (lambda owner: owner).__code__
    assert compilation_info(fn) is None and fn(owner) is owner


def test_public_argument_rebinding_scope_keeps_frame_fallback():
    from recompyler.ir import compile_function, compilation_info
    fn = FunctionType(rebind.__code__.replace(), {})
    compile_function(fn, strict=True)
    assert not compilation_info(fn)['frameless_eligible']
    assert compilation_info(fn)['deployment_abi'] == 'frame'


@pytest.mark.parametrize('late', [False, True])
def test_certified_entry_preserves_monitor_call_events(late):
    fn = FunctionType(read.__code__.replace(), {})
    candidate = prepare(fn, counted=True)
    owner = Node(); owner.child = Node(); owner.child.parent = 42
    tool = 4; seen = []
    sys.monitoring.use_tool_id(tool, 'wave17-certified')
    def invoke(): return fn(owner)
    def callback(code, offset, callable, arg=None):
        if code is invoke.__code__ and callable is fn: seen.append('CALL')
    def returned(code, offset, callable, arg=None):
        if code is invoke.__code__ and callable is fn: seen.append('C_RETURN')
    try:
        if late: assert candidate.install().active
        sys.monitoring.register_callback(tool, sys.monitoring.events.CALL, callback)
        sys.monitoring.register_callback(tool, sys.monitoring.events.C_RETURN, returned)
        if not late: assert not candidate.install().active
        sys.monitoring.set_events(tool, sys.monitoring.events.CALL | sys.monitoring.events.C_RETURN | sys.monitoring.events.C_RAISE)
        assert invoke() == 42 and candidate.native_calls == 0
        assert seen == ['CALL'] and not candidate.active
    finally:
        sys.monitoring.set_events(tool, 0)
        for event in (sys.monitoring.events.CALL, sys.monitoring.events.C_RETURN):
            sys.monitoring.register_callback(tool, event, None)
        sys.monitoring.free_tool_id(tool); candidate.close()


def test_native_forget_retires_managed_vector_installation():
    from recompyler.ir import compile_function, compiler, _entry_native
    fn = FunctionType(read.__code__.replace(), {})
    compile_function(fn, strict=True)
    candidate = compiler._frameless_candidates[fn]
    assert candidate.install().active
    _entry_native.forget_compilation(fn)
    assert not candidate.active


def test_uncompiled_non_function_info_and_dead_source_identity_are_safe():
    from recompyler.ir import compilation_info
    assert compilation_info(None) is None
    fn = FunctionType(read.__code__.replace(), {})
    candidate = prepare(fn)
    assert candidate.source_matches(fn)
    del fn
    gc.collect()
    assert not candidate.source_matches(None)


def test_direct_cold_tailcall_releases_executable_owner_before_callback():
    fn = FunctionType(read.__code__.replace(), {})
    candidate = prepare(fn)
    # Fail before attempting retirement unless LLVM guarantees a tail transfer.
    assert 'musttail call' in str(candidate.owner.native_module)
    executable = weakref.ref(candidate.owner)
    box = [candidate]
    class Child:
        @property
        def parent(self):
            box.clear(); gc.collect()
            assert executable() is None
            return 42
    owner = Node(); owner.child = Child()
    candidate.install(); del candidate
    assert fn(owner) == 42
