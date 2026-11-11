import copy
import math
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

try:
    import numba  # noqa: F401
except ImportError:
    numba = None

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="recompyler-tests-"))

from recompyler import heap  # noqa: E402
from recompyler.heap import lift_region  # noqa: E402
from recompyler.lift import same  # noqa: E402

LIMIT = 10


class Vec:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def length(self):
        return math.sqrt(self.x * self.x + self.y * self.y)

    def scale(self, k):
        self.x *= k
        self.y *= k
        return self


class Node:
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None
        self.count = 1

    def insert(self, key):
        if key == self.key:
            self.count += 1
        elif key < self.key:
            if self.left is None:
                self.left = Node(key)
            else:
                self.left.insert(key)
        else:
            if self.right:
                self.right.insert(key)
            else:
                self.right = Node(key)

    def total(self):
        result = self.key * self.count
        if self.left is not None:
            result += self.left.total()
        if self.right is not None:
            result += self.right.total()
        return result

    def depth(self):
        left = self.left.depth() if self.left else 0
        right = self.right.depth() if self.right else 0
        return 1 + (left if left > right else right)


class Bag:
    def __init__(self):
        self.items = []
        self.best = None

    def add(self, vec):
        self.items.append(vec)
        if self.best is None or vec.length() > self.best.length():
            self.best = vec


class Account:
    def __init__(self, balance):
        self.balance = balance
        self.history = [balance]


def grow_and_link(nodes, accounts, rounds):
    """Changes ints, floats, links between objects passed in and new objects."""
    for r in range(rounds):
        for account in accounts:
            account.balance += r
            account.history.append(account.balance)
    nodes[0].right = nodes[len(nodes) - 1]
    nodes[0].count += 1
    fresh = Node(99.5)
    nodes[len(nodes) - 1].left = fresh
    total = 0.0
    for node in nodes:
        total += node.key * node.count
    return total, fresh


def build_tree(keys):
    root = Node(keys[0])
    for key in keys[1:]:
        root.insert(key)
    return root.total(), root.depth()


def make_tree(keys):
    root = Node(keys[0])
    for key in keys[1:]:
        root.insert(key)
    return root


def is_even(n):
    if n == 0:
        return True
    return is_odd(n - 1)


def is_odd(n):
    if n == 0:
        return False
    return is_even(n - 1)


def count_even(n):
    total = 0
    for i in range(n):
        if is_even(i):
            total += 1
    return total


def countdown(n):
    if n <= 0:
        return 0
    return 1 + countdown(n - 1)


def starts_whole(values):
    total = 0
    for value in values:
        total += value
    return total


def whole_or_not(n, flag):
    total = 0
    step = 2
    for _ in range(n):
        total += step
    if flag:
        total += 0.5
    return total, step * total


def longest(vectors):
    bag = Bag()
    for vec in vectors:
        bag.add(vec)
    return bag.best, len(bag.items), bag.items[0] is vectors[0]


def stretch_all(vectors, k):
    for vec in vectors:
        vec.scale(k)
    vectors.append(Vec(k, -k))
    return vectors


def deposit(account, amount):
    account.balance += amount
    account.history.append(account.balance)
    return account.history


def replace_first(vectors):
    vectors[0] = Vec(vectors[0].y, vectors[0].x)
    return vectors[0]


def pick(values, index):
    return values[index]


def ratio(vec):
    return vec.x / vec.y


def first_length(bag):
    return bag.best.length()


def factorial(n):
    result = 1
    for i in range(2, n + 1):
        result *= i
    return result


def many(n):
    made = [None] * n
    for i in range(n):
        made[i] = Vec(i * 0.5, i)
    total = 0.0
    for vec in made:
        total += vec.length()
    return total


def scaled_limit(x):
    return x * LIMIT


def uses_a_string(x):
    return str(x)


def swap(a, b):
    a, b = b, a
    return a, b


def slices(values):
    head = values[:2]
    tail = values[-2:]
    head.append(9.5)
    return head, tail, values[1:3]


def chained(a, b, c):
    return a < b <= c, (a if a > b else b)


