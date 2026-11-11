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

import ast
import builtins
import functools
import hashlib
import importlib.util
import inspect
import itertools
import math
from pathlib import Path
import sys
import textwrap
import types as pytypes
from types import FunctionType

from .lift import (INT_MAX, INT_MIN, MATH, MATH_CONSTANTS, TRANSCENDENTAL, Unsupported, _check_flow, _init_fields,
                   _cache_dir, _local_names, _math_agrees, _record_problem, _runtime_key, _start_numba, _unwrap,
                   _write_once)

try:
    from . import _heap as _native
except ImportError:
    _native = None

# Ints up to this size are exact as floats.
EXACT = 2 ** 53
MAX_SIGNATURES = 8
START_SLOTS = 1 << 16
# Copy objects with the C loader when it is built; tests turn it off to check both.
NATIVE = True
MAX_SLOTS = 1 << 27
# Compiled recursion stops here at the latest; deeper calls go back to Python.
MAX_DEPTH = 3000

INT, FLOAT, BOOL, NONE, MIXED, BOTTOM = "i", "f", "b", "n", "m", "?"


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


class ObjT:
    def __init__(self, cls, nullable=False):
        self.cls, self.nullable = cls, nullable

    def __eq__(self, other):
        return isinstance(other, ObjT) and other.cls is self.cls and other.nullable == self.nullable

    __hash__ = None


class TupT:
    def __init__(self, items):
        self.items = tuple(items)

    def __eq__(self, other):
        return isinstance(other, TupT) and len(other.items) == len(self.items) and all(
            a == b for a, b in zip(self.items, other.items))

    __hash__ = None


def _same(a, b):
    return a == b if type(a) is type(b) else False


def _describe(kind, seen=None):
    if isinstance(kind, str):
        return {INT: "int", FLOAT: "float", BOOL: "bool", NONE: "None", MIXED: "int-or-float", BOTTOM: "nothing"}[kind]
    if isinstance(kind, ObjT):
        return kind.cls.__name__ + ("-or-None" if kind.nullable else "")
    if isinstance(kind, TupT):
        return "(" + ", ".join(_describe(item, seen) for item in kind.items) + ")"
    seen = seen or set()
    cell = _find(kind.cell)
    if id(cell) in seen:
        return "list[...]"
    return f"list[{_describe(cell.elem, seen | {id(cell)})}]"


def _width(kind):
    if kind == MIXED:
        return 2
    if isinstance(kind, TupT):
        return sum(map(_width, kind.items))
    return 1


def _dummy(kind):
    """Values of the right machine types for a result that will be thrown away."""
    if kind == FLOAT:
        return ["0.0"]
    if kind == BOOL:
        return ["False"]
    if kind == MIXED:
        return ["0.0", "False"]
    if kind in (INT, BOTTOM):
        return ["0"]
    if isinstance(kind, TupT):
        return [code for item in kind.items for code in _dummy(item)]
    return ["-1"]


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
    if isinstance(last, ast.While):
        endless = isinstance(last.test, ast.Constant) and bool(last.test.value)
        return endless and not any(isinstance(item, ast.Break) for item in ast.walk(last))
    return False


class _Function:
    """One Python function in the region, and the types of its variables."""

    def __init__(self, program, fn, owner=None):
        self.fn, self.owner = fn, owner
        code = fn.__code__
        if fn.__closure__ or code.co_kwonlyargcount or code.co_flags & 0x2AC:
            raise Unsupported(f"'{fn.__qualname__}' has a closure, keyword-only arguments, *args or is a generator")
        try:
            tree = ast.parse(textwrap.dedent(inspect.getsource(fn)))
        except (OSError, TypeError, SyntaxError) as exc:
            raise Unsupported(f"no source for '{fn.__qualname__}'") from exc
        node = tree.body[0]
        if not isinstance(node, ast.FunctionDef) or node.decorator_list or node.name != fn.__name__:
            raise Unsupported(f"'{fn.__qualname__}' is decorated or not a plain def")
        self.node = node
        self.params = [arg.arg for arg in node.args.posonlyargs + node.args.args]
        self.locals = _local_names(node) | set(self.params)
        for item in ast.walk(node):
            if isinstance(item, (ast.Global, ast.Nonlocal, ast.Lambda, ast.FunctionDef, ast.ClassDef)) and item is not node:
                raise Unsupported(f"'{fn.__qualname__}' declares globals or defines functions inside itself")
        try:
            _check_flow(node, self.params, self.locals)
        except Unsupported as exc:
            # A function may return None on some paths here; a local read before it
            # is assigned is still refused, and that is checked before these.
            if "may be read before assignment" in str(exc):
                raise
        self.falls_through = not _terminates(node.body)
        self.vars, self.ret = {}, BOTTOM
        self.name = f"f{len(program.functions)}_{fn.__name__}"
        self.recursive = False
        self.source = ""


