"""Regions that use what comes from outside them: module globals, random.Random,
numpy arrays and ints too large for 64 bits."""
import copy
import math
import operator
import os
from pathlib import Path
import random
import sys
import tempfile
import unittest

try:
    import numba  # noqa: F401
except ImportError:
    numba = None

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="recompyler-tests-"))

from recompyler import _rng, heap  # noqa: E402
from recompyler.heap import lift_region  # noqa: E402
from recompyler.lift import same  # noqa: E402


def draws(rng, n):
    total = 0.0
    for _ in range(n):
        total += rng.random()
    return total


def mixed_draws(rng, n, top):
    out = []
    for i in range(n):
        out.append(rng.randrange(top) + rng.randrange(-5, top) + rng.randrange(3, 3 + 7 * top, 7))
        out.append(rng.randrange(top * 9, -4, -3))
        out.append(rng.randint(-3, i))
        out.append(rng.getrandbits(i % 64))
    return out


def big_ranges(rng, n):
    out = []
    for _ in range(n):
        out.append(rng.randrange(9223372036854775807))
        out.append(rng.randrange(1099511627776))
        out.append(rng.getrandbits(63))
    return out


def floats(rng, n):
    out = []
    for i in range(n):
        out.append(rng.uniform(-2.5, 7))
        out.append(rng.uniform(i, i + 3))
    return out


def picks(rng, items, n):
    total = 0
    for _ in range(n):
        total += rng.choice(items)
    return total


def shuffled(rng, items, rounds):
    for _ in range(rounds):
        rng.shuffle(items)
    return items[0]


def sampled(rng, items, k, rounds):
    out = []
    for _ in range(rounds):
        part = rng.sample(items, k)
        out.append(part[0] + part[len(part) - 1])
    return out


def reseeded(rng, seed, n):
    rng.seed(seed)
    return draws(rng, n)


def module_draws(n):
    total = 0
    for _ in range(n):
        total += random.randrange(100)
        if random.random() < 0.25:
            total += 1
    return total


def from_import_draws(n):
    total = 0.0
    for _ in range(n):
        total += uniform(1.0, 2.0) + randint(0, 3)
    return total


from random import randint, uniform  # noqa: E402


def operators(a, b):
    return operator.add(a, b) * operator.mul(a, 2) - operator.neg(b) + operator.floordiv(a, 3)


def math_rounding(x):
    return math.floor(x) + math.ceil(x * 2) + math.trunc(-x) + (1 if math.isfinite(x) else 0)


INF = float("inf")
STEPS = ((1, 0), (0, -1), (-1, 2.5))


def smallest(xs):
    best = INF
    worst = -INF
    for x in xs:
        if x < best:
            best = x
        if x > worst:
            worst = x
    return best + STEPS[2][1], worst * STEPS[0][0], math.inf > best


def module_constant(x):
    return x * math.pi + heap.EXACT


class Points:
    def __init__(self, xs):
        self.xs = xs

    def __len__(self):
        return len(self.xs)

    def total(self):
        return sum_points(self)


class Flag:
    def __init__(self, on):
        self.on = on

    def __bool__(self):
        return self.on


class Bad:
    def __init__(self, n):
        self.n = n

    def __len__(self):
        return self.n


def sum_points(points):
    total = 0.0
    if not points:
        return -1.0
    for i in range(len(points)):
        total += points.xs[i]
    return total


def count_flags(flags):
    count = 0
    for flag in flags:
        if flag:
            count += 1
    return count


def bad_length(bad):
    return len(bad)


import numpy as np  # noqa: E402

GRID = np.arange(12, dtype=np.float64).reshape(3, 4) * 0.5


def array_sum(a):
    total = 0.0
    for i in range(len(a)):
        total += a[i]
    return total


def int_sum(a):
    count = 0
    for x in a:
        count += x
    return count


def scale_in_place(a, k):
    for i in range(a.shape[0]):
        for j in range(a.shape[1]):
            a[i, j] = a[i, j] * k + 1
    return None


def row_dot(grid, row, weights):
    line = grid[row]
    total = 0.0
    for j in range(line.shape[0]):
        total += line[j] * weights[j]
    return total


def global_grid(i, j):
    return GRID[i, j] + GRID[-1, -1]


def masks(flags, values):
    hits = 0
    for i in range(len(flags)):
        if flags[i]:
            hits += 1
            values[i] += 2
        else:
            flags[i] = values[i] > 3
    return hits


def mixed_types(a, i):
    x = a[i]
    y = x * 2 + 1
    z = np.sqrt(a[i] * a[i]) + np.maximum(a[0], a[1])
    return x, y, z, float(x), int(y), x > 1.0, np.float64(3), np.int64(4) + 1


def store_kinds(a, b, c):
    a[0] = 3
    a[1] = True
    b[0] = 2.75
    b[1] = -2.75
    c[0] = 5
    c[1] = 0.0
    return None


