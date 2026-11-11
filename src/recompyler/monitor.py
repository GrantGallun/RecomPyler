"""Call timing and argument capture built on ``sys.monitoring`` (PEP 669).

One tool does what cProfile and a ``sys.settrace`` hook did together, but only
pays for code in the watched files:

* Code outside the watched files reports only its starts (``PY_START``, one check
  in C) until watched code calls it, so library internals run at close to full speed.
  Library code entered without a ``CALL`` event (an import, an operator or attribute
  hook, a library generator being iterated) is timed as a call out of the watched
  frame on top of the stack, so its time is not charged to that frame's self time.
* Watched code reports its calls out (``CALL``). A built-in or C callee ends with
  ``C_RETURN``/``C_RAISE``. A Python library callee gets a local ``PY_RETURN`` on
  its own code object only, never on what it calls. Self time is therefore exact,
  and the time each function spends in the libraries it calls directly is kept
  separately (``library_s``).
* Time spent in the callbacks themselves, sample copies included, is taken off a
  per-thread clock, so it is not charged to the functions being measured.
* Every thread is seen, generators and coroutines are timed across suspensions,
  a recursive function's cumulative time counts only its outermost call, and the
  tool takes a free tool ID instead of replacing ``sys.settrace``.

Arguments are sampled with a skip-ahead reservoir (Vitter's algorithm L), uniform
over all calls. The first call with each new combination of argument types is
also kept, so rare signatures can be checked even when the uniform sample misses
them.
"""

from math import exp, floor, log
from operator import is_
import os
import random
import sys
from threading import get_ident
from time import perf_counter
from types import FunctionType, MethodType
from zlib import crc32

try:
    from . import _monitor as _accelerator
except ImportError:
    _accelerator = None

_M = sys.monitoring
_E = _M.events
_GLOBAL = _E.PY_START | _E.PY_UNWIND | _E.PY_THROW
_LOCAL = _E.PY_RETURN | _E.PY_YIELD | _E.PY_RESUME | _E.CALL
# On library code entered from watched code: when that call ends or the generator resumes.
_LIBRARY_LOCAL = _E.PY_RETURN | _E.PY_YIELD | _E.PY_RESUME
# Calling one of these returns an object without running its code.
_LAZY = 0x20 | 0x80 | 0x100 | 0x200
_UNSUPPORTED = ((0x04, "takes *args"), (0x08, "takes **kwargs"), (0x20, "is a generator"),
                (0x80, "is a coroutine"), (0x200, "is an async generator"))
MAX_RARE = 16
MAX_CAPTURE_FAILURES = 32
LIST_CHECK_CALLS = 64
# Copy failures (other than size) after which an argument-type signature is skipped.
SIGNATURE_FAILURES = 4
_SCRIPT, _C, _PY = 0, 1, 2


class Stats:
    __slots__ = ("key", "qualname", "calls", "self_s", "cumulative_s", "library_s")

    def __init__(self, key, qualname):
        self.key, self.qualname = key, qualname
        self.calls, self.self_s, self.cumulative_s, self.library_s = 0, 0.0, 0.0, 0.0


class _Code:
    __slots__ = ("stats", "sampler")

    def __init__(self, stats, sampler):
        self.stats, self.sampler = stats, sampler


class _Thread:
    __slots__ = ("stack", "off", "active")

    def __init__(self):
        # Entries: [kind, info/callable/code, start, child time, library time, extra]
        self.stack, self.off, self.active = [], 0.0, {}


