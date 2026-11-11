import array
import copy
import itertools
import math
import os
from pathlib import Path
import tempfile
import random
import struct
import sys
import unittest

try:
    import numba  # noqa: F401
except ImportError:
    numba = None

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
# Keep compiled code from the tests out of the user's cache.
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="recompyler-tests-"))

from recompyler.lift import Unsupported, lift, same  # noqa: E402

WINDOWS = (0b00111, 0b01110, 0b11100, (1 << 4) | 0b00011)
SCALE = 0.5


def clamp(x, lo, hi):
    return lo if x < lo else hi if x > hi else x


def particle(position, velocity, dt):
    for _ in range(128):
        velocity += (-9.81 - 0.04 * velocity) * dt
        position += velocity * dt
        if position < 0.0:
            position = -position
            velocity *= -0.7
    return position


def score_hand(cards):
    """Lists, enumerate, a filtered comprehension, bit_count, a helper and a constant."""
    if len(cards) != 4:
        return 0.5
    rank_counts = [0] * 5
    suit_masks = [0] * 4
    total = 0
    for c in cards:
        if not 0 <= int(c) < 20:
            return 0.5
        rank_counts[int(c) >> 2] += 1
        suit_masks[int(c) & 3] |= 1 << (int(c) >> 2)
        total += int(c) >> 2
    q = 0.25 + SCALE * (total / 16.0)
    mask = 0
    for r, n in enumerate(rank_counts):
        if n:
            mask |= 1 << r
        if n == 2:
            q += 0.05 + 0.01 * r
    best = 0
    for window in WINDOWS:
        best = max(best, (mask & window).bit_count())
    distinct = [r for r, n in enumerate(rank_counts) if n]
    gaps = 0
    for i in range(len(distinct)):
        for j in range(i + 1, len(distinct)):
            if distinct[j] - distinct[i] == 1:
                gaps += 1
    return clamp(q + 0.03 * best + min(gaps, 3) * 0.008, 0.2, 0.94)


def grow(n):
    x = 1
    for _ in range(n):
        x *= 3
    return x


def shift(n):
    return 1 << n


def total(a, b):
    return a + b


def difference(a, b):
    return a - b


def negate(a):
    return -a


def magnitude(a):
    return abs(a)


def square(a):
    return a ** 2


def ratio(a, b):
    return a / b


def floor_ratio(a, b):
    return a // b


def remainder(a, b):
    return a % b


def truncate(x):
    return int(x)


def root(x):
    return math.sqrt(x)


def one_or_half(x):
    if x > 0:
        return 1
    return 0.5


def flag_or_count(x):
    result = True
    if x > 3:
        result = 2
    return result


def smaller(a, b):
    return min(a, b)


def store_into_ints(x):
    values = [0] * 3
    values[0] = x
    return values[0]


def append_to_ints(x):
    values = [0]
    values.append(x)
    return values[1]


def mixed_literal(x):
    values = [0, x]
    return values[0]


def pick(values, index):
    return values[index]


def echo(values):
    return values


def first_pair(values):
    return (values[0], values[1])


def build(n):
    return [i * 2 for i in range(n)]


def scaled(x):
    return x * SCALE


def maybe_unbound(x):
    if x > 0:
        y = 1
    return y


def no_return(x):
    if x > 0:
        return 1


def uses_string(x):
    return len("abc") + x


def uses_power(x):
    return x ** 3


def cube_root(x):
    return x ** (1 / 3) + x ** 3 + 2 ** x


def uses_exp(x):
    return math.exp(x)


def extends_in_place(x):
    values = [x]
    alias = values
    values += [x]
    return len(alias)


def scale_in_place(values, k):
    for i in range(len(values)):
        values[i] *= k


def copy_into(target, source):
    for i in range(len(source)):
        target[i] = source[i] + 1


def with_default(x, k=3):
    return x * k


def calls_default(x):
    return with_default(x) + with_default(x, 2)


def first_index(values, wanted):
    for i, value in enumerate(values):
        if value == wanted:
            break
    else:
        return -1
    return i


def spin(n):
    k = 0
    while True:
        k += 1
        if k >= n:
            return k


def shuffle(n, k):
    perm = list(range(n))
    perm[:k + 1] = perm[k::-1]
    copy = perm[:]
    copy[1:3] = [7]
    push = copy.append
    push(perm.pop(0))
    copy.insert(1, perm.pop())
    return perm, copy


def checked_log(n):
    k = 1
    log = 0
    while k < n:
        k *= 2
        log += 1
    if n != 1 << log:
        raise ValueError("not a power of two")
    return log


def dot(xs, ys):
    total = 0
    for i in range(len(xs)):
        total += xs[i] * ys[i]
    return total


def head(values):
    return values[:2]


def doubled(values):
    return values + values


def doubled_length(values):
    both = values + values
    return len(both) + len(values * 2)


def nonempty(values, x):
    return x if values and x > 0 else 0.5


def pair_energy(pairs):
    e = 0.0
    for (([x1, y1], v1, m1), ((x2, y2), v2, m2)) in pairs:
        dx, dy = x1 - x2, y1 - y2
        e -= m1 * m2 / (dx * dx + dy * dy) ** 0.5
        v1[0] -= dx * m2
        v2[1] += dy * m1
    return e


def step_bodies(dt, bodies=None):
    for (r, [vx, vy], m) in bodies:
        r[0] += dt * vx
        r[1] += dt * vy


def grow_while_iterating(values):
    seen = 0
    for value in values:
        seen += 1
        if value > 0 and len(values) < 8:
            values.append(value - 1)
    return seen


