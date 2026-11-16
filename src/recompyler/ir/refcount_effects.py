"""Adapted from CinderX Jit/hir/refcount_insertion.cpp and instr_effects.h @ f3dc0e8.
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
from .deopt import RefKind


@dataclass(frozen=True)
class Output:
    kind: RefKind
    # Strings identify mutable memory regions; integers identify owned SSA roots.
    support: frozenset = frozenset()

    def __post_init__(self):
        if not isinstance(self.kind,RefKind) or type(self.support) is not frozenset:
            raise ValueError('explicit reference kind and immutable support required')
        if self.kind is not RefKind.BORROWED and self.support:
            raise ValueError('only borrowed values have support')
        if any(type(item) not in (str,int) for item in self.support):
            raise ValueError('support must name memory or an SSA owner')


@dataclass(frozen=True)
class Effects:
    outputs: tuple[Output,...] = ()
    steal: tuple[int,...] = ()
    retire: tuple[int,...] = ()
    may_store: frozenset[str] = frozenset()
    arbitrary: bool = False

    def __post_init__(self):
        if any(type(value) is not tuple for value in (self.outputs,self.steal,self.retire)):
            raise ValueError('effect operands must be immutable')
        if type(self.may_store) is not frozenset or any(type(item) is not str for item in self.may_store):
            raise ValueError('memory effects must name immutable memory regions')
        if not all(isinstance(output,Output) for output in self.outputs):
            raise ValueError('invalid output effect')
