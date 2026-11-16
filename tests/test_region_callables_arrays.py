"""Function and class values, enumerate/zip loops, typed arrays, float % and //,
shifts, isinstance against built-in classes, constructors that call a setup method,
and float-typed lists of run-time numbers, each checked against CPython."""
import math
import os
from pathlib import Path
import struct
import sys
import tempfile
from array import array

import pytest

pytest.importorskip("numba")
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="recompyler-tests-"))

from recompyler.heap import lift_region  # noqa: E402


def same(x, y):
    if type(x) is not type(y):
        return False
    if isinstance(x, float):
        return struct.pack("d", x) == struct.pack("d", y)
    if isinstance(x, (tuple, list)):
        return len(x) == len(y) and all(same(a, b) for a, b in zip(x, y))
    if isinstance(x, array):
        return x.typecode == y.typecode and x.tobytes() == y.tobytes()
    if hasattr(x, "__dict__") and not isinstance(x, type):
        return vars(x).keys() == vars(y).keys() and all(same(vars(x)[k], vars(y)[k]) for k in vars(x))
    return x == y


def outcome(fn, args):
    try:
        return fn(*args)
    except Exception as exc:  # noqa: BLE001
        return ("raised", type(exc).__name__)


def agree(fn, cases, native=True):
    region = lift_region(fn)
    for make in cases:
        first, second = make(), make()
        want, got = outcome(fn, first), outcome(region, second)
        assert same(got, want), (fn.__name__, first, got, want)
        assert same(list(second), list(first)), (fn.__name__, "arguments", second, first)
    if native:
        assert region.problem is None, region.problem
        assert region.compiled_calls > 0
    return region