def rebinds_sequence(values):
    total = 0
    for value in values:
        total += value
        values = [1, 2, 3]
    return total


def flips(n, k):
    perm = list(range(n))
    count = [0] * n
    for step in range(n):
        perm.insert(step % (n + 2) - 1, perm.pop(k))
        perm[:k + 1] = perm[k::-1]
        count[perm[0]] += 1
    snapshot = perm[:]
    snapshot[1:] = snapshot[:0:-1]
    return snapshot[0] * 100 + count[0] * 10 + perm[-1]


def resizes(n):
    values = list(range(n))
    values[:2] = values[3:]
    return len(values)


def returns_local(n):
    values = [0.5] * n
    values[0] = 2.0
    return values


class Vec:
    def __init__(self, x, y, z=0.0):
        self.x = x
        self.y = y
        self.z = z

    def dot(self, other):
        return self.x * other.x + self.y * other.y + self.z * other.z

    def __sub__(self, other):
        return Vec(self.x - other.x, self.y - other.y, self.z - other.z)

    def __mul__(self, k):
        return Vec(self.x * k, self.y * k, self.z * k)

    def __rmul__(self, k):
        return Vec(k * self.x, k * self.y, k * self.z)


class Spin(Vec):
    def dot(self, other):
        return -(self.x * other.x)


class Grid:
    def __init__(self, width, height):
        self.width = width
        self.height = height
        self.data = array.array("d", [0.0]) * (width * height)

    def _idx(self, x, y):
        if 0 <= x < self.width and 0 <= y < self.height:
            return y * self.width + x
        raise IndexError

    def __getitem__(self, x_y):
        (x, y) = x_y
        return self.data[self._idx(x, y)]

    def __setitem__(self, x_y, value):
        (x, y) = x_y
        self.data[self._idx(x, y)] = value


class Slotted:
    __slots__ = ("count", "total")

    def __init__(self, count, total):
        self.count = count
        self.total = total

    def add(self, value):
        self.count += 1
        self.total += value


def spread(points, k):
    total = 0.0
    for p in points:
        d = p - points[0]
        total += d.dot(d) + (2.0 * p).x + (p * k).y
    return total


def build_vec(a, b):
    return Vec(a, b) - Vec(b, a)


def first_point(points):
    return points[0]


def relax(grid, sweeps, omega):
    for _ in range(sweeps):
        for y in range(1, grid.height - 1):
            for x in range(1, grid.width - 1):
                grid[x, y] = omega * 0.25 * (grid[x, y - 1] + grid[x, y + 1] + grid[x - 1, y]
                                             + grid[x + 1, y]) + (1.0 - omega) * grid[x, y]


def peek(grid, x, y):
    return grid[x, y]


def tally(counter, values):
    for value in values:
        counter.add(value)
    return counter.total / counter.count


def twice(a, b):
    a.x += 1.0
    return b.x


def compare_points(a, b):
    return 1 if a == b else 0


def count_fields(p):
    return len(p)


def waves(x):
    return math.sin(x) + math.cos(x) * math.exp(-x) + math.log1p(abs(x)) + math.pi


def value_or_none(x):
    if x > 0:
        return 1
    return


BIG = 2**62
INTS = (0, 1, -1, 2, -2, 3, 7, -7, 63, 64, 2**31, 2**53, 2**53 + 1, -(2**53) - 1, BIG, -BIG,
        2**63 - 1, -(2**63), 2**63 - 2, -(2**63) + 1, True, False)
FLOATS = (0.0, -0.0, 1.5, -1.5, 2.5, 1e-320, 1e200, -1e200, 1.7976931348623157e308, 9.3e18, -9.3e18,
          float("inf"), float("-inf"), float("nan"))