class _Program:
    """A region compiled for one set of argument types."""

    def __init__(self, entry):
        self.entry_fn = entry
        self.functions, self.order, self.changed = {}, [], False
        # Class -> {attribute: type}, in slot order; and the attributes code assigns
        # outside the constructor, which have to be written back.
        self.fields, self.written = {}, set()
        self.guards, self.calls = {}, {}
        self.broken = False
        self.entry = self.function(entry)

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
        elif isinstance(a, ObjT) or isinstance(b, ObjT):
            if a == NONE:
                return ObjT(b.cls, True)
            if b == NONE:
                return ObjT(a.cls, True)
            if isinstance(a, ObjT) and isinstance(b, ObjT) and a.cls is b.cls:
                return ObjT(a.cls, a.nullable or b.nullable)
        elif isinstance(a, ListT) and isinstance(b, ListT):
            self.unify(a.cell, b.cell)
            return a
        elif isinstance(a, TupT) and isinstance(b, TupT) and len(a.items) == len(b.items):
            return TupT(self.join(x, y) for x, y in zip(a.items, b.items))
        raise Unsupported(f"one value can be {_describe(a)} or {_describe(b)}")

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
            if joined == MIXED or isinstance(joined, TupT):
                raise Unsupported("a list holds both ints and floats, or tuples")

    def widen(self, store, key, kind):
        old = store.get(key, BOTTOM)
        joined = self.join(old, kind)
        if key not in store or not _same(joined, old):
            store[key], self.changed = joined, True
        return joined

    # Classes

    def register(self, cls):
        if cls in self.fields:
            return self.fields[cls]
        problem = _record_problem(cls)
        if problem:
            raise Unsupported(problem)
        init = getattr(cls, "__init__")
        if init is object.__init__:
            names = []
        else:
            if not isinstance(init, FunctionType):
                raise Unsupported(f"'{cls.__name__}.__init__' is not a plain function")
            names = sorted(_init_assigned(cls, init))
            self.guard("attr", cls, "__init__", init)
        self.fields[cls] = {name: BOTTOM for name in names}
        return self.fields[cls]

    def layout(self, cls):
        """({attribute: slot offset}, slots) for the current attribute types."""
        offsets, at = {}, 0
        for name, kind in self.fields[cls].items():
            if isinstance(kind, TupT):
                raise Unsupported(f"'{cls.__name__}.{name}' holds a tuple")
            offsets[name] = at
            at += _width(kind)
        return offsets, max(at, 1)

    def load_plan(self, cls):
        """(attribute names, slots, [(name, offset, type, is float)]) for loading
        objects of ``cls``; worked out once, since types are fixed after compiling."""
        plans = self.__dict__.setdefault("_load_plans", {})
        plan = plans.get(cls)
        if plan is None:
            fields = self.fields[cls]
            offsets, size = self.layout(cls)
            plan = plans[cls] = (fields.keys(), size, [(name, offsets[name], kind, isinstance(kind, str) and kind == FLOAT)
                                                        for name, kind in fields.items()])
        return plan

    # Types for the C loader (_heap.c): small ints for numbers and None, lists for
    # objects and lists, which may refer to themselves.

    def c_kind(self, kind, item=False):
        if isinstance(kind, str):
            if item and kind == MIXED:
                return 9
            return _C_CODES.get(kind, 9)
        if isinstance(kind, TupT):
            return 9
        cache = self.__dict__.setdefault("_c_kinds", {})
        if isinstance(kind, ObjT):
            key = kind.cls, kind.nullable
            made = cache.get(key)
            if made is None:
                made = cache[key] = [10, kind.cls, kind.nullable, self.c_plan(kind.cls)]
            return made
        root = _find(kind.cell)
        made = cache.get(id(root))
        if made is None:
            made = cache[id(root)] = [11, 9, kind, root]
            made[1] = self.c_kind(root.elem, item=True)
        return made

    def c_plan(self, cls):
        plans = self.__dict__.setdefault("_c_plans", {})
        plan = plans.get(cls)
        if plan is None:
            fields = self.fields[cls]
            offsets, size = self.layout(cls)
            plan = plans[cls] = [size, tuple(fields), tuple(offsets[name] for name in fields), []]
            plan[3].extend(self.c_kind(kind) for kind in fields.values())
        return plan

    def c_write_plans(self):
        """{class: ((name, offset, code, type), ...)} for the attributes code writes."""
        plans = self.__dict__.get("_c_write_plans")
        if plans is None:
            plans = {}
            for cls, fields in self.fields.items():
                offsets = self.layout(cls)[0]
                written = tuple((name, offsets[name], _C_CODES.get(kind, 20) if isinstance(kind, str) else 20, kind)
                                for name, kind in fields.items() if (cls, name) in self.written)
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

    def function(self, fn, owner=None):
        info = self.functions.get(fn)
        if info is None:
            info = self.functions[fn] = _Function(self, fn, owner)
            self.guard("code", fn, fn.__code__)
        if info not in self.order:
            self.order.append(info)
        return info

    # Compiling

    def compile(self):
        for _ in range(60):
            self.changed, self.order, self.calls = False, [self.entry], {}
            position = 0
            while position < len(self.order):
                info = self.order[position]
                info.source = _Gen(self, info).run()
                position += 1
            if self.mark_recursive():
                self.changed = True
            if not self.changed:
                break
        else:
            raise Unsupported("the types in this region did not settle")
        used = {name for info in self.order for name in getattr(info, "math_used", ())}
        differs = sorted(used.intersection(TRANSCENDENTAL) - _math_agrees())
        if differs:
            raise Unsupported(f"math.{differs[0]} gives different results when compiled on this machine")
        self.source = _RUNTIME + "\n\n".join(info.source for info in self.order) + "\n"
        _start_numba()
        # The module must be registered: Numba names functions from unregistered
        # modules afresh on each compile, and recursive calls then fail to link. The
        # name also marks the functions as RecomPyler's for reference-count removal.
        # Numba's disk cache cannot reload functions that call each other (the
        # reloaded code crashes), so such regions compile afresh in each process.
        module = None if self.mutually_recursive() else _cached_module(self.source)
        self.cached = module is not None
        if module is None:
            module = pytypes.ModuleType(f"recompyler_generated_heap{next(_MODULE_NUMBERS)}")
            sys.modules[module.__name__] = module
            exec(compile(self.source, f"<recompyler region:{self.entry_fn.__name__}>", "exec"), module.__dict__)
        self.module = module
        self.run = module.__dict__[self.entry.name]

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

    def mutually_recursive(self):
        """True if two different functions in the region can each reach the other."""
        def reach(info):
            seen, stack = set(), list(self.calls.get(info, ()))
            while stack:
                other = stack.pop()
                if other not in seen:
                    seen.add(other)
                    stack.extend(self.calls.get(other, ()))
            return seen

        return any(other is not info and info in reach(other)
                   for info in self.order if info.recursive for other in reach(info))

    def guards_hold(self):
        for guard in self.guards.values():
            kind = guard[0]
            if kind == "code":
                if guard[1].__code__ is not guard[2]:
                    return False
            elif kind == "attr":
                if getattr(guard[1], guard[2], None) is not guard[3]:
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
        return True