def read_only(a):
    a[0] = 1.0
    return None


@unittest.skipIf(numba is None, "needs Numba")
class NumpyTests(unittest.TestCase):
    def check(self, fn, *args):
        region = lift_region(fn)
        given = copy.deepcopy(args)
        reference = copy.deepcopy(args)
        expected = fn(*reference)
        ok, got = region.attempt(given)
        self.assertTrue(ok, region.problem or region.gave_up)
        self.assertTrue(same(got, expected), (got, expected))
        self.assertTrue(same(list(given), list(reference)), (given, reference))
        return region

    def test_sums_keep_numpy_types(self):
        self.check(array_sum, np.array([1.5, 2.25, -3.0]))
        self.check(array_sum, np.array([], dtype=np.float64))
        self.check(int_sum, np.arange(10, dtype=np.int64))
        self.check(int_sum, np.array([], dtype=np.int64))

    def test_two_dimensions_views_and_globals(self):
        self.check(scale_in_place, np.arange(6, dtype=np.float64).reshape(2, 3), 1.5)
        # A transposed array has strides of its own.
        self.check(scale_in_place, np.arange(6, dtype=np.float64).reshape(2, 3).T.copy().T, 2.0)
        self.check(row_dot, GRID.copy(), 1, np.array([1.0, -1.0, 0.5, 2.0]))
        self.check(global_grid, 1, 2)
        self.check(masks, np.array([True, False, True, False]), np.array([1, 5, 2, 0], dtype=np.int64))

    def test_scalars_and_stores(self):
        self.check(mixed_types, np.array([1.25, 4.0, -2.0]), 2)
        self.check(store_kinds, np.zeros(2), np.zeros(2, dtype=np.int64), np.zeros(2, dtype=bool))

    def test_writes_are_in_place(self):
        a = np.arange(6, dtype=np.float64).reshape(2, 3)
        region = lift_region(scale_in_place)
        self.assertTrue(region.attempt((a, 2.0))[0])
        self.assertEqual(a.tolist(), [[1.0, 3.0, 5.0], [7.0, 9.0, 11.0]])

    def test_fallbacks(self):
        region = lift_region(array_sum)
        # Wrong dtype: a different program, refused for float32.
        self.assertFalse(region.attempt((np.zeros(3, dtype=np.float32),))[0])
        region = lift_region(global_grid)
        self.assertFalse(region.attempt((5, 0))[0])
        frozen = np.zeros(3)
        frozen.flags.writeable = False
        region = lift_region(read_only)
        self.assertFalse(region.attempt((frozen,))[0])
        self.assertEqual(frozen[0], 0.0)
        region = lift_region(store_kinds)
        self.assertFalse(region.attempt((np.zeros(2), np.zeros(2, dtype=np.int64), np.zeros(1, dtype=bool)))[0])


class Box:
    def __init__(self, n):
        self.n = n
        self.items = [n, 1]


def int_total(xs):
    s = 0
    for x in xs:
        s += x
    return s


def box_total(b):
    return b.n + b.items[0]


@unittest.skipIf(numba is None, "needs Numba")
class BigIntTests(unittest.TestCase):
    def test_big_ints_fall_back_and_small_ones_compile(self):
        for native in (True, False):
            saved, heap.NATIVE = heap.NATIVE, native
            try:
                for fn, args, compiles in ((int_total, ([1, 2, 3],), True), (int_total, ([1, 2 ** 70, 3],), False),
                                           (int_total, ([2 ** 62, 2 ** 62],), False), (box_total, (Box(3),), True),
                                           (box_total, (Box(2 ** 64),), False), (box_total, (Box(-2 ** 63),), False)):
                    ok, got = lift_region(fn).attempt(args)
                    self.assertEqual(ok, compiles, (fn, args))
                    if ok:
                        self.assertEqual(got, fn(*args))
            finally:
                heap.NATIVE = saved

    def test_one_region_over_mixed_calls(self):
        region = lift_region(int_total)
        for xs in ([1, 2], [2 ** 65], [3, 4], [2 ** 63 - 1, 1], [7], [-2 ** 64, 2 ** 64]):
            self.assertEqual(region(xs), int_total(xs))
        self.assertEqual((region.compiled_calls, region.fallback_calls), (3, 3))


