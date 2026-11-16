"""Lift a function and everything it calls into one compiled region with its own heap.

``lift_region(fn)`` compiles ``fn`` together with the functions, methods and
constructors it reaches. Inside the region every object lives in one preallocated
array of 8-byte slots, seen both as float64 (``F``) and as int64 (``I``):

* an object is the index of its first slot (its handle), and attribute k is a fixed
  offset from it;
* ``None`` is -1, and ``is`` compares handles;
* a list is an object too: length, capacity and the handle of its items.

Because a handle is a plain integer, Numba cannot tell objects apart, so this module
does its own type inference over the Python source: one type per variable, attribute
and list, widened until nothing changes. The types then drive code generation.

Results are exact or the call is handed back to Python. Where Python would raise
(an attribute of None, an index out of range, a division by zero, an int too large
for 64 bits), compiled code sets a flag and returns at once, and the original
function runs from the untouched arguments. Objects passed in are copied into the
heap before the call; afterwards the attributes and lists the region may have
changed are written back, and objects it made are turned into Python objects.

A number that may be an int at one time and a float at another (``total = 0`` then
``total += x``) is held as a float plus a flag that says whether Python would hold
an int, so its type on the way out is right.
"""

import array
import ast
import builtins
import copy
import functools
import hashlib
import importlib.util
import inspect
import itertools
import math
from pathlib import Path
import random
import re
import struct
import sys
import textwrap
import types as pytypes
from types import FunctionType, MethodType

from . import facts as _facts
from . import escape as _escape
from . import scalar as _scalar
from . import flow as _flow
from .lift import (INT_MAX, INT_MIN, MATH, MATH_CONSTANTS, TRANSCENDENTAL, Unsupported, _check_flow, _init_fields,
                   _cache_dir, _local_names, _math_agrees, _record_problem, _runtime_key, _start_numba, _unwrap,
                   _target_names, _write_once)

try:
    from . import _heap as _native
except ImportError:
    _native = None

# Ints up to this size are exact as floats.
EXACT = 2 ** 53
MAX_SIGNATURES = 8
MAX_SPECIALIZATIONS = 6
START_SLOTS = 1 << 16
# Copy objects with the C loader when it is built; tests turn it off to check both.
NATIVE = True
MAX_SLOTS = 1 << 27
# Compiled recursion stops here at the latest; deeper calls go back to Python.
MAX_DEPTH = 3000

INT, FLOAT, BOOL, NONE, MIXED, BOTTOM = "i", "f", "b", "n", "m", "?"
NUMBERS = (INT, FLOAT, BOOL, MIXED)
# numpy scalars: np.float64, np.int64 and np.bool_, as read from arrays. Each is held
# as the Python number it equals; a "q" kind may be either the Python or the numpy
# type, with a flag (a second value) that says numpy. Arithmetic is the same on both
# as long as it stays exact (anything else hands the call back), so the types only
# matter for what reaches Python.
NPF, NPI, NPB, NPFQ, NPIQ, NPBQ = "F", "I", "B", "Fq", "Iq", "Bq"
_NP_BASE = {NPF: FLOAT, NPI: INT, NPB: BOOL, NPFQ: FLOAT, NPIQ: INT, NPBQ: BOOL}
_NP_DEFINITE = {FLOAT: NPF, INT: NPI, BOOL: NPB}
_NP_MAYBE = {FLOAT: NPFQ, INT: NPIQ, BOOL: NPBQ}


class OptT:
    """A number of type ``base``, or None: its codes and a flag that it is there."""

    def __init__(self, base):
        self.base = base

    def __eq__(self, other):
        return isinstance(other, OptT) and other.base == self.base

    __hash__ = None


class _Cell:
    """The item type shared by every expression that may hold one list."""

    def __init__(self):
        self.parent, self.elem, self.mutated = None, BOTTOM, False


def _find(cell):
    while cell.parent is not None:
        cell = cell.parent
    return cell


class ListT:
    def __init__(self, cell=None):
        self.cell = cell or _Cell()

    def __eq__(self, other):
        return isinstance(other, ListT) and _find(self.cell) is _find(other.cell)

    __hash__ = None

    @property
    def elem(self):
        return _find(self.cell).elem


def _root(cls):
    """The top of ``cls``'s family: its highest base class other than ``object``.
    Classes of one family share a layout, so one variable can hold any of them."""
    return [klass for klass in cls.__mro__ if klass is not object][-1]


class ArrT(ListT):
    """An array.array('B'): a list of ints from 0 to 255."""

    def __init__(self, cell=None):
        super().__init__(cell)
        if cell is None:
            self.cell.elem = INT


class ObjT:
    """An object of one family (``cls``, the root), of one of ``classes``."""

    def __init__(self, cls, nullable=False, classes=None):
        self.cls = _root(cls)
        self.classes = frozenset(classes) if classes is not None else frozenset((cls,))
        self.nullable = nullable

    def __eq__(self, other):
        return isinstance(other, ObjT) and other.nullable == self.nullable and other.classes == self.classes

    __hash__ = None


class TupT:
    """A tuple: its items' values, and with ``nullable`` a flag that it is not None.
    In the heap a tuple is a block of its items, referred to by handle."""

    def __init__(self, items, nullable=False):
        self.items = tuple(items)
        self.nullable = nullable

    def __eq__(self, other):
        return isinstance(other, TupT) and len(other.items) == len(self.items) and all(
            a == b for a, b in zip(self.items, other.items)) and other.nullable == self.nullable

    __hash__ = None


class NdT:
    """A numpy array of one dtype ("float64", "int64" or "bool") and number of
    dimensions: the handle of a block [address, shape..., strides in elements...,
    handle of the loaded array] (recompyler._nd). ``writable`` mirrors its flag."""

    nullable = False

    def __init__(self, dtype, ndim, writable=True):
        self.dtype, self.ndim, self.writable = dtype, ndim, writable

    def __eq__(self, other):
        return isinstance(other, NdT) and (other.dtype, other.ndim, other.writable) == (
            self.dtype, self.ndim, self.writable)

    __hash__ = None


class StrT:
    """A str, and with ``nullable`` maybe None. In the heap a string is an immutable
    block ``[length, hash, code points...]`` referred to by handle; None is -1. The
    hash is the region's own (0 until worked out), never Python's."""

    def __init__(self, nullable=False):
        self.nullable = nullable

    def __eq__(self, other):
        return isinstance(other, StrT) and other.nullable == self.nullable

    __hash__ = None


def _np_flag(kind, codes):
    """The code of the flag that a number of ``kind`` is a numpy scalar."""
    if kind in (NPF, NPI, NPB):
        return "True"
    if kind in (NPFQ, NPIQ, NPBQ):
        return codes[1]
    return "False"


def _is_np(kind):
    return isinstance(kind, str) and kind in _NP_BASE


def _is_ndarray(value):
    """True for a numpy array, without importing numpy."""
    kind = type(value)
    return kind.__name__ == "ndarray" and kind.__module__ == "numpy"


class RngT:
    """A random.Random generator: the handle of its block of state in the heap
    (recompyler._rng). Its methods run compiled; nothing else may be done with it."""

    nullable = False

    def __eq__(self, other):
        return isinstance(other, RngT)

    __hash__ = None

class DictT:
    """A dict: the key and value types shared by every expression that may hold it
    (like a list's item type), and with ``nullable`` maybe None. In the heap a header
    ``[len, entries used, capacity, entries, table size, table, stride, -1]`` and
    entries ``[hash, key, alive, value slots...]`` in insertion order, as CPython
    keeps them. A key takes one slot: an int or bool itself, a str, tuple or object
    by handle. The hash table is built on first lookup (table size 0 until then)."""

    def __init__(self, kcell=None, vcell=None, nullable=False):
        self.kcell, self.vcell, self.nullable = kcell or _Cell(), vcell or _Cell(), nullable

    def __eq__(self, other):
        return (isinstance(other, DictT) and _find(self.kcell) is _find(other.kcell)
                and _find(self.vcell) is _find(other.vcell) and other.nullable == self.nullable)

    __hash__ = None

    @property
    def key(self):
        return _find(self.kcell).elem

    @property
    def value(self):
        return _find(self.vcell).elem


class SetT:
    """A set: its item type, shared like a list's, and with ``nullable`` maybe None.
    In the heap a dict without values whose header slot 7 is a log of the adds and
    discards that changed it, so the Python set it becomes is made by the same
    operations, in the same order, and has Python's own iteration order. A set loaded
    from Python can be iterated in the region until it changes; header slot 8 is 1 for
    a set made in the region."""

    def __init__(self, cell=None, nullable=False):
        self.cell, self.nullable = cell or _Cell(), nullable

    def __eq__(self, other):
        return isinstance(other, SetT) and _find(self.cell) is _find(other.cell) and other.nullable == self.nullable

    __hash__ = None

    @property
    def elem(self):
        return _find(self.cell).elem


# Kinds held by handle that may be None (-1), besides objects.
_HANDLES = (StrT, DictT, SetT)


def _same(a, b):
    return a == b if type(a) is type(b) else False


def _object_problem(cls):
    """Why instances of ``cls`` cannot be objects in a region's heap, or None. Unlike
    a record, an object may define its own truth or length: truth tests and len()
    call those methods in compiled code."""
    problem = _record_problem(cls)
    if problem is None or not problem.endswith("defines its own truth or length"):
        return problem
    from .lift import _ATTRIBUTE_HOOKS

    for klass in cls.__mro__[:-1]:
        if klass.__module__ == "builtins":
            return f"'{cls.__name__}' subclasses a built-in type"
        if any(hook in vars(klass) for hook in _ATTRIBUTE_HOOKS):
            return f"'{cls.__name__}' customises attribute access"
    return None


def _describe(kind, seen=None):
    if isinstance(kind, str):
        return {INT: "int", FLOAT: "float", BOOL: "bool", NONE: "None", MIXED: "int-or-float", BOTTOM: "nothing",
                NPF: "np.float64", NPI: "np.int64", NPB: "np.bool_", NPFQ: "float-or-np.float64",
                NPIQ: "int-or-np.int64", NPBQ: "bool-or-np.bool_"}[kind]
    if isinstance(kind, NdT):
        return f"ndarray[{kind.dtype}, {kind.ndim}d{'' if kind.writable else ', read-only'}]"
    if isinstance(kind, OptT):
        return _describe(kind.base) + "-or-None"
    if isinstance(kind, ObjT):
        return "|".join(sorted(cls.__name__ for cls in kind.classes)) + ("-or-None" if kind.nullable else "")
    if isinstance(kind, TupT):
        return "(" + ", ".join(_describe(item, seen) for item in kind.items) + ")" + ("-or-None" if kind.nullable else "")
    if isinstance(kind, ArrT):
        return "array('B')"
    if isinstance(kind, RngT):
        return "random.Random"
    if isinstance(kind, _HANDLES):
        return _describe_handle(kind, seen) + ("-or-None" if kind.nullable else "")
    seen = seen or set()
    cell = _find(kind.cell)
    if id(cell) in seen:
        return "list[...]"
    return f"list[{_describe(cell.elem, seen | {id(cell)})}]"


def _describe_handle(kind, seen):
    if isinstance(kind, StrT):
        return "str"
    seen = seen or set()
    cells = [kind.kcell, kind.vcell] if isinstance(kind, DictT) else [kind.cell]
    roots = [_find(cell) for cell in cells]
    if any(id(root) in seen for root in roots):
        return "dict[...]" if isinstance(kind, DictT) else "set[...]"
    inner = seen | {id(root) for root in roots}
    parts = ", ".join(_describe(root.elem, inner) for root in roots)
    return f"dict[{parts}]" if isinstance(kind, DictT) else f"set[{parts}]"


def _width(kind):
    """Machine values that hold a value of ``kind`` in generated code."""
    if kind == MIXED or kind in (NPFQ, NPIQ, NPBQ):
        return 2
    if isinstance(kind, OptT):
        return _width(kind.base) + 1
    if isinstance(kind, TupT):
        return sum(map(_width, kind.items)) + kind.nullable
    return 1


def _slots(kind):
    """Heap slots that hold a value of ``kind``; a tuple is a handle to its block."""
    if isinstance(kind, OptT):
        return _slots(kind.base) + 1
    return 2 if kind == MIXED or kind in (NPFQ, NPIQ, NPBQ) else 1


def _dummy(kind):
    """Values of the right machine types for a result that will be thrown away."""
    if kind in (FLOAT, NPF):
        return ["0.0"]
    if kind in (BOOL, NPB):
        return ["False"]
    if kind in (MIXED, NPFQ):
        return ["0.0", "False"]
    if kind == NPIQ:
        return ["0", "False"]
    if kind == NPBQ:
        return ["False", "False"]
    if isinstance(kind, OptT):
        return _dummy(kind.base) + ["False"]
    if kind in (INT, BOTTOM, NPI):
        return ["0"]
    if isinstance(kind, TupT):
        return [code for item in kind.items for code in _dummy(item)] + (["False"] if kind.nullable else [])
    return ["-1"]


def _zero_parts(kind, codes, path=()):
    """Numeric tuple leaves, with paths independent of their machine widths."""
    if isinstance(kind, TupT) and not kind.nullable:
        at = 0
        for index, item in enumerate(kind.items):
            width = _width(item)
            yield from _zero_parts(item, codes[at:at + width], path + (index,))
            at += width
    elif kind in (INT, FLOAT, MIXED):
        yield path, kind, (kind, *codes)


_LITERAL = re.compile(r"True|False|-?\d+(\.\d+)?")


def _literal_truth(code):
    """The truth of a test made only of True, False, numbers, not, and, or; else None."""
    try:
        tree = ast.parse(code, mode="eval")
    except SyntaxError:
        return None
    if not all(isinstance(item, (ast.Expression, ast.Constant, ast.UnaryOp, ast.Not, ast.BoolOp, ast.And, ast.Or))
               for item in ast.walk(tree)):
        return None
    return bool(eval(compile(tree, "<test>", "eval"), {"__builtins__": {}}))


def _is_literal_int(code):
    return code.lstrip("-").isdigit()


def _terminates(statements):
    """True if control cannot run off the end of ``statements``."""
    if not statements:
        return False
    last = statements[-1]
    if isinstance(last, (ast.Return, ast.Raise)):
        return True
    if isinstance(last, ast.If):
        return _terminates(last.body) and _terminates(last.orelse)
    if isinstance(last, ast.Try) and not last.handlers:
        return _terminates(last.body) or _terminates(last.finalbody)
    if isinstance(last, ast.While):
        endless = isinstance(last.test, ast.Constant) and bool(last.test.value)
        return endless and not any(isinstance(item, ast.Break) for item in ast.walk(last))
    return False


class _Function:
    """One Python function in the region, and the types of its variables."""

    def __init__(self, program, fn, owner=None):
        self.fn, self.owner = fn, owner
        code = fn.__code__
        # A coroutine function (async def) is allowed: awaited at once inside the
        # region, a call of one that never suspends is just a call.
        self.coroutine = bool(code.co_flags & 0x80)
        # A generator (or async generator) is compiled into the loops that consume it
        # (_inline_generator), or as a function that collects what it yields (sink).
        self.generator, self.sink = bool(code.co_flags & _GENERATOR_FLAGS), False
        if code.co_flags & 0x08:
            raise Unsupported(f"'{fn.__qualname__}' takes **kwargs")
        try:
            # The code object names the actual body without following __wrapped__.
            tree = ast.parse(textwrap.dedent(inspect.getsource(code)))
        except (OSError, TypeError, SyntaxError) as exc:
            raise Unsupported(f"no source for '{fn.__qualname__}'") from exc
        node = tree.body[0]
        expected = ast.AsyncFunctionDef if self.coroutine or code.co_flags & 0x200 else ast.FunctionDef
        if not isinstance(node, expected) or node.decorator_list or node.name != fn.__name__:
            raise Unsupported(f"'{fn.__qualname__}' is decorated or not a plain def")
        self.node = node
        self.params = _signature_names(fn)
        own = _rename_comprehensions(node, fn) | _rename_generator_exps(node, fn)
        if self.generator:
            own |= _check_generator(node, fn)
        # Generator expressions are scoped as list comprehensions are.
        flow = _flow_view(node)
        self.locals = _local_names(flow) | set(self.params) | own
        for item in ast.walk(node):
            if isinstance(item, (ast.Global, ast.Nonlocal, ast.Lambda, ast.FunctionDef, ast.ClassDef,
                                 ast.AsyncFunctionDef)) and item is not node:
                raise Unsupported(f"'{fn.__qualname__}' declares globals or defines functions inside itself")
            if isinstance(item, ast.AsyncWith) or (isinstance(item, (ast.Yield, ast.YieldFrom)) and not self.generator):
                raise Unsupported(f"'{fn.__qualname__}' uses async with, or yield outside a generator")
        # Locals that may be read unbound are held with a flag that they are bound
        # (u_name), checked at those reads only: Python raises there, so the call
        # goes back to Python. A function may return None on some paths.
        flow = _flow.analyse(node, self.params, self.locals)
        self.unbound, self.flagged = flow.unbound, flow.names
        for read in flow.nodes:
            if id(read) in flow.unbound:
                read._rc_unbound = True
        self.falls_through = not _terminates(node.body) and flow.falls_through
        self.vars, self.ret = {}, BOTTOM
        # The codes every return gives, when they are all the same constant.
        self.constant = None
        self.name = f"f{len(program.functions)}_{fn.__name__}"
        self.recursive = False
        self.source = ""

    def make_sink(self):
        """Compile this generator as a function that appends what it yields to a list
        passed as its last argument."""
        if not self.generator:
            raise Unsupported(f"'{self.fn.__qualname__}' is not a generator")
        self.sink = True
        self.params = self.params + [_OUT]
        self.locals = self.locals | {_OUT}


def _object_leaf_codes(kind, codes):
    if isinstance(kind, ObjT):
        return codes[:1]
    if isinstance(kind, (TupT, OptT)):
        if isinstance(kind, OptT):return _object_leaf_codes(kind.base, codes[:-1])
        result, at = [], 0
        for item in kind.items:
            width = _width(item)
            result += _object_leaf_codes(item, codes[at:at+width])
            at += width
        return result
    return []


class _Program:
    """A region compiled for one set of argument types."""

    def __init__(self, entry, numeric_policy=None):
        self.entry_fn = entry
        # Explicit experimental policies are immutable and local to this program.
        # Ordinary regions never select one from a machine/type signature.
        self.numeric_policy = numeric_policy
        self.functions, self.order, self.changed = {}, [], False
        # Int-or-float as plain floats (floats_unseen), and whether any arithmetic is.
        self.fast_mixed = self.saw_mixed = False
        self.mixed_kind_used = False
        self.zero_vars, self.zero_returns = {}, {}
        self.zero_collect = self.zero_optimized = False
        # Class -> {attribute: type}, in slot order; and the attributes code assigns
        # outside the constructor, which have to be written back.
        self.fields, self.written = {}, set()
        # Per concrete class, the attributes its __init__ sets; per family root, its
        # classes in tag order. Objects a region reads from module globals sit in
        # fixed heap slots 0, 1, ... as (namespace, name, type).
        self.class_fields, self.members = {}, {}
        # Family root -> the root it was merged into.
        self.alias = {}
        self.global_objects, self.global_index = [], {}
        self.guards, self.calls = {}, {}
        self.broken = False
        self.entry = self.function(entry, sink=bool(entry.__code__.co_flags & _GENERATOR_FLAGS))

    @property
    def facts(self):
        # Analysis metadata is cold. Keep it on the entry analysis record,
        # preserving the execution-program instance layout on the warm path.
        answer = self.entry.__dict__.get('_facts')
        if answer is None:
            answer = self.entry._facts = _facts.Facts()
        return answer

    def guard(self, *parts):
        """Something the compiled code assumes, checked before every call."""
        self.guards[tuple(part if isinstance(part, str) else id(part) for part in parts)] = parts

    # Types

    def join(self, a, b):
        if a == BOTTOM:
            return b
        if b == BOTTOM:
            return a
        if isinstance(a, str) and isinstance(b, str):
            if a == b:
                return a
            if {a, b} <= {INT, FLOAT, MIXED}:
                return MIXED
            if NONE in (a, b) and {a, b} - {NONE} <= set(NUMBERS):
                return OptT(b if a == NONE else a)
            if (a in _NP_BASE or b in _NP_BASE) and _NP_BASE.get(a, a) == _NP_BASE.get(b, b):
                # A Python number and a numpy scalar of the same kind.
                return _NP_MAYBE[_NP_BASE.get(a, a)]
        elif isinstance(a, OptT) or isinstance(b, OptT):
            if NONE in (a, b):
                return a if b == NONE else b
            base = self.join(a.base if isinstance(a, OptT) else a, b.base if isinstance(b, OptT) else b)
            if base in NUMBERS:
                return OptT(base)
        elif isinstance(a, TupT) or isinstance(b, TupT):
            if a == NONE:
                return TupT(b.items, True)
            if b == NONE:
                return TupT(a.items, True)
            if isinstance(a, TupT) and isinstance(b, TupT) and len(a.items) == len(b.items):
                return TupT((self.join(x, y) for x, y in zip(a.items, b.items)), a.nullable or b.nullable)
        elif isinstance(a, ObjT) or isinstance(b, ObjT):
            if a == NONE:
                return ObjT(b.cls, True, b.classes)
            if b == NONE:
                return ObjT(a.cls, True, a.classes)
            if isinstance(a, ObjT) and isinstance(b, ObjT):
                # Unrelated classes that meet in one value share a family from now on.
                self.merge(a.cls, b.cls)
                return ObjT(a.cls, a.nullable or b.nullable, a.classes | b.classes)
        elif isinstance(a, ListT) and isinstance(b, ListT) and type(a) is type(b):
            self.unify(a.cell, b.cell)
            return a
        elif isinstance(a, RngT) and isinstance(b, RngT):
            return a
        elif isinstance(a, NdT) and a == b:
            return a
        elif isinstance(a, _HANDLES) or isinstance(b, _HANDLES):
            joined = self.join_handles(a, b)
            if joined is not None:
                return joined
        raise Unsupported(f"one value can be {_describe(a)} or {_describe(b)}")

    def join_handles(self, a, b):
        """The join of a str, dict or set with None or one of its own kind, or None."""
        if a == NONE or b == NONE:
            kind = b if a == NONE else a
            if isinstance(kind, StrT):
                return StrT(True)
            if isinstance(kind, DictT):
                return DictT(kind.kcell, kind.vcell, True)
            return SetT(kind.cell, True)
        if type(a) is not type(b):
            return None
        nullable = a.nullable or b.nullable
        if isinstance(a, StrT):
            return StrT(nullable)
        if isinstance(a, DictT):
            self.unify(a.kcell, b.kcell)
            self.unify(a.vcell, b.vcell)
            return DictT(a.kcell, a.vcell, nullable)
        self.unify(a.cell, b.cell)
        return SetT(a.cell, nullable)

    def unify(self, first, second):
        first, second = _find(first), _find(second)
        if first is second:
            return
        # Every pass makes new cells for the lists it creates; joining one that adds
        # nothing is not a change.
        second.parent = first
        joined = self.join(first.elem, second.elem)
        if not _same(joined, first.elem) or (second.mutated and not first.mutated):
            self.changed = True
        first.elem, first.mutated = joined, first.mutated or second.mutated

    def widen_cell(self, cell, kind):
        cell = _find(cell)
        joined = self.join(cell.elem, kind)
        if not _same(joined, cell.elem):
            cell.elem, self.changed = joined, True
            if joined == MIXED or isinstance(joined, OptT):
                raise Unsupported("a list holds both ints and floats, or floats and None")

    def widen(self, store, key, kind):
        old = store.get(key, BOTTOM)
        joined = self.join(old, kind)
        if key not in store or not _same(joined, old):
            store[key], self.changed = joined, True
        return joined

    # Classes

    def register(self, cls):
        """Note a concrete class; returns its family's attribute types."""
        root = self.family(cls)
        if cls in self.class_fields:
            return self.fields[root]
        problem = _object_problem(cls)
        if problem:
            raise Unsupported(problem)
        self.guard("lifetime", cls)
        init = getattr(cls, "__init__")
        if init is object.__init__:
            names = []
        else:
            if not isinstance(init, FunctionType):
                raise Unsupported(f"'{cls.__name__}.__init__' is not a plain function")
            names = sorted(_init_assigned(cls, init))
            self.facts.known("F2", ("constructor-only", cls, init), not _ESCAPES.get((cls, init), False),
                             "constructor publishes the object; lifetime escape is separate")
            self.guard("attr", cls, "__init__", init)
        self.class_fields[cls] = frozenset(names)
        family = self.fields.setdefault(root, {})
        for name in names:
            family.setdefault(name, BOTTOM)
        members = self.members.setdefault(root, [])
        members.append(cls)
        # A new class may add attributes or the type tag: generate the code again.
        self.changed = True
        return family

    def canon(self, root):
        """The family ``root`` now belongs to, after merges."""
        while root in self.alias:
            root = self.alias[root]
        return root

    def family(self, cls):
        return self.canon(_root(cls))

    def merge(self, first, second):
        first, second = self.family(first), self.family(second)
        if first is second:
            return first
        fields = self.fields.setdefault(first, {})
        for name, kind in self.fields.pop(second, {}).items():
            fields[name] = self.join(fields.get(name, BOTTOM), kind)
        self.members.setdefault(first, []).extend(self.members.pop(second, []))
        self.alias[second] = first
        self.changed = True
        return first

    def written_set(self):
        """(family, attribute) pairs written outside constructors, after merges."""
        return {(self.canon(root), name) for root, name in self.written}

    def polymorphic(self, root):
        return len(self.members.get(self.family(root), ())) > 1

    def tag(self, cls):
        return self.members[self.family(cls)].index(cls)

    def layout(self, cls):
        """({attribute: slot offset}, slots) for the current attribute types of the
        family of ``cls``. A family of several classes keeps the class's tag in slot 0."""
        root = self.family(cls)
        offsets, at = {}, 1 if self.polymorphic(root) else 0
        for name, kind in self.fields[root].items():
            offsets[name] = at
            at += _slots(kind)
        return offsets, max(at, 1)

    def global_value(self, namespace, name, value, key=None):
        """The type and code of a module global (or class attribute) that holds an
        object or list."""
        key = key or (id(namespace), name)
        slot = self.global_index.get(key)
        if slot is None:
            kind = _seed(self, value, {})
            slot = self.global_index[key] = len(self.global_objects)
            self.global_objects.append((namespace, name, kind))
            self.guard("item", namespace, name, value)
        return self.global_objects[slot][2], [f"I[{slot}]"]

    def constant_blocks(self):
        """(slots, {global slot: handle}, [(handle, length, code points)]) for the str
        constants, laid out just after the global slots; worked out once."""
        cached = self.__dict__.get("_constant_blocks")
        if cached is None:
            import numpy as np

            holder = self.__dict__.get("str_constants")
            start = at = len(self.global_objects)
            slots, blocks = {}, []
            for slot, (namespace, name, _) in enumerate(self.global_objects):
                if holder is not None and namespace is holder:
                    points = np.frombuffer(name.encode("utf-32-le", "surrogatepass"), dtype=np.uint32).astype(np.int64)
                    slots[slot] = at
                    blocks.append((at, len(name), points))
                    at += 2 + len(name)
            cached = self._constant_blocks = (at - start, slots, blocks)
        return cached

    def constant_strings(self):
        size, slots, _ = self.constant_blocks()
        return [(self.global_objects[slot][1], handle) for slot, handle in slots.items()]

    def load_plan(self, cls):
        """(attribute names, slots, [(name, offset, type, is float)]) for loading
        objects of ``cls``; worked out once, since types are fixed after compiling."""
        plans = self.__dict__.setdefault("_load_plans", {})
        plan = plans.get(cls)
        if plan is None:
            root = self.family(cls)
            fields, names = self.fields[root], self.class_fields[cls]
            offsets, size = self.layout(cls)
            tag = self.tag(cls) if self.polymorphic(root) else -1
            plan = plans[cls] = (names, size, [(name, offsets[name], kind, isinstance(kind, str) and kind == FLOAT)
                                               for name, kind in fields.items() if name in names], tag)
        return plan

    # Types for the C loader (_heap.c): small ints for numbers and None, lists for
    # objects and lists, which may refer to themselves.

    def c_kind(self, kind, item=False):
        if isinstance(kind, OptT):
            raise _NoNative
        if isinstance(kind, str):
            if _is_np(kind):
                raise _NoNative
            if item and kind == MIXED:
                return 9
            return _C_CODES.get(kind, 9)
        if isinstance(kind, (TupT, ArrT, RngT, NdT) + _HANDLES):
            raise _NoNative
        cache = self.__dict__.setdefault("_c_kinds", {})
        if isinstance(kind, ObjT):
            key = self.family(kind.cls), kind.nullable, kind.classes
            made = cache.get(key)
            if made is None:
                made = cache[key] = [10, {}, kind.nullable]
                made[1].update((cls, self.c_plan(cls)) for cls in kind.classes)
            return made
        root = _find(kind.cell)
        made = cache.get(id(root))
        if made is None:
            made = cache[id(root)] = [11, 9, kind, root]
            made[1] = self.c_kind(root.elem, item=True)
        return made

    def c_ok(self, kind):
        """True if the C loader handles every type reachable from ``kind``."""
        cache = self.__dict__.setdefault("_c_ok_cache", {})
        hit = cache.get(id(kind))
        if hit is None or hit[0] is not kind:
            hit = cache[id(kind)] = kind, self._c_ok(kind, set())
        return hit[1]

    def _c_ok(self, kind, seen):
        if isinstance(kind, str):
            return kind not in _NP_BASE
        if isinstance(kind, (TupT, ArrT, OptT, RngT, NdT) + _HANDLES):
            return False
        if isinstance(kind, ListT):
            root = _find(kind.cell)
            if id(root) in seen:
                return True
            seen.add(id(root))
            return self._c_ok(root.elem, seen)
        for cls in kind.classes:
            if cls in seen:
                continue
            seen.add(cls)
            fields = self.fields[self.family(cls)]
            if not all(self._c_ok(fields[name], seen) for name in self.class_fields[cls]):
                return False
        return True

    def c_plan(self, cls):
        plans = self.__dict__.setdefault("_c_plans", {})
        plan = plans.get(cls)
        if plan is None:
            root = self.family(cls)
            names = [name for name in self.fields[root] if name in self.class_fields[cls]]
            offsets, size = self.layout(cls)
            tag = self.tag(cls) if self.polymorphic(root) else -1
            plan = plans[cls] = [size, tuple(names), tuple(offsets[name] for name in names), [], tag]
            plan[3].extend(self.c_kind(self.fields[root][name]) for name in names)
        return plan

    def c_write_plans(self):
        """{class: ((name, offset, code, type), ...)} for the attributes code writes."""
        plans = self.__dict__.get("_c_write_plans")
        if plans is None:
            plans, done = {}, self.written_set()
            for root, fields in self.fields.items():
                offsets = self.layout(root)[0]
                for cls in self.members.get(root, ()):
                    for name, kind in fields.items():
                        if (root, name) in done and not (isinstance(kind, (str, ObjT)) or type(kind) is ListT):
                            raise _NoNative
                        if (root, name) in done and _is_np(kind):
                            raise _NoNative
                    written = tuple((name, offsets[name], _C_CODES.get(kind, 20) if isinstance(kind, str) else 20, kind)
                                    for name, kind in fields.items()
                                    if (root, name) in done and name in self.class_fields[cls])
                    if written:
                        plans[cls] = written
            self._c_write_plans = plans
        return plans

    def method(self, cls, name):
        for klass in cls.__mro__[:-1]:
            if name in vars(klass):
                found = vars(klass)[name]
                if not isinstance(found, FunctionType):
                    raise Unsupported(f"'{cls.__name__}.{name}' is not a plain method")
                self.guard("attr", cls, name, found)
                return self.function(_unwrap(found), cls)
        raise Unsupported(f"'{cls.__name__}' has no method '{name}'")

    def function(self, fn, owner=None, key=None, sink=False):
        """The copy of ``fn`` compiled for argument types ``key`` (None: the shared
        copy). It is generated only once a call uses it. ``sink``: a generator's
        collecting form (_Function.make_sink)."""
        slot = (fn, key, "sink") if sink else (fn, key)
        info = self.functions.get(slot)
        if info is None:
            info = self.functions[slot] = _Function(self, fn, owner)
            if sink:
                info.make_sink()
            self.guard("code", fn, fn.__code__)
        return info

    def specialize(self, info, args):
        """The copy of ``info``'s function for these argument types. Objects are told
        apart by their possible classes and numbers by type, so a method called on a
        Vector is compiled without the code its Point callers need. A function gets at
        most MAX_SPECIALIZATIONS copies a pass; further calls share one."""
        parts = []
        for kind, _ in args:
            if isinstance(kind, ObjT):
                parts.append(("o", tuple(sorted(cls.__qualname__ + "@" + cls.__module__ for cls in kind.classes)),
                              kind.nullable))
            elif kind in NUMBERS:
                parts.append(kind)
            elif isinstance(kind, TupT):
                # Tuples of different lengths can never share a copy.
                parts.append(("t", len(kind.items)))
            else:
                parts.append("*")
        key = tuple(parts)
        seen = self.specialized.setdefault((info.fn, info.sink) if info.sink else info.fn, [])
        if key not in seen:
            if len(seen) >= MAX_SPECIALIZATIONS:
                key = None
            else:
                seen.append(key)
        return self.function(info.fn, info.owner, key, info.sink)

    # Compiling

    def compile(self, ahead_of_time=None):
        """Generate the region's code and compile it. With ``ahead_of_time`` (a map
        from source digest to an exported function of a built module), code that
        hashes to a built entry is used from the module and Numba is not loaded."""
        self.facts.answers.clear()
        self.fast_mixed = self.saw_mixed = False
        self.mixed_kind_used = False
        self.zero_vars, self.zero_returns = {}, {}
        self.zero_collect = self.zero_optimized = False
        self.settle()
        if self.saw_mixed and self.floats_unseen():
            # Generate again with int-or-float arithmetic as plain floats; the types
            # stay as they are.
            self.fast_mixed = True
            self.settle()
        self.prove_zero_int_results()
        self.escape_analysis = _escape.EscapeAnalysis([
            _escape.FunctionIR(info.name, info.source,
                tuple(code for name in info.params
                      for code in _object_leaf_codes(info.vars.get(name, BOTTOM), _Gen(self, info).var_codes(name, info.vars.get(name, BOTTOM)))),
                getattr(info, 'object_allocations', {}), isinstance(info.ret, ObjT), info.fn.__name__ == '__init__')
            for info in self.order])
        for info in self.order:
            self.facts.query('F2', ('lifetime-summary', info.name),
                lambda info=info: _facts.Fact.proven(self.escape_analysis.summaries[info.name]))
        self.scalar_report = _scalar.ScalarReplacer(self, sys.modules[__name__], classes=('a','b','c')).run()
        try:
            merged = _merge_cycles(self)
        except Unsupported:
            merged = None
        compact = any(info.recursive for info in self.order)
        bodies = (_borrow_heap_context(self, merged or []) if compact else
                  [info.source for info in self.order] + (merged or []))
        helpers = "".join(source for _, source in sorted(self.__dict__.get("helpers", {}).items()))
        self.source = (_RUNTIME + (_BORROWED_HEAP if compact else "") + self.extra_runtime() + helpers
                       + "\n\n".join(bodies) + "\n")
        if self.numeric_policy is not None:
            self.source = self.numeric_policy.source + self.source
        from ._origin import cache_identity as origin_identity
        origins = [origin_identity(info.fn) for info in self.order]
        self.digest = _source_digest(self.source + "\n# origins: " + repr(origins) + ("\n# inference seed: " + self.seed_identity
                                                    if hasattr(self, "seed_identity") else ""))
        if hasattr(ahead_of_time, 'resolve_program'):
            try:
                built = ahead_of_time.resolve_program(self)
            except Exception as exc:
                from ._prepared import PreparedMiss
                if not isinstance(exc, PreparedMiss): raise
                raise Unsupported(str(exc)) from exc
        else:
            built = (ahead_of_time or {}).get(self.digest)
        if built is not None:
            # Built from this exact code, after the checks below passed at build time.
            self.module, self.run, self.cached, self.ahead_of_time = None, built, True, True
            return
        self.ahead_of_time = False
        self.check_math()
        _start_numba()
        # The module must be registered: Numba names functions from unregistered
        # modules afresh on each compile, and recursive calls then fail to link. The
        # name also marks the functions as RecomPyler's for reference-count removal.
        # Numba's disk cache cannot reload functions that call each other (the
        # reloaded code crashes). Merged groups only call themselves; a region whose
        # groups could not be merged compiles afresh in each process.
        module = None if merged is None else _cached_module(_plain(self.source))
        self.cached = module is not None
        if module is None:
            module = pytypes.ModuleType(f"recompyler_generated_heap{next(_MODULE_NUMBERS)}")
            sys.modules[module.__name__] = module
            exec(compile(_plain(self.source), f"<recompyler region:{self.entry_fn.__name__}>", "exec"), module.__dict__)
        self.module = module
        self.run = module.__dict__[self.entry.name]

    def prove_zero_int_results(self):
        """Certify zero-only integer cases without changing any numeric kind/flag.

        Start with candidate certificates, then drop them on every unknown or
        nonzero producer. Retained recursive certificates hold by induction on
        finite successful call trees. Never emit optimized code during analysis.
        """
        if not self.saw_mixed or self.fast_mixed or any(info.generator or info.coroutine for info in self.order):
            return
        order = tuple(self.order)
        self.zero_vars = {info: {name: {path for path, _, _ in _zero_parts(kind, _dummy(kind))}
                                     if name not in info.params else set()
                                for name, kind in info.vars.items()} for info in order}
        self.zero_returns = {info: {path for path, _, _ in _zero_parts(info.ret, _dummy(info.ret))}
                             for info in order}
        count = sum(len(paths) for variables in self.zero_vars.values() for paths in variables.values())
        count += sum(map(len, self.zero_returns.values()))
        self.zero_collect = True
        stable = False
        for _ in range(count + 1):
            self.changed = self.zero_changed = False
            for info in order:
                _Gen(self, info).run()
            if self.changed or tuple(self.order) != order:
                break
            if not self.zero_changed:
                stable = True
                break
        self.zero_collect = False
        if stable:
            self.zero_optimized, self.zero_invalid = True, False
            self.changed = False
            sources = [_Gen(self, info).run() for info in order]
            if not self.changed and not self.zero_invalid and tuple(self.order) == order:
                for info, source in zip(order, sources):
                    info.source = source
                return
        # Optional proof failure must not remove ordinary compiler eligibility.
        self.zero_vars, self.zero_returns = {}, {}
        self.zero_optimized = False
        self.settle()

    def meet_zero(self, candidates, facts):
        if candidates - facts:
            if self.zero_collect:
                candidates.intersection_update(facts)
                self.zero_changed = True
            elif self.zero_optimized:
                self.zero_invalid = True

    def check_math(self):
        """Require the existing exact-math check for every emitted operation."""
        used = {name for info in self.order for name in getattr(info, "math_used", ())}
        differs = sorted(used.intersection(TRANSCENDENTAL) - _math_agrees())
        if differs:
            raise Unsupported(f"math.{differs[0]} gives different results when compiled on this machine")

    def extra_runtime(self):
        """Helpers the generated code needs beyond _RUNTIME: the Mersenne Twister
        when a random.Random is used."""
        extra = ""
        if getattr(self, "arrays_used", False):
            from ._nd import IMPORT
            extra += IMPORT
        if getattr(self, "rng_used", False):
            from ._rng import RUNTIME
            extra += RUNTIME
        return extra

    def settle(self):
        """Generate every function's code until the types stop changing."""
        for _ in range(60):
            self.changed, self.order, self.calls, self.specialized = False, [self.entry], {}, {}
            position = 0
            while position < len(self.order):
                info = self.order[position]
                info.source = _Gen(self, info).run()
                position += 1
            if self.mark_recursive():
                self.changed = True
            if not self.changed:
                return
        raise Unsupported("the types in this region did not settle")

    def floats_unseen(self):
        return self.facts.query("F4", "float-observability",
            lambda: _facts.Fact.proven(True) if self._floats_unseen()
            else _facts.Fact.unknown("numeric kind is observed")).state == "proven"

    def _floats_unseen(self):
        """True if nothing the region hands back to Python can be a float or an
        int-or-float: its result, the attributes and lists it writes back, and what
        they hold.

        Then an int-or-float value can be computed as a plain float, as long as every
        result stays below 2**53 in size, so int arithmetic stays exact: what would
        tell an int from an equal float, or 0 from -0.0, never reaches Python. Inside
        the region nothing does either: // % and bitwise operators need ints, every
        compiled math function takes one argument and keeps or ignores the sign of a
        zero, and dividing by either zero raises."""
        # An integer-tagged mixed value may index a list, while an equal float
        # must raise. Its kind is observable inside the region itself.
        if self.mixed_kind_used:
            return False
        done, written = set(), self.written_set()

        def plain(kind, seen):
            if isinstance(kind, str):
                return kind not in (FLOAT, MIXED, NPF, NPFQ)
            if isinstance(kind, OptT):
                return False
            if isinstance(kind, (RngT, NdT)):
                return True
            if isinstance(kind, TupT):
                return all(plain(item, seen) for item in kind.items)
            if isinstance(kind, ListT):
                root = _find(kind.cell)
                if id(root) in seen:
                    return True
                seen.add(id(root))
                return plain(root.elem, seen)
            if isinstance(kind, _HANDLES):
                return all(plain(elem, seen) for elem in _contained(kind, seen))
            for cls in kind.classes:
                if cls in seen:
                    continue
                seen.add(cls)
                fields = self.fields[self.family(cls)]
                if not all(plain(fields[name], seen) for name in self.class_fields[cls]):
                    return False
            return True

        def written_back(kind):
            """What is written back into objects and lists that came in is plain."""
            if isinstance(kind, TupT):
                return all(written_back(item) for item in kind.items)
            if isinstance(kind, ListT):
                root = _find(kind.cell)
                if id(root) in done:
                    return True
                done.add(id(root))
                if root.mutated and not plain(root.elem, set()):
                    return False
                return written_back(root.elem)
            if isinstance(kind, (DictT, SetT)):
                mutated = any(_find(cell).mutated for cell in _cells(kind))
                elems = _contained(kind, done)
                if mutated and not all(plain(elem, set()) for elem in elems):
                    return False
                return all(written_back(elem) for elem in elems)
            if not isinstance(kind, ObjT):
                return True
            for cls in kind.classes:
                if cls in done:
                    continue
                done.add(cls)
                root = self.family(cls)
                for name in self.class_fields[cls]:
                    field = self.fields[root][name]
                    if (root, name) in written and not plain(field, set()):
                        return False
                    if not written_back(field):
                        return False
            return True

        inputs = [self.entry.vars.get(name, BOTTOM) for name in self.entry.params]
        inputs += [kind for _, _, kind in self.global_objects]
        return plain(self.entry.ret, set()) and all(written_back(kind) for kind in inputs)

    def mark_recursive(self):
        """Flag the functions that can reach themselves. True if any flag changed."""
        changed = False
        for info in self.order:
            seen, stack = set(), list(self.calls.get(info, ()))
            while stack:
                other = stack.pop()
                if other in seen:
                    continue
                seen.add(other)
                stack.extend(self.calls.get(other, ()))
            recursive = info in seen
            if recursive != info.recursive:
                info.recursive, changed = recursive, True
        return changed

    def guards_hold(self):
        for guard in self.guards.values():
            kind = guard[0]
            if kind == "code":
                if guard[1].__code__ is not guard[2]:
                    return False
            elif kind == "lifetime":
                from .lift import _has_finalizer, _plain_allocation
                if _has_finalizer(guard[1]) or not _plain_allocation(guard[1]):
                    return False
            elif kind == "attr":
                if getattr(guard[1], guard[2], None) is not guard[3]:
                    return False
            elif kind == "own":
                if vars(guard[1]).get(guard[2]) is not guard[3]:
                    return False
            elif kind == "item":
                if guard[1].get(guard[2]) is not guard[3]:
                    return False
            elif kind == "builtin":
                if guard[2] in guard[1] or guard[3].get(guard[2]) is not guard[4]:
                    return False
            elif kind == "const":
                current = guard[1].get(guard[2])
                if type(current) is not type(guard[3]) or current != guard[3] or repr(current) != repr(guard[3]):
                    return False
            elif kind == "kwdefaults":
                current, saved, items = guard[1].__kwdefaults__, guard[2], guard[3]
                if (current is not saved or type(current) is not dict or len(current) != len(items)
                        or any(type(name) is not str for name in current)):
                    return False
                if any(
                        name not in current or current[name] is not value for name, value in items):
                    return False
        return True


