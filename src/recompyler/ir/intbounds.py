"""Reduced interval/known-bit word domain; boxed Python ints never wrap.

Adapted from PyPy optimizeopt/intutils.py and ruleopt/proof.py (PyPy 8.0.1).
Copyright (c) the PyPy authors (see reference/pypy/LICENSE).
The MIT License
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
"""
from dataclasses import dataclass


def _limits(width):
    if type(width) is not int or not 2 <= width <= 64:
        raise ValueError('word width must be between 2 and 64')
    return -(1 << (width-1)), (1 << (width-1))-1


@dataclass(frozen=True)
class KnownBits:
    """PyPy tnum representation: value bits are one, mask bits are unknown."""
    value: int
    mask: int
    width: int = 64

    def __post_init__(self):
        _limits(self.width)
        full=(1 << self.width)-1
        if (type(self.value) is not int or type(self.mask) is not int
                or not 0<=self.value<=full or not 0<=self.mask<=full
                or self.value & self.mask):
            raise ValueError('invalid known bits')

    @classmethod
    def unknown(cls,width=64):
        return cls(0,(1 << width)-1,width)

    @classmethod
    def constant(cls,value,width=64):
        return cls(value & ((1 << width)-1),0,width)

    def contains(self,value):
        word=value & ((1 << self.width)-1)
        return word & ~self.mask == self.value

    def _check(self,other):
        if not isinstance(other,KnownBits) or self.width!=other.width:
            raise ValueError('word widths differ')

    def join(self,other):
        self._check(other)
        mask=self.mask | other.mask | (self.value ^ other.value)
        return KnownBits(self.value & ~mask,mask,self.width)

    def transfer(self,name,other):
        self._check(other)
        av,am,bv,bm=self.value,self.mask,other.value,other.mask
        full=(1 << self.width)-1
        if name=='and':
            value=av & bv; mask=((av|am)&(bv|bm)) & ~value
        elif name=='or':
            value=av|bv; mask=(am|bm)&~value
        elif name=='xor':
            mask=am|bm; value=(av^bv)&~mask
        elif name=='add':
            total=av+bv
            mask=((total+am+bm)^total)|am|bm
            value=total & ~mask
        elif name=='sub':
            difference=av-bv
            mask=((difference+am)^(difference-bm))|am|bm
            value=difference & ~mask
        elif name in ('lshift','rshift') and bm==0 and bv<self.width:
            if name=='lshift':
                value=av<<bv;mask=am<<bv
            else:
                value=av>>bv;mask=am>>bv
                fill=full ^ ((1 << (self.width-bv))-1)
                if am & (1 << (self.width-1)):mask |= fill
                elif av & (1 << (self.width-1)):value |= fill
        else:
            return KnownBits.unknown(self.width)
        return KnownBits(value&full,mask&full,self.width)

    def signed_bounds(self):
        sign=1 << (self.width-1)
        low=self.value
        high=self.value | self.mask
        if self.mask & sign:
            return low-sign, high-sign
        if self.value & sign:
            return low-2*sign, high-2*sign
        return low,high