@unittest.skipUnless(numba, "numba is not installed")
class LiftTests(unittest.TestCase):
    def check(self, function, calls, expect_compiled=None):
        lifted = lift(function)
        checked, mismatches = lifted.verify(calls)
        self.assertEqual(mismatches, [], function.__name__)
        if expect_compiled is not None:
            self.assertEqual(lifted.compiled_calls > 0, expect_compiled, function.__name__)
        return lifted

    def test_particle_matches_bit_for_bit(self):
        rng = random.Random(7)
        calls = [(rng.uniform(0, 4), rng.uniform(-4, 4), rng.uniform(0.01, 0.02)) for _ in range(500)]
        lifted = self.check(particle, calls)
        self.assertEqual(lifted.fallback_calls, 0)

    def test_hand_scorer_over_every_holding(self):
        calls = [(cards,) for cards in itertools.combinations(range(20), 4)]
        calls += [((0, 1, 2),), ((0, 1, 2, 40),), ([3, 7, 11, 15],), ((0.0, 1.0, 2.0, 3.0),)]
        lifted = self.check(score_hand, calls, expect_compiled=True)
        self.assertGreaterEqual(lifted.compiled_calls, 4845)

    def test_integer_overflow_falls_back(self):
        lifted = self.check(grow, [(n,) for n in range(70)], expect_compiled=True)
        self.assertEqual(lifted(50), 3**50)
        self.check(shift, [(n,) for n in (*range(-2, 70), 2**40)], expect_compiled=True)

    def test_binary_operators_on_edge_values(self):
        pairs = list(itertools.product(INTS + FLOATS, repeat=2))
        for function in (total, difference, ratio, floor_ratio, remainder, smaller):
            self.check(function, pairs)

    def test_unary_operators_on_edge_values(self):
        for function in (negate, magnitude, square, truncate, root):
            self.check(function, [(value,) for value in INTS + FLOATS])

    def test_merged_types_are_not_compiled(self):
        self.check(one_or_half, [(1,), (-1,), (2.0,), (-2.0,)], expect_compiled=False)
        self.check(flag_or_count, [(1,), (5,)], expect_compiled=False)
        self.check(smaller, [(1, 2.0), (2.0, 1), (True, 1), (1, True)], expect_compiled=False)
        self.check(mixed_literal, [(1.5,), (2,)])

    def test_lists_keep_python_element_types(self):
        for function in (store_into_ints, append_to_ints):
            self.check(function, [(1.5,), (2,), (True,)])
        self.check(extends_in_place, [(1,)], expect_compiled=False) if self.lifts(extends_in_place) else None
        self.check(build, [(n,) for n in range(1, 6)], expect_compiled=True)

    def lifts(self, function):
        try:
            lift(function)
        except Unsupported:
            return False
        return True

    def test_indexing_errors_match(self):
        calls = [((1, 2, 3), index) for index in (-4, -3, -1, 0, 2, 3, 99)]
        self.check(pick, calls + [([1, 2, 3], 1), ((1.5, 2.5), 5)])

    def test_list_arguments_keep_identity(self):
        values = [1, 2, 3]
        self.assertIs(lift(echo)(values), values)
        self.check(echo, [((1, 2),), ([1.5, 2.5],)])
        self.check(first_pair, [([1, 2],), ((1, 2),)])

    def test_changed_global_is_noticed(self):
        global SCALE
        lifted = lift(scaled)
        self.assertEqual(lifted(4.0), 2.0)
        self.assertEqual(lifted.compiled_calls, 1)
        try:
            SCALE = 0.25
            self.assertEqual(lifted(4.0), 1.0)
        finally:
            SCALE = 0.5
        self.assertEqual(lifted(4.0), 2.0)
        self.assertEqual((lifted.compiled_calls, lifted.fallback_calls), (2, 1))

    def test_builtin_rebinding_invalidates_a_lifted_function(self):
        lifted = lift(grow)
        self.assertEqual(lifted(4), 81)
        namespace = grow.__globals__
        try:
            namespace["range"] = lambda n: ()
            self.assertEqual(lifted(4), 1)
        finally:
            del namespace["range"]

    def test_unsafe_functions_are_rejected(self):
        for function in (maybe_unbound, no_return, value_or_none, uses_string, len, lambda x: x):
            with self.assertRaises(Unsupported):
                lift(function)

    def test_lists_and_arrays_change_in_place(self):
        calls = [([1.5, -2.0, 0.25], 2.0), ([1, 2, 3], 3), ([1, 2], 2.5), (array.array("d", [1.0, 2.0]), 0.5),
                 (array.array("i", [5, 6]), 2), (array.array("i", [2**30, 1]), 4), ([2**62, 1], 4), ([], 2)]
        lifted = self.check(scale_in_place, calls, expect_compiled=True)
        values = [1.0, 2.0]
        self.assertIsNone(lifted(values, 3.0))
        self.assertEqual(values, [3.0, 6.0])

    def test_one_list_passed_twice_is_one_list(self):
        self.check(copy_into, [([1, 2, 3], [5, 6, 7])], expect_compiled=True)
        shared = [1, 2, 3]
        expected = [1, 2, 3]
        copy_into(expected, expected)
        lift(copy_into)(shared, shared)
        self.assertEqual(shared, expected)

    def test_defaults_are_filled_in(self):
        self.check(with_default, [(2,), (2, 4), (1.5,)], expect_compiled=True)
        self.check(calls_default, [(2,), (2.5,)], expect_compiled=True)
        lifted = lift(with_default)
        self.assertEqual(lifted(2, k=5), 10)

    def test_loop_else_and_endless_loops(self):
        self.check(first_index, [([1, 2, 3], 2), ([1, 2, 3], 9), ([1.5], 1.5)], expect_compiled=True)
        self.check(spin, [(1,), (5,), (0,)], expect_compiled=True)

    def test_slices_and_list_methods(self):
        self.check(shuffle, [(n, k) for n in range(2, 7) for k in range(-1, n + 1)], expect_compiled=True)

    def test_raise_falls_back_to_python(self):
        lifted = self.check(checked_log, [(1,), (2,), (1024,), (3,), (1000,)], expect_compiled=True)
        with self.assertRaises(ValueError):
            lifted(6)

    def test_int_start_promoted_for_float_sums(self):
        calls = [([1.5, 2.5], [2.0, 4.0]), ([1, 2], [0.5, 0.25]), ([], []), ([1, 2], [3, 4]), ([-0.0], [1.0])]
        lifted = self.check(dot, calls, expect_compiled=True)
        self.assertIs(type(lift(dot)([], [])), int)
        self.assertIs(type(lifted([1, 2], [3, 4])), int)

    def test_array_arguments_keep_list_behaviour(self):
        self.check(head, [([1.0, 2.0, 3.0],), ([1, 2, 3],)])
        self.check(doubled, [([1.0, 2.0],), ([1, 2],)])
        self.check(echo, [([1.5, 2.5, 3.5],)])
        self.check(doubled_length, [([1.0, 2.0],), ([3],)])
        self.check(nonempty, [([0.0], 1.0), ([1.0, 0.0], 2.0), ([False], 1.0)])

    def test_powers_match_python(self):
        values = [value for value in INTS + FLOATS if not (type(value) is int and abs(value) > 1000)]
        self.check(cube_root, [(value,) for value in values], expect_compiled=True)
        self.check(uses_power, [(value,) for value in INTS + FLOATS], expect_compiled=True)

    def test_nested_unpacking_and_shared_lists(self):
        a, b, c = ([0.0, 1.0], [0.5, 0.0], 2.0), ([3.0, 4.0], [0.0, 0.25], 1.5), ([1.0, -2.0], [1.0, 1.0], 0.5)
        pairs = [(a, b), (a, c), (b, c)]
        self.check(pair_energy, [(pairs,), ([((1.0, 2.0), [0.0, 0.0], 1.0), ((2.0, 2.0), [0.0, 0.0], 1.0)],),
                                 ([(([1.0, 2.0, 3.0], [0.0], 1.0), ([2.0, 2.0], [0.0, 0.0], 1.0))],)],
                   expect_compiled=True)
        bodies = [a, b, c]
        self.check(step_bodies, [(0.01, bodies), (0.5, [([1.0, 2.0], [3.0, 4.0], 1.0)])], expect_compiled=True)
        lift(step_bodies)(0.1, bodies)
        self.assertEqual(bodies[0][0], [0.05, 1.0])

    def test_loops_follow_the_list_as_python_does(self):
        self.check(grow_while_iterating, [([2],), ([0, 3],), ([],)])
        self.check(rebinds_sequence, [([5, 6],), ([1.5],)], expect_compiled=True)

    def test_fixed_length_local_lists(self):
        lifted = self.check(flips, [(n, k) for n in range(1, 7) for k in range(0, n)], expect_compiled=True)
        self.assertIn("_rc_arange", lifted.source)
        self.assertIn("_rc_rotate", lifted.source)
        self.check(resizes, [(5,), (2,)])
        self.check(returns_local, [(3,), (1,), (0,)])
        self.assertNotIn("_rc_full", lift(returns_local).source)

    def test_objects_travel_as_records(self):
        points = [Vec(1.0, 2.0, 3.0), Vec(0.5, -1.0, 2.0), Spin(3.0, 0.0, 1.0)]
        self.check(spread, [(points, 0.5), ([Vec(1, 2), Vec(3, 4)], 2)], expect_compiled=True)
        lifted = self.check(build_vec, [(1.0, 2.5), (1, 2)], expect_compiled=True)
        self.assertIsInstance(lifted(1.0, 2.0), Vec)
        self.assertIs(lift(first_point)(points), points[0])

    def test_methods_and_item_access_change_objects(self):
        grid = Grid(6, 5)
        for index in range(30):
            grid.data[index] = index * 0.5
        self.check(relax, [(grid, 3, 1.25)], expect_compiled=True)
        lifted = self.check(peek, [(grid, 2, 3), (grid, 9, 1), (grid, -1, 0)], expect_compiled=True)
        with self.assertRaises(IndexError):
            lifted(grid, 6, 0)
        counter = Slotted(0, 0.0)
        self.check(tally, [(Slotted(0, 0.0), [1.5, 2.5]), (Slotted(2, 1.0), [3.0])], expect_compiled=True)
        lift(tally)(counter, [2.0, 4.0])
        self.assertEqual((counter.count, counter.total), (2, 6.0))

    def test_one_object_passed_twice_is_one_object(self):
        point = Vec(1.0, 2.0)
        self.assertEqual(lift(twice)(point, point), 2.0)
        self.assertEqual(point.x, 2.0)

    def test_tuple_behaviour_never_leaks_into_objects(self):
        a, b = Vec(1.0, 2.0), Vec(1.0, 2.0)
        self.check(compare_points, [(a, b), (a, a)], expect_compiled=False)
        self.check(count_fields, [(a,)], expect_compiled=False)

    def test_compiled_calls_neither_leak_nor_free_too_much(self):
        # The lifter removes reference counting from its own helpers, as Numba up to
        # 0.65 did. A wrong removal would leak memory or free arrays still in use.
        from numba.core.runtime import _nrt_python, rtsys

        _nrt_python.memsys_enable_stats()
        self.addCleanup(_nrt_python.memsys_disable_stats)
        a, b, c = ([0.0, 1.0], [0.5, 0.0], 2.0), ([3.0, 4.0], [0.0, 0.25], 1.5), ([1.0, -2.0], [1.0, 1.0], 0.5)
        cases = [(scale_in_place, ([1.5, -2.0, 0.25] * 40, 1.0001)), (pair_energy, ([(a, b), (a, c), (b, c)],)),
                 (flips, (6, 3)), (dot, ([1.5, 2.5] * 50, [2.0, 4.0] * 50)), (relax, (Grid(6, 5), 1, 1.25)),
                 (spread, ([Vec(1.0, 2.0, 3.0), Vec(0.5, -1.0, 2.0)], 0.5))]
        for function, args in cases:
            lifted = lift(function)
            packed, shape, boundary = lifted._pack_call(lifted._complete(args))
            lifted(*args)
            packed, shape, boundary = lifted._pack_call(lifted._complete(args))
            arrays = [item for item in boundary.copies.values()]
            counts = [sys.getrefcount(copied) for _, copied, *_ in arrays]
            before = rtsys.get_allocation_stats()
            for _ in range(3000):
                lifted._run(packed)
            after = rtsys.get_allocation_stats()
            self.assertEqual(after.alloc - after.free, before.alloc - before.free, function.__name__)
            self.assertEqual(after.mi_alloc - after.mi_free, before.mi_alloc - before.mi_free, function.__name__)
            self.assertEqual([sys.getrefcount(copied) for _, copied, *_ in arrays], counts, function.__name__)
            self.assertGreater(lifted.compiled_calls, 0, function.__name__)
            if function is flips:
                # Its local lists are arrays made on every call: proof the counters count.
                self.assertGreater(after.alloc, before.alloc)

    def test_compiled_code_is_reused_from_disk(self):
        for function, calls in ((grow, [(5,), (50,)]), (dot, [([1, 2], [0.5, 0.25]), ([1.5], [2.0])])):
            first = self.check(function, calls, expect_compiled=True)
            again = self.check(function, calls, expect_compiled=True)
            self.assertEqual(first.source, again.source)
            hits = sum(sum(item.stats.cache_hits.values()) for item in again._dispatchers)
            self.assertGreater(hits, 0, function.__name__)

    def test_math_functions_match_python(self):
        self.check(waves, [(value,) for value in INTS + FLOATS if not (type(value) is int and abs(value) > 2**60)],
                   expect_compiled=True)

    def test_map_matches_a_python_loop(self):
        hands = [(cards,) for cards in itertools.combinations(range(20), 4)]
        lifted = lift(score_hand)
        self.assertTrue(same(lifted.map(hands), [score_hand(*args) for args in hands]))
        self.assertEqual((lifted.compiled_calls, lifted.fallback_calls), (len(hands), 0))

    def test_map_redoes_only_the_rows_that_overflow(self):
        calls = [(n,) for n in range(70)]
        lifted = lift(grow)
        self.assertTrue(same(lifted.map(calls), [grow(*args) for args in calls]))
        self.assertEqual((lifted.compiled_calls, lifted.fallback_calls), (40, 30))

    def test_map_handles_rows_it_cannot_batch(self):
        for function, calls in ((total, [(1, 2), (1.5, 2), (True, 2**70), (2, 3)]),
                                (echo, [([1, 2],), ([3, 4],)]),
                                (first_pair, [((1, 2),), ((3, 4),)]),
                                (score_hand, [((0, 1, 2, 3),), ((0, 1, 2),), ([0, 1, 2, 3],)]),
                                (flag_or_count, [(1,), (5,)]),
                                (total, [])):
            self.assertTrue(same(lift(function).map(calls), [function(*args) for args in calls]), function.__name__)

    def test_map_raises_like_a_python_loop(self):
        with self.assertRaises(ZeroDivisionError):
            lift(ratio).map([(1, 2), (1, 0), (3, 4)])

    def test_same_is_strict(self):
        self.assertFalse(same(1, 1.0))
        self.assertFalse(same(True, 1))
        self.assertFalse(same(0.0, -0.0))
        self.assertFalse(same((1, 2), [1, 2]))
        self.assertTrue(same(float("nan"), float("nan")))
        a = struct.unpack("d", struct.pack("Q", 0x7FF8000000000001))[0]
        b = struct.unpack("d", struct.pack("Q", 0x7FF8000000000002))[0]
        self.assertFalse(same(a, b))


