"""Definite assignment over a function's control flow.

``analyse(node, params)`` walks a function's body as Python runs it, through if/elif,
for and while loops (with break, continue and else), try/except/else/finally, with,
match, return and raise, and keeps the set of locals that are bound on every path to
each point. It reports the reads of a local that it cannot prove bound there.

Compiled code holds such a local with a flag that says it is bound and checks the flag
at those reads only: where Python would raise UnboundLocalError, the call goes back to
Python, which then raises it itself.

The analysis is conservative: where it is unsure (an exception part way through a try
body, a with block whose exit may swallow an exception, a test it cannot evaluate), it
assumes the fewest names bound, so a read it calls bound is bound on every path.
"""

import ast

_SCOPES = (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef, ast.Lambda,
           ast.GeneratorExp, ast.ListComp, ast.SetComp, ast.DictComp)


class Flow:
    """What ``analyse`` found: the reads that may find their local unbound (``unbound``,
    the ids of Name nodes, and of the target of ``x += ...``), the locals they read
    (``names``), those reads in source order (``nodes``), and whether control can run
    off the end of the body."""

    def __init__(self, unbound, names, falls_through, nodes=()):
        self.unbound, self.names, self.falls_through = unbound, names, falls_through
        self.nodes = list(nodes)


def _bound_names(target, out):
    """Names a target binds: a name, or names inside tuples, lists and starred targets."""
    if isinstance(target, ast.Name):
        out.append(target.id)
    elif isinstance(target, (ast.Tuple, ast.List)):
        for item in target.elts:
            _bound_names(item, out)
    elif isinstance(target, ast.Starred):
        _bound_names(target.value, out)
    return out


def function_locals(node):
    """The names local to function ``node``: its parameters and every name its own
    scope binds (not those of comprehensions, lambdas or functions inside it), less
    those declared global or nonlocal."""
    args = node.args
    names = {arg.arg for arg in args.posonlyargs + args.args + args.kwonlyargs}
    names |= {arg.arg for arg in (args.vararg, args.kwarg) if arg is not None}
    declared = set()

    def walk(item):
        if isinstance(item, (ast.Global, ast.Nonlocal)):
            declared.update(item.names)
        elif isinstance(item, ast.Name) and isinstance(item.ctx, (ast.Store, ast.Del)):
            names.add(item.id)
        elif isinstance(item, ast.ClassDef):
            names.add(item.name)
            # Only the class header runs in the enclosing scope. The class body
            # and type parameters have their own bindings.
            for part in item.decorator_list + item.bases + [keyword.value for keyword in item.keywords]:
                walk(part)
            return
        elif isinstance(item, (ast.FunctionDef, ast.AsyncFunctionDef)):
            names.add(item.name)
            for part in item.decorator_list + _defaults(item):
                walk(part)
            return
        elif isinstance(item, (ast.Import, ast.ImportFrom)):
            for alias in item.names:
                names.add((alias.asname or alias.name).split(".")[0])
        elif isinstance(item, ast.ExceptHandler) and item.name:
            names.add(item.name)
        elif isinstance(item, (ast.MatchAs, ast.MatchStar)) and item.name:
            names.add(item.name)
        elif isinstance(item, ast.MatchMapping) and item.rest:
            names.add(item.rest)
        elif isinstance(item, ast.Lambda):
            for part in _defaults(item):
                walk(part)
            return
        elif isinstance(item, (ast.GeneratorExp, ast.ListComp, ast.SetComp, ast.DictComp)):
            # The first iterable is evaluated in this scope; := inside binds here too.
            walk(item.generators[0].iter)
            for inner in ast.walk(item):
                if isinstance(inner, ast.NamedExpr) and isinstance(inner.target, ast.Name):
                    names.add(inner.target.id)
            return
        for child in ast.iter_child_nodes(item):
            walk(child)

    for statement in node.body:
        walk(statement)
    return names - declared


def _defaults(node):
    args = node.args
    return [item for item in args.defaults + args.kw_defaults if item is not None]


def _constant_truth(test):
    """True or False for a test that is a literal constant, else None."""
    if isinstance(test, ast.Constant) and type(test.value) in (bool, int, float, str, type(None)):
        return bool(test.value)
    return None


