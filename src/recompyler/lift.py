"""Lift a plain Python function into a compiled equivalent that keeps Python's results.

``lift(fn)`` reads the function's source, follows the helpers and module constants it
uses, and builds a Numba version. Every operation where 64-bit machine arithmetic could
disagree with Python (integer overflow, shifts, truncation, silent type unification)
is either checked at run time or rejected at compile time. When a check fires, or the
compiled code raises for any reason, the call is answered by the original function.

The supported subset is numeric code: numbers, tuples, lists and array.array values, loops,
branches, slices, top-level helper functions and numeric module constants. List and
array.array arguments travel as NumPy copies and are written back after a successful call.

Known limits: comparing an int above 2**53 with a float follows machine rules, and
transcendental ``math`` functions are used only if a self-test shows they match here.
"""

import array
import ast
import builtins
import collections
import contextlib
import copy
import functools
import hashlib
import importlib.util
import inspect
import itertools
import json
import math
import operator
import os
from pathlib import Path
import platform
import struct
import sys
import textwrap
from time import perf_counter
from types import FunctionType

INT_MIN, INT_MAX = -(2**63), 2**63 - 1
MAX_SEQUENCE = 32
MAX_SHAPES = 16
BUILTINS = {name: getattr(builtins, name)
            for name in ("len", "range", "enumerate", "int", "float", "abs", "min", "max", "list")}
LIST_METHODS = ("append", "insert", "pop")
# Lists and array.array arguments travel as NumPy copies up to this length.
MAX_ARRAY = 1 << 24
# A lifted function keeps the converted copies of up to this many list arguments,
# reused while a list still holds the same objects. Shorter lists are cheap to convert.
LIST_CACHE_ENTRIES = 8
LIST_CACHE_MINIMUM = 64
# Write back element by element when at most this share of a list changed.
SPARSE_WRITE_BACK = 0.25
# Below this length, writing a whole list back is cheaper than finding what changed.
DIFF_MINIMUM = 512
# array.array type codes that hold floats or signed integers, and the scalar they read as.
ARRAY_CODES = {"d": "f", "q": "i", "l": "i", "i": "i", "h": "i", "b": "i"}
BINARY = {ast.Add: "_rc_add", ast.Sub: "_rc_sub", ast.Mult: "_rc_mul", ast.Div: "_rc_div",
          ast.FloorDiv: "_rc_floordiv", ast.Mod: "_rc_mod", ast.LShift: "_rc_lshift", ast.RShift: "_rc_rshift"}
# In-place operators rebind a name. For a list that would differ from Python's in-place
# update, so these variants accept numbers only.
IN_PLACE = {**BINARY, ast.Add: "_rc_nadd", ast.Mult: "_rc_nmul"}
BITWISE = (ast.BitAnd, ast.BitOr, ast.BitXor)
UNARY = {ast.USub: "_rc_neg", ast.UAdd: "_rc_pos", ast.Invert: "_rc_inv"}
COMPARE = (ast.Eq, ast.NotEq, ast.Lt, ast.LtE, ast.Gt, ast.GtE)
# One-argument math functions computed by the C library. Compiled code calls the same
# library, but each is used only after a self-test shows it matches on this machine.
TRANSCENDENTAL = ("sin", "cos", "tan", "asin", "acos", "atan", "sinh", "cosh", "tanh",
                  "exp", "expm1", "log", "log10", "log1p")
MATH = {name: getattr(math, name) for name in ("sqrt", "fabs", *TRANSCENDENTAL)}
MATH_CONSTANTS = ("pi", "e", "tau", "inf")
STATUS = "_rc_st"
BACKENDS = ("cpu", "parallel", "gpu")
# Below this many rows a batch finishes before another backend could start up.
AUTO_MINIMUM = 256
SCALARS = {"f": float, "i": int, "b": bool}
SCALARS_BY_TYPE = {value: key for key, value in SCALARS.items()}
DTYPES = {"f": "float64", "i": "int64", "b": "bool"}


def _cache_dir():
    """Where compiled code is kept between runs, or None if caching is off.

    ``RECOMPYLER_CACHE`` names the directory; "off" turns the cache off.
    """
    chosen = os.environ.get("RECOMPYLER_CACHE")
    if chosen == "off":
        return None
    if chosen:
        folder = Path(chosen)
    elif os.name == "nt" and os.environ.get("LOCALAPPDATA"):
        folder = Path(os.environ["LOCALAPPDATA"]) / "recompyler" / "cache"
    else:
        folder = Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache")) / "recompyler"
    try:
        folder.mkdir(parents=True, exist_ok=True)
    except OSError:
        return None
    return folder


@functools.cache
def _runtime_key():
    """Changes whenever the lifter, Numba, NumPy, Python or the machine type changes."""
    import numba
    import numpy

    digest = hashlib.sha256(Path(__file__).read_bytes())
    digest.update(f"{numba.__version__}|{numpy.__version__}|{sys.version}|{platform.machine()}".encode())
    return digest.hexdigest()


def _stable(value):
    """A text form of a constant that tells apart every value Python would."""
    if type(value) is float:
        return value.hex()
    if type(value) is tuple:
        return "(" + ",".join(map(_stable, value)) + ")"
    return f"{type(value).__name__}:{value!r}"


def _write_once(path, text):
    """Write ``text`` to ``path`` unless it is there, never leaving a partial file."""
    if path.exists():
        return
    partial = path.with_name(f"{path.name}.{os.getpid()}.tmp")
    partial.write_text(text, encoding="utf-8")
    os.replace(partial, path)


class Unsupported(Exception):
    """The function uses something outside the subset that can be lifted safely."""


class _Reject(Exception):
    pass


class _Fallback(Exception):
    """Raised by compiled code in place of the function's own exception."""


def same(a, b):
    """Exact equality: same types all the way down and bit-identical floats."""
    if type(a) is not type(b):
        return False
    if type(a) is float:
        return struct.pack("d", a) == struct.pack("d", b)
    if type(a) in (tuple, list):
        return len(a) == len(b) and all(map(same, a, b))
    if type(a) is array.array:
        return a.typecode == b.typecode and a.tobytes() == b.tobytes()
    if type(a).__module__ != "builtins":
        fields_a, fields_b = _object_fields(a), _object_fields(b)
        if fields_a is not None and fields_b is not None:
            return fields_a.keys() == fields_b.keys() and all(same(fields_a[k], fields_b[k]) for k in fields_a)
    return a == b


def _constant_ok(value):
    kind = type(value)
    if kind is tuple:
        return bool(value) and all(map(_constant_ok, value))
    return kind in (bool, float) or (kind is int and INT_MIN <= value <= INT_MAX)


# Record type (a generated namedtuple class) -> _RecordInfo, read by the overloads.
_RECORD_TYPES = {}
# Columns type (a generated namedtuple class) -> the _RecordInfo of its rows.
_COLUMN_TYPES = {}
_RECORD_TOKENS = {}
# Class token -> the number types compiled code stored into a list of new objects,
# when they differ from the ones its columns were made with. See Lifted._prepare.
_RETYPE = {}
# Name stem of a build's record classes -> the class tuples that share it in this
# process, in the order they were first built. See Lifted._name_records.
_ISSUED = {}
_RECORD_MODULE = __name__.rpartition(".")[0] + "._record_types"
_ATTRIBUTE_HOOKS = ("__getattribute__", "__getattr__", "__setattr__", "__delattr__")


class _NeedClass(Exception):
    """Packing met an instance of a class not registered yet."""

    def __init__(self, cls):
        super().__init__(cls.__qualname__)
        self.cls = cls


def _record_problem(cls):
    """Why instances of ``cls`` cannot travel as records, or None."""
    # Only classes written in Python (heap types); C types such as re.Pattern may not
    # allow new instances or attribute assignment.
    if (not isinstance(cls, type) or type(cls) is not type or cls.__module__ == "builtins"
            or not cls.__flags__ & (1 << 9)):
        return f"'{getattr(cls, '__name__', cls)}' is not a plain class"
    for klass in cls.__mro__[:-1]:
        if klass.__module__ == "builtins":
            return f"'{cls.__name__}' subclasses a built-in type"
        if any(hook in vars(klass) for hook in _ATTRIBUTE_HOOKS):
            return f"'{cls.__name__}' customises attribute access"
        if "__bool__" in vars(klass) or "__len__" in vars(klass):
            # A record's truth would be a tuple's.
            return f"'{cls.__name__}' defines its own truth or length"
    return None


def _init_fields(init):
    """Attributes ``__init__`` assigns on its first parameter, or None without source."""
    try:
        node = ast.parse(textwrap.dedent(inspect.getsource(init))).body[0]
    except (OSError, TypeError, SyntaxError):
        return None
    if not isinstance(node, ast.FunctionDef) or not node.args.args:
        return None
    me = node.args.args[0].arg
    return {item.attr for item in ast.walk(node) if isinstance(item, ast.Attribute) and isinstance(item.ctx, ast.Store)
            and isinstance(item.value, ast.Name) and item.value.id == me}


def _record_fields(cls):
    """Instance attribute names of ``cls`` in a fixed order, or None if unknown."""
    if all("__slots__" in vars(klass) for klass in cls.__mro__[:-1]):
        names = set()
        for klass in cls.__mro__[:-1]:
            slots = vars(klass)["__slots__"]
            names.update([slots] if isinstance(slots, str) else slots)
        return tuple(sorted(names - {"__dict__", "__weakref__"}))
    init = getattr(cls, "__init__")
    if init is object.__init__:
        return ()
    if not isinstance(init, FunctionType):
        return None
    names = _init_fields(init)
    return None if names is None else tuple(sorted(names))


def _object_fields(value):
    """The attribute values of a plain object, in its record order, or None."""
    cls = type(value)
    if _record_problem(cls) is not None:
        return None
    fields = _record_fields(cls)
    if fields is None:
        return None
    if hasattr(value, "__dict__") and set(vars(value)) != set(fields):
        return None
    try:
        return {name: getattr(value, name) for name in fields}
    except AttributeError:
        return None


class _RecordInfo:
    """How instances of one class travel to compiled code: a namedtuple of the
    object's position in the arguments (-1 for an object made in compiled code)
    followed by its attributes. An attribute that compiled code assigns sits in a
    one-item array, so the store reaches the object."""

    def __init__(self, cls, fields, token):
        self.cls, self.fields, self.token = cls, fields, token
        # Set by ``name_types`` once a build knows its generated code.
        self.nt = self.columns = None
        self.boxed = frozenset()
        self.mangled, self.methods, self.problems = {}, {}, {}
        # The number type of each attribute in a list of objects made by compiled
        # code: floats until a build shows otherwise. ``tried`` holds what failed.
        self.kinds, self.tried = ("f",) * len(fields), set()


    def name_types(self, stem):
        """Make, or find, the two namedtuple classes this class travels as.

        The names are the same in every process that builds the same code, and the
        classes live in an importable module, so Numba's disk cache can store types
        that mention them. ``nt`` is one object. ``columns`` is a list of them: their
        positions in the arguments, then one array per attribute; indexing it makes a
        record of one row.
        """
        module = importlib.import_module(_RECORD_MODULE)
        made = []
        for prefix, first in (("_rc", "id"), ("_rcc", "ids")):
            name = f"{prefix}_{self.cls.__name__}_{stem}"
            if not name.isidentifier():
                name = f"{prefix}_{stem}"
            kind = getattr(module, name, None)
            if kind is None:
                kind = collections.namedtuple(name, [first, *self.fields], rename=True, module=_RECORD_MODULE)
                setattr(module, name, kind)
            made.append(kind)
        self.nt, self.columns = made
        _RECORD_TYPES[self.nt] = _COLUMN_TYPES[self.columns] = self


class _Records:
    """The classes one lifted function has met, kept across rebuilds."""

    def __init__(self):
        self.infos = {}

    def register(self, cls):
        if cls in self.infos:
            return self.infos[cls]
        problem = _record_problem(cls)
        if problem:
            raise Unsupported(problem)
        fields = _record_fields(cls)
        if fields is None:
            raise Unsupported(f"the attributes of '{cls.__name__}' are not known")
        info = self.infos[cls] = _RecordInfo(cls, fields, f"{cls.__qualname__}#{id(self)}#{len(self.infos)}")
        _RECORD_TOKENS[info.token] = info
        return info


@functools.cache
def _list_items_offset():
    """Byte offset of a list's item-pointer field, or None if this interpreter's
    layout isn't the one expected. Checked once on a sample list before use."""
    import ctypes

    if sys.implementation.name != "cpython" or not getattr(sys, "_is_gil_enabled", lambda: True)():
        return None
    # PyListObject: the PyObject header, ob_size, ob_item, allocated.
    word = ctypes.sizeof(ctypes.c_void_p)
    offset = object.__basicsize__ + word
    if list.__basicsize__ != offset + 2 * word or ctypes.sizeof(ctypes.c_ssize_t) != word:
        return None
    sample = [object() for _ in range(5)]
    if ctypes.c_ssize_t.from_address(id(sample) + offset - word).value != len(sample):
        return None
    items = ctypes.c_void_p.from_address(id(sample) + offset).value
    if not items or list((ctypes.c_ssize_t * len(sample)).from_address(items)) != list(map(id, sample)):
        return None
    return offset


def _list_pointers(value):
    """The addresses of a list's items as bytes: equal bytes mean the same objects."""
    return _read_pointers(value)


def _make_pointer_reader():
    import ctypes

    offset, word = _list_items_offset(), ctypes.sizeof(ctypes.c_void_p)
    address_at, string_at = ctypes.c_void_p.from_address, ctypes.string_at

    def read(value):
        return string_at(address_at(id(value) + offset).value, len(value) * word)

    return read


def _read_pointers(value):
    # Replaced by the bound reader on first use, which saves the ctypes lookups on every call.
    global _read_pointers
    _read_pointers = _make_pointer_reader()
    return _read_pointers(value)


class _ListCache:
    """Converted copies of list arguments, reused across calls while a list holds
    the same item objects.

    Each entry keeps the list and a shallow copy of its items alive, so an id or an
    item address can't be reused by a different object while the entry exists.
    Item objects are ints, floats or bools, which can't change, so the same
    addresses mean the same values.
    """

    def __init__(self):
        self.entries = {}
        # Ids of lists met once. A list is cached the second time it's met, so a
        # function always given new lists doesn't pay to cache them.
        self.seen = {}
        self.enabled = _list_items_offset() is not None

    def worth_keeping(self, value):
        if id(value) in self.seen:
            return True
        if len(self.seen) >= 4 * LIST_CACHE_ENTRIES:
            del self.seen[next(iter(self.seen))]
        self.seen[id(value)] = None
        return False

    def get(self, value):
        entry = self.entries.get(id(value))
        if entry is None or entry[0] is not value or len(value) != len(entry[1]):
            return None
        if _list_pointers(value) != entry[2]:
            del self.entries[id(value)]
            return None
        return entry[3], entry[4]

    def put(self, value, copied, shape):
        self.entries.pop(id(value), None)
        while len(self.entries) >= LIST_CACHE_ENTRIES:
            del self.entries[next(iter(self.entries))]
        self.entries[id(value)] = [value, list(value), _list_pointers(value), copied, shape]

    def written(self, value, indices=None):
        """Record a list's new item objects after its copy was written back into it,
        all of them or those at ``indices``. The copy and the list agree again."""
        entry = self.entries.get(id(value))
        if entry is None or entry[0] is not value:
            return
        if indices is None:
            entry[1] = list(value)
        else:
            items = entry[1]
            for index in indices:
                items[index] = value[index]
        entry[2] = _list_pointers(value)

    def drop(self, value):
        self.entries.pop(id(value), None)


