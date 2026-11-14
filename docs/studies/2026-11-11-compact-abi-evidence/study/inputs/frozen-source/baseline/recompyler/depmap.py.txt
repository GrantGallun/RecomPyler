"""A dependency map of one script: who calls whom, what each region reaches, and
which values depend on the script's inputs.

Built from the script's source, plus a profile report when one is given (call
counts, times and compile verdicts). Three things come out:

- **Call graph.** Edges between the script's functions and methods, and every call
  out of the script by name (``math.sqrt``, ``builtins.print``, ``method:append``).
- **Regions.** A region is a function plus everything it reaches. Each call out is
  put in a tier, as in the escape study: ``native`` (a compiler can do it on unboxed
  data), ``container`` (dicts, sets, strings), ``boundary`` (print, random, time:
  scalars cross, nothing escapes) or ``escape``. A region's tier is the worst of
  everything it reaches, so a region closed at ``native`` can be compiled whole.
- **Data edges from inputs.** Sources are ``argv`` items, argparse options
  (``args.NAME``) and environment variables (``env:NAME``). For every parameter of
  every function the map records which sources its *value* may depend on, and which
  its *type* may depend on. They differ: in ``dt = 1.0 / n`` the value of ``dt``
  depends on ``n`` but its type is always float, while ``zero = 0 if args.exact
  else 0.0`` makes the type depend on ``args.exact``. Value dependence follows data
  and ``if``/``while`` conditions; a ``for`` loop's iterable reaches only its target.

The analysis is flow-insensitive and context-insensitive: it unions every
assignment and every call site, then repeats until nothing changes. That
over-approximates (it may report a dependency that cannot happen), which costs at
most an extra compiled variant, never a wrong result: every variant is still
checked against Python before it is used.
"""

import ast
import builtins
from collections import Counter, defaultdict
import json
from pathlib import Path
import tokenize

MODULE = ("<module>", 1)
NAMESPACE = "<namespace>"  # marks an argparse namespace object
NATIVE_BUILTINS = {"len", "range", "abs", "min", "max", "int", "float", "bool", "round", "isinstance", "enumerate",
                   "zip", "sum", "divmod", "pow", "list", "tuple", "reversed", "sorted", "iter", "next", "any",
                   "all", "map", "filter", "slice", "super"}
CONTAINER_BUILTINS = {"dict", "set", "frozenset", "str", "chr", "ord", "format", "repr", "hash", "bytes",
                      "bytearray", "id"}
BOUNDARY_MODULES = {"random", "time"}
NATIVE_METHODS = {"append", "pop", "extend", "insert", "index", "count", "reverse", "sort", "copy", "clear",
                  "remove", "is_integer", "conjugate", "bit_length"}
CONTAINER_METHODS = {"get", "items", "keys", "values", "add", "update", "discard", "setdefault", "join", "split",
                     "strip", "startswith", "endswith", "replace", "format", "lower", "upper", "encode", "decode",
                     "popitem", "union", "intersection", "difference"}
DYNAMIC_CALLS = {"eval", "exec", "compile", "globals", "locals", "vars", "__import__", "delattr"}
DYNAMIC_ATTRS = {"__dict__", "__class__", "__globals__", "f_locals", "f_globals", "_getframe", "__code__"}
TIERS = ("native", "container", "boundary", "escape")
NUMBERS = ("bool", "int", "float")
MATH_INT = {"floor", "ceil", "trunc", "isqrt", "factorial", "gcd", "lcm", "comb", "perm"}
MATH_BOOL = {"isfinite", "isinf", "isnan", "isclose"}


def tier(callee):
    """The tier of one call out of the script, by its static name."""
    if callee.startswith("script:"):
        return "native"
    if callee.startswith("method:"):
        name = callee.split(":", 1)[1]
        if name in NATIVE_METHODS:
            return "native"
        return "container" if name in CONTAINER_METHODS else "escape"
    module, _, attribute = callee.rpartition(".")
    if module == "builtins":
        if attribute in NATIVE_BUILTINS or _is_exception(attribute):
            # Raising leaves compiled code through the fallback, so nothing escapes.
            return "native"
        if attribute in CONTAINER_BUILTINS:
            return "container"
        return "boundary" if attribute == "print" else "escape"
    if module in ("math", "operator"):
        return "native"
    if module.split(".")[0] in BOUNDARY_MODULES:
        return "boundary"
    return "escape"


