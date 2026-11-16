"""S92 tests first: one numeric provider on stock and fork real frames.

Each test catches a numeric shortcut bypassing canonical type dispatch,
retirement, source-frame state or executable ownership.
"""
import ctypes
import gc
import sys
import weakref

import pytest
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from test_ir_existing_frame import frame_entry


def add(left, right): return left + right

def subtract(left, right): return left - right

def multiply(left, right): return left * right


def numeric_entry(function, **options):
    from recompyler.ir.numeric_ops import TaggedIntOps
    return frame_entry(function, lowering_options={'numeric_ops': TaggedIntOps()}, **options)[0]


@pytest.mark.parametrize('function,left,right,want', [
    (add, 0, 0, 0),
    (add, (1 << 61) - 1, 0, (1 << 61) - 1),
    (add, (1 << 61) - 1, 1, 1 << 61),
    (add, -(1 << 61), -1, -(1 << 61) - 1),
    (add, 1 << 200, -(1 << 200), 0),
    (subtract, -(1 << 61), 0, -(1 << 61)),
    (subtract, -(1 << 61), 1, -(1 << 61) - 1),
    (subtract, (1 << 61) - 1, -1, 1 << 61),
    (multiply, 0, -(1 << 61), 0),
    (multiply, -(1 << 61), -1, 1 << 61),
    (multiply, (1 << 31) - 1, (1 << 31) + 1, (1 << 62) - 1),
    (multiply, 1 << 100, -(1 << 100), -(1 << 200)),
])
def test_exact_int_boundaries_and_arbitrary_precision(function, left, right, want):
    result = numeric_entry(function)(left, right)
    assert type(result) is int and result == want


@pytest.mark.parametrize('function,left,right,want', [
    (add, True, True, 2), (subtract, True, False, 1),
    (multiply, True, False, 0), (add, 1.5, 2, 3.5),
    (multiply, 2j, 3, 6j), (add, 'a', 'b', 'ab'),
])
def test_nonexact_int_uses_original_operation(function, left, right, want):
    result = numeric_entry(function)(left, right)
    assert type(result) is type(want) and result == want


def test_int_subclass_reflected_dispatch_and_effects_are_not_replayed():
    effects = []
    class Right(int):
        def __radd__(self, other):
            effects.append(('radd', other, int(self)))
            return 'reflected'
    def target(left, right):
        effects.append('before')
        return left + right
    entry = numeric_entry(target)
    assert entry(3, Right(4)) == 'reflected'
    assert effects == ['before', ('radd', 3, 4)]
    effects.clear()
    assert entry((1 << 61) - 1, 1) == 1 << 61
    assert effects == ['before']


def test_custom_error_has_original_code_pc_and_live_locals():
    class Broken:
        def __add__(self, right):
            frame = sys._getframe(1)
            assert frame.f_code is target.__code__
            assert frame.f_locals['left'] is self
            raise ValueError('numeric sentinel')
    def target(left, right):
        result = left + right
        return result
    entry = numeric_entry(target)
    with pytest.raises(ValueError, match='numeric sentinel') as caught:
        entry(Broken(), 7)
    traceback = caught.value.__traceback__
    sites = []
    while traceback:
        if traceback.tb_frame.f_code is target.__code__:
            sites.append(traceback.tb_lineno)
        traceback = traceback.tb_next
    assert sites == [target.__code__.co_firstlineno + 1]


def test_boxed_values_are_visible_before_observer_callback():
    observations = []
    def observe():
        frame = sys._getframe(1)
        observations.append((frame.f_code is target.__code__,
                             dict(frame.f_locals)))
    def target(left, right):
        result = left * right
        observe()
        return result
    entry = numeric_entry(target)
    assert entry(123456, 654321) == 80779853376
    same_code, locals_ = observations.pop()
    assert same_code and type(locals_['result']) is int
    assert locals_['result'] == 80779853376


def test_canonical_store_retirement_keeps_finalizer_and_weakref_order():
    events = []
    refs = []
    class Operand:
        def __add__(self, right):
            events.append('add')
            return 42
        def __del__(self): events.append('dead')
    def make():
        value = Operand()
        refs.append(weakref.ref(value, lambda _: events.append('weak')))
        return value
    def target():
        value = make()
        value = value + 1
        events.append('stored')
        return value
    entry = numeric_entry(target)
    assert target() == 42
    expected = events[:]
    events.clear()
    assert entry() == 42 and events == expected
    assert expected == ['add', 'dead', 'weak', 'stored']
    assert all(ref() is None for ref in refs)


def test_execution_owner_pins_numeric_provider_until_machine_code_dies():
    from recompyler.ir.numeric_ops import TaggedIntOps
    ops = TaggedIntOps()
    reference = weakref.ref(ops)
    lowered = lower(build(add), frame_entry=True, numeric_ops=ops)
    owner = lowered.execution_owner
    assert ops in owner.providers
    del ops, lowered
    gc.collect()
    assert reference() is not None
    assert owner.engine.get_function_address('body') == owner.body_address
    del owner
    gc.collect()
    assert reference() is None