@dataclass(frozen=True)
class IntBound:
    lower: int | None = None
    upper: int | None = None
    bits: KnownBits | None = None
    width: int = 64

    def __post_init__(self):
        minimum,maximum=_limits(self.width)
        low=minimum if self.lower is None else self.lower
        high=maximum if self.upper is None else self.upper
        if type(low) is not int or type(high) is not int or not minimum<=low<=high<=maximum:
            raise ValueError('invalid signed interval')
        bits=self.bits or KnownBits.unknown(self.width)
        if bits.width!=self.width:raise ValueError('word widths differ')
        # Each reduction is sound independently; iterate until stable.
        while True:
            old=(low,high,bits)
            a,b=bits.signed_bounds()
            low,high=max(low,a),min(high,b)
            if low>high:raise ValueError('empty reduced product')
            # A signed interval crossing zero has no common prefix.
            if low>=0 or high<0:
                full=(1 << self.width)-1
                ul,uh=low&full,high&full
                unknown=(1 << (ul^uh).bit_length())-1
                interval=KnownBits(ul&~unknown,unknown,self.width)
                if (bits.value ^ interval.value) & ~(bits.mask | interval.mask):
                    raise ValueError('inconsistent known bits')
                mask=bits.mask & interval.mask
                bits=KnownBits((bits.value | interval.value)&~mask,mask,self.width)
            if old==(low,high,bits):break
        object.__setattr__(self,'lower',low)
        object.__setattr__(self,'upper',high)
        object.__setattr__(self,'bits',bits)

    @classmethod
    def constant(cls,value,width=64):
        return cls(value,value,KnownBits.constant(value,width),width)

    @classmethod
    def from_knownbits(cls,bits):
        return cls(bits=bits,width=bits.width)

    def contains(self,value):
        return self.lower<=value<=self.upper and self.bits.contains(value)

    def _check(self,other):
        if not isinstance(other,IntBound) or self.width!=other.width:
            raise ValueError('word widths differ')

    def join(self,other):
        self._check(other)
        return IntBound(min(self.lower,other.lower),max(self.upper,other.upper),
                        self.bits.join(other.bits),self.width)

    def widen(self,other):
        self._check(other)
        minimum,maximum=_limits(self.width)
        return IntBound(minimum if other.lower<self.lower else self.lower,
                        maximum if other.upper>self.upper else self.upper,
                        KnownBits.unknown(self.width),self.width)

    def intersect(self,other):
        self._check(other)
        a,b=self.bits,other.bits
        if (a.value^b.value)&~(a.mask|b.mask):
            raise ValueError('empty known-bit intersection')
        mask=a.mask&b.mask
        bits=KnownBits((a.value|b.value)&~mask,mask,self.width)
        return IntBound(max(self.lower,other.lower),min(self.upper,other.upper),bits,self.width)

    def _arithmetic_range(self,name,other):
        a,b,c,d=self.lower,self.upper,other.lower,other.upper
        if name=='add':return a+c,b+d
        if name=='sub':return a-d,b-c
        if name=='mul':
            products=(a*c,a*d,b*c,b*d)
            return min(products),max(products)
        if name=='lshift':
            outputs=(a<<c,a<<d,b<<c,b<<d)
            return min(outputs),max(outputs)
        raise ValueError('not arithmetic')

    def cannot_overflow(self,name,other):
        self._check(other)
        if name=='lshift' and not 0<=other.lower<=other.upper<self.width:
            return False
        low,high=self._arithmetic_range(name,other)
        minimum,maximum=_limits(self.width)
        return minimum<=low<=high<=maximum

    def transfer(self,name,other):
        self._check(other)
        if name in ('lshift','rshift') and not 0<=other.lower<=other.upper<self.width:
            return IntBound(width=self.width)
        bits=self.bits.transfer(name,other.bits)
        if name=='rshift':
            outputs=(self.lower>>other.lower,self.lower>>other.upper,
                     self.upper>>other.lower,self.upper>>other.upper)
            return IntBound(min(outputs),max(outputs),bits,self.width)
        if name in ('add','sub','mul','lshift') and self.cannot_overflow(name,other):
            low,high=self._arithmetic_range(name,other)
            return IntBound(low,high,bits,self.width)
        if name not in ('add','sub','mul','and','or','xor','lshift'):
            raise ValueError('unknown transfer')
        return IntBound.from_knownbits(bits)



    def neg_bound(self):
        """Wrapping word negation; a Python-int consumer must exclude MININT."""
        return IntBound.constant(0,self.width).transfer('sub',self)

    def invert_bound(self):
        bits=self.bits.transfer('xor',KnownBits.constant(-1,self.width))
        return IntBound(-self.upper-1,-self.lower-1,bits,self.width)