class Sampler:
    """A uniform sample of one function's calls plus the first call of each new
    argument-type signature."""

    def __init__(self, function, code, size, copy, seed):
        self.function, self.copy, self.size = function, copy, size
        self.names = code.co_varnames[:code.co_argcount]
        self.random = random.Random(seed)
        self.seen, self.next, self.weight = 0, 0, 1.0
        self.samples, self.rare, self.signatures = [], {}, {}
        self.failures, self.uncaptured, self.info = 0, 0, None
        # Set by the C backend: this sampler's index there, and how to stop it.
        self.index, self.stop = None, None
        # Captured samples are copies, so this is the only record of list reuse, which
        # lets a lifted function keep its converted copies between calls. The previous
        # lists are held so their ids cannot be reused.
        self.with_lists, self.reused_lists, self.previous_lists = 0, 0, None
        # Argument-type signatures whose values failed to copy SIGNATURE_FAILURES
        # times for a reason other than size: later calls with them are not tried.
        self.uncopyable, self.copy_failures = set(), {}

    def _uniform(self):
        return self.random.random() or 0.5

    def _skip(self):
        self.next += floor(log(self._uniform()) / log(1.0 - self.weight)) + 1

    def _slot(self):
        seen, size = self.seen, self.size
        if seen <= size:
            if seen == size:
                self.weight = min(exp(log(self._uniform()) / size), 1.0 - 1e-12)
                self.next = size
                self._skip()
            return seen - 1
        if seen != self.next:
            return None
        self.weight = min(self.weight * exp(log(self._uniform()) / size), 1.0 - 1e-12)
        self._skip()
        return self.random.randrange(size)

    def enter(self, frame):
        self.seen += 1
        try:
            values = frame.f_locals
            given = tuple([values[name] for name in self.names])
        except Exception:
            return None
        signature = tuple(map(type, given))
        count = self.signatures.get(signature)
        self.signatures[signature] = 1 if count is None else count + 1
        # A function whose first calls pass no lists is not checked again.
        if self.with_lists or self.seen <= LIST_CHECK_CALLS:
            lists = _lists_in(given, [])
            if lists:
                self.with_lists += 1
                previous = self.previous_lists
                if previous is not None and len(previous) == len(lists) and all(map(is_, previous, lists)):
                    self.reused_lists += 1
                self.previous_lists = lists
        slot = self._slot()
        new = count is None and len(self.rare) < MAX_RARE
        if slot is None and not new:
            return None
        return self.capture(given, slot, new)

    def capture(self, given, slot, new):
        signature = tuple(map(type, given))
        if signature in self.uncopyable:
            self._failed()
            return None
        try:
            return self.copy(given), given, slot, signature if new else None
        except Exception as exc:
            # A value of a type that cannot be copied fails the same way every time,
            # usually after walking much of the arguments; size limits vary by call.
            if "too large" not in str(exc):
                failed = self.copy_failures[signature] = self.copy_failures.get(signature, 0) + 1
                if failed >= SIGNATURE_FAILURES:
                    self.uncopyable.add(signature)
            self._failed()
            return None

    @property
    def list_reuse(self):
        """The share of calls passing lists that passed the very list objects of the call before."""
        return self.reused_lists / self.with_lists if self.with_lists else 0.0

    def leave(self, pending, result):
        inputs, given, slot, signature = pending
        try:
            # The arguments as the call left them, for functions that change them.
            sample = inputs, self.copy(result), self.copy(given)
        except Exception:
            self._failed()
            return
        if slot is not None:
            if slot >= len(self.samples):
                self.samples.append(sample)
            else:
                self.samples[slot] = sample
        if signature is not None:
            self.rare[signature] = sample

    def _failed(self):
        # Arguments or results that cannot be captured usually never can: copying a
        # large object on every call would slow the script many times over.
        self.uncaptured += 1
        self.failures += 1
        if self.failures >= MAX_CAPTURE_FAILURES and not self.samples:
            if self.info is not None:
                self.info.sampler = None
            if self.stop is not None:
                self.stop()

    def extra(self):
        """Captured calls whose argument types the uniform sample has none of."""
        covered = {tuple(map(type, arguments)) for arguments, *_ in self.samples}
        return [sample for signature, sample in self.rare.items() if signature not in covered]


def _lists_in(values, out, depth=0):
    """The list objects among ``values`` and inside tuples (two deep) among them."""
    for value in values:
        if type(value) is list:
            out.append(value)
        elif type(value) is tuple and depth < 2:
            _lists_in(value, out, depth + 1)
    return out


def _unsupported(code):
    for flag, reason in _UNSUPPORTED:
        if code.co_flags & flag:
            return reason
    if code.co_kwonlyargcount:
        return "takes keyword-only arguments"
    return None


