"""Ahead-of-time builds: recommended functions compiled into an extension module,
so a later run calls them without importing Numba.

The profiler builds the module once, from the same generated code and argument
types it verified. At run time, ``AotLifted`` regenerates that code from the
script's current source, without compiling anything. It uses the module only if the
regenerated code and its constants hash to the value recorded at build time.
Guards, argument packing, write-back and the Python fallback work as in ``Lifted``.
"""

import ast
import functools
import hashlib
import importlib
from pathlib import Path
import sys
from types import FunctionType

from . import lift as _lift
from .lift import Lifted, Unsupported, _ListCache, _Records, _stable, _unwrap, _Unit


@functools.cache
def _lifter_key():
    """Changes whenever the lifter's code does; it decides what code is generated."""
    return hashlib.sha256(Path(_lift.__file__).read_bytes()).hexdigest()


def _digest(unit, source):
    """A hash of generated code and every constant baked into it."""
    constants = sorted((name, _stable(value)) for name, value in unit.constants.values())
    return hashlib.sha256("\n".join((source, repr(constants), _lifter_key())).encode()).hexdigest()


def _qualnames(fn, keys):
    """Map the unit's function keys (object ids) to names that survive a new process."""
    found = {}
    for key in keys:
        if key == id(fn):
            found[key] = fn.__qualname__
            continue
        for value in fn.__globals__.values():
            if id(_unwrap(value)) == key and isinstance(_unwrap(value), FunctionType):
                found[key] = _unwrap(value).__qualname__
                break
    return found


def build(entries, folder):
    """Compile every verified argument type of each lifted function into one module.

    ``entries`` holds (row key, function, lifted, sample arguments). Functions on
    objects of Python classes are left out: their records use classes generated in
    the profiling process. Returns the plan section, or None if nothing was built.
    """
    from numba import typeof
    from ._pycc import CC

    planned, exports = [], []
    for (name, line), fn, lifted, rows in entries:
        if lifted._records.infos:
            continue
        signatures = {}
        for args in rows:
            full = lifted._complete(args)
            if full is None:
                continue
            packed, shape, boundary = lifted._pack_call(full)
            if shape is None:
                continue
            boundary.discard()
            if lifted._shapes.get(shape) is not True:
                continue
            result = lifted._compiled.overloads.get((typeof(lifted._flag), *map(typeof, packed)))
            if result is not None:
                signatures[repr(shape)] = result.signature
        if not signatures:
            continue
        names = _qualnames(fn, lifted._promote)
        if len(names) != len(lifted._promote):
            continue
        exported = {}
        for shape, signature in signatures.items():
            export = f"f{len(exports)}"
            exports.append((export, signature, lifted._compiled.py_func))
            exported[shape] = export
        planned.append({"function": name, "line": line, "qualname": fn.__qualname__,
                        "digest": _digest(lifted._unit, lifted.source), "exports": exported,
                        "promote": {names[key]: sorted(value) for key, value in lifted._promote.items()}})
    if not planned:
        return None
    identity = hashlib.sha256(repr([(item["digest"], sorted(item["exports"].items())) for item in planned]).encode()
                              + repr([str(signature) for _, signature, _ in exports]).encode()
                              + sys.version.encode()).hexdigest()[:24]
    module = f"rcaot_{identity}"
    if not any(Path(folder).glob(f"{module}.*")):
        cc = CC(module)
        cc.output_dir = str(folder)
        cc.verbose = False
        for export, signature, function in exports:
            cc.export(export, signature)(function)
        cc.compile()
    return {"module": module, "folder": str(folder), "functions": planned}


class AotLifted(Lifted):
    """``Lifted`` with calls answered by an ahead-of-time module instead of Numba."""

    def __init__(self, fn, entry, module):
        import numpy as np

        if not isinstance(fn, FunctionType):
            raise Unsupported("only plain Python functions can be lifted")
        self.original = fn
        self._promote = {}
        for qualname, names in entry["promote"].items():
            target = fn if qualname == fn.__qualname__ else _unwrap(fn.__globals__.get(qualname))
            if not isinstance(target, FunctionType):
                raise Unsupported(f"'{qualname}' is not where it was when the module was built")
            self._promote[id(target)] = set(names)
        self._records, self._verdicts, self._verdict_file = _Records(), {}, None
        self._unit, self._drivers, self.choices = _Unit(self._promote, self._records), {}, {}
        self._root = self._unit.function(fn)
        if self._records.infos:
            raise Unsupported("objects of Python classes are compiled at run time")
        tree = ast.fix_missing_locations(ast.Module(body=self._unit.definitions, type_ignores=[]))
        self.source = ast.unparse(tree)
        if _digest(self._unit, self.source) != entry["digest"]:
            raise Unsupported("the function or its constants changed since the module was built")
        node = self._unit.source(fn)
        read = {item.id for item in ast.walk(node) if isinstance(item, ast.Name) and isinstance(item.ctx, ast.Load)}
        self._unused = [index for index, arg in enumerate(node.args.posonlyargs + node.args.args)
                        if arg.arg not in read]
        self._exports = {shape: getattr(module, export) for shape, export in entry["exports"].items()}
        self._list_cache = _ListCache()
        self._shapes, self._last, self._by_shape = {}, None, {}
        self._flag = np.zeros(1, dtype=np.uint8)
        self.compiled_calls = self.fallback_calls = 0
        self.gpu_note = None

    def _pack_call(self, args):
        packed, shape, boundary = super()._pack_call(args)
        self._last = shape
        return packed, shape, boundary

    def _prepare(self, shape, packed):
        # Only the argument types verified when the module was built are exported.
        # The plan stores them by the shape's text; look that up once per shape.
        found = self._exports.get(repr(shape))
        if found is not None:
            self._by_shape[shape] = found
        return found is not None

    def _run(self, packed):
        self._flag[0] = 0
        result = self._by_shape[self._last](self._flag, *packed)
        return not self._flag[0], result

    def map(self, calls, backend="cpu"):
        return [self(*args) for args in calls]


def load(section):
    """Import a built module from its plan section, or None if it cannot be loaded."""
    folder = section["folder"]
    added = folder not in sys.path
    if added:
        sys.path.insert(0, folder)
    try:
        return importlib.import_module(section["module"])
    except ImportError:
        return None
    finally:
        if added:
            sys.path.remove(folder)