def _init_assigned(cls, init):
    """The attributes ``__init__`` sets, after checking it sets every one of them
    before the new object is used for anything else, so no attribute of an object
    in the heap is ever unset."""
    names = _init_fields(init)
    if names is None:
        raise Unsupported(f"no source for '{cls.__name__}.__init__'")
    node = ast.parse(textwrap.dedent(inspect.getsource(init))).body[0]
    me = node.args.args[0].arg
    assigned = set()
    for statement in node.body:
        if assigned == names:
            break
        mentions = [item for item in ast.walk(statement) if isinstance(item, ast.Name) and item.id == me]
        if not mentions:
            continue
        simple = isinstance(statement, ast.Assign) and not any(
            isinstance(item, ast.Name) and item.id == me for item in ast.walk(statement.value))
        targets = [target for target in statement.targets] if simple else []
        own = [target for target in targets if isinstance(target, ast.Attribute)
               and isinstance(target.value, ast.Name) and target.value.id == me]
        if not simple or len(own) != len(mentions):
            raise Unsupported(f"'{cls.__name__}.__init__' uses the new object before setting all its attributes")
        assigned.update(target.attr for target in own)
    if assigned != names:
        raise Unsupported(f"'{cls.__name__}.__init__' does not always set every attribute")
    return names


_MODULE_NUMBERS = itertools.count()
_DECORATOR = '@njit(error_model="numpy")'


@functools.cache
def _heap_key():
    """Changes whenever this module or the lifter's runtime changes."""
    return hashlib.sha256(Path(__file__).read_bytes() + _runtime_key().encode()).hexdigest()


def _cached_module(source):
    """The generated ``source`` as a module file in the cache directory, compiled with
    Numba's disk cache, so a later process loads the machine code instead of compiling.
    The file is named after a hash of the source, which holds every constant the code
    uses. None if caching is off or the file cannot be used."""
    folder = _cache_dir()
    if folder is None:
        return None
    cached = source.replace(_DECORATOR, '@njit(error_model="numpy", cache=True)')
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
_COMPARISONS = {ast.Lt: "<", ast.LtE: "<=", ast.Gt: ">", ast.GtE: ">=", ast.Eq: "==", ast.NotEq: "!="}

_RUNTIME = '''import math

import numpy as np
from numba import njit


@njit(error_model="numpy")
def alloc(I, top, st, slots):
    start = top[0]
    if start + slots > len(I):
        st[0] = 2
        return 0
    top[0] = start + slots
    return start


@njit(error_model="numpy")
def list_new(I, top, st, length, capacity):
    data = alloc(I, top, st, capacity)
    h = alloc(I, top, st, 3)
    if st[0]:
        return 0
    I[h] = length
    I[h + 1] = capacity
    I[h + 2] = data
    return h


@njit(error_model="numpy")
def list_fill(I, top, st, count, value):
    size = count if count > 0 else 0
    h = list_new(I, top, st, size, size)
    if st[0]:
        return 0
    data = I[h + 2]
    for k in range(size):
        I[data + k] = value
    return h


@njit(error_model="numpy")
def list_fill_f(F, I, top, st, count, value):
    size = count if count > 0 else 0
    h = list_new(I, top, st, size, size)
    if st[0]:
        return 0
    data = I[h + 2]
    for k in range(size):
        F[data + k] = value
    return h


@njit(error_model="numpy")
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


@njit(error_model="numpy")
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


@njit(error_model="numpy")
def add_i(st, a, b):
    r = a + b
    if ((a ^ r) & (b ^ r)) < 0:
        st[0] = 1
    return r


@njit(error_model="numpy")
def sub_i(st, a, b):
    r = a - b
    if ((a ^ b) & (a ^ r)) < 0:
        st[0] = 1
    return r


@njit(error_model="numpy")
def mul_i(st, a, b):
    estimate = float(a) * float(b)
    if estimate >= 9.2e18 or estimate <= -9.2e18:
        st[0] = 1
        return 0
    return a * b


@njit(error_model="numpy")
def floordiv_i(st, a, b):
    if b == 0 or (b == -1 and a == -a and a != 0):
        st[0] = 1
        return 0
    return a // b


@njit(error_model="numpy")
def mod_i(st, a, b):
    if b == 0 or b == -1:
        if b == 0:
            st[0] = 1
        return 0
    return a % b


'''