class _Boundary:
    """Lists and array.array arguments passed to compiled code as NumPy copies.

    Compiled code changes only the copies. After a call that succeeded the elements
    that changed are written back into the original objects; after a fallback the
    originals are untouched, so the Python function starts from the same state. An
    object that appears more than once in the arguments gets one shared copy, so
    aliasing works as it does in Python.

    With a ``cache``, a list's copy can be reused from an earlier call. Any copy the
    compiled code may have changed without the change reaching the list must be
    dropped with ``discard``.
    """

    def __init__(self, records=None, cache=None, track=False):
        self.copies = {}
        # Objects passed as records, by position; and the assigned attributes to copy back.
        self.records, self.objects, self.instances, self.boxes, self.packing = records, [], {}, [], set()
        # Lists of objects passed as columns: (objects, written columns with their
        # contents before the call), and the ids of every object in a column.
        self.columns, self.in_columns = [], set()
        # With ``track``, each list copy's contents before the call, to find what changed.
        self.cache, self.track, self.before = cache if cache is not None and cache.enabled else None, track, {}

    def instance(self, value):
        """Return (record, shape) for an object of a plain class."""
        import numpy as np

        known = self.instances.get(id(value))
        if known is not None:
            return known
        if id(value) in self.in_columns:
            # Already a row of a column list: a separate record would not see its writes.
            raise _Reject
        cls = type(value)
        info = self.records.infos.get(cls)
        if info is None:
            if _record_problem(cls) is not None:
                raise _Reject
            raise _NeedClass(cls)
        if id(value) in self.packing or (hasattr(value, "__dict__") and set(vars(value)) != set(info.fields)):
            raise _Reject
        self.packing.add(id(value))
        items, shapes = [], []
        for name in info.fields:
            try:
                field = getattr(value, name)
            except AttributeError:
                raise _Reject from None
            if name in info.boxed:
                letter = SCALARS_BY_TYPE.get(type(field))
                if letter is None or (letter == "i" and not INT_MIN <= field <= INT_MAX):
                    raise _Reject
                box = np.array([field], dtype=DTYPES[letter])
                self.boxes.append((value, name, box))
                items.append(box)
                shapes.append(("B", letter))
            else:
                packed, shape = _pack(field, self)
                items.append(packed)
                shapes.append(shape)
        self.packing.discard(id(value))
        record = info.nt(len(self.objects), *items)
        self.objects.append(value)
        self.instances[id(value)] = result = record, ("O", info.token, *shapes)
        return result

    def column_list(self, value):
        """Return (columns, shape) for a list of objects of one plain class whose
        attributes are all numbers of one type each, or None to pack it another way.

        Each object must appear once, and nowhere else in the arguments: compiled code
        reads and writes its row, so any other copy of it would not see the writes.
        """
        import numpy as np

        cls = type(value[0])
        if cls.__module__ == "builtins" or any(type(item) is not cls for item in value):
            return None
        info = self.records.infos.get(cls)
        if info is None:
            if _record_problem(cls) is not None:
                return None
            raise _NeedClass(cls)
        ids = set(map(id, value))
        if len(ids) != len(value) or not ids.isdisjoint(self.instances) or not ids.isdisjoint(self.in_columns):
            raise _Reject
        # Read attributes straight from each object's __dict__, which runs at C speed.
        # Every dict holding exactly the record's fields, and every field present, means
        # its keys are the fields: the same test ``instance`` makes with vars().
        try:
            sources = list(map(operator.attrgetter("__dict__"), value))
        except AttributeError:
            sources = None
        if sources is not None and set(map(len, sources)) != {len(info.fields)}:
            return None
        arrays, letters = [], []
        for name in info.fields:
            try:
                column = (list(map(operator.itemgetter(name), sources)) if sources is not None
                          else list(map(operator.attrgetter(name), value)))
            except (KeyError, AttributeError):
                return None
            kinds = set(map(type, column))
            letter = SCALARS_BY_TYPE.get(kinds.pop()) if len(kinds) == 1 else None
            if letter is None:
                return None
            try:
                arrays.append(np.array(column, dtype=DTYPES[letter]))
            except OverflowError:
                return None
            letters.append(letter)
        start = len(self.objects)
        self.objects.extend(value)
        self.in_columns.update(ids)
        written = [(name, array, array.copy()) for name, array in zip(info.fields, arrays) if name in info.boxed]
        if written:
            self.columns.append((list(value), written))
        # int32 ids: see _install_column_rows.
        packed = info.columns(np.arange(start, start + len(value), dtype=np.int32), *arrays)
        return packed, ("C", info.token, *letters)

    def rebuild(self, value, seen=None):
        """Turn records in a compiled result back into objects.

        An object made by compiled code can appear in a result more than once, and
        must come back as one object. One with an assigned attribute is known by where
        that attribute is stored. Others carry nothing to tell them apart, so two of
        one class with equal attributes are rejected: they might be one object.
        """
        if seen is None:
            seen = {}
        if type(value) in _COLUMN_TYPES:
            info = _COLUMN_TYPES[type(value)]
            ids = value[0]
            if len(ids) and int(ids.max()) >= 0:
                # Objects that came in as a list: Python may be returning that list.
                raise _Reject
            columns = [column.tolist() for column in value[1:]]
            where = None
            for name, column in zip(info.fields, value[1:]):
                if name in info.boxed:
                    where = column.__array_interface__["data"][0], column.strides[0]
                    break
            return [self.new_object(info, row, None if where is None else where[0] + index * where[1], seen)
                    for index, row in enumerate(zip(*columns))]
        info = _RECORD_TYPES.get(type(value))
        if info is not None:
            if value[0] >= 0:
                return self.objects[value[0]]
            fields, where = [], None
            for name, field in zip(info.fields, value[1:]):
                if name in info.boxed:
                    if where is None:
                        where = field.__array_interface__["data"][0]
                    field = field[0].item()
                else:
                    field = self.rebuild(field, seen)
                    if _holds_array(field):
                        raise _Reject
                fields.append(field)
            return self.new_object(info, fields, where, seen)
        if type(value) is tuple:
            return tuple(self.rebuild(item, seen) for item in value)
        if type(value) is list:
            return [self.rebuild(item, seen) for item in value]
        return value

    def new_object(self, info, fields, where, seen):
        """The Python object for one made by compiled code; ``where`` is the address
        of its first assigned attribute, or None if nothing is assigned."""
        if where is not None:
            key = info.token, where
            if key in seen:
                return seen[key]
        else:
            key = info.token, tuple(map(_identity, fields))
            if key in seen:
                raise _Reject
        made = seen[key] = info.cls.__new__(info.cls)
        for name, field in zip(info.fields, fields):
            setattr(made, name, field)
        return made

    def copy(self, value):
        """Return (array, shape) for a list or array.array that can travel as an array, else None."""
        known = self.copies.get(id(value))
        if known is not None:
            return known[1], known[2]
        # Imported only where needed: a cache hit uses no NumPy function.
        if type(value) is array.array:
            import numpy as np

            letter = ARRAY_CODES.get(value.typecode)
            if letter is None:
                return None
            source = np.frombuffer(value, dtype=f"{'f' if letter == 'f' else 'i'}{value.itemsize}") if value else ()
            copied = np.array(source, dtype=DTYPES[letter])
        else:
            if not value or len(value) > MAX_ARRAY:
                return None
            cached = None
            if self.cache is not None and len(value) >= LIST_CACHE_MINIMUM:
                cached = self.cache.get(value)
            if cached is not None:
                copied, shape = cached
            else:
                import numpy as np

                kinds = set(map(type, value))
                letter = SCALARS_BY_TYPE.get(kinds.pop()) if len(kinds) == 1 else None
                if letter is None:
                    return None
                try:
                    copied = np.array(value, dtype=DTYPES[letter])
                except OverflowError:
                    return None
                shape = "A", letter
                if (self.cache is not None and len(value) >= LIST_CACHE_MINIMUM
                        and self.cache.worth_keeping(value)):
                    self.cache.put(value, copied, shape)
            # Short lists are cheaper to write back whole than to compare.
            if self.track and len(value) >= DIFF_MINIMUM:
                self.before[id(value)] = copied.copy()
            self.copies[id(value)] = value, copied, shape
            return copied, shape
        shape = "A", letter
        self.copies[id(value)] = value, copied, shape
        return copied, shape

    def discard(self):
        """Forget cached copies this call used: compiled code may have changed them."""
        if self.cache is not None:
            for original, _, _ in self.copies.values():
                if type(original) is list:
                    self.cache.drop(original)

    def write_back(self):
        """Copy results into the original objects. False if one cannot hold them, as
        when an int too large for its array.array type code was stored."""
        import numpy as np

        views = []
        for original, copied, _ in self.copies.values():
            if not len(original):
                continue
            if type(original) is list:
                before = self.before.get(id(original))
                if before is None:
                    views.append((original, copied))
                    continue
                # Compare bit patterns, so -0.0 and NaN payloads count as written.
                bits = f"u{copied.itemsize}"
                changed = np.flatnonzero(copied.view(bits) != before.view(bits))
                if not len(changed):
                    continue
                if len(changed) <= SPARSE_WRITE_BACK * len(copied):
                    views.append((original, (changed, copied[changed])))
                else:
                    views.append((original, copied))
                continue
            view = np.frombuffer(original, dtype=f"{'f' if copied.dtype.kind == 'f' else 'i'}{original.itemsize}")
            if view.dtype != copied.dtype and len(copied):
                limits = np.iinfo(view.dtype)
                if copied.min() < limits.min or copied.max() > limits.max:
                    return False
            views.append((view, copied))
        for target, copied in views:
            indices = None
            if type(copied) is tuple:
                indices = copied[0].tolist()
                for index, item in zip(indices, copied[1].tolist()):
                    target[index] = item
            else:
                target[:] = copied.tolist() if type(target) is list else copied
            if self.cache is not None and type(target) is list:
                self.cache.written(target, indices)
        for owner, name, box in self.boxes:
            setattr(owner, name, box[0].item())
        for objects, written in self.columns:
            for name, array, before in written:
                bits = f"u{array.itemsize}"
                changed = np.flatnonzero(array.view(bits) != before.view(bits))
                for index, item in zip(changed.tolist(), array[changed].tolist()):
                    setattr(objects[index], name, item)
        return True


# The boundary for calls whose arguments are all plain numbers: nothing to copy,
# write back or discard. Shared, so it must never be packed into.
_NO_COPIES = _Boundary()


def _pack(value, boundary=None):
    kind = type(value)
    if value is None:
        return None, "N"
    if kind is float:
        return value, "f"
    if kind is bool:
        return value, "b"
    if kind is int:
        if INT_MIN <= value <= INT_MAX:
            return value, "i"
        raise _Reject
    if boundary is not None and (kind is list or kind is array.array):
        copied = boundary.copy(value)
        if copied is not None:
            return copied
    if boundary is not None and boundary.records is not None and kind not in (tuple, list) and (
            kind.__module__ != "builtins"):
        return boundary.instance(value)
    if boundary is not None and boundary.records is not None and kind is list and value:
        columns = boundary.column_list(value)
        if columns is not None:
            return columns
    if (kind is tuple or kind is list) and 0 < len(value) <= MAX_SEQUENCE:
        items = [_pack(item, boundary) for item in value]
        return tuple(item[0] for item in items), ("T" if kind is tuple else "L", *(item[1] for item in items))
    raise _Reject


def _identity(value):
    """A key that is equal for two attribute values only if nothing tells them apart."""
    kind = type(value)
    if kind is float:
        return value.hex()
    if kind in (int, bool, type(None)):
        return kind.__name__, value
    if kind in (tuple, list):
        return kind.__name__, tuple(map(_identity, value))
    return id(value)


def _holds_array(value):
    if type(value) in (tuple, list):
        return any(map(_holds_array, value))
    return type(value).__name__ == "ndarray"


def _columns(values, shape, out):
    """Split rows that all have ``shape`` into one flat column per scalar, or reject."""
    if type(shape) is str:
        if set(map(type, values)) != {SCALARS[shape]}:
            raise _Reject
        out.append((shape, values))
    else:
        if set(map(type, values)) != {tuple} or set(map(len, values)) != {len(shape) - 1}:
            raise _Reject
        for part, column in zip(shape[1:], zip(*values)):
            _columns(column, part, out)


def _has(shape_or_value, wanted):
    if type(shape_or_value) is tuple:
        return wanted is tuple or shape_or_value[:1] == (wanted,) or any(_has(item, wanted) for item in shape_or_value)
    if type(shape_or_value) is list:
        return any(_has(item, wanted) for item in shape_or_value)
    return False


_takes_list = functools.lru_cache(maxsize=4096)(lambda shape: _has(shape, "L"))
_PLAIN_RESULTS = frozenset((float, int, bool, type(None)))


def _suspect_result(shape, result):
    """True if a compiled result may be a list argument coming back as a tuple or
    array, which Python would have returned as the list itself."""
    if type(result) in _PLAIN_RESULTS:
        return False
    return (_takes_list(shape) and _has(result, tuple)) or _holds_array(result)


# Argument types -> the shape ``_pack`` gives a tuple of those scalars, or None.
_SCALAR_SHAPES = {}
_SCALAR_LETTERS = {float: "f", bool: "b", int: "i", type(None): "N"}


def _scalar_shape(kinds):
    shape = _SCALAR_SHAPES.get(kinds)
    if shape is None:
        letters = [_SCALAR_LETTERS.get(kind) for kind in kinds]
        shape = _SCALAR_SHAPES[kinds] = (
            ("T", *letters) if 0 < len(kinds) <= MAX_SEQUENCE and None not in letters else False)
    return shape


def _call(name, *args):
    # Checked operations and lifted helpers take the status flag as their first argument.
    if name.startswith("_rc"):
        args = (ast.Name(id=STATUS, ctx=ast.Load()), *args)
    return ast.Call(func=ast.Name(id=name, ctx=ast.Load()), args=list(args), keywords=[])


def _flagged():
    return ast.Subscript(value=ast.Name(id=STATUS, ctx=ast.Load()), slice=ast.Constant(value=0), ctx=ast.Load())


def _target_names(target):
    """Names bound by an assignment target: a name, or a tuple or list pattern of them."""
    if isinstance(target, ast.Name):
        return [target.id]
    if isinstance(target, (ast.Tuple, ast.List)):
        return [name for item in target.elts for name in _target_names(item)]
    raise Unsupported(f"assignment target at line {target.lineno}")


def _local_names(node):
    """Names bound in the function body, leaving out comprehension variables."""
    names = set()

    def walk(item):
        if isinstance(item, ast.ListComp):
            for generator in item.generators:
                walk(generator.iter)
            return
        if isinstance(item, ast.Name) and isinstance(item.ctx, ast.Store):
            names.add(item.id)
        for child in ast.iter_child_nodes(item):
            walk(child)

    for statement in node.body:
        walk(statement)
    return names


def _returns_none(node):
    return node.value is None or (isinstance(node.value, ast.Constant) and node.value.value is None)


def _infinite(test):
    return isinstance(test, ast.Constant) and type(test.value) in (bool, int) and bool(test.value)


def _check_flow(node, params, local_names):
    """Reject a local that may be read before assignment, and a function that returns
    a value on some paths and None on others.

    Python raises for the first. Compiled code would read an arbitrary value instead,
    so only definite assignments are accepted. Assignments inside a loop body are only
    counted after the loop when the loop is left through a ``break`` that follows them.
    A function that never returns a value is a procedure and returns None.
    """

    def read(expr, defined):
        if isinstance(expr, ast.ListComp):
            inner = set(defined)
            for generator in expr.generators:
                read(generator.iter, inner)
                inner.update(_target_names(generator.target))
                for test in generator.ifs:
                    read(test, inner)
            read(expr.elt, inner)
            return
        if isinstance(expr, ast.Name) and isinstance(expr.ctx, ast.Load):
            if expr.id in local_names and expr.id not in defined:
                raise Unsupported(f"'{expr.id}' may be read before assignment at line {expr.lineno}")
        for child in ast.iter_child_nodes(expr):
            read(child, defined)

    def merge(paths):
        paths = [path for path in paths if path is not None]
        return set.intersection(*paths) if paths else None

    def loop(statement, defined, inner):
        """Names defined after a loop, or None if it never finishes; plus the breaks
        in its else branch, which leave the enclosing loop."""
        out, breaks = block(statement.body, inner)
        normal, outer = None, []
        if not (isinstance(statement, ast.While) and _infinite(statement.test)):
            normal, outer = block(statement.orelse, set(defined)) if statement.orelse else (set(defined), [])
        return merge([normal, *breaks]), outer

    def block(statements, defined):
        """Returns (names defined if control falls through, or None; names defined at each break)."""
        breaks = []
        for statement in statements:
            if isinstance(statement, ast.Return):
                if statement.value is not None:
                    read(statement.value, defined)
                return None, breaks
            if isinstance(statement, ast.Raise):
                return None, breaks
            if isinstance(statement, ast.Break):
                return None, [*breaks, set(defined)]
            if isinstance(statement, ast.Continue):
                return None, breaks
            if isinstance(statement, ast.Assign):
                read(statement.value, defined)
                for target in statement.targets:
                    if isinstance(target, (ast.Subscript, ast.Attribute)):
                        read(target, defined)
                    else:
                        defined.update(_target_names(target))
            elif isinstance(statement, ast.AugAssign):
                read(statement.value, defined)
                read(ast.Name(id=statement.target.id, ctx=ast.Load(), lineno=statement.lineno)
                     if isinstance(statement.target, ast.Name) else statement.target, defined)
            elif isinstance(statement, ast.If):
                read(statement.test, defined)
                (yes, yes_breaks), (no, no_breaks) = block(statement.body, set(defined)), block(statement.orelse, set(defined))
                breaks += yes_breaks + no_breaks
                defined = merge([yes, no])
                if defined is None:
                    return None, breaks
            elif isinstance(statement, (ast.For, ast.While)):
                if isinstance(statement, ast.For):
                    read(statement.iter, defined)
                    inner = defined | set(_target_names(statement.target))
                else:
                    read(statement.test, defined)
                    inner = set(defined)
                after, outer = loop(statement, defined, inner)
                breaks += outer
                if after is None:
                    return None, breaks
                defined = after
            else:
                read(statement, defined)
        return defined, breaks

    returns = [item for item in ast.walk(node) if isinstance(item, ast.Return)]
    gives_value = any(not _returns_none(item) for item in returns)
    if gives_value and block(node.body, set(params))[0] is not None:
        raise Unsupported(f"'{node.name}' can finish without a return")
    if gives_value and any(map(_returns_none, returns)):
        raise Unsupported(f"'{node.name}' returns a value on some paths and None on others")
    block(node.body, set(params))


def _full_slice(node):
    return (isinstance(node, ast.Subscript) and isinstance(node.slice, ast.Slice)
            and node.slice.lower is None and node.slice.upper is None and node.slice.step is None)


def _list_creation(value, builtin):
    """True for ``list(range(...))``, ``[number] * n``, ``n * [number]`` and ``other[:]``."""
    if (isinstance(value, ast.Call) and isinstance(value.func, ast.Name) and value.func.id == "list"
            and builtin("list") and len(value.args) == 1 and not value.keywords):
        inner = value.args[0]
        return (isinstance(inner, ast.Call) and isinstance(inner.func, ast.Name) and inner.func.id == "range"
                and builtin("range") and 1 <= len(inner.args) <= 3 and not inner.keywords)
    if isinstance(value, ast.BinOp) and isinstance(value.op, ast.Mult):
        for repeated in (value.left, value.right):
            if (isinstance(repeated, ast.List) and len(repeated.elts) == 1 and isinstance(repeated.elts[0], ast.Constant)
                    and type(repeated.elts[0].value) in (int, float, bool)):
                return True
        return False
    return _full_slice(value) and isinstance(value.value, ast.Name)


