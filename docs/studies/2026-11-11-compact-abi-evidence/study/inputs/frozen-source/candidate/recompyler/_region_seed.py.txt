"""Versioned, non-executable inference seeds for region AOT deployment.

Only types, shared inference cells and binding descriptions are saved. Values are
always loaded from the live graph. Replaying a seed regenerates Python guards and
code; it does not authorize an export until the exact source/seed digest matches.
Unresolvable bindings (including local classes and closures) decline deployment.
"""
import hashlib
import json
from types import FunctionType, ModuleType

from .lift import Unsupported

VERSION = 1


class ExactExport(dict):
    """A failed seed reconstruction must never compile a speculative JIT variant."""
    def get(self, digest, default=None):
        if digest not in self:
            raise Unsupported("the regenerated AOT seed does not match its export")
        return self[digest]


def identity(seed):
    return hashlib.sha256(json.dumps(seed, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


def _literal(value):
    if value is None or type(value) in (bool, int, float, str, bytes):
        return (type(value).__name__, repr(value))
    if type(value) is tuple:
        return ("tuple", tuple(_literal(item) for item in value))
    raise Unsupported("an AOT seed requires plain immutable constants/defaults")


def _fingerprint(fn):
    code = fn.__code__
    if code.co_freevars and code.co_freevars != ("__class__",):
        raise Unsupported("an AOT seed cannot bind a closure")
    kwdefaults = fn.__kwdefaults__
    if kwdefaults is not None and (type(kwdefaults) is not dict
                                   or any(type(key) is not str for key in kwdefaults)):
        raise Unsupported("an AOT seed requires a plain keyword-default dictionary")
    parts = (code.co_code.hex(), _literal(code.co_consts), code.co_names,
             code.co_varnames, code.co_freevars, code.co_cellvars,
             getattr(code, "co_exceptiontable", b"").hex(), code.co_flags, code.co_argcount,
             code.co_posonlyargcount, code.co_kwonlyargcount,
             _literal(fn.__defaults__),
             sorted((key, _literal(value)) for key, value in (kwdefaults or {}).items()))
    return hashlib.sha256(repr(parts).encode()).hexdigest()


class Bindings:
    def __init__(self, entry):
        self.entry = entry

    def resolve(self, path):
        if path == ["$entry"]:
            return self.entry
        if not isinstance(path, list) or not path or not all(type(part) is str for part in path):
            raise Unsupported("invalid AOT binding")
        space = self.entry.__globals__
        value = None
        for index, part in enumerate(path):
            value = space.get(part)
            if index + 1 < len(path):
                if type(value) not in (type, ModuleType):
                    raise Unsupported("AOT binding is no longer a plain class/module")
                space = vars(value)
        # Arbitrary replacement objects must not get an attribute lookup merely
        # to reject a stale binding. Function dictionaries cannot run user hooks.
        if type(value) is FunctionType:
            original = value.__dict__.get("__recompyler_original__", value)
            if type(original) is not FunctionType:
                raise Unsupported("invalid wrapped AOT function")
            return original
        return value

    def ref(self, value):
        if value is self.entry:
            return ["$entry"]
        qualname = getattr(value, "__qualname__", "")
        if "<locals>" in qualname:
            raise Unsupported("an AOT seed cannot bind a local definition")
        paths = [[name] for name, item in self.entry.__globals__.items() if item is value]
        if qualname:
            parts = qualname.split(".")
            paths.append(parts)
            paths.extend([name] + parts for name, item in self.entry.__globals__.items()
                         if type(item) is ModuleType and item.__name__ == getattr(value, "__module__", None))
        for path in sorted(paths, key=lambda path: (len(path), path)):
            try:
                if self.resolve(path) is value:
                    return path
            except Unsupported:
                pass
        raise Unsupported("an AOT seed binding is not reachable from the entry globals")


def capture(program, widen_objects=True):
    """Describe inferred types, optionally retaining empty object edges at startup.

    Strict seeds preserve verified specializations whose native signature cannot
    represent the wider startup variant. Both are independently guarded on reuse.
    """
    from . import heap as h

    refs = Bindings(program.entry_fn)
    cells, cell_ids = [], {}
    def cell(value):
        root = h._find(value)
        key = id(root)
        if key not in cell_ids:
            cell_ids[key] = len(cells)
            cells.append(None)
            cells[cell_ids[key]] = [kind(root.elem), root.mutated]
        return cell_ids[key]
    def kind(value):
        if type(value) is str:
            return value
        if isinstance(value, h.ObjT):
            # Mutable graph edges may be empty at startup. Retain the None case
            # when regenerating so profile-time occupancy cannot fold it away.
            return ["object", refs.ref(value.cls), value.nullable or widen_objects,
                    [refs.ref(cls) for cls in sorted(value.classes, key=program.tag)]]
        if isinstance(value, h.ListT):
            return ["array" if isinstance(value, h.ArrT) else "list", cell(value.cell)]
        if isinstance(value, h.TupT):
            return ["tuple", [kind(item) for item in value.items], value.nullable]
        if isinstance(value, h.OptT):
            return ["optional", kind(value.base)]
        if isinstance(value, h.StrT):
            return ["string", value.nullable]
        if isinstance(value, h.DictT):
            return ["dict", cell(value.kcell), cell(value.vcell), value.nullable]
        if isinstance(value, h.SetT):
            return ["set", cell(value.cell), value.nullable]
        if isinstance(value, h.NdT):
            return ["ndarray", value.dtype, value.ndim, value.writable]
        if isinstance(value, h.RngT):
            return ["random"]
        raise Unsupported("unsupported AOT seed type")
    classes = []
    for cls, names in program.class_fields.items():
        classes.append([refs.ref(cls), sorted(names),
                        [refs.ref(base) for base in cls.__mro__ if base is not object]])
    families = [[refs.ref(root), [refs.ref(cls) for cls in members],
                 [[name, kind(value)] for name, value in program.fields[root].items()]]
                for root, members in program.members.items()]
    functions = []
    for slot, info in program.functions.items():
        functions.append(dict(ref=refs.ref(info.fn), owner=refs.ref(info.owner) if info.owner else None,
                              key=slot[1], sink=info.sink, fingerprint=_fingerprint(info.fn),
                              vars=[[name, kind(value)] for name, value in info.vars.items()], ret=kind(info.ret)))
    globals_ = []
    for namespace, name, value in program.global_objects:
        if namespace is program.__dict__.get("str_constants"):
            location = ["strings"]
        else:
            owner = next((info.fn for info in program.functions.values() if info.fn.__globals__ is namespace), None)
            if owner is not None:
                location = ["function", refs.ref(owner)]
            else:
                module = next((item for item in program.entry_fn.__globals__.values()
                               if type(item) is ModuleType and vars(item) is namespace), None)
                if module is None:
                    raise Unsupported("an AOT seed cannot rebind this global namespace")
                location = ["module", refs.ref(module)]
        globals_.append([location, name, kind(value)])
    return dict(version=VERSION, classes=classes, families=families, functions=functions,
                globals=globals_, cells=cells)


def _constructor(cls):
    """Look up a constructor without invoking a descriptor or metaclass hook."""
    return next(vars(base)["__init__"] for base in cls.__mro__ if "__init__" in vars(base))


def seal(seed, program):
    """Bind dependencies discovered by normalized inference, without changing types.

    Startup branches can discover code absent from the original specialization.
    Its real code object/defaults must be checked even if inspect finds the same
    source text after a code-object replacement. Guard values also include
    constructors used only to validate fields and helpers inlined during emission.
    """
    refs = Bindings(program.entry_fn)
    functions = {info.fn for info in program.functions.values()}
    classes = set(program.class_fields)
    for guard in program.guards.values():
        if guard[0] in ("code", "attr", "own", "item"):
            functions.update(value for value in guard[1:] if type(value) is FunctionType)
            classes.update(value for value in guard[1:] if type(value) is type)
    for fn in functions:
        if fn.__code__.co_freevars == ("__class__",):
            value = fn.__closure__[0].cell_contents
            if type(value) is not type:
                raise Unsupported("an AOT __class__ cell no longer holds a plain class")
            classes.add(value)
    classes = {base for cls in classes for base in cls.__mro__ if base is not object}
    class_rows = []
    for cls in classes:
        if type(cls) is not type:
            raise Unsupported("an AOT dependency is not a plain class")
        init = _constructor(cls)
        if init is object.__init__:
            init_ref = None
        elif type(init) is FunctionType:
            functions.add(init)
            init_ref = refs.ref(init)
        else:
            raise Unsupported("an AOT constructor is not a plain function")
        class_rows.append([refs.ref(cls), [refs.ref(base) for base in cls.__mro__ if base is not object], init_ref])
    function_rows = []
    for fn in functions:
        class_cell = None
        if fn.__code__.co_freevars == ("__class__",):
            value = fn.__closure__[0].cell_contents
            if type(value) is not type:
                raise Unsupported("an AOT __class__ cell no longer holds a plain class")
            class_cell = refs.ref(value)
        function_rows.append([refs.ref(fn), _fingerprint(fn), class_cell])
    # Set iteration is never part of persisted metadata or its compatibility hash.
    order = lambda row: json.dumps(row[0], separators=(",", ":"))
    return dict(seed, dependencies=dict(functions=sorted(function_rows, key=order),
                                        classes=sorted(class_rows, key=order)))


def _check_dependencies(program, refs, dependencies):
    from . import heap as h

    for path, mro, init_ref in dependencies["classes"]:
        cls = refs.resolve(path)
        if type(cls) is not type:
            raise Unsupported("an AOT class dependency changed")
        bases = [refs.resolve(base) for base in mro]
        if any(type(base) is not type for base in bases) or tuple(bases) != tuple(
                base for base in cls.__mro__ if base is not object):
            raise Unsupported("an AOT dependency inheritance graph changed")
        problem = h._object_problem(cls)
        if problem:
            raise Unsupported(problem)
        init = _constructor(cls)
        expected = object.__init__ if init_ref is None else refs.resolve(init_ref)
        if init is not expected or (init is not object.__init__ and type(init) is not FunctionType):
            raise Unsupported("an AOT constructor binding changed")
        program.guard("attr", cls, "__mro__", cls.__mro__)
        program.guard("attr", cls, "__init__", init)
    for path, fingerprint, class_cell in dependencies["functions"]:
        fn = refs.resolve(path)
        if type(fn) is not FunctionType or _fingerprint(fn) != fingerprint:
            raise Unsupported("an AOT dependency's code or defaults changed")
        program.guard("code", fn, fn.__code__)
        program.guard("attr", fn, "__defaults__", fn.__defaults__)
        program.guard("attr", fn, "__kwdefaults__", fn.__kwdefaults__)
        if fn.__kwdefaults__ is not None:
            program.guard("kwdefaults", fn, fn.__kwdefaults__, tuple(fn.__kwdefaults__.items()))
        if class_cell is not None:
            cls = refs.resolve(class_cell)
            if type(cls) is not type or fn.__code__.co_freevars != ("__class__",) or (
                    fn.__closure__[0].cell_contents is not cls):
                raise Unsupported("an AOT defining-class cell changed")
            program.guard("attr", fn.__closure__[0], "cell_contents", cls)


def restore(entry, seed):
    """Construct inference state, validating live definitions before using its types."""
    from . import heap as h

    try:
        if type(seed) is not dict or seed["version"] != VERSION:
            raise Unsupported("unknown AOT seed version")
        refs, program = Bindings(entry), h._Program(entry)
        if "dependencies" in seed:
            _check_dependencies(program, refs, seed["dependencies"])
        cells = [h._Cell() for _ in seed["cells"]]
        def cls(path):
            value = refs.resolve(path)
            if type(value) is not type:
                raise Unsupported("an AOT class binding changed")
            return value
        def kind(value):
            if type(value) is str:
                if value not in (h.INT,h.FLOAT,h.BOOL,h.NONE,h.MIXED,h.BOTTOM,*h._NP_BASE):
                    raise Unsupported("invalid AOT scalar type")
                return value
            tag, *parts = value
            if tag == "object": return h.ObjT(cls(parts[0]), parts[1], [cls(p) for p in parts[2]])
            if tag == "list": return h.ListT(cells[parts[0]])
            if tag == "array": return h.ArrT(cells[parts[0]])
            if tag == "tuple": return h.TupT([kind(p) for p in parts[0]], parts[1])
            if tag == "optional": return h.OptT(kind(parts[0]))
            if tag == "string": return h.StrT(parts[0])
            if tag == "dict": return h.DictT(cells[parts[0]], cells[parts[1]], parts[2])
            if tag == "set": return h.SetT(cells[parts[0]], parts[1])
            if tag == "ndarray": return h.NdT(*parts)
            if tag == "random": return h.RngT()
            raise Unsupported("invalid AOT type")
        for path, names, mro in seed["classes"]:
            klass = cls(path)
            if tuple(cls(p) for p in mro) != tuple(base for base in klass.__mro__ if base is not object):
                raise Unsupported("an AOT class inheritance graph changed")
            # register must run normally: never bypass constructor/object checks.
            program.register(klass)
            if sorted(program.class_fields[klass]) != names:
                raise Unsupported("an AOT constructor layout changed")
            program.guard("attr", klass, "__mro__", klass.__mro__)
        families, roots, ownership, all_members = [], set(), {}, []
        for path, members, fields in seed["families"]:
            root = cls(path)
            concrete = [cls(p) for p in members]
            own_roots = {h._root(member) for member in concrete}
            # A canonical root may be abstract, but it must own some concrete
            # member of this family. It cannot be another family's alias.
            if root in roots or h._root(root) is not root or root not in own_roots:
                raise Unsupported("invalid AOT canonical family root")
            roots.add(root)
            for own in own_roots:
                if own in ownership and ownership[own] is not root:
                    raise Unsupported("an AOT own-root belongs to multiple families")
                ownership[own] = root
            families.append((root, concrete, fields))
            all_members.extend(concrete)
        if len(all_members) != len(set(all_members)) or set(all_members) != set(program.class_fields):
            raise Unsupported("incomplete or overlapping AOT class families")
        aliases = {own: root for own, root in ownership.items() if own is not root}
        for own in aliases:
            seen, current = set(), own
            while current in aliases:
                if current in seen:
                    raise Unsupported("cyclic AOT family aliases")
                seen.add(current)
                current = aliases[current]
            if current not in roots:
                raise Unsupported("an AOT alias has no canonical family")
        if roots.intersection(aliases):
            raise Unsupported("an AOT canonical family is also an alias")
        # Publish the complete topology only after validating it. In particular,
        # no replay operation may enter canon() with malformed cyclic aliases.
        program.fields = {root: {name: kind(value) for name, value in fields}
                          for root, _, fields in families}
        program.members = {root: members for root, members, _ in families}
        program.alias = aliases
        for target, (value, mutated) in zip(cells, seed["cells"]):
            target.elem, target.mutated = kind(value), mutated
        def key(value):
            return tuple(key(p) for p in value) if isinstance(value, list) else value
        for row in seed["functions"]:
            fn = refs.resolve(row["ref"])
            if type(fn) is not FunctionType or _fingerprint(fn) != row["fingerprint"]:
                raise Unsupported("an AOT function or its defaults changed")
            info = program.function(fn, cls(row["owner"]) if row["owner"] else None,
                                    key(row["key"]), row["sink"])
            info.vars = {name: kind(value) for name, value in row["vars"]}
            info.ret = kind(row["ret"])
        for location, name, value in seed["globals"]:
            if location[0] == "strings":
                namespace = program.__dict__.setdefault("str_constants", {})
                namespace[name] = name
            elif location[0] == "function":
                function = refs.resolve(location[1])
                if type(function) is not FunctionType:
                    raise Unsupported("an AOT global namespace is no longer a plain function")
                namespace = function.__globals__
            elif location[0] == "module":
                module = refs.resolve(location[1])
                if type(module) is not ModuleType:
                    raise Unsupported("an AOT global namespace is no longer a plain module")
                namespace = vars(module)
            else:
                raise Unsupported("invalid AOT global binding")
            index_key = ("str", name) if location[0] == "strings" else (id(namespace), name)
            program.global_index[index_key] = len(program.global_objects)
            program.global_objects.append((namespace, name, kind(value)))
            program.guard("item", namespace, name, namespace.get(name))
        program.seed_identity = identity(seed)
        return program
    except (KeyError, IndexError, TypeError, ValueError, AttributeError) as exc:
        raise Unsupported("invalid or incompatible AOT inference seed") from exc