class CallMonitor:
    """Profile the code in ``paths`` (files or folders) while it runs.

    With ``max_samples``, also capture arguments and results of plain functions
    and methods, copied with ``copy`` (which raises for values it cannot copy).
    """

    def __init__(self, paths, max_samples=0, copy=None, seed=0, bias=None, backend=None):
        self.files, self.folders = set(), []
        for path in paths:
            path = os.path.normcase(os.path.abspath(path))
            if os.path.isdir(path):
                self.folders.append(path.rstrip(os.sep) + os.sep)
            else:
                self.files.add(path)
        self.max_samples, self.copy, self.seed = max_samples if copy else 0, copy, seed
        self.stats, self.samplers, self.skipped = {}, {}, {}
        self._codes, self._watched, self._library, self._local = {}, {}, set(), []
        self._threads, self._tool, self.total_s = {}, None, 0.0
        # "c" runs the per-call path in the _monitor extension, "python" in the
        # callbacks below; None picks C when the extension is built.
        if backend is None:
            backend = "c" if _accelerator is not None else "python"
        if backend == "c" and _accelerator is None:
            raise ImportError("recompyler._monitor is not built")
        self.backend, self._core, self._indexed = backend, None, []
        # Seconds of each callback that its own clock readings miss (the call into it
        # and the return from it); None measures it on start.
        self.bias = bias

    def watches(self, filename):
        found = self._watched.get(filename)
        if found is None:
            path = os.path.normcase(os.path.abspath(filename)) if filename[:1] != "<" else filename
            found = self._watched[filename] = path in self.files or path.startswith(tuple(self.folders))
        return found

    def _register(self, code, frame):
        key = code.co_filename, code.co_name, code.co_firstlineno
        stats = self.stats.get(key)
        if stats is None:
            stats = self.stats[key] = Stats(key, getattr(code, "co_qualname", code.co_name))
        sampler = self.samplers.get(key)
        if sampler is None and self.max_samples and key not in self.skipped:
            function, reason = _function(code, frame), _unsupported(code)
            if reason is None and function is None:
                reason = "not a module-level function or a method"
            if reason is None:
                sampler = self.samplers[key] = Sampler(function, code, self.max_samples, self.copy,
                                                       crc32(f"{self.seed}:{key[1]}:{key[2]}".encode()))
            else:
                self.skipped[key] = reason
        info = self._codes[code] = _Code(stats, sampler)
        if sampler is not None and sampler.info is None:
            sampler.info = info
        _M.set_local_events(self._tool, code, _LOCAL)
        self._local.append(code)
        return info

    def __enter__(self):
        self.start()
        return self

    def __exit__(self, *_):
        self.stop()

    def start(self):
        for tool in (3, 4, _M.PROFILER_ID):
            if _M.get_tool(tool) is None:
                break
        else:
            raise RuntimeError("no free sys.monitoring tool ID")
        _M.use_tool_id(tool, "recompyler")
        self._tool = tool
        callbacks = self._core_callbacks() if self.backend == "c" else self._callbacks()
        for event, callback in callbacks.items():
            _M.register_callback(tool, event, callback)
        self._started = perf_counter()
        self._main = get_ident()
        _M.set_events(tool, _GLOBAL)

    def stop(self):
        tool = self._tool
        if tool is None:
            return
        _M.set_events(tool, 0)
        ended = perf_counter()
        for code in self._local:
            _M.set_local_events(tool, code, 0)
        _M.free_tool_id(tool)
        self._tool = None
        if self._core is not None:
            offset = self._sync()
        else:
            main = self._threads.get(self._main)
            offset = main.off if main else 0.0
        self.total_s = ended - self._started - offset

    def _core_callbacks(self):
        if self.bias is None:
            self.bias = calibrate("c")
        indexed = self._indexed

        def watch(code, frame):
            if not self.watches(code.co_filename):
                return -1
            info = self._register(code, frame)
            index = len(indexed)
            indexed.append(info)
            sampler = info.sampler
            if sampler is not None and sampler.index is None:
                sampler.index = index
                sampler.stop = lambda: core.stop_sampling(index)
                core.configure(index, sampler.size, sampler.names, sampler.random.getrandbits(64))
            return index

        def classify(code):
            if self.watches(code.co_filename):
                return True
            self._instrument(code)
            return False

        def capture(index, given, slot, new):
            sampler = indexed[index].sampler
            return None if sampler is None else sampler.capture(given, None if slot < 0 else slot, new)

        def leave(index, pending, value):
            sampler = indexed[index].sampler
            if sampler is not None:
                sampler.leave(pending, value)

        core = self._core = _accelerator.Core(_M.DISABLE, watch, classify, capture, leave, self.bias)
        return {_E.PY_START: core.on_start, _E.PY_RESUME: core.on_resume, _E.PY_THROW: core.on_resume,
                _E.PY_RETURN: core.on_return, _E.PY_YIELD: core.on_yield, _E.PY_UNWIND: core.on_unwind,
                _E.CALL: core.on_call, _E.C_RETURN: core.on_c_return, _E.C_RAISE: core.on_c_return}

    def _instrument(self, code):
        """Watch for the end of calls into library code ``code`` (see _LIBRARY_LOCAL)."""
        if code not in self._library:
            self._library.add(code)
            _M.set_local_events(self._tool, code, _LIBRARY_LOCAL)
            self._local.append(code)

    def _sync(self):
        """Copy the C backend's totals into the Python records; returns the main thread's offset."""
        core = self._core
        for index, info in enumerate(self._indexed):
            calls, own, cumulative, library = core.stats(index)
            stats = info.stats
            stats.calls += calls
            stats.self_s += own
            stats.cumulative_s += cumulative
            stats.library_s += library
        for sampler in self.samplers.values():
            if sampler.index is not None:
                state = core.sampling(sampler.index)
                if state is not None:
                    sampler.seen, sampler.signatures, _, sampler.with_lists, sampler.reused_lists = state
            sampler.stop = None
        offset = core.offset(self._main)
        self._core = None
        return offset

    def rows(self):
        return [{"function": stats.key[1], "qualname": stats.qualname, "file": stats.key[0], "line": stats.key[2],
                 "calls": stats.calls, "self_s": stats.self_s, "cumulative_s": stats.cumulative_s,
                 "library_s": stats.library_s, "_key": stats.key}
                for stats in self.stats.values() if stats.calls]

    def _callbacks(self):
        codes, threads, library, watches = self._codes, self._threads, self._library, self.watches
        register, instrument, getframe = self._register, self._instrument, sys._getframe
        bias = self.bias
        if bias is None:
            bias = self.bias = calibrate("python")

        def thread():
            state = threads.get(get_ident())
            if state is None:
                state = threads[get_ident()] = _Thread()
            return state

        def close(state, entry, now):
            """Account for an entry just popped off ``state.stack``."""
            total = now - entry[2]
            stack = state.stack
            if entry[0] == _SCRIPT:
                stats = entry[1].stats
                stats.self_s += total - entry[3]
                stats.library_s += entry[4]
                active = state.active
                depth = active[stats] = active[stats] - 1
                if not depth:
                    stats.cumulative_s += total
                if stack:
                    stack[-1][3] += total
            elif stack:
                parent = stack[-1]
                parent[3] += total
                parent[4] += total - entry[3]

        def close_calls(state, now):
            # Control is back in watched code, so any open call out of it has ended
            # (one that failed before its frame started reports nothing).
            stack = state.stack
            while stack and stack[-1][0] != _SCRIPT:
                close(state, stack.pop(), now)

        def push(state, info, now, pending):
            state.stack.append([_SCRIPT, info, now, 0.0, 0.0, pending])
            active = state.active
            active[info.stats] = active.get(info.stats, 0) + 1

        def leave(code, value, returned):
            began = perf_counter()
            state = thread()
            now = began - state.off
            info = codes[code]
            stack = state.stack
            for index in range(len(stack) - 1, -1, -1):
                entry = stack[index]
                if entry[0] == _SCRIPT and entry[1] is info:
                    break
            else:
                # A frame that began before monitoring started.
                state.off += perf_counter() - began + bias
                return
            while len(stack) > index + 1:
                close(state, stack.pop(), now)
            stack.pop()
            close(state, entry, now)
            pending = entry[5]
            if pending is not None and returned and info.sampler is not None:
                info.sampler.leave(pending, value)
            state.off += perf_counter() - began + bias

        def library_exit(code):
            began = perf_counter()
            state = threads.get(get_ident())
            if state is not None:
                stack = state.stack
                if stack and stack[-1][0] == _PY and stack[-1][1] is code:
                    # Only the call made from watched code ends it, not a recursive one.
                    caller = getframe(2).f_back
                    if caller is not None and caller.f_code is stack[-1][5]:
                        close(state, stack.pop(), began - state.off)
                state.off += perf_counter() - began + bias

        def implicit(code, frame):
            # Library code starting or resuming while a watched frame is on top of the
            # stack was entered without a CALL event: an import, an operator or
            # attribute hook, a library generator being iterated. Time it as a call
            # out of that frame. Unwatched code is never switched off, or it could
            # not be seen here later.
            began = perf_counter()
            state = threads.get(get_ident())
            if state is None or not state.stack or state.stack[-1][0] != _SCRIPT:
                return
            instrument(code)
            caller = frame.f_back
            state.stack.append([_PY, code, began - state.off, 0.0, 0.0, caller and caller.f_code])
            state.off += perf_counter() - began + bias

        def on_start(code, offset):
            began = perf_counter()
            info = codes.get(code)
            if info is None:
                if code in library or not watches(code.co_filename):
                    implicit(code, getframe(1))
                    return
                info = register(code, getframe(1))
            state = thread()
            now = began - state.off
            info.stats.calls += 1
            sampler = info.sampler
            push(state, info, now, None if sampler is None else sampler.enter(getframe(1)))
            state.off += perf_counter() - began + bias

        def on_resume(code, offset, *_):
            info = codes.get(code)
            if info is None:
                if code in library or not watches(code.co_filename):
                    implicit(code, getframe(1))
                return
            began = perf_counter()
            state = thread()
            push(state, info, began - state.off, None)
            state.off += perf_counter() - began + bias

        def on_return(code, offset, value):
            if code in codes:
                leave(code, value, True)
            else:
                library_exit(code)

        def on_yield(code, offset, value):
            if code in codes:
                leave(code, value, False)
            else:
                library_exit(code)

        def on_unwind(code, offset, exception):
            if code in codes:
                leave(code, None, False)
            elif code in library:
                library_exit(code)

        def on_call(code, offset, callee, first):
            began = perf_counter()
            state = thread()
            now = began - state.off
            close_calls(state, now)
            kind = type(callee)
            function = callee if kind is FunctionType else (callee.__func__ if kind is MethodType else None)
            if type(function) is FunctionType:
                called = function.__code__
                if not (called.co_flags & _LAZY or called in codes or watches(called.co_filename)):
                    instrument(called)
                    state.stack.append([_PY, called, now, 0.0, 0.0, code])
            else:
                state.stack.append([_C, callee, now, 0.0, 0.0, None])
            state.off += perf_counter() - began + bias

        def on_c_return(code, offset, callee, first):
            began = perf_counter()
            state = thread()
            stack = state.stack
            if stack:
                top = stack[-1]
                # A Python function reports C_RETURN too when called through a
                # non-default vectorcall; its PY_RETURN may then not be seen.
                if top[0] == _C and top[1] is callee or (
                        top[0] == _PY and type(callee) is FunctionType and callee.__code__ is top[1]):
                    close(state, stack.pop(), began - state.off)
            state.off += perf_counter() - began + bias

        return {_E.PY_START: on_start, _E.PY_RESUME: on_resume, _E.PY_THROW: on_resume, _E.PY_RETURN: on_return,
                _E.PY_YIELD: on_yield, _E.PY_UNWIND: on_unwind, _E.CALL: on_call, _E.C_RETURN: on_c_return,
                _E.C_RAISE: on_c_return}