class _Gen:
    """One pass over one function: widens types and writes its compiled form."""

    def __init__(self, program, info):
        self.program, self.info = program, info
        self.namespace, self.builtins = info.fn.__globals__, info.fn.__builtins__
        self.lines, self.depth, self.counter, self.line = [], 1, 0, 0
        self.math_used = set()
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
        saved = len(self.lines), self.depth, self.counter
        kind, _ = self.expr(node)
        del self.lines[saved[0]:]
        self.depth, self.counter = saved[1], saved[2]
        return kind

    def unsupported(self, what, node):
        raise Unsupported(f"{what} at line {getattr(node, 'lineno', '?')} of '{self.info.fn.__qualname__}'")

    # Variables

    def var_codes(self, name, kind):
        width = _width(kind)
        return [f"v_{name}"] if width == 1 else [f"v_{name}_{index}" for index in range(width)]

    def coerce(self, kind, codes, target):
        """The codes for a value of ``kind`` stored where ``target`` is expected."""
        if kind == BOTTOM or target == BOTTOM:
            return _dummy(target)
        if target == MIXED and kind != MIXED:
            return list(self.as_mixed(kind, codes))
        if isinstance(target, ObjT):
            return ["-1"] if kind == NONE else codes
        if isinstance(target, TupT):
            out, at = [], 0
            for item, wanted in zip(kind.items, target.items):
                width = _width(item)
                out += self.coerce(item, codes[at:at + width], wanted)
                at += width
            return out
        return codes

    def assign(self, name, kind, codes):
        joined = self.program.widen(self.info.vars, name, kind)
        for target, code in zip(self.var_codes(name, joined), self.coerce(kind, codes, joined)):
            self.emit(f"{target} = {code}")

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

    def numeric(self, kind, node):
        if kind not in (INT, FLOAT, BOOL, MIXED):
            self.unsupported(f"arithmetic on {_describe(kind)}", node)

    def binop(self, op, left, right, node):
        (lk, lc), (rk, rc) = left, right
        if lk == BOTTOM or rk == BOTTOM:
            return BOTTOM, ["0"]
        self.numeric(lk, node)
        self.numeric(rk, node)
        whole = lk in (INT, BOOL) and rk in (INT, BOOL)
        if op in _ARITHMETIC:
            sign, helper = _ARITHMETIC[op]
            if whole:
                value = self.temp(f"{helper}(st, {self.as_int(lk, lc)}, {self.as_int(rk, rc)})")
                self.check()
                return INT, [value]
            if MIXED not in (lk, rk):
                return FLOAT, [f"({self.as_float(lk, lc)} {sign} {self.as_float(rk, rc)})"]
            (av, at), (bv, bt) = self.as_mixed(lk, lc), self.as_mixed(rk, rc)
            if "False" in (at, bt):
                return FLOAT, [f"({av} {sign} {bv})"]
            value, flag = self.temp(f"{av} {sign} {bv}"), self.temp(f"{at} and {bt}")
            # Two ints: the float result is the int result while it stays exact, and
            # an int zero is never negative.
            self.emit(f"if {flag}:")
            self.emit(f"    if {value} >= {EXACT}.0 or {value} <= -{EXACT}.0:")
            self.emit("        st[0] = 1")
            self.emit(f"        top[3] = {self.where()}")
            self.emit("        " + self.bail())
            self.emit(f"    {value} += 0.0")
            return MIXED, [value, flag]
        if op is ast.Div:
            # int / int is the correctly rounded quotient of the ints themselves.
            both_exact = FLOAT not in (lk, rk)
            top = self.as_float(lk, lc, exact=both_exact)
            bottom = self.temp(self.as_float(rk, rc, exact=both_exact))
            self.fail(f"{bottom} == 0.0")
            return FLOAT, [f"({top} / {bottom})"]
        if op in (ast.FloorDiv, ast.Mod) and whole:
            helper = "floordiv_i" if op is ast.FloorDiv else "mod_i"
            value = self.temp(f"{helper}(st, {self.as_int(lk, lc)}, {self.as_int(rk, rc)})")
            self.check()
            return INT, [value]
        self.unsupported(f"operator {op.__name__} on {_describe(lk)} and {_describe(rk)}", node)

    def truth(self, kind, codes, node):
        if kind == BOOL:
            return codes[0]
        if kind == INT:
            return f"({codes[0]} != 0)"
        if kind in (FLOAT, MIXED):
            return f"({codes[0]} != 0.0)"
        if kind in (NONE, BOTTOM):
            return "False"
        if isinstance(kind, ObjT):
            return f"({codes[0]} >= 0)" if kind.nullable else "True"
        if isinstance(kind, ListT):
            return self.temp(f"I[{codes[0]}] != 0")
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

    def slot(self, kind, where):
        """Codes that read the value of ``kind`` stored at slot expression ``where``."""
        if kind == FLOAT:
            return [f"F[{where}]"]
        if kind == MIXED:
            return [f"F[{where}]", f"(I[{where} + 1] != 0)"]
        if kind == BOOL:
            return [f"(I[{where}] != 0)"]
        if kind in (NONE, BOTTOM):
            return ["-1"] if kind == NONE else ["0"]
        return [f"I[{where}]"]

    def store(self, kind, where, codes):
        if kind == FLOAT:
            self.emit(f"F[{where}] = {codes[0]}")
        elif kind == MIXED:
            self.emit(f"F[{where}] = {codes[0]}")
            self.emit(f"I[{where} + 1] = {codes[1]}")
        else:
            self.emit(f"I[{where}] = {codes[0]}")

    def field(self, kind, node, attr):
        if kind == BOTTOM:
            return None, None
        if not isinstance(kind, ObjT) and kind != NONE:
            self.unsupported(f"attribute '{attr}' of {_describe(kind)}", node)
        if kind == NONE:
            return None, None
        fields = self.program.register(kind.cls)
        if attr not in fields:
            self.unsupported(f"'{kind.cls.__name__}.{attr}', which __init__ does not set", node)
        return fields, self.program.layout(kind.cls)[0][attr]

    def index(self, base, position, node):
        """A checked position in a list: a temp holding the item's slot."""
        (bk, bc), (pk, pc) = base, position
        if pk not in (INT, BOOL):
            self.unsupported(f"a list index that is {_describe(pk)}", node)
        size = self.temp(f"I[{bc[0]}]")
        at = self.temp(self.as_int(pk, pc))
        self.emit(f"if {at} < 0:")
        self.emit(f"    {at} += {size}")
        self.fail(f"{at} < 0 or {at} >= {size}")
        return self.temp(f"I[{bc[0]} + 2] + {at}")

    def check_item(self, kind, node):
        if kind == MIXED or isinstance(kind, TupT):
            self.unsupported("a list that holds both ints and floats, or tuples", node)

    # Expressions

    def expr(self, node):
        method = getattr(self, "expr_" + type(node).__name__, None)
        if method is None:
            self.unsupported(type(node).__name__, node)
        return method(node)

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
        self.unsupported(f"constant {value!r}", node)

    def constant(self, value, node):
        return self.expr_Constant(ast.copy_location(ast.Constant(value=value), node))

    def expr_Name(self, node):
        if node.id in self.info.locals:
            kind = self.info.vars.get(node.id, BOTTOM)
            return kind, (self.var_codes(node.id, kind) if kind != BOTTOM else ["0"])
        if node.id in self.namespace:
            value = self.namespace[node.id]
            if type(value) in (int, float, bool) or value is None:
                self.program.guard("const", self.namespace, node.id, value)
                return self.constant(value, node)
        self.unsupported(f"name '{node.id}' used as a value", node)

    def is_math(self, node):
        return (isinstance(node, ast.Name) and node.id not in self.info.locals
                and self.namespace.get(node.id) is math)

    def expr_Attribute(self, node):
        if self.is_math(node.value):
            if node.attr not in MATH_CONSTANTS or node.attr == "inf":
                self.unsupported(f"math.{node.attr}", node)
            self.program.guard("item", self.namespace, node.value.id, math)
            self.program.guard("const", math.__dict__, node.attr, getattr(math, node.attr))
            return FLOAT, [repr(getattr(math, node.attr))]
        kind, codes = self.expr(node.value)
        fields, offset = self.field(kind, node, node.attr)
        if fields is None:
            if kind == NONE:
                self.fail("True")
            return BOTTOM, ["0"]
        base = self.handle(kind, codes, node)
        found = fields[node.attr]
        return found, [self.temp(code) for code in self.slot(found, f"{base} + {offset}")]

    def expr_Subscript(self, node):
        kind, codes = self.expr(node.value)
        if isinstance(kind, TupT):
            if not (isinstance(node.slice, ast.Constant) and type(node.slice.value) is int
                    and -len(kind.items) <= node.slice.value < len(kind.items)):
                self.unsupported("a tuple index that is not a constant in range", node)
            position = node.slice.value % len(kind.items)
            start = sum(map(_width, kind.items[:position]))
            return kind.items[position], codes[start:start + _width(kind.items[position])]
        if kind == BOTTOM:
            self.expr(node.slice) if not isinstance(node.slice, ast.Slice) else None
            return BOTTOM, ["0"]
        if not isinstance(kind, ListT):
            self.unsupported(f"indexing {_describe(kind)}", node)
        if isinstance(node.slice, ast.Slice):
            if node.slice.step is not None:
                self.unsupported("a slice with a step", node)
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
        return kind.elem, [self.temp(code) for code in self.slot(kind.elem, where)]

    def expr_UnaryOp(self, node):
        if isinstance(node.op, ast.Not):
            return BOOL, [f"(not {self.cond(node.operand)})"]
        kind, codes = self.expr(node.operand)
        if kind == BOTTOM:
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
        codes = [self.temp(code) for _, item_codes in items for code in item_codes]
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
        left = self.expr(node.left)
        result = None
        for position, (op, comparator) in enumerate(zip(node.ops, node.comparators)):
            if position:
                self.emit(f"if {result}:")
                self.depth += 1
            right = self.expr(comparator)
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

        def reference(kind):
            return kind == NONE or isinstance(kind, (ObjT, ListT))

        if op in (ast.Is, ast.IsNot, ast.Eq, ast.NotEq) and reference(lk) and reference(rk):
            if op in (ast.Eq, ast.NotEq):
                for kind in (lk, rk):
                    if isinstance(kind, ListT):
                        self.unsupported("comparing lists", node)
                    if isinstance(kind, ObjT) and any("__eq__" in vars(klass) or "__ne__" in vars(klass)
                                                      for klass in kind.cls.__mro__[:-1]):
                        self.unsupported(f"comparing '{kind.cls.__name__}' objects that define ==", node)
            return f"({lc[0]} {'==' if op in (ast.Is, ast.Eq) else '!='} {rc[0]})"
        if op not in _COMPARISONS:
            self.unsupported("this comparison", node)
        self.numeric(lk, node)
        self.numeric(rk, node)
        if lk in (INT, BOOL) and rk in (INT, BOOL):
            return f"({self.as_int(lk, lc)} {_COMPARISONS[op]} {self.as_int(rk, rc)})"
        # Python compares an int with a float exactly, not after rounding the int.
        return f"({self.as_float(lk, lc, exact=True)} {_COMPARISONS[op]} {self.as_float(rk, rc, exact=True)})"

    # Calls

    def expr_Call(self, node):
        if node.keywords or any(isinstance(arg, ast.Starred) for arg in node.args):
            self.unsupported("a keyword or starred argument", node)
        func = node.func
        if isinstance(func, ast.Attribute):
            if self.is_math(func.value):
                self.program.guard("item", self.namespace, func.value.id, math)
                return self.math_call(func.attr, node)
            base = self.expr(func.value)
            if isinstance(base[0], ListT):
                return self.list_method(base, func.attr, node)
            if base[0] == BOTTOM:
                [self.expr(arg) for arg in node.args]
                return BOTTOM, ["0"]
            if base[0] == NONE:
                self.fail("True")
                return BOTTOM, ["0"]
            if not isinstance(base[0], ObjT):
                self.unsupported(f"method '{func.attr}' of {_describe(base[0])}", node)
            receiver = self.handle(base[0], base[1], node)
            callee = self.program.method(base[0].cls, func.attr)
            return self.call(callee, [(ObjT(base[0].cls), [receiver])] + [self.expr(arg) for arg in node.args], node)
        if not isinstance(func, ast.Name) or func.id in self.info.locals:
            self.unsupported("a call of something that is not a named function, class or method", node)
        name = func.id
        if name in self.namespace:
            target = self.namespace[name]
            known = getattr(target, "__name__", None)
            if known in MATH and target is MATH[known]:
                self.program.guard("item", self.namespace, name, target)
                return self.math_call(known, node)
            if isinstance(target, type):
                self.program.guard("item", self.namespace, name, target)
                return self.construct(target, node)
            if isinstance(target, FunctionType):
                self.program.guard("item", self.namespace, name, target)
                callee = self.program.function(_unwrap(target))
                return self.call(callee, [self.expr(arg) for arg in node.args], node)
            self.unsupported(f"a call of '{name}'", node)
        if getattr(builtins, name, None) is not None and self.builtins.get(name) is getattr(builtins, name):
            self.program.guard("builtin", self.namespace, name, self.builtins, getattr(builtins, name))
            return self.builtin(name, node)
        self.unsupported(f"a call of '{name}'", node)

    def call(self, callee, args, node):
        fn = callee.fn
        missing = len(callee.params) - len(args)
        defaults = fn.__defaults__ or ()
        if missing < 0 or missing > len(defaults):
            self.unsupported(f"a call of '{fn.__qualname__}' with the wrong number of arguments", node)
        if missing:
            self.program.guard("attr", fn, "__defaults__", defaults)
            args = args + [self.constant(value, node) for value in defaults[len(defaults) - missing:]]
        passed = []
        for name, (kind, codes) in zip(callee.params, args):
            wanted = self.program.widen(callee.vars, name, kind)
            passed += self.coerce(kind, codes, wanted)
        self.program.function(fn, callee.owner)
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
        else:
            self.counter += 1
            codes = [f"t{self.counter}_{index}" for index in range(_width(kind))]
            self.emit(f"{', '.join(codes)} = {invoke}")
            self.check()
        if callee.recursive:
            self.emit("top[1] -= 1")
        return kind, codes

    def construct(self, cls, node):
        fields = self.program.register(cls)
        args = [self.expr(arg) for arg in node.args]
        made = self.temp(f"alloc(I, top, st, {self.program.layout(cls)[1]})")
        self.check()
        init = getattr(cls, "__init__")
        if init is object.__init__:
            if args:
                self.unsupported(f"arguments to '{cls.__name__}', which has no __init__", node)
        else:
            callee = self.program.function(_unwrap(init), cls)
            self.call(callee, [(ObjT(cls), [made])] + args, node)
        del fields
        return ObjT(cls), [made]

    def math_call(self, name, node):
        if name not in MATH or getattr(math, name, None) is not MATH[name] or len(node.args) != 1:
            self.unsupported(f"math.{name}", node)
        self.program.guard("item", math.__dict__, name, MATH[name])
        kind, codes = self.expr(node.args[0])
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
        args = [self.expr(arg) for arg in node.args]
        if any(kind == BOTTOM for kind, _ in args):
            return BOTTOM, ["0"]
        if name == "len" and len(args) == 1 and isinstance(args[0][0], ListT):
            return INT, [self.temp(f"I[{args[0][1][0]}]")]
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
        self.unsupported(f"{name}() on {', '.join(_describe(kind) for kind, _ in args) or 'nothing'}", node)

    def list_method(self, base, name, node):
        (kind, codes), cell = base, _find(base[0].cell)
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
        self.unsupported(f"list method '{name}'", node)

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
        self.emit("break")

    def do_Continue(self, node):
        self.emit("continue")

    def do_Expr(self, node):
        if isinstance(node.value, ast.Constant) and isinstance(node.value.value, str):
            return
        if not isinstance(node.value, ast.Call):
            self.unsupported("an expression statement", node)
        self.expr(node.value)

    def do_Return(self, node):
        kind, codes = (NONE, ["-1"]) if node.value is None else self.expr(node.value)
        joined = self.program.widen(self.info.__dict__, "ret", kind)
        if joined in (NONE, BOTTOM):
            self.emit("return")
        else:
            self.emit("return " + ", ".join(self.coerce(kind, codes, joined)))

    def do_Raise(self, node):
        self.emit("st[0] = 1")
        self.emit(f"top[3] = {self.where()}")
        self.emit(self.bail())

    def do_If(self, node):
        self.block(f"if {self.cond(node.test)}:", node.body)
        if node.orelse:
            self.block("else:", node.orelse)

    def do_While(self, node):
        if node.orelse:
            self.unsupported("while ... else", node)
        self.emit("while True:")
        self.depth += 1
        self.emit(f"if not {self.cond(node.test)}:")
        self.emit("    break")
        self.body(node.body)
        self.depth -= 1

    def do_For(self, node):
        if node.orelse or not isinstance(node.target, ast.Name):
            self.unsupported("for ... else, or a loop target that is not one name", node)
        iterable, name = node.iter, node.target.id
        if (isinstance(iterable, ast.Call) and isinstance(iterable.func, ast.Name) and iterable.func.id == "range"
                and "range" not in self.info.locals and "range" not in self.namespace
                and self.builtins.get("range") is range and not iterable.keywords and 1 <= len(iterable.args) <= 3):
            self.program.guard("builtin", self.namespace, "range", self.builtins, range)
            bounds = []
            for arg in iterable.args:
                kind, codes = self.expr(arg)
                if kind not in (INT, BOOL, BOTTOM):
                    self.unsupported(f"range() of {_describe(kind)}", node)
                bounds.append(self.temp(self.as_int(kind, codes) if kind != BOTTOM else "0"))
            if len(bounds) == 3:
                self.fail(f"{bounds[2]} == 0")
            self.counter += 1
            step = f"t{self.counter}"
            self.emit(f"for {step} in range({', '.join(bounds)}):")
            self.depth += 1
            self.assign(name, INT, [step])
            self.body(node.body)
            self.depth -= 1
            return
        kind, codes = self.expr(iterable)
        if kind == BOTTOM:
            kind = ListT()
        if not isinstance(kind, ListT):
            self.unsupported(f"a loop over {_describe(kind)}", node)
        # By position, reading the length each time, as Python's list iterator does.
        held, position = self.temp(codes[0]), self.temp("0")
        self.emit("while True:")
        self.depth += 1
        self.emit(f"if {position} >= I[{held}]:")
        self.emit("    break")
        elem = kind.elem
        self.check_item(elem, node)
        item = [self.temp(code) for code in self.slot(elem, f"I[{held} + 2] + {position}")]
        self.emit(f"{position} += 1")
        self.assign(name, elem, item)
        self.body(node.body)
        self.depth -= 1

    def do_Assign(self, node):
        value = self.expr(node.value)
        if len(node.targets) > 1:
            value = value[0], [self.temp(code) for code in value[1]]
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
            if not isinstance(base[0], ListT) or isinstance(target.slice, ast.Slice):
                self.unsupported("this item assignment", node)
            where = self.index(base, self.expr(target.slice), node)
            self.set_item(base[0], where, value, node)
        else:
            self.unsupported("this assignment target", node)

    def set_attribute(self, target, base_kind, base_codes, value):
        fields, offset = self.field(base_kind, target, target.attr)
        if fields is None:
            if base_kind == NONE:
                self.fail("True")
            return
        base = self.handle(base_kind, base_codes, target)
        kind, codes = value
        joined = self.program.widen(fields, target.attr, kind)
        if not (self.me is not None and isinstance(target.value, ast.Name) and target.value.id == self.me):
            self.program.written.add((base_kind.cls, target.attr))
        # The layout may have moved if this store widened an attribute.
        offset = self.program.layout(base_kind.cls)[0][target.attr]
        self.store(joined, f"{base} + {offset}", self.coerce(kind, codes, joined))

    def set_item(self, list_kind, where, value, node):
        kind, codes = value
        cell = _find(list_kind.cell)
        self.program.widen_cell(cell, kind)
        cell.mutated = True
        self.check_item(cell.elem, node)
        self.store(cell.elem, where, self.coerce(kind, codes, cell.elem))

    def do_AugAssign(self, node):
        target, op = node.target, type(node.op)
        if isinstance(target, ast.Name):
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
            found = fields[target.attr]
            current = found, [self.temp(code) for code in self.slot(found, f"{base} + {offset}")]
            result = self.binop(op, current, self.expr(node.value), node)
            self.set_attribute(target, ObjT(base_kind.cls), [base], result)
        elif isinstance(target, ast.Subscript) and not isinstance(target.slice, ast.Slice):
            base = self.expr(target.value)
            if base[0] == BOTTOM:
                self.expr(node.value)
                return
            if not isinstance(base[0], ListT):
                self.unsupported("this in-place operator", node)
            where = self.index(base, self.expr(target.slice), node)
            self.check_item(base[0].elem, node)
            current = base[0].elem, [self.temp(code) for code in self.slot(base[0].elem, where)]
            self.set_item(base[0], where, self.binop(op, current, self.expr(node.value), node), node)
        else:
            self.unsupported("this in-place operator", node)

    # The function

    def run(self):
        info, program = self.info, self.program
        if info.falls_through:
            program.widen(info.__dict__, "ret", NONE)
        statements = info.node.body
        self.body(statements)
        closing = self.result_codes()
        self.emit("return " + ", ".join(closing) if closing else "return")
        info.math_used = self.math_used
        params = [code for name in info.params for code in self.var_codes(name, info.vars.get(name, BOTTOM))]
        header = f"@njit(error_model=\"numpy\")\ndef {info.name}(F, I, top, st{''.join(', ' + p for p in params)}):"
        return header + "\n" + "\n".join(self.lines) + "\n"


