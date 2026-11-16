"""Opt in to a measured CPU optimization on explicitly verified inputs."""

from functools import wraps
import statistics
import struct
from threading import RLock
from time import perf_counter

from .lift import Unsupported, lift


def _key(value, depth=0):
    kind = type(value)
    if kind is tuple:
        if depth >= 32:
            raise ValueError("verified inputs must nest fewer than 32 tuples")
        return tuple(_key(item, depth + 1) for item in value)
    if kind is float:
        return kind, struct.pack("d", value)
    if kind is int or kind is bool:
        return kind, value
    raise ValueError("verified inputs must contain only numbers and tuples")


def _matches(actual, expected):
    return type(actual) is type(expected) and _key(actual) == _key(expected)


def _speedup(python, compiled):
    def measure(run):
        start = perf_counter()
        count = 0
        while True:
            run()
            count += 1
            elapsed = perf_counter() - start
            if elapsed >= 0.01:
                return elapsed / count

    baseline, native = [], []
    for index in range(3):
        if index % 2:
            native.append(measure(compiled))
            baseline.append(measure(python))
        else:
            baseline.append(measure(python))
            native.append(measure(compiled))
    return statistics.median(baseline) / statistics.median(native)


def optimize(function, *, samples):
    """Return a callable and ``.map(rows)`` that can use a verified CPU version.

    ``samples`` contains positional argument tuples for a pure numeric function.
    Only the exact verified inputs are eligible. Each mode stays on Python if
    it cannot compile, differs from Python, or fails to show a warm speedup.
    ``.report`` describes the outcome for single calls and batches separately.
    """
    rows = list(samples)
    if any(type(row) is not tuple for row in rows):
        raise ValueError("samples must be positional argument tuples")
    verified_batch = tuple(map(_key, rows))
    verified = set(verified_batch)
    lock = RLock()
    call_active = batch_active = False
    report = {"verified_inputs": 0, "batch_size": len(rows)}

    def eligible(args):
        try:
            return _key(args) in verified
        except ValueError:
            return False

    @wraps(function)
    def call(*args, **kwargs):
        if call_active and not kwargs and eligible(args):
            with lock:
                return native(*args)
        return function(*args, **kwargs)

    def batch(calls):
        if batch_active and type(calls) in (list, tuple) and len(calls) == len(verified_batch):
            materialized = tuple(calls)
            try:
                matches = len(materialized) == len(verified_batch) and all(
                    type(args) is tuple and _key(args) == key for args, key in zip(materialized, verified_batch)
                )
            except ValueError:
                matches = False
            if matches:
                with lock:
                    return native.map(materialized)
        return [function(*args) for args in calls]

    def skip(status, reason):
        report.update({mode: {"status": status, "reason": reason} for mode in ("call", "batch")})
        return call

    call.map, call.report = batch, report
    if not rows:
        return skip("skipped", "no samples supplied")
    try:
        native = lift(function)
    except (Unsupported, ImportError) as exc:
        return skip("skipped", str(exc))

    start = perf_counter()
    try:
        expected = [function(*row) for row in rows]
        if any(type(value) not in (int, float, bool) for value in expected):
            return skip("skipped", "the public optimizer requires scalar numeric results")
        if not all(_matches(native(*row), value) for row, value in zip(rows, expected)):
            return skip("rejected", "a compiled result differs from Python")
    except Exception as exc:
        return skip("rejected", f"a sample raised {type(exc).__name__}")
    report["verified_inputs"] = len(verified)
    if not native.compiled_calls:
        return skip("skipped", "all samples needed Python fallback")
    try:
        native_before = native.compiled_calls
        output = native.map(rows)
        batch_verified = (native.compiled_calls > native_before and len(output) == len(expected)
                          and all(map(_matches, output, expected)))
    except Exception:
        batch_verified = False
    report["verification_ms"] = (perf_counter() - start) * 1000

    def decide(python, compiled):
        ratio = _speedup(python, compiled)
        return {"status": "active" if ratio > 1.05 else "slower", "speedup": ratio}

    call_active = True  # Measure the same guarded path the caller will run.
    report["call"] = decide(lambda: [function(*row) for row in rows], lambda: [call(*row) for row in rows])
    call_active = report["call"]["status"] == "active"
    if batch_verified:
        batch_active = True
        report["batch"] = decide(lambda: [function(*row) for row in rows], lambda: batch(rows))
        batch_active = report["batch"]["status"] == "active"
    else:
        report["batch"] = {"status": "skipped", "reason": "batch compilation did not verify"}
    return call