def sum_squares(values):
    total = 0.0
    for i in range(len(values)):
        total += values[i] * values[i]
    return total


def bump_some(values, step):
    for j in range(3):
        values[j * 5] += step


def set_then_divide(values, k):
    values[0] = 5.0
    return 7 // k


def store_negative_zero(values, i):
    values[i] = -0.0


@unittest.skipUnless(numba, "numba is not installed")
class ListCacheTests(unittest.TestCase):
    """Repeated calls on the same list objects, which may reuse converted copies."""

    def twin(self, values):
        return list(values), list(values)

    def run_both(self, function, lifted, py_values, lifted_values, *extra):
        expected = function(py_values, *extra)
        got = lifted(lifted_values, *extra)
        self.assertTrue(same(expected, got), (function.__name__, expected, got))
        self.assertTrue(same(py_values, lifted_values), function.__name__)

    def test_cached_copy_follows_outside_changes(self):
        lifted = lift(sum_squares)
        py_values, lifted_values = self.twin([i * 0.5 for i in range(200)])
        for step in range(6):
            self.run_both(sum_squares, lifted, py_values, lifted_values)
            for values in (py_values, lifted_values):
                values[step * 11] = step + 0.25
        # An equal value of another type, and -0.0 for 0.0, are new objects.
        for values in (py_values, lifted_values):
            values[3] = 2
        self.run_both(sum_squares, lifted, py_values, lifted_values)
        for values in (py_values, lifted_values):
            values[3] = 2.0
            values[0] = -0.0
        self.run_both(sum_squares, lifted, py_values, lifted_values)
        for values in (py_values, lifted_values):
            values.append(1.5)
        self.run_both(sum_squares, lifted, py_values, lifted_values)
        for values in (py_values, lifted_values):
            del values[:150]
        self.run_both(sum_squares, lifted, py_values, lifted_values)
        self.assertGreater(lifted.compiled_calls, 0)

    def test_sparse_write_back_over_repeated_calls(self):
        lifted = lift(bump_some)
        py_values, lifted_values = self.twin([float(i) for i in range(300)])
        for step in (1.0, 2.5, -3.0, 0.0):
            self.run_both(bump_some, lifted, py_values, lifted_values, step)
            for values in (py_values, lifted_values):
                values[5] = 100.0
        self.assertGreater(lifted.compiled_calls, 0)

    def test_negative_zero_is_written_back(self):
        lifted = lift(store_negative_zero)
        py_values, lifted_values = self.twin([0.0] * 100)
        for i in (4, 4, 50):
            self.run_both(store_negative_zero, lifted, py_values, lifted_values, i)
        self.assertEqual(lifted.fallback_calls, 0)

    def test_fallback_after_a_write_leaves_no_stale_copy(self):
        lifted = lift(set_then_divide)
        py_values, lifted_values = self.twin([1.0] * 100)
        self.run_both(set_then_divide, lifted, py_values, lifted_values, 2)
        for values in (py_values, lifted_values):
            values[0] = 1.0
        # Compiled code writes values[0], then the division fails and Python runs
        # the call again from the untouched list, raising after its own write.
        for values in (py_values, lifted_values):
            with self.assertRaises(ZeroDivisionError):
                (set_then_divide if values is py_values else lifted)(values, 0)
        self.assertTrue(same(py_values, lifted_values))
        for values in (py_values, lifted_values):
            values[0] = 3.0
        self.run_both(set_then_divide, lifted, py_values, lifted_values, 3)

    def test_one_list_passed_twice_with_a_cached_copy(self):
        lifted = lift(copy_into)
        shared = [float(i) for i in range(100)]
        expected = list(shared)
        for _ in range(3):
            copy_into(expected, expected)
            lifted(shared, shared)
            self.assertTrue(same(expected, shared))

    def test_cache_is_bounded(self):
        lifted = lift(sum_squares)
        lists = [[float(i + k) for i in range(100)] for k in range(20)]
        for values in lists:
            self.assertTrue(same(lifted(values), sum_squares(values)))
        self.assertLessEqual(len(lifted._list_cache.entries), 8)