class _Walker:
    def __init__(self, local_names):
        self.locals = local_names
        # id(Name) -> whether the latest visit found it maybe unbound. A loop body is
        # visited until its entry state settles; the last visit is the one that counts.
        self.reads = {}
        self.read_names, self.read_nodes = {}, {}
        # Per enclosing loop: the states at its breaks and at its continues.
        self.loops = []

    # Expressions: each returns the state after evaluating, with := bindings.

    def check(self, node, name, bound):
        if name in self.locals:
            self.reads[id(node)] = name not in bound
            self.read_names[id(node)] = name
            self.read_nodes[id(node)] = node

    def expr(self, node, bound):
        if node is None:
            return bound
        if isinstance(node, ast.Name):
            if isinstance(node.ctx, ast.Load):
                self.check(node, node.id, bound)
            return bound
        if isinstance(node, ast.NamedExpr):
            bound = self.expr(node.value, bound)
            return bound | {node.target.id}
        if isinstance(node, ast.BoolOp):
            bound = self.expr(node.values[0], bound)
            inner = bound
            for value in node.values[1:]:
                inner = self.expr(value, inner)
            return bound
        if isinstance(node, ast.IfExp):
            bound = self.expr(node.test, bound)
            return self.expr(node.body, bound) & self.expr(node.orelse, bound)
        if isinstance(node, (ast.GeneratorExp, ast.ListComp, ast.SetComp, ast.DictComp)):
            return self.comprehension(node, bound)
        if isinstance(node, ast.Lambda):
            for part in _defaults(node):
                bound = self.expr(part, bound)
            # The body runs later, in its own scope.
            return bound
        for child in ast.iter_child_nodes(node):
            if isinstance(child, ast.expr):
                bound = self.expr(child, bound)
            elif isinstance(child, ast.keyword):
                bound = self.expr(child.value, bound)
            elif isinstance(child, (ast.comprehension, ast.arguments)):
                pass
        return bound

    def comprehension(self, node, bound):
        """A comprehension's own scope: its targets are its own; other names are this
        function's. Only the first iterable is certain to be evaluated."""
        first = node.generators[0]
        bound = self.expr(first.iter, bound)
        own = set()
        for generator in node.generators:
            own.update(_bound_names(generator.target, []))
        saved = self.locals
        self.locals = saved - own
        inner = bound
        try:
            for index, generator in enumerate(node.generators):
                if index:
                    inner = self.expr(generator.iter, inner)
                for test in generator.ifs:
                    inner = self.expr(test, inner)
            if isinstance(node, ast.DictComp):
                self.expr(node.value, self.expr(node.key, inner))
            else:
                self.expr(node.elt, inner)
        finally:
            self.locals = saved
        return bound

    # Targets

    def store(self, target, bound):
        """The state after assigning to ``target`` (its parts read as Python reads them)."""
        if isinstance(target, ast.Name):
            return bound | {target.id}
        if isinstance(target, (ast.Tuple, ast.List)):
            for item in target.elts:
                bound = self.store(item, bound)
            return bound
        if isinstance(target, ast.Starred):
            return self.store(target.value, bound)
        if isinstance(target, ast.Attribute):
            return self.expr(target.value, bound)
        if isinstance(target, ast.Subscript):
            return self.expr(target.slice, self.expr(target.value, bound))
        return self.expr(target, bound)

    # Statements: each returns the state if control falls through, or None.

    def block(self, statements, bound):
        for statement in statements:
            if bound is None:
                # Unreachable code: nothing in it runs, so no read in it is wrong.
                bound = frozenset(self.locals)
            bound = self.statement(statement, bound)
            if bound is None:
                return None
        return bound

    def statement(self, node, bound):
        method = getattr(self, "do_" + type(node).__name__, None)
        if method is not None:
            return method(node, bound)
        for child in ast.iter_child_nodes(node):
            if isinstance(child, ast.expr):
                bound = self.expr(child, bound)
        return bound

    def do_Return(self, node, bound):
        self.expr(node.value, bound)
        return None

    def do_Raise(self, node, bound):
        self.expr(node.cause, self.expr(node.exc, bound))
        return None

    def do_Break(self, node, bound):
        if self.loops:
            self.loops[-1][0].append(bound)
        return None

    def do_Continue(self, node, bound):
        if self.loops:
            self.loops[-1][1].append(bound)
        return None

    def do_Assign(self, node, bound):
        bound = self.expr(node.value, bound)
        for target in node.targets:
            bound = self.store(target, bound)
        return bound

    def do_AnnAssign(self, node, bound):
        if node.value is None:
            return bound if isinstance(node.target, ast.Name) else self.store(node.target, bound)
        return self.store(node.target, self.expr(node.value, bound))

    def do_AugAssign(self, node, bound):
        target = node.target
        if isinstance(target, ast.Name):
            self.check(target, target.id, bound)
            return self.expr(node.value, bound) | {target.id}
        if isinstance(target, ast.Attribute):
            bound = self.expr(target.value, bound)
        elif isinstance(target, ast.Subscript):
            bound = self.expr(target.slice, self.expr(target.value, bound))
        return self.expr(node.value, bound)

    def do_Delete(self, node, bound):
        for target in node.targets:
            if isinstance(target, ast.Name):
                self.check(target, target.id, bound)
                bound = bound - {target.id}
            else:
                bound = self.store(target, bound)
        return bound

    def do_If(self, node, bound):
        bound = self.expr(node.test, bound)
        truth = _constant_truth(node.test)
        yes = self.block(node.body, bound) if truth is not False else None
        no = self.block(node.orelse, bound) if truth is not True else None
        return _merge([yes, no])

    def loop(self, node, entry, body_entry, exits_normally):
        """A loop: its body is walked until the state at the top settles."""
        head = entry
        for _ in range(len(self.locals) + 2):
            self.loops.append(([], []))
            end = self.block(node.body, body_entry(head))
            breaks, continues = self.loops.pop()
            settled = _merge([entry, end, *continues])
            if settled == head:
                break
            head = settled
        normal = None
        if exits_normally:
            normal = self.block(node.orelse, head) if node.orelse else head
        return _merge([normal, *breaks])

    def do_While(self, node, bound):
        truth = _constant_truth(node.test)

        def body_entry(head):
            return self.expr(node.test, head)

        after_test = self.expr(node.test, bound)
        return self.loop(node, after_test, body_entry, truth is not True)

    def do_For(self, node, bound):
        bound = self.expr(node.iter, bound)

        def body_entry(head):
            return self.store(node.target, head)

        return self.loop(node, bound, body_entry, True)

    do_AsyncFor = do_For

    def do_Try(self, node, bound):
        # An exception can come part way through the body: a handler or the finally
        # block starts with what was bound before it, less what the body deletes.
        deleted = {target.id for item in node.body for inner in ast.walk(item) if isinstance(inner, ast.Delete)
                   for target in inner.targets if isinstance(target, ast.Name)}
        start = bound - deleted
        body = self.block(node.body, bound)
        ends = [self.block(node.orelse, body) if body is not None and node.orelse else body]
        for handler in node.handlers:
            entry = self.expr(handler.type, start)
            if handler.name:
                entry = entry | {handler.name}
            out = self.block(handler.body, entry)
            ends.append(None if out is None else out - {handler.name})
        if not node.finalbody:
            return _merge(ends)
        later = {target.id for part in (node.orelse, *[h.body for h in node.handlers]) for item in part
                 for inner in ast.walk(item) if isinstance(inner, ast.Delete)
                 for target in inner.targets if isinstance(target, ast.Name)}
        final = self.block(node.finalbody, start - later - {h.name for h in node.handlers if h.name})
        after = _merge(ends)
        if after is None or final is None:
            return None
        return after | final

    do_TryStar = do_Try

    def do_With(self, node, bound):
        for item in node.items:
            bound = self.expr(item.context_expr, bound)
            if item.optional_vars is not None:
                bound = self.store(item.optional_vars, bound)
        body = self.block(node.body, bound)
        # The exit of a context manager may swallow an exception from the body.
        return bound if body is None else body & bound

    do_AsyncWith = do_With

    def do_Match(self, node, bound):
        bound = self.expr(node.subject, bound)
        ends = [bound]
        for case in node.cases:
            names = {item.name for item in ast.walk(case.pattern)
                     if isinstance(item, (ast.MatchAs, ast.MatchStar)) and item.name}
            names |= {item.rest for item in ast.walk(case.pattern) if isinstance(item, ast.MatchMapping) and item.rest}
            for item in ast.walk(case.pattern):
                if isinstance(item, ast.MatchValue):
                    self.expr(item.value, bound)
            entry = self.expr(case.guard, bound | names)
            ends.append(self.block(case.body, entry))
            if case.guard is None and isinstance(case.pattern, ast.MatchAs) and case.pattern.pattern is None:
                # ``case _`` or ``case name``: no subject gets past it.
                ends[0] = None
                break
        return _merge(ends)

    def do_FunctionDef(self, node, bound):
        for part in node.decorator_list + _defaults(node):
            bound = self.expr(part, bound)
        return bound | {node.name}

    do_AsyncFunctionDef = do_FunctionDef

    def do_ClassDef(self, node, bound):
        for part in node.decorator_list + node.bases + [keyword.value for keyword in node.keywords]:
            bound = self.expr(part, bound)
        return bound | {node.name}

    def do_Import(self, node, bound):
        return bound | {(alias.asname or alias.name).split(".")[0] for alias in node.names}

    do_ImportFrom = do_Import

    def do_Global(self, node, bound):
        return bound

    do_Nonlocal = do_Global


def _merge(states):
    states = [state for state in states if state is not None]
    if not states:
        return None
    out = states[0]
    for state in states[1:]:
        out = out & state
    return out


def analyse(node, params=None, local_names=None):
    """The reads in function ``node`` that may find a local unbound; see Flow."""
    if local_names is None:
        local_names = function_locals(node)
    if params is None:
        args = node.args
        params = [arg.arg for arg in args.posonlyargs + args.args + args.kwonlyargs]
        params += [arg.arg for arg in (args.vararg, args.kwarg) if arg is not None]
    walker = _Walker(frozenset(local_names))
    end = walker.block(node.body, frozenset(params))
    unbound = {key for key, maybe in walker.reads.items() if maybe}
    names = {walker.read_names[key] for key in unbound}
    nodes = sorted((walker.read_nodes[key] for key in unbound), key=lambda item: (item.lineno, item.col_offset))
    return Flow(unbound, names, end is not None, nodes)