def _is_exception(name):
    found = getattr(builtins, name, None)
    return isinstance(found, type) and issubclass(found, BaseException)


def _function_ref(key):
    return f"fn:{key[0]}:{key[1]}"


class _Value:
    """What one expression depends on: sources of its value and of its type, and its
    type when that is fixed whatever the inputs are (``"int"``, ``"float"``, ``"bool"``)."""

    __slots__ = ("data", "types", "fixed")

    def __init__(self, data=frozenset(), types=frozenset(), fixed=None):
        self.data, self.types, self.fixed = frozenset(data), frozenset(types), fixed


def _join(values, fixed=None):
    data = frozenset().union(*(value.data for value in values)) if values else frozenset()
    types = frozenset().union(*(value.types for value in values)) if values else frozenset()
    if fixed is None and values and len({value.fixed for value in values}) == 1:
        fixed = values[0].fixed
    return _Value(data, types, fixed)


class _Slot:
    """Everything that flows into one variable, parameter, field or return value."""

    __slots__ = ("data", "types", "fixed", "control")

    def __init__(self):
        self.data, self.types, self.fixed, self.control = set(), set(), set(), set()

    def add(self, value, control):
        before = len(self.data), len(self.types), len(self.fixed), len(self.control)
        self.data |= value.data | control
        self.types |= value.types
        self.fixed.add(value.fixed)
        self.control |= control
        return before != (len(self.data), len(self.types), len(self.fixed), len(self.control))

    def value(self):
        known = {kind for kind in self.fixed if kind is not None}
        types = set(self.types)
        if len(known) > 1 or (known and None in self.fixed and self.types):
            # Different fixed types reach this slot under different conditions: which
            # one it holds depends on those conditions.
            types |= self.control
        fixed = next(iter(known)) if len(known) == 1 and None not in self.fixed else None
        return _Value(self.data, types, fixed)


class Function:
    def __init__(self, key, qualname, node, owner):
        self.key, self.qualname, self.node, self.owner = key, qualname, node, owner
        args = node.args.posonlyargs + node.args.args if not isinstance(node, ast.Module) else []
        self.params = [arg.arg for arg in args]
        self.locals = set(self.params)
        self.globals = set()
        if not isinstance(node, ast.Module):
            for item in ast.walk(node):
                if isinstance(item, ast.Global):
                    self.globals.update(item.names)
            for item in _own_nodes(node):
                if isinstance(item, ast.Name) and isinstance(item.ctx, ast.Store) and item.id not in self.globals:
                    self.locals.add(item.id)
                elif isinstance(item, ast.arg):
                    self.locals.add(item.arg)
        self.externals, self.callees, self.dynamic = Counter(), set(), set()
        self.profile = {}
        # name = obj.method: a later name(...) is a method call.
        self.aliases = {}
        for item in _own_nodes(node):
            if (isinstance(item, ast.Assign) and len(item.targets) == 1 and isinstance(item.targets[0], ast.Name)
                    and isinstance(item.value, ast.Attribute)):
                self.aliases[item.targets[0].id] = item.value.attr


def _own_nodes(node):
    """Nodes in ``node``'s body, not inside nested functions, classes or lambdas."""
    stack = list(ast.iter_child_nodes(node))
    while stack:
        item = stack.pop()
        yield item
        if not isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef, ast.Lambda)):
            stack.extend(ast.iter_child_nodes(item))