def _fixed_lists(node, params, builtin):
    """Local lists whose length never changes, which can be NumPy arrays instead.

    A candidate is only ever created by ``list(range(...))``, ``[number] * n`` or a
    copy ``other[:]`` of another candidate. It is only indexed, measured with ``len``,
    iterated, rearranged in place by a slice assignment from itself, or rotated with
    ``insert(i, pop(j))``. It is never returned, passed on, aliased or used in a
    comprehension, where its type would show. Returns (names, method aliases).
    """
    parents = {child: parent for parent in ast.walk(node) for child in ast.iter_child_nodes(parent)}
    creations, stores, aliases = {}, {}, {}
    for item in ast.walk(node):
        if isinstance(item, ast.Name) and isinstance(item.ctx, ast.Store):
            stores[item.id] = stores.get(item.id, 0) + 1
        if isinstance(item, ast.Assign) and len(item.targets) == 1 and isinstance(item.targets[0], ast.Name):
            creations.setdefault(item.targets[0].id, []).append(item.value)
    for name, values in creations.items():
        value = values[0]
        if (len(values) == 1 and isinstance(value, ast.Attribute) and value.attr in ("insert", "pop")
                and isinstance(value.value, ast.Name)):
            aliases[name] = value.value.id, value.attr
    candidates = {name for name, values in creations.items()
                  if name not in params and len(values) == stores.get(name)
                  and all(_list_creation(value, builtin) for value in values)}

    def method(func):
        if isinstance(func, ast.Attribute) and isinstance(func.value, ast.Name):
            return func.value.id, func.attr
        if isinstance(func, ast.Name):
            return aliases.get(func.id)
        return None

    def rotation(call):
        """``v.insert(i, v.pop(j))`` as a statement, through aliases or not; returns v."""
        if not (isinstance(call, ast.Call) and isinstance(parents.get(call), ast.Expr) and len(call.args) == 2):
            return None
        inner = call.args[1]
        outer_method = method(call.func)
        if not (outer_method and outer_method[1] == "insert" and isinstance(inner, ast.Call) and len(inner.args) <= 1):
            return None
        inner_method = method(inner.func)
        if inner_method != (outer_method[0], "pop") or call.keywords or inner.keywords:
            return None
        return outer_method[0]

    def allowed(use):
        parent = parents.get(use)
        if isinstance(parent, ast.Subscript) and parent.value is use:
            if not isinstance(parent.slice, ast.Slice):
                return True
            holder = parents.get(parent)
            if not isinstance(holder, ast.Assign):
                return False
            if holder.value is parent and _full_slice(parent):
                return isinstance(holder.targets[0], ast.Name) and holder.targets[0].id in candidates
            other = holder.value if holder.targets[0] is parent else holder.targets[0]
            return (isinstance(other, ast.Subscript) and isinstance(other.slice, ast.Slice)
                    and isinstance(other.value, ast.Name) and other.value.id == use.id)
        if (isinstance(parent, ast.Call) and parent.args == [use] and isinstance(parent.func, ast.Name)
                and parent.func.id == "len" and builtin("len")):
            return True
        if isinstance(parent, ast.For) and parent.iter is use:
            return True
        if isinstance(parent, ast.Attribute) and parent.attr in ("insert", "pop"):
            holder = parents.get(parent)
            if isinstance(holder, ast.Assign):
                return holder.targets[0].id in aliases and all(
                    rotation(parents.get(load)) == use.id or rotation(parents.get(parents.get(load))) == use.id
                    for load in ast.walk(node) if isinstance(load, ast.Name) and isinstance(load.ctx, ast.Load)
                    and load.id == holder.targets[0].id)
            call = parents.get(parent)
            return rotation(call) == use.id or rotation(parents.get(call)) == use.id
        return False

    changed = True
    while changed:
        changed = False
        for item in ast.walk(node):
            if isinstance(item, ast.Name) and isinstance(item.ctx, ast.Load) and item.id in candidates:
                if not allowed(item):
                    candidates.discard(item.id)
                    changed = True
    return candidates, {alias: base for alias, (base, _) in aliases.items() if base in candidates}


def _none_list(value):
    """The length expression of ``[None] * n`` or ``n * [None]``, else None."""
    if isinstance(value, ast.BinOp) and isinstance(value.op, ast.Mult):
        for repeated, count in ((value.left, value.right), (value.right, value.left)):
            if (isinstance(repeated, ast.List) and len(repeated.elts) == 1
                    and isinstance(repeated.elts[0], ast.Constant) and repeated.elts[0].value is None):
                return count
    return None


def _object_fills(node, params):
    """Local lists made as ``[None] * n`` and filled with new objects straight away.

    The creation must be followed directly by ``for i in range(n):`` whose body stores
    ``name[i] = Class(...)`` on every pass and uses the list for nothing else, so
    every item is a new object before anything reads the list. Returns
    {name: (creation statement, the store statements)}.
    """
    stores = {}
    for item in ast.walk(node):
        if isinstance(item, ast.Name) and isinstance(item.ctx, ast.Store):
            stores[item.id] = stores.get(item.id, 0) + 1
    found = {}
    for holder in ast.walk(node):
        for field in ("body", "orelse"):
            statements = getattr(holder, field, None)
            if not isinstance(statements, list):
                continue
            for creation, loop in zip(statements, statements[1:]):
                if not (isinstance(creation, ast.Assign) and len(creation.targets) == 1
                        and isinstance(creation.targets[0], ast.Name) and isinstance(loop, ast.For)):
                    continue
                name, count = creation.targets[0].id, _none_list(creation.value)
                if count is None or name in params or stores.get(name) != 1 or name in found:
                    continue
                bound = loop.iter
                if not (isinstance(loop.target, ast.Name) and not loop.orelse and isinstance(bound, ast.Call)
                        and isinstance(bound.func, ast.Name) and bound.func.id == "range" and len(bound.args) == 1
                        and not bound.keywords and ast.dump(bound.args[0]) == ast.dump(count)
                        and (isinstance(count, ast.Name) or (isinstance(count, ast.Constant)
                                                              and type(count.value) is int))):
                    continue
                index = loop.target.id
                inside = [item for statement in loop.body for item in ast.walk(statement)]
                if any(isinstance(item, (ast.Break, ast.Continue, ast.Return, ast.Raise)) for item in inside):
                    continue
                fixed = {index, name} | ({count.id} if isinstance(count, ast.Name) else set())
                if any(isinstance(item, ast.Name) and isinstance(item.ctx, ast.Store) and item.id in fixed
                       for item in inside):
                    continue
                fills = [statement for statement in loop.body
                         if isinstance(statement, ast.Assign) and len(statement.targets) == 1
                         and isinstance(statement.targets[0], ast.Subscript)
                         and isinstance(statement.targets[0].value, ast.Name)
                         and statement.targets[0].value.id == name
                         and isinstance(statement.targets[0].slice, ast.Name)
                         and statement.targets[0].slice.id == index
                         and isinstance(statement.value, ast.Call) and isinstance(statement.value.func, ast.Name)]
                uses = sum(isinstance(item, ast.Name) and item.id == name for item in inside)
                if fills and uses == len(fills):
                    found[name] = creation, fills
    return found


