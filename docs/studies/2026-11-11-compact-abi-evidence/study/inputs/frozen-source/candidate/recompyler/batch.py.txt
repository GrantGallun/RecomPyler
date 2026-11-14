"""Run independent calls of a compiled function as one batch, on one or more CPU cores or the GPU.

``recompyler run`` finds places in a script where one function is applied to many
inputs and nothing else happens in between:

- ``[f(a, b) for x in xs if ...]``
- ``sum(f(x) for x in xs)``, and the same with ``list``, ``tuple``, ``min``, ``max``, ``sorted``
- ``list(map(f, xs, ys))`` and the same consumers around ``map``
- ``Pool.map``, ``Pool.starmap`` and ``Executor.map`` (thread or process pools)

Each site becomes "build the argument rows, then run them all as one compiled loop".
The function must be one the profile verified for batches, which means it returns a
number and leaves its arguments alone, so running every call first and in any order
gives the same results as Python. Rows the compiled loop cannot answer are run by
Python afterwards, in order, so the first exception is the one Python would raise.
Anything else at the site (a different function, a shadowed builtin, no compiled
version) runs the original expression unchanged.
"""

import ast
import builtins
import functools

READY = "__recompyler_batch_ready__"
RUN = "__recompyler_batch__"
# Consumers that read a whole iterable in order, so computing every element first
# gives the same result. Anything lazy (any, all, next, for loops) is left alone.
CONSUMERS = ("sum", "list", "tuple", "min", "max", "sorted")
# The profile's minimum batch sizes for each backend (profiler.PARALLEL_MINIMUM, GPU_MINIMUM).
MINIMUM = {"cpu": 0, "parallel": 256, "gpu": 1024}


def choose(ratios, rows):
    """The backend the profile measured fastest among those worth starting for ``rows`` rows."""
    usable = {backend: ratio for backend, ratio in ratios.items() if rows >= MINIMUM.get(backend, 0)}
    return max(usable, key=usable.get) if usable else "cpu"


class Sites(ast.NodeTransformer):
    """Rewrite the batch sites that call one of ``names`` (function names in the script)."""

    def __init__(self, names):
        self.names, self.found = set(names), []

    def _target(self, call):
        """The function name if ``call`` is a plain positional call to one of ``names``."""
        if (isinstance(call, ast.Call) and isinstance(call.func, ast.Name) and call.func.id in self.names
                and not call.keywords and not any(isinstance(arg, ast.Starred) for arg in call.args)):
            return call.func.id
        return None

    def _rows(self, comprehension):
        """``[(args,) for ...]`` from a comprehension whose element is the call."""
        row = ast.Tuple(elts=comprehension.elt.args, ctx=ast.Load())
        return ast.ListComp(elt=row, generators=comprehension.generators)

    def _site(self, node, name, rows, consumer=None):
        """``(consumer(RUN(f, rows)) if READY(f, consumer) else node)``, with the original kept."""
        function = ast.Name(id=name, ctx=ast.Load())
        test_args = [function] + ([ast.Name(id=consumer, ctx=ast.Load())] if consumer else [])
        test = ast.Call(func=ast.Name(id=READY, ctx=ast.Load()), args=test_args, keywords=[])
        batch = ast.Call(func=ast.Name(id=RUN, ctx=ast.Load()),
                         args=[ast.Name(id=name, ctx=ast.Load()), rows], keywords=[])
        if consumer:
            batch = ast.Call(func=ast.Name(id=consumer, ctx=ast.Load()), args=[batch], keywords=[])
        self.found.append((name, node.lineno))
        replaced = ast.IfExp(test=test, body=batch, orelse=node)
        return ast.copy_location(ast.fix_missing_locations(ast.copy_location(replaced, node)), node)

    def visit_ListComp(self, node):
        self.generic_visit(node)
        name = self._target(node.elt)
        if name is None or any(generator.is_async for generator in node.generators):
            return node
        return self._site(node, name, self._rows(node))

    def visit_Call(self, node):
        self.generic_visit(node)
        if not (isinstance(node.func, ast.Name) and node.func.id in CONSUMERS
                and len(node.args) == 1 and not node.keywords):
            return node
        consumer, inner = node.func.id, node.args[0]
        if isinstance(inner, ast.GeneratorExp):
            name = self._target(inner.elt)
            if name is not None and not any(generator.is_async for generator in inner.generators):
                return self._site(node, name, self._rows(inner), consumer)
        if (isinstance(inner, ast.Call) and isinstance(inner.func, ast.Name) and inner.func.id == "map"
                and len(inner.args) >= 2 and not inner.keywords
                and isinstance(inner.args[0], ast.Name) and inner.args[0].id in self.names
                and not any(isinstance(arg, ast.Starred) for arg in inner.args)):
            # map stops at the shortest iterable, as zip does.
            rows = ast.Call(func=ast.Name(id="list", ctx=ast.Load()), keywords=[], args=[
                ast.Call(func=ast.Name(id="zip", ctx=ast.Load()), args=inner.args[1:], keywords=[])])
            # The original is kept for the fallback; it calls the builtin map.
            return self._site(node, inner.args[0].id, rows, consumer)
        return node