@unittest.skipIf(numba is None, "needs Numba")
class RandomTests(unittest.TestCase):
    def check(self, fn, *args, rng_at=0):
        region = lift_region(fn)
        for seed in (0, 1, 12345, 2 ** 40 + 3):
            given = list(args)
            expected_rng = random.Random(seed)
            mine = random.Random(seed)
            if rng_at is not None:
                given.insert(rng_at, mine)
            reference = copy.deepcopy(given)
            if rng_at is not None:
                reference[rng_at] = expected_rng
            expected = fn(*reference)
            ok, got = region.attempt(tuple(given))
            self.assertTrue(ok, region.problem or region.gave_up)
            self.assertTrue(same(got, expected), (got, expected))
            if rng_at is not None:
                self.assertEqual(mine.getstate(), expected_rng.getstate())
                self.assertEqual(mine.random(), expected_rng.random())
            self.assertTrue(same(given[:rng_at or 0] + given[(rng_at or 0) + 1:],
                                 reference[:rng_at or 0] + reference[(rng_at or 0) + 1:]))

    def test_layout_is_read_in_place(self):
        self.assertIsNotNone(_rng._LAYOUT)

    def test_random(self):
        # Over 624 words, so the state is twisted inside the region.
        self.check(draws, 1000)

    def test_ranges_and_bits(self):
        self.check(mixed_draws, 300, 50)

    def test_big_ranges(self):
        self.check(big_ranges, 200)

    def test_uniform(self):
        self.check(floats, 100)

    def test_choice_shuffle_sample(self):
        self.check(picks, [3, 1, 4, 1, 5, 9, 2, 6], 200)
        self.check(shuffled, list(range(30)), 20)
        self.check(sampled, list(range(10)), 4, 50)
        # Population larger than the set threshold: the other algorithm.
        self.check(sampled, list(range(400)), 7, 50)
        self.check(sampled, list(range(40)), 30, 20)

    def test_seed(self):
        for seed in (0, 7, -7, 2 ** 32 - 1, 2 ** 32, 2 ** 62 + 12345):
            self.check(reseeded, seed, 700)

    def test_errors_fall_back_and_leave_the_generator(self):
        region = lift_region(mixed_draws)
        rng = random.Random(3)
        before = rng.getstate()
        ok, _ = region.attempt((rng, 10, 0))
        self.assertFalse(ok)
        self.assertEqual(rng.getstate(), before)

    def test_module_generator(self):
        region = lift_region(module_draws)
        random.seed(99)
        expected = module_draws(500)
        after = random.getstate()
        random.seed(99)
        ok, got = region.attempt((500,))
        self.assertTrue(ok, region.problem)
        self.assertEqual(got, expected)
        self.assertEqual(random.getstate(), after)

    def test_from_import_and_rebinding(self):
        global uniform
        region = lift_region(from_import_draws)
        random.seed(5)
        expected = from_import_draws(300)
        random.seed(5)
        ok, got = region.attempt((300,))
        self.assertTrue(ok, region.problem)
        self.assertTrue(same(got, expected))
        saved = uniform
        try:
            uniform = lambda a, b: 0.0  # noqa: E731
            ok, _ = region.attempt((300,))
            self.assertFalse(ok)
        finally:
            uniform = saved

    def test_subclass_is_refused(self):
        class Mine(random.Random):
            pass

        region = lift_region(draws)
        ok, _ = region.attempt((Mine(1), 10))
        self.assertFalse(ok)


@unittest.skipIf(numba is None, "needs Numba")
class ModuleGlobalTests(unittest.TestCase):
    def test_operator_and_math(self):
        for fn, args in ((operators, (7, -3)), (operators, (9, 4)), (math_rounding, (2.75,)),
                         (math_rounding, (-3.5,)), (module_constant, (2.0,)),
                         (smallest, ([3.0, -1.5, 7.25],)), (smallest, ([],))):
            region = lift_region(fn)
            ok, got = region.attempt(args)
            self.assertTrue(ok, region.problem)
            self.assertTrue(same(got, fn(*args)), (fn, got))

    def test_truth_and_length_methods(self):
        for fn, args in ((sum_points, (Points([1.5, 2.0, 3.25]),)), (sum_points, (Points([]),)),
                         (count_flags, ([Flag(True), Flag(False), Flag(True)],))):
            region = lift_region(fn)
            ok, got = region.attempt(args)
            self.assertTrue(ok, region.problem)
            self.assertTrue(same(got, fn(*args)), (fn, got))
        region = lift_region(bad_length)
        self.assertEqual(region.attempt((Bad(3),)), (True, 3))
        # Python raises ValueError for a negative length.
        self.assertEqual(region.attempt((Bad(-1),))[0], False)

    def test_rebinding_a_module_global(self):
        region = lift_region(module_constant)
        self.assertTrue(region.attempt((1.0,))[0])
        saved = math.pi
        try:
            math.pi = 3.0
            self.assertFalse(region.attempt((1.0,))[0])
        finally:
            math.pi = saved
        self.assertTrue(region.attempt((1.0,))[0])

    def test_math_rounding_falls_back_outside_64_bits(self):
        region = lift_region(math_rounding)
        for value in (1e300, float("nan"), float("inf")):
            ok, _ = region.attempt((value,))
            self.assertFalse(ok)


if __name__ == "__main__":
    unittest.main()