_C_CODES = {FLOAT: 0, MIXED: 1, INT: 2, BOOL: 3, NONE: 4}


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
        self.native = _native is not None and F is not None
        self.F, self.I = F, I
        self.float_at, self.float_values, self.int_at, self.int_values = [], [], [], []
        self.top = 0
        # id(value) -> handle; and every object and list loaded, kept alive, in order.
        self.handles, self.objects, self.lists = {}, [], []

    def put(self, kind, where, value):
        if type(kind) is not str:
            # An object or list: it adds its own slots first, so find the value
            # before recording where it goes.
            raw = self.instance(kind.cls, value) if type(kind) is ObjT and value is not None else self.scalar(kind, value)
            self.int_at.append(where)
            self.int_values.append(raw)
        elif kind == FLOAT:
            if type(value) is not float:
                raise _Mismatch
            self.float_at.append(where)
            self.float_values.append(value)
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
        if self.native and type(kind) in (ObjT, ListT):
            try:
                handle, self.top = _native.load(self.program.c_kind(kind), value, self.F, self.I, self.top,
                                                self.handles, self.objects, self.lists)
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
            return self.instance(kind.cls, value)
        if isinstance(kind, ListT):
            return self.list(kind, value)
        raise _Mismatch

    def instance(self, cls, value):
        known = self.handles.get(id(value))
        if known is not None:
            return known
        if type(value) is not cls:
            raise _Mismatch
        plan = self.program.load_plan(cls)
        names, size, steps = plan
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

    def list(self, kind, value):
        known = self.handles.get(id(value))
        if known is not None:
            return known
        if type(value) is not list:
            raise _Mismatch
        elem, count = kind.elem, len(value)
        if count and (elem in (BOTTOM, MIXED) or isinstance(elem, TupT)):
            raise _Mismatch
        handle = self.handles[id(value)] = self.top
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
        if kind == BOTTOM or isinstance(kind, TupT):
            raise _Mismatch
        return [self.scalar(kind, value)]