class _Rewriter:
    """Copy one function body into the checked subset, raising on anything else."""

    def __init__(self, unit, function, local_names, node, params):
        self.unit, self.namespace, self.locals = unit, function.__globals__, local_names
        self.builtins = function.__builtins__
        self.renames = []
        # Locals bound once to a list method, such as ``push = values.append``.
        self.methods = {}
        self.params = set(params)
        self.node = node
        self.stores = {}
        for item in ast.walk(node):
            if isinstance(item, ast.Name) and isinstance(item.ctx, ast.Store):
                self.stores[item.id] = self.stores.get(item.id, 0) + 1
        self.promoted = {name for name in unit.promote.get(id(function), ()) if self.promotable(node, name)}

        def builtin(name):
            return name not in local_names and name not in self.namespace and self.builtins.get(name) is BUILTINS[name]

        self.arrays, self.array_aliases = _fixed_lists(node, params, builtin) if unit.local_arrays else (set(), {})
        # Lists made as ``[None] * n`` and filled with new objects of one class.
        self.fills, self.fill_class = _object_fills(node, self.params), {}
        for name in ("list", "range", "len"):
            if builtin(name):
                unit.builtin_guards[id(self.namespace), id(self.builtins), name] = self.namespace, self.builtins

    def promotable(self, node, name):
        """True if ``name`` starts as one small int literal and only changes by += -= *= /=.

        Python keeps it an int until the first update, and a float after an update
        with a float. The compiled version is a float from the start, plus a flag
        that says whether Python would still hold the int. Reading it while the flag
        is set, or updating it with something other than a float, falls back.
        """
        if name in self.params:
            return False
        starts = 0
        for item in ast.walk(node):
            if isinstance(item, ast.Assign) and any(isinstance(t, ast.Name) and t.id == name for t in item.targets):
                value = item.value
                if (len(item.targets) != 1 or not isinstance(value, ast.Constant) or type(value.value) is not int
                        or abs(value.value) > 2**53):
                    return False
                starts += 1
            elif isinstance(item, ast.AugAssign) and isinstance(item.target, ast.Name) and item.target.id == name:
                if not isinstance(item.op, (ast.Add, ast.Sub, ast.Mult, ast.Div)):
                    return False
        return starts >= 1 and starts + sum(
            isinstance(item, ast.AugAssign) and isinstance(item.target, ast.Name) and item.target.id == name
            for item in ast.walk(node)) == self.stores.get(name, 0)

    def pending(self, name, ctx):
        return ast.Name(id=f"_rcp_{name}", ctx=ctx)

    def visit(self, node):
        method = getattr(self, "visit_" + type(node).__name__, None)
        if method is None:
            raise Unsupported(f"{type(node).__name__} at line {getattr(node, 'lineno', '?')}")
        result = method(node)
        # A statement can become several.
        for item in result if isinstance(result, list) else [result]:
            ast.copy_location(item, node)
        return result

    def body(self, statements):
        out = []
        for statement in statements:
            result = self.visit(statement)
            out.extend(result if isinstance(result, list) else [result])
        return out

    def local(self, name):
        for mapping in reversed(self.renames):
            if name in mapping:
                return mapping[name]
        return name if name in self.locals else None

    def store(self, target):
        # A list pattern unpacks like a tuple pattern; both raise on a length mismatch.
        if isinstance(target, (ast.Tuple, ast.List)):
            return ast.Tuple(elts=[self.store(item) for item in target.elts], ctx=ast.Store())
        return ast.Name(id=self.local(_target_names(target)[0]), ctx=ast.Store())

    def unpack(self, target, value):
        """Statements that assign ``value`` to a name or an unpacking pattern.

        A pattern becomes a length check and one constant-index read per item, which
        Numba compiles far faster than unpacking an array. A wrong length falls back,
        and Python raises its ValueError.
        """
        if not isinstance(target, (ast.Tuple, ast.List)):
            return [ast.Assign(targets=[self.store(target)], value=value)]
        if any(isinstance(item, ast.Starred) for item in target.elts):
            raise Unsupported(f"starred assignment at line {target.lineno}")
        held = self.unit.fresh("unpack")
        out = [ast.Assign(targets=[ast.Name(id=held, ctx=ast.Store())], value=value),
               ast.Expr(value=_call("_rc_unpack", ast.Name(id=held, ctx=ast.Load()),
                                    ast.Constant(value=len(target.elts))))]
        for position, item in enumerate(target.elts):
            out += self.unpack(item, _call("_rc_index", ast.Name(id=held, ctx=ast.Load()), ast.Constant(value=position)))
        return out

    # Statements

    def visit_Return(self, node):
        if _returns_none(node):
            return ast.Return(value=None)
        return ast.Return(value=self.visit(node.value))

    def method_alias(self, node):
        """``push = values.append``: remember it, so ``push(x)`` becomes ``values.append(x)``.

        Only when both names are bound once, so the alias always means the same list.
        """
        if len(node.targets) != 1 or not isinstance(node.targets[0], ast.Name):
            return False
        alias, value = node.targets[0].id, node.value
        if not (isinstance(value, ast.Attribute) and value.attr in LIST_METHODS and isinstance(value.value, ast.Name)):
            return False
        base = value.value.id
        if self.local(base) is None or alias in self.params or self.stores.get(alias) != 1:
            return False
        if self.stores.get(base, 0) != (0 if base in self.params else 1):
            raise Unsupported(f"'{alias}' refers to a method of '{base}', which is rebound")
        self.methods[alias] = base, value.attr
        return True

    def create_array(self, name, value):
        """The NumPy form of a fixed-length local list's creation."""
        if isinstance(value, ast.Call):
            bounds = [self.visit(item) for item in value.args[0].args]
            start, stop, step = ([ast.Constant(value=0), *bounds, ast.Constant(value=1)] if len(bounds) == 1
                                 else [*bounds, ast.Constant(value=1)] if len(bounds) == 2 else bounds)
            return _call("_rc_arange", start, stop, step)
        if isinstance(value, ast.BinOp):
            repeated, count = ((value.left, value.right) if isinstance(value.left, ast.List)
                               else (value.right, value.left))
            return _call("_rc_full", self.visit(count), ast.Constant(value=repeated.elts[0].value))
        return _call("_rc_copy", self.visit(value.value))

    def fill_info(self, name):
        """The class of the objects a ``[None] * n`` list is filled with."""
        if name not in self.fill_class:
            classes = set()
            for fill in self.fills[name][1]:
                called = fill.value.func.id
                cls = self.namespace.get(called) if self.local(called) is None else None
                if not isinstance(cls, type) or _record_problem(cls) is not None:
                    raise Unsupported(f"'{name}' is filled with something other than new objects of a plain class")
                self.unit.guard(self.namespace, called)
                classes.add(cls)
            if len(classes) != 1:
                raise Unsupported(f"'{name}' is filled with objects of different classes")
            info = self.unit.records.register(classes.pop())
            if not info.fields:
                raise Unsupported(f"'{info.cls.__name__}' has no attributes")
            self.fill_class[name] = info
        return self.fill_class[name]

    def fill_key(self, info):
        return f"{info.token}|{''.join(info.kinds)}"

    def visit_Assign(self, node):
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Name) and node.targets[0].id in self.fills:
            name = node.targets[0].id
            info = self.fill_info(name)
            return ast.Assign(targets=[self.store(node.targets[0])], value=_call(
                self.unit.named("blank", self.fill_key(info)), self.visit(_none_list(node.value))))
        if (len(node.targets) == 1 and isinstance(node.targets[0], ast.Subscript)
                and isinstance(node.targets[0].value, ast.Name) and node.targets[0].value.id in self.fills):
            name = node.targets[0].value.id
            if not any(node is fill for fill in self.fills[name][1]):
                raise Unsupported(f"store into the list of objects '{name}' at line {node.lineno}")
            info, call = self.fill_info(name), node.value
            if call.keywords or any(isinstance(arg, ast.Starred) for arg in call.args):
                raise Unsupported(f"keyword or starred argument at line {node.lineno}")
            args = [self.visit(arg) for arg in call.args]
            init = getattr(info.cls, "__init__")
            if init is not object.__init__:
                args += self.defaults(init, len(args) + 1, call)
            values = _call(self.unit.constructor(info.cls, fields_only=True), *args)
            return ast.Expr(value=_call(self.unit.named("fill", self.fill_key(info)),
                                        self.visit(node.targets[0].value), self.visit(node.targets[0].slice), values))
        if (len(node.targets) == 1 and isinstance(node.targets[0], ast.Name)
                and node.targets[0].id in self.array_aliases):
            return ast.Pass()
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Name) and node.targets[0].id in self.arrays:
            return ast.Assign(targets=[self.store(node.targets[0])],
                              value=self.create_array(node.targets[0].id, node.value))
        if self.method_alias(node):
            return ast.Pass()
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Name) and node.targets[0].id in self.promoted:
            name = node.targets[0].id
            return [ast.Assign(targets=[ast.Name(id=self.local(name), ctx=ast.Store())],
                               value=ast.Constant(value=float(node.value.value))),
                    ast.Assign(targets=[self.pending(name, ast.Store())], value=ast.Constant(value=True))]
        value = self.visit(node.value)
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Attribute):
            target = node.targets[0]
            self.plain_base(target)
            self.unit.written.add(target.attr)
            return ast.Expr(value=_call(self.unit.named("setattr", target.attr), self.visit(target.value), value))
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Subscript):
            target = node.targets[0]
            self.unit.writes = True
            if isinstance(target.slice, ast.Slice):
                source = node.value
                if (isinstance(source, ast.Subscript) and isinstance(source.slice, ast.Slice)
                        and isinstance(source.value, ast.Name) and isinstance(target.value, ast.Name)
                        and source.value.id == target.value.id):
                    # ``a[i:j] = a[k:l:-1]`` within one list, done without building
                    # the intermediate list when it is a reversal in place. The source
                    # bounds come first, as Python evaluates them first.
                    parts = [ast.Constant(value=None) if part is None else self.visit(part)
                             for item in (source.slice, target.slice) for part in (item.lower, item.upper, item.step)]
                    return ast.Expr(value=_call("_rc_moveslice", self.visit(target.value), *parts))
                # Numba would convert the elements of a list of another type.
                store = ast.Subscript(value=self.visit(target.value), slice=self.visit(target.slice), ctx=ast.Store())
                return ast.Assign(targets=[store], value=_call("_rc_samelist", self.visit(target.value), value))
            return ast.Expr(value=_call("_rc_setitem", self.visit(target.value), self.visit(target.slice), value))
        if len(node.targets) == 1:
            return self.unpack(node.targets[0], value)
        return ast.Assign(targets=[self.store(target) for target in node.targets], value=value)

    def visit_AugAssign(self, node):
        target = node.target
        if isinstance(target, ast.Subscript) and isinstance(target.slice, ast.Slice):
            raise Unsupported(f"in-place operator on a slice at line {node.lineno}")
        if isinstance(target, ast.Attribute):
            self.plain_base(target)
            self.unit.written.add(target.attr)
            current = self.visit(ast.copy_location(ast.Attribute(value=target.value, attr=target.attr, ctx=ast.Load()),
                                                   target))
            value = self.operation(node, type(node.op), IN_PLACE, current, node.value)
            return ast.Expr(value=_call(self.unit.named("setattr", target.attr), self.visit(target.value), value))
        if isinstance(target, ast.Name) and target.id in self.promoted:
            current = ast.Name(id=self.local(target.id), ctx=ast.Load())
            value = _call(IN_PLACE[type(node.op)], current, _call("_rc_floatonly", self.visit(node.value)))
            return [ast.Assign(targets=[self.store(target)], value=value),
                    ast.Assign(targets=[self.pending(target.id, ast.Store())], value=ast.Constant(value=False))]
        current = self.visit(ast.copy_location(ast.Name(id=target.id, ctx=ast.Load()), target)
                             if isinstance(target, ast.Name) else target)
        value = self.operation(node, type(node.op), IN_PLACE, current, node.value)
        if isinstance(target, ast.Subscript):
            self.unit.writes = True
            return ast.Expr(value=_call("_rc_setitem", self.visit(target.value), self.visit(target.slice), value))
        return ast.Assign(targets=[self.store(target)], value=value)

    def plain_base(self, target):
        """The object of an attribute store is evaluated before the value here, after it in
        Python, so it may not contain calls whose order would show."""
        if any(isinstance(item, ast.Call) for item in ast.walk(target.value)):
            raise Unsupported(f"assignment to an attribute of a call result at line {target.lineno}")

    def visit_Expr(self, node):
        call = node.value
        if isinstance(call, ast.Call) and len(call.args) == 2 and isinstance(call.args[1], ast.Call):
            # ``v.insert(i, v.pop(j))`` on a fixed-length local: an in-place rotation.
            base = (call.func.value.id if isinstance(call.func, ast.Attribute) and isinstance(call.func.value, ast.Name)
                    else self.array_aliases.get(getattr(call.func, "id", None)))
            if base in self.arrays:
                inner = call.args[1]
                where = self.visit(inner.args[0]) if inner.args else ast.Constant(value=-1)
                self.unit.writes = True
                return ast.Expr(value=_call("_rc_rotate", ast.Name(id=self.local(base), ctx=ast.Load()),
                                            self.visit(call.args[0]), where))
        if isinstance(call, ast.Call):
            return ast.Expr(value=self.visit(call))
        raise Unsupported(f"expression statement at line {node.lineno}")

    def visit_If(self, node):
        return ast.If(test=self.visit(node.test), body=self.body(node.body), orelse=self.body(node.orelse))

    def visit_While(self, node):
        # Once a check has failed the result is discarded, so stop looping.
        test = ast.BoolOp(op=ast.And(), values=[ast.UnaryOp(op=ast.Not(), operand=_flagged()), self.visit(node.test)])
        return ast.While(test=test, body=self.body(node.body), orelse=self.body(node.orelse))

    def visit_For(self, node):
        iterable = node.iter
        if isinstance(iterable, ast.Call) and isinstance(iterable.func, ast.Name) and iterable.func.id in (
                "range", "enumerate"):
            stop = ast.If(test=_flagged(), body=[ast.Break()], orelse=[])
            return ast.For(target=self.store(node.target), iter=self.visit(iterable),
                           body=[stop, *self.body(node.body)], orelse=self.body(node.orelse))
        # Walk a sequence by index, reading its length on every step, as Python's
        # list iterator does. Numba compiles this much faster than iterating a tuple
        # of records, and it gives the same items when a list grows inside the loop.
        index = self.unit.fresh("k")
        visited = self.visit(iterable)
        # A name the loop never rebinds is indexed directly. Copying a tuple of records
        # into a temporary costs a reference-count update per array it holds.
        rebound = isinstance(iterable, ast.Name) and any(
            isinstance(item, ast.Name) and isinstance(item.ctx, ast.Store) and item.id == iterable.id
            for statement in node.body + node.orelse + [node.target] for item in ast.walk(statement))
        direct = isinstance(visited, ast.Name) and isinstance(iterable, ast.Name) and not rebound
        sequence = visited.id if direct else self.unit.fresh("seq")

        def name(identifier, ctx=ast.Load):
            return ast.Name(id=identifier, ctx=ctx())

        test = ast.BoolOp(op=ast.And(), values=[
            ast.UnaryOp(op=ast.Not(), operand=_flagged()),
            ast.Compare(left=name(index), ops=[ast.Lt()], comparators=[_call("_rc_len", name(sequence))])])
        step = [*self.unpack(node.target, ast.Subscript(value=name(sequence), slice=name(index), ctx=ast.Load())),
                ast.Assign(targets=[name(index, ast.Store)],
                           value=ast.BinOp(left=name(index), op=ast.Add(), right=ast.Constant(value=1)))]
        setup = [] if direct else [ast.Assign(targets=[name(sequence, ast.Store)], value=visited)]
        # The index starts as a plain int64, not a literal 0: with a literal, Numba
        # first types ``columns[0]`` as the tuple's first item, the id column.
        start = ast.Call(func=name("_rc_int64"), args=[ast.Constant(value=0)], keywords=[])
        return [*setup, ast.Assign(targets=[name(index, ast.Store)], value=start),
                ast.While(test=test, body=[*step, *self.body(node.body)], orelse=self.body(node.orelse))]

    def stand_in(self):
        """A return value of the right type for a call that is going to be discarded:
        one of the function's own return expressions that reads only parameters,
        attributes and constants and calls nothing."""
        for item in ast.walk(self.node):
            if not (isinstance(item, ast.Return) and item.value is not None and not _returns_none(item)):
                continue
            names = {name.id for name in ast.walk(item.value) if isinstance(name, ast.Name)}
            if any(isinstance(part, ast.Call) for part in ast.walk(item.value)):
                continue
            if all(name in self.params or (self.local(name) is None and name in self.namespace) for name in names):
                try:
                    return self.visit(item.value)
                except Unsupported:
                    continue
        return None

    def visit_Raise(self, node):
        # The exception itself is not compiled. Raising hands the call to Python,
        # which runs from the original arguments and raises its own exception. Where it
        # can, the compiled code sets the fallback flag and returns instead: a real
        # exception keeps the reference counts of arrays live around every call that
        # could raise, which costs tens of nanoseconds a call.
        gives_value = any(isinstance(item, ast.Return) and not _returns_none(item) for item in ast.walk(self.node))
        if not gives_value:
            return [ast.Expr(value=_call("_rc_fail")), ast.Return(value=None)]
        value = self.stand_in()
        if value is not None:
            return [ast.Expr(value=_call("_rc_fail")), ast.Return(value=value)]
        self.unit.raises = True
        return ast.Raise(exc=ast.Name(id="_rc_Fallback", ctx=ast.Load()), cause=None)

    def visit_Break(self, node):
        return ast.Break()

    def visit_Continue(self, node):
        return ast.Continue()

    def visit_Pass(self, node):
        return ast.Pass()

    # Expressions

    def visit_Name(self, node):
        if node.id in self.methods:
            raise Unsupported(f"method '{node.id}' used as a value at line {node.lineno}")
        if node.id in self.promoted and self.local(node.id) == node.id:
            return _call("_rc_settled", ast.Name(id=node.id, ctx=ast.Load()), self.pending(node.id, ast.Load()))
        name = self.local(node.id)
        if name is None:
            if node.id not in self.namespace:
                raise Unsupported(f"name '{node.id}' at line {node.lineno}")
            name = self.unit.constant(self.namespace, node.id)
        return ast.Name(id=name, ctx=ast.Load())

    def visit_Constant(self, node):
        if type(node.value) is str or not _constant_ok(node.value):
            raise Unsupported(f"constant {node.value!r} at line {node.lineno}")
        return ast.Constant(value=node.value)

    def visit_Attribute(self, node):
        base = node.value
        if isinstance(base, ast.Name) and self.local(base.id) is None and self.namespace.get(base.id) is math:
            if node.attr not in MATH_CONSTANTS:
                raise Unsupported(f"attribute math.{node.attr} at line {node.lineno}")
            self.unit.guard(self.namespace, base.id)
            self.unit.guards.append((_Attribute(math), node.attr, getattr(math, node.attr), None))
            return ast.Constant(value=getattr(math, node.attr))
        # An attribute of a record; the overload checks it is one of its fields.
        return _call(self.unit.named("getattr", node.attr), self.visit(base))

    def operation(self, node, op, table, left, right_node):
        if op is ast.Pow:
            if isinstance(right_node, ast.Constant) and type(right_node.value) is int and right_node.value == 2:
                return _call("_rc_sq", left)
            self.unit.uses_pow = True
            return _call("_rc_pow", left, self.visit(right_node))
        right = self.visit(right_node)
        if op in BITWISE:
            return ast.BinOp(left=left, op=op(), right=right)
        if op not in table:
            raise Unsupported(f"operator {op.__name__} at line {node.lineno}")
        return _call(table[op], left, right)

    def visit_BinOp(self, node):
        return self.operation(node, type(node.op), BINARY, self.visit(node.left), node.right)

    def visit_UnaryOp(self, node):
        operand = self.visit(node.operand)
        if isinstance(node.op, ast.Not):
            return ast.UnaryOp(op=ast.Not(), operand=operand)
        if isinstance(node.op, ast.USub) and isinstance(operand, ast.Constant) and type(operand.value) is not bool:
            return ast.Constant(value=-operand.value)
        return _call(UNARY[type(node.op)], operand)

    def visit_BoolOp(self, node):
        return ast.BoolOp(op=node.op, values=[self.visit(value) for value in node.values])

    def visit_Compare(self, node):
        if not all(isinstance(op, COMPARE) for op in node.ops):
            raise Unsupported(f"comparison at line {node.lineno}")
        return ast.Compare(left=self.visit(node.left), ops=node.ops,
                           comparators=[self.visit(item) for item in node.comparators])

    def visit_IfExp(self, node):
        return ast.IfExp(test=self.visit(node.test), body=self.visit(node.body), orelse=self.visit(node.orelse))

    def visit_Slice(self, node):
        parts = [None if part is None else self.visit(part) for part in (node.lower, node.upper, node.step)]
        return ast.Slice(lower=parts[0], upper=parts[1], step=parts[2])

    def visit_Subscript(self, node):
        value, index = self.visit(node.value), self.visit(node.slice)
        # A slice of a list is a new list. Slices of array arguments, which would be
        # views, are rejected after type inference.
        if isinstance(index, ast.Slice):
            parts = index.lower, index.upper, index.step
            if all(part is None or (isinstance(part, ast.Constant) and type(part.value) is int) for part in parts):
                # Constant bounds: an overload per slice, so a list of objects held
                # as columns is sliced column by column.
                text = ":".join("" if part is None else str(part.value) for part in parts)
                return _call(self.unit.named("slice", text), value)
            return ast.Subscript(value=value, slice=index, ctx=ast.Load())
        if isinstance(index, ast.Constant) and type(index.value) is int:
            return _call("_rc_index", value, index)
        return _call("_rc_getitem", value, index)

    def visit_List(self, node):
        return ast.List(elts=[self.visit(item) for item in node.elts], ctx=ast.Load())

    def visit_Tuple(self, node):
        return ast.Tuple(elts=[self.visit(item) for item in node.elts], ctx=ast.Load())

    def visit_ListComp(self, node):
        if len(node.generators) != 1 or node.generators[0].is_async:
            raise Unsupported(f"comprehension at line {node.lineno}")
        generator = node.generators[0]
        iterable = self.visit(generator.iter)
        # Comprehension variables are private in Python, so give them private names.
        self.renames.append({name: self.unit.fresh(name) for name in _target_names(generator.target)})
        try:
            inner = ast.comprehension(target=self.store(generator.target), iter=iterable,
                                      ifs=[self.visit(test) for test in generator.ifs], is_async=0)
            return ast.ListComp(elt=self.visit(node.elt), generators=[inner])
        finally:
            self.renames.pop()

    def visit_Call(self, node):
        if node.keywords or any(isinstance(arg, ast.Starred) for arg in node.args):
            raise Unsupported(f"keyword or starred argument at line {node.lineno}")
        func, args = node.func, [self.visit(arg) for arg in node.args]
        if isinstance(func, ast.Name) and func.id in self.methods:
            base, method = self.methods[func.id]
            return self.list_method(node, ast.Name(id=self.local(base), ctx=ast.Load()), method, args)
        if isinstance(func, ast.Attribute):
            if func.attr == "bit_count" and not args:
                return _call("_rc_popcount", self.visit(func.value))
            base = func.value
            if (isinstance(base, ast.Name) and self.local(base.id) is None and self.namespace.get(base.id) is math
                    and func.attr in MATH and getattr(math, func.attr, None) is MATH[func.attr] and len(args) == 1):
                self.unit.guard(self.namespace, base.id)
                self.unit.math_guards.add(func.attr)
                return _call("_rc_" + func.attr, *args)
            if isinstance(base, ast.Name) and self.local(base.id) is None and self.namespace.get(base.id) is math:
                raise Unsupported(f"call of math.{func.attr} at line {node.lineno}")
            # A method of a record, or append/insert/pop on a list, chosen by type.
            return _call(self.unit.named("method", func.attr), self.visit(base), ast.Tuple(elts=args, ctx=ast.Load()))
        elif isinstance(func, ast.Name) and self.local(func.id) is None:
            name = func.id
            if name in self.namespace:
                value = self.namespace[name]
                known = getattr(value, "__name__", None)
                if (len(args) == 1 and known in MATH and value is MATH[known]
                        and getattr(math, known, None) is value):
                    # ``from math import sqrt``
                    self.unit.guard(self.namespace, name)
                    self.unit.math_guards.add(known)
                    return _call("_rc_" + known, *args)
                if isinstance(value, type) and _record_problem(value) is None:
                    self.unit.guard(self.namespace, name)
                    init = getattr(value, "__init__")
                    if init is not object.__init__:
                        args += self.defaults(init, len(args) + 1, node)
                    return _call(self.unit.constructor(value), *args)
                if isinstance(self.namespace[name], FunctionType):
                    # ``recompyler run`` swaps in wrappers; compile what they wrap.
                    callee = _unwrap(self.namespace[name])
                    args += self.defaults(callee, len(args), node)
                    return _call(self.unit.function(callee, self.namespace, name), *args)
            elif name in BUILTINS and self.builtins.get(name) is BUILTINS[name]:
                self.unit.builtin_guards[id(self.namespace), id(self.builtins), name] = self.namespace, self.builtins
                if name == "range" and len(args) == 3:
                    args[2] = _call("_rc_step", args[2])
                if name == "len" and len(args) == 1:
                    return _call("_rc_len", *args)
                if name in ("range", "float", "enumerate", "list") and (name == "range" or len(args) == 1):
                    return _call(name, *args)
                if name in ("int", "abs") and len(args) == 1:
                    return _call("_rc_" + name, *args)
                if name in ("min", "max") and len(args) >= 2:
                    return functools.reduce(lambda left, right: _call("_rc_" + name, left, right), args)
        raise Unsupported(f"call at line {node.lineno}")

    def list_method(self, node, target, method, args):
        if method == "append" and len(args) == 1:
            return _call("_rc_append", target, *args)
        if method == "insert" and len(args) == 2:
            return _call("_rc_insert", target, *args)
        if method == "pop" and len(args) <= 1:
            return _call("_rc_pop", target, *(args or [ast.Constant(value=-1)]))
        raise Unsupported(f"call of .{method} at line {node.lineno}")

    def defaults(self, callee, given, node):
        """Default values for the parameters a call leaves out, as guarded constants."""
        missing = callee.__code__.co_argcount - given
        values = callee.__defaults__ or ()
        if missing <= 0:
            return []
        if missing > len(values) or not all(map(_constant_ok, values[-missing:])):
            raise Unsupported(f"call at line {node.lineno} relies on a default that is not a numeric constant")
        return [ast.Name(id=self.unit.default(callee, index), ctx=ast.Load())
                for index in range(len(values) - missing, len(values))]


def _unwrap(fn):
    return getattr(fn, "__recompyler_original__", fn)


class _Attribute:
    """Lets a guard watch one attribute of an object, such as a function's defaults."""

    def __init__(self, owner):
        self.owner = owner

    def get(self, name):
        return getattr(self.owner, name, None)