def helper_add(a, b):
    return a + b


def helper_sub(a, b):
    return a - b


def uses_helper(a, b):
    return helper_add(a, b) * 2.0


def first_plus(values, k):
    return values[0] + k


@unittest.skipUnless(numba, "numba is not installed")
class FastCallTests(unittest.TestCase):
    """The per-call fast paths must give what the general path gives."""

    def test_large_ints_and_bools_keep_python_results(self):
        lifted = lift(total)
        for args in ((2, 3), (True, 2), (True, False), (2**63 - 1, 0), (2**70, 1), (-(2**63), -1), (1.5, None)):
            try:
                expected = total(*args)
            except TypeError:
                with self.assertRaises(TypeError):
                    lifted(*args)
                continue
            self.assertTrue(same(lifted(*args), expected), args)
        self.assertGreater(lifted.compiled_calls, 0)

    def test_equal_but_new_global_still_holds(self):
        global SCALE
        lifted = lift(scaled)
        self.assertEqual(lifted(4.0), 2.0)
        try:
            SCALE = float("0.5")  # a new float object with the same value
            self.assertEqual(lifted(4.0), 2.0)
            self.assertEqual(lifted.fallback_calls, 0)
        finally:
            SCALE = 0.5

    def test_swapped_helper_code_is_noticed(self):
        lifted = lift(uses_helper)
        self.assertEqual(lifted(5.0, 2.0), 14.0)
        original = helper_add.__code__
        try:
            helper_add.__code__ = helper_sub.__code__
            self.assertEqual(lifted(5.0, 2.0), 6.0)
        finally:
            helper_add.__code__ = original
        self.assertEqual(lifted(5.0, 2.0), 14.0)

    def test_lists_the_fast_path_cannot_take(self):
        lifted = lift(first_plus)
        for args in (([1.5, 2.5], 1.0), ([1, 2.5], 1), ([(1.0, 2.0)], 0), ([], 1), ([2**70], 1), ([True, False], 2)):
            try:
                expected = first_plus(*args)
            except (IndexError, TypeError) as exc:
                with self.assertRaises(type(exc)):
                    lifted(*args)
                continue
            self.assertTrue(same(lifted(*args), expected), args)