class _Unloader:
    """Turns heap values back into Python values after a call."""

    def __init__(self, program, loader, F, I):
        self.program, self.F, self.I = program, F, I
        self.made = {handle: value for value, handle, _ in loader.objects}
        self.made.update({handle: value for value, handle, _ in loader.lists})

    def value(self, kind, where):
        if kind == FLOAT:
            return self.F.item(where)
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
        if isinstance(kind, ObjT):
            cls = kind.cls
            made = self.made[handle] = cls.__new__(cls)
            offsets = self.program.layout(cls)[0]
            for name, field in self.program.fields[cls].items():
                setattr(made, name, self.value(field, handle + offsets[name]))
            return made
        made = self.made[handle] = []
        made.extend(self.items(kind, handle))
        return made

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
        if kind == FLOAT:
            return float(codes[0])
        if kind == MIXED:
            return int(codes[0]) if codes[1] else float(codes[0])
        if kind == INT:
            return int(codes[0])
        if kind == BOOL:
            return bool(codes[0])
        if isinstance(kind, TupT):
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
        if loader.native:
            plans = program.c_write_plans()
            if plans:
                _native.write_back(loader.objects, plans, self.F, self.I, loader.handles, self.value)
        for value, handle, cls in ([] if loader.native else loader.objects):
            names = by_class.get(cls)
            if names is None:
                offsets = program.layout(cls)[0]
                names = by_class[cls] = [(name, program.fields[cls][name], offsets[name])
                                         for name in program.fields[cls] if (cls, name) in program.written]
            for name, kind, offset in names:
                new, old = self.value(kind, handle + offset), getattr(value, name)
                if new is not old and not _unchanged(old, new):
                    setattr(value, name, new)
        for value, handle, kind in loader.lists:
            if not _find(kind.cell).mutated:
                continue
            new = self.items(kind, handle)
            if len(new) != len(value) or any(a is not b and not _unchanged(a, b) for a, b in zip(value, new)):
                value[:] = new


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
    if kind in (tuple, dict, set, str, bytes) or kind.__module__ == "builtins":
        raise Unsupported(f"an argument of type {kind.__name__}")
    fields = program.register(kind)
    made = seen[id(value)] = ObjT(kind)
    if hasattr(value, "__dict__") and vars(value).keys() != fields.keys():
        raise Unsupported(f"a '{kind.__name__}' object with attributes its __init__ does not set")
    for name in fields:
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
    return repr(([_describe(kind) for kind in kinds], classes))