def _cells(kind):
    """The item cells of a dict or set."""
    if isinstance(kind, DictT):
        return [kind.kcell, kind.vcell]
    return [kind.cell] if isinstance(kind, SetT) else []


def _contained(kind, seen):
    """The item types of a dict or set not yet in ``seen`` (ids of cells), which it
    then holds."""
    out = []
    for cell in _cells(kind):
        root = _find(cell)
        if id(root) not in seen:
            seen.add(id(root))
            out.append(root.elem)
    return out


def _rename_comprehensions(node, fn):
    """Give each list comprehension's variables names of their own, as Python's
    separate scope does, and a name for the list it builds. Returns those names, which
    the generated code holds as locals."""
    names = set()
    comprehensions = [item for item in ast.walk(node) if isinstance(item, ast.ListComp)]
    for number, comprehension in enumerate(comprehensions):
        if any(isinstance(inner, ast.ListComp) and inner is not comprehension for inner in ast.walk(comprehension)):
            raise Unsupported(f"a list comprehension inside another in '{fn.__qualname__}'")
        if any(generator.is_async for generator in comprehension.generators):
            raise Unsupported(f"an async comprehension in '{fn.__qualname__}'")
        own = set()
        for generator in comprehension.generators:
            own.update(_target_names(generator.target))
        prefix = f"_c{number}_"
        # The first iterable is evaluated outside the comprehension's scope.
        inside = [comprehension.elt] + [part for index, generator in enumerate(comprehension.generators)
                                        for part in ([generator.target] + generator.ifs
                                                     + ([generator.iter] if index else []))]
        for part in inside:
            for item in ast.walk(part):
                if isinstance(item, ast.Name) and item.id in own:
                    item.id = prefix + item.id
        comprehension.recompyler_list = f"{prefix}list"
        names |= {prefix + name for name in own} | {comprehension.recompyler_list}
    return names


def _defining_class(fn):
    """The class whose body defines ``fn``, if its only free variable is the
    ``__class__`` cell that zero-argument super() reads; else None."""
    if fn.__code__.co_freevars != ("__class__",) or not fn.__closure__:
        return None
    try:
        found = fn.__closure__[0].cell_contents
    except ValueError:
        return None
    return found if isinstance(found, type) else None


def _super_call(node):
    """The method name if ``node`` is a call ``super().name(...)``, else None."""
    func = node.func if isinstance(node, ast.Call) else None
    if not (isinstance(func, ast.Attribute) and isinstance(func.value, ast.Call)):
        return None
    inner = func.value
    if not (isinstance(inner.func, ast.Name) and inner.func.id == "super" and not inner.args and not inner.keywords):
        return None
    return func.attr

_GENERATOR_FLAGS = 0x20 | 0x200
# The list a generator's collecting form appends what it yields to.
_OUT = "_rc_out"


def _rename_generator_exps(node, fn):
    """Give each generator expression's variables names of their own (``_e<n>_``), as
    its own scope does. Returns those names. A generator expression compiles only
    where it is consumed at once (a loop over it, sum(), any(), ...)."""
    names = set()
    found = [item for item in ast.walk(node) if isinstance(item, ast.GeneratorExp)]
    for number, expression in enumerate(found):
        if any(generator.is_async for generator in expression.generators):
            raise Unsupported(f"an async generator expression in '{fn.__qualname__}'")
        own = set()
        for generator in expression.generators:
            own.update(_target_names(generator.target))
        prefix = f"_e{number}_"
        # The first iterable is evaluated outside the expression's scope.
        inside = [expression.elt] + [part for index, generator in enumerate(expression.generators)
                                     for part in ([generator.target] + generator.ifs
                                                  + ([generator.iter] if index else []))]
        for part in inside:
            for item in ast.walk(part):
                if isinstance(item, ast.Name) and item.id in own:
                    item.id = prefix + item.id
        names |= {prefix + name for name in own}
    return names


class _AsListComp(ast.NodeTransformer):
    def visit_GeneratorExp(self, node):
        self.generic_visit(node)
        return ast.copy_location(ast.ListComp(elt=node.elt, generators=node.generators), node)

    def visit_AsyncFor(self, node):
        self.generic_visit(node)
        return ast.copy_location(ast.For(target=node.target, iter=node.iter, body=node.body, orelse=node.orelse), node)


def _flow_view(node):
    """A copy of ``node`` with generator expressions as list comprehensions, which
    have the same scope, for the checks that know list comprehensions."""
    return _AsListComp().visit(copy.deepcopy(node))


def _check_generator(node, fn):
    """Check a generator's yields and rewrite ``yield from x`` as ``for _rcy<n> in x:
    yield _rcy<n>``. Returns the names that adds. Only ``yield`` statements are
    allowed (no values sent in), and ``return`` without a value."""
    statements = {id(item.value) for item in ast.walk(node) if isinstance(item, ast.Expr)}
    for item in ast.walk(node):
        if isinstance(item, (ast.Yield, ast.YieldFrom)) and id(item) not in statements:
            raise Unsupported(f"'{fn.__qualname__}' uses the value of a yield at line {item.lineno}")
        if isinstance(item, ast.Return) and item.value is not None and not (
                isinstance(item.value, ast.Constant) and item.value.value is None):
            raise Unsupported(f"generator '{fn.__qualname__}' returns a value at line {item.lineno}")
    names = []

    class Expand(ast.NodeTransformer):
        def visit_Expr(self, statement):
            if not isinstance(statement.value, ast.YieldFrom):
                return statement
            name = f"_rcy{len(names)}"
            names.append(name)
            loop = ast.For(target=ast.Name(id=name, ctx=ast.Store()), iter=statement.value.value, orelse=[],
                           body=[ast.Expr(value=ast.Yield(value=ast.Name(id=name, ctx=ast.Load())))])
            return _locate(loop, statement)

    Expand().visit(node)
    return set(names)


def _locate(tree, node):
    """Give the parts of ``tree`` without a position the position of ``node``."""
    for item in ast.walk(tree):
        if "lineno" in item._attributes and not hasattr(item, "lineno"):
            ast.copy_location(item, node)
    return tree


def _loop_exits(statements):
    """True if ``statements`` hold a break or continue of the loop they are the body of."""
    for statement in statements:
        if isinstance(statement, (ast.Break, ast.Continue)):
            return True
        if isinstance(statement, ast.If) and (_loop_exits(statement.body) or _loop_exits(statement.orelse)):
            return True
        if isinstance(statement, ast.Try) and any(_loop_exits(part) for part in (
                statement.body, statement.orelse, statement.finalbody, *[h.body for h in statement.handlers])):
            return True
    return False


def _exits_to(statements, stop):
    """A copy of a loop body run once inside ``while True: ... break``: its own break
    sets ``stop`` and leaves, its own continue just leaves."""
    out = []
    for statement in statements:
        if isinstance(statement, ast.Break):
            out += [_locate(ast.Assign(targets=[ast.Name(id=stop, ctx=ast.Store())], value=ast.Constant(True)),
                            statement), ast.copy_location(ast.Break(), statement)]
        elif isinstance(statement, ast.Continue):
            out.append(ast.copy_location(ast.Break(), statement))
        elif isinstance(statement, ast.If):
            copied = copy.copy(statement)
            copied.body, copied.orelse = _exits_to(statement.body, stop), _exits_to(statement.orelse, stop)
            out.append(copied)
        elif isinstance(statement, ast.Try):
            copied = copy.copy(statement)
            copied.body, copied.finalbody = _exits_to(statement.body, stop), _exits_to(statement.finalbody, stop)
            out.append(copied)
        else:
            out.append(statement)
    return out


def _yields_or_returns(statements):
    return any(isinstance(item, (ast.Yield, ast.Return)) for statement in statements for item in ast.walk(statement))


class _InlineYields:
    """A generator's body rewritten for one consuming loop: each ``yield v`` binds the
    loop's target and runs its body there; a ``return``, or a ``break`` in the loop's
    body, sets ``stop`` and leaves every loop of the generator."""

    def __init__(self, stop, target, body):
        self.stop, self.target, self.body = stop, target, body
        self.exits = _loop_exits(body)

    def leave(self, node):
        return [_locate(ast.Assign(targets=[ast.Name(id=self.stop, ctx=ast.Store())], value=ast.Constant(True)),
                        node), ast.copy_location(ast.Break(), node)]

    def check(self, node):
        return _locate(ast.If(test=ast.Name(id=self.stop, ctx=ast.Load()), body=[ast.Break()], orelse=[]), node)

    def statements(self, statements):
        out = []
        for statement in statements:
            out += self.statement(statement)
        return out

    def statement(self, node):
        if isinstance(node, ast.Expr) and isinstance(node.value, ast.Yield):
            value = node.value.value or ast.Constant(None)
            bind = _locate(ast.Assign(targets=[copy.deepcopy(self.target)], value=value), node)
            body = copy.deepcopy(self.body)
            if not self.exits:
                return [bind] + body
            once = ast.While(test=ast.Constant(True), body=_exits_to(body, self.stop) + [ast.Break()], orelse=[])
            return [bind, _locate(once, node), self.check(node)]
        if isinstance(node, ast.Return):
            return self.leave(node)
        if isinstance(node, (ast.For, ast.AsyncFor, ast.While)):
            if node.orelse:
                raise Unsupported(f"a loop with else in a generator at line {node.lineno}")
            copied = copy.copy(node)
            copied.body = self.statements(node.body) or [ast.copy_location(ast.Pass(), node)]
            return [copied] + ([self.check(node)] if _yields_or_returns(node.body) else [])
        if isinstance(node, ast.If):
            copied = copy.copy(node)
            copied.body = self.statements(node.body) or [ast.copy_location(ast.Pass(), node)]
            copied.orelse = self.statements(node.orelse)
            return [copied]
        if _yields_or_returns([node]):
            # A yield or return inside try ... finally: closing the generator early
            # would have to run the finally block.
            raise Unsupported(f"a yield or return inside {type(node).__name__} in a generator at line {node.lineno}")
        return [node]


def _inline_generator(consumer, callee, args, receiver, site):
    """Statements that run generator ``callee`` with argument expressions ``args``
    for the loop ``site`` of ``consumer``: the generator's body with its variables
    renamed, each yield running the loop's body. ``receiver``: the first argument is
    an object a method or ``__iter__`` was looked up on, so it cannot be None."""
    consumer.inlines = getattr(consumer, "inlines", 0) + 1
    prefix = f"_g{consumer.inlines}_"
    stop = prefix + "stop"
    fn, params = callee.fn, callee.params
    if fn.__closure__:
        raise Unsupported(f"inlining generator '{fn.__qualname__}' with a closure")
    bound = _bind_entry(fn, tuple(args), {})
    if bound is None:
        raise Unsupported("a generator call has invalid arguments or default metadata")
    argument_ids = {id(argument) for argument in args}
    def expression(value):
        # Only parsed argument expressions are AST nodes. Defaults may contain
        # arbitrary application values; never inspect them with isinstance.
        if id(value) in argument_ids:
            return value
        kind = type(value)
        if kind is tuple:
            return ast.Tuple(elts=[expression(part) for part in value], ctx=ast.Load())
        if any(kind is cls for cls in (bool, int, float, complex, str, bytes, type(None))):
            return ast.Constant(value)
        raise Unsupported("a generator default is not an inert literal")
    values = [expression(value) for value in bound]
    statements = [ast.Assign(targets=[ast.Name(id=prefix + name, ctx=ast.Store())], value=value)
                  for name, value in zip(params, values)]
    if receiver:
        statements.append(ast.Assert(test=ast.Compare(left=ast.Name(id=prefix + params[0], ctx=ast.Load()),
                                                      ops=[ast.IsNot()], comparators=[ast.Constant(None)]), msg=None))
    body = copy.deepcopy(callee.node.body)
    for statement in body:
        for item in ast.walk(statement):
            if isinstance(item, ast.Name) and item.id in callee.locals:
                item.id = prefix + item.id
            if isinstance(item, ast.ListComp) and hasattr(item, "recompyler_list"):
                item.recompyler_list = prefix + item.recompyler_list
    inner = _InlineYields(stop, site.target, site.body).statements(body)
    statements += [ast.Assign(targets=[ast.Name(id=stop, ctx=ast.Store())], value=ast.Constant(False)),
                   ast.While(test=ast.Constant(True), body=inner + [ast.Break()], orelse=[])]
    consumer.locals = consumer.locals | {prefix + name for name in callee.locals} | {stop}
    reset_flags = {prefix + name for name in callee.flagged}
    consumer.flagged = consumer.flagged | reset_flags
    statements[0]._rc_reset_flags = reset_flags
    return [_locate(statement, site) for statement in statements]


def _base_init(statement, me, init, cls):
    """The base class if ``statement`` is ``Base.__init__(me, ...)`` for a base of
    ``cls`` with a plain __init__, else None."""
    if not (isinstance(statement, ast.Expr) and isinstance(statement.value, ast.Call)):
        return None
    call = statement.value
    func = call.func
    if not (isinstance(func, ast.Attribute) and func.attr == "__init__" and isinstance(func.value, ast.Name)
            and call.args and isinstance(call.args[0], ast.Name) and call.args[0].id == me):
        return None
    if any(isinstance(item, ast.Name) and item.id == me for keyword in call.keywords for item in ast.walk(keyword)):
        return None
    base = init.__globals__.get(func.value.id)
    if not isinstance(base, type) or base not in cls.__mro__[1:] or not isinstance(base.__init__, FunctionType):
        return None
    return base


def _plain_store(statement, unset):
    """True for an assignment made only of names, attributes, subscripts and
    constants that reads none of the attributes in ``unset``: it runs no code."""
    if not isinstance(statement, ast.Assign):
        return False
    for item in ast.walk(statement):
        if not isinstance(item, (ast.Assign, ast.Name, ast.Attribute, ast.Subscript, ast.Constant, ast.Load,
                                 ast.Store)):
            return False
        if isinstance(item, ast.Attribute) and isinstance(item.ctx, ast.Load) and item.attr in unset:
            return False
    return True


# (class, __init__) -> whether it stores the new object somewhere before the end.
_ESCAPES = {}


def _super_init(statement, init, cls):
    """The __init__ that ``statement`` calls if it is ``super().__init__(...)`` in
    ``init`` on an object of ``cls``, else None."""
    if not (isinstance(statement, ast.Expr) and isinstance(statement.value, ast.Call)):
        return None
    func = statement.value.func
    if not (isinstance(func, ast.Attribute) and func.attr == "__init__" and isinstance(func.value, ast.Call)
            and isinstance(func.value.func, ast.Name) and func.value.func.id == "super"
            and not func.value.args and not func.value.keywords):
        return None
    if init.__globals__.get("super", init.__builtins__.get("super")) is not super:
        return None
    cell = dict(zip(init.__code__.co_freevars, init.__closure__ or ())).get("__class__")
    if cell is None or cell.cell_contents not in cls.__mro__:
        return None
    mro = cls.__mro__
    for klass in mro[mro.index(cell.cell_contents) + 1:]:
        if "__init__" in vars(klass):
            found = vars(klass)["__init__"]
            if found is not object.__init__ and not isinstance(found, FunctionType):
                raise Unsupported(f"'{klass.__name__}.__init__' is not a plain function")
            return found
    return None


def _init_assigned(cls, init):
    """The attributes ``__init__`` sets, after checking it sets every one of them
    before the new object is used for anything else, so no attribute of an object
    in the heap is ever unset."""
    names = _init_fields(init)
    if names is None:
        raise Unsupported(f"no source for '{cls.__name__}.__init__'")
    names = set(names)
    node = ast.parse(textwrap.dedent(inspect.getsource(init.__code__))).body[0]
    me = node.args.args[0].arg
    assigned, escaped = set(), False
    for statement in node.body:
        found = _super_init(statement, init, cls)
        if assigned == names and not _base_init(statement, me, init, cls) and found is None:
            break
        calls = any(isinstance(item, ast.Call) for item in ast.walk(statement))
        if escaped and (calls or not isinstance(statement, (ast.Assign, ast.AugAssign, ast.AnnAssign, ast.Pass))):
            # Once stored somewhere, the new object may be seen by any code that runs.
            raise Unsupported(f"'{cls.__name__}.__init__' uses the new object before setting all its attributes")
        mentions = [item for item in ast.walk(statement) if isinstance(item, ast.Name) and item.id == me]
        if found is not None:
            # ``super().__init__(...)``: what the next __init__ sets, it sets here.
            if mentions:
                raise Unsupported(f"'{cls.__name__}.__init__' passes the new object to super().__init__")
            if found is not object.__init__:
                inherited = _init_assigned(cls, found)
                names |= inherited
                assigned |= inherited
                escaped = escaped or _ESCAPES.get((cls, found), False)
            continue
        if not mentions:
            continue
        base = _base_init(statement, me, init, cls)
        if base is not None:
            # ``Base.__init__(self, ...)``: what it sets, it sets here.
            if len(mentions) != 1:
                raise Unsupported(f"'{cls.__name__}.__init__' passes the new object to its base twice")
            inherited = _init_assigned(base, base.__init__)
            names |= inherited
            assigned |= inherited
            escaped = escaped or _ESCAPES.get((base, base.__init__), False)
            continue
        # Every use of the new object must read an attribute already set, or be the
        # target of a plain assignment that sets one.
        own = []
        if isinstance(statement, ast.Assign):
            own = [target for target in statement.targets if isinstance(target, ast.Attribute)
                   and isinstance(target.value, ast.Name) and target.value.id == me]
        allowed = 0
        for item in ast.walk(statement):
            if isinstance(item, ast.Attribute) and isinstance(item.value, ast.Name) and item.value.id == me:
                if item in own or item.attr in assigned:
                    allowed += 1
        if allowed != len(mentions):
            # The object stored as a plain value (``table[i] = self``), by a statement
            # that runs no code: allowed if no code runs until its attributes are set.
            if (isinstance(statement, ast.Assign) and isinstance(statement.value, ast.Name)
                    and statement.value.id == me and allowed == len(mentions) - 1 and not calls):
                escaped = True
            else:
                raise Unsupported(f"'{cls.__name__}.__init__' uses the new object before setting all its attributes")
        assigned.update(target.attr for target in own)
    if assigned != names:
        raise Unsupported(f"'{cls.__name__}.__init__' does not always set every attribute")
    _ESCAPES[cls, init] = escaped
    return names


_MODULE_NUMBERS = itertools.count()
_DECORATOR = '@njit(error_model="numpy")'
# Functions that are not recursive are inlined where they are called in modules built
# ahead of time: a call passes the four heap arrays and is followed by an error-flag
# check, and in code made of many small methods that costs as much as the work
# (raytrace: 12.2 ms to 5.1 ms). Inlining makes Numba type each function again at
# every call site (raytrace: about 9 s to 44 s), so code compiled at run time and
# while profiling keeps plain calls; see _plain.
_INLINED = '@njit(error_model="numpy", inline="always")'
INLINE_LINES = 400


def _plain(source):
    """Generated source with every function compiled on its own."""
    return source.replace(_INLINED, _DECORATOR)
_SHARED = {"F", "I", "top", "st"}


def _cycles(program):
    """The groups of two or more functions that can each reach the others."""
    def reach(info):
        seen, stack = set(), list(program.calls.get(info, ()))
        while stack:
            other = stack.pop()
            if other not in seen:
                seen.add(other)
                stack.extend(program.calls.get(other, ()))
        return seen

    reached = {info: reach(info) for info in program.order}
    groups, placed = [], set()
    for info in program.order:
        if info in placed:
            continue
        group = [other for other in program.order if other in reached[info] and info in reached[other]]
        if len(group) > 1:
            groups.append(group)
            placed.update(group)
    return groups


def _merge_cycles(program):
    """Turn each group of functions that call each other into one self-recursive
    function, and each member into a thin wrapper that calls it.

    Numba's disk cache crashes when it reloads functions that call each other; a
    function that calls only itself reloads fine. The merged function takes a
    selector ``which``, then every member's parameters (prefixed, so no two members'
    names meet), and always returns one tuple with every member's result slots,
    unused slots holding throwaway values. Calls between members go straight to it;
    callers outside the group keep calling the wrappers. Returns the merged
    functions' source.
    """
    out, wrappers = [], {}
    for number, group in enumerate(_cycles(program)):
        name = f"s{number}_{group[0].name}"
        members = {info.name: index for index, info in enumerate(group)}
        params, dummies, slots, at = [], [], [], 0
        for index, info in enumerate(group):
            codes = [code for param in info.params for code in _dummy(info.vars.get(param, BOTTOM))]
            own = [f"m{index}_{param}" for param in _params(info)]
            if len(codes) != len(own):
                raise Unsupported(f"cannot merge '{info.fn.__qualname__}' with the functions it calls back")
            params.append(own)
            dummies.append(_typed_codes(_param_kinds(info), codes))
            ret = info.ret
            width = 0 if ret in (NONE, BOTTOM) else _width(ret)
            slots.append((at, width, _dummy(ret) if width else []))
            at += width
        filler = [] if at else ["0"]

        def packed(index, values):
            items = [code for other, (_, width, empty) in enumerate(slots)
                     for code in (values if other == index else empty)] + filler
            return "(" + ", ".join(items) + ",)"

        def direct(index, args):
            args = _typed_codes(_param_kinds(group[index]), args)
            passed = [code for other in range(len(group))
                      for code in (args if other == index else dummies[other])]
            return f"{name}(F, I, top, st, np.int64({index}){''.join(', ' + code for code in passed)})"

        def pick(index, call):
            start, width, _ = slots[index]
            if width == 0:
                return call
            return f"{call}[{start}]" if width == 1 else f"{call}[{start}:{start + width}]"

        branches = []
        for index, info in enumerate(group):
            tree = ast.parse(info.source).body[0]
            local = set(_params(info)) | {node.id for node in ast.walk(tree)
                                          if isinstance(node, ast.Name) and isinstance(node.ctx, ast.Store)}
            local -= _SHARED
            body = _Rewrite(index, local, members, slots, packed, direct, pick).rewrite(tree.body)
            branches.append(body)
            # The wrapper keeps the member's name and parameters for outside callers.
            result = pick(index, direct(index, _params(info)))
            body_text = f"    {result}\n    return" if slots[index][1] == 0 else f"    return {result}"
            wrappers[info] = (f"{_INLINED}\ndef {info.name}(F, I, top, st"
                              f"{''.join(', ' + p for p in _params(info))}):\n{body_text}\n")
        lines = [f"{_DECORATOR}",
                 f"def {name}(F, I, top, st, which{''.join(', ' + p for own in params for p in own)}):"]
        for index, body in enumerate(branches):
            lines.append(f"    {'if' if index == 0 else 'elif'} which == {index}:")
            lines.extend("        " + line for line in body.splitlines())
        lines.append(f"    return {packed(-1, [])}")
        out.append("\n".join(lines) + "\n")
    for info, source in wrappers.items():
        info.source = source
    return out


def _borrow_heap_context(program, merged):
    """Compact generated calls, keeping the four-array public entry unchanged.

    One adapter-owned stack record carries the borrowed context throughout the
    synchronous native attempt. Local carray views keep ordinary signed indexing.
    In particular, F and I can alias: neither pointer has a noalias contract.
    Growth is still a status exit followed by a new Python-side attempt.
    """
    sources = [info.source for info in program.order] + merged
    trees = [ast.parse(source).body[0] for source in sources]
    names = {tree.name: tree.name + "_borrowed" for tree in trees}
    raw = ["_heap_F", "_heap_I", "_heap_top", "_heap_st", "_heap_len"]
    # Preserve SSA pointers through helpers selected for AOT always-inlining.
    # _plain deliberately keeps wider helper calls for JIT/profiling; recursive,
    # large and ordinary entry bodies still use the compact pointer interface.
    contexts = {tree.name: ["_heap_ctx"] + (raw if source.startswith(_INLINED + "\ndef ") else [])
                for source, tree in zip(sources, trees)}

    class Calls(ast.NodeTransformer):
        def visit_Call(self, node):
            self.generic_visit(node)
            if isinstance(node.func, ast.Name) and node.func.id in names:
                context = contexts[node.func.id]
                node.func.id = names[node.func.id]
                node.args[:4] = [ast.Name(id=name, ctx=ast.Load()) for name in context]
            return node

    unpack = ast.parse("_heap_F, _heap_I, _heap_top, _heap_st, _heap_len = _heap_context_unpack(_heap_ctx)\n").body
    views = ast.parse("F = carray(_heap_F, _heap_len)\n"
                      "I = carray(_heap_I, _heap_len)\n"
                      "top = carray(_heap_top, 4)\n"
                      "st = carray(_heap_st, 1)\n").body
    out = []
    for source, tree in zip(sources, trees):
        context = contexts[tree.name]
        tree = Calls().visit(tree)
        tree.name = names[tree.name]
        tree.args.args[:4] = [ast.arg(arg=name) for name in context]
        tree.body[:0] = copy.deepcopy((unpack if len(context) == 1 else []) + views)
        # Keep decorator spelling: _plain and the disk-cache adapter deliberately
        # rewrite these exact decorator strings before compiling the source.
        decorator = source.split("\ndef ", 1)[0]
        tree.decorator_list = []
        out.append(decorator + "\n" + ast.unparse(ast.fix_missing_locations(tree)) + "\n")
    for info, source in zip(program.order, out):
        info.source = source
    params = _params(program.entry)
    entry_context = contexts[program.entry.name]
    out.append(f'''{_DECORATOR}
def {program.entry.name}(F, I, top, st{''.join(', ' + name for name in params)}):
    if (F.ndim != 1 or I.ndim != 1 or top.ndim != 1 or st.ndim != 1
            or len(F) != len(I) or len(top) != 4 or len(st) != 1
            or F.strides[0] != 8 or I.strides[0] != 8
            or top.strides[0] != 8 or st.strides[0] != 1):
        raise ValueError("invalid heap context")
    _heap_F = _heap_data(F)
    _heap_I = _heap_data(I)
    _heap_top = _heap_data(top)
    _heap_st = _heap_data(st)
    _heap_len = np.int64(len(F))
    _heap_ctx = _heap_context_pack(_heap_F, _heap_I, _heap_top, _heap_st, _heap_len)
    return {names[program.entry.name]}({', '.join(entry_context)}{''.join(', ' + name for name in params)})
''')
    return out


# The intrinsic's implementation is part of generated source/cache identity.
# It is executed only on compilation, after the Numba-free AOT digest lookup.
_BORROWED_HEAP = '''
from numba import carray, types as _heap_types
from numba.core import cgutils as _heap_cgutils
from numba.extending import intrinsic as _heap_intrinsic

@_heap_intrinsic
def _heap_data(typingctx, array):
    signature = _heap_types.CPointer(array.dtype)(array)
    def codegen(context, builder, sig, args):
        view = context.make_array(sig.args[0])(context, builder, value=args[0])
        return view.data
    return signature, codegen

@_heap_intrinsic
def _heap_context_pack(typingctx, heap_F, heap_I, heap_top, heap_st, heap_len):
    fields = (heap_F, heap_I, heap_top, heap_st, heap_len)
    if not all(isinstance(field, _heap_types.CPointer) for field in fields[:4]) or heap_len != _heap_types.int64:
        return
    record = _heap_types.Tuple(fields)
    signature = _heap_types.CPointer(record)(*fields)
    def codegen(context, builder, sig, args):
        # This intrinsic emits into the public adapter's frame, which remains
        # live until every synchronous borrowed call has returned. The pointer
        # never becomes a returned user value or part of retained native state.
        model = context.data_model_manager[record]
        value = context.make_tuple(builder, record, args)
        return _heap_cgutils.alloca_once_value(builder, model.as_data(builder, value))
    return signature, codegen

@_heap_intrinsic
def _heap_context_unpack(typingctx, pointer):
    if not isinstance(pointer, _heap_types.CPointer) or not isinstance(pointer.dtype, _heap_types.BaseTuple):
        return
    record = pointer.dtype
    if (len(record) != 5 or not all(isinstance(field, _heap_types.CPointer) for field in record.types[:4])
            or record.types[4] != _heap_types.int64):
        return
    signature = record(pointer)
    def codegen(context, builder, sig, args):
        # The immutable descriptor retains each actual pointer type. Its arena
        # pointees can alias and mutate; no disjointness/readonly promise is made.
        model = context.data_model_manager[sig.return_type]
        return model.from_data(builder, builder.load(args[0]))
    return signature, codegen

'''


_MACHINE = {"i": "np.int64", "f": "np.float64", "b": "np.bool_"}


def _machine_types(kind):
    """'i', 'f' or 'b' for each machine value that stands for a value of ``kind``."""
    if kind in (FLOAT, NPF):
        return ["f"]
    if kind in (BOOL, NPB):
        return ["b"]
    if kind in (MIXED, NPFQ):
        return ["f", "b"]
    if kind == NPIQ:
        return ["i", "b"]
    if kind == NPBQ:
        return ["b", "b"]
    if isinstance(kind, OptT):
        return _machine_types(kind.base) + ["b"]
    if isinstance(kind, TupT):
        return [letter for item in kind.items for letter in _machine_types(item)] + (["b"] if kind.nullable else [])
    return ["i"]