class _Unit:
    """The root function plus every helper and constant it reaches."""

    def __init__(self, promote=None, records=None):
        # Variables to promote from an int start to a guarded float, by function.
        self.promote = promote or {}
        # Classes whose instances are records, and attributes compiled code assigns.
        self.records = records if records is not None else _Records()
        self.written = set()
        # (family, name) -> the generated name of the per-name overload it calls.
        self.names = {}
        self.functions, self.building, self.definitions = {}, set(), []
        self.constants, self.guards, self.counter = {}, [], 0
        self.builtin_guards, self.math_guards = {}, set()
        # Whether any function stores into a list or array by index, so arguments
        # passed as copies have to be written back.
        self.writes = False
        # Whether any function raises. Exceptions need the single-threaded CPU loop.
        self.raises = False
        # Whether ``**`` with an exponent other than 2 appears; it needs the self-test.
        self.uses_pow = False
        # Whether fixed-length local lists become NumPy arrays.
        self.local_arrays = True

    def named(self, family, name):
        """The module-level name for the overload of one attribute, method or class."""
        key = family, name
        if key not in self.names:
            self.names[key] = f"_rc_{family}{len(self.names)}"
        return self.names[key]

    def fresh(self, name):
        self.counter += 1
        return f"_rcv{self.counter}_{name}"

    def guard(self, namespace, name):
        value = namespace[name]
        self.guards.append((namespace, name, value, getattr(value, "__code__", None)))

    def constant(self, namespace, name):
        value = namespace[name]
        if not _constant_ok(value):
            raise Unsupported(f"global '{name}' is not a numeric constant")
        key = id(namespace), name
        if key not in self.constants:
            self.constants[key] = self.fresh(name), value
            self.guard(namespace, name)
        return self.constants[key][0]

    def default(self, fn, index):
        key = id(fn), "__defaults__", index
        if key not in self.constants:
            self.constants[key] = self.fresh(f"{fn.__name__}_default{index}"), fn.__defaults__[index]
            self.guards.append((_Attribute(fn), "__defaults__", fn.__defaults__, None))
        return self.constants[key][0]

    def function(self, fn, namespace=None, name=None):
        if namespace is not None:
            self.guard(namespace, name)
        if id(fn) in self.functions:
            return self.functions[id(fn)]
        if id(fn) in self.building:
            raise Unsupported(f"'{fn.__name__}' is recursive")
        if not isinstance(fn, FunctionType):
            raise Unsupported(f"'{fn}' is not a plain function")
        if hasattr(fn, "__recompyler_original__"):
            raise Unsupported("internal: unwrap before lifting")
        node = self.source(fn)
        params = [arg.arg for arg in node.args.posonlyargs + node.args.args]
        local_names = _local_names(node) | set(params)
        if any(name.startswith("_rc") for name in local_names):
            raise Unsupported("names starting with _rc are reserved")
        return self.define(fn, id(fn), node, params, fn.__name__)

    def source(self, fn):
        code = fn.__code__
        if fn.__closure__ or code.co_kwonlyargcount or code.co_flags & 0x2AC:
            raise Unsupported(f"'{fn.__name__}' has a closure, keyword-only arguments, *args or is a generator")
        self.guards.append(({"": fn}, "", fn, code))
        try:
            tree = ast.parse(textwrap.dedent(inspect.getsource(fn)))
        except (OSError, TypeError, SyntaxError) as exc:
            raise Unsupported(f"no source for '{fn.__name__}'") from exc
        node = tree.body[0]
        if not isinstance(node, ast.FunctionDef) or node.decorator_list or node.name != fn.__name__:
            raise Unsupported(f"'{fn.__name__}' is decorated or not a plain def")
        if ast.get_docstring(node) is not None:
            node.body = node.body[1:]
        return node

    def constructor(self, cls, fields_only=False):
        """A compiled ``cls(...)``: ``__init__`` may only assign attributes of the new
        object from values that do not read it, so the record can be built directly.
        With ``fields_only`` it returns the attribute values as a tuple, in record
        order, for storing as a row of a column list."""
        key = ("fields" if fields_only else "new"), id(cls)
        if key in self.functions:
            return self.functions[key]
        info = self.records.register(cls)
        init = getattr(cls, "__init__")
        if init is object.__init__:
            node = ast.FunctionDef(name="__init__", args=ast.arguments(
                posonlyargs=[], args=[ast.arg(arg="self")], kwonlyargs=[], kw_defaults=[], defaults=[]),
                body=[], decorator_list=[], lineno=1, col_offset=0)
        else:
            node = self.source(init)
        if node.args.posonlyargs or not node.args.args:
            raise Unsupported(f"'{cls.__name__}.__init__' has an unusual signature")
        me, params = node.args.args[0].arg, [arg.arg for arg in node.args.args[1:]]
        body, assigned = [], []
        for statement in node.body:
            if not isinstance(statement, ast.Assign) or any(
                    isinstance(item, ast.Name) and item.id == me for item in ast.walk(statement.value)):
                raise Unsupported(f"'{cls.__name__}.__init__' does more than set attributes from its arguments")
            targets = []
            for target in statement.targets:
                if isinstance(target, ast.Attribute) and isinstance(target.value, ast.Name) and target.value.id == me:
                    assigned.append(target.attr)
                    targets.append(ast.Name(id=f"_rcf_{target.attr}", ctx=ast.Store()))
                elif isinstance(target, ast.Name) and target.id != me:
                    targets.append(target)
                else:
                    raise Unsupported(f"'{cls.__name__}.__init__' does more than set attributes from its arguments")
            body.append(ast.copy_location(ast.Assign(targets=targets, value=statement.value), statement))
        if sorted(assigned) != list(info.fields):
            raise Unsupported(f"'{cls.__name__}.__init__' does not set each attribute exactly once")
        built = ast.FunctionDef(name=node.name, args=ast.arguments(
            posonlyargs=[], args=[ast.arg(arg=name) for name in params], kwonlyargs=[], kw_defaults=[], defaults=[]),
            body=body, decorator_list=[], lineno=node.lineno, col_offset=0)
        names = _local_names(built) | set(params)
        if any(name.startswith("_rc") for name in names - {f"_rcf_{field}" for field in info.fields}):
            raise Unsupported("names starting with _rc are reserved")
        values = ast.Tuple(elts=[ast.Name(id=f"_rcf_{field}", ctx=ast.Load()) for field in info.fields],
                           ctx=ast.Load())
        tail = [ast.Return(value=values if fields_only else _call(self.named("make", info.token), values))]
        keep = len(built.body)
        built.body.append(ast.Return(value=ast.Constant(value=0)))  # a value path for the flow check
        return self.define(init, key, built, params, f"{'fields' if fields_only else 'new'}_{cls.__name__}",
                           tail=tail, keep=keep)

    def methods(self, info):
        """Lift every method of a record class that fits the subset."""
        seen = set()
        for klass in info.cls.__mro__[:-1]:
            for name, value in vars(klass).items():
                if name in seen:
                    continue
                seen.add(name)
                if name == "__init__" or not isinstance(value, FunctionType):
                    continue
                value = _unwrap(value)
                try:
                    info.mangled[name] = self.function(value)
                except Unsupported as exc:
                    info.problems[name] = str(exc)
                    continue
                self.guards.append((_Attribute(info.cls), name, value, None))

    def define(self, fn, key, node, params, label, tail=(), keep=None):
        local_names = _local_names(node) | set(params)
        _check_flow(node, params, local_names)
        if keep is not None:
            node.body = node.body[:keep]
        self.building.add(key)
        body = _Rewriter(self, fn, local_names, node, params).body(node.body) + list(tail)
        self.building.discard(key)
        mangled = self.functions[key] = self.fresh(label)
        arguments = ast.arguments(posonlyargs=[], args=[ast.arg(arg=name) for name in (STATUS, *params)],
                                  kwonlyargs=[], kw_defaults=[], defaults=[])
        self.definitions.append(ast.FunctionDef(name=mangled, args=arguments, body=body, decorator_list=[],
                                                type_params=[], lineno=node.lineno, col_offset=0))
        return mangled

    # Identity checks built from the guards on the first call; see guards_hold.
    _fast_guards = None

    def guards_hold(self):
        """True if every global, default, builtin and math function the compiled code
        assumed is still in place. Checked on every call, so the common case (every
        object is the very one recorded) is a flat run of identity checks; anything
        else goes through the full comparison."""
        checks = self._fast_guards
        if checks is None:
            checks = self._fast_guards = (
                [(namespace, name, value, code) for namespace, name, value, code in self.guards],
                [(namespace, name, lookup, BUILTINS[name])
                 for (_, _, name), (namespace, lookup) in self.builtin_guards.items()],
                [(name, MATH[name]) for name in self.math_guards])
        plain, builtin, maths = checks
        for namespace, name, value, code in plain:
            current = namespace.get(name)
            if current is not value or (code is not None and current.__code__ is not code):
                return self._guards_hold_fully()
        for namespace, name, lookup, expected in builtin:
            if namespace.get(name, lookup.get(name)) is not expected:
                return False
        math_names = math.__dict__
        for name, expected in maths:
            if math_names.get(name) is not expected:
                return False
        return True

    def _guards_hold_fully(self):
        for namespace, name, value, code in self.guards:
            current = namespace.get(name)
            if current is not value and not (type(value) is not tuple and same(current, value)):
                return False
            if code is not None and current.__code__ is not code:
                return False
        return (all(namespace.get(name, lookup.get(name)) is BUILTINS[name]
                    for (_, _, name), (namespace, lookup) in self.builtin_guards.items())
                and all(getattr(math, name, None) is MATH[name] for name in self.math_guards))


@functools.cache
class _NoSciPy:
    """An import hook that makes ``import scipy`` fail, used only while Numba starts."""

    def find_spec(self, name, path=None, target=None):
        if name == "scipy" or name.startswith("scipy."):
            raise ImportError("skipped while RecomPyler starts Numba")
        return None


def _ours(fndesc):
    """True for functions RecomPyler generated: its runtime overloads and lifted modules."""
    module = getattr(fndesc, "modname", "") or ""
    return module == __name__ or module.startswith(("rc_", "recompyler_generated"))


def _refcounts_unneeded(module, dmm, fndesc):
    """True if a function can drop all its NRT_incref and NRT_decref calls.

    It must take only arrays or values that are not reference counted, return
    nothing reference counted, call nothing that returns something reference
    counted, and allocate nothing. Then every array it touches is borrowed from
    its caller for the whole call, and the counts it adds cancel out.

    The rule and the rewrite are from ``numba.core.removerefctpass`` (Numba up to
    0.65, BSD 2-clause licence), which Numba 0.68 removed.
    """
    from numba.core import types

    def plain(ty):
        return not dmm[ty].contains_nrt_meminfo()

    if not all(plain(ty) or isinstance(ty, types.Array) for ty in fndesc.argtypes):
        return False
    if not plain(fndesc.restype):
        return False
    if any(call is not None and not plain(call.return_type) for call in fndesc.calltypes.values()):
        return False
    return not any(fn.name.startswith("NRT_") and fn.name not in ("NRT_incref", "NRT_decref")
                   for fn in module.functions)


def _drop_refcounts(function):
    for block in function.basic_blocks:
        for instruction in list(block.instructions):
            callee = getattr(getattr(instruction, "callee", None), "name", "")
            if callee in ("NRT_incref", "NRT_decref"):
                block.instructions.remove(instruction)


def _keep_refcount_pass():
    """Run Numba's old refcount removal on RecomPyler's own functions.

    RecomPyler's checked operations are small overloads that take the status array
    and the arrays they work on. Numba up to 0.65 removed their reference counting
    after lowering; Numba 0.68 dropped that step, and once the overloads are inlined
    their count updates stay in the hot loops: nbody's lifted ``advance`` went from
    3.9 ms to 90 ms. This reinstates the step for functions RecomPyler generated
    only, and does nothing where Numba still has it.
    """
    import numba.core
    from numba.core import lowering

    if importlib.util.find_spec("numba.core.removerefctpass") is not None:
        return
    if getattr(lowering.Lower, "_recompyler_refcounts", False):
        return
    original = lowering.Lower.lower_normal_function

    def lower_normal_function(self, fndesc):
        original(self, fndesc)
        if self.context.enable_nrt and _ours(fndesc) and _refcounts_unneeded(
                self.module, self.context.data_model_manager, fndesc):
            _drop_refcounts(self.function)

    lowering.Lower.lower_normal_function = lower_normal_function
    lowering.Lower._recompyler_refcounts = True


def _start_numba():
    """Set up Numba's CPU target without importing SciPy.

    On the first compile Numba imports SciPy only to learn whether BLAS is there for
    ``np.dot``; that takes about 0.3 s, and compiled code from here never uses BLAS.
    While Numba starts, ``import scipy`` fails before anything runs, so nothing is
    left half-imported. The answer is then set from whether SciPy is installed, so a
    script's own Numba code that uses ``np.dot`` behaves as before.
    """
    if "scipy" in sys.modules or "numba.np.arraymath" in sys.modules:
        _keep_refcount_pass()
        return
    blocker = _NoSciPy()
    sys.meta_path.insert(0, blocker)
    try:
        from numba.core.registry import cpu_target

        cpu_target.target_context.refresh()
        _keep_refcount_pass()
    finally:
        sys.meta_path.remove(blocker)
    arraymath = sys.modules.get("numba.np.arraymath")
    if arraymath is not None:
        arraymath._HAVE_BLAS = importlib.util.find_spec("scipy") is not None


_COLUMN_ROWS_INSTALLED = False


def _install_column_rows():
    """Let ``columns[index]`` give a record of one row in compiled code.

    A for loop walks its sequence with a plain index, which for a tuple of records
    must stay Numba's own: anything wrapped around it added reference counting on
    every step. So column lists get an overload of ``getitem`` itself, which matches
    nothing else: their id column is int32, unlike any attribute column, so a column
    list is never a uniform tuple that Numba's tuple indexing would take. The loop's
    index is always in bounds, so it needs no check.
    """
    global _COLUMN_ROWS_INSTALLED
    if _COLUMN_ROWS_INSTALLED:
        return
    import numpy as np
    from numba import types
    from numba.extending import overload

    readers = {}

    @overload(operator.getitem, inline="always")
    def column_row(target, index):
        info = _COLUMN_TYPES.get(target.instance_class) if isinstance(target, types.BaseNamedTuple) else None
        if info is None or not isinstance(index, types.Integer):
            return None
        # Which attributes are views depends on what the compiled code assigns.
        key = info, info.boxed
        if key not in readers:
            items = "".join(f", target[{1 + position}][index:index + 1]" if field in info.boxed
                            else f", target[{1 + position}][index]" for position, field in enumerate(info.fields))
            scope = {"NT": info.nt, "np": np, "__name__": __name__}
            exec(f"def impl(target, index):\n    return NT(np.int64(target[0][index]){items})\n", scope)
            readers[key] = scope["impl"]
        return readers[key]

    _COLUMN_ROWS_INSTALLED = True