class DependencyMap:
    def __init__(self, tree, path=None):
        self.path = path
        self.functions, self.classes, self.imports = {}, {}, {}
        self.by_name, self.methods = defaultdict(list), defaultdict(list)
        self.slots = defaultdict(_Slot)  # (function key, name) or ("field", name) or ("return", key)
        self.options = {}  # argparse option -> fixed type its parser gives, or None
        self.call_sites = defaultdict(list)  # callee key -> (caller key, line)
        self._collect(tree)
        self._solve()

    # Collection

    def _collect(self, tree):
        self.functions[MODULE] = Function(MODULE, "<module>", tree, None)

        def visit(node, prefix, owner):
            for child in ast.iter_child_nodes(node):
                if isinstance(child, (ast.FunctionDef, ast.AsyncFunctionDef)):
                    key = (child.name, child.lineno)
                    function = Function(key, prefix + child.name, child, owner)
                    self.functions[key] = function
                    if owner is not None and isinstance(node, ast.ClassDef):
                        self.methods[child.name].append(key)
                    elif prefix == "":
                        self.by_name[child.name].append(key)
                    visit(child, f"{prefix}{child.name}.<locals>.", None)
                elif isinstance(child, ast.ClassDef):
                    self.classes[child.name] = child
                    visit(child, f"{prefix}{child.name}.", child.name)
                elif isinstance(child, (ast.Import, ast.ImportFrom)):
                    for alias in child.names:
                        if isinstance(child, ast.Import):
                            self.imports[alias.asname or alias.name.split(".")[0]] = (
                                alias.name if alias.asname else alias.name.split(".")[0])
                        else:
                            self.imports[alias.asname or alias.name] = f"{child.module}.{alias.name}"
                    visit(child, prefix, owner)
                else:
                    visit(child, prefix, owner)

        visit(tree, "", None)

    # Name resolution

    def _dotted(self, node):
        """``math.sqrt`` for a call through an imported module, else None."""
        parts = []
        while isinstance(node, ast.Attribute):
            parts.append(node.attr)
            node = node.value
        if isinstance(node, ast.Name) and node.id in self.imports:
            return ".".join([self.imports[node.id], *reversed(parts)])
        return None

    def _targets(self, call, function):
        """(callee keys, offset of the first argument among their parameters, external name)."""
        func = call.func
        if isinstance(func, ast.Name):
            name = func.id
            if name in self.by_name and name not in function.locals - {*function.globals}:
                return self.by_name[name], 0, None
            if name in self.classes:
                init = [key for key in self.methods.get("__init__", ())
                        if self.functions[key].owner == name]
                return init, 1, f"script:{name}"
            if name in self.imports:
                return [], 0, self.imports[name]
            if hasattr(builtins, name) and name not in function.locals:
                return [], 0, f"builtins.{name}"
            passed = sorted(self._passed_functions(function, name))
            if passed:
                return passed, 0, None
            if name in function.aliases:
                attr = function.aliases[name]
                if attr in self.methods:
                    return self.methods[attr], 0, None
                return [], 0, f"method:{attr}"
            return [], 0, f"local:{name}"
        if isinstance(func, ast.Attribute):
            dotted = self._dotted(func)
            if dotted is not None:
                return [], 0, dotted
            if func.attr in self.methods:
                owner = func.value.id if isinstance(func.value, ast.Name) else None
                if owner in self.classes:
                    # Class.method(obj, ...): arguments line up with the parameters.
                    return [key for key in self.methods[func.attr] if self.functions[key].owner == owner], 0, None
                return self.methods[func.attr], 1, None
            return [], 0, f"method:{func.attr}"
        return [], 0, "other:call"

    def _passed_functions(self, function, name):
        """Script functions that a local name or parameter may hold."""
        data = self._read(function, name).data
        return {key for key in self.functions if _function_ref(key) in data}

    # Evaluation

    def _read(self, function, name):
        if function.key != MODULE and name in function.locals and name not in function.globals:
            return self.slots[function.key, name].value()
        return self.slots[MODULE, name].value()

    def _value(self, node, function, control):
        """A _Value for expression ``node`` in ``function``, recording calls on the way."""
        ev = lambda item: self._value(item, function, control)  # noqa: E731
        if node is None:
            return _Value()
        if isinstance(node, ast.Constant):
            kind = type(node.value).__name__
            return _Value(fixed=kind if kind in NUMBERS else None)
        if isinstance(node, ast.Name):
            if node.id in self.by_name and (function.key == MODULE or node.id not in function.locals):
                return _Value({_function_ref(key) for key in self.by_name[node.id]})
            return self._read(function, node.id) if node.id not in ("True", "False") else _Value(fixed="bool")
        if isinstance(node, ast.Attribute):
            if node.attr in DYNAMIC_ATTRS:
                function.dynamic.add(node.attr)
            dotted = self._dotted(node)
            if dotted == "sys.argv":
                return _Value({"argv"}, {"argv"})
            if dotted is not None:
                return _Value(fixed="float" if dotted.startswith("math.") else None)
            owner = ev(node.value)
            if NAMESPACE in owner.data:
                source = f"args.{node.attr}"
                fixed = self.options.get(node.attr)
                return _Value({source}, set() if fixed else {source}, fixed)
            return self.slots["field", node.attr].value()
        if isinstance(node, ast.Subscript):
            dotted = self._dotted(node.value)
            index = node.slice.value if isinstance(node.slice, ast.Constant) else None
            if dotted == "sys.argv":
                source = f"argv[{index}]" if type(index) is int else "argv"
                return _Value({source}, {source})
            if dotted == "os.environ" and type(index) is str:
                return _Value({f"env:{index}"}, {f"env:{index}"})
            container, key = ev(node.value), ev(node.slice)
            return _Value(container.data | key.data, container.types)
        if isinstance(node, ast.Call):
            return self._call(node, function, control)
        if isinstance(node, ast.BinOp):
            left, right = ev(node.left), ev(node.right)
            data = left.data | right.data
            if isinstance(node.op, ast.Div):
                return _Value(data, (), "float")
            if "float" in (left.fixed, right.fixed) and not isinstance(node.op, (ast.Pow,)):
                return _Value(data, (), "float")
            if left.fixed == right.fixed == "int" and not isinstance(node.op, ast.Pow):
                return _Value(data, (), "int")
            return _Value(data, left.types | right.types, None)
        if isinstance(node, ast.UnaryOp):
            operand = ev(node.operand)
            if isinstance(node.op, ast.Not):
                return _Value(operand.data, (), "bool")
            return _Value(operand.data, operand.types, "int" if operand.fixed == "bool" else operand.fixed)
        if isinstance(node, ast.Compare):
            return _Value(_join([ev(node.left), *map(ev, node.comparators)]).data, (), "bool")
        if isinstance(node, ast.BoolOp):
            return _join([ev(value) for value in node.values])
        if isinstance(node, ast.IfExp):
            test, body, orelse = ev(node.test), ev(node.body), ev(node.orelse)
            types = body.types | orelse.types
            if body.fixed != orelse.fixed:
                types |= test.data
            fixed = body.fixed if body.fixed == orelse.fixed else None
            return _Value(test.data | body.data | orelse.data, types, fixed)
        if isinstance(node, (ast.ListComp, ast.SetComp, ast.GeneratorExp, ast.DictComp)):
            inner = [ev(generator.iter) for generator in node.generators]
            for generator in node.generators:
                self._assign(generator.target, ev(generator.iter), function, control)
                for test in generator.ifs:
                    ev(test)
            parts = [ev(node.key), ev(node.value)] if isinstance(node, ast.DictComp) else [ev(node.elt)]
            joined = _join(parts)
            return _Value(joined.data | _join(inner).data, joined.types)
        if isinstance(node, ast.Lambda):
            return _Value()
        children = [ev(child) for child in ast.iter_child_nodes(node) if isinstance(child, ast.expr)]
        joined = _join(children)
        return _Value(joined.data, joined.types)

    def _call(self, node, function, control):
        ev = lambda item: self._value(item, function, control)  # noqa: E731
        args = [ev(arg.value if isinstance(arg, ast.Starred) else arg) for arg in node.args]
        keywords = {keyword.arg: ev(keyword.value) for keyword in node.keywords}
        everything = args + list(keywords.values())
        func = node.func
        if isinstance(func, ast.Attribute):
            receiver = ev(func.value)
            if func.attr == "parse_args":
                return _Value({NAMESPACE})
            if func.attr == "add_argument":
                self._option(node)
            if func.attr == "get" and self._dotted(func.value) == "os.environ" and node.args and isinstance(
                    node.args[0], ast.Constant):
                name = f"env:{node.args[0].value}"
                return _Value({name}, {name})
        dotted = self._dotted(func) if isinstance(func, ast.Attribute) else None
        if dotted == "os.getenv" and node.args and isinstance(node.args[0], ast.Constant):
            name = f"env:{node.args[0].value}"
            return _Value({name}, {name})
        if isinstance(func, ast.Name) and func.id in DYNAMIC_CALLS and func.id not in function.locals:
            function.dynamic.add(func.id)
        if (isinstance(func, ast.Name) and func.id in ("getattr", "setattr", "hasattr")
                and len(node.args) > 1 and not isinstance(node.args[1], ast.Constant)):
            function.dynamic.add(f"{func.id} with a computed name")
        callees, offset, external = self._targets(node, function)
        data = _join(everything).data
        if callees:
            function.callees.update(callees)
            control_types = set(control)
            results = []
            for key in callees:
                callee = self.functions[key]
                self.call_sites[key].append((function.key, node.lineno))
                for index, value in enumerate(args):
                    if isinstance(node.args[index], ast.Starred):
                        break
                    if index + offset < len(callee.params):
                        self.slots[key, callee.params[index + offset]].add(value, control_types)
                for name, value in keywords.items():
                    if name in callee.params:
                        self.slots[key, name].add(value, control_types)
                if callee.node.name != "__init__":
                    results.append(self.slots["return", key].value())
            if external is not None:  # a class: the call makes an object
                function.externals[external] += 1
                return _Value(data)
            joined = _join(results) if results else _Value()
            return _Value(joined.data | data, joined.types, joined.fixed)
        function.externals[external] += 1
        name = external.rpartition(".")[2] if external else ""
        if external in ("builtins.int", "builtins.len") or external == "builtins.round" and len(args) == 1:
            return _Value(data, (), "int")
        if external == "builtins.float":
            return _Value(data, (), "float")
        if external == "builtins.bool" or external == "builtins.isinstance":
            return _Value(data, (), "bool")
        if external and external.startswith("math."):
            return _Value(data, (), "int" if name in MATH_INT else "bool" if name in MATH_BOOL else "float")
        if external in ("builtins.abs", "builtins.min", "builtins.max", "builtins.sum", "builtins.pow"):
            return _join(everything)
        if external in ("builtins.input",):
            return _Value({"input"}, {"input"})
        joined = _join(everything)
        return _Value(joined.data, joined.types)

    def _option(self, node):
        """Record an argparse option's name and the type its parser fixes, if any."""
        names = [arg.value for arg in node.args if isinstance(arg, ast.Constant) and type(arg.value) is str]
        settings = {keyword.arg: keyword.value for keyword in node.keywords}
        dest = settings.get("dest")
        if isinstance(dest, ast.Constant):
            name = dest.value
        else:
            longs = [item for item in names if item.startswith("--")]
            name = (longs or names or ["?"])[0].lstrip("-").replace("-", "_")
        fixed = None
        kind = settings.get("type")
        if isinstance(kind, ast.Name) and kind.id in NUMBERS:
            fixed = kind.id
        action = settings.get("action")
        if isinstance(action, ast.Constant) and action.value in ("store_true", "store_false"):
            fixed = "bool"
        if isinstance(action, ast.Constant) and action.value == "count":
            fixed = "int"
        if kind is None and action is None and "default" in settings:
            default = settings["default"]
            if isinstance(default, ast.Constant) and type(default.value).__name__ in NUMBERS:
                # Without type=, a given option is a str; only the default is a number.
                fixed = None
        self.options[name] = fixed

    # Statements

    def _assign(self, target, value, function, control):
        changed = False
        if isinstance(target, ast.Name):
            scope = (function.key if function.key != MODULE and target.id in function.locals
                     and target.id not in function.globals else MODULE)
            changed |= self.slots[scope, target.id].add(value, control)
        elif isinstance(target, (ast.Tuple, ast.List)):
            for item in target.elts:
                changed |= self._assign(item.value if isinstance(item, ast.Starred) else item,
                                        _Value(value.data, value.types), function, control)
        elif isinstance(target, ast.Attribute):
            self._value(target.value, function, control)
            changed |= self.slots["field", target.attr].add(value, control)
        elif isinstance(target, ast.Subscript):
            self._value(target.slice, function, control)
            container = target.value
            while isinstance(container, (ast.Subscript, ast.Attribute)):
                container = container.value
            if isinstance(container, ast.Name):
                changed |= self._assign(container, _Value(value.data, value.types), function, control)
        return changed

    def _statements(self, body, function, control):
        for statement in body:
            self._statement(statement, function, control)

    def _statement(self, node, function, control):
        ev = lambda item: self._value(item, function, control)  # noqa: E731
        if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
            for decorator in node.decorator_list:
                ev(decorator)
            if isinstance(node, ast.ClassDef):
                # Class bodies run once, in the enclosing scope.
                self._statements([item for item in node.body if not isinstance(
                    item, (ast.FunctionDef, ast.AsyncFunctionDef))], function, control)
            return
        if isinstance(node, ast.Assign):
            value = ev(node.value)
            for target in node.targets:
                self._assign(target, value, function, control)
        elif isinstance(node, ast.AnnAssign):
            if node.value is not None:
                self._assign(node.target, ev(node.value), function, control)
        elif isinstance(node, ast.AugAssign):
            current = ev(ast.Name(id=node.target.id, ctx=ast.Load())) if isinstance(node.target, ast.Name) \
                else _Value()
            combined = self._value(ast.BinOp(left=node.target if not isinstance(node.target, ast.Name)
                                             else ast.Name(id=node.target.id, ctx=ast.Load()),
                                             op=node.op, right=node.value), function, control)
            self._assign(node.target, _join([current, combined], combined.fixed), function, control)
        elif isinstance(node, (ast.If, ast.While)):
            test = ev(node.test)
            inner = control | test.data
            self._statements(node.body, function, inner)
            self._statements(node.orelse, function, inner)
        elif isinstance(node, (ast.For, ast.AsyncFor)):
            iterable = ev(node.iter)
            self._assign(node.target, _Value(iterable.data, iterable.types), function, control)
            # How many times a loop runs is not a condition on the values made inside it.
            self._statements(node.body, function, control)
            self._statements(node.orelse, function, control)
        elif isinstance(node, (ast.With, ast.AsyncWith)):
            for item in node.items:
                value = ev(item.context_expr)
                if item.optional_vars is not None:
                    self._assign(item.optional_vars, value, function, control)
            self._statements(node.body, function, control)
        elif isinstance(node, ast.Try) or type(node).__name__ == "TryStar":
            self._statements(node.body, function, control)
            for handler in node.handlers:
                if handler.name:
                    self._assign(ast.Name(id=handler.name, ctx=ast.Store()), _Value(), function, control)
                self._statements(handler.body, function, control)
            self._statements(node.orelse, function, control)
            self._statements(node.finalbody, function, control)
        elif isinstance(node, ast.Match):
            subject = ev(node.subject)
            for case in node.cases:
                self._statements(case.body, function, control | subject.data)
        elif isinstance(node, ast.Return):
            self.slots["return", function.key].add(ev(node.value) if node.value else _Value(), control)
        elif isinstance(node, (ast.Expr, ast.Assert, ast.Raise, ast.Delete)):
            for child in ast.iter_child_nodes(node):
                if isinstance(child, ast.expr):
                    ev(child)

    def _solve(self):
        """Repeat until no slot changes. Slots only grow, so this ends."""
        for _ in range(50):
            before = self._signature()
            for function in self.functions.values():
                function.externals.clear()
                function.callees.clear()
                self._statements(function.node.body, function, frozenset())
            self.call_sites = defaultdict(list, {key: sorted(set(sites)) for key, sites in self.call_sites.items()})
            if self._signature() == before:
                return
        raise RuntimeError("dependency map did not settle")

    def _signature(self):
        return sum(len(slot.data) + len(slot.types) + len(slot.fixed) + len(slot.control)
                   for slot in self.slots.values())

    # Questions

    def parameter(self, key, name):
        """(value sources, type sources, fixed type or None) of one parameter."""
        value = self.slots[key, name].value()
        drop = lambda items: {item for item in items if item != NAMESPACE and not item.startswith("fn:")}  # noqa: E731
        return drop(value.data), drop(value.types), value.fixed

    def depends_on(self, source):
        """{function key: {"value": [params], "type": [params]}} for params that depend on ``source``."""
        found = {}
        for key, function in self.functions.items():
            value = [name for name in function.params if source in self.parameter(key, name)[0]]
            kind = [name for name in function.params if source in self.parameter(key, name)[1]]
            if value or kind:
                found[key] = {"value": value, "type": kind}
        return found

    def sources(self):
        everything = set()
        for slot in self.slots.values():
            everything |= slot.data
        return sorted(item for item in everything - {NAMESPACE} if not item.startswith("fn:"))

    def own_tier(self, key):
        """(tier index, reasons) for one function on its own."""
        function = self.functions[key]
        reasons = Counter({(tier(name), name): count for name, count in function.externals.items()})
        for feature in function.dynamic:
            reasons[("escape", f"uses {feature}")] += 1
        worst = max((TIERS.index(level) for level, _ in reasons), default=0)
        return worst, reasons

    def reach(self, key):
        seen, stack = {key}, [key]
        while stack:
            for callee in self.functions[stack.pop()].callees:
                if callee not in seen:
                    seen.add(callee)
                    stack.append(callee)
        return seen

    def region(self, key):
        """(members, tier name, the calls that set the tier) for the region rooted at ``key``."""
        members = self.reach(key)
        worst, why = 0, Counter()
        for member in members:
            level, reasons = self.own_tier(member)
            worst = max(worst, level)
            why.update(reasons)
        blocking = sorted(name for (level, name) in why if TIERS.index(level) == worst and worst > 0)
        return members, TIERS[worst], blocking

    def attach(self, report):
        """Add a profile's call counts, times and compile verdicts to the matching functions."""
        for row in report.get("functions") or []:
            key = row["function"], row["line"]
            if key in self.functions:
                candidate = row.get("candidate", {})
                self.functions[key].profile = {
                    "calls": row.get("calls"), "self_s": row.get("self_s"), "cumulative_s": row.get("cumulative_s"),
                    "status": candidate.get("status"), "engine": candidate.get("engine", "lift"),
                    "recommended": candidate.get("recommended")}
        return self

    def to_json(self):
        functions = []
        for key, function in self.functions.items():
            members, level, blocking = self.region(key)
            params = {}
            for name in function.params:
                data, types, fixed = self.parameter(key, name)
                if data or types or fixed:
                    params[name] = {"value": sorted(data), "type": sorted(types), "fixed": fixed}
            functions.append({"function": key[0], "line": key[1], "qualname": function.qualname,
                              "calls": sorted(f"{self.functions[c].qualname}:{c[1]}" for c in function.callees),
                              "external": dict(function.externals), "dynamic": sorted(function.dynamic),
                              "region": {"tier": level, "size": len(members), "blocked_by": blocking[:5]},
                              "params": params, "profile": function.profile})
        return {"schema": "recompyler.depmap.v1", "script": str(self.path) if self.path else None,
                "sources": self.sources(), "options": self.options, "functions": functions}