class Body:
    def __init__(self, x, v, m):
        self.x = x
        self.v = v
        self.m = m

    def energy(self):
        return 0.5 * self.m * self.v * self.v


def total_energy(bodies):
    total = 0.0
    for body in bodies:
        total += body.energy()
    return total


def drift(bodies, dt):
    for i in range(len(bodies)):
        bodies[i].x += bodies[i].v * dt


def pick_heaviest(bodies):
    best = 0
    for i in range(len(bodies)):
        if bodies[i].m > bodies[best].m:
            best = i
    return bodies[best]


def give_back(bodies):
    return bodies


def drift_and_add(bodies, extra, dt):
    for i in range(len(bodies)):
        bodies[i].x += bodies[i].v * dt
    extra.x += 1.0
    return extra.x


@unittest.skipUnless(numba, "numba is not installed")
class ObjectColumnTests(unittest.TestCase):
    """Lists of objects of one class travel as one array per attribute."""

    def bodies(self, n, start=0.0):
        return [Body(start + i * 0.5, 1.0 - i * 0.01, 1.0 + (i % 7)) for i in range(n)]

    def test_loops_over_object_lists_compile_and_match(self):
        lifted = lift(total_energy)
        for n in (1, 5, 40, 500):
            bodies = self.bodies(n)
            self.assertTrue(same(lifted(bodies), total_energy(bodies)), n)
        self.assertEqual(lifted.fallback_calls, 0)

    def test_attribute_writes_reach_the_objects(self):
        lifted = lift(drift)
        expected, got = self.bodies(300), self.bodies(300)
        kept = [(body, body.v, body.m) for body in got]
        for dt in (0.1, -0.25, 0.0):
            drift(expected, dt)
            lifted(got, dt)
            self.assertTrue(same(expected, got))
        self.assertEqual(lifted.fallback_calls, 0)
        # The same objects, and attributes never written keep their objects.
        for body, (original, v, m) in zip(got, kept):
            self.assertIs(body, original)
            self.assertIs(body.v, v)
            self.assertIs(body.m, m)

    def test_returned_rows_are_the_original_objects(self):
        lifted = lift(pick_heaviest)
        bodies = self.bodies(50)
        self.assertIs(lifted(bodies), pick_heaviest(bodies))
        self.assertGreater(lifted.compiled_calls, 0)
        self.assertIs(lift(give_back)(bodies), bodies)

    def test_shared_or_mixed_lists_fall_back_correctly(self):
        lifted = lift(drift_and_add)
        cases = []
        bodies = self.bodies(10)
        cases.append((bodies, bodies[3]))  # an object both in the list and passed alone
        twice = self.bodies(5)
        cases.append((twice + [twice[0]], Body(0.0, 0.0, 1.0)))  # one object twice
        mixed = self.bodies(5)
        mixed[2].v = 1  # an int where the others hold floats
        cases.append((mixed, Body(0.0, 0.0, 1.0)))
        extra = self.bodies(4)
        extra[1].label = 2.0  # an attribute the class doesn't set
        cases.append((extra, Body(0.0, 0.0, 1.0)))
        for items, alone in cases:
            py_items, py_alone = copy.deepcopy((items, alone))
            expected = drift_and_add(py_items, py_alone, 0.5)
            got = lifted(items, alone, 0.5)
            self.assertTrue(same(expected, got))

            def state(objects):
                # Attribute values in order: also covers objects with extra attributes.
                return [tuple(sorted(vars(item).items())) for item in objects]

            self.assertTrue(same(state(py_items), state(items)))
            self.assertTrue(same(state([py_alone]), state([alone])))

    def test_column_calls_neither_leak_nor_free_too_much(self):
        from numba.core.runtime import _nrt_python, rtsys

        _nrt_python.memsys_enable_stats()
        self.addCleanup(_nrt_python.memsys_disable_stats)
        for function, args in ((total_energy, (self.bodies(64),)), (drift, (self.bodies(64), 0.001)),
                               (pick_heaviest, (self.bodies(64),))):
            lifted = lift(function)
            lifted(*args)
            packed, shape, boundary = lifted._pack_call(lifted._complete(args))
            columns = [array for value in packed if type(value).__name__.startswith("_rcc_") for array in value]
            self.assertTrue(columns, function.__name__)
            counts = [sys.getrefcount(array) for array in columns]
            before = rtsys.get_allocation_stats()
            for _ in range(3000):
                lifted._run(packed)
            after = rtsys.get_allocation_stats()
            self.assertEqual(after.alloc - after.free, before.alloc - before.free, function.__name__)
            self.assertEqual(after.mi_alloc - after.mi_free, before.mi_alloc - before.mi_free, function.__name__)
            self.assertEqual([sys.getrefcount(array) for array in columns], counts, function.__name__)



