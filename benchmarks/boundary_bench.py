"""Time the list boundary: lifted functions called repeatedly with list arguments.

Cases, each a list of N floats passed on every call:
  read_only    reads every element, writes nothing (spectral_norm's pattern)
  write_few    reads every element, changes 4 of them
  write_all    rewrites every element (one-pass scaling)
  two_lists    reads one list, writes the other

Prints microseconds per call for plain Python and the lifted function, and
checks that both leave the lists bit-identical and return the same value.

Usage: python benchmarks/boundary_bench.py [N ...]
"""
import json
import os
from pathlib import Path
import sys
import tempfile
import time

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="recompyler-bench-"))

from recompyler.lift import lift, same  # noqa: E402


def read_only(xs):
    total = 0.0
    for i in range(len(xs)):
        total += xs[i] * xs[i]
    return total


def write_few(xs):
    total = 0.0
    for i in range(len(xs)):
        total += xs[i]
    for j in range(4):
        xs[j * 7] = total * 1e-9 + j
    return total


def write_all(xs):
    for i in range(len(xs)):
        xs[i] = xs[i] * 0.5 + 1.0
    return None


def two_lists(src, dst):
    for i in range(len(src)):
        dst[i] = src[i] * 2.0
    return None


def bump_few(xs):
    total = 0.0
    for i in range(len(xs)):
        total += xs[i]
    for j in range(4):
        xs[j * 7] += 1.0
    return total


def bump_all(xs):
    for i in range(len(xs)):
        xs[i] += 1.0
    return None


# write_few, write_all and two_lists reach fixed values after a few calls, so
# later calls store values equal to what's there. bump_few and bump_all change
# values on every call.
CASES = {
    "read_only": (read_only, 1),
    "write_few": (write_few, 1),
    "write_all": (write_all, 1),
    "two_lists": (two_lists, 2),
    "bump_few": (bump_few, 1),
    "bump_all": (bump_all, 1),
}


def make_args(n, count):
    return [[(i % 97) * 0.25 + k for i in range(n)] for k in range(count)]


def per_call(fn, args, calls):
    best = float("inf")
    for _ in range(5):
        t0 = time.perf_counter()
        for _ in range(calls):
            fn(*args)
        best = min(best, (time.perf_counter() - t0) / calls)
    return best * 1e6


def main():
    sizes = [int(arg) for arg in sys.argv[1:]] or [100, 2000, 50000]
    rows = []
    print(f"{'case':10} {'N':>6} {'python us':>10} {'lifted us':>10} {'speedup':>8}  compiled/fallback  same")
    for n in sizes:
        calls = max(20, 2_000_000 // n)
        for name, (fn, count) in CASES.items():
            lifted = lift(fn)
            py_args, lifted_args = make_args(n, count), make_args(n, count)
            for _ in range(3):
                expected, got = fn(*py_args), lifted(*lifted_args)
            ok = same(expected, got) and all(map(same, py_args, lifted_args))
            py_us = per_call(fn, make_args(n, count), calls)
            lifted_us = per_call(lifted, make_args(n, count), calls)
            row = {"case": name, "n": n, "python_us": py_us, "lifted_us": lifted_us,
                   "compiled": lifted.compiled_calls, "fallback": lifted.fallback_calls, "same": ok}
            rows.append(row)
            print(f"{name:10} {n:>6} {py_us:>10.1f} {lifted_us:>10.1f} {py_us / lifted_us:>7.1f}x"
                  f"  {lifted.compiled_calls:>8}/{lifted.fallback_calls:<8} {ok}")
    out = Path(__file__).with_name("boundary_bench.json")
    out.write_text(json.dumps(rows, indent=2))
    print(f"Wrote {out}")


if __name__ == "__main__":
    main()
