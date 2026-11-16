"""Conservative simplification proof queries; no automatic graph rewrites.

Adapted from CinderX Jit/hir/simplify.cpp @ f3dc0e8.
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
from enum import Enum
from .type_lattice import BOTTOM,Atom,TypeSet


class GuardDecision(Enum):
    PASS='pass';FAIL='fail';UNKNOWN='unknown';UNREACHABLE='unreachable'


def type_guard(known,required):
    if not isinstance(known,TypeSet) or not isinstance(required,TypeSet):raise ValueError('type sets required')
    if known==BOTTOM:return GuardDecision.UNREACHABLE
    if known<=required:return GuardDecision.PASS
    if known&required==BOTTOM:return GuardDecision.FAIL
    return GuardDecision.UNKNOWN


def constant_truth(known):
    if not isinstance(known,TypeSet):raise ValueError('type set required')
    if known.bits==Atom.NONE:return False
    if known.literal is None:return None
    return bool(known.materialize())


def normalize_tuple_index(length,index):
    """Caller proves exact tuple length and exact int; errors stay at source."""
    if type(length) is not int or length<0 or type(index) is not int:
        raise ValueError('nonnegative exact length and exact integer index required')
    if index<0:index+=length
    return index if 0<=index<length else None