from math import cos as cosine, sqrt as square_root  # noqa: E402


class Dot:
    __slots__ = ("x", "y")

    def __init__(self, i):
        self.x = x = cosine(i)
        self.y = x * 2 + i

    def stretch(self, k):
        self.x *= k
        self.y *= k

    def larger(self, other):
        self.x = self.x if self.x > other.x else other.x
        return self

    def size(self):
        return square_root(self.x * self.x + self.y * self.y)


class Counted:
    def __init__(self, i, weight=2):
        self.n = i * weight
        self.even = i % 2 == 0
        self.share = i / 4


class Either:
    def __init__(self, value):
        self.value = value


def imported_root(x):
    return square_root(x) + cosine(x)


def make_and_reduce(n, k):
    dots = [None] * n
    for i in range(n):
        dots[i] = Dot(i)
    for dot in dots:
        dot.stretch(k)
    best = dots[0]
    for dot in dots[1:]:
        best = best.larger(dot)
    return best


def make_total(n):
    dots = n * [None]
    for i in range(n):
        dots[i] = Dot(i)
    total = 0.0
    for dot in dots:
        total += dot.size()
    return total


def make_counted(n):
    items = [None] * n
    for i in range(n):
        items[i] = Counted(i)
    total = 0
    for item in items:
        if item.even:
            total += item.n
    return total, items[n - 1].share


def make_list(n):
    dots = [None] * n
    for i in range(n):
        dots[i] = Dot(i)
    for dot in dots:
        dot.stretch(0.5)
    return dots


def make_list_and_one(n):
    dots = [None] * n
    for i in range(n):
        dots[i] = Dot(i)
    dots[0].stretch(3.0)
    return dots, dots[0], dots[n - 1]


def make_same_twice(n):
    items = [None] * n
    for i in range(n):
        items[i] = Counted(i)
    return items[0], items[0]


def make_mixed(n):
    items = [None] * n
    for i in range(n):
        items[i] = Either(i)
        items[i] = Either(i * 0.5)
    return items[n - 1].value


def make_then_store(n):
    dots = [None] * n
    for i in range(n):
        dots[i] = Dot(i)
    dots[0] = Dot(5)
    return dots[0].x


def make_partly(n):
    dots = [None] * n
    for i in range(n - 1):
        dots[i] = Dot(i)
    return dots[0].x


def make_and_read_early(n):
    dots = [None] * n
    for i in range(n):
        dots[i] = Dot(i)
        if i:
            dots[i - 1].stretch(2.0)
    return dots[0].x


def stretch_tail(bodies, k):
    for body in bodies[1:]:
        body.x *= k
    return bodies[1:][0].x


