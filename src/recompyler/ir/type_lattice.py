"""Finite exact-builtin/primitive lattice with scalar literal specializations.

Adapted from CinderX Jit/hir/type.h and website/docs/Jit/hir/type.md @ f3dc0e8.
MIT License

Copyright (c) Meta Platforms, Inc. and affiliates.

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
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

"""
from dataclasses import dataclass
from enum import IntFlag,auto
from types import FunctionType
import struct


class Atom(IntFlag):
    NONE=auto();BOOL=auto();INT=auto();FLOAT=auto();COMPLEX=auto()
    STR=auto();BYTES=auto();TUPLE=auto();LIST=auto();DICT=auto()
    SET=auto();FROZENSET=auto();SLICE=auto();RANGE=auto();FUNCTION=auto()
    OTHER_OBJECT=auto()
    NULL=auto();SIGNED64=auto();UNSIGNED64=auto();DOUBLE=auto();CBOOL=auto()


_BUILTINS=((type(None),Atom.NONE),(bool,Atom.BOOL),(int,Atom.INT),(float,Atom.FLOAT),
           (complex,Atom.COMPLEX),(str,Atom.STR),(bytes,Atom.BYTES),(tuple,Atom.TUPLE),
           (list,Atom.LIST),(dict,Atom.DICT),(set,Atom.SET),(frozenset,Atom.FROZENSET),
           (slice,Atom.SLICE),(range,Atom.RANGE),(FunctionType,Atom.FUNCTION))
_OBJECT_BITS=sum(int(a) for _,a in _BUILTINS)|int(Atom.OTHER_OBJECT)
_PRIMITIVE_BITS=int(Atom.NULL|Atom.SIGNED64|Atom.UNSIGNED64|Atom.DOUBLE|Atom.CBOOL)
_ALL_BITS=_OBJECT_BITS|_PRIMITIVE_BITS


@dataclass(frozen=True)
class TypeSet:
    bits:Atom
    literal:tuple[str,int|bool|bytes]|None=None
    def __post_init__(self):
        if type(self.bits) not in (Atom,int) or int(self.bits)<0 or int(self.bits)&~_ALL_BITS:
            raise ValueError('invalid type bits')
        object.__setattr__(self,'bits',Atom(self.bits))
        if self.literal is not None:
            p=self.literal
            if type(p) is not tuple or len(p)!=2 or type(p[0]) is not str:raise ValueError('invalid literal')
            tags={Atom.BOOL:('bool',bool),Atom.INT:('int',int),Atom.FLOAT:('double',bytes),Atom.COMPLEX:('complex',bytes),
                  Atom.SIGNED64:('signed',int),Atom.UNSIGNED64:('unsigned',int),Atom.DOUBLE:('double',bytes),Atom.CBOOL:('bool',bool)}
            tag,kind=tags.get(self.bits,(None,None))
            if tag!=p[0] or type(p[1]) is not kind:raise ValueError('literal does not match atom')
            if kind is bytes and len(p[1])!=(16 if self.bits==Atom.COMPLEX else 8):raise ValueError('invalid floating bits')
            if self.bits==Atom.SIGNED64 and not -2**63<=p[1]<2**63:raise ValueError('signed overflow')
            if self.bits==Atom.UNSIGNED64 and not 0<=p[1]<2**64:raise ValueError('unsigned overflow')

    def __or__(self,other):
        if not isinstance(other,TypeSet):return NotImplemented
        if not self.bits:return other
        if not other.bits:return self
        literal=self.literal if self.literal==other.literal and self.bits==other.bits else None
        return TypeSet(self.bits|other.bits,literal)

    def __and__(self,other):
        if not isinstance(other,TypeSet):return NotImplemented
        bits=self.bits&other.bits
        if not bits:return BOTTOM
        if self.literal is not None and other.literal is not None and self.literal!=other.literal:return BOTTOM
        return TypeSet(bits,self.literal if self.literal is not None else other.literal)

    def __sub__(self,other):
        if not isinstance(other,TypeSet):return NotImplemented
        if other.literal is None:
            bits=self.bits&~other.bits
            return TypeSet(bits,self.literal if bits else None)
        if self.literal is not None and self.bits==other.bits and self.literal==other.literal:return BOTTOM
        # Removing one member from a nonsingleton atom is not representable.
        return self

    def __le__(self,other):
        if not isinstance(other,TypeSet):return NotImplemented
        if not self.bits:return True
        return not (self.bits&~other.bits) and (other.literal is None or (self.bits==other.bits and self.literal==other.literal))

    def matches(self,value):
        actual=from_value(value)
        if not actual.bits&self.bits:return False
        if self.literal is None:return True
        return constant(value).literal==self.literal

    def materialize(self):
        """Decode scalar metadata; primitive representation stays in bits."""
        if self.bits==Atom.NONE:return None
        if self.literal is None:raise ValueError('not a scalar literal')
        tag,value=self.literal
        if tag=='double':return struct.unpack('>d',value)[0]
        if tag=='complex':return complex(*struct.unpack('>dd',value))
        return value


BOTTOM=TypeSet(Atom(0));OBJECT=TypeSet(Atom(_OBJECT_BITS))
PRIMITIVE=TypeSet(Atom(_PRIMITIVE_BITS));TOP=OBJECT|PRIMITIVE


def exact_builtin(cls):
    for builtin,atom in _BUILTINS:
        if cls is builtin:return TypeSet(atom)
    raise ValueError('unrepresented exact type; use conservative object classification')


def from_value(value):
    cls=type(value)
    for builtin,atom in _BUILTINS:
        if cls is builtin:return TypeSet(atom)
    # No metaclass hashing/equality, subclass hooks, or application roots.
    return TypeSet(Atom.OTHER_OBJECT)


def constant(value):
    cls=type(value)
    if value is None:return TypeSet(Atom.NONE)
    if cls is bool:return TypeSet(Atom.BOOL,('bool',value))
    if cls is int:return TypeSet(Atom.INT,('int',value))
    if cls is float:return TypeSet(Atom.FLOAT,('double',struct.pack('>d',value)))
    if cls is complex:return TypeSet(Atom.COMPLEX,('complex',struct.pack('>dd',value.real,value.imag)))
    raise ValueError('only exact numeric and None literals are supported')


def primitive_constant(atom,value):
    if type(atom) is not Atom:raise ValueError('primitive atom required')
    if atom in (Atom.SIGNED64,Atom.UNSIGNED64) and type(value) is int:
        return TypeSet(atom,('signed' if atom==Atom.SIGNED64 else 'unsigned',value))
    if atom==Atom.CBOOL and type(value) is bool:return TypeSet(atom,('bool',value))
    if atom==Atom.DOUBLE and type(value) is float:return TypeSet(atom,('double',struct.pack('>d',value)))
    raise ValueError('exact primitive scalar required')