@unittest.skipUnless(numba, "numba is not installed")
class RegionTests(unittest.TestCase):
    """Whole regions compiled over a heap of object handles."""

    def agree(self, function, *args, compiled=True):
        region = function if hasattr(function, "original") else lift_region(function)
        mine, theirs = copy.deepcopy(args), copy.deepcopy(args)
        try:
            expected = region.original(*theirs)
        except Exception as exc:
            self.assertRaises(type(exc), region, *mine)
            self.assertTrue(same(list(mine), list(theirs)))
            return region
        got = region(*mine)
        self.assertTrue(same(got, expected), (got, expected, region.problem, region.gave_up))
        self.assertTrue(same(list(mine), list(theirs)), "arguments differ after the call")
        if compiled:
            self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))
        return region

    def test_objects_that_hold_objects_and_none(self):
        region = lift_region(build_tree)
        for keys in ([5], [5, 3, 8, 1, 4, 5, 9, 8, 8], list(range(40)), [0.5, -2.5, 7.25, 0.5]):
            self.agree(region, keys)
        self.assertEqual(region.fallback_calls, 0)

    def test_a_made_tree_comes_back_as_objects(self):
        region = lift_region(make_tree)
        got, expected = region([4, 2, 6, 2, 7]), make_tree([4, 2, 6, 2, 7])
        self.assertEqual(region.fallback_calls, 0, region.problem)
        self.assertIs(type(got), Node)
        self.assertTrue(same(got, expected))
        self.assertIsNone(got.left.left)
        self.assertEqual((got.left.count, got.right.right.key), (2, 7))

    def test_functions_that_call_each_other(self):
        region = self.agree(count_even, 25)
        self.assertEqual(region(0), 0)

    def test_deep_recursion_goes_back_to_python(self):
        region = lift_region(countdown)
        self.assertEqual(region(200), 200)
        self.assertEqual(region.fallback_calls, 0)
        self.assertRaises(RecursionError, region, 10 ** 6)

    def test_a_number_keeps_the_type_python_gives_it(self):
        region = lift_region(starts_whole)
        for values in ([1.5, 2.5], [0.0], [-0.0], [1e300, 1e300]):
            self.agree(region, values)
        self.agree(starts_whole, [])              # the int 0, not 0.0
        self.agree(starts_whole, [3, 4, 5])
        mixed = lift_region(whole_or_not)
        for n, flag in ((0, False), (3, False), (3, True), (0, True)):
            got = mixed(n, flag)
            self.assertTrue(same(got, whole_or_not(n, flag)), (n, flag, got))
        self.assertEqual(mixed.fallback_calls, 0, (mixed.problem, mixed.gave_up))

    def test_lists_in_attributes_and_identity(self):
        vectors = [Vec(1.0, 2.0), Vec(-4.0, 3.0), Vec(0.5, 0.5)]
        region = lift_region(longest)
        best, count, first = region(vectors)
        self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))
        self.assertIs(best, vectors[1])
        self.assertEqual((count, first), (3, True))

    def test_changes_reach_the_objects_passed_in(self):
        region = lift_region(stretch_all)
        vectors = [Vec(1.0, 2.0), Vec(3.0, -1.5)]
        kept = list(vectors)
        result = region(vectors, 2.0)
        self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))
        self.assertIs(result, vectors)
        self.assertEqual(len(vectors), 3)
        self.assertIs(vectors[0], kept[0])
        self.assertIs(vectors[1], kept[1])
        self.assertEqual([(v.x, v.y) for v in vectors], [(2.0, 4.0), (6.0, -3.0), (2.0, -2.0)])
        shared = Vec(1.0, 1.0)
        twice = [shared, shared]
        region(twice, 3.0)
        self.assertEqual((shared.x, len(twice)), (9.0, 3))
        self.assertIs(twice[0], twice[1])

    def test_untouched_attributes_keep_their_objects(self):
        account = Account(10.5)
        history, balance = account.history, account.balance
        region = lift_region(pick)
        region(account.history, 0)
        self.assertIs(account.balance, balance)
        deposits = lift_region(deposit)
        self.assertIs(deposits(account, 2.0), history)
        self.assertEqual((account.balance, history), (12.5, [10.5, 12.5]))
        self.assertEqual(deposits.fallback_calls, 0, (deposits.problem, deposits.gave_up))

    def test_a_new_object_stored_into_an_old_list(self):
        self.agree(replace_first, [Vec(1.0, 2.0), Vec(3.0, 4.0)])

    def test_python_errors_come_from_python(self):
        region = lift_region(pick)
        self.assertEqual(region([1.5, 2.5], -1), 2.5)
        self.assertRaises(IndexError, region, [1.5, 2.5], 2)
        self.assertEqual(region.gave_up[0], "pick")
        self.assertRaises(ZeroDivisionError, lift_region(ratio), Vec(1.0, 0.0))
        self.assertRaises(AttributeError, lift_region(first_length), Bag())
        self.assertRaises(IndexError, lift_region(build_tree), [])

    def test_ints_too_large_for_the_machine(self):
        region = lift_region(factorial)
        self.assertEqual(region(10), 3628800)
        self.assertEqual(region.fallback_calls, 0)
        self.assertEqual(region(30), math.factorial(30))
        self.assertEqual(region.fallback_calls, 1)

    def test_the_heap_grows_when_it_fills(self):
        region = lift_region(many)
        self.assertTrue(same(region(60000), many(60000)))
        self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))
        self.assertGreater(region.slots, 1 << 16)

    def test_code_outside_the_subset_runs_in_python(self):
        region = lift_region(uses_a_string)
        self.assertEqual(region(1.5), "1.5")
        self.assertIn("str", region.problem)

    def test_a_changed_global_is_noticed(self):
        global LIMIT
        region = lift_region(scaled_limit)
        self.assertEqual(region(2.0), 20.0)
        self.assertEqual(region.fallback_calls, 0)
        LIMIT = 4
        try:
            self.assertEqual(region(2.0), 8.0)
        finally:
            LIMIT = 10

    def test_regions_load_from_the_disk_cache(self):
        region = lift_region(countdown)
        self.assertEqual(region(30), 30)
        self.assertTrue(region.latest.cached)
        # A fresh process with the same cache compiles nothing.
        with tempfile.TemporaryDirectory() as tmp:
            folder = Path(tmp)
            (folder / "shapes.py").write_text(
                "class Vec:\n    def __init__(self, x, y):\n        self.x = x\n        self.y = y\n\n"
                "def longest(n):\n    best = None\n    for i in range(n):\n        v = Vec(i * 0.5, 3.0 - i)\n"
                "        if best is None or v.x * v.x + v.y * v.y > best.x * best.x + best.y * best.y:\n"
                "            best = v\n    return best.x, best.y\n", encoding="utf-8")
            code = ("import sys; sys.path[:0] = [sys.argv[1], sys.argv[2]]; import shapes; "
                    "from recompyler.heap import lift_region; region = lift_region(shapes.longest); "
                    "print(region(50), region.fallback_calls, region.latest.cached, "
                    "len(region.latest.run.stats.cache_misses))")
            env = dict(os.environ, RECOMPYLER_CACHE=str(folder / "cache"), PYTHONWARNINGS="ignore")
            src = str(Path(__file__).resolve().parents[1] / "src")
            runs = [subprocess.run([sys.executable, "-c", code, tmp, src], capture_output=True, text=True, env=env,
                                   timeout=300) for _ in range(2)]
            for run in runs:
                self.assertEqual(run.returncode, 0, run.stderr[-2000:])
            first, second = (run.stdout.split() for run in runs)
            self.assertEqual(first[:4], second[:4])
            self.assertEqual(second[2:5], ["0", "True", "0"])

    def test_functions_that_call_each_other_compile_without_the_cache(self):
        # Numba's disk cache crashes when it reloads functions that call each other.
        region = lift_region(count_even)
        self.assertEqual(region(10), 5)
        self.assertFalse(region.latest.cached)

    def test_small_things(self):
        self.agree(swap, 1.5, 2)
        self.agree(slices, [1.0, 2.0, 3.0, 4.0])
        self.agree(slices, [1.0])
        self.agree(chained, 1, 2, 2)
        self.agree(chained, 3.5, 2.0, 9.0)
        self.agree(many, 0)