def _param_kinds(info):
    return [letter for param in info.params for letter in _machine_types(info.vars.get(param, BOTTOM))]


def _typed_codes(letters, codes):
    """``codes`` as values of fixed machine types, so none reaches Numba as a literal."""
    if len(letters) != len(codes):
        raise Unsupported("argument widths do not match")
    return [code if code.startswith(_MACHINE[letter] + "(") else f"{_MACHINE[letter]}({code})"
            for letter, code in zip(letters, codes)]


def _typed(kind, codes):
    return _typed_codes(_machine_types(kind), codes)


def _params(info):
    """The machine-level parameter names of a generated function (_Gen.var_codes)."""
    names = []
    for param in info.params:
        width = _width(info.vars.get(param, BOTTOM))
        names += [f"v_{param}"] if width == 1 else [f"v_{param}_{index}" for index in range(width)]
    return names


class _Rewrite(ast.NodeTransformer):
    """One member's body inside the merged function."""

    def __init__(self, index, local, members, slots, packed, direct, pick):
        self.index, self.local, self.members = index, local, members
        self.slots, self.packed, self.direct, self.pick = slots, packed, direct, pick

    def rewrite(self, statements):
        module = ast.Module(body=[self.visit(statement) for statement in statements], type_ignores=[])
        return ast.unparse(ast.fix_missing_locations(module))

    def visit_Name(self, node):
        if node.id in self.local:
            node.id = f"m{self.index}_{node.id}"
        return node

    def visit_Return(self, node):
        self.generic_visit(node)
        if node.value is None:
            values = list(self.slots[self.index][2])
        elif isinstance(node.value, ast.Tuple) and self.slots[self.index][1] > 1:
            values = [ast.unparse(item) for item in node.value.elts]
        else:
            values = [ast.unparse(node.value)]
        if self.slots[self.index][1] == 0:
            values = []
        return ast.parse(f"return {self.packed(self.index, values)}").body[0]

    def visit_Call(self, node):
        self.generic_visit(node)
        callee = node.func.id if isinstance(node.func, ast.Name) else None
        if callee not in self.members:
            return node
        index = self.members[callee]
        args = [ast.unparse(arg) for arg in node.args[4:]]
        return ast.parse(self.pick(index, self.direct(index, args)), mode="eval").body


@functools.cache
def _heap_key():
    """Changes whenever this module or the lifter's runtime changes."""
    return hashlib.sha256(Path(__file__).read_bytes() + Path(_escape.__file__).read_bytes() + Path(_scalar.__file__).read_bytes() + _runtime_key().encode()).hexdigest()


def _cached_module(source):
    """The generated ``source`` as a module file in the cache directory, compiled with
    Numba's disk cache, so a later process loads the machine code instead of compiling.
    The file is named after a hash of the source, which holds every constant the code
    uses. None if caching is off or the file cannot be used."""
    folder = _cache_dir()
    if folder is None:
        return None
    cached = source.replace('@njit(error_model="numpy"', '@njit(cache=True, error_model="numpy"')
    # The "rc_" prefix marks the functions as RecomPyler's for reference-count removal.
    stem = "rc_heap_" + hashlib.sha256((_heap_key() + cached).encode()).hexdigest()[:24]
    path = folder / f"{stem}.py"
    try:
        _write_once(path, cached)
        spec = importlib.util.spec_from_file_location(stem, path)
        module = importlib.util.module_from_spec(spec)
        # Numba's cache and recursive calls both find the module by name.
        sys.modules[stem] = module
        spec.loader.exec_module(module)
    except Exception:
        sys.modules.pop(stem, None)
        return None
    return module
_ARITHMETIC = {ast.Add: ("+", "add_i"), ast.Sub: ("-", "sub_i"), ast.Mult: ("*", "mul_i")}
_OPERATOR_METHODS = {ast.Add: "__add__", ast.Sub: "__sub__", ast.Mult: "__mul__", ast.Div: "__truediv__"}
_BITWISE = {ast.BitAnd: "&", ast.BitOr: "|", ast.BitXor: "^"}
_COMPARISONS = {ast.Lt: "<", ast.LtE: "<=", ast.Gt: ">", ast.GtE: ">=", ast.Eq: "==", ast.NotEq: "!="}

_RUNTIME = '''import math

import numpy as np
from numba import njit


@njit(error_model="numpy", inline="always")
def alloc(I, top, st, slots):
    start = top[0]
    if start + slots > len(I):
        st[0] = 2
        return 0
    top[0] = start + slots
    return start


@njit(error_model="numpy", inline="always")
def list_new(I, top, st, length, capacity):
    data = alloc(I, top, st, capacity)
    h = alloc(I, top, st, 3)
    if st[0]:
        return 0
    I[h] = length
    I[h + 1] = capacity
    I[h + 2] = data
    return h


@njit(error_model="numpy", inline="always")
def list_fill(I, top, st, count, value):
    size = count if count > 0 else 0
    h = list_new(I, top, st, size, size)
    if st[0]:
        return 0
    data = I[h + 2]
    for k in range(size):
        I[data + k] = value
    return h


@njit(error_model="numpy", inline="always")
def list_fill_f(F, I, top, st, count, value):
    size = count if count > 0 else 0
    h = list_new(I, top, st, size, size)
    if st[0]:
        return 0
    data = I[h + 2]
    for k in range(size):
        F[data + k] = value
    return h


@njit(error_model="numpy", inline="always")
def list_room(I, top, st, h):
    length = I[h]
    if length == I[h + 1]:
        bigger = 4 if length == 0 else length * 2
        data = alloc(I, top, st, bigger)
        if st[0]:
            return 0
        old = I[h + 2]
        for k in range(length):
            I[data + k] = I[old + k]
        I[h + 1] = bigger
        I[h + 2] = data
    I[h] = length + 1
    return I[h + 2] + length


@njit(error_model="numpy", inline="always")
def list_slice(I, top, st, h, low, high, has_low, has_high):
    size = I[h]
    if not has_low:
        low = 0
    elif low < 0:
        low = low + size if low + size > 0 else 0
    elif low > size:
        low = size
    if not has_high:
        high = size
    elif high < 0:
        high = high + size if high + size > 0 else 0
    elif high > size:
        high = size
    count = high - low if high > low else 0
    out = list_new(I, top, st, count, count)
    if st[0]:
        return 0
    source, target = I[h + 2] + low, I[out + 2]
    for k in range(count):
        I[target + k] = I[source + k]
    return out


@njit(error_model="numpy", inline="always")
def add_i(st, a, b):
    r = a + b
    if ((a ^ r) & (b ^ r)) < 0:
        st[0] = 1
    return r


@njit(error_model="numpy", inline="always")
def sub_i(st, a, b):
    r = a - b
    if ((a ^ b) & (a ^ r)) < 0:
        st[0] = 1
    return r


@njit(error_model="numpy", inline="always")
def mul_i(st, a, b):
    estimate = float(a) * float(b)
    if estimate >= 9.2e18 or estimate <= -9.2e18:
        st[0] = 1
        return 0
    return a * b


@njit(error_model="numpy", inline="always")
def floordiv_i(st, a, b):
    if b == 0 or (b == -1 and a == -a and a != 0):
        st[0] = 1
        return 0
    return a // b


@njit(error_model="numpy", inline="always")
def mod_i(st, a, b):
    if b == 0 or b == -1:
        if b == 0:
            st[0] = 1
        return 0
    return a % b


'''

# Strings, dicts and sets (see StrT, DictT and SetT).
_RUNTIME += '''
@njit(error_model="numpy", inline="always")
def str_new(I, top, st, n):
    h = alloc(I, top, st, n + 2)
    if st[0]:
        return 0
    I[h] = n
    I[h + 1] = 0
    return h


@njit(error_model="numpy", inline="always")
def str_hash(I, h):
    v = I[h + 1]
    if v != 0:
        return v
    v = np.int64(-3750763034362895579)
    for k in range(I[h]):
        v = (v ^ I[h + 2 + k]) * np.int64(1099511628211)
    if v == 0:
        v = np.int64(1)
    I[h + 1] = v
    return v


@njit(error_model="numpy", inline="always")
def str_eq(I, a, b):
    if a == b:
        return True
    if a < 0 or b < 0:
        return False
    n = I[a]
    if n != I[b]:
        return False
    if I[a + 1] != 0 and I[b + 1] != 0 and I[a + 1] != I[b + 1]:
        return False
    for k in range(n):
        if I[a + 2 + k] != I[b + 2 + k]:
            return False
    return True


@njit(error_model="numpy", inline="always")
def str_cmp(I, a, b):
    n, m = I[a], I[b]
    size = n if n < m else m
    for k in range(size):
        x, y = I[a + 2 + k], I[b + 2 + k]
        if x != y:
            return -1 if x < y else 1
    if n == m:
        return 0
    return -1 if n < m else 1


@njit(error_model="numpy", inline="always")
def str_concat(I, top, st, a, b):
    n, m = I[a], I[b]
    h = str_new(I, top, st, n + m)
    if st[0]:
        return 0
    for k in range(n):
        I[h + 2 + k] = I[a + 2 + k]
    for k in range(m):
        I[h + 2 + n + k] = I[b + 2 + k]
    return h


@njit(error_model="numpy", inline="always")
def str_slice(I, top, st, h, low, high, has_low, has_high):
    size = I[h]
    if not has_low:
        low = 0
    elif low < 0:
        low = low + size if low + size > 0 else 0
    elif low > size:
        low = size
    if not has_high:
        high = size
    elif high < 0:
        high = high + size if high + size > 0 else 0
    elif high > size:
        high = size
    count = high - low if high > low else 0
    out = str_new(I, top, st, count)
    if st[0]:
        return 0
    for k in range(count):
        I[out + 2 + k] = I[h + 2 + low + k]
    return out


@njit(error_model="numpy", inline="always")
def str_char(I, top, st, cp):
    out = str_new(I, top, st, 1)
    if st[0]:
        return 0
    I[out + 2] = cp
    return out


@njit(error_model="numpy", inline="always")
def str_find(I, h, sub, start):
    n, m = I[h], I[sub]
    for k in range(start, n - m + 1):
        same = True
        for j in range(m):
            if I[h + 2 + k + j] != I[sub + 2 + j]:
                same = False
                break
        if same:
            return k
    return -1


@njit(error_model="numpy", inline="always")
def str_starts(I, h, part, at):
    m = I[part]
    if at < 0 or at + m > I[h]:
        return False
    for j in range(m):
        if I[h + 2 + at + j] != I[part + 2 + j]:
            return False
    return True


@njit(error_model="numpy", inline="always")
def str_from_int(I, top, st, v):
    # Digits of the value made negative, so the smallest int needs no special case.
    m = v if v < 0 else -v
    count = 1
    t = m // -10
    while t != 0:
        count += 1
        t = t // 10
    size = count + (1 if v < 0 else 0)
    out = str_new(I, top, st, size)
    if st[0]:
        return 0
    if v < 0:
        I[out + 2] = 45
    for k in range(count):
        q = m // -10
        I[out + 1 + size - k] = 48 - (m + q * 10)
        m = -q
    return out


@njit(error_model="numpy", inline="always")
def str_join(I, top, st, sep, items):
    count = I[items]
    data = I[items + 2]
    size = 0
    for k in range(count):
        size += I[I[data + k]]
    if count > 1:
        size += I[sep] * (count - 1)
    out = str_new(I, top, st, size)
    if st[0]:
        return 0
    at = out + 2
    for k in range(count):
        if k:
            for j in range(I[sep]):
                I[at + j] = I[sep + 2 + j]
            at += I[sep]
        part = I[data + k]
        for j in range(I[part]):
            I[at + j] = I[part + 2 + j]
        at += I[part]
    return out


@njit(error_model="numpy", inline="always")
def str_space(cp):
    # Whitespace as str.isspace() has it, for code points below 128; -1 above.
    if cp >= 128:
        return -1
    return 1 if cp == 32 or 9 <= cp <= 13 or 28 <= cp <= 31 else 0


@njit(error_model="numpy", inline="always")
def str_strip(I, top, st, h, left, right):
    low, high = 0, I[h]
    while left and low < high:
        space = str_space(I[h + 2 + low])
        if space < 0:
            st[0] = 1
            return 0
        if space == 0:
            break
        low += 1
    while right and high > low:
        space = str_space(I[h + 1 + high])
        if space < 0:
            st[0] = 1
            return 0
        if space == 0:
            break
        high -= 1
    return str_slice(I, top, st, h, low, high, True, True)


@njit(error_model="numpy", inline="always")
def str_case(I, top, st, h, upper):
    n = I[h]
    out = str_new(I, top, st, n)
    if st[0]:
        return 0
    for k in range(n):
        cp = I[h + 2 + k]
        if cp >= 128:
            st[0] = 1
            return 0
        if upper and 97 <= cp <= 122:
            cp -= 32
        elif not upper and 65 <= cp <= 90:
            cp += 32
        I[out + 2 + k] = cp
    return out


@njit(error_model="numpy", inline="always")
def str_split(I, top, st, h, sep):
    # sep < 0: runs of whitespace, as str.split() with no argument.
    out = list_new(I, top, st, 0, 0)
    if st[0]:
        return 0
    n = I[h]
    if sep < 0:
        k = 0
        while True:
            while k < n:
                space = str_space(I[h + 2 + k])
                if space < 0:
                    st[0] = 1
                    return 0
                if space == 0:
                    break
                k += 1
            if k >= n:
                return out
            start = k
            while k < n:
                space = str_space(I[h + 2 + k])
                if space < 0:
                    st[0] = 1
                    return 0
                if space == 1:
                    break
                k += 1
            part = str_slice(I, top, st, h, start, k, True, True)
            at = list_room(I, top, st, out)
            if st[0]:
                return 0
            I[at] = part
    m = I[sep]
    if m == 0:
        st[0] = 1
        return 0
    start = 0
    while True:
        found = str_find(I, h, sep, start)
        end = found if found >= 0 else n
        part = str_slice(I, top, st, h, start, end, True, True)
        at = list_room(I, top, st, out)
        if st[0]:
            return 0
        I[at] = part
        if found < 0:
            return out
        start = found + m


@njit(error_model="numpy", inline="always")
def str_count(I, h, sub):
    n, m = I[h], I[sub]
    if m == 0:
        return n + 1
    count, k = 0, 0
    while True:
        found = str_find(I, h, sub, k)
        if found < 0:
            return count
        count += 1
        k = found + m


@njit(error_model="numpy", inline="always")
def str_replace(I, top, st, h, old, new):
    n, m, r = I[h], I[old], I[new]
    if m == 0:
        st[0] = 1
        return 0
    count = str_count(I, h, old)
    out = str_new(I, top, st, n + count * (r - m))
    if st[0]:
        return 0
    k, at = 0, out + 2
    while True:
        found = str_find(I, h, old, k)
        end = found if found >= 0 else n
        for j in range(k, end):
            I[at] = I[h + 2 + j]
            at += 1
        if found < 0:
            return out
        for j in range(r):
            I[at] = I[new + 2 + j]
            at += 1
        k = found + m


@njit(error_model="numpy", inline="always")
def str_repeat(I, top, st, h, count):
    n = I[h]
    if count < 0:
        count = 0
    if n * count > 1 << 40:
        st[0] = 1
        return 0
    out = str_new(I, top, st, n * count)
    if st[0]:
        return 0
    for c in range(count):
        for k in range(n):
            I[out + 2 + c * n + k] = I[h + 2 + k]
    return out


@njit(error_model="numpy", inline="always")
def mix_i(x):
    x = (x ^ (x >> 31)) * np.int64(-7046029254386353131)
    return x ^ (x >> 29)


@njit(error_model="numpy", inline="always")
def mix_t(acc, x):
    return (acc ^ x) * np.int64(1000003) + np.int64(97531)


@njit(error_model="numpy", inline="always")
def dict_new(I, top, st, stride, made):
    h = alloc(I, top, st, 9)
    if st[0]:
        return 0
    I[h] = 0
    I[h + 1] = 0
    I[h + 2] = 0
    I[h + 3] = 0
    I[h + 4] = 0
    I[h + 5] = 0
    I[h + 6] = stride
    I[h + 7] = -1
    I[h + 8] = made
    return h


@njit(error_model="numpy", inline="always")
def set_log(I, top, st, h, op, key):
    log = I[h + 7]
    if log < 0:
        log = list_new(I, top, st, 0, 0)
        if st[0]:
            return
        I[h + 7] = log
    at = list_room(I, top, st, log)
    if st[0]:
        return
    I[at] = op
    at = list_room(I, top, st, log)
    if st[0]:
        return
    I[at] = key


@njit(error_model="numpy", inline="always")
def set_pristine(I, h):
    return I[h + 8] == 0 and (I[h + 7] < 0 or I[I[h + 7]] == 0)


@njit(error_model="numpy", inline="always")
def dict_copy(I, top, st, h, made):
    out = alloc(I, top, st, 9)
    if st[0]:
        return 0
    stride = I[h + 6]
    alive = I[h]
    cap = alive if alive > 0 else 1
    entries = alloc(I, top, st, cap * stride)
    if st[0]:
        return 0
    old, m = I[h + 3], 0
    for e in range(I[h + 1]):
        at = old + e * stride
        if I[at + 2] == 0:
            continue
        for k in range(stride):
            I[entries + m * stride + k] = I[at + k]
        m += 1
    I[out] = alive
    I[out + 1] = alive
    I[out + 2] = cap
    I[out + 3] = entries
    I[out + 4] = 0
    I[out + 5] = 0
    I[out + 6] = stride
    I[out + 7] = -1
    I[out + 8] = made
    return out


@njit(error_model="numpy", inline="always")
def dict_clear(I, h):
    I[h] = 0
    I[h + 1] = 0
    I[h + 4] = 0
'''

# The dict and set operations for one kind of key: KEY is the tag, HASH(x) and EQ(a, b)
# expressions over the one-slot keys x, a and b.
_DICT_TEMPLATE = '''
@njit(error_model="numpy", inline="always")
def dict_rebuild_KEY(F, I, top, st, h, room):
    alive, stride, old, n = I[h], I[h + 6], I[h + 3], I[h + 1]
    fresh = I[h + 4] == 0
    cap = alive * 2 if alive * 2 > room else room
    if cap < 8:
        cap = 8
    tsize = 8
    while tsize * 2 < cap * 3:
        tsize *= 2
    entries = alloc(I, top, st, cap * stride)
    table = alloc(I, top, st, tsize)
    if st[0]:
        return
    mask = tsize - 1
    for k in range(tsize):
        I[table + k] = -1
    m = 0
    for e in range(n):
        at = old + e * stride
        if I[at + 2] == 0:
            continue
        to = entries + m * stride
        for k in range(stride):
            I[to + k] = I[at + k]
        if fresh:
            x = I[to + 1]
            I[to] = HASH
        i = I[to] & mask
        while I[table + i] >= 0:
            i = (i + 1) & mask
        I[table + i] = m
        m += 1
    I[h + 1] = m
    I[h + 2] = cap
    I[h + 3] = entries
    I[h + 4] = tsize
    I[h + 5] = table


@njit(error_model="numpy", inline="always")
def dict_find_KEY(F, I, top, st, h, key):
    if I[h + 4] == 0:
        dict_rebuild_KEY(F, I, top, st, h, 0)
        if st[0]:
            return -1
    x = key
    hv = HASH
    mask, table, entries, stride = I[h + 4] - 1, I[h + 5], I[h + 3], I[h + 6]
    i = hv & mask
    while True:
        e = I[table + i]
        if e < 0:
            return -1
        at = entries + e * stride
        if I[at + 2] != 0 and I[at] == hv:
            a = I[at + 1]
            b = key
            if EQ:
                return at
        i = (i + 1) & mask


@njit(error_model="numpy", inline="always")
def dict_put_KEY(F, I, top, st, h, key):
    at = dict_find_KEY(F, I, top, st, h, key)
    if st[0]:
        return 0, False
    if at >= 0:
        return at, False
    n = I[h + 1]
    if n == I[h + 2] or (n + 1) * 3 > I[h + 4] * 2:
        dict_rebuild_KEY(F, I, top, st, h, I[h] + 1)
        if st[0]:
            return 0, False
        n = I[h + 1]
    x = key
    hv = HASH
    stride = I[h + 6]
    at = I[h + 3] + n * stride
    I[at] = hv
    I[at + 1] = key
    I[at + 2] = 1
    mask, table = I[h + 4] - 1, I[h + 5]
    i = hv & mask
    while I[table + i] >= 0:
        i = (i + 1) & mask
    I[table + i] = n
    I[h + 1] = n + 1
    I[h] += 1
    return at, True


@njit(error_model="numpy", inline="always")
def dict_del_KEY(F, I, top, st, h, key):
    at = dict_find_KEY(F, I, top, st, h, key)
    if at >= 0:
        I[at + 2] = 0
        I[h] -= 1
    return at
'''


def _key_tag(kind):
    """A name for the way keys of ``kind`` hash and compare, or None if they cannot be
    dict keys in a region."""
    if kind in (INT, BOOL):
        return "i"
    if isinstance(kind, ObjT) and not kind.nullable:
        if any("__eq__" in vars(klass) or "__hash__" in vars(klass) for cls in kind.classes
               for klass in cls.__mro__[:-1]):
            return None
        return "i"
    if isinstance(kind, StrT) and not kind.nullable:
        return "s"
    if isinstance(kind, TupT) and not kind.nullable and kind.items:
        parts = [_key_tag(item) for item in kind.items]
        if None in parts:
            return None
        return "t" + "".join(parts) + "e"
    return None


def _hash_code(kind, code):
    if kind in (INT, BOOL) or isinstance(kind, ObjT):
        return f"mix_i({code})"
    if isinstance(kind, StrT):
        return f"str_hash(I, {code})"
    acc, at = "np.int64(3430008)", 0
    for item in kind.items:
        acc = f"mix_t({acc}, {_hash_code(item, f'I[{code} + {at}]')})"
        at += _slots(item)
    return acc


def _eq_code(kind, a, b):
    if kind in (INT, BOOL) or isinstance(kind, ObjT):
        return f"({a} == {b})"
    if isinstance(kind, StrT):
        return f"str_eq(I, {a}, {b})"
    parts, at = [], 0
    for item in kind.items:
        parts.append(_eq_code(item, f"I[{a} + {at}]", f"I[{b} + {at}]"))
        at += _slots(item)
    return "(" + " and ".join(parts) + ")"


def _dict_helpers(kind, tag):
    return (_DICT_TEMPLATE.replace("KEY", tag).replace("HASH", _hash_code(kind, "x"))
            .replace("EQ", _eq_code(kind, "a", "b")))


class _CellView:
    """A closure cell seen as a namespace of one name, so its contents load and are
    guarded like a module global's."""

    def __init__(self, cell, name):
        self.cell, self.name = cell, name

    def get(self, name, default=None):
        try:
            return self.cell.cell_contents if name == self.name else default
        except ValueError:
            return default


_VARARGS = 0x04


def _signature_names(fn):
    """The parameter names in compiled order: positional, keyword-only, then *args."""
    code = fn.__code__
    names = list(code.co_varnames[:code.co_argcount + code.co_kwonlyargcount])
    if code.co_flags & _VARARGS:
        names.append(code.co_varnames[len(names)])
    return names