class Region:
    """A compiled stand-in for ``original`` that falls back whenever it cannot be sure."""

    def __init__(self, fn):
        if not isinstance(fn, FunctionType):
            raise Unsupported("only plain Python functions can be lifted")
        self.original = fn
        self.programs, self.latest = {}, None
        self.compiled_calls = self.fallback_calls = 0
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
        try:
            candidate = _Program(self.original)
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
        try:
            for name, kind in zip(candidate.entry.params, kinds):
                candidate.widen(candidate.entry.vars, name, kind)
            candidate.compile()
        except Unsupported as exc:
            self.problem = str(exc)
            candidate = None
        self.programs[key] = candidate
        return candidate

    def load(self, program, args):
        entry = program.entry
        while True:
            F, I = self.arrays()[:2] if NATIVE else (None, None)
            loader = _Loader(program, F, I)
            try:
                passed = [code for name, value in zip(entry.params, args)
                          for code in loader.argument(entry.vars.get(name, BOTTOM), value)]
            except _Grow:
                self.slots *= 2
                if self.slots > MAX_SLOTS:
                    self.slots //= 2
                    raise _Mismatch from None
                continue
            return loader, passed

    def attempt(self, args):
        """(True, result) from compiled code, or (False, None)."""
        import numpy as np

        entry_params = self.original.__code__.co_argcount
        defaults = self.original.__defaults__ or ()
        if not 0 <= entry_params - len(args) <= len(defaults):
            return False, None
        if len(args) < entry_params:
            args = args + defaults[len(defaults) - (entry_params - len(args)):]
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
                program.broken, self.problem = True, f"{type(exc).__name__}: {str(exc)[:600]}"
                return False, None
            if st[0] == 2 and self.slots < MAX_SLOTS:
                # The heap filled up. Nothing outside it has changed: run again with more.
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
        value = unloader.result(kind, codes)
        unloader.write_back(loader)
        return True, value

    def __call__(self, *args, **kwargs):
        if not kwargs:
            try:
                ok, value = self.attempt(args)
            except RecursionError:
                ok = False
            if ok:
                self.compiled_calls += 1
                return value
        self.fallback_calls += 1
        return self.original(*args, **kwargs)


def lift_region(fn):
    """Compile ``fn`` and everything it reaches as one region. Compilation happens on
    the first call, when the argument types are known; a region that cannot be
    compiled runs as plain Python, and ``problem`` says why."""
    return Region(_unwrap(fn))
