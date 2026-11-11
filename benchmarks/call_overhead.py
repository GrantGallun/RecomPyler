"""Where the time goes in one call of a lifted function.

Times each step of Lifted.__call__ on its own, for functions whose compiled work
is tiny, so what's left is RecomPyler's per-call overhead. Steps are timed in
isolation and won't add up exactly to the whole call.

Usage: python benchmarks/call_overhead.py
"""
import os
from pathlib import Path
import sys
import tempfile
import time

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="recompyler-bench-"))

from numba import njit  # noqa: E402

from recompyler.lift import _Boundary, _pack, _suspect_result, lift  # noqa: E402


def axpy(a, x, y):
    return a * x + y


def particle(position, velocity, dt):
    for _ in range(16):
        velocity += (-9.81 - 0.04 * velocity) * dt
        position += velocity * dt
    return position


def sum_squares(values):
    total = 0.0
    for i in range(len(values)):
        total += values[i] * values[i]
    return total


def bump(values):
    values[0] += 1.0


def per_call(fn, repeats=200_000):
    best = float("inf")
    for _ in range(5):
        start = time.perf_counter()
        for _ in range(repeats):
            fn()
        best = min(best, (time.perf_counter() - start) / repeats)
    return best * 1e9


@njit
def _empty3(flag, a, b, c):
    return a


@njit
def _empty1(flag, a):
    return 0.0


def main():
    cases = {
        "axpy(3 floats)": (axpy, (1.5, 2.0, 3.0)),
        "particle(3 floats)": (particle, (1.0, 0.5, 0.01)),
        "sum_squares(100-list)": (sum_squares, ([i * 0.5 for i in range(100)],)),
        "sum_squares(2000-list)": (sum_squares, ([i * 0.5 for i in range(2000)],)),
        "bump(100-list)": (bump, ([0.5] * 100,)),
    }
    for name, (function, args) in cases.items():
        lifted = lift(function)
        for _ in range(3):
            lifted(*args)
        assert lifted.compiled_calls, name
        full = lifted._complete(args)
        packed, shape, boundary = lifted._pack_call(full)
        result = lifted._compiled(lifted._flag, *packed)
        empty = _empty3 if len(packed) == 3 else _empty1
        empty(lifted._flag, *packed)
        rows = [
            ("python function", lambda: function(*args)),
            ("lifted call, total", lambda: lifted(*args)),
            ("  _complete", lambda: lifted._complete(args)),
            ("  _pack_call", lambda: lifted._pack_call(full)),
            ("    _Boundary()", lambda: _Boundary(lifted._records, lifted._list_cache, lifted._unit.writes)),
            ("    _pack", lambda: _pack(full, _Boundary(lifted._records, lifted._list_cache, lifted._unit.writes))),
            ("  shape lookup", lambda: lifted._shapes.get(shape)),
            ("  guards_hold", lifted._unit.guards_hold),
            ("  _run", lambda: lifted._run(packed)),
            ("    Numba call alone", lambda: lifted._compiled(lifted._flag, *packed)),
            ("    empty Numba call, same types", lambda: empty(lifted._flag, *packed)),
            ("  result checks", lambda: _suspect_result(shape, result)),
        ]
        if lifted._unit.writes:
            rows.append(("  write_back", boundary.write_back))
        print(f"\n{name}   (compiled {lifted.compiled_calls}, fallback {lifted.fallback_calls})")
        for label, fn in rows:
            print(f"  {label:36} {per_call(fn, 50_000 if '2000' in name else 200_000):9.0f} ns")


if __name__ == "__main__":
    main()