def _runtime():
    """Checked operations, compiled into the lifted code in place of raw operators."""
    import numpy as np

    _start_numba()
    from numba import njit, types
    from numba.core import ir
    from numba.core.errors import NumbaError
    from numba.extending import overload

    limit, exact = 2.0**62, 2**53

    def kind(numba_type):
        if isinstance(numba_type, types.Literal):
            numba_type = numba_type.literal_type
        if isinstance(numba_type, types.Boolean):
            return "b"
        if isinstance(numba_type, types.Integer):
            return "i" if numba_type.signed else "u"
        if isinstance(numba_type, types.Float):
            return "f"
        if isinstance(numba_type, types.BaseTuple):
            return ("t", *map(kind, numba_type.types))
        if isinstance(numba_type, types.List):
            return "l", kind(numba_type.dtype)
        return str(numba_type)

    def integer(numba_type):
        return kind(numba_type) in ("b", "i")

    def number(numba_type):
        return kind(numba_type) in ("b", "i", "f")

    library = {}
    impls = {}

    def made(source, **env):
        """An implementation from generated source, made once per source and environment."""
        key = source, tuple(sorted((name, id(value)) for name, value in env.items()))
        if key not in impls:
            # A real module name lets Numba's disk cache find the function again.
            scope = dict(env, np=np, __name__=__name__)
            exec(source, scope)
            impls[key] = scope["impl"]
        return impls[key]

    def record_of(numba_type):
        if isinstance(numba_type, types.BaseNamedTuple):
            return _RECORD_TYPES.get(numba_type.instance_class)
        return None

    def columns_of(numba_type):
        if isinstance(numba_type, types.BaseNamedTuple):
            return _COLUMN_TYPES.get(numba_type.instance_class)
        return None

    def holds_record(expr, caller, callee):
        """Inline a call at Numba's level when a record or a column list goes in. One
        holding arrays, passed into a call LLVM does not inline, costs reference-count
        updates on every call; inlining every overload made other code slower."""
        return any(record_of(arg_type) is not None or columns_of(arg_type) is not None
                   for arg_type in (caller.typemap.get(arg.name) for arg in expr.args))

    def register(name, pick, prefer_literal=False, inline=None):
        # The picker's parameter names must match the implementation it returns.
        def stub(*args):
            raise NotImplementedError(name)

        stub.__name__ = name
        # Inlined at Numba's level: a record or array passed into a call that LLVM does
        # not inline costs reference-count updates on every call.
        overload(stub, prefer_literal=prefer_literal, inline=inline or holds_record)(pick)
        library[name] = stub

    dunders = {"_rc_add": ("__add__", "__radd__"), "_rc_nadd": ("__iadd__", "__add__", "__radd__"),
               "_rc_sub": ("__sub__", "__rsub__"), "_rc_mul": ("__mul__", "__rmul__"),
               "_rc_nmul": ("__imul__", "__mul__", "__rmul__"), "_rc_div": ("__truediv__", "__rtruediv__"),
               "_rc_floordiv": ("__floordiv__", "__rfloordiv__"), "_rc_mod": ("__mod__", "__rmod__"),
               "_rc_pow": ("__pow__", "__rpow__")}

    def record_operator(name, a, b):
        """The method an operator calls on a record, as Python would choose it."""
        left, right = record_of(a), record_of(b)
        names = dunders.get(name)
        if names is None:
            return None
        *forward, reflected = names
        if left is not None:
            if right is not None and right.cls is not left.cls and issubclass(right.cls, left.cls):
                return None
            for method in forward:
                if method in left.methods:
                    return made("def impl(st, a, b):\n    return D(st, a, b)\n", D=left.methods[method])
            return None
        if right is not None and number(a) and reflected in right.methods:
            return made("def impl(st, a, b):\n    return D(st, b, a)\n", D=right.methods[reflected])
        return None

    def binary(name, on_integers, plain, sequences=False):
        def pick(st, a, b):
            if record_of(a) is not None or record_of(b) is not None:
                return record_operator(name, a, b)
            if columns_of(a) is not None or columns_of(b) is not None:
                # A column list is not a tuple: + or * on it would act like a tuple's.
                return None
            if integer(a) and integer(b):
                return on_integers
            # An array argument stands in for a list; NumPy would work elementwise.
            if isinstance(a, types.Array) or isinstance(b, types.Array):
                return None
            if (number(a) and number(b)) or (sequences and not (number(a) and number(b))):
                return plain
            return None

        register(name, pick)

    # A failed check sets the flag and returns a harmless value. Nothing raises, so the
    # same code runs inside parallel loops and on a GPU, where exceptions are unavailable.
    def add(st, a, b):
        x, y = np.int64(a), np.int64(b)
        if (y > 0 and x > INT_MAX - y) or (y < 0 and x < INT_MIN - y):
            st[0] = 1
            return np.int64(0)
        return x + y

    def sub(st, a, b):
        x, y = np.int64(a), np.int64(b)
        if (y < 0 and x > INT_MAX + y) or (y > 0 and x < INT_MIN + y):
            st[0] = 1
            return np.int64(0)
        return x - y

    def mul(st, a, b):
        x, y = np.int64(a), np.int64(b)
        product = float(x) * float(y)
        if not -limit < product < limit:
            st[0] = 1
            return np.int64(0)
        return x * y

    def div(st, a, b):
        x, y = np.int64(a), np.int64(b)
        if y == 0 or x > exact or x < -exact or y > exact or y < -exact:
            st[0] = 1
            return 0.0
        return x / y

    def floordiv(st, a, b):
        x, y = np.int64(a), np.int64(b)
        if y == 0 or (y == -1 and x == INT_MIN):
            st[0] = 1
            return np.int64(0)
        return x // y

    def mod(st, a, b):
        x, y = np.int64(a), np.int64(b)
        if y == 0:
            st[0] = 1
        if y == 0 or y == -1:
            return np.int64(0)
        return x % y

    def lshift(st, a, b):
        x, y = np.int64(a), np.int64(b)
        if x == 0 and y >= 0:
            return x
        if y < 0 or y >= 63 or x > (INT_MAX >> y) or x < (INT_MIN >> y):
            st[0] = 1
            return np.int64(0)
        return x << y

    def rshift(st, a, b):
        x, y = np.int64(a), np.int64(b)
        if y < 0:
            st[0] = 1
            return np.int64(0)
        return x >> min(y, np.int64(63))

    def float_div(st, a, b):
        if b == 0:
            st[0] = 1
            return 0.0
        return a / b

    def float_floordiv(st, a, b):
        if b == 0:
            st[0] = 1
            return 0.0
        return a // b

    def float_mod(st, a, b):
        if b == 0:
            st[0] = 1
            return 0.0
        return a % b

    binary("_rc_add", add, lambda st, a, b: a + b, sequences=True)
    binary("_rc_nadd", add, lambda st, a, b: a + b)
    binary("_rc_sub", sub, lambda st, a, b: a - b)
    binary("_rc_mul", mul, lambda st, a, b: a * b, sequences=True)
    binary("_rc_nmul", mul, lambda st, a, b: a * b)
    binary("_rc_div", div, float_div)
    binary("_rc_floordiv", floordiv, float_floordiv)
    binary("_rc_mod", mod, float_mod)
    binary("_rc_lshift", lshift, None)
    binary("_rc_rshift", rshift, None)

    unary_dunders = {"_rc_neg": "__neg__", "_rc_pos": "__pos__", "_rc_abs": "__abs__"}

    def unary(name, on_integers, on_floats):
        def pick(st, a):
            info = record_of(a)
            if info is not None:
                method = info.methods.get(unary_dunders.get(name))
                return made("def impl(st, a):\n    return D(st, a)\n", D=method) if method else None
            return on_integers if integer(a) else on_floats if kind(a) == "f" else None

        register(name, pick)

    def neg(st, a):
        x = np.int64(a)
        if x == INT_MIN:
            st[0] = 1
            return np.int64(0)
        return -x

    def absolute(st, a):
        x = np.int64(a)
        if x == INT_MIN:
            st[0] = 1
            return np.int64(0)
        return -x if x < 0 else x

    def truncate(st, a):
        if not -9.2e18 < a < 9.2e18:
            st[0] = 1
            return np.int64(0)
        return np.int64(a)

    def square(st, a):
        result = a * a
        if math.isinf(result) and not math.isinf(a):
            st[0] = 1
        return result

    def square_integer(st, a):
        x = np.int64(a)
        product = float(x) * float(x)
        if not product < limit:
            st[0] = 1
            return np.int64(0)
        return x * x

    def popcount(st, a):
        x, count = np.int64(a), 0
        if x == INT_MIN:
            return 1
        if x < 0:
            x = -x
        while x:
            x &= x - 1
            count += 1
        return count

    def sqrt(st, a):
        x = float(a)
        if x < 0.0:
            st[0] = 1
            return 0.0
        return math.sqrt(x)

    def step(st, a):
        x = np.int64(a)
        if x == 0:
            st[0] = 1
            return np.int64(1)
        return x

    unary("_rc_neg", neg, lambda st, a: -a)
    unary("_rc_pos", lambda st, a: np.int64(a), lambda st, a: a)
    unary("_rc_inv", lambda st, a: ~np.int64(a), None)
    unary("_rc_abs", absolute, lambda st, a: math.fabs(a))
    unary("_rc_int", lambda st, a: np.int64(a), truncate)
    unary("_rc_sq", square_integer, square)

    def int_power(st, a, b):
        x, y = np.int64(a), np.int64(b)
        if y < 0:
            # Python returns a float here, so the result type would depend on the value.
            st[0] = 1
            return np.int64(0)
        result = np.int64(1)
        while y > 0:
            if y & 1:
                product = float(result) * float(x)
                if not -limit < product < limit:
                    st[0] = 1
                    return np.int64(0)
                result *= x
            y >>= 1
            if y:
                square = float(x) * float(x)
                if not square < limit:
                    st[0] = 1
                    return np.int64(0)
                x *= x
        return result

    def float_power(st, a, b):
        x, y = float(a), float(b)
        if x == 0.0 and y < 0.0 and math.isfinite(y):
            # ZeroDivisionError in Python. Zero to the power of -inf is inf.
            st[0] = 1
            return 0.0
        if x < 0.0 and math.isfinite(x) and math.isfinite(y) and np.floor(y) != y:
            # A complex result in Python.
            st[0] = 1
            return 0.0
        result = x ** y
        if math.isinf(result) and math.isfinite(x) and math.isfinite(y):
            # OverflowError in Python.
            st[0] = 1
        return result

    binary("_rc_pow", int_power, float_power)
    unary("_rc_popcount", popcount, None)
    unary("_rc_sqrt", sqrt, sqrt)
    unary("_rc_fabs", lambda st, a: math.fabs(float(a)), lambda st, a: math.fabs(a))
    unary("_rc_step", step, None)
    for name in TRANSCENDENTAL:
        # Python raises where the C function returns NaN from a non-NaN argument or an
        # infinity from a finite one. Flagging those cases hands them to Python.
        scope = {"math": math, "__name__": __name__}
        exec(f"""def impl(st, a):
    x = float(a)
    r = math.{name}(x)
    if (math.isnan(r) and not math.isnan(x)) or (math.isinf(r) and not math.isinf(x)):
        st[0] = 1
    return r
""", scope)
        unary(f"_rc_{name}", scope["impl"], scope["impl"])

    # Python's min and max return one of their arguments unchanged, so the compiled
    # version only accepts arguments of one type.
    register("_rc_min", lambda st, a, b: (lambda st, a, b: b if b < a else a)
             if number(a) and kind(a) == kind(b) else None)
    register("_rc_max", lambda st, a, b: (lambda st, a, b: b if b > a else a)
             if number(a) and kind(a) == kind(b) else None)

    def append(st, target, value):
        target.append(value)

    # Bounds are checked with one unsigned comparison: a negative position, after
    # adding the length, becomes a huge unsigned number. With Numba 0.68 / LLVM 20,
    # two signed comparisons kept loops from being optimised and made checked
    # reads about 70 times slower.
    def setitem(st, target, index, value):
        size = len(target)
        position = index + size if index < 0 else index
        if np.uint64(position) >= np.uint64(size):
            st[0] = 1
        else:
            target[position] = value

    def getitem_or(default):
        def getitem(st, target, index):
            size = len(target)
            position = index + size if index < 0 else index
            if np.uint64(position) >= np.uint64(size):
                st[0] = 1
                return default
            return target[position]

        return getitem

    defaults = {"f": getitem_or(0.0), "i": getitem_or(0), "b": getitem_or(False)}

    def vector(target):
        """A list, or a one-dimensional array standing in for a list argument."""
        return isinstance(target, types.List) or (isinstance(target, types.Array) and target.ndim == 1)

    # Numba's own list reads and stores check bounds and raise IndexError, which falls
    # back, so lists skip the extra check. Arrays and tuples have no such check.
    def list_read(st, target, index):
        return target[index]

    def list_store(st, target, index, value):
        target[index] = value

    def record_item(target, method, arity):
        info = record_of(target)
        if info is None or method not in info.methods:
            return None
        names = ", ".join(("st", "target", "index", "value")[:arity])
        return made(f"def impl({names}):\n    return D({names})\n", D=info.methods[method])

    def row_reader(info):
        """``columns[index]``: a record of one row. An attribute compiled code assigns
        is a one-item view of its column, so the store lands in the column."""
        items = "".join(f", target[{1 + position}][at:at + 1]" if field in info.boxed
                        else f", target[{1 + position}][at]" for position, field in enumerate(info.fields))
        return made("def impl(st, target, index):\n"
                    "    size = len(target[0])\n"
                    "    at = index + size if index < 0 else index\n"
                    "    if np.uint64(at) >= np.uint64(size):\n"
                    "        st[0] = 1\n"
                    "        at = 0\n"
                    f"    return NT(np.int64(target[0][at]){items})\n", NT=info.nt)

    def pick_getitem(st, target, index):
        if record_of(target) is not None:
            return record_item(target, "__getitem__", 3)
        if kind(index) != "i":
            return None
        if columns_of(target) is not None:
            return row_reader(columns_of(target))
        if isinstance(target, types.List):
            return list_read
        if vector(target) or isinstance(target, types.UniTuple):
            return defaults.get(kind(target.dtype))
        return None

    def pop_or(default):
        def pop(st, target, index):
            size = len(target)
            if index < -size or index >= size:
                st[0] = 1
                return default
            return target.pop(index + size if index < 0 else index)

        return pop

    pops = {"f": pop_or(0.0), "i": pop_or(0), "b": pop_or(False)}

    def insert(st, target, index, value):
        target.insert(index, value)

    # Numba would silently convert a float stored into a list of ints.
    register("_rc_append", lambda st, target, value: append if isinstance(target, types.List)
             and kind(target.dtype) == kind(value) else None)
    register("_rc_insert", lambda st, target, index, value: insert if isinstance(target, types.List)
             and kind(index) == "i" and kind(target.dtype) == kind(value) else None)
    register("_rc_pop", lambda st, target, index: pops.get(kind(target.dtype)) if isinstance(target, types.List)
             and kind(index) == "i" else None)
    register("_rc_setitem", lambda st, target, index, value: record_item(target, "__setitem__", 4)
             if record_of(target) is not None else (
        list_store if isinstance(target, types.List) else setitem) if vector(target)
             and kind(index) == "i" and kind(target.dtype) == kind(value) else None)
    register("_rc_samelist", lambda st, target, value: (lambda st, target, value: value)
             if isinstance(target, types.List) and isinstance(value, types.List)
             and kind(target.dtype) == kind(value.dtype) else None)
    register("_rc_getitem", pick_getitem)
    _install_column_rows()

    constant_reads = {}

    def pick_index(st, target, index):
        """``target[k]`` for a constant ``k``: a tuple item, which may differ in type from
        the others, or a checked read from a list or array."""
        if record_of(target) is not None:
            return record_item(target, "__getitem__", 3)
        if columns_of(target) is not None:
            return row_reader(columns_of(target)) if kind(index) == "i" else None
        if not isinstance(index, types.IntegerLiteral):
            return None
        position = index.literal_value
        # Numba checks list bounds itself and raises IndexError, so lists read directly.
        if isinstance(target, (types.BaseTuple, types.List)):
            if isinstance(target, types.BaseTuple) and not -len(target) <= position < len(target):
                return None
            if position not in constant_reads:
                scope = {"__name__": __name__}
                exec(f"def read(st, target, index):\n    return target[{position}]\n", scope)
                constant_reads[position] = scope["read"]
            return constant_reads[position]
        if vector(target):
            return defaults.get(kind(target.dtype))
        return None

    register("_rc_index", pick_index, prefer_literal=True)

    def unpack_length(st, target, count):
        if len(target) != count:
            st[0] = 1

    register("_rc_unpack", lambda st, target, count: unpack_length if isinstance(
        target, (types.BaseTuple, types.List, types.Array)) and record_of(target) is None
        and columns_of(target) is None else None)

    # Attribute, method and constructor overloads are made one per name, because a
    # string argument loses its literal type when Numba inlines the caller.
    def field_position(obj, field):
        info = record_of(obj)
        if info is None or field not in info.fields:
            return None, None
        return info, 1 + info.fields.index(field)

    def getattr_for(field):
        def pick(st, obj):
            info, position = field_position(obj, field)
            if info is None:
                return None
            boxed = "[0]" if field in info.boxed else ""
            return made(f"def impl(st, obj):\n    return obj[{position}]{boxed}\n")
        return pick

    def setattr_for(field):
        def pick(st, obj, value):
            info, position = field_position(obj, field)
            if info is None or field not in info.boxed or kind(obj.types[position].dtype) != kind(value):
                return None
            return made(f"def impl(st, obj, value):\n    obj[{position}][0] = value\n")
        return pick

    def method_for(method):
        def pick(st, obj, args):
            count = len(args)
            info = record_of(obj)
            # Spelled out: Numba cannot inline a call that passes *args.
            spread = ", ".join(f"args[{index}]" for index in range(count))
            if info is not None:
                target = info.methods.get(method)
                return made(f"def impl(st, obj, args):\n    return D(st, obj{', ' if spread else ''}{spread})\n",
                            D=target) if target else None
            if isinstance(obj, types.List):
                calls = {("append", 1): ("_rc_append", spread), ("insert", 2): ("_rc_insert", spread),
                         ("pop", 1): ("_rc_pop", spread), ("pop", 0): ("_rc_pop", "-1")}
                found = calls.get((method, count))
                if found:
                    return made(f"def impl(st, obj, args):\n    return D(st, obj, {found[1]})\n",
                                D=library[found[0]])
            return None
        return pick

    def make_for(token):
        def pick(st, values):
            info = _RECORD_TOKENS.get(token)
            if info is None:
                return None
            items = ", ".join(f"np.array([values[{index}]])" if field in info.boxed else f"values[{index}]"
                              for index, field in enumerate(info.fields))
            return made(f"def impl(st, values):\n    return NT(-1{', ' if items else ''}{items})\n", NT=info.nt)
        return pick

    def slice_for(text):
        def pick(st, target):
            info = columns_of(target)
            if info is None:
                return None if record_of(target) is not None else made(
                    f"def impl(st, target):\n    return target[{text}]\n")
            if text.split(":")[2]:
                return None
            # The same objects in a new list: views, so attribute stores reach them.
            items = ", ".join(f"target[{position}][{text}]" for position in range(len(info.fields) + 1))
            return made(f"def impl(st, target):\n    return C({items})\n", C=info.columns)
        return pick

    def blank_for(key):
        token, letters = key.rsplit("|", 1)

        def pick(st, count):
            info = _RECORD_TOKENS.get(token)
            if info is None or not integer(count):
                return None
            # Ids of -1: objects made in compiled code. Every row is filled before it
            # is read (see _object_fills), so the columns start uninitialised.
            items = "".join(f", np.empty(size, dtype=np.{DTYPES[letter]})" for letter in letters)
            return made("def impl(st, count):\n"
                        "    size = max(np.int64(count), 0)\n"
                        f"    return C(np.full(size, -1, dtype=np.int32){items})\n", C=info.columns)
        return pick

    def fill_for(key):
        token, letters = key.rsplit("|", 1)

        def pick(st, target, index, values):
            info = _RECORD_TOKENS.get(token)
            if (info is None or columns_of(target) is None or target.instance_class is not info.columns
                    or not isinstance(values, types.BaseTuple) or not integer(index)):
                return None
            found = tuple(map(kind, values.types))
            if len(found) != len(letters) or any(letter not in ("f", "i", "b") for letter in found):
                return None
            if found != tuple(letters):
                # The columns were made for other number types: ask for a rebuild.
                _RETYPE[token] = found
                return None
            body = "".join(f"    target[{1 + position}][index] = values[{position}]\n"
                           for position in range(len(letters)))
            return made(f"def impl(st, target, index, values):\n{body}")
        return pick

    pickers = {"getattr": getattr_for, "setattr": setattr_for, "method": method_for, "make": make_for,
               "slice": slice_for, "blank": blank_for, "fill": fill_for}
    named_stubs = {}

    def named(family, name):
        """The overload for one attribute, method or class token, made once."""
        key = family, name
        if key not in named_stubs:
            stub_name = f"_rc_{family}__{name}"
            register(stub_name, pickers[family](name))
            named_stubs[key] = library.pop(stub_name)
        return named_stubs[key]

    library["_named"] = named
    library["_rc_int64"] = np.int64

    def fail(st):
        st[0] = 1

    # Numba folds len() of a tuple into a constant, so a record would report its
    # field count. Records have no length.
    # Always inlined: a loop bound computed by a call that receives the status array
    # lets LLVM assume the array may change anywhere, so it rereads the flag on every
    # step and cannot vectorise. With Numba 0.68 that made such loops 100x slower.
    register("_rc_len", lambda st, value: None if record_of(value) is not None else (
        (lambda st, value: len(value[0])) if columns_of(value) is not None else (lambda st, value: len(value))),
        inline="always")

    register("_rc_fail", lambda st: fail)

    def not_float(st, a):
        st[0] = 1
        return 0.0

    def settled(st, a, pending):
        if pending:
            st[0] = 1
        return a

    register("_rc_floatonly", lambda st, a: (lambda st, a: a) if kind(a) == "f" else not_float if number(a) else None)
    register("_rc_settled", lambda st, a, pending: settled if kind(a) == "f" else None)

    def moveslice(st, target, d, e, f, a, b, c):
        size = len(target)
        t0, t1, ts = slice(a, b, c).indices(size)
        s0, s1, ss = slice(d, e, f).indices(size)
        count = len(range(t0, t1, ts))
        if count > 0 and count == len(range(s0, s1, ss)) and ts == -ss and t0 == s0 + (count - 1) * ss:
            # The destination is the source reversed, so swapping pairs gives the
            # same list as Python's copy-then-assign.
            for k in range(count // 2):
                x, y = t0 + k * ts, t0 + (count - 1 - k) * ts
                value = target[x]
                target[x] = target[y]
                target[y] = value
            return
        target[slice(a, b, c)] = target[slice(d, e, f)]

    def array_moveslice(st, target, d, e, f, a, b, c):
        """The same on an array, which cannot change length: a different count falls back."""
        size = len(target)
        t0, t1, ts = slice(a, b, c).indices(size)
        s0, s1, ss = slice(d, e, f).indices(size)
        count = len(range(t0, t1, ts))
        if count != len(range(s0, s1, ss)):
            st[0] = 1
            return
        if count > 0 and ts == -ss and t0 == s0 + (count - 1) * ss:
            for k in range(count // 2):
                x, y = t0 + k * ts, t0 + (count - 1 - k) * ts
                value = target[x]
                target[x] = target[y]
                target[y] = value
            return
        held = np.empty(count, dtype=target.dtype)
        for k in range(count):
            held[k] = target[s0 + k * ss]
        for k in range(count):
            target[t0 + k * ts] = held[k]

    def arange(st, a, b, c):
        if c == 0:
            st[0] = 1
            return np.empty(0, dtype=np.int64)
        return np.arange(np.int64(a), np.int64(b), np.int64(c))

    def full(st, n, value):
        return np.full(max(np.int64(n), 0), value)

    def rotate(st, target, i, j):
        """``target.insert(i, target.pop(j))`` without changing the length."""
        size = len(target)
        if j < 0:
            j += size
        if j < 0 or j >= size:
            st[0] = 1
            return
        value = target[j]
        shorter = size - 1
        if i < 0:
            i += shorter
            if i < 0:
                i = 0
        elif i > shorter:
            i = shorter
        if i < j:
            for k in range(j, i, -1):
                target[k] = target[k - 1]
        else:
            for k in range(j, i):
                target[k] = target[k + 1]
        target[i] = value

    register("_rc_arange", lambda st, a, b, c: arange if integer(a) and integer(b) and integer(c) else None)
    register("_rc_full", lambda st, n, value: full if integer(n) and number(value) else None)
    register("_rc_copy", lambda st, source: (lambda st, source: source.copy())
             if isinstance(source, types.Array) else None)
    register("_rc_rotate", lambda st, target, i, j: rotate if isinstance(target, types.Array)
             and integer(i) and integer(j) else None)

    def bound(item):
        return kind(item) in ("i", "none")

    general_array_move = njit(array_moveslice)

    def array_flip(st, target, d, e, f, a, b, c):
        """``target[:b] = target[d::-1]`` on an array: reverse the first b items."""
        size = len(target)
        stop = b + size if b < 0 else b
        stop = 0 if stop < 0 else size if stop > size else stop
        start = d + size if d < 0 else d
        start = size - 1 if start >= size else start
        if f != -1 or start < -1 or start + 1 != stop:
            general_array_move(st, target, d, e, f, a, b, c)
            return
        i, j = 0, start
        while i < j:
            value = target[i]
            target[i] = target[j]
            target[j] = value
            i += 1
            j -= 1

    def pick_moveslice(st, target, d, e, f, a, b, c):
        if not (vector(target) and all(map(bound, (a, b, c, d, e, f)))):
            return None
        if isinstance(target, types.List):
            return moveslice
        none = kind(types.none)
        if (kind(a), kind(c), kind(e)) == (none, none, none) and kind(b) == kind(d) == kind(f) == "i":
            return array_flip
        return array_moveslice

    register("_rc_moveslice", pick_moveslice)

    def unstable(result):
        """True if type inference merged different types where Python keeps them apart.

        A merge of an int into a float, which is what ``total = 0`` followed by
        ``total += x`` with float ``x`` gives, is returned as the set of variable
        names, so they can be promoted to guarded floats. Anything else is True.
        """
        annotation = result.type_annotation
        types_of = annotation.typemap
        merged = set()

        def is_array(variable):
            return isinstance(variable, ir.Var) and isinstance(types_of.get(variable.name), types.Array)

        def is_record(variable):
            return isinstance(variable, ir.Var) and record_of(types_of.get(variable.name)) is not None

        # The arrays of a column list. Reading a row slices one to a one-item view, so a
        # store into an attribute lands in the column; that slice is the lifter's own.
        column_arrays, grew = set(), True
        while grew:
            grew = False
            for block in annotation.blocks.values():
                for statement in block.body:
                    if not isinstance(statement, ir.Assign) or statement.target.name in column_arrays:
                        continue
                    value = statement.value
                    source = value if isinstance(value, ir.Var) else getattr(value, "value", None) if (
                        isinstance(value, ir.Expr) and value.op in ("static_getitem", "getitem", "getattr")) else None
                    if isinstance(source, ir.Var) and (
                            source.name in column_arrays if isinstance(value, ir.Var)
                            else columns_of(types_of.get(source.name)) is not None):
                        column_arrays.add(statement.target.name)
                        grew = True

        for block in annotation.blocks.values():
            for statement in block.body:
                # An array stands in for a list argument. Slicing it, doing arithmetic
                # or comparisons on it would follow NumPy rules, not Python's.
                # A slice assignment into an array would follow NumPy rules. Stores by
                # index come from the checked overloads, which are inlined here.
                if isinstance(statement, (ir.SetItem, ir.StaticSetItem)) and is_record(statement.target):
                    return True
                if isinstance(statement, ir.SetItem) and is_array(statement.target) and isinstance(
                        types_of.get(statement.index.name), types.SliceType):
                    return True
                if isinstance(statement, ir.StaticSetItem) and is_array(statement.target) and isinstance(
                        statement.index, slice):
                    return True
                if not isinstance(statement, ir.Assign):
                    continue
                value, sources = statement.value, []
                if isinstance(value, ir.Expr):
                    # A record is a namedtuple to Numba, but indexing, measuring, comparing
                    # or testing one would follow tuple rules, not the class's.
                    if value.op in ("binop", "inplace_binop") and (is_record(value.lhs) or is_record(value.rhs)):
                        return True
                    if value.op == "unary" and is_record(value.value):
                        return True
                    if value.op == "call" and any(map(is_record, value.args)) and getattr(
                            types_of.get(value.func.name), "typing_key", None) in (bool, len):
                        return True
                    if value.op in ("getitem", "static_getitem") and is_array(value.value):
                        if isinstance(types_of[statement.target.name], types.Array) and (
                                value.value.name not in column_arrays):
                            return True
                    if value.op in ("binop", "inplace_binop") and (is_array(value.lhs) or is_array(value.rhs)):
                        return True
                    if value.op == "unary" and is_array(value.value):
                        return True
                    # The truth of a list is whether it has items; of an array, its elements.
                    if value.op == "call" and any(map(is_array, value.args)) and getattr(
                            types_of.get(value.func.name), "typing_key", None) is bool:
                        return True
                if isinstance(value, ir.Var):
                    sources = [value]
                elif isinstance(value, ir.Expr) and value.op == "phi":
                    sources = value.incoming_values
                elif isinstance(value, ir.Expr) and value.op == "cast":
                    sources = [value.value]
                elif isinstance(value, ir.Expr) and value.op == "build_list":
                    target = types_of[statement.target.name]
                    if any(kind(types_of[item.name]) != kind(target.dtype) for item in value.items):
                        return True
                    continue
                target_type = types_of[statement.target.name]
                allowed = {kind(target_type)}
                if isinstance(target_type, types.Optional):
                    # The flow check rules out a None return in a function that returns
                    # values. None can only come from leaving a loop because a check
                    # failed, and that result is discarded.
                    allowed = {kind(target_type.type), kind(types.none)}
                for source in sources:
                    if not isinstance(source, ir.Var):
                        return True
                    found = kind(types_of[source.name])
                    if found in allowed:
                        continue
                    if found == "i" and allowed == {"f"} and (isinstance(value, ir.Var) or value.op == "phi"):
                        merged.add(statement.target.unversioned_name)
                        continue
                    return True
        return merged or False

    rounding = library["_rc_floordiv"], library["_rc_mod"]

    def gpu_unsafe(result):
        """True if the function needs something the GPU cannot do, or does differently.

        Lists need dynamic memory. Float floor division and remainder give different
        results on the GPU for some infinite and signed-zero cases.
        """
        annotation = getattr(result, "type_annotation", None)
        if not hasattr(annotation, "typemap"):
            # Loaded from the disk cache, so there is nothing to inspect.
            return True
        types_of = annotation.typemap
        # Batches never pass arrays in, so an array here is a local list made into one.
        if any(isinstance(item, (types.List, types.ListType)) or (isinstance(item, types.Array) and STATUS not in name)
               for name, item in types_of.items()):
            return True
        for block in annotation.blocks.values():
            for call in block.find_exprs("call"):
                if getattr(types_of[call.func.name], "typing_key", None) in rounding:
                    if any(kind(types_of[arg.name]) == "f" for arg in call.args):
                        return True
        return False

    return library, unstable, NumbaError, kind, gpu_unsafe


@functools.cache
def _math_agrees():
    """Names of the math functions whose compiled results match Python's here.

    The answer is kept in the cache directory, so later runs skip the test.
    """
    folder = _cache_dir()
    saved = folder and folder / f"selftest-{_runtime_key()[:24]}.json"
    if saved:
        try:
            return frozenset(json.loads(saved.read_text(encoding="utf-8")))
        except (OSError, ValueError):
            pass
    agreed = _run_math_selftest()
    if saved:
        try:
            _write_once(saved, json.dumps(sorted(agreed)))
        except OSError:
            pass
    return agreed


def _run_math_selftest():
    """Run each function on fixed values, compiled and in Python, and compare.

    Each function runs on a fixed set of ordinary and edge values, compiled and in
    Python. It passes if every result is bit-identical, and the compiled error rule
    flags exactly the values for which Python raises.
    """
    import numpy as np

    _start_numba()
    from numba import njit

    rng = __import__("random").Random(12345)
    values = [0.0, -0.0, 1.0, -1.0, 0.5, -0.5, 2.0, 1e-310, -1e-310, 5e-324, 1e-300, 1e300, -1e300,
              709.78, 709.79, -745.2, -745.1, 710.5, -710.5, 1.7976931348623157e308, float("inf"),
              float("-inf"), float("nan"), math.pi / 2, math.pi, 1e16, -1e16]
    values += [rng.uniform(-10.0, 10.0) for _ in range(4000)] + [rng.uniform(-1.0, 1.0) for _ in range(2000)]
    values += [math.ldexp(rng.random(), rng.randint(-1074, 1023)) * rng.choice((-1, 1)) for _ in range(4000)]
    source = "def run(x, out):\n    for i in range(len(x)):\n" + "".join(
        f"        out[{index}, i] = math.{name}(x[i])\n" for index, name in enumerate(TRANSCENDENTAL))
    scope = {"math": math}
    exec(source, scope)
    inputs = np.array(values)
    out = np.empty((len(TRANSCENDENTAL), len(values)))
    njit(scope["run"])(inputs, out)
    agreed = set()
    if _power_agrees(values):
        agreed.add("pow")
    for index, name in enumerate(TRANSCENDENTAL):
        function, ok = getattr(math, name), True
        for x, r in zip(values, out[index].tolist()):
            flagged = (math.isnan(r) and not math.isnan(x)) or (math.isinf(r) and not math.isinf(x))
            try:
                expected = function(x)
            except (ValueError, OverflowError):
                ok = flagged
            else:
                ok = not flagged and same(expected, r)
            if not ok:
                break
        if ok:
            agreed.add(name)
    return agreed


def _power_agrees(values):
    """True if the compiled ``**`` matches Python, results and errors, on pairs of values."""
    import numpy as np

    _start_numba()
    from numba import njit

    power = _runtime()[0]["_rc_pow"]
    exponents = [0.0, -0.0, 1.0, -1.0, 2.0, -2.0, 0.5, -0.5, 1.5, -1.5, 3.0, 1 / 3, 7.0, 2.5, 1e300, -1e300,
                 float("inf"), float("-inf"), float("nan")]
    pairs = [(x, y) for x in values[:40] for y in exponents] + list(zip(values, reversed(values)))

    @njit
    def run(xs, ys, out, flags):
        status = np.zeros(1, dtype=np.uint8)
        for i in range(len(xs)):
            status[0] = 0
            out[i] = power(status, xs[i], ys[i])
            flags[i] = status[0]

    xs, ys = (np.array(column) for column in zip(*pairs))
    out, flags = np.empty(len(pairs)), np.zeros(len(pairs), dtype=np.uint8)
    run(xs, ys, out, flags)
    for (x, y), r, flagged in zip(pairs, out.tolist(), flags.tolist()):
        try:
            expected = x ** y
        except (ZeroDivisionError, OverflowError):
            expected = None
        if type(expected) is not float:
            if not flagged:
                return False
        elif flagged or not same(expected, r):
            return False
    return True


@functools.cache
def _gpu_ready():
    from .benchmark import cuda_device

    return cuda_device()[0] is not None


@contextlib.contextmanager
def _gpu_compile():
    """Work around two Numba behaviours while a GPU kernel compiles.

    The GPU compiler fuses a multiply and an add into one rounding step, which changes
    the last bit of a result. Numba has no switch for that, so the option is added
    where Numba hands code to the NVIDIA compiler.

    Numba also keeps one lowering entry per intrinsic and argument types. A GPU
    compile can replace an entry the CPU compiler relies on, after which unrelated
    CPU functions stop compiling. The entries are put back afterwards.
    """
    from numba.core.typing import templates
    from numba.cuda.cudadrv import nvvm

    original = nvvm.compile_ir
    intrinsics = [(template, dict(template._impl_cache), dict(template._overload_cache))
                  for template in getattr(templates, "_IntrinsicTemplate", type).__subclasses__()
                  if isinstance(getattr(template, "_overload_cache", None), dict)]

    def compile_ir(llvmir, **options):
        if not options.get("fastmath"):
            options["fma"] = False
        return original(llvmir, **options)

    nvvm.compile_ir = compile_ir
    try:
        yield
    finally:
        nvvm.compile_ir = original
        for template, impl_cache, overload_cache in intrinsics:
            template._impl_cache.update(impl_cache)
            template._overload_cache.update(overload_cache)


class Lifted:
    """A compiled stand-in for ``original`` that falls back whenever it cannot be sure."""

    def __init__(self, fn):
        if not isinstance(fn, FunctionType):
            raise Unsupported("only plain Python functions can be lifted")
        import numpy as np

        _start_numba()
        from numba import njit

        self._library, self._unstable, self._compile_error, self._kind, self._gpu_unsafe = _runtime()
        self.original, self._promote, self._records = fn, {}, _Records()
        self._verdicts, self._verdict_file = {}, None
        self._list_cache = _ListCache()
        self._build()
        # Parameters the body never reads travel as None, whatever they hold.
        node = self._unit.source(fn)
        read = {item.id for item in ast.walk(node) if isinstance(item, ast.Name) and isinstance(item.ctx, ast.Load)}
        self._unused = [index for index, arg in enumerate(node.args.posonlyargs + node.args.args)
                        if arg.arg not in read]
        self._flag = np.zeros(1, dtype=np.uint8)
        self.compiled_calls = self.fallback_calls = 0
        self.gpu_note = None

    def _build(self):
        """Generate and load the compiled module, promoting the variables in ``_promote``."""
        from numba import njit

        self._unit, self._shapes, self._drivers, self.choices = _Unit(self._promote, self._records), {}, {}, {}
        self._root = self._unit.function(self.original)
        # Lift the methods of every class met so far; that can meet more classes.
        done = set()
        while len(done) < len(self._records.infos):
            for info in list(self._records.infos.values()):
                if info.cls not in done:
                    done.add(info.cls)
                    info.mangled, info.problems = {}, {}
                    self._unit.methods(info)
        for info in self._records.infos.values():
            info.boxed = frozenset(info.fields).intersection(self._unit.written)
        differs = sorted((self._unit.math_guards.intersection(TRANSCENDENTAL)
                          | ({"pow"} if self._unit.uses_pow else set())) - _math_agrees())
        if differs:
            raise Unsupported(f"math.{differs[0]} gives different results when compiled on this machine")
        module = ast.fix_missing_locations(ast.Module(body=self._unit.definitions, type_ignores=[]))
        self._code = compile(module, f"<recompyler:{self.original.__name__}>", "exec")
        # Helpers and methods are inlined into their callers at Numba's level. A call
        # between compiled functions passes records by value, with a reference-count
        # update for every array they hold.
        root = self._root
        self.source = ast.unparse(module)
        self._name_records()
        cache = self._module_file() is not None
        # Whether Numba may cache is known only once the module file has loaded.
        loaded = self._load(lambda function, cached: njit(function, cache=cached) if function.__name__ == root
                            else njit(function, inline="always", cache=cached), cache=cache)
        self._dispatchers = list(loaded.values())
        self._owners = {mangled: key for key, mangled in self._unit.functions.items()}
        self._names = list(loaded)
        self._compiled = loaded[self._root]
        for info in self._records.infos.values():
            info.methods = {name: loaded[mangled] for name, mangled in info.mangled.items()}
        # An earlier run found that made lists of these classes hold other number
        # types than this build assumed: build again with those.
        saved, infos = self._verdicts.get("retype"), list(self._records.infos.values())
        if type(saved) is list and len(saved) == len(infos):
            changed = False
            for info, letters in zip(infos, saved):
                wanted = tuple(letters) if type(letters) is str else None
                if (wanted is not None and wanted != info.kinds and wanted not in info.tried
                        and len(wanted) == len(info.fields) and set(wanted) <= set(DTYPES)):
                    info.tried.add(info.kinds)
                    info.kinds, changed = wanted, True
            if changed:
                self._build()

    def _load(self, decorate, cache=False):
        """Run the generated module and compile each function with ``decorate``.

        With ``cache``, the module is written to a file named after a hash of its
        source, constants and the runtime, so Numba can keep the machine code on disk
        and a later run loads it instead of compiling. A changed value gives a new file.
        """
        scope = {name: value for name, value in self._library.items() if name != "_named"}
        scope.update(self._unit.constants.values())
        for (family, name), alias in self._unit.names.items():
            scope[alias] = self._library["_named"](family, name)
        scope["_rc_Fallback"] = _Fallback
        path = self._module_file() if cache else None
        self._verdicts, self._verdict_file = {}, None
        if path is not None:
            self._verdict_file = path.with_suffix(".verdicts.json")
            try:
                self._verdicts = json.loads(self._verdict_file.read_text(encoding="utf-8"))
            except (OSError, ValueError):
                self._verdicts = {}
            try:
                spec = importlib.util.spec_from_file_location(path.stem, path)
                module = importlib.util.module_from_spec(spec)
                module.__dict__.update(scope)
                # Numba's cache imports the module by name to rebuild a function's globals.
                sys.modules[path.stem] = module
                spec.loader.exec_module(module)
                scope = module.__dict__
            except Exception:
                path = None
        if path is None:
            # Marks the functions as RecomPyler's, as a cached module's name does.
            scope["__name__"] = "recompyler_generated"
            exec(self._code, scope)
        for name in self._unit.functions.values():
            scope[name] = decorate(scope[name], path is not None) if decorate.__code__.co_argcount == 2                 else decorate(scope[name])
        return {name: scope[name] for name in self._unit.functions.values()}

    def _gpu_blocked(self):
        """True if any compiled signature needs something the GPU cannot do. Code
        loaded from the disk cache has no types to inspect, so its saved verdict is used."""
        for name, item in zip(self._names, self._dispatchers):
            for signature, result in item.overloads.items():
                if hasattr(getattr(result, "type_annotation", None), "typemap"):
                    if self._gpu_unsafe(result):
                        return True
                elif self._verdicts.get(f"{name}|{signature}|gpu", True):
                    return True
        return False

    def _save_verdict(self, key, verdict):
        self._verdicts[key] = verdict
        if self._verdict_file is None:
            return
        try:
            partial = self._verdict_file.with_name(f"{self._verdict_file.name}.{os.getpid()}.tmp")
            partial.write_text(json.dumps(self._verdicts), encoding="utf-8")
            os.replace(partial, self._verdict_file)
        except OSError:
            pass

    def _name_records(self):
        """Name this build's record classes after everything their compiled code
        depends on: the generated source, the constants, and each class's attributes,
        which of them are assigned, and their number types in made lists.

        Two builds with the same name stem compile to the same code unless their
        classes are different objects, as when a class is defined again. Those get a
        different number, so each keeps its own record classes.
        """
        infos = list(self._records.infos.values())
        self._record_text = ""
        if not infos:
            return
        described = [(info.cls.__module__, info.cls.__qualname__, info.fields, sorted(info.boxed), info.kinds)
                     for info in infos]
        constants = sorted((name, _stable(value)) for name, value in self._unit.constants.values())
        stem = hashlib.sha256("\n".join((self.source, repr(constants), repr(described))).encode()).hexdigest()[:16]
        classes = tuple(info.cls for info in infos)
        issued = _ISSUED.setdefault(stem, [])
        for number, known in enumerate(issued):
            if len(known) == len(classes) and all(map(operator.is_, known, classes)):
                break
        else:
            number = len(issued)
            issued.append(classes)
        for position, info in enumerate(infos):
            info.name_types(f"{stem}_{number}_{position}")
        self._record_text = repr((described, number))

    def _module_file(self):
        folder = _cache_dir()
        if folder is None:
            return None
        constants = sorted((name, _stable(value)) for name, value in self._unit.constants.values())
        digest = hashlib.sha256("\n".join((self.source, repr(constants), self._record_text,
                                           _runtime_key())).encode()).hexdigest()
        path = folder / f"rc_{digest[:32]}.py"
        try:
            _write_once(path, self.source + "\n")
        except OSError:
            return None
        return path

    def _run(self, packed):
        """One compiled call. Returns (ok, result)."""
        self._flag[0] = 0
        result = self._compiled(self._flag, *packed)
        return not self._flag[0], result

    def _prepare(self, shape, packed):
        if len(self._shapes) >= MAX_SHAPES:
            return False
        before = {(id(item), signature) for item in self._dispatchers for signature in item.overloads}
        try:
            self._run(packed)
        except self._compile_error:
            if self._retype():
                # Saved beside this build's module, so a later process starts from
                # the right number types instead of failing to compile first.
                self._save_verdict("retype", ["".join(info.kinds) for info in self._records.infos.values()])
                self._build()
                return self._prepare(shape, packed)
            return False
        except Exception:
            pass
        merged = {}
        for name, item in zip(self._names, self._dispatchers):
            for signature, result in item.overloads.items():
                if (id(item), signature) in before:
                    continue
                key = f"{name}|{signature}"
                if not hasattr(getattr(result, "type_annotation", None), "typemap"):
                    # Loaded from the disk cache, which keeps no types to check: use
                    # the verdict saved when this signature was compiled and checked.
                    saved = self._verdicts.get(key)
                    if saved is None or saved == "unstable":
                        return False
                    verdict = set() if saved == "stable" else set(saved)
                else:
                    verdict = self._unstable(result)
                    self._save_verdict(key, "unstable" if verdict is True else sorted(verdict) if verdict else "stable")
                    self._save_verdict(f"{key}|gpu", bool(self._gpu_unsafe(result)))
                if verdict is True:
                    return False
                if verdict:
                    merged.setdefault(self._owners[name], set()).update(verdict)
        if not merged:
            return True
        if all(names <= self._promote.get(key, set()) for key, names in merged.items()):
            return False
        # Rebuild with those variables promoted to floats, then try this shape again.
        # Shapes prepared before are prepared again on their next call.
        for key, names in merged.items():
            self._promote.setdefault(key, set()).update(names)
        self._build()
        return self._prepare(shape, packed)

    def _retype(self):
        """True if a class's objects were stored into columns made for other number
        types, and the types the compiled code asked for have not been tried."""
        changed = False
        for info in self._records.infos.values():
            wanted = _RETYPE.pop(info.token, None)
            if wanted is not None and wanted != info.kinds and wanted not in info.tried:
                info.tried.add(info.kinds)
                info.kinds, changed = wanted, True
        return changed

    def _complete(self, args):
        """Positional arguments with defaults filled in, or None if the count is wrong."""
        missing = self.original.__code__.co_argcount - len(args)
        if missing == 0:
            return args
        defaults = self.original.__defaults__ or ()
        if 0 < missing <= len(defaults):
            return args + defaults[len(defaults) - missing:]
        return None

    def _pack_call(self, args):
        if self._unused:
            args = tuple(None if index in self._unused else value for index, value in enumerate(args))
        # Plain numbers and None travel as they are: the same result as ``_pack``
        # without walking each argument or making a boundary.
        kinds = tuple(map(type, args))
        shape = _scalar_shape(kinds)
        if shape and (int not in kinds or all(INT_MIN <= value <= INT_MAX for value in args if type(value) is int)):
            return args, shape, _NO_COPIES
        if list in kinds and tuple not in kinds and 0 < len(args) <= MAX_SEQUENCE:
            # Numbers and lists of numbers: what ``_pack`` gives, without its general walk.
            boundary = _Boundary(self._records, self._list_cache, self._unit.writes)
            packed, shapes = [], ["T"]
            for value, kind in zip(args, kinds):
                letter = _SCALAR_LETTERS.get(kind)
                if letter is not None and (kind is not int or INT_MIN <= value <= INT_MAX):
                    packed.append(value)
                    shapes.append(letter)
                    continue
                copied = boundary.copy(value) if kind is list else None
                if copied is None:
                    break
                packed.append(copied[0])
                shapes.append(copied[1])
            else:
                return tuple(packed), tuple(shapes), boundary
            # Something only the general walk handles. Copies made so far were never
            # given to compiled code, so cached ones are still good.
        for _ in range(MAX_SHAPES):
            boundary = _Boundary(self._records, self._list_cache, self._unit.writes)
            try:
                packed, shape = _pack(args, boundary)
            except _Reject:
                return None, None, None
            except _NeedClass as need:
                # A class met for the first time: lift its methods and start again.
                try:
                    self._records.register(need.cls)
                    self._build()
                except Unsupported:
                    return None, None, None
                continue
            return packed, shape, boundary
        return None, None, None

    def __call__(self, *args, **kwargs):
        full = None if kwargs else self._complete(args)
        packed, shape, boundary = self._pack_call(full) if full is not None else (None, None, None)
        if shape is not None:
            ready = self._shapes.get(shape)
            if ready is None:
                ready = self._shapes[shape] = self._prepare(shape, packed)
                # Compiling ran the function once on the copies. Start again from
                # the originals, with fresh copies.
                boundary.discard()
                packed, shape, boundary = self._pack_call(full)
            if ready and self._unit.guards_hold():
                try:
                    ok, result = self._run(packed)
                    if ok and self._records.infos:
                        result = boundary.rebuild(result)
                except Exception:
                    ok = False
                # A list argument travels as a tuple or an array. If one comes back,
                # it may be that argument, which Python would have returned as a list.
                if ok and _suspect_result(shape, result):
                    ok = self._shapes[shape] = False
                if ok and ((self._unit.writes and boundary.copies) or boundary.boxes or boundary.columns):
                    ok = boundary.write_back()
                if ok:
                    self.compiled_calls += 1
                    return result
                # The copies may hold changes that never reached the originals.
                boundary.discard()
        self.fallback_calls += 1
        return self.original(*args, **kwargs)

    def _driver(self, shape, packed, backend):
        """Compile a loop over rows of one shape for one backend.

        Each row gets its own status byte. A row whose check fails is flagged and
        answered by the original function afterwards.
        """
        from numba import njit, prange, typeof

        result = self._compiled.overloads.get((typeof(self._flag), *(typeof(value) for value in packed)))
        dtype = result and DTYPES.get(self._kind(result.signature.return_type))
        if dtype is None:
            return None
        counter = itertools.count()

        def expression(part):
            if type(part) is str:
                return f"c{next(counter)}[i]"
            return "(" + "".join(expression(item) + ", " for item in part[1:]) + ")"

        call = f"_rc_root(status[i:i + 1], {', '.join(expression(part) for part in shape[1:])})"
        columns = "".join(f", c{index}" for index in range(next(counter)))
        body = {"cpu": f"""
                for i in range(len(out)):
                    try:
                        out[i] = {call}
                    except Exception:
                        status[i] = 1""",
                "parallel": f"""
                for i in prange(len(out)):
                    out[i] = {call}""",
                "gpu": f"""
                i = grid(1)
                if i < out.size:
                    out[i] = {call}"""}[backend]
        source = f"def _rc_driver(out, status{columns}):{body}\n"
        scope = {"_rc_root": self._compiled, "prange": prange}
        if backend == "parallel":
            # Without this, idle OpenMP threads spin between batches and each
            # parallel call can stall for many milliseconds.
            os.environ.setdefault("OMP_WAIT_POLICY", "PASSIVE")
        if backend == "gpu":
            from numba import cuda

            scope.update(_rc_root=self._load(cuda.jit(device=True))[self._root], grid=cuda.grid)
            decorate = cuda.jit
        else:
            decorate = njit(parallel=backend == "parallel")
        exec(compile(textwrap.dedent(source), f"<recompyler:{self.original.__name__}:{backend}>", "exec"), scope)
        return decorate(scope["_rc_driver"]), dtype

    def _launch(self, backend, driver, out, status, arrays):
        if backend != "gpu":
            driver(out, status, *arrays)
            return
        from numba import cuda

        device_out, device_status = cuda.device_array_like(out), cuda.to_device(status)
        launch = driver[-(-len(out) // 128), 128]
        if driver.overloads:
            launch(device_out, device_status, *map(cuda.to_device, arrays))
        else:
            with _gpu_compile():
                launch(device_out, device_status, *map(cuda.to_device, arrays))
        device_out.copy_to_host(out)
        device_status.copy_to_host(status)

    def _batch(self, calls, backend):
        import numpy as np

        from_array = isinstance(calls, np.ndarray)
        if from_array:
            # Rows are already packed: one column per argument, no Python objects to unpack.
            if calls.ndim != 2 or not calls.shape[1] or DTYPES.get(calls.dtype.kind) != calls.dtype.name:
                raise _Reject
            packed, shape = _pack(tuple(calls[0].tolist()))
        else:
            packed, shape = _pack(calls[0])
        if _has(shape, "L") or _has(shape, "A") or _has(shape, "O"):
            raise _Reject
        ready = self._shapes.get(shape)
        if ready is None:
            ready = self._shapes[shape] = self._prepare(shape, packed)
        if not ready:
            raise _Reject
        if from_array:
            arrays = [np.ascontiguousarray(calls[:, index]) for index in range(calls.shape[1])]
        else:
            columns = []
            _columns(calls, shape, columns)
            try:
                arrays = [np.array(column, dtype=DTYPES[kind]) for kind, column in columns]
            except OverflowError:
                raise _Reject from None

        def run(backend):
            key = shape, backend
            if key not in self._drivers:
                self._drivers[key] = self._driver(shape, packed, backend)
            if self._drivers[key] is None:
                raise _Reject
            driver, dtype = self._drivers[key]
            out, status = np.empty(len(calls), dtype=dtype), np.zeros(len(calls), dtype=np.uint8)
            self._launch(backend, driver, out, status, arrays)
            return out, status

        def execute(backend):
            if self._unit.raises:
                # Compiled code raises to fall back, which only the CPU loop catches.
                backend = "cpu"
            if backend == "gpu":
                return self._gpu(shape, run)
            if backend == "parallel" and self._drivers.get((shape, "parallel-works")) is not False:
                try:
                    return run(backend)
                except _Reject:
                    raise
                except Exception:
                    self._drivers[shape, "parallel-works"] = False
            return run("cpu")

        out, status = self._choose(shape, len(calls), execute) if backend == "auto" else execute(backend)
        redo = np.flatnonzero(status).tolist()
        if from_array:
            values = [self.original(*calls[index].tolist()) for index in redo]
            if values:
                # A Python result that the array cannot hold exactly, such as an
                # integer past 64 bits, turns the output into an array of objects.
                if not all(type(value) is SCALARS[out.dtype.kind] for value in values) or any(
                        type(value) is int and not INT_MIN <= value <= INT_MAX for value in values):
                    out = out.astype(object)
                for index, value in zip(redo, values):
                    out[index] = value
            results = out
        else:
            results = out.tolist()
            for index in redo:
                results[index] = self.original(*calls[index])
        self.compiled_calls += len(calls) - len(redo)
        self.fallback_calls += len(redo)
        return results

    def _choose(self, shape, size, execute):
        """Run a batch on whichever backend measured fastest for batches of about this size.

        The first batch in each size range (rounded to a power of two) is run on every
        backend that works for this function, once to compile and once timed. Every
        backend returns the same values, so trying them costs time but nothing else.
        Timings include transfers to and from the GPU.
        """
        if size < AUTO_MINIMUM:
            return execute("cpu")
        key = shape, size.bit_length()
        if key in self.choices:
            return execute(self.choices[key]["backend"])
        seconds, results = {}, {}
        for backend in BACKENDS:
            execute(backend)
            if self._drivers.get((shape, "gpu-trusted" if backend == "gpu" else f"{backend}-works")) is False:
                continue
            start = perf_counter()
            results[backend] = execute(backend)
            seconds[backend] = perf_counter() - start
        best = min(seconds, key=seconds.get)
        self.choices[key] = {"backend": best, "rows": size, "seconds": seconds}
        return results[best]

    def _gpu(self, shape, run):
        """Run on the GPU, falling back to the CPU if it is unavailable or disagrees.

        The first GPU batch of each shape is also run on the CPU. The GPU is only
        trusted for that shape if both produce the same bytes and flag the same rows.
        """
        import numpy as np

        key = shape, "gpu-trusted"
        if self._drivers.get(key) is False:
            return run("cpu")
        if self._unit.math_guards.intersection(TRANSCENDENTAL) or self._unit.uses_pow:
            self._drivers[key] = False
            self.gpu_note = "the GPU's math library rounds sin, exp and similar functions differently"
            return run("cpu")
        if self._gpu_blocked():
            self._drivers[key] = False
            self.gpu_note = "the GPU path does not support lists or float // and %"
            return run("cpu")
        try:
            if not _gpu_ready():
                raise RuntimeError("CUDA is unavailable")
            out, status = run("gpu")
        except _Reject:
            raise
        except Exception as exc:
            self._drivers[key], self.gpu_note = False, f"GPU could not run this function ({type(exc).__name__})"
            return run("cpu")
        if key not in self._drivers:
            expected, expected_status = run("cpu")
            keep = expected_status == 0
            self._drivers[key] = bool(np.array_equal(status, expected_status)
                                      and out[keep].tobytes() == expected[keep].tobytes())
            if not self._drivers[key]:
                self.gpu_note = "GPU results differed from the CPU, so the GPU is not used"
                return expected, expected_status
        return out, status

    def map(self, calls, backend="cpu"):
        """``[fn(*args) for args in calls]``, run as one compiled loop when rows share a shape.

        ``backend`` is "cpu", "parallel" (all CPU cores), "gpu" (CUDA) or "auto". Every
        backend returns the same values. If the chosen one cannot run, the
        single-threaded CPU loop is used instead. "auto" times the backends on the
        first batch of each size range and then uses the fastest; ``choices`` records
        what it measured.

        ``calls`` can also be a 2-D float64, int64 or bool NumPy array with one row per
        call. That skips unpacking Python objects, and the result is an array.
        """
        if backend not in BACKENDS and backend != "auto":
            raise ValueError(f"backend must be one of {(*BACKENDS, 'auto')}")
        from_array = type(calls).__module__ == "numpy" and type(calls).__name__ == "ndarray"
        if not from_array:
            calls = list(calls)
        if len(calls) and self._unit.guards_hold():
            try:
                return self._batch(calls, backend)
            except _Reject:
                pass
        if not from_array:
            return [self(*args) for args in calls]
        import numpy as np

        if calls.ndim != 2:
            raise ValueError("an array of calls needs one row per call")
        values = [self(*args) for args in calls.tolist()]
        kinds = {type(value) for value in values}
        exact = len(kinds) == 1 and kinds <= {float, bool} or (
            kinds == {int} and all(INT_MIN <= value <= INT_MAX for value in values))
        results = np.empty(len(values), dtype=object)
        results[:] = values
        return results.astype(DTYPES[SCALARS_BY_TYPE[kinds.pop()]]) if exact else results

    def verify(self, calls):
        """Compare against the original on each argument tuple. Returns (checked, mismatches).

        Each side gets its own copy of the arguments, and the arguments it leaves
        behind are compared as well as the result.
        """
        checked, mismatches = 0, []
        for args in calls:
            outcomes = []
            for function in (self.original, self):
                given = copy.deepcopy(args)
                try:
                    outcomes.append((function(*given), given))
                except Exception as exc:
                    outcomes.append((type(exc), given))
            checked += 1
            if not same(*outcomes) and len(mismatches) < 10:
                mismatches.append((args, *outcomes))
        return checked, mismatches


def lift(fn):
    """Return a compiled equivalent of ``fn``, or raise Unsupported with the reason."""
    return Lifted(fn)