def test_execution_owner_does_not_retain_source_function_or_globals():
    import types
    from recompyler.ir.numeric_ops import TaggedIntOps
    class Marker: pass
    marker = Marker()
    function = types.FunctionType(add.__code__, {'marker': marker})
    source_ref, marker_ref = weakref.ref(function), weakref.ref(marker)
    lowered = lower(build(function), frame_entry=True, numeric_ops=TaggedIntOps())
    owner = lowered.execution_owner
    del lowered, function, marker
    gc.collect()
    assert source_ref() is None and marker_ref() is None
    assert owner.engine.get_function_address('body') == owner.body_address


def test_disabled_numeric_provider_keeps_current_real_frame_behavior():
    entry = frame_entry(add)[0]
    assert entry(17, 25) == 42
    assert type(entry(True, True)) is int


def test_pending_callback_runs_without_tagged_frame_slots():
    seen = []
    callback_type = ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_void_p)
    @callback_type
    def pending(_):
        seen.append('pending')
        return 0
    entry = numeric_entry(add, pending_callback=pending)
    assert entry(17, 25) == 42 and seen == ['pending']


@pytest.mark.skipif(not getattr(ctypes.pythonapi, 'PyUnstable_RPCode_SetNative', None)
                    or sys._jit.is_enabled(), reason='fork native ABI with JIT off')
def test_yield_send_throw_close_materialize_exact_values():
    from recompyler.ir.fork_entry import install_function, stats
    from recompyler.ir.numeric_ops import TaggedIntOps
    events = []
    def producer(left, right):
        try:
            value = left * right
            extra = yield value
            yield value + extra
        finally:
            events.append('closed')
    handle = install_function(producer, numeric_ops=TaggedIntOps(), count=True)
    try:
        gen = producer(123456, 654321)
        assert next(gen) == 80779853376
        assert type(gen.gi_frame.f_locals['value']) is int
        assert gen.send(1) == 80779853377
        with pytest.raises(ValueError, match='throw sentinel'):
            gen.throw(ValueError('throw sentinel'))
        assert events == ['closed']
        gen = producer(2, 3)
        assert next(gen) == 6
        gen.close()
        assert events == ['closed', 'closed']
        assert stats(handle)['calls'] > 0
    finally:
        handle.close()


def test_readonly_early_finish_pins_numeric_provider_too():
    from recompyler import heap, _structure_ops_native
    from recompyler.ir.numeric_ops import TaggedIntOps
    from recompyler.ir.structure_lowerings import StructureCalls
    from recompyler.ir.symbols import CPythonSymbols
    ops = TaggedIntOps()
    calls = StructureCalls(CPythonSymbols(), _structure_ops_native)
    lowered = lower(build(heap._find), readonly_loops=True,
                    structure_calls=calls, numeric_ops=ops)
    assert ops in lowered.execution_owner.providers


def test_signed62_fast_path_and_out_of_range_miss_are_distinct():
    # A sentinel generic branch distinguishes real unboxing from a provider
    # that silently routes every value through PyNumber_Add.
    from llvmlite import ir
    from recompyler.ir.numeric_ops import TaggedIntOps
    class SentinelMiss(TaggedIntOps):
        def emit_binary(self, builder, oparg, left, right, generic):
            def sentinel():
                function = self.symbols.declare(builder.module, 'PyLong_FromLongLong',
                                                left.type, [ir.IntType(64)])
                return builder.call(function, [ir.Constant(ir.IntType(64), 999)])
            return super().emit_binary(builder, oparg, left, right, sentinel)
    for source, left, right, want in (
        (add, (1 << 61) - 2, 1, (1 << 61) - 1),
        (subtract, -(1 << 61) + 1, 1, -(1 << 61)),
        (multiply, -(1 << 30), 1 << 30, -(1 << 60)),
        (multiply, -(1 << 61), 0, 0),
    ):
        entry = frame_entry(source, lowering_options={'numeric_ops': SentinelMiss()})[0]
        assert entry(left, right) == want
        assert entry(1 << 200, 1) == 999
        assert entry(True, 1) == 999
    entry = frame_entry(add, lowering_options={'numeric_ops': SentinelMiss()})[0]
    assert entry((1 << 61) - 1, 1) == 999
    entry = frame_entry(multiply, lowering_options={'numeric_ops': SentinelMiss()})[0]
    assert entry(1 << 40, 1 << 40) == 999


def test_inplace_dispatch_never_uses_numeric_binary_provider():
    from recompyler.ir.numeric_ops import TaggedIntOps
    class NoBinary(TaggedIntOps):
        def emit_binary(self, *args):
            raise AssertionError('inplace operation reached numeric provider')
    effects = []
    class Inplace:
        def __iadd__(self, other):
            effects.append(other)
            return self
    def target(value):
        value += 1
        return value
    entry = frame_entry(target, lowering_options={'numeric_ops': NoBinary()})[0]
    value = Inplace()
    assert entry(value) is value and effects == [1]


@pytest.mark.parametrize('provider', [object(), type('NoKeepalive', (), {'emit_binary': lambda *args: None})(),
    type('NoEmit', (), {'keepalive': ()})()])
def test_malformed_provider_is_rejected_before_codegen(provider):
    with pytest.raises(TypeError, match='numeric_ops'):
        lower(build(add), numeric_ops=provider)