def build(script, report=None):
    """The dependency map of ``script`` (a path), with ``report`` (a profile dict) attached."""
    with tokenize.open(script) as handle:
        tree = ast.parse(handle.read(), str(script))
    found = DependencyMap(tree, Path(script))
    return found.attach(report) if report else found


def print_map(found, out):
    data = found.to_json()
    print(f"\nRecomPyler dependency map — {data['script']}", file=out)
    if data["sources"]:
        print(f"Inputs: {', '.join(data['sources'])}", file=out)
    for row in data["functions"]:
        if row["function"] == "<module>":
            continue
        region = row["region"]
        blocked = f" (blocked by {', '.join(region['blocked_by'])})" if region["blocked_by"] else ""
        timing = ""
        if row["profile"].get("self_s") is not None:
            timing = f", {row['profile']['calls']:,} calls, {row['profile']['self_s'] * 1000:.1f} ms self"
        print(f"{row['qualname']}:{row['line']}  region {region['tier']}, {region['size']} function(s){blocked}"
              f"{timing}", file=out)
        for name, info in row["params"].items():
            parts = []
            if info["type"]:
                parts.append(f"type depends on {', '.join(info['type'])}")
            elif info["fixed"]:
                parts.append(f"always {info['fixed']}")
            if info["value"]:
                parts.append(f"value depends on {', '.join(info['value'])}")
            if parts:
                print(f"    {name}: {'; '.join(parts)}", file=out)


def main_map(script, plan=None, json_path=None, out=None):
    import sys

    report = json.loads(Path(plan).read_text(encoding="utf-8")) if plan else None
    found = build(script, report)
    if json_path:
        Path(json_path).write_text(json.dumps(found.to_json(), indent=1), encoding="utf-8")
    print_map(found, out or sys.stderr)
    return found
