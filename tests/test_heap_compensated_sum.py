"""CPython 3.14 compensated float sums keep exact bits and result types."""
import math
import random
import struct
from recompyler import heap


def total(values):
    return sum(x for x in values)


def started(values,start):
    return sum((x for x in values),start)


def spectral(n):
    u=[1.0]*n
    for _ in range(6):
        u=[sum(x/(((i+j)*(i+j+1)//2)+i+1) for j,x in enumerate(u)) for i in range(n)]
    return u


def identical(actual,expected):
    assert type(actual) is type(expected)
    if type(expected) is float:assert struct.pack('>d',actual)==struct.pack('>d',expected)
    elif type(expected) is list:
        assert len(actual)==len(expected)
        for a,b in zip(actual,expected):identical(a,b)
    else:assert actual==expected


def test_finite_cancellation_uses_native_compensated_sum():
    region=heap.lift_region(total)
    for values in ([1e16,1.0,-1e16],[1e100,1.0,2.0,-1e100],[0.1]*11,[-0.0],[1.0,-1.0]):
        before=region.compiled_calls
        identical(region(values),total(values))
        assert region.compiled_calls==before+1,region.problem


def test_float_sum_prefix_and_empty_result_types_are_exact():
    region=heap.lift_region(started)
    for start in (0,1,-1,0.0,-0.0,1e16):
        for values in ([],[1.0,1e16,-1e16],[1e16,1.0,-1e16],[-0.0,-0.0]):
            identical(region(values,start),started(values,start))
    assert region.compiled_calls>0,region.problem
    # bool starts follow CPython's generic addition loop, not float compensation.
    identical(region([1e16,1.0,-1e16],True),started([1e16,1.0,-1e16],True))


def test_compensated_float_sum_differential_and_nonfinite_fallback():
    region=heap.lift_region(total);rng=random.Random(104)
    cases=[[math.inf],[-math.inf,math.inf],[math.nan],[1e308,1e308,-1e308]]
    for _ in range(400):
        values=[math.ldexp(rng.uniform(-1.0,1.0),rng.randint(-900,900)) for _ in range(rng.randint(1,35))]
        if rng.randrange(2):values += [-x for x in reversed(values)]
        cases.append(values)
    for values in cases:identical(region(values),total(values))
    assert region.compiled_calls>0,region.problem


def test_existing_spectral_shape_executes_natively_with_exact_digest():
    region=heap.lift_region(spectral)
    identical(region(12),spectral(12))
    assert region.compiled_calls==1,region.problem


def test_rebound_sum_is_not_lowered_as_canonical_builtin(monkeypatch):
    import builtins
    from types import GeneratorType
    canonical=builtins.sum
    def replacement(values,start=0):
        if type(values) is GeneratorType and values.gi_code.co_filename==total.__code__.co_filename:
            return 999
        return canonical(values,start)
    with monkeypatch.context() as patch:
        patch.setattr(builtins,'sum',replacement)
        region=heap.lift_region(total)
        actual=region([1,2,3])
    assert actual==999