@unittest.skipUnless(numba, "numba is not installed")
class MadeObjectTests(unittest.TestCase):
    """Objects a function makes and keeps in a list live in compiled code as columns."""

    def test_math_functions_imported_by_name(self):
        lifted = lift(imported_root)
        for x in (0.0, 2.0, 9, 1e300):
            self.assertTrue(same(lifted(x), imported_root(x)), x)
        self.assertTrue(math.isnan(lifted(float("nan"))))
        self.assertRaises(ValueError, lifted, -1.0)
        self.assertEqual(lifted.fallback_calls, 1)

    def test_a_list_of_new_objects_compiles_and_matches(self):
        lifted = lift(make_and_reduce)
        for n, k in ((1, 2.0), (2, -1.5), (9, 0.25), (5000, 3.0)):
            self.assertTrue(same(lifted(n, k), make_and_reduce(n, k)), n)
        self.assertEqual(lifted.fallback_calls, 0)
        total = lift(make_total)
        for n in (0, -3, 1, 77):
            self.assertTrue(same(total(n), make_total(n)), n)
        self.assertEqual(total.fallback_calls, 0)

    def test_an_empty_list_raises_as_in_python(self):
        lifted = lift(make_and_reduce)
        for n in (0, -2):
            self.assertRaises(IndexError, lifted, n, 1.0)

    def test_attributes_that_are_ints_and_bools(self):
        lifted = lift(make_counted)
        for n in (1, 2, 31):
            self.assertTrue(same(lifted(n), make_counted(n)), n)
        self.assertGreater(lifted.compiled_calls, 0)
        self.assertEqual(lifted.fallback_calls, 0)

    def test_the_list_comes_back_as_new_objects(self):
        lifted = lift(make_list)
        got, expected = lifted(40), make_list(40)
        self.assertEqual(lifted.fallback_calls, 0)
        self.assertIs(type(got), list)
        self.assertEqual({type(item) for item in got}, {Dot})
        self.assertTrue(same([(d.x, d.y) for d in got], [(d.x, d.y) for d in expected]))
        self.assertEqual(len(set(map(id, got))), 40)
        self.assertEqual(lifted(0), [])

    def test_an_object_returned_twice_is_one_object(self):
        lifted = lift(make_list_and_one)
        dots, first, last = lifted(6)
        self.assertEqual(lifted.fallback_calls, 0)
        self.assertIs(first, dots[0])
        self.assertIs(last, dots[5])
        expected = make_list_and_one(6)
        self.assertTrue(same([(d.x, d.y) for d in dots], [(d.x, d.y) for d in expected[0]]))
        # Nothing assigned after creation: two equal results may be one object.
        twice = lift(make_same_twice)
        a, b = twice(3)
        self.assertIs(a, b)
        self.assertEqual((a.n, a.even, a.share), (0, True, 0.0))

    def test_lists_outside_the_pattern(self):
        self.assertTrue(same(lift(make_mixed)(4), make_mixed(4)))
        for function in (make_then_store, make_partly, make_and_read_early):
            self.assertRaises(Unsupported, lift, function)

    def test_a_slice_of_an_object_list_holds_the_same_objects(self):
        lifted = lift(stretch_tail)
        expected = [Body(1.0 + i, 0.5, 2.0) for i in range(8)]
        got = copy.deepcopy(expected)
        self.assertTrue(same(lifted(got, 3.0), stretch_tail(expected, 3.0)))
        self.assertTrue(same(expected, got))
        self.assertEqual(lifted.fallback_calls, 0)

    def test_object_code_is_loaded_from_the_disk_cache_by_a_later_process(self):
        import subprocess

        script = (
            "import sys\n"
            f"sys.path[:0] = [{str(Path(__file__).resolve().parents[1] / 'src')!r}, {str(Path(__file__).parent)!r}]\n"
            "import test_lift as t\n"
            "for function, args in ((t.make_and_reduce, (40, 2.0)), (t.make_counted, (9,)), (t.total_energy, None)):\n"
            "    args = args or ([t.Body(1.0 + i, 0.5, 2.0) for i in range(70)],)\n"
            "    lifted = t.lift(function)\n"
            "    assert t.same(lifted(*args), function(*args)), function.__name__\n"
            "    assert lifted.fallback_calls == 0, function.__name__\n"
            "    stats = lifted._compiled.stats\n"
            "    print(function.__name__, sum(stats.cache_hits.values()), sum(stats.cache_misses.values()))\n")
        with tempfile.TemporaryDirectory(prefix="recompyler-cache-test-") as folder:
            environment = dict(os.environ, RECOMPYLER_CACHE=folder)
            runs = [subprocess.run([sys.executable, "-c", script], capture_output=True, text=True, env=environment,
                                   timeout=600) for _ in range(2)]
        for done in runs:
            self.assertEqual(done.returncode, 0, done.stderr[-2000:])
        first, second = ([line.split() for line in done.stdout.splitlines()] for done in runs)
        self.assertEqual([row[0] for row in second], ["make_and_reduce", "make_counted", "total_energy"])
        for name, hits, misses in first:
            self.assertEqual((name, hits), (name, "0"))
        for name, hits, misses in second:
            self.assertEqual((name, misses), (name, "0"))
            self.assertGreater(int(hits), 0, name)

    def test_made_lists_neither_leak_nor_free_too_much(self):
        from numba.core.runtime import _nrt_python, rtsys

        _nrt_python.memsys_enable_stats()
        self.addCleanup(_nrt_python.memsys_disable_stats)
        for function, args in ((make_and_reduce, (50, 2.0)), (make_total, (50,)), (make_list, (50,))):
            lifted = lift(function)
            lifted(*args)
            before = rtsys.get_allocation_stats()
            for _ in range(2000):
                lifted(*args)
            after = rtsys.get_allocation_stats()
            self.assertEqual(lifted.fallback_calls, 0, function.__name__)
            self.assertEqual(after.alloc - after.free, before.alloc - before.free, function.__name__)
            self.assertEqual(after.mi_alloc - after.mi_free, before.mi_alloc - before.mi_free, function.__name__)


if __name__ == "__main__":
    unittest.main()