class Batches:
    """The runtime side of the rewritten sites and pool interception for one run.

    ``ratios`` maps each batch function's (name, line) to the profile's measured batch
    speed ratios per backend. Functions are compiled on first use with Numba, even if
    single calls use an ahead-of-time module, because batch loops are made at run time.
    """

    def __init__(self, ratios):
        self.ratios, self.lifted, self.failed, self.used = ratios, {}, {}, {}
        # Functions used only at batch sites stay unwrapped; they are recognised by identity.
        self.plain = {}

    def mark(self, fn):
        self.plain[id(fn)] = fn
        return fn

    def _original(self, fn):
        original = getattr(fn, "__recompyler_original__", None)
        return original if original is not None else self.plain.get(id(fn))

    def lifted_for(self, fn):
        """The compiled version of a stand-in made by ``recompyler run``, or None."""
        original = self._original(fn)
        if original is None:
            return None
        key = original.__name__, original.__code__.co_firstlineno
        if key not in self.ratios or key in self.failed:
            return None
        found = self.lifted.get(key)
        if found is None:
            reuse = getattr(fn, "__recompyler_lifted__", None)
            found = reuse() if reuse is not None else None
            if found is None or type(found).__name__ != "Lifted":
                try:
                    from .lift import lift

                    found = lift(original)
                except Exception as exc:
                    self.failed[key] = f"{type(exc).__name__}: {exc}"
                    return None
            self.lifted[key] = found
        return found

    def ready(self, fn, consumer=None):
        if consumer is not None and getattr(builtins, consumer.__name__, None) is not consumer:
            return False
        return self.lifted_for(fn) is not None

    def run(self, fn, rows):
        lifted = self.lifted_for(fn)
        original = self._original(fn)
        key = original.__name__, original.__code__.co_firstlineno
        backend = choose(self.ratios[key], len(rows))
        before = lifted.compiled_calls, lifted.fallback_calls
        stats = self.used.setdefault(original.__qualname__, {"batches": 0, "rows": 0, "compiled": 0,
                                                             "fallback": 0, "backends": {}})
        try:
            return lifted.map(rows, backend)
        finally:
            # Counted even when a row Python reran raised, as Python itself would.
            stats["batches"] += 1
            stats["rows"] += len(rows)
            stats["compiled"] += lifted.compiled_calls - before[0]
            stats["fallback"] += max(lifted.fallback_calls - before[1], 0)
            stats["backends"][backend] = stats["backends"].get(backend, 0) + 1

    def namespace(self):
        return {READY: self.ready, RUN: self.run}

    def intercept(self):
        """Patch ``Pool.map``/``starmap`` and ``Executor.map`` for the run; returns an undo function."""
        import concurrent.futures
        import concurrent.futures.process
        import multiprocessing.pool

        patches = []

        def patch(owner, name, make):
            original = owner.__dict__[name]
            setattr(owner, name, functools.wraps(original)(make(original)))
            patches.append((owner, name, original))

        def pool_map(star):
            def make(original):
                def method(pool, func, iterable, chunksize=None):
                    if self.ready(func):
                        rows = [tuple(args) for args in iterable] if star else [(item,) for item in iterable]
                        return self.run(func, rows)
                    return original(pool, func, iterable, chunksize)
                return method
            return make

        def executor_map(original):
            def method(executor, fn, *iterables, **options):
                if self.ready(fn) and iterables:
                    rows = list(zip(*iterables))
                    try:
                        results = self.run(fn, rows)
                    except Exception:
                        # Executor.map raises when the failing result is reached, not
                        # here; the function is pure, so let the pool redo it its way.
                        return original(executor, fn, *zip(*rows), **options)
                    return iter(results)
                return original(executor, fn, *iterables, **options)
            return method

        patch(multiprocessing.pool.Pool, "map", pool_map(False))
        patch(multiprocessing.pool.Pool, "starmap", pool_map(True))
        patch(concurrent.futures.Executor, "map", executor_map)
        patch(concurrent.futures.process.ProcessPoolExecutor, "map", executor_map)

        def undo():
            for owner, name, original in reversed(patches):
                setattr(owner, name, original)
        return undo


def plan_ratios(data):
    """(name, line) -> batch speed ratios for functions the profile verified for batches.

    A function qualifies when its fastest batch backend beat Python by at least 5%,
    including the cost of packing arguments and any GPU transfers.
    """
    picks = {}
    for row in data.get("functions") or []:
        candidate = row.get("candidate", {})
        ratios = candidate.get("batch_backends") or {}
        if candidate.get("status") == "verified" and ratios and max(ratios.values()) >= 1.05:
            picks[row["function"], row["line"]] = ratios
    return picks
