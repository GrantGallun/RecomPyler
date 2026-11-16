"""Small-word exhaustive oracles for the word domain, including overflow."""
from itertools import product
import pytest
from recompyler.ir.intbounds import IntBound, KnownBits


def concrete(bound):
    return [n for n in range(-(1 << (bound.width-1)), 1 << (bound.width-1))
            if bound.contains(n)]


def test_exhaustive_transfers():
    bounds = [IntBound(a,b,width=3) for a in range(-4,4) for b in range(a,4)]
    for a,b in product(bounds,repeat=2):
        for name,f in [('add',lambda x,y:x+y),('sub',lambda x,y:x-y),
                       ('mul',lambda x,y:x*y),('and',lambda x,y:x&y),
                       ('or',lambda x,y:x|y),('xor',lambda x,y:x^y)]:
            result=a.transfer(name,b)
            outputs=[f(x,y) for x,y in product(concrete(a),concrete(b))]
            if name in ('add','sub','mul'):
                assert a.cannot_overflow(name,b)==all(-4<=n<=3 for n in outputs)
                outputs=[((n+4)%8)-4 for n in outputs]
            assert all(result.contains(n) for n in outputs),(a,b,name,result,outputs)


def test_exhaustive_known_bits_and_joins():
    patterns=[KnownBits(v,m,4) for v in range(16) for m in range(16) if not v&m]
    for a,b in product(patterns,repeat=2):
        av=[n for n in range(16) if a.contains(n)]
        bv=[n for n in range(16) if b.contains(n)]
        assert all(a.join(b).contains(n) for n in av+bv)
        for name,f in [('and',lambda x,y:x&y),('or',lambda x,y:x|y),
                       ('xor',lambda x,y:x^y),('add',lambda x,y:(x+y)&15),
                       ('sub',lambda x,y:(x-y)&15)]:
            result=a.transfer(name,b)
            assert all(result.contains(f(x,y)) for x,y in product(av,bv))


def test_reduced_product_and_widening():
    masked=IntBound.from_knownbits(KnownBits(0,7,8))
    assert (masked.lower,masked.upper)==(0,7)
    assert IntBound(-8,-1,width=8).bits.value&128
    old=IntBound(0,1,width=8)
    assert old.widen(IntBound(0,2,width=8)).upper==127
    assert old.join(IntBound(-2,0,width=8)).contains(-2)
    with pytest.raises(ValueError):KnownBits(1,1,8)
    with pytest.raises(ValueError):IntBound(-129,0,width=8)
    with pytest.raises(ValueError):old.join(IntBound(0,1,width=16))


def test_overflow_is_not_a_python_result_proof():
    top=IntBound(width=64)
    one=IntBound.constant(1)
    assert not top.cannot_overflow('add',one)
    assert IntBound(0,100).cannot_overflow('mul',IntBound(0,100))
    assert not IntBound.constant(-(1<<63)).cannot_overflow('sub',one)


def test_exhaustive_shift_and_unary_transfers():
    bounds=[IntBound(a,b,width=4) for a in range(-8,8) for b in range(a,8)]
    for a in bounds:
        assert all(a.invert_bound().contains(~x) for x in concrete(a))
        assert all(a.neg_bound().contains(((-x+8)%16)-8) for x in concrete(a))
        for low in range(4):
            for high in range(low,4):
                b=IntBound(low,high,width=4)
                for name,f in [('lshift',lambda x,y:x<<y),('rshift',lambda x,y:x>>y)]:
                    result=a.transfer(name,b)
                    outputs=[f(x,y) for x,y in product(concrete(a),concrete(b))]
                    if name=='lshift':
                        assert a.cannot_overflow(name,b)==all(-8<=n<=7 for n in outputs)
                        outputs=[((n+8)%16)-8 for n in outputs]
                    assert all(result.contains(n) for n in outputs)
    assert not IntBound(1,2,width=4).cannot_overflow('lshift',IntBound(-1,1,width=4))

