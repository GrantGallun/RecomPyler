import array
import copy
import json
import os
from pathlib import Path
import random
import subprocess
import importlib.util
import runpy
import statistics
import sys
from time import perf_counter
from types import GetSetDescriptorType
import weakref

from .lift import Unsupported, _record_fields, _record_problem, lift, same
from .monitor import CallMonitor, Yielded

MAX_ELEMENTS = 4096
# A function counts as verified only if at least this share of captured calls ran compiled.
MIN_COMPILED_SHARE = 0.9
# A compiled version is recommended only if it is at least this much faster a call.
MIN_SPEEDUP = 1.05
MAX_BATCH = 65536
# Smaller batches finish before extra threads or a GPU could start up.
PARALLEL_MINIMUM = 256
GPU_MINIMUM = 1024


# Per class: its __init__ when last checked, and its record fields (None if its
# instances cannot be copied). Finding the fields parses __init__'s source, far too
# slow to repeat for every object copied while the script runs.
_CLASS_FIELDS = weakref.WeakKeyDictionary()
_ANY_FIELDS = ("<instance dictionary>",)


def _object_fields(value):
    """lift._object_fields, with the per-class part cached."""
    cls = type(value)
    init = getattr(cls, "__init__", None)
    cached = _CLASS_FIELDS.get(cls)
    if cached is None or cached[0] is not init:
        from .heap import _object_problem

        if _object_problem(cls) is not None:
            fields = None
        else:
            # A plain class whose attributes the lifter cannot list from __init__ (a
            # base class's __init__ sets some): its instance dictionary says.
            fields = _record_fields(cls) or _ANY_FIELDS
        try:
            _CLASS_FIELDS[cls] = init, fields
        except TypeError:
            pass
    else:
        fields = cached[1]
    if fields is None:
        return None
    if fields is _ANY_FIELDS:
        found = getattr(value, "__dict__", None)
        return dict(found) if found is not None else None
    if hasattr(value, "__dict__") and vars(value).keys() != set(fields):
        # Attributes set elsewhere too (a base class's __init__): copy what it holds.
        return dict(vars(value))
    try:
        return {name: getattr(value, name) for name in fields}
    except AttributeError:
        return None