@unittest.skipIf(heap._native is None, "the C loader is not built")
class PythonLoaderTests(RegionTests):
    """The same tests with objects copied by the Python loader instead of _heap.c."""

    def setUp(self):
        heap.NATIVE = False

    def tearDown(self):
        heap.NATIVE = True

    test_regions_load_from_the_disk_cache = None


class NativeLoaderTests(unittest.TestCase):
    @unittest.skipIf(heap._native is None, "the C loader is not built")
    def test_both_loaders_give_the_same_results_and_changes(self):
        def run(native):
            heap.NATIVE = native
            try:
                region = lift_region(grow_and_link)
                nodes = [Node(float(i)) for i in range(5)]
                nodes[1].left, nodes[3].right = nodes[2], nodes[1]
                accounts = [Account(i) for i in range(4)]
                result = region(nodes, accounts, 4)
                self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))
                return result, nodes, accounts
            finally:
                heap.NATIVE = True

        native, plain = run(True), run(False)
        expected = grow_and_link([Node(float(i)) for i in range(5)], [Account(i) for i in range(4)], 4)
        self.assertTrue(same(native, plain))
        self.assertTrue(same(native[0], plain[0]))
        self.assertIs(native[1][0].right, native[1][4])
        self.assertTrue(same(native[0], expected) and type(native[2][3].balance) is int)

    @unittest.skipIf(heap._native is None, "the C loader is not built")
    def test_values_that_do_not_fit_go_back_to_python(self):
        region = lift_region(grow_and_link)
        nodes = [Node(float(i)) for i in range(3)]
        region(nodes, [Account(1)], 1)
        odd = [Node(float(i)) for i in range(3)]
        odd[1].extra = 1
        self.assertTrue(same(region(odd, [Account(1)], 1), grow_and_link(copy.deepcopy(odd), [Account(1)], 1)))
        big = [Account(2 ** 70)]
        self.assertTrue(same(region(nodes, big, 1), grow_and_link(nodes, [Account(2 ** 70)], 1)))
        self.assertGreaterEqual(region.fallback_calls, 2)

    @unittest.skipIf(heap._native is None, "the C loader is not built")
    def test_the_heap_grows_for_large_arguments(self):
        region = lift_region(grow_and_link)
        nodes = [Node(float(i)) for i in range(30000)]
        accounts = [Account(i * 0.5) for i in range(30000)]
        expected = grow_and_link(copy.deepcopy(nodes), copy.deepcopy(accounts), 3)
        self.assertTrue(same(region(nodes, accounts, 3), expected))
        self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))
        self.assertGreater(region.slots, heap.START_SLOTS)


if __name__ == "__main__":
    unittest.main()