class _ContainerGen:
    """Strings, dicts, sets, constants and calling conventions, for _Gen."""

    # Constants

    def str_constant(self, value):
        """A str constant: loaded into its own fixed slot before each call, as an
        object held by a module global is."""
        holder = self.program.__dict__.setdefault("str_constants", {})
        value = holder.setdefault(value, value)
        _, codes = self.program.global_value(holder, value, value, key=("str", value))
        return StrT(), codes

    def value_constant(self, value, node):
        """(type, codes) for a number, None, str, or tuple of these; None for others."""
        if type(value) in (int, float, bool) or value is None:
            return self.constant(value, node)
        if type(value) is str:
            return self.str_constant(value)
        if type(value) is tuple:
            parts = [self.value_constant(item, node) for item in value]
            if any(part is None for part in parts):
                return None
            return TupT(kind for kind, _ in parts), [code for _, codes in parts for code in codes]
        return None

    def cells(self):
        fn = self.info.fn
        return dict(zip(fn.__code__.co_freevars, fn.__closure__ or ()))

    def cell_view(self, name):
        cell = self.cells()[name]
        views = self.program.__dict__.setdefault("cell_views", {})
        view = views.get(id(cell))
        if view is None:
            view = views[id(cell)] = _CellView(cell, name)
        return view

    def cell_name(self, node):
        """A free variable of a closure: its cell's contents, read only, guarded like a
        module global. None if ``node`` is not one."""
        if node.id in self.info.locals or node.id not in self.cells():
            return None
        view = self.cell_view(node.id)
        try:
            value = view.cell.cell_contents
        except ValueError:
            self.unsupported(f"free variable '{node.id}' before it is set", node)
        if type(value) in (int, float, bool, str, tuple) or value is None:
            made = self.value_constant(value, node)
            if made is not None:
                self.program.guard("const", view, node.id, value)
                return made
        if type(value) in (list, dict, set) or (
                not isinstance(value, (type, FunctionType, pytypes.ModuleType, pytypes.BuiltinFunctionType))
                and type(value).__module__ != "builtins" and _record_problem(type(value)) is None):
            return self.program.global_value(view, node.id, value, key=("cell", id(view.cell)))
        self.unsupported(f"free variable '{node.id}' that holds {type(value).__name__}", node)

    def global_constant(self, node, value):
        """A module global that holds a str or a tuple of constants, or None."""
        if type(value) not in (str, tuple):
            return None
        made = self.value_constant(value, node)
        if made is not None:
            self.program.guard("const", self.namespace, node.id, value)
        return made

    # Handles

    def present_handle(self, kind, codes):
        """The handle of a str, dict or set that Python would use: None raises."""
        if kind == NONE:
            self.fail("True")
            return "0"
        if kind.nullable:
            self.fail(f"{codes[0]} < 0")
        return codes[0]

    def box(self, kind, codes):
        """One slot for a key: an int or bool itself, a tuple as a new block."""
        if kind == BOOL:
            return f"(1 if {codes[0]} else 0)"
        if isinstance(kind, TupT):
            size = max(1, sum(map(_slots, kind.items)))
            block = self.temp(f"alloc(I, top, st, {size})")
            self.check()
            at = position = 0
            for item in kind.items:
                width = _width(item)
                self.store(item, f"{block} + {at}", codes[position:position + width])
                at += _slots(item)
                position += width
            return block
        return codes[0]

    def key_tag(self, kind, node):
        """The helpers' tag for dict or set keys of ``kind``, registering the helpers."""
        tag = _key_tag(kind)
        if tag is None:
            self.unsupported(f"dict or set keys that are {_describe(kind)}", node)
        helpers = self.program.__dict__.setdefault("helpers", {})
        if f"dict_{tag}" not in helpers:
            helpers[f"dict_{tag}"] = _dict_helpers(kind, tag)
        return tag

    def keyed(self, kind, key, node):
        """(tag, boxed key code) for a lookup of ``key`` in a dict or set of ``kind``,
        widening its key type to take it."""
        cell = kind.kcell if isinstance(kind, DictT) else kind.cell
        self.program.widen_cell(cell, key[0])
        found = _find(cell).elem
        if found == BOTTOM:
            raise _Pending
        tag = self.key_tag(found, node)
        return tag, self.box(found, self.coerce(key[0], key[1], found))

    def stride(self, kind):
        return 3 + (_slots(kind.value) if isinstance(kind, DictT) else 0)

    # Strings

    def to_str(self, kind, codes, node):
        """``str(value)`` for a str, int, bool or None."""
        if isinstance(kind, StrT):
            if kind.nullable:
                none = self.str_constant("None")[1][0]
                return self.temp(f"{codes[0]} if {codes[0]} >= 0 else {none}")
            return codes[0]
        if kind == INT:
            made = self.temp(f"str_from_int(I, top, st, {codes[0]})")
            self.check()
            return made
        if kind == BOOL:
            yes, no = self.str_constant("True")[1][0], self.str_constant("False")[1][0]
            return self.temp(f"{yes} if {codes[0]} else {no}")
        if kind == NONE:
            return self.str_constant("None")[1][0]
        self.unsupported(f"str() of {_describe(kind)}", node)

    def expr_JoinedStr(self, node):
        pieces = []
        for part in node.values:
            if isinstance(part, ast.Constant) and type(part.value) is str:
                pieces.append(self.str_constant(part.value)[1][0])
                continue
            if not isinstance(part, ast.FormattedValue) or part.format_spec is not None or part.conversion not in (
                    -1, ord("s")):
                self.unsupported("an f-string field with a format or conversion", node)
            kind, codes = self.expr(part.value)
            if kind == BOTTOM:
                return BOTTOM, ["0"]
            pieces.append(self.temp(self.to_str(kind, codes, part)))
        if not pieces:
            return self.str_constant("")
        made = pieces[0]
        for piece in pieces[1:]:
            made = self.temp(f"str_concat(I, top, st, {made}, {piece})")
            self.check()
        return StrT(), [made]

    def str_subscript(self, codes, node):
        handle = self.temp(codes[0])
        if isinstance(node.slice, ast.Slice):
            if node.slice.step is not None:
                self.unsupported("a str slice with a step", node)
            bounds = []
            for part in (node.slice.lower, node.slice.upper):
                if part is None:
                    bounds.append(None)
                    continue
                part_kind, part_codes = self.expr(part)
                if part_kind not in (INT, BOOL, BOTTOM):
                    self.unsupported(f"a slice bound that is {_describe(part_kind)}", node)
                bounds.append(self.as_int(part_kind, part_codes))
            low, high = bounds
            made = self.temp(f"str_slice(I, top, st, {handle}, {low or 0}, {high or 0}, "
                             f"{low is not None}, {high is not None})")
            self.check()
            return StrT(), [made]
        pk, pc = self.expr(node.slice)
        if pk not in (INT, BOOL):
            self.unsupported(f"a str index that is {_describe(pk)}", node)
        size = self.temp(f"I[{handle}]")
        at = self.temp(self.as_int(pk, pc))
        self.emit(f"if {at} < 0:")
        self.emit(f"    {at} += {size}")
        self.fail(f"{at} < 0 or {at} >= {size}")
        made = self.temp(f"str_char(I, top, st, I[{handle} + 2 + {at}])")
        self.check()
        return StrT(), [made]

    def str_method(self, handle, name, args, node):
        def text(position):
            kind, codes = args[position]
            if not isinstance(kind, StrT):
                self.unsupported(f"str.{name}() of {_describe(kind)}", node)
            return self.present_handle(kind, codes)

        if name in ("startswith", "endswith") and len(args) == 1:
            part = self.temp(text(0))
            at = "0" if name == "startswith" else f"I[{handle}] - I[{part}]"
            return BOOL, [self.temp(f"str_starts(I, {handle}, {part}, {at})")]
        if name == "find" and len(args) == 1:
            return INT, [self.temp(f"str_find(I, {handle}, {text(0)}, 0)")]
        if name in ("strip", "lstrip", "rstrip") and not args:
            made = self.temp(f"str_strip(I, top, st, {handle}, {name != 'rstrip'}, {name != 'lstrip'})")
            self.check()
            return StrT(), [made]
        if name in ("lower", "upper") and not args:
            made = self.temp(f"str_case(I, top, st, {handle}, {name == 'upper'})")
            self.check()
            return StrT(), [made]
        if name == "split" and len(args) <= 1:
            sep = text(0) if args else "-1"
            made = self.temp(f"str_split(I, top, st, {handle}, {sep})")
            self.check()
            made_kind = ListT()
            made_kind.cell.elem = StrT()
            return made_kind, [made]
        if name == "count" and len(args) == 1:
            return INT, [self.temp(f"str_count(I, {handle}, {text(0)})")]
        if name == "replace" and len(args) == 2:
            old, new = self.temp(text(0)), self.temp(text(1))
            made = self.temp(f"str_replace(I, top, st, {handle}, {old}, {new})")
            self.check()
            return StrT(), [made]
        if name == "join" and len(args) == 1:
            kind, codes = args[0]
            if not (type(kind) is ListT and (isinstance(kind.elem, StrT) or kind.elem == BOTTOM)):
                self.unsupported(f"str.join() of {_describe(kind)}", node)
            if isinstance(kind.elem, StrT) and kind.elem.nullable:
                self.unsupported("str.join() of strings that may be None", node)
            made = self.temp(f"str_join(I, top, st, {handle}, {codes[0]})")
            self.check()
            return StrT(), [made]
        self.unsupported(f"str method '{name}'", node)

    # Dicts and sets

    def expr_Dict(self, node):
        if any(key is None for key in node.keys):
            self.unsupported("** in a dict display", node)
        items = [(self.expr(key), self.expr(value)) for key, value in zip(node.keys, node.values)]
        made = DictT()
        for (kk, _), (vk, _) in items:
            # A new dict starts with its own types; that is not a change to anything.
            made.kcell.elem = self.program.join(made.kcell.elem, kk)
            made.vcell.elem = self.program.join(made.vcell.elem, vk)
        self.check_item(made.value, node)
        self.check_item(made.key, node)
        handle = self.temp(f"dict_new(I, top, st, {self.stride(made)}, 1)")
        self.check()
        for key, (vk, vc) in items:
            self.dict_store(made, handle, key, (vk, vc), node)
        return made, [handle]

    def dict_store(self, kind, handle, key, value, node):
        """``d[key] = value``, after both are worked out."""
        cell = _find(kind.vcell)
        self.program.widen_cell(cell, value[0])
        cell.mutated = True
        _find(kind.kcell).mutated = True
        tag, boxed = self.keyed(kind, key, node)
        self.counter += 1
        at = f"t{self.counter}"
        self.emit(f"{at}, {at}_new = dict_put_{tag}(F, I, top, st, {handle}, {boxed})")
        self.check()
        self.store(cell.elem, f"{at} + 3", self.coerce(value[0], value[1], cell.elem))
        return at

    def dict_find(self, kind, handle, key, node):
        """A temp holding the slot of ``key``'s entry, or -1."""
        tag, boxed = self.keyed(kind, key, node)
        at = self.temp(f"dict_find_{tag}(F, I, top, st, {handle}, {boxed})")
        self.check()
        return at

    def dict_subscript(self, kind, codes, node):
        if isinstance(node.slice, ast.Slice):
            self.unsupported("a slice of a dict", node)
        handle = self.temp(self.present_handle(kind, codes))
        key = self.expr(node.slice)
        if key[0] == BOTTOM:
            return BOTTOM, ["0"]
        at = self.dict_find(kind, handle, key, node)
        # A missing key raises KeyError.
        self.fail(f"{at} < 0")
        elem = kind.value
        if elem == BOTTOM:
            return BOTTOM, ["0"]
        return elem, [self.temp(code) for code in self.slot(elem, f"{at} + 3")]

    def dict_method(self, kind, handle, name, args, node):
        elem = kind.value
        if name == "get" and len(args) in (1, 2):
            default = args[1] if len(args) == 2 else (NONE, ["-1"])
            joined = self.program.join(elem, default[0])
            if joined == BOTTOM:
                return BOTTOM, ["0"]
            at = self.dict_find(kind, handle, args[0], node)
            self.counter += 1
            names = [f"t{self.counter}_{index}" for index in range(_width(joined))]
            self.emit(f"if {at} >= 0:")
            self.depth += 1
            found = self.slot(elem, f"{at} + 3") if elem != BOTTOM else _dummy(joined)
            for target, code in zip(names, self.coerce(elem, found, joined)):
                self.emit(f"{target} = {code}")
            self.depth -= 1
            self.emit("else:")
            self.depth += 1
            for target, code in zip(names, self.coerce(default[0], default[1], joined)):
                self.emit(f"{target} = {code}")
            self.depth -= 1
            return joined, names
        if name == "setdefault" and len(args) in (1, 2):
            default = args[1] if len(args) == 2 else (NONE, ["-1"])
            cell = _find(kind.vcell)
            self.program.widen_cell(cell, default[0])
            cell.mutated = True
            _find(kind.kcell).mutated = True
            elem = cell.elem
            tag, boxed = self.keyed(kind, args[0], node)
            self.counter += 1
            at = f"t{self.counter}"
            self.emit(f"{at}, {at}_new = dict_put_{tag}(F, I, top, st, {handle}, {boxed})")
            self.check()
            self.emit(f"if {at}_new:")
            self.depth += 1
            self.store(elem, f"{at} + 3", self.coerce(default[0], default[1], elem))
            self.depth -= 1
            return elem, [self.temp(code) for code in self.slot(elem, f"{at} + 3")]
        if name == "pop" and len(args) in (1, 2):
            _find(kind.vcell).mutated = _find(kind.kcell).mutated = True
            tag, boxed = self.keyed(kind, args[0], node)
            at = self.temp(f"dict_del_{tag}(F, I, top, st, {handle}, {boxed})")
            self.check()
            if len(args) == 1:
                self.fail(f"{at} < 0")
                if elem == BOTTOM:
                    return BOTTOM, ["0"]
                return elem, [self.temp(code) for code in self.slot(elem, f"{at} + 3")]
            default = args[1]
            joined = self.program.join(elem, default[0])
            self.counter += 1
            names = [f"t{self.counter}_{index}" for index in range(_width(joined))]
            self.emit(f"if {at} >= 0:")
            self.depth += 1
            found = self.slot(elem, f"{at} + 3") if elem != BOTTOM else _dummy(joined)
            for target, code in zip(names, self.coerce(elem, found, joined)):
                self.emit(f"{target} = {code}")
            self.depth -= 1
            self.emit("else:")
            self.depth += 1
            for target, code in zip(names, self.coerce(default[0], default[1], joined)):
                self.emit(f"{target} = {code}")
            self.depth -= 1
            return joined, names
        if name == "clear" and not args:
            _find(kind.vcell).mutated = _find(kind.kcell).mutated = True
            self.emit(f"dict_clear(I, {handle})")
            return NONE, ["-1"]
        if name == "copy" and not args:
            made = self.temp(f"dict_copy(I, top, st, {handle}, 1)")
            self.check()
            return DictT(kind.kcell, kind.vcell), [made]
        if name == "update" and len(args) == 1 and isinstance(args[0][0], DictT):
            other_kind, other_codes = args[0]
            joined = self.program.join(DictT(kind.kcell, kind.vcell), DictT(other_kind.kcell, other_kind.vcell))
            other = self.temp(self.present_handle(other_kind, other_codes))
            self.dict_entries(joined, other, node, lambda key, value: self.dict_store(
                joined, handle, key, value, node), items=True)
            return NONE, ["-1"]
        self.unsupported(f"dict method '{name}'", node)

    def dict_entries(self, kind, handle, node, visit, items=False, check=True):
        """Call ``visit(key, value)`` inside a loop over the live entries of a dict or
        set, in order; a change in its size or entries stops the call, as Python
        raises RuntimeError."""
        size, used, position = self.temp(f"I[{handle}]"), self.temp(f"I[{handle} + 1]"), self.temp("0")
        self.emit("while True:")
        self.depth += 1
        if check:
            self.fail(f"I[{handle}] != {size} or I[{handle} + 1] != {used}")
        self.emit(f"if {position} >= {used}:")
        self.emit("    break")
        at = self.temp(f"I[{handle} + 3] + {position} * I[{handle} + 6]")
        self.emit(f"{position} += 1")
        self.emit(f"if I[{at} + 2] == 0:")
        self.emit("    continue")
        key_kind = kind.key if isinstance(kind, DictT) else kind.elem
        key = key_kind, [self.temp(code) for code in self.slot(key_kind, f"{at} + 1")]
        value = None
        if isinstance(kind, DictT) and items:
            value = kind.value, [self.temp(code) for code in self.slot(kind.value, f"{at} + 3")]
        visit(key, value)
        self.depth -= 1

    def expr_Set(self, node):
        items = [self.expr(item) for item in node.elts]
        made = SetT()
        for kind, _ in items:
            made.cell.elem = self.program.join(made.cell.elem, kind)
        self.check_item(made.elem, node)
        handle = self.temp("dict_new(I, top, st, 3, 1)")
        self.check()
        # Python fills a display of three or more constants from a frozenset.
        op = 3 if len(node.elts) >= 3 and all(isinstance(item, ast.Constant) for item in node.elts) else 1
        for item in items:
            self.set_add(made, handle, item, node, op)
        return made, [handle]

    def set_add(self, kind, handle, item, node, op=1):
        cell = _find(kind.cell)
        cell.mutated = True
        tag, boxed = self.keyed(kind, item, node)
        key = self.temp(boxed)
        self.counter += 1
        at = f"t{self.counter}"
        self.emit(f"{at}, {at}_new = dict_put_{tag}(F, I, top, st, {handle}, {key})")
        self.check()
        self.emit(f"if {at}_new:")
        self.emit(f"    set_log(I, top, st, {handle}, {op}, {key})")
        self.check()

    def set_method(self, kind, handle, name, args, node):
        if name == "add" and len(args) == 1:
            self.set_add(kind, handle, args[0], node)
            return NONE, ["-1"]
        if name in ("discard", "remove") and len(args) == 1:
            _find(kind.cell).mutated = True
            tag, boxed = self.keyed(kind, args[0], node)
            key = self.temp(boxed)
            at = self.temp(f"dict_del_{tag}(F, I, top, st, {handle}, {key})")
            self.check()
            if name == "remove":
                self.fail(f"{at} < 0")
            self.emit(f"if {at} >= 0:")
            self.emit(f"    set_log(I, top, st, {handle}, 0, {key})")
            self.check()
            return NONE, ["-1"]
        if name == "clear" and not args:
            _find(kind.cell).mutated = True
            self.emit(f"dict_clear(I, {handle})")
            self.emit(f"set_log(I, top, st, {handle}, 2, 0)")
            self.check()
            return NONE, ["-1"]
        if name == "update" and len(args) == 1 and type(args[0][0]) is ListT:
            self.set_fill(kind, handle, args[0], node)
            return NONE, ["-1"]
        self.unsupported(f"set method '{name}'", node)

    def set_fill(self, kind, handle, items, node):
        """Add every item of a list, in order."""
        list_kind, codes = items
        elem = list_kind.elem
        if elem == BOTTOM:
            return
        self.check_item(elem, node)
        held, position = self.temp(codes[0]), self.temp("0")
        self.emit("while True:")
        self.depth += 1
        self.emit(f"if {position} >= I[{held}]:")
        self.emit("    break")
        item = [self.temp(code) for code in self.slot(elem, f"I[{held} + 2] + {position}")]
        self.emit(f"{position} += 1")
        self.set_add(kind, handle, (elem, item), node)
        self.depth -= 1

    def contains(self, item, container, node, negate):
        """``item in container``."""
        (ik, ic), (ck, cc) = item, container
        if BOTTOM in (ik, ck):
            return "False"
        if isinstance(ck, StrT):
            if not isinstance(ik, StrT):
                self.unsupported(f"{_describe(ik)} in a str", node)
            found = f"(str_find(I, {self.present_handle(ck, cc)}, {self.present_handle(ik, ic)}, 0) >= 0)"
        elif isinstance(ck, (DictT, SetT)):
            handle = self.temp(self.present_handle(ck, cc))
            cell = ck.kcell if isinstance(ck, DictT) else ck.cell
            if _find(cell).elem == BOTTOM and ik != BOTTOM:
                # Nothing was ever put in: an empty dict or set.
                # Python still hashes the key. Unsupported hashing must fall back
                # even here, to preserve exceptions and user-defined __hash__.
                self.key_tag(ik, node)
                found = "False"
            else:
                found = f"({self.dict_find(ck, handle, item, node)} >= 0)"
        elif type(ck) is ListT:
            found = self.list_contains(ik, ic, ck, cc, node)
        else:
            self.unsupported(f"'in' on {_describe(ck)}", node)
        return f"(not {found})" if negate else found

    def list_contains(self, ik, ic, ck, cc, node, index=False):
        """Code for ``item in list``; with ``index``, a temp with the first position of
        an equal item, or -1."""
        elem = ck.elem
        if elem == BOTTOM:
            return "-1" if index else "False"
        self.check_item(elem, node)
        if ik in (INT, BOOL) and elem in (INT, BOOL):
            value = self.temp(self.as_int(ik, ic))

            def test(at):
                return f"{self.as_int(elem, self.slot(elem, at))} == {value}"
        elif ik == FLOAT and elem == FLOAT:
            value = self.temp(ic[0])
            # A NaN is found only as the same object, which a float in the heap is not.
            self.fail(f"{value} != {value}")

            def test(at):
                return f"F[{at}] == {value}"
        elif isinstance(ik, StrT) and isinstance(elem, StrT):
            value = self.temp(ic[0])

            def test(at):
                return f"str_eq(I, I[{at}], {value})"
        elif isinstance(ik, ObjT) and isinstance(elem, ObjT) or (ik == NONE and isinstance(elem, (ObjT, StrT))):
            for kind in (ik, elem):
                if isinstance(kind, ObjT) and any("__eq__" in vars(klass) for cls in kind.classes
                                                  for klass in cls.__mro__[:-1]):
                    self.unsupported(f"'in' on '{_describe(kind)}' objects that define ==", node)
            value = self.temp(ic[0])

            def test(at):
                return f"I[{at}] == {value}"
        else:
            self.unsupported(f"{_describe(ik)} in {_describe(ck)}", node)
        held, found = self.temp(cc[0]), self.temp("-1")
        self.counter += 1
        step = f"t{self.counter}"
        self.emit(f"for {step} in range(I[{held}]):")
        self.emit(f"    if {test(f'I[{held} + 2] + {step}')}:")
        self.emit(f"        {found} = {step}")
        self.emit("        break")
        return found if index else f"({found} >= 0)"

    def compare_containers(self, op, left, right, node):
        """Comparisons that involve a str, dict or set, and ``in``; None for others."""
        (lk, lc), (rk, rc) = left, right
        if op in (ast.In, ast.NotIn):
            return self.contains(left, right, node, op is ast.NotIn)
        if not (isinstance(lk, _HANDLES) or isinstance(rk, _HANDLES)):
            return None
        if op in (ast.Is, ast.IsNot):
            if isinstance(lk, StrT) or isinstance(rk, StrT):
                self.unsupported("'is' between strings", node)
            if lk == NONE or rk == NONE:
                return None
            return f"({lc[0]} {'==' if op is ast.Is else '!='} {rc[0]})"
        if isinstance(lk, StrT) and isinstance(rk, StrT):
            if op in (ast.Eq, ast.NotEq):
                test = f"str_eq(I, {lc[0]}, {rc[0]})"
                return test if op is ast.Eq else f"(not {test})"
            if op in _COMPARISONS:
                a, b = self.present_handle(lk, lc), self.present_handle(rk, rc)
                return f"(str_cmp(I, {a}, {b}) {_COMPARISONS[op]} 0)"
        if op in (ast.Eq, ast.NotEq) and NONE in (lk, rk):
            kind, codes = (rk, rc) if lk == NONE else (lk, lc)
            test = self.none_test(kind, codes)
            return test if op is ast.Eq else f"(not {test})"
        if op in (ast.Eq, ast.NotEq) and isinstance(lk, StrT) != isinstance(rk, StrT) and (
                lk in NUMBERS or rk in NUMBERS):
            # A str never equals a number.
            return "False" if op is ast.Eq else "True"
        self.unsupported(f"comparing {_describe(lk)} with {_describe(rk)}", node)

    def container_binop(self, op, left, right, node):
        (lk, lc), (rk, rc) = left, right
        if op is ast.Add and isinstance(lk, StrT) and isinstance(rk, StrT):
            a, b = self.present_handle(lk, lc), self.present_handle(rk, rc)
            made = self.temp(f"str_concat(I, top, st, {a}, {b})")
            self.check()
            return StrT(), [made]
        if op is ast.Mult and (isinstance(lk, StrT) and rk in (INT, BOOL) or isinstance(rk, StrT) and lk in (INT, BOOL)):
            (sk, sc), (nk, nc) = (left, right) if isinstance(lk, StrT) else (right, left)
            made = self.temp(f"str_repeat(I, top, st, {self.present_handle(sk, sc)}, {self.as_int(nk, nc)})")
            self.check()
            return StrT(), [made]
        self.unsupported(f"operator {op.__name__} on {_describe(lk)} and {_describe(rk)}", node)

    def container_truth(self, kind, codes):
        if kind.nullable:
            return self.temp(f"{codes[0]} >= 0 and I[{codes[0]}] != 0")
        return self.temp(f"I[{codes[0]}] != 0")

    def container_method(self, base, name, node):
        if node.keywords:
            self.unsupported("a keyword argument", node)
        kind, codes = base
        args = [self.expr(arg) for arg in node.args]
        if any(arg[0] == BOTTOM for arg in args):
            return BOTTOM, ["0"]
        handle = self.temp(self.present_handle(kind, codes))
        if isinstance(kind, StrT):
            return self.str_method(handle, name, args, node)
        if isinstance(kind, DictT):
            return self.dict_method(kind, handle, name, args, node)
        return self.set_method(kind, handle, name, args, node)

    def container_builtin(self, name, args, node):
        """len, str, ord, chr, dict and set on what this mixin adds; None for others."""
        kinds = [kind for kind, _ in args]
        if name == "len" and len(args) == 1 and isinstance(kinds[0], _HANDLES):
            return INT, [self.temp(f"I[{self.present_handle(*args[0])}]")]
        if name == "str" and len(args) == 1 and (isinstance(kinds[0], StrT) or kinds[0] in (INT, BOOL, NONE)):
            return StrT(), [self.to_str(kinds[0], args[0][1], node)]
        if name == "str" and not args:
            return self.str_constant("")
        if name == "ord" and len(args) == 1 and isinstance(kinds[0], StrT):
            handle = self.temp(self.present_handle(*args[0]))
            self.fail(f"I[{handle}] != 1")
            return INT, [self.temp(f"I[{handle} + 2]")]
        if name == "chr" and len(args) == 1 and kinds[0] in (INT, BOOL):
            value = self.temp(self.as_int(*args[0]))
            self.fail(f"{value} < 0 or {value} > 1114111")
            made = self.temp(f"str_char(I, top, st, {value})")
            self.check()
            return StrT(), [made]
        if name == "dict" and not args:
            made = DictT()
            handle = self.temp(f"dict_new(I, top, st, {self.stride(made)}, 1)")
            self.check()
            return made, [handle]
        if name == "dict" and len(args) == 1 and isinstance(kinds[0], DictT):
            made = self.temp(f"dict_copy(I, top, st, {self.present_handle(*args[0])}, 1)")
            self.check()
            return DictT(kinds[0].kcell, kinds[0].vcell), [made]
        if name == "set" and len(args) <= 1 and (not args or type(kinds[0]) is ListT):
            made = SetT()
            handle = self.temp("dict_new(I, top, st, 3, 1)")
            self.check()
            if args:
                made.cell.elem = kinds[0].elem
                self.set_fill(made, handle, args[0], node)
            return made, [handle]
        return None

    def container_loop(self, node, iterable):
        """A for loop over a str, dict, dict view or set. False if ``iterable`` is not one."""
        view = None
        if (isinstance(iterable, ast.Call) and isinstance(iterable.func, ast.Attribute)
                and iterable.func.attr in ("keys", "values", "items") and not iterable.args
                and not iterable.keywords):
            if isinstance(self.peek(iterable.func.value), DictT):
                view, iterable = iterable.func.attr, iterable.func.value
        if view is None and isinstance(self.peek(iterable), TupT):
            return self.tuple_loop(node, iterable)
        if view is None and not isinstance(self.peek(iterable), _HANDLES):
            return False
        kind, codes = self.expr(iterable)
        if not isinstance(kind, _HANDLES):
            return False
        handle = self.temp(self.present_handle(kind, codes))
        if isinstance(kind, StrT):
            position = self.temp("0")
            self.emit("while True:")
            self.depth += 1
            self.emit(f"if {position} >= I[{handle}]:")
            self.emit("    break")
            item = self.temp(f"str_char(I, top, st, I[{handle} + 2 + {position}])")
            self.check()
            self.emit(f"{position} += 1")
            self.bind(node.target, (StrT(), [item]), node)
            self.body(node.body)
            self.depth -= 1
            return True
        if isinstance(kind, SetT):
            # Only a set as Python made it has Python's order here.
            self.fail(f"not set_pristine(I, {handle})")
        if (kind.key if isinstance(kind, DictT) else kind.elem) == BOTTOM:
            # Nothing was ever put in: the loop never runs.
            return True

        def visit(key, value):
            if view == "values":
                self.bind(node.target, value, node)
            elif view == "items":
                self.bind(node.target, (TupT((key[0], value[0])), key[1] + value[1]), node)
            else:
                self.bind(node.target, key, node)
            self.body(node.body)

        self.dict_entries(kind, handle, node, visit, items=view in ("values", "items"))
        return True

    def more_list_method(self, kind, codes, cell, name, args, node):
        handle = self.temp(codes[0])
        elem = kind.elem
        if name in ("remove", "index", "count") and len(args) == 1:
            if name == "count":
                if elem == BOTTOM:
                    return INT, ["0"]
                total = self.temp("0")
                start = self.temp("0")
                self.emit("while True:")
                self.depth += 1
                rest = self.temp(f"list_slice(I, top, st, {handle}, {start}, 0, True, False)")
                self.check()
                at = self.list_contains(args[0][0], args[0][1], kind, [rest], node, index=True)
                self.emit(f"if {at} < 0:")
                self.emit("    break")
                self.emit(f"{total} += 1")
                self.emit(f"{start} += {at} + 1")
                self.depth -= 1
                return INT, [total]
            at = self.list_contains(args[0][0], args[0][1], kind, [handle], node, index=True)
            # Not there: ValueError.
            self.fail(f"{at} < 0")
            if name == "index":
                return INT, [at]
            cell.mutated = True
            self.list_close(handle, at)
            return NONE, ["-1"]
        if name == "pop" and len(args) == 1 and args[0][0] in (INT, BOOL):
            cell.mutated = True
            self.check_item(elem, node)
            where = self.index((kind, [handle]), args[0], node)
            value = [self.temp(code) for code in self.slot(elem, where)]
            self.list_close(handle, f"{where} - I[{handle} + 2]")
            return elem, value
        if name == "insert" and len(args) == 2 and args[0][0] in (INT, BOOL):
            item_kind, item_codes = args[1]
            self.program.widen_cell(cell, item_kind)
            cell.mutated = True
            elem = kind.elem
            self.check_item(elem, node)
            at = self.temp(self.as_int(*args[0]))
            size = self.temp(f"I[{handle}]")
            self.emit(f"if {at} < 0:")
            self.emit(f"    {at} = {at} + {size} if {at} + {size} > 0 else 0")
            self.emit(f"if {at} > {size}:")
            self.emit(f"    {at} = {size}")
            self.temp(f"list_room(I, top, st, {handle})")
            self.check()
            data = self.temp(f"I[{handle} + 2]")
            self.counter += 1
            step = f"t{self.counter}"
            self.emit(f"for {step} in range({size}, {at}, -1):")
            self.emit(f"    I[{data} + {step}] = I[{data} + {step} - 1]")
            self.store(elem, f"{data} + {at}", self.coerce(item_kind, item_codes, elem))
            return NONE, ["-1"]
        if name == "extend" and len(args) == 1 and type(args[0][0]) is ListT:
            other_kind, other_codes = args[0]
            self.program.join(kind, other_kind)
            cell.mutated = True
            other, count = self.temp(other_codes[0]), self.temp(f"I[{other_codes[0]}]")
            self.counter += 1
            step = f"t{self.counter}"
            self.emit(f"for {step} in range({count}):")
            self.depth += 1
            where = self.temp(f"list_room(I, top, st, {handle})")
            self.check()
            self.emit(f"I[{where}] = I[I[{other} + 2] + {step}]")
            self.depth -= 1
            return NONE, ["-1"]
        if name in ("reverse", "clear") and not args:
            cell.mutated = True
            if name == "clear":
                self.emit(f"I[{handle}] = 0")
                return NONE, ["-1"]
            data, size = self.temp(f"I[{handle} + 2]"), self.temp(f"I[{handle}]")
            self.counter += 1
            step = f"t{self.counter}"
            self.emit(f"for {step} in range({size} // 2):")
            self.emit(f"    I[{data} + {step}], I[{data} + {size} - 1 - {step}] = "
                      f"I[{data} + {size} - 1 - {step}], I[{data} + {step}]")
            return NONE, ["-1"]
        self.unsupported(f"list method '{name}'", node)

    def list_close(self, handle, position):
        """Take out the item at ``position``, moving the later ones down."""
        data, size = self.temp(f"I[{handle} + 2]"), self.temp(f"I[{handle}]")
        self.counter += 1
        step = f"t{self.counter}"
        self.emit(f"for {step} in range({position}, {size} - 1):")
        self.emit(f"    I[{data} + {step}] = I[{data} + {step} + 1]")
        self.emit(f"I[{handle}] = {size} - 1")

    def tuple_loop(self, node, iterable):
        """A for loop over a tuple: by position, each item picked by a branch."""
        kind, codes = self.expr(iterable)
        if kind.nullable:
            self.fail(f"not {codes[-1]}")
        if not kind.items:
            return True
        joined = BOTTOM
        for item in kind.items:
            joined = self.program.join(joined, item)
        held, at = [], 0
        for item in kind.items:
            width = _width(item)
            held.append([self.temp(code) for code in self.coerce(item, codes[at:at + width], joined)])
            at += width
        self.counter += 1
        step = f"t{self.counter}"
        names = [f"{step}_{index}" for index in range(_width(joined))]
        self.emit(f"for {step} in range({len(kind.items)}):")
        self.depth += 1
        for position, values in enumerate(held):
            self.emit(f"{'if' if position == 0 else 'elif'} {step} == {position}:")
            for name, code in zip(names, values):
                self.emit(f"    {name} = {code}")
        self.emit("else:")
        for name, code in zip(names, _dummy(joined)):
            self.emit(f"    {name} = {code}")
        self.bind(node.target, (joined, names), node)
        self.body(node.body)
        self.depth -= 1
        return True

    def do_Delete(self, node):
        for target in node.targets:
            if not isinstance(target, ast.Subscript) or isinstance(target.slice, ast.Slice):
                self.unsupported("this del", node)
            kind, codes = self.expr(target.value)
            if kind == BOTTOM:
                return
            if not isinstance(kind, DictT):
                self.unsupported(f"del of an item of {_describe(kind)}", node)
            handle = self.temp(self.present_handle(kind, codes))
            key = self.expr(target.slice)
            if key[0] == BOTTOM:
                return
            _find(kind.vcell).mutated = _find(kind.kcell).mutated = True
            tag, boxed = self.keyed(kind, key, node)
            at = self.temp(f"dict_del_{tag}(F, I, top, st, {handle}, {boxed})")
            self.check()
            self.fail(f"{at} < 0")

    def dict_augassign(self, base, target, node):
        """``d[k] op= value``: Python reads d[k], works out the result, then stores it."""
        kind, codes = base
        handle = self.temp(self.present_handle(kind, codes))
        key = self.expr(target.slice)
        key = key[0], [self.temp(code) for code in key[1]]
        if key[0] == BOTTOM:
            self.expr(node.value)
            return
        at = self.dict_find(kind, handle, key, node)
        self.fail(f"{at} < 0")
        elem = kind.value
        current = elem, [self.temp(code) for code in self.slot(elem, f"{at} + 3")]
        result = self.binop(type(node.op), current, self.expr(node.value), node)
        self.dict_store(kind, handle, key, result, node)

    # Calls

    def call_keywords(self, node):
        """Evaluated keyword arguments, in order: [(name, (type, codes))]."""
        out = []
        for keyword in node.keywords:
            if keyword.arg is None:
                self.unsupported("** in a call", node)
            out.append((keyword.arg, self.expr(keyword.value)))
        return out

    def bind_call(self, callee, args, keywords, node):
        """The arguments of a call in the callee's parameter order: positional ones,
        keywords, defaults that are constants, and extra positional ones as the
        tuple ``*args`` takes."""
        fn = callee.fn
        code = fn.__code__
        count = code.co_argcount
        names = _signature_names(fn)
        star = bool(code.co_flags & _VARARGS)
        named = names[:count + code.co_kwonlyargcount]
        if len(args) > count and not star:
            self.unsupported(f"a call of '{fn.__qualname__}' with the wrong number of arguments", node)
        bound = dict(zip(named[:count], args[:count]))
        for name, value in keywords:
            if name not in named or named.index(name) < code.co_posonlyargcount or name in bound:
                self.unsupported(f"a call of '{fn.__qualname__}' with a keyword it does not take", node)
            bound[name] = value
        metadata = _binding_metadata(fn)
        if metadata is None:
            self.unsupported("a call with unsupported default metadata", node)
        defaults, kwdefaults = metadata
        out = []
        for index, name in enumerate(named):
            if name in bound:
                out.append(bound[name])
                continue
            if count - len(defaults) <= index < count:
                self.program.guard("attr", fn, "__defaults__", fn.__defaults__)
                value = defaults[index - (count - len(defaults))]
            elif index >= count and name in kwdefaults:
                self.program.guard("attr", fn, "__kwdefaults__", fn.__kwdefaults__)
                self.program.guard("item", fn.__kwdefaults__, name, kwdefaults[name])
                value = kwdefaults[name]
            else:
                self.unsupported(f"a call of '{fn.__qualname__}' with the wrong number of arguments", node)
            made = self.value_constant(value, node)
            if made is None:
                self.unsupported(f"a call of '{fn.__qualname__}' that relies on a default that is "
                                 f"{type(value).__name__}", node)
            out.append(made)
        if star:
            extra = args[count:]
            out.append((TupT(kind for kind, _ in extra), [code for _, codes in extra for code in codes]))
        return out

    def is_super(self, node):
        return (isinstance(node, ast.Call) and isinstance(node.func, ast.Name) and node.func.id == "super"
                and not node.args and not node.keywords and "super" not in self.info.locals
                and "super" not in self.namespace and self.builtins.get("super") is super)

    def super_call(self, name, node):
        """``super().name(...)`` in a method: the method the classes of ``self`` find
        after the class that defines this one."""
        cell = self.cells().get("__class__")
        if cell is None or not self.info.params:
            self.unsupported("super() outside a method", node)
        self.program.guard("builtin", self.namespace, "super", self.builtins, super)
        definer = cell.cell_contents
        me = self.info.params[0]
        kind, codes = self.expr(ast.copy_location(ast.Name(id=me, ctx=ast.Load()), node))
        if kind == BOTTOM:
            raise _Pending
        if not isinstance(kind, ObjT) or any(definer not in cls.__mro__ for cls in kind.classes):
            self.unsupported(f"super() on {_describe(kind)}", node)
        args, keywords = self.call_args(node.args), self.call_keywords(node)
        resolved = [next((vars(klass)[name] for klass in cls.__mro__[cls.__mro__.index(definer) + 1:]
                          if name in vars(klass)), None) for cls in kind.classes]
        if name == "__init__" and all(found is object.__init__ for found in resolved):
            if args or keywords:
                self.unsupported("arguments to object.__init__", node)
            return NONE, ["-1"]
        receiver = self.temp(self.handle(kind, codes, node))
        return self.method_call(kind, receiver, name, args, node, keywords, definer)


_MATH_EXTRA = {name: getattr(math, name) for name in ("floor", "ceil", "trunc", "isnan", "isinf", "isfinite")}


def _operator_node(target, node):
    """``node``, a call of a function of the operator module, as the expression it
    stands for (``operator.add(a, b)`` is ``a + b``), or None."""
    import operator

    binary = {operator.add: ast.Add, operator.sub: ast.Sub, operator.mul: ast.Mult, operator.truediv: ast.Div,
              operator.floordiv: ast.FloorDiv, operator.mod: ast.Mod, operator.and_: ast.BitAnd,
              operator.or_: ast.BitOr, operator.xor: ast.BitXor}
    compare = {operator.lt: ast.Lt, operator.le: ast.LtE, operator.gt: ast.Gt, operator.ge: ast.GtE,
               operator.eq: ast.Eq, operator.ne: ast.NotEq}
    unary = {operator.neg: ast.USub, operator.pos: ast.UAdd, operator.not_: ast.Not}
    args = node.args
    if node.keywords or any(isinstance(arg, ast.Starred) for arg in args):
        return None
    try:
        if target in binary and len(args) == 2:
            made = ast.BinOp(left=args[0], op=binary[target](), right=args[1])
        elif target in compare and len(args) == 2:
            made = ast.Compare(left=args[0], ops=[compare[target]()], comparators=[args[1]])
        elif target in unary and len(args) == 1:
            made = ast.UnaryOp(op=unary[target](), operand=args[0])
        else:
            return None
    except TypeError:
        # An unhashable callable is no operator function.
        return None
    return ast.copy_location(made, node)