def snapshot(value, budget=None):
    """Copy a value made of numbers, tuples, lists and array.array, so later mutation cannot change it.

    An object that appears more than once appears as one object in the copy.
    """
    budget = [MAX_ELEMENTS, {}] if budget is None else budget
    kind = type(value)
    if kind in (bool, int, float, type(None), str):
        budget[0] -= 1
        if budget[0] < 0:
            raise ValueError("too large to capture")
        return value
    if id(value) in budget[1]:
        return budget[1][id(value)]
    # An array is copied in one block, far cheaper per item than a list.
    budget[0] -= 1 + (len(value) // 256 if kind is array.array else 0)
    if budget[0] < 0:
        raise ValueError("too large to capture")
    if kind is array.array:
        copied = budget[1][id(value)] = array.array(value.typecode, value)
        return copied
    if kind is list:
        copied = budget[1][id(value)] = []
        copied.extend(snapshot(item, budget) for item in value)
        return copied
    if kind is tuple:
        return tuple(snapshot(item, budget) for item in value)
    if kind.__module__ == "numpy":
        copied = _numpy_copy(value, kind, budget)
        if copied is not None:
            return copied
    if kind is random.Random:
        # A generator: its state, which compiled code advances as Python would.
        copied = budget[1][id(value)] = random.Random()
        copied.setstate(value.getstate())
        copied.__dict__.update(vars(value))
        return copied
    if isinstance(value, random.Random):
        raise ValueError("cannot copy this generator")
    if kind is dict:
        copied = budget[1][id(value)] = {}
        for key, item in value.items():
            copied[snapshot(key, budget)] = snapshot(item, budget)
        return copied
    if kind is set:
        # A copy of a set of plain values keeps its order; new objects would not.
        if not all(_plain_value(item) for item in value):
            raise ValueError("a set of objects")
        budget[0] -= len(value)
        if budget[0] < 0:
            raise ValueError("too large to capture")
        copied = budget[1][id(value)] = value.copy()
        return copied

    fields = _object_fields(value)
    if fields is not None:
        # A plain object: a new instance with copies of its attributes.
        try:
            copied = budget[1][id(value)] = kind.__new__(kind)
            for name, field in fields.items():
                setattr(copied, name, snapshot(field, budget))
        except ValueError:
            raise
        except Exception:
            # The script must run as it would without the profiler.
            raise ValueError("cannot copy this object") from None
        return copied
    raise ValueError("unsupported value")


_NP_SCALARS = ("float64", "int64", "bool", "float32", "int32", "int16", "int8", "uint8", "uint16", "uint32",
               "uint64")


def _numpy_copy(value, kind, budget):
    """A copy of a numpy array (dtype, shape and read-only flag kept) or scalar;
    None for other numpy values."""
    if kind.__name__ in _NP_SCALARS:
        # Scalars are immutable.
        return value
    if kind.__name__ != "ndarray" or value.dtype.hasobject:
        return None
    budget[0] -= value.size // 256
    if budget[0] < 0:
        raise ValueError("too large to capture")
    copied = budget[1][id(value)] = value.copy()
    copied.flags.writeable = value.flags.writeable
    return copied


def _plain_value(value):
    """True for a number, str, None, or a tuple of these: values that hash the same in
    a copy."""
    if type(value) is tuple:
        return all(map(_plain_value, value))
    return type(value) in (bool, int, float, str, type(None))




def _holds_object(value):
    if type(value) in (tuple, list):
        return any(map(_holds_object, value))
    return type(value).__module__ != "builtins" and type(value).__name__ != "array"


def fresh_copy(value):
    return snapshot(value, [float("inf"), {}])


# Defining any of these changes what pickling an object does.
_PICKLE_HOOKS = ("__reduce__", "__reduce_ex__", "__getstate__", "__setstate__", "__getnewargs__",
                 "__getnewargs_ex__", "__copy__", "__deepcopy__", "__new__",
                 "__getattribute__", "__getattr__", "__slots__")


class _Copies:
    """Fresh copies of one captured argument tuple, made by unpickling a pickle of
    it: several times faster than ``fresh_copy`` for object graphs. Classes travel
    by identity, so classes a script defines under ``__main__`` work. Used only
    when each class leaves pickling to the default, and when one copy is ``same``
    as the arguments; otherwise ``fresh_copy``."""

    def __init__(self, arguments):
        import io
        import pickle

        self.blob, self.classes = None, []
        if not _plain_pickle_graph(arguments):
            return
        classes = self.classes

        class Pickler(pickle.Pickler):
            def persistent_id(self, obj):
                if type(obj) is type:
                    classes.append(obj)
                    return len(classes) - 1
                return None

        try:
            buffer = io.BytesIO()
            Pickler(buffer, protocol=5).dump(arguments)
        except Exception:
            return
        if not all(_plain_pickle(cls) for cls in classes if cls.__module__ not in ("builtins", "array")):
            return
        self.blob = buffer.getvalue()
        try:
            if not same(self._load(), arguments):
                self.blob = None
        except Exception:
            self.blob = None

    def _load(self):
        import io
        import pickle

        classes = self.classes

        class Unpickler(pickle.Unpickler):
            def persistent_load(self, pid):
                return classes[pid]

        return Unpickler(io.BytesIO(self.blob)).load()

    def __call__(self, arguments):
        return fresh_copy(arguments) if self.blob is None else self._load()


def _plain_pickle(cls):
    for klass in cls.__mro__[:-1]:
        if klass.__module__ == "builtins" or any(hook in vars(klass) for hook in _PICKLE_HOOKS):
            return False
    return True


def _plain_pickle_graph(value):
    """Check the complete graph before pickle can invoke any user copy hooks.

    Unknown types and slot-only objects use snapshot instead. Repeated references
    are visited once so ordinary cyclic object graphs still take the fast path.
    """
    pending, seen = [value], set()
    while pending:
        item = pending.pop()
        kind = type(item)
        if kind in (bool, int, float, str, type(None), bytes, array.array):
            continue
        if id(item) in seen:
            continue
        seen.add(id(item))
        if kind in (tuple, list):
            pending.extend(item)
        elif kind is dict:
            # Rebuilding keys must not invoke user-defined hashing either.
            if not all(_plain_value(key) for key in item):
                return False
            pending.extend(item.values())
        elif kind in (set, frozenset):
            if not all(_plain_value(part) for part in item):
                return False
        else:
            if not _plain_pickle(kind):
                return False
            # Only the ordinary instance dictionary is inspected. A custom
            # descriptor named __dict__ must not execute during this preflight.
            descriptor = next((vars(cls)["__dict__"] for cls in kind.__mro__
                               if "__dict__" in vars(cls)), None)
            if not isinstance(descriptor, GetSetDescriptorType):
                return False
            fields = object.__getattribute__(item, "__dict__")
            if type(fields) is not dict:
                return False
            pending.extend(fields.values())
    return True


def warm_time(function, inputs, fresh=False):
    """Seconds per call. With ``fresh``, each call gets its own copy of the captured
    arguments, made outside the timed part, so a function that changes its
    arguments always starts from the captured state."""
    copiers = [_Copies(arguments) for arguments, *_ in inputs] if fresh else None

    def timed(repeats):
        if fresh:
            elapsed = 0.0
            for _ in range(repeats):
                for (arguments, *_), copier in zip(inputs, copiers):
                    copied = copier(arguments)
                    start = perf_counter()
                    function(*copied)
                    elapsed += perf_counter() - start
            return elapsed
        start = perf_counter()
        for _ in range(repeats):
            for arguments, *_ in inputs:
                function(*arguments)
        return perf_counter() - start

    repeats = min(4096, max(1, int(0.01 / max(timed(1), 1e-9))))
    return statistics.median(timed(repeats) for _ in range(3)) / (repeats * len(inputs))


def reused_time(lifted, inputs, fresh=False):
    """Seconds per compiled call when each call gets the same list objects as the
    one before, as in the profiled run, so converted copies are reused. None if
    the calls stopped running compiled, as when repeating a call that changes its
    arguments pushes a value out of range."""
    elapsed = calls = 0
    fallbacks = lifted.fallback_calls
    for arguments, *_ in inputs[:64]:
        given = fresh_copy(arguments) if fresh else arguments
        # The cache keeps a list's copy from the second time it meets the list.
        lifted(*given)
        lifted(*given)
        start = perf_counter()
        for _ in range(16):
            lifted(*given)
        elapsed += perf_counter() - start
        calls += 16
    if not calls or lifted.fallback_calls != fallbacks:
        return None
    return elapsed / calls


def batch_time(lifted, rows, backend="cpu"):
    def timed():
        start = perf_counter()
        lifted.map(rows, backend)
        return perf_counter() - start

    return statistics.median(timed() for _ in range(3)) / len(rows)


def compare_backends(lifted, rows, expected, python_s, cpu_s):
    """Time the batch on all CPU cores and on the GPU, checking each against the captured results.

    Returns speed ratios against Python for every backend that reproduced the results,
    and the reason the GPU was left out, if it was. Timings include packing the
    arguments and, for the GPU, the transfers in both directions.
    """
    ratios, note = {"cpu": python_s / cpu_s}, None
    for backend, minimum in (("parallel", PARALLEL_MINIMUM), ("gpu", GPU_MINIMUM)):
        if len(rows) < minimum:
            continue
        try:
            if not same(lifted.map(rows, backend), expected):
                note = f"{backend} results differed from the captured calls"
            elif backend == "gpu" and lifted.gpu_note:
                note = lifted.gpu_note
            else:
                ratios[backend] = python_s / batch_time(lifted, rows, backend)
        except Exception as exc:
            note = f"{backend} could not run ({type(exc).__name__})"
    return ratios, note


def test_candidate(function, inputs, calls, list_reuse=0.0, extra=(), cumulative_s=None):
    """Test the usual lifter on one function, and where it does not apply, the
    whole-region lifter (recompyler.heap), which also takes the functions it calls."""
    result = test_lifted(function, inputs, calls, list_reuse, extra, cumulative_s)
    if result["status"] == "verified" and result["_lifted"]._records.infos:
        # Code on objects of Python classes cannot be built ahead of time by the usual
        # lifter; the region lifter's can. Keep whichever is faster a call.
        region = test_region(function, inputs, calls, extra, cumulative_s)
        if region["status"] == "verified" and region["speedup"] > result["speedup"]:
            region["lift_reason"] = f"the usual lifter was {result['speedup']:.2f}x; as a region, {region['speedup']:.2f}x"
            return region
        return result
    if result["status"] != "skipped" or not inputs:
        return result
    region = test_region(function, inputs, calls, extra, cumulative_s)
    if region["status"] == "skipped":
        result["region_reason"] = region["reason"]
        return result
    region["lift_reason"] = result["reason"]
    return region


def test_region(function, inputs, calls, extra=(), cumulative_s=None):
    """test_lifted for recompyler.heap: the function and everything it calls compiled
    as one region, with objects held in the region's own heap. Never batched.

    A region that reads objects held by module globals depends on their state, which
    the run and earlier replays have since changed. Each captured call is then checked
    against Python run on the same state: both start from a copy of the state as it
    is now, which is put back afterwards. Running the original is safe here: a region
    compiles only if its whole body does, so it changes nothing but those objects."""
    from .heap import lift_region

    start = perf_counter()
    try:
        region = lift_region(function)
    except Unsupported as exc:
        return {"status": "skipped", "reason": f"as a region: {exc}"}
    saved = []
    if inputs:
        arguments = tuple(fresh_copy(inputs[0][0]))
        if function.__code__.co_flags & _GENERATORS:
            # Discovery uses the same collecting-list parameter as attempt(),
            # even before any generator code is executed.
            arguments += ([],)
        program = region.program_for(arguments)
        for namespace, name, _ in getattr(program, "global_objects", ()):
            value = namespace.get(name)
            try:
                state = _global_state(value)
            except Exception:
                return {"status": "skipped", "reason": f"as a region: the global '{name}' cannot be copied"}
            if state is not None:
                saved.append((value, state))
    def reset():
        for value, state in saved:
            _restore_global(value, state)

    def reference(arguments):
        """(result, arguments afterwards) from Python on the state as it is now, or
        None if Python raises."""
        reset()
        given = fresh_copy(arguments)
        try:
            if function.__code__.co_flags & _GENERATORS:
                result = Yielded(_collected(function)(*given), True, False)
            else:
                result = (_driven(function) if function.__code__.co_flags & 0x80 else function)(*given)
        except Exception:
            return None
        finally:
            reset()
        return result, given

    try:
        return _test_region(region, function, inputs, calls, extra, cumulative_s, start,
                            reference if saved else None, reset)
    finally:
        for value, state in saved:
            _restore_global(value, state)


def _global_state(value):
    """Shallow states of the original reachable nodes, retaining every edge's identity."""
    pending, seen, nodes = [value], set(), []
    while pending:
        item = pending.pop()
        if id(item) in seen:
            continue
        seen.add(id(item))
        kind = type(item)
        if kind in (str, bool, int, float, bytes, type(None)):
            continue
        if kind is tuple:
            pending.extend(item)
        elif kind is list:
            state = tuple(item)
            nodes.append((item, "list", state))
            pending.extend(state)
        elif kind is dict:
            if not all(_plain_value(key) for key in item):
                raise ValueError("cannot restore custom global keys")
            state = dict(item)
            nodes.append((item, "dict", state))
            pending.extend(state.values())
        elif kind is set:
            if not all(_plain_value(part) for part in item):
                raise ValueError("cannot restore a global set of objects")
            nodes.append((item, "set", item.copy()))
        elif kind is array.array:
            nodes.append((item, "array", item[:]))
        elif kind.__name__ == "ndarray" and kind.__module__ == "numpy":
            if item.dtype.hasobject:
                raise ValueError("cannot restore a global object array")
            nodes.append((item, "numpy", item.copy()))
        elif kind is random.Random:
            fields = dict(vars(item))
            nodes.append((item, "random", (item.getstate(), fields)))
            pending.extend(fields.values())
        else:
            if _object_fields(item) is None or not hasattr(item, "__dict__"):
                raise ValueError("cannot restore this global object")
            state = dict(vars(item))
            nodes.append((item, "object", state))
            pending.extend(state.values())
    return nodes or None


def _restore_global(value, state):
    if state is None:
        return
    for item, kind, saved in state:
        if kind in ("list", "array"):
            item[:] = saved
        elif kind in ("dict", "set"):
            item.clear()
            item.update(saved)
        elif kind == "numpy":
            if item.flags.writeable:
                item[...] = saved
        else:
            if kind == "random":
                item.setstate(saved[0])
                saved = saved[1]
            vars(item).clear()
            vars(item).update(saved)


def _test_region(region, function, inputs, calls, extra, cumulative_s, start, reference=None, reset=None):
    from .heap import lift_region

    mutates = any(not same(arguments, after) for arguments, _, after in inputs)
    compiled = fallback = 0
    try:
        # Only the compiled path runs here, never the original: a function that is not
        # known to be free of side effects must not be called again. One that compiles
        # is, since its whole body had to fit the compiled subset.
        for arguments, expected, after in inputs:
            if reference is not None:
                found = reference(arguments)
                if found is None:
                    fallback += 1
                    continue
                expected, after = found
            given = fresh_copy(arguments)
            ok, got = region.attempt(tuple(given))
            if reset is not None:
                reset()
            if not ok:
                fallback += 1
                continue
            compiled += 1
            if not _same_result(got, expected):
                return {"status": "rejected", "engine": "region", "reason": "result differs from a captured call"}
            if not same(given, after):
                return {"status": "rejected", "engine": "region",
                        "reason": "arguments were changed differently from a captured call"}
        for arguments, expected, after in extra:
            if reference is not None:
                found = reference(arguments)
                if found is None:
                    continue
                expected, after = found
            given = fresh_copy(arguments)
            ok, got = region.attempt(tuple(given))
            if reset is not None:
                reset()
            if ok and (not _same_result(got, expected) or not same(given, after)):
                return {"status": "rejected", "engine": "region",
                        "reason": "a call with rarer argument types gave a different result"}
        if not compiled:
            why = region.problem or (f"a check at {region.gave_up[0]} line {region.gave_up[1]} sent it back to Python"
                                     if region.gave_up else "it handed every captured call back to Python")
            return {"status": "skipped", "reason": f"as a region: {why}"}
        if compiled < MIN_COMPILED_SHARE * len(inputs):
            return {"status": "skipped", "reason": f"as a region, only {compiled} of {len(inputs)} captured calls "
                                                   "ran compiled"}
        first_pass = perf_counter() - start
        # A later run loads the region from an ahead-of-time module: it pays for type
        # inference and code generation, not for Numba. Stand the compiled functions
        # in for the module's to time that.
        built = {program.digest: program.run for program in region.programs.values()
                 if program is not None and not program.broken and hasattr(program, "digest")}
        if function.__code__.co_flags & _GENERATORS:
            # A generator function's call only makes a generator: time running it to
            # its end, in a loop that lets the compiled version run.
            drained = _drained_async if function.__code__.co_flags & 0x200 else _drained
            python_s = warm_time(drained(function), inputs, fresh=mutates)
            compiled_s = warm_time(drained(_region_values(region)), inputs, fresh=mutates)
            warm_start = warm_start_time(function, inputs, lambda fn: drained(_region_values(lift_region(fn, built))))
        elif function.__code__.co_flags & 0x80:
            # A coroutine function's call only makes a coroutine: time running it.
            python_s = warm_time(_driven(function), inputs, fresh=mutates)
            compiled_s = warm_time(_driven(region), inputs, fresh=mutates)
            warm_start = warm_start_time(function, inputs, lambda fn: _driven(lift_region(fn, built)))
        else:
            python_s = warm_time(function, inputs, fresh=mutates)
            compiled_s = warm_time(region, inputs, fresh=mutates)
            warm_start = warm_start_time(function, inputs, lambda fn: lift_region(fn, built))
    except Exception as exc:
        return {"status": "rejected", "engine": "region",
                "reason": f"a captured call raised {type(exc).__name__} when replayed"}
    advice = recommend(calls, python_s, compiled_s, first_pass, warm_start, cumulative_s)
    cached = all(getattr(program, "cached", False) for program in region.programs.values() if program is not None)
    return {"status": "verified", "engine": "region", "_lifted": None, "_rows": None, "_region": region,
            "samples": len(inputs), "compiled_samples": compiled, "fallback_samples": fallback,
            "rare_samples_checked": len(extra), **advice, "first_pass_s": first_pass, "warm_start_s": warm_start,
            "python_us_per_call": python_s * 1e6, "compiled_cpu_us_per_call": compiled_s * 1e6,
            "speedup": python_s / compiled_s, "changes_arguments": mutates, "disk_cached": cached,
            "batch_backends": {}, "backend_note": "not batched: compiled as one region"}


_GENERATORS = 0x20 | 0x200


def _same_result(got, expected):
    """same(), where a generator's captured result is the values it yielded: compiled,
    it gives them all in a list. A call closed early or cut short when captured is
    compared on the values it gave."""
    if type(expected) is not Yielded:
        return same(got, expected)
    if type(got) is not list or len(got) < len(expected.values) or (expected.finished and (
            len(got) != len(expected.values) or expected.value is not None)):
        return False
    return same(got[:len(expected.values)], expected.values)


def _collected(function):
    """``function``, a generator or async generator function, as a plain function
    that returns the list of what it yields."""
    if function.__code__.co_flags & 0x200:
        async def collect(*args):
            return [value async for value in function(*args)]

        return _driven(collect)
    return lambda *args: list(function(*args))


def _region_values(region):
    """A generator function that runs ``region``'s compiled version, as ``recompyler
    run`` does for a loop that does nothing with the values: all at once."""
    from .heap import _replay

    if region.original.__code__.co_flags & 0x200:
        def values(*args):
            found = region.values(args)
            return region.original(*args) if found is None else _replay(found)
    else:
        def values(*args):
            found = region.values(args)
            return region.original(*args) if found is None else iter(found)
    return values


def _drained(function):
    """``function``, a generator function, as a plain function that runs the
    generator to its end in a loop that only stores each value."""
    def run(*args):
        for _ in function(*args):
            pass

    return run


def _drained_async(function):
    """_drained for an async generator function, run without an event loop."""
    async def run(*args):
        async for _ in function(*args):
            pass

    return _driven(run)


def _driven(function):
    """``function``, a coroutine function, as a plain function: it runs the coroutine
    to the end without an event loop and returns its result."""
    def run(*args):
        coroutine = function(*args)
        try:
            while True:
                coroutine.send(None)
        except StopIteration as stop:
            return stop.value

    return run


def test_lifted(function, inputs, calls, list_reuse=0.0, extra=(), cumulative_s=None):
    """Lift one function and compare it with what the script itself computed.

    A function that lifts is pure, so calling it again here cannot repeat a side effect.
    ``list_reuse`` is the share of the run's calls that passed the same list objects
    as the call before; the compiled time per call is weighted between reusing
    converted copies and converting afresh by that share. ``extra`` holds captured
    calls with argument types the uniform sample lacks: they are checked for
    correctness only, so they do not skew the compiled share or the timings.
    """
    start = perf_counter()
    try:
        lifted = lift(function)
    except Unsupported as exc:
        return {"status": "skipped", "reason": f"outside the supported subset: {exc}"}
    if not inputs:
        return {"status": "skipped", "reason": "no calls with numeric arguments and results were captured"}
    rows = [arguments for arguments, *_ in inputs]
    repeats = -(-min(max(calls, len(rows)), MAX_BATCH) // len(rows))
    # A function that changes its arguments is checked on what it leaves in them too,
    # and is not batched: its calls are not independent of each other.
    mutates = any(not same(arguments, after) for arguments, _, after in inputs)
    # Objects travel one call at a time, so batches of them would only replay Python.
    objects = any(_holds_object(arguments) for arguments, *_ in inputs)
    try:
        for arguments, expected, after in inputs:
            given = fresh_copy(arguments)
            if not same(lifted(*given), expected):
                return {"status": "rejected", "reason": "result differs from a captured call"}
            if not same(given, after):
                return {"status": "rejected", "reason": "arguments were changed differently from a captured call"}
        compiled, fallback = lifted.compiled_calls, lifted.fallback_calls
        for arguments, expected, after in extra:
            given = fresh_copy(arguments)
            if not same(lifted(*given), expected) or not same(given, after):
                return {"status": "rejected", "reason": "a call with rarer argument types gave a different result"}
        if not compiled:
            return {"status": "skipped", "reason": "the compiled version did not apply to the captured calls"}
        if compiled < MIN_COMPILED_SHARE * len(inputs):
            return {"status": "skipped", "samples": len(inputs), "compiled_samples": compiled,
                    "reason": f"only {compiled} of {len(inputs)} captured calls ran compiled; the rest fell back to Python"}
        first_pass = perf_counter() - start
        python_s = warm_time(function, inputs, fresh=mutates)
        # Time compiled calls without the list cache: a small sample would otherwise
        # reuse copies whether or not the run did.
        cache = lifted._list_cache
        enabled, cache.enabled = cache.enabled, False
        try:
            fresh_s = warm_time(lifted, inputs, fresh=mutates)
        finally:
            cache.enabled = enabled
        reused_s = reused_time(lifted, inputs, fresh=mutates) if list_reuse and enabled else None
        cache.entries.clear()
        compiled_s = fresh_s if reused_s is None else list_reuse * reused_s + (1 - list_reuse) * fresh_s
        reason = "changes its arguments" if mutates else "takes objects"
        ratios, note, batch, batch_s = {}, f"not batched: the function {reason}", [], None
        if not (mutates or objects):
            batch, batch_expected = rows * repeats, [expected for _, expected, _ in inputs] * repeats
            if not same(lifted.map(batch), batch_expected):
                return {"status": "rejected", "reason": "batched result differs from a captured call"}
            batch_s = batch_time(lifted, batch)
            ratios, note = compare_backends(lifted, batch, batch_expected, python_s, batch_s)
        warm_start = warm_start_time(function, inputs)
    except Exception as exc:
        return {"status": "rejected", "reason": f"a captured call raised {type(exc).__name__} when replayed"}
    advice = recommend(calls, python_s, compiled_s, first_pass, warm_start, cumulative_s)
    # "_lifted" and "_rows" stay in this process: an ahead-of-time build needs them.
    return {"status": "verified", "_lifted": lifted, "_rows": rows,
            "samples": len(inputs), "compiled_samples": compiled, "fallback_samples": fallback,
            "rare_samples_checked": len(extra),
            **advice, "first_pass_s": first_pass, "warm_start_s": warm_start, "python_us_per_call": python_s * 1e6,
            "compiled_cpu_us_per_call": compiled_s * 1e6, "speedup": python_s / compiled_s,
            "list_reuse": list_reuse, "compiled_fresh_us_per_call": fresh_s * 1e6,
            "compiled_reused_us_per_call": reused_s and reused_s * 1e6,
            "changes_arguments": mutates, "batch_size": len(batch),
            "batch_us_per_call": batch_s and batch_s * 1e6, "batch_speedup": batch_s and python_s / batch_s,
            "batch_backends": ratios, "best_backend": max(ratios, key=ratios.get) if ratios else None,
            "backend_note": note}


def warm_start_time(function, inputs, lifter=lift):
    """Seconds to lift ``function`` again and make its first calls, with the compiled
    code now in the disk cache: what a later run of the script pays to start."""
    start = perf_counter()
    again = lifter(function)
    for arguments, *_ in inputs[:4]:
        again(*fresh_copy(arguments))
    return perf_counter() - start


def recommend(calls, python_s, compiled_s, first_pass_s, warm_start_s, cumulative_s=None):
    """Whether swapping in the compiled version pays off for a run like the profiled one.

    It must be at least MIN_SPEEDUP faster a call, and the time it saves over the
    run's calls must exceed its start-up cost once the compiled code is cached.
    Batch speedups are not counted: they need the caller rewritten to batch.
    """
    saved = calls * (python_s - compiled_s)
    if cumulative_s is not None and python_s > 0:
        # The run spent cumulative_s in the function, nested calls counted once; a
        # recursive function's inner calls are part of its outer ones, so calls times
        # the saving a call would count them again.
        saved = min(saved, cumulative_s * max(0.0, 1 - compiled_s / python_s))
    net_cold, net_warm = saved - first_pass_s, saved - warm_start_s
    ratio = python_s / compiled_s
    if ratio < MIN_SPEEDUP:
        verdict, why = False, f"one call at a time it is {ratio:.2f}x Python"
    elif net_warm <= 0:
        verdict, why = False, (f"it would save {saved * 1000:.1f} ms over {calls:,} calls, less than the "
                               f"{warm_start_s * 1000:.0f} ms it takes to start")
    elif net_cold > 0:
        verdict, why = True, f"saves {net_cold * 1000:.0f} ms on the first run, compile time included"
    else:
        verdict, why = True, f"saves {net_warm * 1000:.0f} ms a run once the compiled code is cached"
    return {"recommended": verdict, "recommendation": why, "net_s_first_run": net_cold, "net_s_cached": net_warm}


def profile_script(script, script_args, limit, sample_limit, try_compile, include=(), declared=None):
    """Run ``script`` once, timing the functions in it and in ``include`` (more files
    or folders), and test compiled versions of the hottest ones.

    ``declared`` maps script inputs to the number types they can select
    (``recompyler.variants``); those variants are checked and built as well."""
    can_compile = try_compile and importlib.util.find_spec("numba") is not None
    monitor = CallMonitor([script, *include], sample_limit if can_compile else 0, snapshot)
    original_argv, original_path = sys.argv, sys.path[:]
    try:
        sys.argv = [str(script), *script_args]
        sys.path.insert(0, str(script.parent))
        with monitor:
            try:
                runpy.run_path(str(script), run_name="__main__")
            except SystemExit as exc:
                if exc.code is not None and exc.code != 0:
                    raise
    finally:
        sys.argv = original_argv
        sys.path[:] = original_path

    rows = monitor.rows()
    rows.sort(key=lambda item: item["self_s"], reverse=True)
    rows, samplers = rows[:limit], []
    for row in rows:
        key = row.pop("_key")
        if row["file"] == str(script):
            del row["file"]
        sampler = monitor.samplers.get(key)
        samplers.append(sampler)
        if sampler is not None:
            row["signatures"] = len(sampler.signatures)
            if sampler.generator:
                # How the sampled calls were consumed: to the end, closed early (a
                # break, any(), next() then dropped) or cut short when sampling.
                ended = sampler.finished + sampler.closed + sampler.truncated
                row["generator"] = {"sampled_calls": ended, "finished": sampler.finished,
                                    "closed_early": sampler.closed, "cut_short": sampler.truncated,
                                    "yields_per_sampled_call": sampler.yields / ended if ended else 0.0}
        if not try_compile:
            candidate = {"status": "skipped", "reason": "profiling only"}
        elif not can_compile:
            candidate = {"status": "skipped", "reason": "install the compile extra to try CPU compilation"}
        elif sampler is None:
            candidate = {"status": "skipped", "reason": f"not captured: the function {monitor.skipped.get(key)}"}
        else:
            candidate = test_candidate(sampler.function, sampler.samples, row["calls"], sampler.list_reuse,
                                       sampler.extra(), row.get("cumulative_s"))
        row["candidate"] = candidate
    # total_s is the whole run with the profiler's own time taken out.
    report = {"script": str(script), "profiler": monitor.backend, "total_s": monitor.total_s,
              "script_self_s": sum(row["self_s"] for row in monitor.rows()), "functions": rows}
    if declared:
        from .variants import add_variants

        report["declared"] = add_variants(script, rows, declared)
    chosen = [(row, sampler) for row, sampler in zip(rows, samplers) if row["candidate"].get("recommended")]
    section = None
    # Regions are not built ahead of time; they run through Numba's JIT and disk cache.
    built = [(row, sampler) for row, sampler in chosen if row["candidate"].get("engine") != "region"]
    if built:
        section = build_ahead_of_time([((row["function"], row["line"]), sampler.function,
                                         row["candidate"]["_lifted"], row["candidate"]["_rows"])
                                        for row, sampler in built])
    regions = [(row, sampler) for row, sampler in chosen if row["candidate"].get("engine") == "region"]
    region_section = None
    if regions:
        region_section = build_regions_ahead_of_time([((row["function"], row["line"]), sampler.function,
                                                       row["candidate"]["_region"]) for row, sampler in regions])
    for row in rows:
        row["candidate"].pop("_lifted", None)
        row["candidate"].pop("_rows", None)
        row["candidate"].pop("_captured", None)
        row["candidate"].pop("_region", None)
    if chosen:
        report["plan"] = run_plan([row["candidate"] for row, _ in chosen], section, region_section)
    return report


def build_regions_ahead_of_time(entries):
    """build_ahead_of_time for regions (recompyler.heap.build_regions)."""
    from .lift import _cache_dir

    folder = _cache_dir()
    if folder is None:
        return None
    try:
        from .heap import build_regions

        return build_regions(entries, folder)
    except Exception as exc:
        print(f"recompyler: ahead-of-time build of regions skipped ({type(exc).__name__}: {str(exc)[:120]})",
              file=sys.stderr)
        return None


def build_ahead_of_time(entries):
    """Compile the recommended functions into an extension module in the cache
    directory, so ``recompyler run`` can skip loading Numba. None if it cannot."""
    from .lift import _cache_dir

    folder = _cache_dir()
    if folder is None:
        return None
    try:
        from .aot import build

        return build(entries, folder)
    except Exception as exc:
        # No C compiler, or code that pycc cannot export: run mode uses the JIT.
        print(f"recompyler: ahead-of-time build skipped ({type(exc).__name__}: {str(exc)[:120]})", file=sys.stderr)
        return None


def process_startup(ahead_of_time=False):
    """Seconds a fresh process spends loading the compiler before any compiled call.

    With ``ahead_of_time``, what loading the lifter and NumPy costs when the compiled
    code comes from a built extension module and Numba is never imported. Measured
    once in a separate process and kept in the cache directory.
    """
    from .lift import _cache_dir, _runtime_key

    folder = _cache_dir()
    kind = "startup-aot-regions" if ahead_of_time else "startup"
    saved = folder and folder / f"{kind}-{_runtime_key()[:24]}.json"
    if saved:
        try:
            return float(json.loads(saved.read_text(encoding="utf-8")))
        except (OSError, ValueError):
            pass
    # Load the compiler and make one compiled call from the disk cache: the first
    # compiled call in a process also sets up LLVM and Numba's type system.
    sample = folder / "startup_probe.py" if folder else None
    if sample and not sample.exists():
        sample.write_text("def probe(n):\n    total = 0.0\n    for i in range(n):\n        total += i * 0.5\n"
                          "    return total\n", encoding="utf-8")
    if ahead_of_time:
        probe = ("import time; start = time.perf_counter(); import numpy; import recompyler.aot, recompyler.heap; "
                 "print(time.perf_counter() - start)")
    else:
        probe = ("import sys, time; start = time.perf_counter(); from recompyler.lift import _runtime, _math_agrees, lift; "
             "_runtime(); _math_agrees(); "
             + (f"sys.path.insert(0, {str(folder)!r}); import startup_probe; lift(startup_probe.probe)(10); "
                if sample else "")
             + "print(time.perf_counter() - start)")
    environment = dict(os.environ, PYTHONPATH=os.pathsep.join(filter(None, (
        str(Path(__file__).resolve().parents[1]), os.environ.get("PYTHONPATH")))))
    try:
        # The first run fills the self-test cache; the second is what a later run pays.
        for _ in range(2):
            done = subprocess.run([sys.executable, "-c", probe], capture_output=True, text=True, timeout=300,
                                  env=environment)
        seconds = float(done.stdout.strip().splitlines()[-1])
    except (OSError, ValueError, IndexError, subprocess.SubprocessError):
        return 1.0
    if saved:
        try:
            saved.write_text(json.dumps(seconds), encoding="utf-8")
        except OSError:
            pass
    return seconds


def run_plan(chosen, section=None, region_section=None):
    """Whether ``recompyler run`` pays off for the whole script: the recommended
    functions must together save more than a process spends loading the compiler.

    When every recommended function went into an ahead-of-time module, a run never
    loads Numba, so its much smaller start-up is what counts.
    """
    built = (len(section["functions"]) if section else 0) + (len(region_section["functions"]) if region_section else 0)
    covered = built == len(chosen)
    startup = process_startup(ahead_of_time=covered)
    saving = sum(candidate["net_s_cached"] for candidate in chosen)
    plan = {"startup_s": startup, "saving_s": saving, "worth_running": saving > startup}
    if section is not None:
        plan["aot"] = section
    if region_section is not None:
        plan["aot_regions"] = region_section
    return plan


def print_profile(report):
    print(f"\nRecomPyler profile — {report['script']}", file=sys.stderr)
    for row in report["functions"]:
        print(f"{row['function']}:{row['line']}  {row['calls']:,} calls  {row['self_s'] * 1000:.3f} ms self",
              file=sys.stderr)
        candidate = row["candidate"]
        if candidate["status"] == "verified":
            what = ("Compiled as one region with the functions it calls,"
                    if candidate.get("engine") == "region" else "Compiled CPU version")
            print(f"  {what} matched {candidate['samples']} captured calls exactly "
                  f"({candidate['fallback_samples']} needed the Python fallback).", file=sys.stderr)
            batches = (f"Batches of {candidate['batch_size']:,}: "
                       + ", ".join(f"{backend} {ratio:.2f}x" for backend, ratio in candidate["batch_backends"].items())
                       + f" (fastest: {candidate['best_backend']})." if candidate["batch_backends"] else "")
            print(f"  One call at a time: {candidate['speedup']:.2f}x. {batches}".rstrip(), file=sys.stderr)
            if candidate["backend_note"]:
                print(f"  Note: {candidate['backend_note']}.", file=sys.stderr)
            verdict = "Recommended" if candidate["recommended"] else "Not recommended"
            print(f"  {verdict}: {candidate['recommendation']}.", file=sys.stderr)
        else:
            print(f"  {candidate['status']}: {candidate['reason']}", file=sys.stderr)
    plan = report.get("plan")
    if plan:
        verdict = "worth it" if plan["worth_running"] else "not worth it"
        print(f"\nRunning with recompyler run: {verdict}. The recommended functions save about "
              f"{plan['saving_s'] * 1000:.0f} ms a run; loading the compiler takes about "
              f"{plan['startup_s'] * 1000:.0f} ms.", file=sys.stderr)