def eval_a(i, j):
    return 1.0 / ((i + j) * (i + j + 1) // 2 + i + 1)


def times(func, u):
    return [func((i, u)) for i in range(len(list(u)))]


def part_a(i_u):
    i, u = i_u
    total = 0
    for j, u_j in enumerate(u):
        total += eval_a(i, j) * u_j
    return total


def part_at(i_u):
    i, u = i_u
    total = 0
    for j, u_j in enumerate(u):
        total += eval_a(j, i) * u_j
    return total


def ata(u):
    return times(part_at, times(part_a, u))


def apply(func, x):
    return func(x) + 1


def double(x):
    return x * 2


def halve(x):
    return x / 2


def test_function_values_and_float_lists():
    region = agree(ata, [lambda: ([1] * 30,), lambda: ([0.5 * k for k in range(30)],)])
    assert region.fallback_calls == 0
    # With nothing to add up the sums stay ints: the call goes back to Python.
    assert same(region([]), ata([]))


def test_function_passed_to_entry():
    agree(apply, [lambda: (double, 3), lambda: (double, 2.5)])
    region = lift_region(apply)
    assert region(double, 4) == 9 and region(halve, 4) == 3.0 and region(double, 5) == 11


class Grid:
    def __init__(self, w, h):
        self.w = w
        self.h = h
        self.data = array("d", [0]) * (w * h)

    def __getitem__(self, xy):
        (x, y) = xy
        return self.data[y * self.w + x]

    def __setitem__(self, xy, value):
        (x, y) = xy
        self.data[y * self.w + x] = value


def relax(grid, cycles, kind):
    made = kind(2, 2)
    for _ in range(cycles):
        for y in range(1, grid.h - 1):
            for x in range(1, grid.w - 1):
                grid[x, y] = 0.25 * (grid[x, y - 1] + grid[x, y + 1] + grid[x - 1, y] + grid[x + 1, y]) + 1
    return made.w + made.h


def make_grid():
    grid = Grid(6, 5)
    for k in range(30):
        grid.data[k] = k * 0.5
    return grid


def test_class_value_argument_and_array_field():
    agree(relax, [lambda: (make_grid(), 3, Grid)])


def pairs(xs, ys):
    out = []
    for i, x in enumerate(xs, 3):
        out.append(i * x)
    for a, b in zip(xs, ys):
        out.append(a - b)
    for a, b, c in zip(xs, range(10, 0, -3), ys):
        out.append(a + b + c)
    for pair in enumerate(ys):
        out.append(pair[0] + pair[1])
    for i, x in enumerate(xs):
        if i == 1:
            continue
        if i == 3:
            break
        out.append(x)
    return out


def test_enumerate_and_zip():
    agree(pairs, [lambda: ([1, 2, 3], [4, 5, 6]), lambda: ([1.5, 2.5], [1.0, 2.0, 3.0]),
                  lambda: ([1, 2, 3, 4, 5], [9])])


def arrays(n):
    a = array("d", [0]) * n
    b = array("i", [1, 2, 3])
    c = array("d", [1, 2, 3])
    d = array("d")
    e = b * 2
    if n:
        a[0] = 7
    d[:] = c[:]
    return a, b, c, d, e, c[1:], [1, 2] * n, n * [1.5, 2.5]


def fill(a, idx, big):
    total = 0.0
    for k in range(len(a)):
        total += a[k] * a[idx[k]]
    a[0] = 3
    idx[1] = idx[0] + big
    return total


def test_typed_arrays():
    agree(arrays, [lambda: (0,), lambda: (3,), lambda: (17,)])
    agree(fill, [lambda: (array("d", [1.5, 2.5, 3.5]), array("i", [2, 1, 0]), 2),
                 lambda: (array("d", [1.5, 2.5, 3.5]), array("q", [2, 1, 0]), 2),
                 lambda: (array("d", [1.5, 2.5, 3.5]), array("i", [2, 1, 0]), 1 << 40),
                 lambda: (array("d", [1.5, 2.5, 3.5]), array("B", [2, 1, 0]), 300)])


def mod(a, b):
    return a % b


def floordiv(a, b):
    return a // b


def shl(a, b):
    return a << b


def shr(a, b):
    return a >> b


FLOATS = [0.0, -0.0, 1.0, -1.0, 0.5, -0.5, 3.0, -3.0, 2.5, -2.5, 1e308, -1e308, 5e-324, -5e-324, math.inf, -math.inf,
          math.nan, 7.25, -7.25, 1e-9, 123456789.125, 2.0 ** 53, 0.1, -0.1, 0.3]
INTS = [0, 1, -1, 2, -2, 7, -7, 3, 2 ** 31, -2 ** 31, 2 ** 53, 2 ** 53 + 1, -(2 ** 53) - 1, 2 ** 62, -2 ** 62,
        2 ** 63 - 1, -2 ** 63, 12345]


@pytest.mark.parametrize("fn", [mod, floordiv])
def test_float_mod_and_floordiv(fn):
    agree(fn, [lambda args=(a, b): args for a in FLOATS for b in FLOATS])
    agree(fn, [lambda args=(a, b): args for a in INTS for b in FLOATS])
    agree(fn, [lambda args=(a, b): args for a in FLOATS for b in INTS])


@pytest.mark.parametrize("fn", [shl, shr])
def test_shifts(fn):
    counts = [0, 1, 2, 5, 31, 32, 61, 62, 63, 64, 65, 100, -1, -5, 2 ** 40]
    agree(fn, [lambda args=(a, b): args for a in INTS for b in counts])


def kinds(x):
    return (isinstance(x, tuple), isinstance(x, int), isinstance(x, (float, list)), isinstance(x, object),
            isinstance(x, bool), isinstance(x, str))


def test_isinstance_of_builtin_classes():
    for value in (1, 1.5, (1, 2), [1, 2], True, None, "s"):
        agree(kinds, [lambda value=value: (value,)])


class Dice:
    SIDES = 6
    SCALE = 0.5

    def __init__(self, seed):
        self.setup(seed)
        self.rolls = 0

    def setup(self, seed):
        self.seed = seed
        self.state = array("d", [0]) * 4
        for k in range(4):
            self.state[k] = (seed * (k + 1)) % self.SIDES
        self.at = 0

    def roll(self):
        value = self.state[self.at] * self.SCALE
        self.at = (self.at + 1) % 4
        self.rolls += 1
        return value


def play(seed, n):
    dice = Dice(seed)
    total = 0.0
    for _ in range(n):
        total += dice.roll()
    return total, dice.rolls, dice.SIDES


def test_constructor_that_calls_a_setup_method():
    agree(play, [lambda: (7, 10), lambda: (3, 0)])


class Early:
    LIMIT = 3

    def __init__(self, x):
        self.prepare()
        self.x = x

    def prepare(self):
        self.y = self.x + self.LIMIT


def early():
    return Early(1).y


def test_setup_method_reading_an_unset_attribute_is_refused():
    region = lift_region(early)
    assert outcome(region, ()) == outcome(early, ())
    assert region.compiled_calls == 0


def mixed_into_ints(n):
    out = [0] * n
    for k in range(n):
        total = 0
        if k:
            total += 0.5
        out[k] = total
    return out


def test_list_of_ints_and_floats_still_matches():
    region = lift_region(mixed_into_ints)
    for n in (0, 1, 4):
        assert same(region(n), mixed_into_ints(n))