class _Gen(_ContainerGen):

    """One pass over one function: widens types and writes its compiled form."""

    def __init__(self, program, info):
        self.program, self.info = program, info
        self.namespace, self.builtins = info.fn.__globals__, info.fn.__builtins__
        self.lines, self.depth, self.counter, self.line = [], 1, 0, 0
        self.returned, self.unknown_test = [], False
        # Enclosing finally blocks (statements, loop depth at the try), and loop depth.
        self.finals, self.loop_depth = [], 0
        self.math_used = set()
        # Mutable local reads use all-definitions certificates, never whichever
        # assignment happened to be visited last. Only immutable temps use codes.
        self.zero_codes, self.zero_locals = set(), {}
        self.object_allocations = {}
        for name, kind in info.vars.items():
            for path, _, key in _zero_parts(kind, self.var_codes(name, kind)):
                self.zero_locals[key] = name, path
        # Per enclosing loop, the flag a break sets when the loop has an else block.
        self.loop_flags = []

        # Generators whose bodies are being compiled here, innermost last: a loop over
        # one of them again is recursion, and cannot be inlined.
        self.inlining = [info.fn] if info.sink else []
        self.me = info.params[0] if info.owner is not None and info.fn.__name__ == "__init__" and info.params else None

    # Output

    def emit(self, line):
        self.lines.append("    " * self.depth + line)

    def temp(self, code):
        self.counter += 1
        name = f"t{self.counter}"
        self.emit(f"{name} = {code}")
        return name

    def result_codes(self):
        kind = self.info.ret
        return [] if kind in (NONE, BOTTOM) else _dummy(kind)

    def bail(self):
        return "return " + ", ".join(self.result_codes())

    def fail(self, condition):
        """Where Python would raise: flag the call and leave at once."""
        self.emit(f"if {condition}:")
        self.emit("    st[0] = 1")
        self.emit(f"    top[3] = {self.where()}")
        self.emit("    " + self.bail())

    def where(self):
        """A number that names this function and source line, for reporting a fallback."""
        return self.program.order.index(self.info) * 1000000 + self.line

    def check(self):
        self.emit("if st[0]:")
        self.emit("    " + self.bail())

    def peek(self, node):
        """The type of an expression, without keeping the code it would emit."""
        saved = len(self.lines), self.depth, self.counter, self.zero_codes.copy(), self.object_allocations.copy()
        kind, _ = self.expr(node)
        del self.lines[saved[0]:]
        self.depth, self.counter = saved[1], saved[2]
        self.zero_codes = saved[3]
        self.object_allocations = saved[4]
        return kind

    def unsupported(self, what, node):
        raise Unsupported(f"{what} at line {getattr(node, 'lineno', '?')} of '{self.info.fn.__qualname__}'")

    # Variables

    def var_codes(self, name, kind):
        width = _width(kind)
        return [f"v_{name}"] if width == 1 else [f"v_{name}_{index}" for index in range(width)]

    def zero_facts(self, kind, codes):
        facts = set()
        variables = self.program.zero_vars.get(self.info, {})
        for path, leaf, key in _zero_parts(kind, codes):
            local = self.zero_locals.get(key)
            if (leaf == FLOAT or key == (INT, "0") or
                    (local is not None and local[1] in variables.get(local[0], ())) or
                    (local is None and key in self.zero_codes)):
                facts.add(path)
        return facts

    def remember_zero(self, kind, codes, facts):
        for path, _, key in _zero_parts(kind, codes):
            if key not in self.zero_locals:
                if path in facts:
                    self.zero_codes.add(key)
                else:
                    self.zero_codes.discard(key)
        return kind, codes

    def copy_codes(self, kind, codes):
        copied = [self.temp(code) for code in codes]
        return self.remember_zero(kind, copied, self.zero_facts(kind, codes))[1]

    def coerce(self, kind, codes, target):
        facts = self.zero_facts(kind, codes)
        out = self._coerce(kind, codes, target)
        return self.remember_zero(target, out, facts)[1]

    def _coerce(self, kind, codes, target):
        """The codes for a value of ``kind`` stored where ``target`` is expected."""
        if kind == BOTTOM or target == BOTTOM:
            return _dummy(target)
        if target in (NPFQ, NPIQ, NPBQ) and kind != target:
            return [codes[0], _np_flag(kind, codes)]
        if target == MIXED and kind != MIXED:
            return list(self.as_mixed(kind, codes))
        if isinstance(target, OptT):
            if kind == NONE:
                return _dummy(target)
            if isinstance(kind, OptT):
                return self.coerce(kind.base, codes[:-1], target.base) + [codes[-1]]
            return self.coerce(kind, codes, target.base) + ["True"]
        if isinstance(target, TupT) and kind == NONE:
            return _dummy(target)
        if isinstance(target, (ObjT,) + _HANDLES):
            return ["-1"] if kind == NONE else codes
        if isinstance(target, TupT):
            out, at = [], 0
            for item, wanted in zip(kind.items, target.items):
                width = _width(item)
                out += self.coerce(item, codes[at:at + width], wanted)
                at += width
            if target.nullable:
                out.append(codes[-1] if kind.nullable else "True")
            return out
        return codes

    def assign(self, name, kind, codes):
        joined = self.program.widen(self.info.vars, name, kind)
        candidates = self.program.zero_vars.get(self.info, {}).get(name, set())
        self.program.meet_zero(candidates, self.zero_facts(kind, codes))
        for target, code in zip(self.var_codes(name, joined), self.coerce(kind, codes, joined)):
            self.emit(f"{target} = {code}")
        if name in self.info.flagged:
            self.emit(f"u_{name} = True")

    def bound_check(self, node, name):
        """A read that may find ``name`` unbound: Python raises UnboundLocalError."""
        if id(node) in self.info.unbound or getattr(node, "_rc_unbound", False):
            self.fail(f"not u_{name}")

    # Numbers

    def as_int(self, kind, codes):
        return f"(1 if {codes[0]} else 0)" if kind == BOOL else codes[0]

    def as_mixed(self, kind, codes):
        """(float value, flag that Python would hold an int)."""
        if kind == MIXED:
            return codes[0], codes[1]
        if kind == FLOAT:
            return codes[0], "False"
        code = self.as_int(kind, codes)
        if _is_literal_int(code):
            if abs(int(code)) > EXACT:
                raise Unsupported("an int constant too large to mix with floats")
            return f"{int(code)}.0", "True"
        code = self.temp(code)
        if not self.program.zero_optimized or () not in self.zero_facts(kind, codes):
            self.fail(f"{code} > {EXACT} or {code} < -{EXACT}")
        return f"float({code})", "True"

    def as_float(self, kind, codes, exact=False):
        """The value as a float. Python converts an int with correct rounding, as the
        machine does; ``exact`` is for where Python uses the int itself."""
        if kind in (FLOAT, MIXED):
            return codes[0]
        code = self.as_int(kind, codes)
        if _is_literal_int(code):
            if exact and abs(int(code)) > EXACT:
                raise Unsupported("an int constant too large to compare or divide exactly")
            return f"{int(code)}.0" if abs(int(code)) <= EXACT else f"float({code})"
        if exact:
            code = self.temp(code)
            self.fail(f"{code} > {EXACT} or {code} < -{EXACT}")
        return f"float({code})"

    def present(self, kind, codes):
        """A float that may be None, as a float: Python raises TypeError on None.
        A numpy scalar, as the Python number it equals (see np_binop)."""
        if _is_np(kind):
            return _NP_BASE[kind], codes[:1]
        if isinstance(kind, OptT):
            self.fail(f"not {codes[-1]}")
            return kind.base, codes[:-1]
        return kind, codes

    def none_test(self, kind, codes):
        """Code for ``value is None``."""
        if kind == NONE:
            return "True"
        if isinstance(kind, OptT):
            return f"(not {codes[-1]})"
        if isinstance(kind, TupT):
            return f"(not {codes[-1]})" if kind.nullable else "False"
        if isinstance(kind, (ObjT,) + _HANDLES) and kind.nullable:
            return f"({codes[0]} < 0)"
        return "False"

    def numeric(self, kind, node):
        if kind not in (INT, FLOAT, BOOL, MIXED, NPF, NPI, NPFQ, NPIQ):
            self.unsupported(f"arithmetic on {_describe(kind)}", node)

    def binop(self, op, left, right, node):
        (lk, lc), (rk, rc) = left, right
        if lk == BOTTOM or rk == BOTTOM:
            return BOTTOM, ["0"]
        if _is_np(lk) or _is_np(rk):
            return self.np_binop(op, left, right, node)
        if isinstance(lk, _HANDLES) or isinstance(rk, _HANDLES):
            return self.container_binop(op, left, right, node)
        (lk, lc), (rk, rc) = self.present(lk, lc), self.present(rk, rc)
        right = rk, rc
        if NONE in (lk, rk):
            # Arithmetic on None raises TypeError.
            self.fail("True")
            return BOTTOM, ["0"]
        if isinstance(lk, ObjT) and op in _OPERATOR_METHODS:
            # ``a - b`` on objects is ``type(a).__sub__(a, b)``. Methods that return
            # NotImplemented are refused when compiled, so no reflected call is needed.
            receiver = self.temp(self.handle(lk, lc, node))
            return self.method_call(lk, receiver, _OPERATOR_METHODS[op], [right], node)
        self.numeric(lk, node)
        self.numeric(rk, node)
        whole = lk in (INT, BOOL) and rk in (INT, BOOL)
        if op in _ARITHMETIC:
            sign, helper = _ARITHMETIC[op]
            zero = () in self.zero_facts(lk, lc) and () in self.zero_facts(rk, rc)
            if whole:
                if lk == rk == INT and self.program.numeric_policy is not None:
                    value = self.program.numeric_policy.lower(self, op, lc[0], rc[0], node)
                    if value is not None:
                        return self.remember_zero(INT, [value], {()} if zero else set())
                value = self.temp(f"{helper}(st, {self.as_int(lk, lc)}, {self.as_int(rk, rc)})")
                self.check()
                return self.remember_zero(INT, [value], {()} if zero else set())
            if MIXED not in (lk, rk):
                return FLOAT, [f"({self.as_float(lk, lc)} {sign} {self.as_float(rk, rc)})"]
            (av, at), (bv, bt) = self.as_mixed(lk, lc), self.as_mixed(rk, rc)
            if "False" in (at, bt):
                return FLOAT, [f"({av} {sign} {bv})"]
            self.program.saw_mixed = True
            if self.program.fast_mixed:
                # No flag at run time: the value may be an int, so every later result
                # is checked too ("True"), and only its size is: below 2**53, int
                # arithmetic on floats is exact. See _Program.floats_unseen.
                value = self.temp(f"{av} {sign} {bv}")
                self.fail(f"math.fabs({value}) >= {EXACT}.0")
                return MIXED, [value, "True"]
            value, flag = self.temp(f"{av} {sign} {bv}"), self.temp(f"{at} and {bt}")
            if self.program.zero_optimized and zero:
                # The integer branch is 0+0, 0-0 or 0*0, already canonical +0.
                return self.remember_zero(MIXED, [value, flag], {()})
            # Two ints: the float result is the int result while it stays exact, and
            # an int zero is never negative.
            self.emit(f"if {flag}:")
            self.emit(f"    if {value} >= {EXACT}.0 or {value} <= -{EXACT}.0:")
            self.emit("        st[0] = 1")
            self.emit(f"        top[3] = {self.where()}")
            self.emit("        " + self.bail())
            self.emit(f"    {value} += 0.0")
            return self.remember_zero(MIXED, [value, flag], {()} if zero else set())
        if op is ast.Div:
            # int / int is the correctly rounded quotient of the ints themselves.
            both_exact = FLOAT not in (lk, rk)
            top = self.as_float(lk, lc, exact=both_exact)
            bottom = self.temp(self.as_float(rk, rc, exact=both_exact))
            self.fail(f"{bottom} == 0.0")
            return FLOAT, [f"({top} / {bottom})"]
        if op in _BITWISE and whole:
            sign = _BITWISE[op]
            if lk == BOOL and rk == BOOL:
                return BOOL, [f"({lc[0]} {sign} {rc[0]})"]
            return INT, [f"({self.as_int(lk, lc)} {sign} {self.as_int(rk, rc)})"]
        if op in (ast.FloorDiv, ast.Mod) and whole:
            helper = "floordiv_i" if op is ast.FloorDiv else "mod_i"
            value = self.temp(f"{helper}(st, {self.as_int(lk, lc)}, {self.as_int(rk, rc)})")
            self.check()
            return INT, [value]
        self.unsupported(f"operator {op.__name__} on {_describe(lk)} and {_describe(rk)}", node)

    def truth(self, kind, codes, node):
        if _is_np(kind):
            return self.truth(_NP_BASE[kind], codes[:1], node)
        if kind == BOOL:
            return codes[0]
        if kind == INT:
            return f"({codes[0]} != 0)"
        if kind in (FLOAT, MIXED):
            return f"({codes[0]} != 0.0)"
        if kind == BOTTOM:
            # Not known in this pass: an if on it waits for a later one (do_If).
            self.unknown_test = True
            return "False"
        if kind == NONE:
            return "False"
        if isinstance(kind, ObjT):
            hook = self.truth_hook(kind, node)
            if hook is not None:
                return self.object_truth(kind, codes, hook, node)
            return f"({codes[0]} >= 0)" if kind.nullable else "True"
        if isinstance(kind, ListT):
            return self.temp(f"I[{self.physical_index(codes[0], True)}] != 0")
        if isinstance(kind, _HANDLES):
            return self.container_truth(kind, codes)
        if isinstance(kind, OptT):
            return f"({codes[-1]} and {self.truth(kind.base, codes[:-1], node)})"
        if isinstance(kind, TupT):
            if kind.nullable:
                return codes[-1]
            return "True" if kind.items else "False"
        self.unsupported(f"truth of {_describe(kind)}", node)

    def cond(self, node):
        """A boolean expression for ``node`` used as a test, short-circuiting as Python does."""
        if isinstance(node, ast.BoolOp):
            result = self.temp(self.cond(node.values[0]))
            for value in node.values[1:]:
                self.emit(f"if {result}:" if isinstance(node.op, ast.And) else f"if not {result}:")
                self.depth += 1
                self.emit(f"{result} = {self.cond(value)}")
                self.depth -= 1
            return result
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.Not):
            return f"(not {self.cond(node.operand)})"
        kind, codes = self.expr(node)
        return self.truth(kind, codes, node)

    # Objects and lists

    def handle(self, kind, codes, node):
        """The handle of an object that an attribute or method is taken from."""
        if kind == NONE:
            self.fail("True")
            return "0"
        if kind.nullable:
            self.fail(f"{codes[0]} < 0")
        return codes[0]

    def physical_index(self, where, nonnegative):
        """Mark a proved physical slot, not a Python index or a handle value.

        Object fields opt in after handle() and attr_check(); list headers come
        from validated loaders or checked allocation, and index() proves item
        positions. These addresses fit the finite (MAX_SLOTS) arena.
        Cast the final signed expression, never operands: NumPy can then omit
        negative-index wrapping without changing offset arithmetic or sentinels.
        """
        return f"np.uint64({where})" if nonnegative else where

    def slot(self, kind, where, *, nonnegative=False):
        """Codes that read the value of ``kind`` stored at slot expression ``where``."""
        at = self.physical_index(where, nonnegative)
        if _is_np(kind):
            base = self.slot(_NP_BASE[kind], where, nonnegative=nonnegative)
            flag = self.physical_index(f"{where} + 1", nonnegative)
            return base if kind in (NPF, NPI, NPB) else base + [f"(I[{flag}] != 0)"]
        if kind == FLOAT:
            return [f"F[{at}]"]
        if kind == MIXED:
            if self.program.fast_mixed:
                return [f"F[{at}]", "True"]
            flag = self.physical_index(f"{where} + 1", nonnegative)
            return [f"F[{at}]", f"(I[{flag}] != 0)"]
        if isinstance(kind, OptT):
            flag = self.physical_index(f"{where} + {_slots(kind.base)}", nonnegative)
            return self.slot(kind.base, where, nonnegative=nonnegative) + [f"(I[{flag}] != 0)"]
        if kind == BOOL:
            return [f"(I[{at}] != 0)"]
        if isinstance(kind, TupT):
            handle, out, offset = f"I[{at}]", [], 0
            for item in kind.items:
                if kind.nullable and isinstance(item, TupT):
                    raise Unsupported("a tuple that may be None holding a tuple")
                # A missing tuple has handle -1. Its speculative payload is
                # ignored by the presence flag, but must keep signed indexing.
                out += self.slot(item, f"{handle} + {offset}")
                offset += _slots(item)
            return out + ([f"({handle} >= 0)"] if kind.nullable else [])
        if kind in (NONE, BOTTOM):
            return ["-1"] if kind == NONE else ["0"]
        return [f"I[{at}]"]

    def store(self, kind, where, codes, *, nonnegative=False):
        at = self.physical_index(where, nonnegative)
        if _is_np(kind):
            self.store(_NP_BASE[kind], where, codes[:1], nonnegative=nonnegative)
            if kind in (NPFQ, NPIQ, NPBQ):
                flag = self.physical_index(f"{where} + 1", nonnegative)
                self.emit(f"I[{flag}] = {codes[1]}")
            return
        if isinstance(kind, TupT):
            # A new block for the tuple's items; the slot holds its handle.
            size = max(1, sum(map(_slots, kind.items)))
            if kind.nullable:
                self.emit(f"if {codes[-1]}:")
                self.depth += 1
            block = self.temp(f"alloc(I, top, st, {size})")
            self.check()
            offset = position = 0
            for item in kind.items:
                width = _width(item)
                self.store(item, f"{block} + {offset}", codes[position:position + width])
                offset += _slots(item)
                position += width
            self.emit(f"I[{at}] = {block}")
            if kind.nullable:
                self.depth -= 1
                self.emit("else:")
                self.emit(f"    I[{at}] = -1")
        elif kind == FLOAT:
            self.emit(f"F[{at}] = {codes[0]}")
        elif isinstance(kind, OptT):
            self.store(kind.base, where, codes[:-1], nonnegative=nonnegative)
            flag = self.physical_index(f"{where} + {_slots(kind.base)}", nonnegative)
            self.emit(f"I[{flag}] = {codes[-1]}")
        elif kind == MIXED:
            self.emit(f"F[{at}] = {codes[0]}")
            # With int-or-float as plain floats no flag is read again: nothing that
            # holds one is written back (floats_unseen).
            if not self.program.fast_mixed:
                flag = self.physical_index(f"{where} + 1", nonnegative)
                self.emit(f"I[{flag}] = {codes[1]}")
        else:
            self.emit(f"I[{at}] = {codes[0]}")

    def field(self, kind, node, attr):
        if kind == BOTTOM:
            return None, None
        if not isinstance(kind, ObjT) and kind != NONE:
            self.unsupported(f"attribute '{attr}' of {_describe(kind)}", node)
        if kind == NONE:
            return None, None
        fields = self.program.fields[self.program.family(kind.cls)]
        if not any(attr in self.program.class_fields[cls] for cls in kind.classes):
            self.unsupported(f"'{_describe(kind)}.{attr}', which __init__ does not set", node)
        return fields, self.program.layout(kind.cls)[0][attr]

    def attr_check(self, kind, base, attr):
        """Where only some of the classes an object may be have ``attr``, check its
        tag: Python would raise AttributeError for the others."""
        having = sorted((cls for cls in kind.classes if attr in self.program.class_fields[cls]),
                        key=self.program.tag)
        if len(having) < len(kind.classes):
            # All callers have already checked the receiver with handle().
            at = self.physical_index(base, True)
            self.fail("not (" + " or ".join(f"I[{at}] == {self.program.tag(cls)}" for cls in having) + ")")

    def index(self, base, position, node):
        """A checked position in a list: a temp holding the item's slot."""
        (bk, bc), (pk, pc) = base, position
        if pk in (NPI, NPIQ):
            pk, pc = self.present(pk, pc)
        if pk == BOTTOM:
            # Known in a later pass (the result of a call not typed yet); the types
            # cannot settle until it is.
            self.program.changed = True
            return "0"
        if pk == MIXED:
            self.program.mixed_kind_used = True
            # Mixing integers with floats already requires exact integer payloads.
            # Retain the kind and representation checks before conversion even
            # when the indexed value is the only thing that reaches Python.
            self.fail(f"not {pc[1]} or not (-{EXACT}.0 <= {pc[0]} <= {EXACT}.0)")
            pk, pc = INT, [self.temp(f"np.int64({pc[0]})")]
        if pk not in (INT, BOOL):
            self.unsupported(f"a list index that is {_describe(pk)}", node)
        size = self.temp(f"I[{self.physical_index(bc[0], True)}]")
        at = self.temp(self.as_int(pk, pc))
        self.emit(f"if {at} < 0:")
        self.emit(f"    {at} += {size}")
        self.fail(f"{at} < 0 or {at} >= {size}")
        data = self.physical_index(f"{bc[0]} + 2", True)
        return self.temp(f"I[{data}] + {at}")

    def check_item(self, kind, node):
        if kind in (NPFQ, NPIQ, NPBQ):
            self.unsupported(f"a list that holds {_describe(kind)}", node)
        if kind == MIXED or isinstance(kind, OptT):
            self.unsupported("a list that holds both ints and floats, or numbers and None", node)

    # Expressions

    def expr(self, node):
        method = getattr(self, "expr_" + type(node).__name__, None)
        if method is None:
            self.unsupported(type(node).__name__, node)
        try:
            return method(node)
        except _Pending:
            self.program.changed = True
            return BOTTOM, ["0"]

    def expr_Constant(self, node):
        value = node.value
        if value is None:
            return NONE, ["-1"]
        if type(value) is bool:
            return BOOL, [repr(value)]
        if type(value) is int and INT_MIN <= value <= INT_MAX:
            return INT, [repr(value)]
        if type(value) is float and math.isfinite(value):
            return FLOAT, [repr(value)]
        if type(value) is float and value == value and math.copysign(1.0, value) > 0:
            return FLOAT, ["math.inf"]
        if type(value) is float and value == value:
            return FLOAT, ["(-math.inf)"]
        if type(value) is float and struct.pack("<d", value) == struct.pack("<d", math.nan):
            return FLOAT, ["math.nan"]
        if type(value) is str:
            return self.str_constant(value)
        self.unsupported(f"constant {value!r}", node)

    def constant(self, value, node):
        return self.expr_Constant(ast.copy_location(ast.Constant(value=value), node))

    def constant_tuple(self, value, node):
        items = [self.constant_tuple(item, node) if type(item) is tuple else self.constant(item, node)
                 for item in value]
        return TupT(kind for kind, _ in items), [code for _, codes in items for code in codes]

    def expr_Name(self, node):
        if node.id in self.info.locals:
            self.bound_check(node, node.id)
            kind = self.info.vars.get(node.id, BOTTOM)
            return kind, (self.var_codes(node.id, kind) if kind != BOTTOM else ["0"])
        free = self.cell_name(node)
        if free is not None:
            return free
        if node.id in self.namespace:
            value = self.namespace[node.id]
            if type(value) in (int, float, bool) or value is None:
                self.program.guard("const", self.namespace, node.id, value)
                return self.constant(value, node)
            made = self.global_constant(node, value)
            if made is not None:
                return made
            if type(value) in (list, dict, set) or _is_ndarray(value) or (
                    not isinstance(value, (type, FunctionType, pytypes.ModuleType, pytypes.BuiltinFunctionType))
                    and type(value).__module__ != "builtins" and _object_problem(type(value)) is None):
                # An object or list held by a module global: loaded into its own slot
                # before each call and written back after, like an argument.
                return self.program.global_value(self.namespace, node.id, value)
        self.unsupported(f"name '{node.id}' used as a value", node)

    def is_math(self, node):
        return (isinstance(node, ast.Name) and node.id not in self.info.locals
                and self.namespace.get(node.id) is math)

    def expr_Attribute(self, node):
        if self.is_math(node.value):
            if node.attr not in MATH_CONSTANTS + ("nan",):
                self.unsupported(f"math.{node.attr}", node)
            self.program.guard("item", self.namespace, node.value.id, math)
            self.program.guard("const", math.__dict__, node.attr, getattr(math, node.attr))
            return self.constant(getattr(math, node.attr), node)
        member = self.module_member(node)
        if member is not None:
            return self.module_value(*member, node)
        owner = self.class_named(node.value)
        if owner is not None:
            return self.class_attribute(owner, node.attr, node)
        kind, codes = self.expr(node.value)
        if isinstance(kind, NdT):
            return self.nd_attribute(kind, codes, node.attr, node)
        fields, offset = self.field(kind, node, node.attr)
        if fields is None:
            if kind == NONE:
                self.fail("True")
            return BOTTOM, ["0"]
        base = self.handle(kind, codes, node)
        self.attr_check(kind, base, node.attr)
        found = fields[node.attr]
        return found, [self.temp(code) for code in self.slot(found, f"{base} + {offset}", nonnegative=True)]

    def expr_Subscript(self, node):
        kind, codes = self.expr(node.value)
        if isinstance(kind, NdT):
            self.program.arrays_used = True
            return self.nd_read(kind, codes, node.slice, node)
        if isinstance(kind, TupT):
            if kind.nullable:
                self.fail(f"not {codes[-1]}")
            if not (isinstance(node.slice, ast.Constant) and type(node.slice.value) is int
                    and -len(kind.items) <= node.slice.value < len(kind.items)):
                self.unsupported("a tuple index that is not a constant in range", node)
            position = node.slice.value % len(kind.items)
            start = sum(map(_width, kind.items[:position]))
            return kind.items[position], codes[start:start + _width(kind.items[position])]
        if isinstance(kind, StrT):
            return self.str_subscript([self.present_handle(kind, codes)], node)
        if isinstance(kind, DictT):
            return self.dict_subscript(kind, codes, node)
        if isinstance(kind, ObjT) and not isinstance(node.slice, ast.Slice):
            # ``obj[i]`` is ``type(obj).__getitem__(obj, i)``.
            receiver = self.temp(self.handle(kind, codes, node))
            return self.method_call(kind, receiver, "__getitem__", [self.expr(node.slice)], node)
        if kind in (BOTTOM, NONE):
            self.expr(node.slice) if not isinstance(node.slice, ast.Slice) else None
            if kind == NONE:
                # None[...] raises TypeError.
                self.fail("True")
            return BOTTOM, ["0"]
        if not isinstance(kind, ListT):
            self.unsupported(f"indexing {_describe(kind)}", node)
        if isinstance(node.slice, ast.Slice):
            if node.slice.step is not None or isinstance(kind, ArrT):
                self.unsupported("a slice with a step, or of an array", node)
            bounds = []
            for part in (node.slice.lower, node.slice.upper):
                if part is None:
                    bounds.append(None)
                    continue
                part_kind, part_codes = self.expr(part)
                if part_kind not in (INT, BOOL, BOTTOM):
                    self.unsupported(f"a slice bound that is {_describe(part_kind)}", node)
                bounds.append(self.as_int(part_kind, part_codes))
            low, high = bounds
            made = self.temp(f"list_slice(I, top, st, {codes[0]}, {low or 0}, {high or 0}, "
                             f"{low is not None}, {high is not None})")
            self.check()
            # A new list of the same items: it shares the item type of its source.
            return kind, [made]
        where = self.index((kind, codes), self.expr(node.slice), node)
        self.check_item(kind.elem, node)
        return kind.elem, [self.temp(code) for code in self.slot(kind.elem, where, nonnegative=True)]

    def expr_UnaryOp(self, node):
        if isinstance(node.op, ast.Not):
            return BOOL, [f"(not {self.cond(node.operand)})"]
        operand = self.expr(node.operand)
        if _is_np(operand[0]) and isinstance(node.op, (ast.USub, ast.UAdd)):
            if operand[0] in (NPB, NPBQ):
                self.unsupported(f"{type(node.op).__name__} of {_describe(operand[0])}", node)
            flag = _np_flag(*operand)
            kind, codes = self.expr_UnaryOp_plain(node, self.present(*operand))
            return self.np_result(kind, codes, flag)
        kind, codes = self.present(*operand)
        return self.expr_UnaryOp_plain(node, (kind, codes))

    def expr_UnaryOp_plain(self, node, operand):
        kind, codes = operand
        if kind == NONE:
            self.fail("True")
        if kind in (BOTTOM, NONE):
            return BOTTOM, ["0"]
        self.numeric(kind, node)
        if isinstance(node.op, ast.UAdd):
            return (INT, [self.as_int(kind, codes)]) if kind == BOOL else (kind, codes)
        if not isinstance(node.op, ast.USub):
            self.unsupported("this unary operator", node)
        if kind in (INT, BOOL):
            code = self.as_int(kind, codes)
            if _is_literal_int(code):
                return INT, [str(-int(code))]
            code = self.temp(code)
            self.fail(f"{code} == -{code} and {code} != 0")
            return INT, [f"(-{code})"]
        if kind == FLOAT:
            return FLOAT, [f"(-{codes[0]})"]
        if self.program.fast_mixed:
            return MIXED, [self.temp(f"(-{codes[0]})"), codes[1]]
        return MIXED, [self.temp(f"(0.0 - {codes[0]}) if {codes[1]} else (-{codes[0]})"), codes[1]]

    def expr_BinOp(self, node):
        op = type(node.op)
        if op is ast.Mult:
            for display, count in ((node.left, node.right), (node.right, node.left)):
                if isinstance(display, ast.List) and len(display.elts) == 1:
                    return self.repeated(display.elts[0], count, node, display is node.left)
        left = self.expr(node.left)
        if op is ast.Pow:
            if not (isinstance(node.right, ast.Constant) and type(node.right.value) is int and node.right.value == 2):
                self.unsupported("a power other than ** 2", node)
            held = left[0], [self.temp(code) for code in left[1]] if left[0] != BOTTOM else left[1]
            return self.binop(ast.Mult, held, held, node)
        right = self.expr(node.right)
        return self.binop(op, left, right, node)

    def repeated(self, item, count, node, item_first):
        """``[item] * count``: a new list with one value in every place."""
        first, second = (item, count) if item_first else (count, item)
        values = {}
        for part in (first, second):
            values[part] = self.expr(part)
        (ik, ic), (ck, cc) = values[item], values[count]
        if ck not in (INT, BOOL, BOTTOM):
            self.unsupported(f"a list repeated {_describe(ck)} times", node)
        if isinstance(ik, (ListT, TupT)) or ik == MIXED:
            self.unsupported(f"a repeated list of {_describe(ik)}", node)
        # A new list starts with its own item type; that is not a change to anything.
        made = ListT()
        made.cell.elem = ik
        amount = self.as_int(ck, cc) if ck != BOTTOM else "0"
        if ik == FLOAT:
            code = f"list_fill_f(F, I, top, st, {amount}, {ic[0]})"
        else:
            raw = self.as_int(ik, ic) if ik == BOOL else ic[0]
            code = f"list_fill(I, top, st, {amount}, {raw})"
        value = self.temp(code)
        self.check()
        return made, [value]

    def expr_List(self, node):
        made = ListT()
        items = [self.expr(item) for item in node.elts]
        for kind, _ in items:
            made.cell.elem = self.program.join(made.cell.elem, kind)
        value = self.temp(f"list_new(I, top, st, {len(items)}, {len(items)})")
        self.check()
        elem = made.elem
        self.check_item(elem, node)
        if items:
            data = self.temp(f"I[{value} + 2]")
            for position, (kind, codes) in enumerate(items):
                self.store(elem, f"{data} + {position}", self.coerce(kind, codes, elem))
        return made, [value]

    def expr_Tuple(self, node):
        items = [self.expr(item) for item in node.elts]
        # Held in temporaries, so ``a, b = b, a`` reads both before it writes either.
        codes = [code for kind, item_codes in items for code in self.copy_codes(kind, item_codes)]
        return TupT(kind for kind, _ in items), codes

    def expr_IfExp(self, node):
        joined = self.program.join(self.peek(node.body), self.peek(node.orelse))
        if joined == BOTTOM:
            return BOTTOM, ["0"]
        self.counter += 1
        names = [f"t{self.counter}_{index}" for index in range(_width(joined))]
        test = self.cond(node.test)
        for branch, opener in ((node.body, f"if {test}:"), (node.orelse, "else:")):
            self.emit(opener)
            self.depth += 1
            kind, codes = self.expr(branch)
            for name, code in zip(names, self.coerce(kind, codes, joined)):
                self.emit(f"{name} = {code}")
            self.depth -= 1
        return joined, names

    def expr_BoolOp(self, node):
        kinds = [self.peek(value) for value in node.values]
        if any(kind not in (BOOL, BOTTOM) for kind in kinds):
            self.unsupported("and/or whose result is used as a value, on values that are not bool", node)
        return BOOL, [self.cond(node)]

    def expr_Compare(self, node):
        flags = []
        if len(node.ops) == 1 and type(node.ops[0]) in _COMPARISONS:
            left, right = self.expr(node.left), self.expr(node.comparators[0])
            flags = [_np_flag(*left), _np_flag(*right)]
            if flags != ["False", "False"]:
                code = self.compare(type(node.ops[0]), self.present(*left), self.present(*right), node)
                return self.np_result(BOOL, [code], self.temp(" or ".join(flags)) if "True" not in flags else "True")
            return BOOL, [self.compare(type(node.ops[0]), left, right, node)]
        left = self.expr(node.left)
        result = None
        for position, (op, comparator) in enumerate(zip(node.ops, node.comparators)):
            if position:
                self.emit(f"if {result}:")
                self.depth += 1
            right = self.expr(comparator)
            if len(node.ops) > 1 and (_is_np(left[0]) or _is_np(right[0])):
                self.unsupported("a chained comparison of numpy scalars", node)
            if len(node.ops) > 1:
                right = right[0], [self.temp(code) for code in right[1]]
            code = self.compare(type(op), left, right, node)
            if position:
                self.emit(f"{result} = {code}")
                self.depth -= 1
            elif len(node.ops) > 1:
                result = self.temp(code)
            else:
                return BOOL, [code]
            left = right
        return BOOL, [result]

    def compare(self, op, left, right, node):
        (lk, lc), (rk, rc) = left, right
        if BOTTOM in (lk, rk):
            return "False"
        if op in (ast.In, ast.NotIn) and isinstance(rk, ListT):
            found = self.contains_list_legacy(left, right, node)
            return found if op is ast.In else f"(not {found})"
        if op in (ast.Is, ast.IsNot) and NONE in (lk, rk):
            kind, codes = (rk, rc) if lk == NONE else (lk, lc)
            test = self.none_test(kind, codes)
            return test if op is ast.Is else f"(not {test})"
        if not (op in (ast.Is, ast.IsNot, ast.Eq, ast.NotEq) and isinstance(lk, ObjT) and isinstance(rk, ObjT)):
            (lk, lc), (rk, rc) = self.present(lk, lc), self.present(rk, rc)
        if NONE in (lk, rk) and op in _COMPARISONS and op not in (ast.Eq, ast.NotEq):
            # Ordering None raises TypeError.
            self.fail("True")
            return "False"

        handled = self.compare_containers(op, (lk, lc), (rk, rc), node)
        if handled is not None:
            return handled

        def reference(kind):
            return kind == NONE or isinstance(kind, (ObjT, ListT) + _HANDLES)

        if op in (ast.Is, ast.IsNot, ast.Eq, ast.NotEq) and reference(lk) and reference(rk):
            if op in (ast.Eq, ast.NotEq):
                for kind in (lk, rk):
                    if isinstance(kind, ListT):
                        self.unsupported("comparing lists", node)
                    if isinstance(kind, ObjT) and any("__eq__" in vars(klass) or "__ne__" in vars(klass)
                                                      for cls in kind.classes for klass in cls.__mro__[:-1]):
                        self.unsupported(f"comparing '{_describe(kind)}' objects that define ==", node)
            return f"({lc[0]} {'==' if op in (ast.Is, ast.Eq) else '!='} {rc[0]})"
        if op not in _COMPARISONS:
            self.unsupported("this comparison", node)
        self.numeric(lk, node)
        self.numeric(rk, node)
        if lk in (INT, BOOL) and rk in (INT, BOOL):
            return f"({self.as_int(lk, lc)} {_COMPARISONS[op]} {self.as_int(rk, rc)})"
        # Python compares an int with a float exactly, not after rounding the int.
        return f"({self.as_float(lk, lc, exact=True)} {_COMPARISONS[op]} {self.as_float(rk, rc, exact=True)})"

    def contains_list_legacy(self, left, right, node):
        """``value in items`` for a list: each item, in order, is the value or equals
        it, as Python's list.__contains__ tests. Comparing numbers or objects without
        __eq__ runs no code, so the list cannot change while it is searched."""
        (lk, lc), (rk, rc) = left, right
        elem = rk.elem
        found = self.temp("False")
        if elem == BOTTOM:
            return found
        value = lk, [self.temp(code) for code in lc]
        if lk in (FLOAT, MIXED):
            # A NaN is in a list that holds that very object: identity, which the
            # heap does not keep for numbers.
            self.fail(f"{value[1][0]} != {value[1][0]}")
        held = self.temp(rc[0])
        data = self.temp(f"I[{held} + 2]")
        self.counter += 1
        step = f"t{self.counter}"
        self.emit(f"for {step} in range(I[{held}]):")
        self.depth += 1
        item = elem, [self.temp(code) for code in self.slot(elem, f"{data} + {step}")]
        if isinstance(elem, ObjT) or elem == NONE or isinstance(lk, ObjT) or lk == NONE:
            # Identity first; then == for objects, which compare() allows only
            # where no class defines it, so it is identity too.
            test = self.compare(ast.Is, item, value, node) if NONE in (elem, lk) else self.compare(ast.Eq, item, value, node)
        else:
            test = self.compare(ast.Eq, item, value, node)
        self.emit(f"if {test}:")
        self.emit(f"    {found} = True")
        self.emit("    break")
        self.depth -= 1
        return found

    # Calls

    def expr_Await(self, node):
        # Only ``await f(...)`` of a coroutine function in the region: its body never
        # suspends, so awaiting it at once is the same as calling a plain function.
        if not isinstance(node.value, ast.Call):
            self.unsupported("an await of something other than a call", node)
        self.awaited = node.value
        return self.expr(node.value)

    def expr_Call(self, node):
        try:
            return self.call_expr(node)
        except _Pending:
            self.program.changed = True
            return BOTTOM, ["0"]

    def call_expr(self, node):
        func = node.func
        if isinstance(func, ast.Attribute):
            if self.is_super(func.value):
                return self.super_call(func.attr, node)
            if self.is_math(func.value):
                if node.keywords:
                    self.unsupported("a keyword argument", node)
                self.program.guard("item", self.namespace, func.value.id, math)
                return self.math_call(func.attr, node)
            member = self.module_member(func)
            if member is not None:
                return self.call_value(member[1], f"{member[0].__name__}.{func.attr}", node)
            owner = self.class_named(func.value)
            if owner is not None:
                # ``Class.method(obj, ...)``: that class's function, called plainly.
                found = next((vars(klass)[func.attr] for klass in owner.__mro__[:-1] if func.attr in vars(klass)),
                             None)
                if not isinstance(found, FunctionType):
                    self.unsupported(f"'{owner.__name__}.{func.attr}' is not a plain function", node)
                self.program.guard("attr", owner, func.attr, found)
                callee = self.program.function(_unwrap(found), owner)
                args = self.call_args(node.args)
                return self.call(callee, args, node, self.call_keywords(node))
            base = self.expr(func.value)
            if isinstance(base[0], _HANDLES):
                return self.container_method(base, func.attr, node)
            if isinstance(base[0], RngT):
                return self.generator_call(base[1][0], func.attr, node)
            if isinstance(base[0], ListT):
                if node.keywords:
                    self.unsupported("a keyword argument", node)
                return self.list_method(base, func.attr, node)
            if base[0] == BOTTOM:
                [self.expr(arg) for arg in node.args]
                return BOTTOM, ["0"]
            if base[0] == NONE:
                self.fail("True")
                return BOTTOM, ["0"]
            if not isinstance(base[0], ObjT):
                self.unsupported(f"method '{func.attr}' of {_describe(base[0])}", node)
            receiver = self.temp(self.handle(base[0], base[1], node))
            fields = self.program.fields[self.program.family(base[0].cls)]
            if func.attr in fields:
                # A stored callable is an attribute value, rather than a method
                # of its holder. Read it once before evaluating call arguments.
                self.attr_check(base[0], receiver, func.attr)
                offset = self.program.layout(base[0].cls)[0][func.attr]
                kind = fields[func.attr]
                codes = [self.temp(code) for code in self.slot(kind, f"{receiver} + {offset}", nonnegative=True)]
                return self.object_call((kind, codes), node)
            args = self.call_args(node.args)
            return self.method_call(base[0], receiver, func.attr, args, node, self.call_keywords(node))
        if not isinstance(func, ast.Name) or func.id in self.info.locals:
            return self.object_call(self.expr(func), node)
        name = func.id
        if name in self.cells() and isinstance(self.cell_view(name).get(name), (type, FunctionType)):
            # A function or class held by a closure cell.
            view = self.cell_view(name)
            target = view.get(name)
            self.program.guard("item", view, name, target)
            if isinstance(target, type):
                return self.construct(target, node)
            args = self.call_args(node.args)
            return self.call(self.program.function(_unwrap(target)), args, node, self.call_keywords(node))
        if name in self.namespace:
            target = self.namespace[name]
            known = getattr(target, "__name__", None)
            if node.keywords and not isinstance(target, (type, FunctionType)):
                self.unsupported("a keyword argument", node)
            if known in MATH and target is MATH[known]:
                self.program.guard("item", self.namespace, name, target)
                return self.math_call(known, node)
            if isinstance(target, type):
                self.program.guard("item", self.namespace, name, target)
                return self.construct(target, node)
            if isinstance(target, FunctionType):
                self.program.guard("item", self.namespace, name, target)
                callee = self.program.function(_unwrap(target))
                args = self.call_args(node.args)
                return self.call(callee, args, node, self.call_keywords(node))
            self.program.guard("item", self.namespace, name, target)
            return self.call_value(target, name, node)
        if node.keywords:
            self.unsupported("a keyword argument", node)
        if getattr(builtins, name, None) is not None and self.builtins.get(name) is getattr(builtins, name):
            self.program.guard("builtin", self.namespace, name, self.builtins, getattr(builtins, name))
            return self.builtin(name, node)
        self.unsupported(f"a call of '{name}'", node)

    def object_call(self, base, node):
        if base[0] == BOTTOM:
            raise _Pending
        if base[0] == NONE:
            self.fail("True")
            return BOTTOM, ["0"]
        if not isinstance(base[0], ObjT):
            self.unsupported("a call of something that is not a named function, class or callable object", node)
        # Call syntax looks up __call__ on the class, ignoring an instance
        # field of that name. Freeze the receiver before argument effects.
        receiver = self.temp(self.handle(base[0], base[1], node))
        args = self.call_args(node.args)
        return self.method_call(base[0], receiver, "__call__", args, node, self.call_keywords(node))

    def class_named(self, node):
        """The class a bare name refers to, or None."""
        if isinstance(node, ast.Name) and node.id not in self.info.locals:
            value = self.namespace.get(node.id)
            if isinstance(value, type):
                self.program.guard("item", self.namespace, node.id, value)
                return value
        return None

    def class_attribute(self, owner, attr, node):
        """``Class.attr``: a constant, or an object or list held by the class."""
        definer = next((klass for klass in owner.__mro__ if attr in vars(klass)), None)
        if definer is None or definer is object:
            self.unsupported(f"'{owner.__name__}.{attr}'", node)
        for klass in owner.__mro__[:owner.__mro__.index(definer) + 1]:
            self.program.guard("own", klass, attr, vars(klass).get(attr))
        value = vars(definer)[attr]
        if type(value) in (int, float, bool) or value is None:
            return self.constant(value, node)
        if type(value) is list or _is_ndarray(value) or (not isinstance(value, (type, FunctionType, pytypes.ModuleType))
                                   and type(value).__module__ != "builtins"
                                   and _object_problem(type(value)) is None):
            return self.program.global_value(vars(definer), attr, value, key=(id(definer), attr))
        self.unsupported(f"'{owner.__name__}.{attr}', which holds {type(value).__name__}", node)

    def call_args(self, args):
        """Evaluated arguments; ``*t`` of a tuple adds its items."""
        out = []
        for arg in args:
            if isinstance(arg, ast.Starred):
                kind, codes = self.expr(arg.value)
                if kind == BOTTOM:
                    # Its type comes from a later pass; until then the call has none.
                    raise _Pending
                if not isinstance(kind, TupT) or kind.nullable:
                    self.unsupported(f"*{_describe(kind)} as arguments", arg)
                at = 0
                for item in kind.items:
                    out.append((item, codes[at:at + _width(item)]))
                    at += _width(item)
            else:
                out.append(self.expr(arg))
        return out

    def method_call(self, kind, receiver, name, args, node, keywords=(), after=None):
        """Call method ``name`` on an object of ``kind``. When its classes resolve the
        name to different functions, branch on the object's tag. With ``after``, the
        method is looked up past that class, as ``super()`` does."""
        groups, missing = {}, []
        for cls in sorted(kind.classes, key=self.program.tag):
            mro = cls.__mro__[:-1] if after is None else cls.__mro__[cls.__mro__.index(after) + 1:-1]
            found = next((vars(klass)[name] for klass in mro if name in vars(klass)), None)
            if found is None:
                missing.append(cls)
                continue
            if not isinstance(found, FunctionType):
                self.unsupported(f"'{cls.__name__}.{name}' is not a plain method", node)
            for klass in mro:
                # What each class defines itself decides which function runs.
                self.program.guard("own", klass, name, vars(klass).get(name))
            groups.setdefault(_unwrap(found), []).append(cls)
        if not groups:
            self.unsupported(f"'{_describe(kind)}' has no method '{name}'", node)
        callees = []
        for fn, classes in groups.items():
            info = self.program.function(fn, classes[0])
            bound = self.bind_call(info, [(ObjT(kind.cls, False, classes), [receiver])] + list(args), keywords, node)
            callees.append((self.program.specialize(info, bound), classes))
        if len(callees) == 1 and not missing:
            callee, classes = callees[0]
            return self.call(callee, [(ObjT(kind.cls, False, classes), [receiver])] + args, node, keywords)
        joined = BOTTOM
        for callee, _ in callees:
            joined = self.program.join(joined, callee.ret)
        width = 0 if joined in (NONE, BOTTOM) else _width(joined)
        self.counter += 1
        results = [f"t{self.counter}_{index}" for index in range(width)]
        tag = self.temp(f"I[{receiver}]")
        for number, (callee, classes) in enumerate(callees):
            test = " or ".join(f"{tag} == {self.program.tag(cls)}" for cls in classes)
            self.emit(f"{'if' if number == 0 else 'elif'} {test}:")
            self.depth += 1
            kind_i, codes_i = self.call(callee, [(ObjT(kind.cls, False, classes), [receiver])] + list(args), node,
                                        keywords)
            if width:
                for result, code in zip(results, self.coerce(kind_i, codes_i, joined)):
                    self.emit(f"{result} = {code}")
            self.depth -= 1
        self.emit("else:")
        self.depth += 1
        # A class without the method: Python raises AttributeError.
        self.emit("st[0] = 1")
        self.emit(f"top[3] = {self.where()}")
        self.emit(self.bail())
        self.depth -= 1
        if joined in (NONE, BOTTOM):
            return joined, (["-1"] if joined == NONE else ["0"])
        return joined, results

    def call(self, callee, args, node, keywords=()):
        if any(kind == BOTTOM for kind, _ in args) or any(kind == BOTTOM for _, (kind, _) in keywords):
            # An argument not typed in this pass would get a copy of its own typed
            # from nothing: call once it is known.
            raise _Pending
        if callee.sink:
            args = self.bind_call(callee, args[:-1], keywords, node) + [args[-1]]
        else:
            args = self.bind_call(callee, args, keywords, node)
        callee = self.program.specialize(callee, args)
        fn = callee.fn
        if callee.generator and not callee.sink:
            self.unsupported(f"generator '{fn.__qualname__}' used other than by a loop or sum(), any(), ...", node)
        if callee.coroutine != (node is getattr(self, "awaited", None)):
            self.unsupported(f"'{fn.__qualname__}' called without await, or an await of a plain function", node)
        passed = []
        for name, (kind, codes) in zip(callee.params, args):
            wanted = self.program.widen(callee.vars, name, kind)
            coerced = self.coerce(kind, codes, wanted)
            # A literal argument would make Numba compile a second version of a
            # recursive function, which its disk cache cannot reload.
            passed += _typed(wanted, coerced) if callee.recursive else coerced
        if callee not in self.program.order:
            self.program.order.append(callee)
        self.program.calls.setdefault(self.info, set()).add(callee)
        invoke = f"{callee.name}(F, I, top, st{''.join(', ' + code for code in passed)})"
        if callee.recursive:
            self.emit("top[1] += 1")
            self.fail("top[1] > top[2]")
        kind = callee.ret
        if kind in (NONE, BOTTOM):
            self.emit(invoke)
            self.check()
            codes = ["-1"] if kind == NONE else ["0"]
        elif callee.constant is not None:
            # Every return gives the same constant: use it, so tests on it fold.
            self.emit(invoke)
            self.check()
            codes = list(callee.constant)
        else:
            self.counter += 1
            codes = [f"t{self.counter}_{index}" for index in range(_width(kind))]
            self.emit(f"{', '.join(codes)} = {invoke}")
            self.check()
        if callee.recursive:
            self.emit("top[1] -= 1")
        return self.remember_zero(kind, codes, self.program.zero_returns.get(callee, set()))

    def construct(self, cls, node):
        fields = self.program.register(cls)
        args = self.call_args(node.args)
        keywords = self.call_keywords(node)
        made = self.temp(f"alloc(I, top, st, {self.program.layout(cls)[1]})")
        self.object_allocations[made] = cls
        self.check()
        if self.program.polymorphic(_root(cls)):
            self.emit(f"I[{made}] = {self.program.tag(cls)}")
        init = getattr(cls, "__init__")
        if init is object.__init__:
            if args or keywords:
                self.unsupported(f"arguments to '{cls.__name__}', which has no __init__", node)
        else:
            callee = self.program.function(_unwrap(init), cls)
            self.call(callee, [(ObjT(cls), [made])] + args, node, keywords)
        del fields
        return ObjT(cls), [made]

    def math_call(self, name, node):
        if name in _MATH_EXTRA and getattr(math, name, None) is _MATH_EXTRA[name]:
            return self.math_extra(name, node)
        if name not in MATH or getattr(math, name, None) is not MATH[name] or len(node.args) != 1:
            self.unsupported(f"math.{name}", node)
        self.program.guard("item", math.__dict__, name, MATH[name])
        kind, codes = self.present(*self.expr(node.args[0]))
        if kind == BOTTOM:
            return BOTTOM, ["0"]
        self.numeric(kind, node)
        value = self.temp(self.as_float(kind, codes))
        self.math_used.add(name)
        if name == "sqrt":
            self.fail(f"{value} < 0.0")
            return FLOAT, [self.temp(f"math.sqrt({value})")]
        if name == "fabs":
            return FLOAT, [f"math.fabs({value})"]
        result = self.temp(f"math.{name}({value})")
        # Python raises where the C function gives NaN from a number, or an infinity
        # from a finite one.
        self.fail(f"(math.isnan({result}) and not math.isnan({value})) or "
                  f"(math.isinf({result}) and not math.isinf({value}))")
        return FLOAT, [result]

    def builtin(self, name, node):
        if name == "isinstance" and len(node.args) == 2:
            return self.isinstance_test(node)
        if name in _REDUCERS and not node.keywords and len(node.args) in ((1, 2) if name == "sum" else (1,)):
            reduced = self.reduce(name, node)
            if reduced is not None:
                return reduced
        raw = [self.expr(arg) for arg in node.args]
        if name == "len" and len(raw) == 1 and isinstance(raw[0][0], NdT):
            return INT, [self.nd_length(*raw[0], node)]
        if name in ("abs", "min", "max") and any(_is_np(kind) for kind, _ in raw):
            if name == "abs" and len(raw) == 1 and raw[0][0] in (NPF, NPI, NPFQ, NPIQ):
                flag = _np_flag(*raw[0])
                return self.np_result(*self.builtin_plain(name, [self.present(*raw[0])], node), flag)
            self.unsupported(f"{name}() of numpy scalars", node)
        args = [self.present(*item) for item in raw]
        return self.builtin_plain(name, args, node)

    def builtin_plain(self, name, args, node):
        if any(kind == BOTTOM for kind, _ in args):
            return BOTTOM, ["0"]
        made = self.container_builtin(name, args, node)
        if made is not None:
            return made
        if name == "len" and len(args) == 1 and isinstance(args[0][0], ListT):
            return INT, [self.temp(f"I[{self.physical_index(args[0][1][0], True)}]")]
        if name == "len" and len(args) == 1 and isinstance(args[0][0], ObjT):
            kind, codes = args[0]
            receiver = self.temp(self.handle(kind, codes, node))
            return INT, [self.length(ObjT(kind.cls, False, kind.classes), receiver, node)]
        if name == "float" and len(args) == 1 and args[0][0] in (INT, FLOAT, BOOL, MIXED):
            return FLOAT, [self.as_float(*args[0])]
        if name == "int" and len(args) == 1 and args[0][0] in (INT, BOOL):
            return INT, [self.as_int(*args[0])]
        if name == "int" and len(args) == 1 and args[0][0] == FLOAT:
            value = self.temp(args[0][1][0])
            self.fail(f"not ({-2.0 ** 63!r} < {value} < {2.0 ** 63!r})")
            return INT, [self.temp(f"np.int64({value})")]
        if name == "abs" and len(args) == 1 and args[0][0] in (INT, BOOL):
            value = self.temp(self.as_int(*args[0]))
            self.fail(f"{value} == -{value} and {value} != 0")
            return INT, [f"abs({value})"]
        if name == "abs" and len(args) == 1 and args[0][0] == FLOAT:
            return FLOAT, [f"math.fabs({args[0][1][0]})"]
        if name in ("min", "max") and len(args) >= 2 and len({kind for kind, _ in args}) == 1 and (
                args[0][0] in (INT, FLOAT)):
            # Python returns the first of equal arguments.
            best = self.temp(args[0][1][0])
            for _, codes in args[1:]:
                other = self.temp(codes[0])
                best = self.temp(f"{other} if {other} {'<' if name == 'min' else '>'} {best} else {best}")
            return args[0][0], [best]
        if name == "int" and len(args) == 1 and args[0][0] == MIXED:
            value = self.temp(args[0][1][0])
            self.fail(f"not ({-2.0 ** 63!r} < {value} < {2.0 ** 63!r})")
            return INT, [self.temp(f"np.int64({value})")]
        if name == "abs" and len(args) == 1 and args[0][0] == MIXED:
            return MIXED, [self.temp(f"math.fabs({args[0][1][0]})"), args[0][1][1]]
        if name in ("min", "max") and len(args) >= 2 and all(kind in (INT, FLOAT, MIXED) for kind, _ in args):
            # Ints and floats together: Python compares the values exactly and keeps
            # the first of equal ones, with its type.
            best, flag = (self.temp(code) for code in self.as_mixed(*args[0]))
            for kind, codes in args[1:]:
                value, other = (self.temp(code) for code in self.as_mixed(kind, codes))
                better = self.temp(f"{value} {'<' if name == 'min' else '>'} {best}")
                best = self.temp(f"{value} if {better} else {best}")
                flag = self.temp(f"{other} if {better} else {flag}")
            return MIXED, [best, flag]
        self.unsupported(f"{name}() on {', '.join(_describe(kind) for kind, _ in args) or 'nothing'}", node)

    def isinstance_test(self, node):
        wanted = self.class_named(node.args[1])
        if wanted is None:
            self.unsupported("isinstance() with something other than one class", node)
        kind, codes = self.expr(node.args[0])
        if kind in (NONE, BOTTOM) or kind in (INT, FLOAT, BOOL, MIXED) or isinstance(kind, (ListT,) + _HANDLES):
            # None, numbers and lists are never instances of a class written in Python.
            return BOOL, ["False"]
        if not isinstance(kind, ObjT):
            self.unsupported(f"isinstance() of {_describe(kind)}", node)
        matching = sorted((cls for cls in kind.classes if issubclass(cls, wanted)), key=self.program.tag)
        if not matching:
            return BOOL, ["False"]
        handle = self.temp(codes[0])
        tests = []
        if kind.nullable:
            tests.append(f"{handle} >= 0")
        if len(matching) < len(kind.classes):
            tests.append("(" + " or ".join(f"I[{handle}] == {self.program.tag(cls)}" for cls in matching) + ")")
        return BOOL, [self.temp(" and ".join(tests)) if tests else "True"]

    # Objects that define their own truth or length

    def truth_hook(self, kind, node):
        """"__bool__" or "__len__" if the classes of ``kind`` decide truth by that
        method, None if by being an object; the same for every class, or refused."""
        hooks = set()
        for cls in kind.classes:
            names = [klass for klass in cls.__mro__[:-1] for name in ("__bool__", "__len__") if name in vars(klass)]
            for klass in cls.__mro__[:-1]:
                for name in ("__bool__", "__len__"):
                    self.program.guard("own", klass, name, vars(klass).get(name))
            found = None
            for klass in cls.__mro__[:-1]:
                if "__bool__" in vars(klass):
                    found = "__bool__"
                    break
            if found is None and names:
                found = "__len__"
            hooks.add(found)
        if len(hooks) > 1:
            self.unsupported(f"the truth of '{_describe(kind)}', whose classes decide it differently", node)
        return hooks.pop()

    def length(self, kind, receiver, node):
        """``len(obj)``: its __len__, which must give an int of at least 0."""
        result, codes = self.method_call(kind, receiver, "__len__", [], node)
        if result == BOTTOM:
            return "0"
        if result not in (INT, BOOL):
            self.unsupported(f"__len__ of '{_describe(kind)}' giving {_describe(result)}", node)
        value = self.temp(self.as_int(result, codes))
        self.fail(f"{value} < 0")
        return value

    def object_truth(self, kind, codes, hook, node):
        """The truth of an object of a class with __bool__ or __len__."""
        value = self.temp("False")
        handle = self.temp(codes[0])
        plain = ObjT(kind.cls, False, kind.classes)
        if kind.nullable:
            self.emit(f"if {handle} >= 0:")
            self.depth += 1
        if hook == "__len__":
            self.emit(f"{value} = {self.length(plain, handle, node)} != 0")
        else:
            result, found = self.method_call(plain, handle, "__bool__", [], node)
            if result not in (BOOL, BOTTOM):
                self.unsupported(f"__bool__ of '{_describe(kind)}' giving {_describe(result)}", node)
            self.emit(f"{value} = {found[0] if result == BOOL else 'False'}")
        if kind.nullable:
            self.depth -= 1
        return value

    # numpy scalars and arrays

    def np_result(self, kind, codes, flag):
        """A Python number of ``kind`` made a numpy scalar where ``flag`` holds."""
        if kind == BOTTOM or flag == "False":
            return kind, codes
        if kind not in _NP_DEFINITE:
            self.unsupported(f"{_describe(kind)} that may be a numpy scalar", None)
        if flag == "True":
            return _NP_DEFINITE[kind], codes[:1]
        return _NP_MAYBE[kind], [codes[0], flag]

    def np_binop(self, op, left, right, node):
        """Arithmetic with a numpy scalar: the Python result, of numpy type. While
        results stay exact the values agree; where numpy would warn and go on
        (division by zero, int overflow) the Python form hands the call back."""
        for kind, _ in (left, right):
            if kind in (NPB, NPBQ):
                self.unsupported(f"arithmetic on {_describe(kind)}", node)
        flags = [_np_flag(*left), _np_flag(*right)]
        kind, codes = self.binop(op, self.present(*left), self.present(*right), node)
        flag = "True" if "True" in flags else self.temp(" or ".join(flags))
        return self.np_result(kind, codes, flag)

    def nd_field(self, h, kind, part, k=0):
        """The slot code of an array block's address, a shape, a stride or its root."""
        offset = {"address": 0, "shape": 1 + k, "stride": 1 + kind.ndim + k, "root": 1 + 2 * kind.ndim}[part]
        return f"I[{h} + {offset}]" if offset else f"I[{h}]"

    def nd_length(self, kind, codes, node):
        return self.temp(self.nd_field(codes[0], kind, "shape", 0))

    def nd_attribute(self, kind, codes, attr, node):
        h = codes[0]
        if attr == "shape":
            return TupT([INT] * kind.ndim), [self.temp(self.nd_field(h, kind, "shape", k)) for k in range(kind.ndim)]
        if attr == "ndim":
            return INT, [str(kind.ndim)]
        if attr == "size":
            return INT, [self.temp(" * ".join(self.nd_field(h, kind, "shape", k) for k in range(kind.ndim)))]
        self.unsupported(f"attribute '{attr}' of an array", node)

    def nd_indices(self, index, node):
        """The evaluated integer indices of ``array[index]``."""
        parts = index.elts if isinstance(index, ast.Tuple) else [index]
        for part in parts:
            if isinstance(part, (ast.Slice, ast.Starred)) or (isinstance(part, ast.Constant) and part.value in (None, ...)):
                self.unsupported("an array index that is not an int", node)
        return [self.expr(part) for part in parts]

    def nd_locate(self, kind, codes, index, node):
        """(block, address temp, axes used) for ``array[index]`` with integer
        indices; ``index`` is an expression or a list of evaluated indices."""
        parts = index if isinstance(index, list) else self.nd_indices(index, node)
        if len(parts) > kind.ndim:
            self.unsupported("more indices than the array has dimensions", node)
        h = self.temp(codes[0])
        offsets = []
        for axis, (part_kind, part_codes) in enumerate(parts):
            if part_kind in (NPI, NPIQ):
                part_kind, part_codes = self.present(part_kind, part_codes)
            if part_kind == BOTTOM:
                self.program.changed = True
                part_kind, part_codes = INT, ["0"]
            if part_kind != INT:
                # A bool indexes as a mask, a float raises.
                self.unsupported(f"an array index that is {_describe(part_kind)}", node)
            size = self.temp(self.nd_field(h, kind, "shape", axis))
            at = self.temp(part_codes[0])
            self.emit(f"if {at} < 0:")
            self.emit(f"    {at} += {size}")
            self.fail(f"{at} < 0 or {at} >= {size}")
            offsets.append(f"{at} * {self.nd_field(h, kind, 'stride', axis)}")
        width = 1 if kind.dtype == "bool" else 8
        address = self.temp(f"{self.nd_field(h, kind, 'address')} + {width} * ({' + '.join(offsets)})")
        return h, address, len(parts)

    def nd_read(self, kind, codes, index, node):
        h, address, used = self.nd_locate(kind, codes, index, node)
        if used == kind.ndim:
            if kind.dtype == "float64":
                return NPF, [self.temp(f"nd_ld_f8({address})")]
            if kind.dtype == "int64":
                return NPI, [self.temp(f"nd_ld_i8({address})")]
            return NPB, [self.temp(f"nd_ld_b1({address}) != 0")]
        # A view of the remaining axes, on the same memory.
        self.program.array_views = True
        rest = NdT(kind.dtype, kind.ndim - used, kind.writable)
        view = self.temp(f"alloc(I, top, st, {2 + 2 * rest.ndim})")
        self.check()
        self.emit(f"I[{view}] = {address}")
        for k in range(rest.ndim):
            self.emit(f"{self.nd_field(view, rest, 'shape', k)} = {self.nd_field(h, kind, 'shape', used + k)}")
            self.emit(f"{self.nd_field(view, rest, 'stride', k)} = {self.nd_field(h, kind, 'stride', used + k)}")
        self.emit(f"{self.nd_field(view, rest, 'root')} = {self.nd_field(h, kind, 'root')}")
        return rest, [view]

    def nd_write(self, kind, address, value, node):
        """Store ``value`` at ``address`` as numpy converts it to the array's dtype."""
        self.program.arrays_written = True
        value_kind, value_codes = self.present(*value)
        if value_kind == BOTTOM:
            return
        if not kind.writable:
            # Python raises ValueError: the array is read-only.
            self.fail("True")
            return
        if value_kind not in (INT, FLOAT, BOOL, MIXED):
            self.unsupported(f"storing {_describe(value_kind)} in an array", node)
        if kind.dtype == "float64":
            self.emit(f"nd_st_f8({address}, {self.as_float(value_kind, value_codes)})")
        elif kind.dtype == "int64":
            if value_kind in (INT, BOOL):
                self.emit(f"nd_st_i8({address}, {self.as_int(value_kind, value_codes)})")
            else:
                number = self.temp(value_codes[0])
                # numpy raises for NaN and for floats outside 64 bits, else truncates.
                self.fail(f"not ({number} > -9.2e18 and {number} < 9.2e18)")
                self.emit(f"nd_st_i8({address}, np.int64({number}))")
        else:
            self.emit(f"nd_st_b1({address}, np.uint8(1 if {self.truth(value_kind, value_codes, node)} else 0))")

    def nd_store(self, base, index, value, node):
        kind, codes = base
        h, address, used = self.nd_locate(kind, codes, index, node)
        if used != kind.ndim:
            self.unsupported("assigning to part of an array", node)
        self.nd_write(kind, address, value, node)

    def nd_augment(self, base, index, op, operand, node):
        kind, codes = base
        h, address, used = self.nd_locate(kind, codes, index, node)
        if used != kind.ndim:
            self.unsupported("an in-place operator on part of an array", node)
        loads = {"float64": (NPF, "nd_ld_f8({})"), "int64": (NPI, "nd_ld_i8({})"), "bool": (NPB, "nd_ld_b1({}) != 0")}
        current_kind, load = loads[kind.dtype]
        current = current_kind, [self.temp(load.format(address))]
        self.nd_write(kind, address, self.binop(op, current, self.expr(operand), node), node)

    def nd_loop(self, node, kind, codes):
        """``for x in array``: its items (rows of a 2-d array), over its length at the start."""
        held = self.temp(codes[0])
        count, position = self.temp(self.nd_field(held, kind, "shape", 0)), self.temp("0")
        self.emit("while True:")
        self.depth += 1
        self.emit(f"if {position} >= {count}:")
        self.emit("    break")
        item = self.nd_read(kind, [held], [(INT, [position])], node)
        self.emit(f"{position} += 1")
        self.bind(node.target, item, node)
        self.body(node.body)
        self.depth -= 1

    def np_call(self, target, node):
        """A numpy function on scalars, or None if ``target`` is none of them."""
        import numpy as np

        table = {np.float64: "float64", np.int64: "int64", np.sqrt: "sqrt", np.abs: "abs", np.fabs: "fabs",
                 np.floor: "floor", np.ceil: "ceil", np.trunc: "trunc", np.isnan: "isnan", np.isinf: "isinf",
                 np.isfinite: "isfinite", np.minimum: "minimum", np.maximum: "maximum"}
        try:
            name = table.get(target)
        except TypeError:
            return None
        if name is None:
            return None
        if node.keywords:
            self.unsupported(f"numpy.{name} with keyword arguments", node)
        args = [self.present(*self.expr(arg)) for arg in node.args]
        if any(kind == BOTTOM for kind, _ in args):
            return BOTTOM, ["0"]
        wanted = 2 if name in ("minimum", "maximum") else 1
        if len(args) != wanted or any(kind not in (INT, FLOAT, BOOL) for kind, _ in args):
            self.unsupported(f"numpy.{name} of {', '.join(_describe(kind) for kind, _ in args)}", node)
        (kind, codes) = args[0]
        if name == "int64":
            if kind in (INT, BOOL):
                return NPI, [self.as_int(kind, codes)]
            number = self.temp(codes[0])
            self.fail(f"not ({number} > -9.2e18 and {number} < 9.2e18)")
            return NPI, [self.temp(f"np.int64({number})")]
        if name in ("minimum", "maximum"):
            (other_kind, other_codes) = args[1]
            sign = "<=" if name == "minimum" else ">="
            if {kind, other_kind} <= {INT, BOOL}:
                a, b = self.temp(self.as_int(kind, codes)), self.temp(self.as_int(other_kind, other_codes))
                return NPI, [self.temp(f"{a} if {a} {sign} {b} else {b}")]
            a = self.temp(self.as_float(kind, codes))
            b = self.temp(self.as_float(other_kind, other_codes))
            # numpy keeps a NaN from either side, and the first of equal values.
            return NPF, [self.temp(f"{a} if ({a} {sign} {b} or {a} != {a}) else {b}")]
        if name == "abs" and kind in (INT, BOOL):
            number = self.temp(self.as_int(kind, codes))
            # numpy wraps abs of the smallest int; Python does not.
            self.fail(f"{number} == -{number} and {number} != 0")
            return NPI, [f"abs({number})"]
        number = self.temp(self.as_float(kind, codes))
        if name == "float64":
            return NPF, [number]
        if name in ("isnan", "isinf", "isfinite"):
            return NPB, [self.temp(f"math.{name}({number})")]
        if name == "sqrt":
            # numpy warns and gives NaN below zero.
            self.fail(f"{number} < 0.0")
            return NPF, [self.temp(f"math.sqrt({number})")]
        if name in ("abs", "fabs"):
            return NPF, [self.temp(f"math.fabs({number})")]
        return NPF, [self.temp(f"np.{name}({number})")]

    # Module globals: modules, their functions and constants, and random.Random

    def module_member(self, node):
        """(module, value) for ``mod.attr`` where ``mod`` is a module held by a global
        (or a module attribute of one, as in ``os.path``), else None. The global and
        the module's attribute are guarded, so rebinding either sends calls back."""
        if not isinstance(node, ast.Attribute):
            return None
        base = node.value
        if isinstance(base, ast.Name):
            if base.id in self.info.locals:
                return None
            module = self.namespace.get(base.id)
            if not isinstance(module, pytypes.ModuleType):
                return None
            self.program.guard("item", self.namespace, base.id, module)
        else:
            outer = self.module_member(base)
            if outer is None or not isinstance(outer[1], pytypes.ModuleType):
                return None
            module = outer[1]
        space = vars(module)
        if node.attr not in space:
            self.unsupported(f"'{module.__name__}.{node.attr}'", node)
        value = space[node.attr]
        self.program.guard("item", space, node.attr, value)
        return module, value

    def module_value(self, module, value, node):
        """The value of a module's attribute read in compiled code."""
        space = vars(module)
        if type(value) in (int, float, bool) or value is None:
            self.program.guard("const", space, node.attr, value)
            return self.constant(value, node)
        if type(value) is list or type(value) is random.Random or _is_ndarray(value) or (
                not isinstance(value, (type, FunctionType, pytypes.ModuleType, pytypes.BuiltinFunctionType))
                and type(value).__module__ != "builtins" and _object_problem(type(value)) is None):
            return self.program.global_value(space, node.attr, value)
        self.unsupported(f"'{module.__name__}.{node.attr}', which holds {type(value).__name__}", node)

    def call_value(self, target, label, node):
        """A call of ``target``, a module global or module attribute the caller has
        guarded: a function, a class, a math or operator function, or a method of a
        random.Random generator held by a module (``random.random``)."""
        known = getattr(target, "__name__", None)
        if known in MATH and target is MATH[known]:
            return self.math_call(known, node)
        if known in _MATH_EXTRA and target is _MATH_EXTRA[known]:
            return self.math_extra(known, node)
        if type(target).__module__ == "numpy" or getattr(target, "__module__", None) == "numpy":
            found = self.np_call(target, node)
            if found is not None:
                return found
            self.unsupported(f"numpy function '{label}'", node)
        if isinstance(target, type):
            return self.construct(target, node)
        if isinstance(target, FunctionType):
            callee = self.program.function(_unwrap(target))
            args = self.call_args(node.args)
            return self.call(callee, args, node, self.call_keywords(node))
        if type(target) in (MethodType, pytypes.BuiltinMethodType) and type(
                getattr(target, "__self__", None)) is random.Random:
            # random.randrange is a method of a hidden generator; random.random and
            # random.getrandbits are its C methods.
            name = target.__name__
            if type(target) is MethodType and getattr(random.Random, name, None) is not target.__func__ or (
                    type(target) is not MethodType and name not in ("random", "getrandbits")):
                self.unsupported(f"'{label}', which is not a method of random.Random", node)
            generator = target.__self__
            holders = self.program.__dict__.setdefault("generator_holders", {})
            holder = holders.setdefault(id(generator), {"gen": generator})
            _, codes = self.program.global_value(holder, "gen", generator, key=("rng", id(generator)))
            return self.generator_call(codes[0], name, node)
        operator_node = _operator_node(target, node)
        if operator_node is not None:
            return self.expr(operator_node)
        self.unsupported(f"a call of '{label}'", node)

    def math_extra(self, name, node):
        """math.floor, ceil and trunc (an int, or a fallback outside 64 bits) and
        math.isnan, isinf and isfinite."""
        if len(node.args) != 1 or node.keywords:
            self.unsupported(f"math.{name} with other than one argument", node)
        self.program.guard("item", math.__dict__, name, _MATH_EXTRA[name])
        kind, codes = self.present(*self.expr(node.args[0]))
        if kind == BOTTOM:
            return BOTTOM, ["0"]
        self.numeric(kind, node)
        if name in ("isnan", "isinf", "isfinite"):
            if kind in (INT, BOOL):
                return BOOL, ["True" if name == "isfinite" else "False"]
            return BOOL, [self.temp(f"math.{name}({codes[0]})")]
        if kind in (INT, BOOL):
            return INT, [self.as_int(kind, codes)]
        value = self.temp(codes[0])
        # NaN fails both tests; Python raises for it and for infinities.
        self.fail(f"not ({value} > -9.2e18 and {value} < 9.2e18)")
        return INT, [self.temp(f"np.int64(math.{name}({value}))")]

    def generator_call(self, handle, name, node):
        """Method ``name`` of the random.Random whose block is at ``handle``, as
        Lib/random.py defines it, on the Mersenne Twister in recompyler._rng."""
        from . import _rng

        if name not in _rng.METHODS or node.keywords:
            self.unsupported(f"random method '{name}'" + (" with keyword arguments" if node.keywords else ""), node)
        for cls, attr, found in _rng.guards():
            self.program.guard("attr", cls, attr, found)
        self.program.rng_used = True
        args = [self.present(*self.expr(arg)) for arg in node.args]
        if any(kind == BOTTOM for kind, _ in args):
            return BOTTOM, ["0"]
        h = self.temp(handle)
        count = len(args)

        def whole(position):
            kind, codes = args[position]
            if kind not in (INT, BOOL):
                self.unsupported(f"random.{name}() of {_describe(kind)}", node)
            return self.temp(self.as_int(kind, codes))

        if name == "random" and count == 0:
            return FLOAT, [self.temp(f"mt_random(I, {h})")]
        if name == "getrandbits" and count == 1:
            bits = whole(0)
            # Python raises below 0; at 64 bits and up the result may not fit.
            self.fail(f"{bits} < 0 or {bits} > 63")
            return INT, [self.temp(f"mt_bits(I, {h}, {bits})")]
        if name == "randrange" and count == 1:
            stop = whole(0)
            self.fail(f"{stop} <= 0")
            return INT, [self.temp(f"mt_below(I, {h}, {stop})")]
        if name == "randrange" and count in (2, 3):
            start, stop = whole(0), whole(1)
            width = self.temp(f"sub_i(st, {stop}, {start})")
            self.check()
            unit = count == 2 or (isinstance(node.args[2], ast.Constant) and type(node.args[2].value) is int
                                  and node.args[2].value == 1)
            if unit:
                if count == 3:
                    whole(2)
                self.fail(f"{width} <= 0")
                return INT, [self.temp(f"{start} + mt_below(I, {h}, {width})")]
            step = whole(2)
            self.fail(f"{step} == 0")
            padded = self.temp(f"add_i(st, {width}, {step} - 1) if {step} > 0 else add_i(st, {width}, {step} + 1)")
            self.check()
            n = self.temp(f"floordiv_i(st, {padded}, {step})")
            self.check()
            self.fail(f"{n} <= 0")
            offset = self.temp(f"mul_i(st, {step}, mt_below(I, {h}, {n}))")
            self.check()
            value = self.temp(f"add_i(st, {start}, {offset})")
            self.check()
            return INT, [value]
        if name == "randint" and count == 2:
            low, high = whole(0), whole(1)
            self.fail(f"{high} < {low}")
            span = self.temp(f"sub_i(st, {high}, {low})")
            self.check()
            size = self.temp(f"add_i(st, {span}, 1)")
            self.check()
            return INT, [self.temp(f"{low} + mt_below(I, {h}, {size})")]
        if name == "uniform" and count == 2:
            low, high = ((kind, [self.temp(code) for code in codes]) for kind, codes in args)
            difference = self.binop(ast.Sub, high, low, node)
            drawn = FLOAT, [self.temp(f"mt_random(I, {h})")]
            return self.binop(ast.Add, low, self.binop(ast.Mult, difference, drawn, node), node)
        if name in ("choice", "shuffle", "sample") and count in (1, 2):
            kind, codes = args[0]
            if type(kind) is not ListT:
                self.unsupported(f"random.{name}() of {_describe(kind)}", node)
            sequence = self.temp(codes[0])
            if name == "choice" and count == 1:
                size = self.temp(f"I[{sequence}]")
                self.fail(f"{size} == 0")
                self.check_item(kind.elem, node)
                where = self.temp(f"I[{sequence} + 2] + mt_below(I, {h}, {size})")
                return kind.elem, [self.temp(code) for code in self.slot(kind.elem, where)]
            if name == "shuffle" and count == 1:
                _find(kind.cell).mutated = True
                self.emit(f"mt_shuffle(I, {h}, {sequence})")
                return NONE, ["-1"]
            if name == "sample" and count == 2:
                wanted = whole(1)
                self.math_used.add("log")
                made = self.temp(f"mt_sample(I, top, st, {h}, {sequence}, {wanted})")
                self.check()
                # A new list of the population's items: it shares their type.
                return kind, [made]
        if name == "seed" and count == 1:
            value = whole(0)
            self.fail(f"{value} == {INT_MIN}")
            self.emit(f"mt_seed(I, {h}, {value})")
            return NONE, ["-1"]
        self.unsupported(f"random.{name}() with {count} arguments", node)

    def list_method(self, base, name, node):
        (kind, codes), cell = base, _find(base[0].cell)
        if isinstance(kind, ArrT):
            self.unsupported(f"array method '{name}'", node)
        args = [self.expr(arg) for arg in node.args]
        if name == "append" and len(args) == 1:
            item_kind, item_codes = args[0]
            self.program.widen_cell(cell, item_kind)
            cell.mutated = True
            elem = kind.elem
            self.check_item(elem, node)
            where = self.temp(f"list_room(I, top, st, {codes[0]})")
            self.check()
            self.store(elem, where, self.coerce(item_kind, item_codes, elem))
            return NONE, ["-1"]
        if name == "pop" and not args:
            cell.mutated = True
            size = self.temp(f"I[{codes[0]}]")
            self.fail(f"{size} == 0")
            self.check_item(kind.elem, node)
            value = [self.temp(code) for code in self.slot(kind.elem, f"I[{codes[0]} + 2] + {size} - 1")]
            self.emit(f"I[{codes[0]}] = {size} - 1")
            return kind.elem, value
        return self.more_list_method(kind, codes, cell, name, args, node)

    # Statements

    def body(self, statements):
        before = len(self.lines)
        for statement in statements:
            method = getattr(self, "do_" + type(statement).__name__, None)
            if method is None:
                self.unsupported(type(statement).__name__, statement)
            self.line = statement.lineno
            method(statement)
        if len(self.lines) == before:
            self.emit("pass")

    def block(self, opener, statements):
        self.emit(opener)
        self.depth += 1
        self.body(statements)
        self.depth -= 1

    def do_Pass(self, node):
        pass

    def do_Break(self, node):
        self.leave_check(node)
        if self.loop_flags and self.loop_flags[-1] is not None:
            self.emit(f"{self.loop_flags[-1]} = True")
        self.emit("break")

    def loop_else(self, node, emit_loop):
        """A loop, then its else block, which runs unless a break left the loop."""
        flag = None
        if node.orelse:
            flag = self.temp("False")
        self.loop_flags.append(flag)
        try:
            emit_loop()
        finally:
            self.loop_flags.pop()
        if node.orelse:
            self.block(f"if not {flag}:", node.orelse)

    def do_Continue(self, node):
        self.leave_check(node)
        self.emit("continue")

    def leave_check(self, node):
        if self.finals and self.finals[-1][1] == self.loop_depth:
            self.unsupported("break or continue out of a try ... finally", node)

    def do_Try(self, node):
        if node.handlers or node.orelse:
            self.try_except(node)
            return
        if any(isinstance(item, (ast.Return, ast.Break, ast.Continue))
               for statement in node.finalbody for item in ast.walk(statement)):
            self.unsupported("return, break or continue in a finally block", node)
        # An exception hands the whole call back to Python, so the finally block runs
        # only on the way out by return (in do_Return) or by falling through.
        self.finals = self.finals + [(node.finalbody, self.loop_depth)]
        self.body(node.body)
        self.finals = self.finals[:-1]
        if not _terminates(node.body):
            self.body(node.finalbody)

    def try_except(self, node):
        """``try`` with except or else blocks. Where Python would raise, compiled code
        hands the whole call back to Python, which then runs the handlers itself; so
        only the body, the else block and the finally block are compiled."""
        if any(isinstance(item, (ast.Return, ast.Break, ast.Continue))
               for statement in node.finalbody for item in ast.walk(statement)):
            self.unsupported("return, break or continue in a finally block", node)
        if node.finalbody:
            self.finals = self.finals + [(node.finalbody, self.loop_depth)]
        self.body(node.body)
        ends = _terminates(node.body)
        if node.orelse and not ends:
            self.body(node.orelse)
            ends = _terminates(node.orelse)
        if node.finalbody:
            self.finals = self.finals[:-1]
            if not ends:
                self.body(node.finalbody)

    def expr_ListComp(self, node):
        name = node.recompyler_list
        self.assign(name, *self.expr(ast.copy_location(ast.List(elts=[], ctx=ast.Load()), node)))
        inner = ast.Expr(value=ast.Call(func=ast.Attribute(value=ast.Name(id=name, ctx=ast.Load()), attr="append",
                                                           ctx=ast.Load()), args=[node.elt], keywords=[]))
        for generator in reversed(node.generators):
            for test in reversed(generator.ifs):
                inner = ast.If(test=test, body=[inner], orelse=[])
            inner = ast.For(target=generator.target, iter=generator.iter, body=[inner], orelse=[])
        for item in ast.walk(inner):
            if "lineno" in item._attributes and not hasattr(item, "lineno"):
                ast.copy_location(item, node)
        self.body([inner])
        return self.expr(ast.copy_location(ast.Name(id=name, ctx=ast.Load()), node))

    def do_Expr(self, node):
        if isinstance(node.value, ast.Constant) and isinstance(node.value.value, str):
            return
        if isinstance(node.value, ast.Yield):
            # Left only in a generator's collecting form: inlined generators have
            # their yields rewritten (_InlineYields).
            if not self.info.sink:
                self.unsupported("a yield", node)
            value = node.value.value or ast.Constant(None)
            append = ast.Call(func=ast.Attribute(value=ast.Name(id=_OUT, ctx=ast.Load()), attr="append",
                                                 ctx=ast.Load()), args=[value], keywords=[])
            self.expr(_locate(append, node))
            return
        if not isinstance(node.value, ast.Call):
            self.unsupported("an expression statement", node)
        func = node.value.func
        if (isinstance(func, ast.Name) and func.id == "print" and "print" not in self.info.locals
                and "print" not in self.namespace and self.builtins.get("print") is builtins.print):
            # Observable output cannot run speculatively. Exit before even its
            # arguments: rollback and Python replay perform every effect once.
            # Local/global callables named print still follow ordinary dispatch.
            self.fail("True")
            return
        self.expr(node.value)

    def do_Return(self, node):
        kind, codes = (NONE, ["-1"]) if node.value is None else self.expr(node.value)
        self.program.meet_zero(self.program.zero_returns.get(self.info, set()), self.zero_facts(kind, codes))
        joined = self.program.widen(self.info.__dict__, "ret", kind)
        out = [] if joined in (NONE, BOTTOM) else self.coerce(kind, codes, joined)
        self.returned.append(tuple(out))
        if self.finals:
            # The value is worked out first; then the finally blocks run, innermost first.
            out = [self.temp(code) for code in out]
            saved = self.finals
            for depth in range(len(saved) - 1, -1, -1):
                self.finals = saved[:depth]
                self.body(saved[depth][0])
            self.finals = saved
        self.emit("return " + ", ".join(out) if out else "return")

    def do_Raise(self, node):
        self.emit("st[0] = 1")
        self.emit(f"top[3] = {self.where()}")
        self.emit(self.bail())

    def static_truth(self, node):
        """The truth of a test on a module constant (``if tracing:``), or None."""
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.Not):
            inner = self.static_truth(node.operand)
            return None if inner is None else not inner
        if isinstance(node, ast.Name) and node.id not in self.info.locals and node.id in self.namespace:
            value = self.namespace[node.id]
            if type(value) in (int, float, bool) or value is None:
                self.program.guard("const", self.namespace, node.id, value)
                return bool(value)
        return None

    def do_If(self, node):
        truth = self.static_truth(node.test)
        test = None
        if truth is None:
            self.unknown_test = False
            test = self.cond(node.test)
            if self.unknown_test:
                # Typing either branch on a guess would widen types for good, and
                # folding on a placeholder could pick the wrong branch: compile
                # neither, and type them in a pass where the test is known. A test
                # that never becomes known leaves the types unsettled, and the
                # region is refused.
                self.program.changed = True
                self.emit("pass")
                return
            truth = _literal_truth(test)
        if truth is not None:
            # Only the branch the constant picks is compiled; the guard on the
            # constant sends calls back to Python if it ever changes.
            chosen = node.body if truth else node.orelse
            if chosen:
                self.body(chosen)
            return
        self.block(f"if {test}:", node.body)
        if node.orelse:
            self.block("else:", node.orelse)

    def do_Assert(self, node):
        self.fail(f"not {self.cond(node.test)}")

    def do_While(self, node):
        self.loop_else(node, lambda: self.while_loop(node))

    def while_loop(self, node):
        self.emit("while True:")
        self.depth += 1
        self.loop_depth += 1
        self.emit(f"if not {self.cond(node.test)}:")
        self.emit("    break")
        self.body(node.body)
        self.loop_depth -= 1
        self.depth -= 1

    def do_For(self, node):
        if not isinstance(node.target, (ast.Name, ast.Tuple)):
            self.unsupported("a loop target that is not names", node)
        def loop():
            self.loop_depth += 1
            try:
                self.for_loop(node)
            finally:
                self.loop_depth -= 1

        self.loop_else(node, loop)

    def do_AsyncFor(self, node):
        if node.orelse or not isinstance(node.target, (ast.Name, ast.Tuple)):
            self.unsupported("async for ... else, or a loop target that is not names", node)
        self.loop_depth += 1
        try:
            if not self.generator_loop(node, True):
                self.unsupported("async for over something other than an async generator", node)
        finally:
            self.loop_depth -= 1

    def for_loop(self, node):
        if self.generator_loop(node):
            return
        iterable = node.iter
        name = node.target.id if isinstance(node.target, ast.Name) else None
        if isinstance(iterable, ast.Name) and iterable.id not in self.info.locals and (
                type(self.namespace.get(iterable.id)) is range):
            # A range held by a module global: its bounds are constants.
            found = self.namespace[iterable.id]
            self.program.guard("item", self.namespace, iterable.id, found)
            iterable = ast.copy_location(ast.Call(func=ast.Name(id="range", ctx=ast.Load()), keywords=[], args=[
                ast.Constant(found.start), ast.Constant(found.stop), ast.Constant(found.step)]), iterable)
        if (isinstance(iterable, ast.Call) and isinstance(iterable.func, ast.Name) and iterable.func.id == "range"
                and "range" not in self.info.locals and "range" not in self.namespace
                and self.builtins.get("range") is range and not iterable.keywords and 1 <= len(iterable.args) <= 3):
            self.program.guard("builtin", self.namespace, "range", self.builtins, range)
            bounds = []
            for arg in iterable.args:
                kind, codes = self.expr(arg)
                if kind in (NPI, NPIQ):
                    kind, codes = self.present(kind, codes)
                if kind not in (INT, BOOL, BOTTOM):
                    self.unsupported(f"range() of {_describe(kind)}", node)
                bounds.append(self.temp(self.as_int(kind, codes) if kind != BOTTOM else "0"))
            if len(bounds) == 3:
                self.fail(f"{bounds[2]} == 0")
            self.counter += 1
            step = f"t{self.counter}"
            self.emit(f"for {step} in range({', '.join(bounds)}):")
            self.depth += 1
            if name is None:
                self.unsupported("unpacking a number from range()", node)
            self.assign(name, INT, [step])
            self.body(node.body)
            self.depth -= 1
            return
        if self.container_loop(node, iterable):
            return
        kind, codes = self.expr(iterable)
        if isinstance(kind, NdT):
            self.program.arrays_used = True
            return self.nd_loop(node, kind, codes)
        if kind == BOTTOM:
            kind = ListT()
        if not isinstance(kind, ListT):
            self.unsupported(f"a loop over {_describe(kind)}", node)
        # By position, reading the length each time, as Python's list iterator does.
        held, position = self.temp(codes[0]), self.temp("0")
        self.emit("while True:")
        self.depth += 1
        self.emit(f"if {position} >= I[{self.physical_index(held, True)}]:")
        self.emit("    break")
        elem = kind.elem
        self.check_item(elem, node)
        data = self.physical_index(f"{held} + 2", True)
        item = [self.temp(code) for code in self.slot(elem, f"I[{data}] + {position}", nonnegative=True)]
        self.emit(f"{position} += 1")
        self.bind(node.target, (elem, item), node)
        self.body(node.body)
        self.depth -= 1

    # Generators

    def peek_or_none(self, node):
        """peek(), or None for an expression that is not a value of its own here (a
        module, a global range)."""
        try:
            return self.peek(node)
        except Unsupported:
            return None

    def resolve_method(self, kind, name):
        """(function, class) that method ``name`` is for every class an object of
        ``kind`` may be, or None."""
        if not isinstance(kind, ObjT):
            return None
        found = set()
        for cls in kind.classes:
            for klass in cls.__mro__[:-1]:
                self.program.guard("own", klass, name, vars(klass).get(name))
            found.add(next((vars(klass)[name] for klass in cls.__mro__[:-1] if name in vars(klass)), None))
        if len(found) != 1 or not isinstance(next(iter(found)), FunctionType):
            return None
        return _unwrap(found.pop()), min(kind.classes, key=self.program.tag)

    def generator_source(self, iterable, is_async=False):
        """(function, owner, argument expressions, whether the first is a receiver)
        if looping over ``iterable`` runs a generator function of the region (an
        async one for ``async for``), else None."""
        flag = 0x200 if is_async else 0x20

        def wanted(fn):
            return isinstance(fn, FunctionType) and bool(_unwrap(fn).__code__.co_flags & flag)

        if isinstance(iterable, ast.Call):
            if iterable.keywords or any(isinstance(arg, ast.Starred) for arg in iterable.args):
                return None
            func = iterable.func
            if isinstance(func, ast.Name):
                if func.id in self.info.locals or func.id not in self.namespace:
                    return None
                target = self.namespace[func.id]
                if not wanted(target):
                    return None
                self.program.guard("item", self.namespace, func.id, target)
                return _unwrap(target), None, list(iterable.args), False
            if not isinstance(func, ast.Attribute) or self.is_math(func.value):
                return None
            owner = self.class_named(func.value)
            if owner is not None:
                found = next((vars(klass)[func.attr] for klass in owner.__mro__[:-1] if func.attr in vars(klass)), None)
                if not wanted(found):
                    return None
                self.program.guard("attr", owner, func.attr, found)
                return _unwrap(found), owner, list(iterable.args), False
            found = self.resolve_method(self.peek_or_none(func.value), func.attr)
            if found is None or not wanted(found[0]):
                return None
            return found[0], found[1], [func.value] + list(iterable.args), True
        if isinstance(iterable, (ast.Name, ast.Attribute, ast.Subscript)):
            # An object whose __iter__ (or __aiter__) is a generator function.
            found = self.resolve_method(self.peek_or_none(iterable), "__aiter__" if is_async else "__iter__")
            if found is not None and wanted(found[0]):
                return found[0], found[1], [iterable], True
        return None

    def generator_loop(self, node, is_async=False):
        """A loop over a generator expression or a generator of the region: the
        generator's body inlined around the loop's (_inline_generator). A loop over a
        generator that is already being inlined here, which is recursion, calls the
        generator's collecting form instead. True if handled."""
        if isinstance(node.iter, ast.GeneratorExp) and not is_async:
            self.body(self.genexpr_loop(node))
            return True
        source = self.generator_source(node.iter, is_async)
        if source is None:
            return False
        fn, owner, args, receiver = source
        if fn in self.inlining:
            try:
                self.delegate(node, fn, owner, args, receiver)
            except _Pending:
                # A helper result used by delegation may be learned later in
                # this pass. Regenerate the statement once inference advances.
                self.program.changed = True
            return True
        cache = node.__dict__.setdefault("_rc_inlined", {})
        statements = cache.get(fn)
        if statements is None:
            callee = self.program.function(fn, owner)
            metadata = _binding_metadata(fn)
            if metadata is None:
                self.unsupported("a generator call with unsupported default metadata", node)
            defaults, kwdefaults = metadata
            if defaults:
                self.program.guard("attr", fn, "__defaults__", fn.__defaults__)
            if kwdefaults:
                self.program.guard("attr", fn, "__kwdefaults__", kwdefaults)
                for name, value in kwdefaults.items():
                    self.program.guard("item", kwdefaults, name, value)
            statements = cache[fn] = _inline_generator(self.info, callee, args, receiver, node)
        for name in getattr(statements[0], "_rc_reset_flags", ()):
            self.emit(f"u_{name} = False")
        self.inlining.append(fn)
        try:
            self.body(statements)
        finally:
            self.inlining.pop()
        return True

    def delegate(self, node, fn, owner, args, receiver):
        """``for x in g(...): yield x`` in a generator's collecting form, where ``g`` is
        recursive: g's collecting form appends to the same list."""
        body = node.body
        if not (self.info.sink and isinstance(node.target, ast.Name) and len(body) == 1
                and isinstance(body[0], ast.Expr) and isinstance(body[0].value, ast.Yield)
                and isinstance(body[0].value.value, ast.Name) and body[0].value.value.id == node.target.id):
            self.unsupported("a loop over a recursive generator that does more than yield its values", node)
        name = node.target.id
        # The loop variable is left unset: it may be read only by such loops.
        delegated = {id(item.body[0].value.value) for item in ast.walk(self.info.node)
                     if isinstance(item, (ast.For, ast.AsyncFor)) and isinstance(item.target, ast.Name)
                     and item.target.id == name and len(item.body) == 1 and isinstance(item.body[0], ast.Expr)
                     and isinstance(item.body[0].value, ast.Yield) and isinstance(item.body[0].value.value, ast.Name)
                     and item.body[0].value.value.id == name}
        if any(isinstance(item, ast.Name) and item.id == name and isinstance(item.ctx, ast.Load)
               and id(item) not in delegated for item in ast.walk(self.info.node)):
            self.unsupported(f"'{name}' used outside the loop over a recursive generator", node)
        values = self.call_args(args)
        if receiver and values:
            kind, codes = values[0]
            if isinstance(kind, ObjT) and kind.nullable:
                # Looping over None raises TypeError.
                self.fail(f"{codes[0]} < 0")
                values[0] = ObjT(kind.cls, False, kind.classes), codes
            elif kind == NONE:
                self.fail("True")
                return
        callee = self.program.function(fn, owner, sink=True)
        self.call(callee, values + [self.expr(ast.copy_location(ast.Name(id=_OUT, ctx=ast.Load()), node))], node)

    def genexpr_loop(self, node):
        """``for t in (elt for x in xs if c ...): body`` as nested loops."""
        cached = node.__dict__.get("_rc_genexpr")
        if cached is not None:
            return cached
        expression = node.iter
        stop = None
        body = list(node.body)
        if len(expression.generators) > 1 and _loop_exits(body):
            # The body's break leaves every loop of the expression.
            self.info.inlines = getattr(self.info, "inlines", 0) + 1
            stop = f"_x{self.info.inlines}_stop"
            self.info.locals = self.info.locals | {stop}
            body = [ast.While(test=ast.Constant(True), body=_exits_to(body, stop) + [ast.Break()], orelse=[]),
                    ast.If(test=ast.Name(id=stop, ctx=ast.Load()), body=[ast.Break()], orelse=[])]
        inner = [ast.Assign(targets=[node.target], value=expression.elt)] + body
        for index in range(len(expression.generators) - 1, -1, -1):
            generator = expression.generators[index]
            for test in reversed(generator.ifs):
                inner = [ast.If(test=test, body=inner, orelse=[])]
            loop = ast.For(target=generator.target, iter=generator.iter, body=inner, orelse=[])
            inner = [loop]
            if stop is not None and index:
                inner.append(ast.If(test=ast.Name(id=stop, ctx=ast.Load()), body=[ast.Break()], orelse=[]))
        if stop is not None:
            inner.insert(0, ast.Assign(targets=[ast.Name(id=stop, ctx=ast.Store())], value=ast.Constant(False)))
        statements = node._rc_genexpr = [_locate(statement, node) for statement in inner]
        return statements

    def reduce(self, name, node):
        """sum(), any(), all(), min(), max() or list() of a generator expression, a
        generator of the region or a list, as a loop. None if it is none of those."""
        arg = node.args[0]
        if not (isinstance(arg, ast.GeneratorExp) or self.generator_source(arg) is not None
                or isinstance(self.peek_or_none(arg), ListT)):
            return None
        cached = node.__dict__.get("_rc_reduce")
        if cached is None:
            self.info.inlines = getattr(self.info, "inlines", 0) + 1
            prefix = f"_r{self.info.inlines}_"
            result, item, first = prefix + "result", prefix + "item", prefix + "first"
            self.info.locals = self.info.locals | {result, item, first}

            def load(variable):
                return ast.Name(id=variable, ctx=ast.Load())

            def store(variable, value):
                return ast.Assign(targets=[ast.Name(id=variable, ctx=ast.Store())], value=value)

            if name == "sum":
                before = [store(result, node.args[1] if len(node.args) > 1 else ast.Constant(0))]
                body = [store(result, ast.BinOp(left=load(result), op=ast.Add(), right=load(item)))]
            elif name in ("any", "all"):
                before = [store(result, ast.Constant(name == "all"))]
                test = load(item) if name == "any" else ast.UnaryOp(op=ast.Not(), operand=load(item))
                body = [ast.If(test=test, body=[store(result, ast.Constant(name == "any")), ast.Break()], orelse=[])]
            elif name == "list":
                before = [store(result, ast.List(elts=[], ctx=ast.Load()))]
                body = [ast.Expr(value=ast.Call(func=ast.Attribute(value=load(result), attr="append", ctx=ast.Load()),
                                                args=[load(item)], keywords=[]))]
            else:
                # Python keeps the first of equal items: a later one replaces it only
                # if it is strictly smaller (min) or larger (max).
                better = ast.Compare(left=load(item), ops=[ast.Lt() if name == "min" else ast.Gt()],
                                     comparators=[load(result)])
                before = [store(first, ast.Constant(True))]
                body = [ast.If(test=load(first), body=[store(result, load(item)), store(first, ast.Constant(False))],
                               orelse=[ast.If(test=better, body=[store(result, load(item))], orelse=[])])]
            loop = ast.For(target=ast.Name(id=item, ctx=ast.Store()), iter=arg, body=body, orelse=[])
            after = [] if name not in ("min", "max") else [
                # An empty iterable raises ValueError.
                ast.Assert(test=ast.UnaryOp(op=ast.Not(), operand=load(first)), msg=None)]
            cached = node._rc_reduce = ([_locate(statement, node) for statement in before + [loop] + after], result)
        statements, result = cached
        if name in ("min", "max"):
            # The result is set in the loop; give it a value of its type before.
            kind = self.info.vars.get(result, BOTTOM)
            if kind != BOTTOM:
                for code, value in zip(self.var_codes(result, kind), _dummy(kind)):
                    self.emit(f"{code} = {value}")
        self.body(statements)
        kind = self.info.vars.get(result, BOTTOM)
        if name == "sum" and kind not in (INT, BOOL, BOTTOM):
            # Python adds floats with compensated (Neumaier) summation.
            self.unsupported(f"sum() of {_describe(kind)}", node)
        return self.expr(ast.copy_location(ast.Name(id=result, ctx=ast.Load()), node))

    def do_Assign(self, node):
        value = self.expr(node.value)
        if len(node.targets) > 1:
            value = value[0], self.copy_codes(*value)
        for target in node.targets:
            self.bind(target, value, node)

    def bind(self, target, value, node):
        kind, codes = value
        if isinstance(target, ast.Name):
            self.assign(target.id, kind, codes)
        elif isinstance(target, (ast.Tuple, ast.List)):
            if kind == BOTTOM:
                for item in target.elts:
                    self.bind(item, (BOTTOM, ["0"]), node)
                return
            if not isinstance(kind, TupT) or len(kind.items) != len(target.elts):
                self.unsupported(f"unpacking {_describe(kind)} into {len(target.elts)} names", node)
            if kind.nullable:
                self.fail(f"not {codes[-1]}")
            at = 0
            for item, part in zip(target.elts, kind.items):
                self.bind(item, (part, codes[at:at + _width(part)]), node)
                at += _width(part)
        elif isinstance(target, ast.Attribute):
            base_kind, base_codes = self.expr(target.value)
            self.set_attribute(target, base_kind, base_codes, value)
        elif isinstance(target, ast.Subscript):
            base = self.expr(target.value)
            if base[0] == BOTTOM:
                return
            if isinstance(base[0], NdT):
                self.program.arrays_used = True
                self.nd_store(base, target.slice, value, node)
                return
            if isinstance(base[0], ObjT) and not isinstance(target.slice, ast.Slice):
                receiver = self.temp(self.handle(base[0], base[1], node))
                self.method_call(base[0], receiver, "__setitem__", [self.expr(target.slice), value], node)
                return
            if isinstance(base[0], DictT) and not isinstance(target.slice, ast.Slice):
                handle = self.temp(self.present_handle(*base))
                key = self.expr(target.slice)
                if key[0] != BOTTOM:
                    self.dict_store(base[0], handle, key, value, node)
                return
            if not isinstance(base[0], ListT) or isinstance(target.slice, ast.Slice):
                self.unsupported("this item assignment", node)
            where = self.index(base, self.expr(target.slice), node)
            self.set_item(base[0], where, value, node, nonnegative=True)
        else:
            self.unsupported("this assignment target", node)

    def set_attribute(self, target, base_kind, base_codes, value):
        fields, offset = self.field(base_kind, target, target.attr)
        if fields is None:
            if base_kind == NONE:
                self.fail("True")
            return
        base = self.handle(base_kind, base_codes, target)
        self.attr_check(base_kind, base, target.attr)
        kind, codes = value
        joined = self.program.widen(fields, target.attr, kind)
        if not (self.me is not None and isinstance(target.value, ast.Name) and target.value.id == self.me):
            self.program.written.add((self.program.family(base_kind.cls), target.attr))
        # The layout may have moved if this store widened an attribute.
        offset = self.program.layout(base_kind.cls)[0][target.attr]
        self.store(joined, f"{base} + {offset}", self.coerce(kind, codes, joined), nonnegative=True)

    def set_item(self, list_kind, where, value, node, *, nonnegative=False):
        """Store an item; only index() results may certify a nonnegative address."""
        kind, codes = value
        cell = _find(list_kind.cell)
        if isinstance(list_kind, ArrT):
            if kind not in (INT, BOOL):
                self.unsupported(f"storing {_describe(kind)} in an array('B')", node)
            item = self.temp(self.as_int(kind, codes))
            # array('B') raises OverflowError outside 0..255.
            self.fail(f"{item} < 0 or {item} > 255")
            cell.mutated = True
            self.store(INT, where, [item], nonnegative=nonnegative)
            return
        self.program.widen_cell(cell, kind)
        cell.mutated = True
        self.check_item(cell.elem, node)
        self.store(cell.elem, where, self.coerce(kind, codes, cell.elem), nonnegative=nonnegative)

    def do_AugAssign(self, node):
        target, op = node.target, type(node.op)
        if isinstance(target, ast.Name):
            self.bound_check(target, target.id)
            current = self.expr(ast.copy_location(ast.Name(id=target.id, ctx=ast.Load()), target))
            result = self.binop(op, current, self.expr(node.value), node)
            self.assign(target.id, *result)
        elif isinstance(target, ast.Attribute):
            base_kind, base_codes = self.expr(target.value)
            fields, offset = self.field(base_kind, target, target.attr)
            if fields is None:
                if base_kind == NONE:
                    self.fail("True")
                self.expr(node.value)
                return
            base = self.temp(self.handle(base_kind, base_codes, target))
            self.attr_check(base_kind, base, target.attr)
            found = fields[target.attr]
            current = found, [self.temp(code) for code in self.slot(found, f"{base} + {offset}", nonnegative=True)]
            result = self.binop(op, current, self.expr(node.value), node)
            self.set_attribute(target, ObjT(base_kind.cls, False, base_kind.classes), [base], result)
        elif isinstance(target, ast.Subscript) and not isinstance(target.slice, ast.Slice):
            base = self.expr(target.value)
            if base[0] == BOTTOM:
                self.expr(node.value)
                return
            if isinstance(base[0], NdT):
                self.program.arrays_used = True
                self.nd_augment(base, target.slice, op, node.value, node)
                return
            if isinstance(base[0], DictT):
                return self.dict_augassign(base, target, node)
            if not isinstance(base[0], ListT):
                self.unsupported("this in-place operator", node)
            # Python retains the original base and logical index, in that order.
            # The index expression and RHS may rebind the source or resize an alias.
            base = base[0], self.copy_codes(*base)
            position = self.expr(target.slice)
            position = position[0], self.copy_codes(*position)
            where = self.index(base, position, node)
            self.check_item(base[0].elem, node)
            current = base[0].elem, [self.temp(code) for code in self.slot(base[0].elem, where, nonnegative=True)]
            result = self.binop(op, current, self.expr(node.value), node)
            result = result[0], self.copy_codes(*result)
            # Re-normalize negative indices and reload a possibly relocated block
            # only after RHS evaluation and arithmetic, immediately before setting.
            where = self.index(base, position, node)
            self.set_item(base[0], where, result, node, nonnegative=True)
        else:
            self.unsupported("this in-place operator", node)

    # The function

    def run(self):
        info, program = self.info, self.program
        if info.falls_through:
            program.widen(info.__dict__, "ret", NONE)
        source = self.generate()
        constant = None
        if (self.returned and not info.falls_through and len(set(self.returned)) == 1 and self.returned[0]
                and all(_LITERAL.fullmatch(code) for code in self.returned[0])):
            constant = self.returned[0]
        if constant != info.constant:
            info.constant, program.changed = constant, True
        return source

    def unbound_prologue(self):
        """Each flagged local starts unbound, holding a value of its type."""
        lines = []
        for name in sorted(self.info.flagged):
            kind = self.info.vars.get(name, BOTTOM)
            if kind != BOTTOM:
                lines += [f"    {target} = {code}" for target, code in zip(self.var_codes(name, kind), _dummy(kind))]
            lines.append(f"    u_{name} = False")
        return lines

    def generate(self):
        info, program = self.info, self.program
        statements = info.node.body
        self.body(statements)
        closing = self.result_codes()
        self.emit("return " + ", ".join(closing) if closing else "return")
        self.lines[:0] = self.unbound_prologue()
        info.math_used = self.math_used
        info.object_allocations = self.object_allocations
        params = [code for name in info.params for code in self.var_codes(name, info.vars.get(name, BOTTOM))]
        inline = not info.recursive and info is not program.entry and len(self.lines) <= INLINE_LINES
        header = f"{_INLINED if inline else _DECORATOR}\ndef {info.name}(F, I, top, st{''.join(', ' + p for p in params)}):"
        return header + "\n" + "\n".join(self.lines) + "\n"


