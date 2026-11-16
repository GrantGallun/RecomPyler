"""Z3 is an independent oracle over every concrete 64-bit pair per domain."""
import pytest
import z3
from recompyler.ir.intbounds import IntBound, KnownBits


@pytest.mark.parametrize('operation',['add','sub','and','or','xor'])
@pytest.mark.parametrize('left,right',[
    (IntBound(),IntBound.from_knownbits(KnownBits(16,0xff0f,64))),
    (IntBound(-257,511),IntBound(-128,-1)),
    (IntBound((1<<63)-3,(1<<63)-1),IntBound(0,2)),
])
def test_all_concrete_64bit_pairs(operation,left,right):
    a,b=z3.BitVecs('a b',64)
    def member(value,bound):
        return z3.And(value>=bound.lower,value<=bound.upper,
                      value & z3.BitVecVal(~bound.bits.mask,64)==bound.bits.value)
    if operation=='add':expression=a+b
    elif operation=='sub':expression=a-b
    elif operation=='and':expression=a&b
    elif operation=='or':expression=a|b
    else:expression=a^b
    result=left.transfer(operation,right)
    solver=z3.Solver();solver.set(timeout=3000)
    solver.add(member(a,left),member(b,right),z3.Not(member(expression,result)))
    assert solver.check()==z3.unsat,solver

