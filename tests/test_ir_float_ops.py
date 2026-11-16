"""Float unboxing uses the same boxed-boundary numeric_ops protocol."""
import math, random, struct, sys
import pytest
from test_ir_existing_frame import frame_entry

def add(left, right): return left + right

def subtract(left, right): return left - right

def multiply(left, right): return left * right

def bits(value): return struct.pack('!d', value)

def numeric_entry(source):
    from recompyler.ir.numeric_ops import FloatOps
    return frame_entry(source, lowering_options={'numeric_ops': FloatOps()})

@pytest.mark.parametrize('source', [add, subtract, multiply])
@pytest.mark.parametrize('left,right', [(0.0,-0.0),(-0.0,0.0),(-0.0,-0.0),(1.5,-2.25),
    (5e-324,-5e-324),(sys.float_info.max,2.0),(float('inf'),float('-inf')),
    (float('nan'),1.0),(1,2),(True,False),(1.0,2),(2,3.0),(1<<200,3)])
def test_numeric_types_and_exact_float_bits(source, left, right):
    entry,lowered,status=numeric_entry(source)
    expected=source(left,right); actual=entry(left,right)
    assert type(actual) is type(expected)
    assert bits(actual)==bits(expected) if type(expected) is float else actual==expected
    assert status.value==1


def test_finite_ieee_differential_includes_payload_nan_generic_path():
    rng=random.Random(94)
    for source in (add,subtract,multiply):
        entry,lowered,status=numeric_entry(source)
        values=[struct.unpack('!d', struct.pack('!Q',rng.getrandbits(64)))[0] for _ in range(300)]
        values += [struct.unpack('!d',struct.pack('!Q',word))[0] for word in
                   (0x7ff8000000000001,0xfff8000000004321,0x7ff0000000000011)]
        for left,right in zip(values,values[1:]):
            expected=source(left,right);actual=entry(left,right)
            assert type(actual) is float and bits(actual)==bits(expected)


def test_subclass_callbacks_keep_canonical_source_frame_and_pc():
    seen=[]
    class Value(float):
        def __add__(self, other):
            frame=sys._getframe(1)
            seen.append((frame.f_code,frame.f_locals['left'] is self,frame.f_lasti))
            return ('callback',other)
    value=Value(1.0)
    expected=add(value,2.0);reference=seen.pop()
    entry,lowered,status=numeric_entry(add)
    assert entry(value,2.0)==expected
    assert seen==[reference] and reference[0] is add.__code__


def test_overflowing_int_to_double_raises_at_original_operation_once():
    entry,lowered,status=numeric_entry(add)
    with pytest.raises(OverflowError) as expected:add(1<<20000,1.0)
    with pytest.raises(OverflowError) as actual:entry(1<<20000,1.0)
    assert str(actual.value)==str(expected.value)
    trace=actual.value.__traceback__
    while trace and trace.tb_frame.f_code is not add.__code__:trace=trace.tb_next
    assert trace is not None


def test_float_ir_is_strict_and_keeps_provider_alive():
    from recompyler.ir.numeric_ops import FloatOps
    from recompyler.ir import build
    from recompyler.ir.lower_llvm import lower
    ops=FloatOps();lowered=lower(build(add),frame_entry=True,numeric_ops=ops)
    assert ops in lowered.execution_owner.providers
    text=str(lowered.module)
    assert 'fadd double' in text and ' fast ' not in text and 'contract ' not in text


def test_finite_float_fast_lane_and_nonfinite_generic_lane_are_distinct():
    from llvmlite import ir
    from recompyler.ir.numeric_ops import FloatOps
    class SentinelMiss(FloatOps):
        def emit_binary(self, builder, oparg, left, right, generic):
            def sentinel():
                function=self.symbols.declare(builder.module,'PyLong_FromLongLong',left.type,[ir.IntType(64)])
                return builder.call(function,[ir.Constant(ir.IntType(64),999)])
            return super().emit_binary(builder,oparg,left,right,sentinel)
    entry=frame_entry(add,lowering_options={'numeric_ops':SentinelMiss()})[0]
    assert entry(1.5,2.5)==4.0
    assert type(entry(1.5,2.5)) is float
    assert entry(float('nan'),1.0)==999
    assert entry(float('inf'),1.0)==999


@pytest.mark.parametrize('provider', [False, True])
@pytest.mark.parametrize('rebind', [False, True])
def test_nonfinite_payload_uses_original_pc_without_replaying_prior_effects(provider,rebind,monkeypatch):
    from recompyler.ir.numeric_ops import FloatOps
    def target(left, right, events):
        events.append('before')
        value=left+right
        events.append('after')
        return value
    for _ in range(50):target(1.0,2.0,[])
    left=struct.unpack('!d',bytes.fromhex('7ff8000000000001'))[0]
    right=struct.unpack('!d',bytes.fromhex('fff8000000004321'))[0]
    expected=target(left,right,[])
    options={'numeric_ops':FloatOps()} if provider else {}
    import builtins
    class OtherFloat(float):pass
    with monkeypatch.context() as patch:
        if rebind:patch.setattr(builtins,'float',OtherFloat)
        entry,lowered,status=frame_entry(target,lowering_options=options)
    events=[];actual=entry(left,right,events)
    assert bits(actual)==bits(expected) and events==['before','after']


def test_numeric_guard_uses_canonical_type_when_builtin_is_rebound(monkeypatch):
    import builtins
    class FloatSubclass(float):
        def __add__(self,other):return 'subclass-dispatch'
    with monkeypatch.context() as patch:
        patch.setattr(builtins,'float',FloatSubclass)
        entry,lowered,status=numeric_entry(add)
    assert entry(FloatSubclass(1),FloatSubclass(2))=='subclass-dispatch'
    assert entry(1.0,2.0)==3.0