_C_CODES = {FLOAT: 0, MIXED: 1, INT: 2, BOOL: 3, NONE: 4}
_REDUCERS = ("sum", "any", "all", "min", "max", "list")


class _Pending(Exception):
    """A value whose type is not known yet in this pass."""


class _NoNative(Exception):
    """A type the C loader does not handle: that part loads in Python."""


class _Grow(Exception):
    """The heap is too small for the arguments."""


class _Mismatch(Exception):
    """A value does not fit the types the region was compiled for."""


class _Loader:
    """Copies the arguments of one call into the heap."""

    def __init__(self, program, F=None, I=None):
        self.program = program
        # With the heap arrays given and _heap built, objects and lists are copied
        # straight into the arrays by C code.
        self.native = (_native is not None and F is not None
                       and getattr(_native, "LOAD_CONTRACTS_VERSION", 0) == 1)
        self.F, self.I = F, I
        self.float_at, self.float_values, self.int_at, self.int_values = [], [], [], []
        # (first slot, int64 array) copied in whole: the items of byte arrays.
        self.blocks = []
        # Slots 0, 1, ... hold the handles of objects read from module globals.
        self.top = len(program.global_objects)
        # id(value) -> handle; and every object and list loaded, kept alive, in order.
        self.handles, self.objects, self.lists = {}, [], []
        # Repeated mutable identities retain their complete type/mutation
        # contracts, including when C-loaded objects contain list aliases.
        self.contracts = {}
        # str -> handle (equal strings share one block); dicts and sets loaded.
        self.strings, self.dicts = {}, []

    def put(self, kind, where, value):
        if type(kind) is OptT:
            # The number (zeros for None), then the flag that it is there.
            self.int_at.append(where + _slots(kind.base))
            self.int_values.append(value is not None)
            if value is None:
                self.int_at.append(where)
                self.int_values.append(0)
                if _slots(kind.base) == 2:
                    self.int_at.append(where + 1)
                    self.int_values.append(0)
                return
            kind = kind.base
        if type(kind) is not str:
            # An object or list: it adds its own slots first, so find the value
            # before recording where it goes.
            raw = self.instance(kind, value) if type(kind) is ObjT and value is not None else self.scalar(kind, value)
            self.int_at.append(where)
            self.int_values.append(raw)
        elif kind == FLOAT:
            if type(value) is not float:
                raise _Mismatch
            self.float_at.append(where)
            self.float_values.append(value)
        elif _is_np(kind):
            number, flag = self.np_number(kind, value)
            if _NP_BASE[kind] == FLOAT:
                self.float_at.append(where)
            else:
                self.int_at.append(where)
            self.float_values.append(number) if _NP_BASE[kind] == FLOAT else self.int_values.append(number)
            if kind in (NPFQ, NPIQ, NPBQ):
                self.int_at.append(where + 1)
                self.int_values.append(int(flag))

        elif kind == MIXED:
            if type(value) is float:
                whole = 0
            elif type(value) is int and -EXACT <= value <= EXACT:
                whole = 1
            else:
                raise _Mismatch
            self.float_at.append(where)
            self.float_values.append(float(value))
            self.int_at.append(where + 1)
            self.int_values.append(whole)
        else:
            # Loading an object or list adds its own slots first, so find the value
            # before recording where it goes.
            raw = self.scalar(kind, value)
            self.int_at.append(where)
            self.int_values.append(raw)

    def scalar(self, kind, value):
        """The int64 that stands for ``value`` where ``kind`` is expected."""
        if kind == INT:
            if type(value) is not int or not INT_MIN <= value <= INT_MAX:
                raise _Mismatch
            return value
        if kind == BOOL:
            if type(value) is not bool:
                raise _Mismatch
            return int(value)
        if kind == NONE:
            if value is not None:
                raise _Mismatch
            return -1
        if isinstance(kind, TupT):
            return self.tuple(kind, value)
        if type(kind) is RngT:
            return self.generator(value)
        if type(kind) is NdT:
            return self.ndarray(kind, value)
        if _is_np(kind):
            return self.np_number(kind, value)[0]
        if isinstance(kind, _HANDLES):
            return self.container(kind, value)
        if self.native and type(kind) in (ObjT, ListT) and self.program.c_ok(kind):
            try:
                handle, self.top = _native.load(self.program.c_kind(kind), value, self.F, self.I, self.top,
                                                self.handles, self.objects, self.lists, self.contracts)
            except _native.Mismatch:
                raise _Mismatch from None
            except _native.Grow:
                raise _Grow from None
            return handle
        if isinstance(kind, ObjT):
            if value is None:
                if not kind.nullable:
                    raise _Mismatch
                return -1
            return self.instance(kind, value)
        if isinstance(kind, ListT):
            return self.list(kind, value)
        raise _Mismatch

    def container(self, kind, value):
        if value is None:
            if not kind.nullable:
                raise _Mismatch
            return -1
        if isinstance(kind, StrT):
            if type(value) is not str:
                raise _Mismatch
            known = self.strings.get(value)
            if known is not None:
                return known
            import numpy as np

            handle = self.strings[value] = self.top
            count = len(value)
            self.top += 2 + count
            self.int_at += (handle, handle + 1)
            self.int_values += (count, 0)
            if count:
                self.blocks.append((handle + 2, np.frombuffer(value.encode("utf-32-le", "surrogatepass"),
                                                              dtype=np.uint32).astype(np.int64)))
            return handle
        is_dict = isinstance(kind, DictT)
        if type(value) is not (dict if is_dict else set):
            raise _Mismatch
        contract = ((DictT, _find(kind.kcell), _find(kind.vcell)) if is_dict else
                    (SetT, _find(kind.cell)))
        known = self.handles.get(id(value))
        if known is not None:
            if self.contracts.get(id(value)) != contract:
                raise _Mismatch
            return known
        key = kind.key if is_dict else kind.elem
        count = len(value)
        if count and (key == BOTTOM or _key_tag(key) is None or (is_dict and kind.value == BOTTOM)):
            raise _Mismatch
        stride = 3 + (_slots(kind.value) if is_dict else 0)
        handle = self.handles[id(value)] = self.top
        self.contracts[id(value)] = contract
        entries = handle + 9
        cap = max(count, 1)
        self.top = entries + cap * stride
        self.dicts.append((value, handle, kind))
        self.int_at += range(handle, handle + 9)
        self.int_values += (count, count, cap, entries, 0, 0, stride, -1, 0)
        if is_dict:
            vkind = kind.value
            for position, (item, part) in enumerate(value.items()):
                at = entries + position * stride
                self.int_at += (at, at + 2)
                self.int_values += (0, 1)
                self.put(key, at + 1, item)
                self.put(vkind, at + 3, part)
        else:
            for position, item in enumerate(value):
                at = entries + position * stride
                self.int_at += (at, at + 2)
                self.int_values += (0, 1)
                self.put(key, at + 1, item)
        return handle

    def instance(self, kind, value):
        cls = type(value)
        if cls not in kind.classes:
            raise _Mismatch
        known = self.handles.get(id(value))
        if known is not None:
            return known
        plan = self.program.load_plan(cls)
        names, size, steps, tag = plan
        attributes = getattr(value, "__dict__", None)
        if attributes is None:
            try:
                attributes = {name: getattr(value, name) for name in names}
            except AttributeError:
                raise _Mismatch from None
        elif attributes.keys() != names:
            raise _Mismatch
        handle = self.handles[id(value)] = self.top
        self.top += size
        self.objects.append((value, handle, cls))
        if tag >= 0:
            self.int_at.append(handle)
            self.int_values.append(tag)
        for name, offset, kind, is_float in steps:
            item = attributes[name]
            if is_float:
                if type(item) is not float:
                    raise _Mismatch
                self.float_at.append(handle + offset)
                self.float_values.append(item)
            else:
                self.put(kind, handle + offset, item)
        return handle

    def tuple(self, kind, value):
        if value is None:
            if not kind.nullable:
                raise _Mismatch
            return -1
        if type(value) is not tuple or len(value) != len(kind.items):
            raise _Mismatch
        block = self.top
        self.top += max(1, sum(map(_slots, kind.items)))
        at = 0
        for item, part in zip(kind.items, value):
            self.put(item, block + at, part)
            at += _slots(item)
        return block

    def np_number(self, kind, value):
        """(Python number, is numpy) for a value of numpy scalar kind ``kind``."""
        base = _NP_BASE[kind]
        python = {FLOAT: float, INT: int, BOOL: bool}[base]
        numpy_name = {FLOAT: "float64", INT: "int64", BOOL: "bool"}[base]
        is_np = type(value).__module__ == "numpy" and type(value).__name__ == numpy_name
        if not (is_np or (kind in (NPFQ, NPIQ, NPBQ) and type(value) is python)):
            raise _Mismatch
        if base == INT and not is_np and not INT_MIN <= value <= INT_MAX:
            raise _Mismatch
        return python(value), is_np

    def ndarray(self, kind, value):
        """An array: a block with its address, shape and strides (recompyler._nd)."""
        if (not _is_ndarray(value) or value.dtype.name != kind.dtype or value.ndim != kind.ndim
                or bool(value.flags.writeable) != kind.writable or not value.dtype.isnative):
            raise _Mismatch
        if getattr(self.program, "array_views", False) and not (
                value.flags.c_contiguous or value.flags.f_contiguous):
            # Reconstructing a returned view requires a contiguous buffer owner.
            # Refuse before native stores rather than exposing a conversion error.
            raise _Mismatch
        size = value.itemsize
        if any(stride % size for stride in value.strides):
            raise _Mismatch
        known = self.handles.get(id(value))
        if known is not None:
            return known
        handle = self.handles[id(value)] = self.top
        self.top += 2 + 2 * kind.ndim
        self.__dict__.setdefault("arrays", []).append((value, handle))
        import numpy as np

        self.blocks.append((handle, np.array([value.__array_interface__["data"][0], *value.shape,
                                              *(stride // size for stride in value.strides), handle], dtype=np.int64)))
        return handle

    def generator(self, value):
        """A random.Random: a block with a copy of its state (recompyler._rng)."""
        from . import _rng

        known = self.handles.get(id(value))
        if known is not None:
            return known
        if not _rng.supported(value):
            raise _Mismatch
        handle = self.handles[id(value)] = self.top
        self.top += _rng.RNG_SLOTS
        self.__dict__.setdefault("rngs", []).append((value, handle))
        self.blocks.append((handle, _rng.state_of(value)))
        return handle

    def array(self, kind, value):
        import numpy as np

        if type(value) is not array.array or value.typecode != "B":
            raise _Mismatch
        root = _find(kind.cell)
        known = self.handles.get(id(value))
        if known is not None:
            if self.contracts.get(id(value)) is not root:
                raise _Mismatch
            return known
        count = len(value)
        handle = self.handles[id(value)] = self.top
        self.contracts[id(value)] = root
        data = handle + 3
        self.top = data + count
        self.lists.append((value, handle, kind))
        self.int_at += (handle, handle + 1, handle + 2)
        self.int_values += (count, count, data)
        if count:
            self.blocks.append((data, np.frombuffer(value, dtype=np.uint8).astype(np.int64)))
        return handle

    def list(self, kind, value):
        if isinstance(kind, ArrT):
            return self.array(kind, value)
        if type(value) is not list:
            raise _Mismatch
        root = _find(kind.cell)
        known = self.handles.get(id(value))
        if known is not None:
            if self.contracts.get(id(value)) is not root:
                raise _Mismatch
            return known
        elem, count = kind.elem, len(value)
        if count and (elem in (BOTTOM, MIXED) or isinstance(elem, OptT)):
            raise _Mismatch
        handle = self.handles[id(value)] = self.top
        self.contracts[id(value)] = root
        data = handle + 3
        self.top = data + count
        self.lists.append((value, handle, kind))
        self.int_at += (handle, handle + 1, handle + 2)
        self.int_values += (count, count, data)
        if elem == FLOAT:
            if set(map(type, value)) - {float}:
                raise _Mismatch
            self.float_at += range(data, data + count)
            self.float_values += value
        else:
            for position, item in enumerate(value):
                self.put(elem, data + position, item)
        return handle

    def argument(self, kind, value):
        """The machine values passed for one argument."""
        if isinstance(kind, OptT):
            if value is None:
                return [{"f": 0.0, "i": 0, "b": False}[letter] for letter in _machine_types(kind)[:-1]] + [False]
            return self.argument(kind.base, value) + [True]
        if kind == FLOAT:
            if type(value) is not float:
                raise _Mismatch
            return [value]
        if kind == MIXED:
            if type(value) is float:
                return [value, False]
            if type(value) is int and -EXACT <= value <= EXACT:
                return [float(value), True]
            raise _Mismatch
        if kind == BOOL:
            if type(value) is not bool:
                raise _Mismatch
            return [value]
        if isinstance(kind, TupT):
            if value is None:
                if not kind.nullable:
                    raise _Mismatch
                return [{"f": 0.0, "i": 0, "b": False}[letter] for letter in _machine_types(kind)[:-1]] + [False]
            if type(value) is not tuple or len(value) != len(kind.items):
                raise _Mismatch
            return [code for item, part in zip(kind.items, value) for code in self.argument(item, part)] + (
                [True] if kind.nullable else [])
        if kind == BOTTOM:
            raise _Mismatch
        if _is_np(kind):
            number, flag = self.np_number(kind, value)
            return [number, flag] if kind in (NPFQ, NPIQ, NPBQ) else [number]
        return [self.scalar(kind, value)]


class _Unloader:
    """Turns heap values back into Python values after a call."""

    def __init__(self, program, loader, F, I):
        self.program, self.F, self.I = program, F, I
        self.made = {handle: value for value, handle, _ in loader.objects}
        self.made.update({handle: value for value, handle, _ in loader.lists})
        self.made.update({handle: value for value, handle in getattr(loader, "rngs", ())})
        self.made.update({handle: value for value, handle in getattr(loader, "arrays", ())})
        self.made.update({handle: value for value, handle in loader.strings.items()})
        self.made.update({handle: value for value, handle, _ in loader.dicts})

    def value(self, kind, where):
        if _is_np(kind):
            number = self.value(_NP_BASE[kind], where)
            return _np_scalar(kind, number, kind in (NPF, NPI, NPB) or self.I.item(where + 1))
        if kind == FLOAT:
            return self.F.item(where)
        if isinstance(kind, OptT):
            return self.value(kind.base, where) if self.I.item(where + _slots(kind.base)) else None
        if isinstance(kind, TupT):
            block = self.I.item(where)
            if block < 0:
                return None
            out, at = [], 0
            for item in kind.items:
                out.append(self.value(item, block + at))
                at += _slots(item)
            return tuple(out)
        if kind == MIXED:
            number = self.F.item(where)
            return int(number) if self.I.item(where + 1) else number
        raw = self.I.item(where)
        if kind == INT:
            return raw
        if kind == BOOL:
            return bool(raw)
        if kind == NONE or raw < 0:
            return None
        return self.reference(kind, raw)

    def reference(self, kind, handle):
        known = self.made.get(handle)
        if known is not None:
            return known
        if isinstance(kind, NdT):
            return self.view(kind, handle)
        if isinstance(kind, _HANDLES):
            return self.container(kind, handle)
        if isinstance(kind, ObjT):
            program = self.program
            root = program.family(kind.cls)
            cls = program.members[root][self.I.item(handle)] if program.polymorphic(root) else next(iter(kind.classes))
            made = self.made[handle] = cls.__new__(cls)
            offsets = program.layout(cls)[0]
            for name, field in program.fields[root].items():
                if name in program.class_fields[cls]:
                    setattr(made, name, self.value(field, handle + offsets[name]))
            return made
        if isinstance(kind, ArrT):
            made = self.made[handle] = array.array("B", self.items(kind, handle))
            return made
        made = self.made[handle] = []
        made.extend(self.items(kind, handle))
        return made

    def view(self, kind, handle):
        """A view made in the region (``grid[i]``), as a view of the array it is of."""
        import numpy as np

        root = self.made[self.I.item(handle + 1 + 2 * kind.ndim)]
        size = root.itemsize
        shape = tuple(self.I.item(handle + 1 + k) for k in range(kind.ndim))
        strides = tuple(size * self.I.item(handle + 1 + kind.ndim + k) for k in range(kind.ndim))
        offset = self.I.item(handle) - root.__array_interface__["data"][0]
        try:
            made = np.ndarray(shape, root.dtype, buffer=root, offset=offset, strides=strides)
        except (ValueError, TypeError, BufferError):
            raise _Mismatch from None
        made.flags.writeable = root.flags.writeable
        self.made[handle] = made
        return made

    def container(self, kind, handle):
        I = self.I
        if isinstance(kind, StrT):
            count = I.item(handle)
            made = self.made[handle] = I[handle + 2:handle + 2 + count].astype("<u4").tobytes().decode(
                "utf-32-le", "surrogatepass")
            return made
        if isinstance(kind, DictT):
            made = self.made[handle] = {}
            made.update(self.entries(kind, handle))
            return made
        made = self.made[handle] = set()
        self.replay(kind, handle, made)
        return made

    def entries(self, kind, handle):
        """The live (key, value) pairs of a dict in the heap, in order."""
        I = self.I
        used, entries, stride = I.item(handle + 1), I.item(handle + 3), I.item(handle + 6)
        key, value = kind.key, kind.value
        out = []
        for position in range(used):
            at = entries + position * stride
            if I.item(at + 2):
                out.append((self.value(key, at + 1), self.value(value, at + 3)))
        return out

    def replay(self, kind, handle, target):
        """Make on ``target`` the adds and discards the region made on a set, in order."""
        I = self.I
        log = I.item(handle + 7)
        if log < 0:
            return
        count, data, elem = I.item(log), I.item(log + 2), kind.elem
        position, frozen = 0, []
        while position < count:
            op = I.item(data + position)
            item = self.value(elem, data + position + 1) if op != 2 else None
            position += 2
            if op == 3:
                frozen.append(item)
                if position < count and I.item(data + position) == 3:
                    continue
                target.update(frozenset(frozen))
                frozen = []
            elif op == 1:
                target.add(item)
            elif op == 0:
                target.discard(item)
            else:
                target.clear()

    def items(self, kind, handle):
        count, data = self.I.item(handle), self.I.item(handle + 2)
        elem = kind.elem
        if elem == FLOAT:
            return self.F[data:data + count].tolist()
        if elem == INT:
            return self.I[data:data + count].tolist()
        return [self.value(elem, data + position) for position in range(count)]

    def result(self, kind, codes):
        if kind in (NONE, BOTTOM):
            return None
        if _is_np(kind):
            number = self.result(_NP_BASE[kind], codes[:1])
            return _np_scalar(kind, number, kind in (NPF, NPI, NPB) or bool(codes[1]))
        if kind == FLOAT:
            return float(codes[0])
        if kind == MIXED:
            return int(codes[0]) if codes[1] else float(codes[0])
        if isinstance(kind, OptT):
            return self.result(kind.base, codes[:-1]) if codes[-1] else None
        if kind == INT:
            return int(codes[0])
        if kind == BOOL:
            return bool(codes[0])
        if isinstance(kind, TupT):
            if kind.nullable and not codes[-1]:
                return None
            out, at = [], 0
            for item in kind.items:
                out.append(self.result(item, codes[at:at + _width(item)]))
                at += _width(item)
            return tuple(out)
        handle = int(codes[0])
        return None if handle < 0 else self.reference(kind, handle)

    def write_back(self, loader):
        """Store what the region changed into the objects and lists that came in."""
        program = self.program
        by_class = {}
        native = loader.native
        if native:
            try:
                plans = program.c_write_plans()
            except _NoNative:
                native = False
            else:
                if plans:
                    _native.write_back(loader.objects, plans, self.F, self.I, loader.handles, self.value)
        for value, handle, cls in ([] if native else loader.objects):
            names = by_class.get(cls)
            if names is None:
                root, done = program.family(cls), program.written_set()
                offsets = program.layout(cls)[0]
                names = by_class[cls] = [(name, program.fields[root][name], offsets[name])
                                         for name in program.fields[root]
                                         if (root, name) in done and name in program.class_fields[cls]]
            for name, kind, offset in names:
                new, old = self.value(kind, handle + offset), getattr(value, name)
                if new is not old and not _unchanged(old, new):
                    setattr(value, name, new)
        for value, handle, kind in loader.lists:
            if not _find(kind.cell).mutated:
                continue
            new = self.items(kind, handle)
            if isinstance(kind, ArrT):
                if value.tolist() != new:
                    value[:] = array.array("B", new)
                continue
            if len(new) != len(value) or any(a is not b and not _unchanged(a, b) for a, b in zip(value, new)):
                value[:] = new
        for value, handle, kind in loader.dicts:
            if not any(_find(cell).mutated for cell in _cells(kind)):
                continue
            if isinstance(kind, SetT):
                self.replay(kind, handle, value)
                continue
            new = self.entries(kind, handle)
            if len(new) != len(value) or any(not _kept(a, c) or not _kept(b, d)
                                             for (a, b), (c, d) in zip(value.items(), new)):
                value.clear()
                value.update(new)


def _kept(old, new):
    """True if ``new`` may stay as ``old``: the same object, or an equal number, str
    or tuple of these."""
    if old is new or _unchanged(old, new):
        return True
    kind = type(old)
    if kind is not type(new):
        return False
    if kind is str:
        return old == new
    return kind is tuple and len(old) == len(new) and all(map(_kept, old, new))


def _constant_tuple(value, depth=0):
    """True for a short tuple of numbers, None and such tuples."""
    return depth < 4 and len(value) <= 64 and all(
        type(item) in (int, float, bool) or item is None or (type(item) is tuple and _constant_tuple(item, depth + 1))
        for item in value)


def _np_scalar(kind, number, is_np):
    """``number`` as the numpy scalar it stands for, if ``is_np``."""
    if not is_np:
        return number
    import numpy as np

    return {FLOAT: np.float64, INT: np.int64, BOOL: np.bool_}[_NP_BASE[kind]](number)


def _unchanged(old, new):
    """True if replacing ``old`` by ``new`` could not be noticed: equal numbers of one
    type with the same bits."""
    kind = type(old)
    if kind is not type(new) or kind not in (int, float, bool):
        return False
    return old == new and (kind is not float or math.copysign(1.0, old) == math.copysign(1.0, new))


def _seed(program, value, seen):
    """The type of an argument value, widening class attributes and lists as it goes."""
    kind = type(value)
    if value is None:
        return NONE
    if kind is bool:
        return BOOL
    if kind is float:
        return FLOAT
    if kind is int:
        if not INT_MIN <= value <= INT_MAX:
            raise Unsupported("an int argument too large for 64 bits")
        return INT
    known = seen.get(id(value))
    if known is not None:
        return known
    if kind is list:
        made = seen[id(value)] = ListT()
        for item in value:
            program.widen_cell(made.cell, _seed(program, item, seen))
        return made
    if kind is tuple:
        return TupT(_seed(program, item, seen) for item in value)
    if _is_ndarray(value):
        dtype = value.dtype
        if dtype.name not in ("float64", "int64", "bool") or not dtype.isnative or value.ndim < 1:
            raise Unsupported(f"an array of dtype {dtype.name} and {value.ndim} dimensions")
        return NdT(dtype.name, value.ndim, bool(value.flags.writeable))
    if kind.__module__ == "numpy":
        found = {"float64": NPF, "int64": NPI, "bool": NPB}.get(kind.__name__)
        if found is None:
            raise Unsupported(f"an argument of type numpy.{kind.__name__}")
        return found
    if kind is random.Random:
        from . import _rng

        if not _rng.supported(value):
            raise Unsupported("a random.Random with attributes of its own")
        made = seen[id(value)] = RngT()
        return made
    if kind is array.array:
        if value.typecode != "B":
            raise Unsupported(f"an array of typecode '{value.typecode}'")
        made = seen[id(value)] = ArrT()
        return made
    if kind is str:
        return StrT()
    if kind is dict:
        made = seen[id(value)] = DictT()
        for key, item in value.items():
            program.widen_cell(made.kcell, _seed(program, key, seen))
            program.widen_cell(made.vcell, _seed(program, item, seen))
        if value and _key_tag(made.key) is None:
            raise Unsupported(f"a dict with keys that are {_describe(made.key)}")
        return made
    if kind is set:
        made = seen[id(value)] = SetT()
        for item in value:
            program.widen_cell(made.cell, _seed(program, item, seen))
        if value and _key_tag(made.elem) is None:
            raise Unsupported(f"a set of {_describe(made.elem)}")
        return made
    if kind in (dict, set, str, bytes) or kind.__module__ in ("builtins", "array"):

        raise Unsupported(f"an argument of type {kind.__name__}")
    fields = program.register(kind)
    made = seen[id(value)] = ObjT(kind)
    names = program.class_fields[kind]
    if hasattr(value, "__dict__") and vars(value).keys() != names:
        raise Unsupported(f"a '{kind.__name__}' object with attributes its __init__ does not set")
    for name in sorted(names):
        try:
            item = getattr(value, name)
        except AttributeError:
            raise Unsupported(f"a '{kind.__name__}' object without attribute '{name}'") from None
        program.widen(fields, name, _seed(program, item, seen))
    return made


def _signature(program, kinds):
    """Text that is equal for calls whose arguments have the same types throughout."""
    classes = sorted((cls.__module__, cls.__qualname__, [(name, _describe(kind)) for name, kind in fields.items()])
                     for cls, fields in program.fields.items())
    signature = repr(([_describe(kind) for kind in kinds], classes))
    if program.numeric_policy is not None:
        signature += ":numeric:" + program.numeric_policy.identity
    return signature


class Region:
    """A compiled stand-in for ``original`` that falls back whenever it cannot be sure."""

    def __init__(self, fn, ahead_of_time=None, seeds=None, prepared=None):
        if not isinstance(fn, FunctionType):
            raise Unsupported("only plain Python functions can be lifted")
        self.original = fn
        # Source digest -> function exported by an ahead-of-time module.
        self.ahead_of_time = ahead_of_time or {}
        self.seeds = seeds if type(seeds) is dict else {}
        self.prepared = prepared
        self.prepared_hits = self.prepared_misses = 0
        self.prepared_reasons = []
        self.programs, self.latest = {}, None
        self.compiled_calls = self.fallback_calls = 0
        self.aot_calls = self.jit_calls = 0
        self.problem = None
        # (function, source line) of the check that last sent a call back to Python.
        self.gave_up = None
        self.slots = START_SLOTS
        self._arrays = None

    def arrays(self):
        import numpy as np

        if self._arrays is None or len(self._arrays[0]) != self.slots:
            F = np.zeros(self.slots, dtype=np.float64)
            self._arrays = F, F.view(np.int64), np.zeros(4, dtype=np.int64), np.zeros(1, dtype=np.uint8)
        return self._arrays

    def program_for(self, args):
        """The program compiled for these argument types, or None."""
        if self.prepared is not None:
            if len(self.programs) >= MAX_SIGNATURES:
                return None
            candidates = self.prepared.bind(self.original)
            self.prepared_reasons = list(self.prepared.reasons)
            for record_id, program in enumerate(candidates):
                if program.broken or not program.guards_hold():
                    continue
                try:
                    self.load(program, args)
                except (_Mismatch, RecursionError):
                    continue
                if len(self.programs) < MAX_SIGNATURES:
                    self.programs[('prepared', record_id)] = program
                self.prepared_hits += 1
                return program
            self.prepared_misses += 1
        try:
            candidate = self._make_program()
            seen = {}
            kinds = [_seed(candidate, value, seen) for value in args]
        except Unsupported as exc:
            self.problem = str(exc)
            return None
        key = _signature(candidate, kinds)
        if key in self.programs:
            return self.programs[key]
        if len(self.programs) >= MAX_SIGNATURES:
            return None
        if self.seeds:
            from ._region_seed import restore, ExactExport

            # Seeds provide types, never values. The loader checks the actual call
            # graph, then the ordinary per-call guards protect live definitions.
            for digest, seed in self.seeds.items():
                if digest not in self.ahead_of_time:
                    continue
                try:
                    seeded = restore(self.original, seed)
                    exact = ExactExport({digest: self.ahead_of_time[digest]})
                    if hasattr(self.ahead_of_time, 'resolve_program'):
                        verified = self.ahead_of_time
                        class ExactVerified(dict):
                            def resolve_program(self, program):
                                if program.digest != digest:
                                    raise Unsupported('no exact saved seed export')
                                return verified.resolve_program(program)
                        exact = ExactVerified(exact)
                    seeded.compile(exact)
                    if seeded.digest != digest:
                        continue
                    self.load(seeded, args)
                except (Unsupported, _Mismatch, KeyError, IndexError, TypeError, ValueError, AttributeError,
                        RecursionError):
                    continue
                self.programs[key] = seeded
                return seeded
            if not getattr(self.ahead_of_time, "allow_jit", True):
                self.problem = "no saved AOT inference seed matches the live program"
                self.programs[key] = None
                return None
        try:
            for name, kind in zip(candidate.entry.params, kinds):
                candidate.widen(candidate.entry.vars, name, kind)
            candidate.compile(self.ahead_of_time)
        except Unsupported as exc:
            self.problem = str(exc)
            candidate = None
        self.programs[key] = candidate
        return candidate

    def _make_program(self):
        """A fresh strict program; explicit experimental wrappers override this."""
        return _Program(self.original)

    def load(self, program, args):
        entry = program.entry
        while True:
            F, I = self.arrays()[:2] if NATIVE else (None, None)
            loader = _Loader(program, F, I)
            constants = self.constants(program, loader)
            try:
                passed = [code for name, value in zip(entry.params, args)
                          for code in loader.argument(entry.vars.get(name, BOTTOM), value)]
                for slot, (namespace, name, kind) in enumerate(program.global_objects):
                    handle = constants.get(slot)
                    if handle is None:
                        handle = loader.scalar(kind, namespace.get(name))
                    if loader.native:
                        loader.I[slot] = handle
                    else:
                        loader.int_at.append(slot)
                        loader.int_values.append(handle)
                if loader.native and loader.top + 64 > len(F):
                    # Parts loaded in Python are copied in after the load; make room
                    # for them in these arrays rather than in new ones.
                    raise _Grow
            except _Grow:
                self.slots *= 2
                if self.slots > MAX_SLOTS:
                    self.slots //= 2
                    raise _Mismatch from None
                continue
            return loader, passed

    def constants(self, program, loader):
        """Put the program's str constants just after the global slots, and start the
        loader past them. They are copied into the arrays only when another program
        or new arrays were there last. Returns {global slot: handle}."""
        size, slots, blocks = program.constant_blocks()
        if not blocks:
            return slots
        loader.top += size
        loader.strings.update((value, handle) for value, handle in program.constant_strings())
        if loader.native and loader.top + 64 <= len(loader.F):
            prefix = getattr(self, "_prefix", None)
            if prefix is None or prefix[0] is not program or prefix[1] is not loader.F:
                for handle, count, points in blocks:
                    loader.I[handle] = count
                    loader.I[handle + 1] = 0
                    loader.I[handle + 2:handle + 2 + count] = points
                self._prefix = program, loader.F
        else:
            self._prefix = None
            for handle, count, points in blocks:
                loader.int_at += (handle, handle + 1)
                loader.int_values += (count, 0)
                if count:
                    loader.blocks.append((handle + 2, points))
        return slots

    def attempt(self, args, kwargs=None, *, _bound_entry=False):
        """(True, result) from compiled code, or (False, None)."""

        import numpy as np

        code = self.original.__code__
        if not _bound_entry:
            if kwargs is not None and type(kwargs) is not dict:
                return False, None
            if kwargs or code.co_kwonlyargcount or code.co_flags & _VARARGS:
                args = _bind_entry(self.original, args, kwargs or {})
                if args is None:
                    return False, None
            else:
                entry_params = code.co_argcount
                defaults = self.original.__defaults__
                if defaults is None:
                    defaults = ()
                if type(defaults) is not tuple:
                    return False, None
                if not 0 <= entry_params - len(args) <= len(defaults):
                    return False, None
                if len(args) < entry_params:
                    args = args + defaults[len(defaults) - (entry_params - len(args)):]
        generator = self.original.__code__.co_flags & _GENERATOR_FLAGS
        if generator:
            # A generator compiles as a function that appends what it yields to a
            # list, its last argument; the values come back in that list.
            collected = []
            args = args + (collected,)
        program, loaded = self.latest, None
        if program is not None and program.broken:
            program = None
        if program is not None:
            try:
                loaded = self.load(program, args)
            except _Mismatch:
                program = None
        if program is None:
            program = self.program_for(args)
            if program is None or program.broken:
                return False, None
            try:
                loaded = self.load(program, args)
            except _Mismatch:
                return False, None
            self.latest = program
        if not program.guards_hold():
            return False, None
        loader, passed = loaded
        # Array stores bypass the private heap. Keep their original bytes until
        # the attempt succeeds, including when an overlapping view is an input.
        try:
            array_states = [(value, value.copy(order="K")) for value, _ in getattr(loader, "arrays", ())
                            if value.flags.writeable] if getattr(program, "arrays_written", False) else ()
        except MemoryError:
            return False, None
        while True:
            if loader.top + 64 > self.slots:
                self.slots = max(self.slots * 2, 1 << (loader.top + 64).bit_length())
                if self.slots > MAX_SLOTS:
                    return False, None
            F, I, top, st = self.arrays()
            if loader.float_at:
                F[np.array(loader.float_at, dtype=np.int64)] = loader.float_values
            if loader.int_at:
                I[np.array(loader.int_at, dtype=np.int64)] = loader.int_values
            for start, values in loader.blocks:
                I[start:start + len(values)] = values
            top[0], top[1], top[3] = loader.top, 0, -1
            frame, depth = sys._getframe(), 0
            while frame is not None:
                frame, depth = frame.f_back, depth + 1
            top[2] = max(0, min(MAX_DEPTH, sys.getrecursionlimit() - depth - 50))
            st[0] = 0
            try:
                result = program.run(F, I, top, st, *passed)
            except Exception as exc:
                # The generated code did not compile: never try this program again.
                for array_value, state in array_states:
                    array_value[...] = state
                program.broken, self.problem = True, f"{type(exc).__name__}: {str(exc)[:600]}"
                return False, None
            if st[0]:
                for array_value, state in array_states:
                    array_value[...] = state
            if st[0] == 2 and self.slots < MAX_SLOTS:
                # The heap filled up. Array stores were undone: retry with more.
                self.slots *= 2
                if loader.native:
                    # The arguments were copied into the old arrays: copy them again.
                    try:
                        loader, passed = self.load(program, args)
                    except _Mismatch:
                        return False, None
                continue
            if st[0]:
                # Where compiled code gave up, if a check in the region did it; an
                # int overflow or a full heap leaves no line.
                if top[3] >= 0:
                    info = program.order[int(top[3]) // 1000000]
                    self.gave_up = info.fn.__qualname__, info.fn.__code__.co_firstlineno + int(top[3]) % 1000000 - 1
                else:
                    self.gave_up = None
                return False, None
            break
        unloader = _Unloader(program, loader, F, I)
        kind = program.entry.ret
        codes = [] if kind in (NONE, BOTTOM) else (list(result) if _width(kind) > 1 else [result])
        try:
            value = unloader.result(kind, codes)
        except (_Mismatch, MemoryError):
            # Conversion precedes heap write-back. Zero-copy stores must also be
            # undone before Python retries the call.
            for array_value, state in array_states:
                array_value[...] = state
            return False, None
        unloader.write_back(loader)
        if getattr(loader, "rngs", None):
            from ._rng import store

            for rng, handle in loader.rngs:
                store(rng, I, handle)
        # Count the program that actually completed, including generator consumers
        # and resumed coroutines. Preparation, bailout and retries count nothing.
        if program.ahead_of_time:
            self.aot_calls += 1
        else:
            self.jit_calls += 1
        return True, (collected if generator else value)

    def __call__(self, *args, **kwargs):
        if self.original.__code__.co_flags & _GENERATOR_FLAGS:
            # Its values are worked out at once only where nothing runs between them
            # (Region.values); a generator handed to Python is Python's own.
            self.fallback_calls += 1
            return self.original(*args, **kwargs)
        if self.original.__code__.co_flags & 0x80:
            # Calling a coroutine function makes a coroutine; the work runs when it is
            # first resumed, so the compiled call waits until then too.
            return self._resumed(args, kwargs)
        try:
            ok, value = self.attempt(args, kwargs)
        except RecursionError:
            ok = False
        if ok:
            self.compiled_calls += 1
            return value
        self.fallback_calls += 1
        return self.original(*args, **kwargs)

    def values(self, args):
        """What a call of this generator function with ``args`` yields, as a list from
        compiled code, or None if it fell back. Compiled code copies objects into its
        heap, so this is only right where no Python code runs between the values the
        generator yields: a loop over it whose body does nothing (see runner.py)."""
        try:
            ok, values = self.attempt(tuple(args))
        except RecursionError:
            ok = False
        if ok:
            self.compiled_calls += 1
            return values
        self.fallback_calls += 1
        return None

    async def _resumed(self, args, kwargs):
        try:
            ok, value = self.attempt(args, kwargs)
        except RecursionError:
            ok = False
        if ok:
            self.compiled_calls += 1
            return value
        self.fallback_calls += 1
        return await self.original(*args, **kwargs)


def _binding_metadata(fn):
    """Exact parameter metadata shared by entry and compiled-callee binding."""
    if type(fn) is not FunctionType:
        return None
    defaults, kwdefaults = fn.__defaults__, fn.__kwdefaults__
    if defaults is None:
        defaults = ()
    if kwdefaults is None:
        kwdefaults = {}
    if type(defaults) is not tuple or type(kwdefaults) is not dict:
        return None
    code = fn.__code__
    names = code.co_varnames[:code.co_argcount + code.co_kwonlyargcount]
    if not all(type(name) is str for name in names) or not all(type(name) is str for name in kwdefaults):
        return None
    return defaults, kwdefaults


def _bind_entry(fn, args, kwargs):
    """Bind exact Python parameter metadata without signature/annotation hooks.

    Unsupported metadata returns None so the original call owns its behavior.
    Compiled order is positional, keyword-only, then the existing *args tuple.
    """
    if type(fn) is not FunctionType or type(args) is not tuple or type(kwargs) is not dict:
        return None
    code = fn.__code__
    if code.co_flags & 0x08:
        return None
    metadata = _binding_metadata(fn)
    if metadata is None:
        return None
    defaults, kwdefaults = metadata
    count, kwcount = code.co_argcount, code.co_kwonlyargcount
    names = code.co_varnames[:count + kwcount]
    if not all(type(name) is str for name in names):
        return None
    if not all(type(name) is str for name in kwargs) or not all(type(name) is str for name in kwdefaults):
        return None
    star = bool(code.co_flags & _VARARGS)
    if len(args) > count and not star:
        return None
    indices = {name: index for index, name in enumerate(names)}
    provided = min(len(args), count)
    for name in kwargs:
        index = indices.get(name)
        if index is None or index < code.co_posonlyargcount or index < provided:
            return None
    out = list(args[:count])
    for index in range(provided, count):
        name = names[index]
        if name in kwargs:
            out.append(kwargs[name])
        elif index >= count - len(defaults):
            out.append(defaults[index - count + len(defaults)])
        else:
            return None
    for name in names[count:]:
        if name in kwargs:
            out.append(kwargs[name])
        elif name in kwdefaults:
            out.append(kwdefaults[name])
        else:
            return None
    if star:
        out.append(args[count:])
    return tuple(out)


async def _replay(values):
    for value in values:
        yield value


def lift_region(fn, ahead_of_time=None, seeds=None, prepared=None):

    """Compile ``fn`` and everything it reaches as one region. Compilation happens on
    the first call, when the argument types are known; a region that cannot be
    compiled runs as plain Python, and ``problem`` says why. ``ahead_of_time`` maps
    source digests to functions of a module built by ``build_regions``."""
    return Region(_unwrap(fn), ahead_of_time, seeds, prepared)


def _inlined_entry(program):
    """The program's entry function from its source with small functions inlined, for
    an ahead-of-time build. The module is registered so recursive calls link."""
    module = pytypes.ModuleType(f"rc_inlined_heap{next(_MODULE_NUMBERS)}")
    sys.modules[module.__name__] = module
    exec(compile(program.source, f"<recompyler region:{program.entry_fn.__name__}>", "exec"), module.__dict__)
    return module.__dict__[program.entry.name].py_func


def _source_digest(source):
    """A hash of a region's generated code (constants included) and of the code that
    generates and runs it, computed without loading Numba."""
    digest = hashlib.sha256(source.encode())
    for name in ("heap.py", "escape.py", "scalar.py", "lift.py", "_region_seed.py"):
        digest.update(hashlib.sha256((Path(__file__).parent / name).read_bytes()).digest())
    digest.update(sys.version.encode())
    return digest.hexdigest()


def build_regions(entries, folder, *, plan_factory=None):
    """Compile the regions the profiler verified into one extension module, so a
    later run uses them without importing Numba.

    ``entries`` holds ((name, line), function, region). Every program the region
    compiled with exactly one signature is exported, keyed by its source digest.
    Returns the plan section, or None if nothing was built.
    """
    planned, exports, pending = [], [], []
    export_numbers = itertools.count()
    for (name, line), fn, region in entries:
        if getattr(region, "experimental_numeric", False):
            # Experimental policy manifests have their own explicit builder/loader.
            # Type-only strict inference seeds cannot encode range/wrap contracts.
            continue
        digests, seeds, legacy = {}, {}, {}
        function_exports, complete_strict_coverage = set(), True
        for program in region.programs.values():
            if program is None or program.broken or getattr(program, "ahead_of_time", False):
                continue
            overloads = list(getattr(program.run, "overloads", {}).values())
            if len(overloads) != 1:
                continue
            export = f"r{next(export_numbers)}"
            exports.append((export, overloads[0].signature, _inlined_entry(program)))
            digests[program.digest] = legacy[program.digest] = export
            function_exports.add(export)
            pending.append((program, None, export, 'legacy'))
            strict_covered = False
            source_exports = {program.source: export}
            for widen_objects in (False, True):
                try:
                    from ._region_seed import capture, restore, seal

                    seed = capture(program, widen_objects=widen_objects)
                    normalized = restore(fn, seed)
                    class SourceOnly(dict):
                        def __bool__(self):
                            return True
                        def get(self, digest, default=None):
                            return True
                    normalized.compile(SourceOnly())
                    seed = seal(seed, normalized)
                    sealed = restore(fn, seed)
                    sealed.compile(SourceOnly())
                    if sealed.source != normalized.source:
                        continue
                    normalized = sealed
                    # Nullable startup edges can reveal a new return branch. The
                    # verified native signature is reusable only with the same ABI.
                    if (_machine_types(normalized.entry.ret) != _machine_types(program.entry.ret)
                            or _param_kinds(normalized.entry) != _param_kinds(program.entry)
                            or (program.entry.constant is not None
                                and normalized.entry.constant != program.entry.constant)):
                        continue
                    if normalized.source != program.source:
                        # A startup branch may contain math absent from the warm
                        # verified program. Validate it here, never on an AOT hit.
                        normalized.check_math()
                except Unsupported:
                    continue
                # Strict and widened seeds each bind their own type metadata.
                # Byte-identical generated code may share the same native export.
                seeded_export = source_exports.get(normalized.source)
                if seeded_export is None:
                    seeded_export = f"r{next(export_numbers)}"
                    exports.append((seeded_export, overloads[0].signature, _inlined_entry(normalized)))
                    function_exports.add(seeded_export)
                    source_exports[normalized.source] = seeded_export
                digests[normalized.digest] = seeded_export
                seeds[normalized.digest] = seed
                pending.append((normalized, seed, seeded_export, 'wide-seed' if widen_objects else 'strict-seed'))
                if not widen_objects:
                    strict_covered = True
            complete_strict_coverage = complete_strict_coverage and strict_covered
        if digests:
            if not complete_strict_coverage:
                # Partial seeds must not hide another signature's valid legacy
                # export. Select baseline exact regeneration for this function
                # as a whole, rather than escaping after a guarded seed rejects.
                kept = set(legacy.values())
                exports = [row for row in exports if row[0] not in function_exports or row[0] in kept]
                digests, seeds = legacy, {}
            planned.append({"function": name, "line": line, "qualname": fn.__qualname__, "file": fn.__code__.co_filename,
                        "origin": __import__("recompyler._origin", fromlist=["identity"]).identity(fn),
                            "exports": digests, "seeds": seeds,
                            "seed_policy": "guarded" if complete_strict_coverage else "legacy-only",
                            "seed_policy_reason": None if complete_strict_coverage else
                            "not all verified signatures have guarded strict seeds"})
    if not planned:
        return None
    from ._pycc import CC
    from . import _prepared as pc
    section = dict(functions=planned)
    snapshot = (plan_factory(section) if plan_factory is not None else
                dict(mode='standalone', functions=[], plan=dict(aot_regions=section)))
    key = pc.plan_key(snapshot)
    build_key = dict(compiler=pc.compiler_key(), runtime=pc.runtime_key())
    cores, signatures, diagnostics = [], {}, []
    for program, seed, export, variant in pending:
        row = next((r for r in planned if r['qualname'] == program.entry_fn.__qualname__
                    and r['exports'].get(program.digest) == export), None)
        if row is None: continue
        signatures[program.digest] = pc._signature(program)
        try:
            core = pc.capture(program, seed=seed, export=export, plan_key=key,
                              build_key=build_key, variant=variant)
            if pc.core_id(core) not in {pc.core_id(c) for c in cores}: cores.append(core)
        except (pc.PreparedMiss, OSError, KeyError, IndexError, TypeError, ValueError, AttributeError, RecursionError) as exc:
            diagnostics.append(dict(function=row['qualname'], variant=variant, reason=str(exc)))
    for row in planned:
        row['prepared'] = [pc.core_id(c) for c in cores if c['entry_id']['qualname']==row['qualname']
                           and c['generated']['digest'] in row['exports']]
    # Freeze mapping, ABI and record membership in the same native seal.
    import json
    signatures = json.loads(pc.canonical(signatures))
    manifest = dict(functions=json.loads(pc.canonical(planned)), signatures=signatures)
    prepared = pc.bundle(cores, manifest, build_key)
    prepared['diagnostics'] = diagnostics
    identity = prepared['bundle_seal'][:24]
    module = f"rcaotr_{identity}"
    cc = CC(module)
    cc.output_dir = str(folder)
    cc.verbose = False
    for export, signature, function in exports:
        cc.export(export, signature)(function)
    words = tuple(int(prepared['bundle_seal'][i:i+8], 16) for i in range(0, 64, 8))
    namespace = {'__name__': __name__}
    exec('def _prepared_seal():\n    return ' + repr(words), namespace)
    cc.export('_prepared_seal', 'UniTuple(uint64, 8)()')(namespace['_prepared_seal'])
    path = Path(folder) / cc.output_file
    if path.exists():
        raise Unsupported('refuse to reuse an existing prepared artifact build')
    cc.compile()
    prepared['artifact'] = dict(file=path.name, length=path.stat().st_size,
                               sha256=hashlib.sha256(path.read_bytes()).hexdigest())
    section.update(module=module, folder=str(folder), prepared=prepared)
    return section