_CALIBRATION = "<recompyler-calibration>"
_bias = {}


def calibrate(backend="python", calls=20000, rounds=5):
    """Seconds per callback that the callbacks' own clock readings miss, measured
    once per process: a loop of empty calls timed with and without monitoring."""
    if backend in _bias:
        return _bias[backend]
    space = {}
    source = "def leaf():\n    pass\ndef loop(n):\n    for _ in range(n):\n        leaf()\n"
    exec(compile(source, _CALIBRATION, "exec"), space)
    loop, residuals = space["loop"], []
    for _ in range(rounds):
        start = perf_counter()
        loop(calls)
        plain = perf_counter() - start
        monitor = CallMonitor([], bias=0.0, backend=backend)
        monitor.files.add(_CALIBRATION)
        with monitor:
            loop(calls)
        measured = next(stats.cumulative_s for stats in monitor.stats.values() if stats.key[1] == "loop")
        # Each iteration makes three callbacks: CALL, then PY_START and PY_RETURN of leaf.
        residuals.append((measured - plain) / (3 * calls))
    residuals.sort()
    _bias[backend] = max(residuals[len(residuals) // 2], 0.0)
    return _bias[backend]


def _function(code, frame):
    """The function object running ``code``: a module-level function, or a method
    found on the class of its first argument."""
    function = frame.f_globals.get(code.co_name)
    if getattr(function, "__code__", None) is code:
        return function
    if code.co_argcount:
        try:
            first = frame.f_locals.get(code.co_varnames[0])
        except Exception:
            return None
        for klass in type(first).__mro__:
            candidate = vars(klass).get(code.co_name)
            if getattr(candidate, "__code__", None) is code:
                return candidate
    return None
