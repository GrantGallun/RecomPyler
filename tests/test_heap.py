import array
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


def last_index(xs):
    for i in range(len(xs)):
        pass
    return i


def sign_of(a):
    if a < 0:
        s = -1
    elif a > 0:
        s = 1
    return s


def first_above(xs, k):
    for x in xs:
        if x > k:
            found = x
            break
    else:
        found = -1.0
    return found


def carried(n):
    total = 0
    i = 0
    while i < n:
        if i == 0:
            prev = 0
        else:
            total += prev
            prev = i
        i += 1
    else:
        total += 1000
    return total


def largest_doubled(xs):
    try:
        best = xs[0]
        for x in xs:
            if x > best:
                best = x
    except IndexError:
        best = -1.0
    else:
        best = best * 2.0
    return best


def bumped(flag, n):
    if flag:
        count = n
    count += 1
    return count


registry = [None]


class Shape:
    def __init__(self, a):
        self.a = a
        self.b = a * 2
        registry[0] = self
        self.c = 0

    def value(self):
        return self.a + self.b + self.c


class Square(Shape):
    def __init__(self, a, d):
        super().__init__(a)
        self.d = d

    def value(self):
        return super().value() * 10 + self.d


class Bare:
    def __init__(self):
        super().__init__()
        self.x = 1.5


def through_super(n):
    total = 0
    for i in range(n):
        total += Square(i, 3).value() + Shape(i).value()
    return total, Bare().x, registry[0].a


def members(xs, ys, nodes, node):
    n = 0
    for y in ys:
        if y in xs:
            n += 1
        if y not in xs:
            n += 100
    if node in nodes:
        n += 10000
    if None in nodes:
        n += 100000
    return n


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



async def afib(n):
    if n <= 1:
        return n
    return await afib(n - 1) + await afib(n - 2)


def drive(coroutine):
    try:
        while True:
            coroutine.send(None)
    except StopIteration as stop:
        return stop.value


class Shape:
    def __init__(self, size):
        self.size = size

    def area(self):
        return self.size * self.size

    def describe(self):
        return self.area() + 0.5


class Circle(Shape):
    def __init__(self, size):
        Shape.__init__(self, size)
        self.turns = 1

    def area(self):
        return 3.0 * self.size * self.size


class Square(Shape):
    def __init__(self, size):
        Shape.__init__(self, size)
        self.corners = 4


class Tally:
    def __init__(self):
        self.count = 0
        self.last = None


TALLY = Tally()
VERBOSE = False
FOUR = range(4)


def shapes_total(shapes):
    total = 0.0
    for shape in shapes:
        total += shape.describe()
        if isinstance(shape, Circle):
            TALLY.count += 1
            TALLY.last = shape
        if VERBOSE:
            print("shape", shape)
    return total


def corners(shapes):
    found = 0
    for shape in shapes:
        assert isinstance(shape, Square)
        found += shape.corners
    return found


def make_shapes(n):
    out = []
    for i in range(n):
        if i % 3 == 0:
            out.append(Circle(i * 0.5))
        elif i % 3 == 1:
            out.append(Square(i * 0.5))
        else:
            out.append(Shape(i * 0.5))
    return out


def mixing(n):
    acc = 0
    for i in FOUR:
        acc = (acc ^ (n * 31 + i)) & 0xffff | i
    return acc, (n & 1) == 1



class Arrow:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __add__(self, other):
        if other.isSpot():
            return Spot(self.x + other.x, self.y + other.y)
        return Arrow(self.x + other.x, self.y + other.y)

    def __sub__(self, other):
        return Arrow(self.x - other.x, self.y - other.y)

    def isSpot(self):
        return False


class Spot:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __sub__(self, other):
        if other.isSpot():
            return Arrow(self.x - other.x, self.y - other.y)
        return Spot(self.x - other.x, self.y - other.y)

    def isSpot(self):
        return True


Arrow.UNIT = Arrow(1, 0)


class Board:
    def __init__(self, width, colour):
        self.cells = array.array("B", [0] * width)
        for i in range(width):
            self.cells[i] = 1
        self.width = width
        self.colour = colour
        self.depth = 0
        self.items = [(Spot(0, 0), 1.5), (Spot(2, 1), None)]

    def paint(self, at, r, g, b):
        self.cells[at] = max(0, min(255, int(r * 255) + int(g) + int(b)))


def hit(t):
    if t > 2:
        return None
    return t * 0.5


def nearest(pairs):
    best = None
    for pair in pairs:
        t = pair[1]
        if t is not None and (best is None or t < best[1]):
            best = pair
    return best


def guarded(board):
    if board.depth > 2:
        return (0, 0, 0)
    try:
        board.depth = board.depth + 1
        found = nearest([(spot, hit(i)) for i, (spot, t) in enumerate_items(board.items) if t is None or t > 0])
        if found is None:
            return (0, 0, 0)
        else:
            (spot, t) = found
            return (spot.x * t, 1, t)
    finally:
        board.depth = board.depth - 1


def enumerate_items(items):
    out = []
    i = 0
    for item in items:
        out.append((i, item))
        i += 1
    return out


def draw(board, base):
    total = 0
    moved = base + Arrow.UNIT - Spot(1, 1)
    for at in range(board.width):
        colour = guarded(board)
        board.paint(at, *colour)
        amount = 0
        for spot, t in board.items:
            if t is not None:
                amount = amount + t
        total = total + min(1, amount) + max(at, 0.25)
    return total, moved.x, moved.y, board.colour



class Pos:
    def __init__(self, x, y):
        self.x = x
        self.y = y


def pixel_sum(points, k):
    # Int-or-float arithmetic whose int-ness never reaches Python: the result is an
    # int made by int(), as raytrace's bytes are.
    total = 0
    for p in points:
        v = p.x * k - p.y * k
        w = v * -1
        total += int(w * 0.5 + p.x * p.y)
    return total


def mixed_result(points):
    acc = 0
    for p in points:
        acc = acc + p.x * p.y
    return acc


def mixed_written(points):
    for p in points:
        p.x = p.x * 2 + p.y
    return len(points)


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

    def test_recursion_reloads_from_the_disk_cache(self):
        # Numba's disk cache crashes when it reloads functions that call each other,
        # or a recursive function compiled for more than one set of types (as literal
        # arguments cause). Groups that call each other are merged into one function,
        # and recursive calls pass typed values; a second process must load it all.
        region = lift_region(count_even)
        self.assertEqual(region(10), 5)
        self.assertTrue(region.latest.cached)
        self.assertEqual(len([name for name in vars(region.latest.module) if name.startswith("s0_")]), 1)
        with tempfile.TemporaryDirectory() as tmp:
            folder = Path(tmp)
            (folder / "calls.py").write_text(
                "def is_even(n, flag):\n    if n == 0:\n        return True\n    return is_odd(n - 1, 0)\n\n"
                "def is_odd(n, flag):\n    if n == 0:\n        return False\n    return is_even(n - 1, 1)\n\n"
                "def depth(n, step):\n    if n <= 0:\n        return 0.5\n    return depth(n - 1, 2) + step\n\n"
                "def both(n):\n    total = 0.0\n    for i in range(n):\n        if is_even(i, 0):\n"
                "            total += depth(i, 1)\n    return total\n", encoding="utf-8")
            code = ("import sys; sys.path[:0] = [sys.argv[1], sys.argv[2]]; import calls; "
                    "from recompyler.heap import lift_region; region = lift_region(calls.both); "
                    "print(region(40), region.fallback_calls, region.latest.cached, "
                    "len(region.latest.run.stats.cache_misses))")
            env = dict(os.environ, RECOMPYLER_CACHE=str(folder / "cache"), PYTHONWARNINGS="ignore")
            src = str(Path(__file__).resolve().parents[1] / "src")
            runs = [subprocess.run([sys.executable, "-c", code, tmp, src], capture_output=True, text=True, env=env,
                                   timeout=300) for _ in range(2)]
            for run in runs:
                self.assertEqual(run.returncode, 0, run.stderr[-2000:])
            first, second = (run.stdout.split() for run in runs)
            self.assertEqual(first[0], second[0])
            self.assertEqual(second[1:4], ["0", "True", "0"])

    def test_regions_built_ahead_of_time_run_without_numba(self):
        with tempfile.TemporaryDirectory() as tmp:
            folder = Path(tmp)
            (folder / "trees.py").write_text(
                "class Node:\n    def __init__(self, key):\n        self.key = key\n        self.left = None\n"
                "        self.right = None\n\n"
                "    def insert(self, key):\n        if key < self.key:\n            if self.left is None:\n"
                "                self.left = Node(key)\n            else:\n                self.left.insert(key)\n"
                "        elif self.right is None:\n            self.right = Node(key)\n        else:\n"
                "            self.right.insert(key)\n\n"
                "def grow(root, keys):\n    for key in keys:\n        root.insert(key)\n    return root.key\n", encoding="utf-8")
            src = str(Path(__file__).resolve().parents[1] / "src")
            env = dict(os.environ, RECOMPYLER_CACHE=str(folder / "cache"), PYTHONWARNINGS="ignore")
            build = ("import sys, json; sys.path[:0] = [sys.argv[1], sys.argv[2]]; import trees; "
                     "from recompyler.heap import lift_region, build_regions; region = lift_region(trees.grow); "
                     "region(trees.Node(5.0), [1.0, 7.5, 3.0]); "
                     "print(json.dumps(build_regions([(('grow', 1), trees.grow, region)], sys.argv[1])))")
            use = ("import sys, json; sys.path[:0] = [sys.argv[1], sys.argv[2]]; import trees; "
                   "from recompyler.heap import lift_region; from recompyler.aot import load; "
                   "section = json.load(open(sys.argv[3])); module = load(section); "
                   "built = {d: getattr(module, e) for d, e in section['functions'][0]['exports'].items()}; "
                   "region = lift_region(trees.grow, built); root = trees.Node(5.0); "
                   "print(region(root, [2.0, 9.0, 1.0, 6.5]), root.left.key, root.right.left.key, "
                   "region.fallback_calls, region.latest.ahead_of_time, 'numba' in sys.modules)")
            made = subprocess.run([sys.executable, "-c", build, tmp, src], capture_output=True, text=True, env=env,
                                  timeout=600)
            self.assertEqual(made.returncode, 0, made.stderr[-2000:])
            section = made.stdout.strip().splitlines()[-1]
            self.assertIn("rcaotr_", section)
            section_path = folder / "section.json"
            section_path.write_text(section, encoding="utf-8")
            run = subprocess.run([sys.executable, "-c", use, tmp, src, str(section_path)], capture_output=True, text=True,
                                 env=env, timeout=300)
            self.assertEqual(run.returncode, 0, run.stderr[-2000:])
            self.assertEqual(run.stdout.split(), ["5.0", "2.0", "6.5", "0", "True", "False"])

    def test_awaited_coroutines_run_as_calls(self):
        region = lift_region(afib)
        made = region(15)
        self.assertEqual(drive(made), drive(afib(15)))
        self.assertEqual(region.compiled_calls, 1, (region.problem, region.gave_up))
        self.assertEqual(drive(region(0)), 0)

    def test_subclasses_through_one_variable(self):
        global VERBOSE
        region = lift_region(shapes_total)
        TALLY.count, TALLY.last = 0, None
        shapes = make_shapes(9)
        expected = shapes_total(copy.deepcopy(shapes))
        TALLY.count, TALLY.last = 0, None
        self.assertTrue(same(region(shapes), expected))
        self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))
        self.assertEqual(TALLY.count, 3)
        self.assertIs(TALLY.last, shapes[6])
        # A changed constant sends calls back to Python, which prints here.
        VERBOSE = True
        try:
            import contextlib
            import io
            with contextlib.redirect_stdout(io.StringIO()) as out:
                region(shapes)
            self.assertIn("shape", out.getvalue())
        finally:
            VERBOSE = False

    def test_isinstance_and_assert(self):
        region = lift_region(corners)
        squares = [Square(1.0), Square(2.0)]
        self.assertEqual(region(squares), 8)
        self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))
        mixed = [Square(1.0), Circle(1.0)]
        self.assertRaises(AssertionError, region, mixed)

    def test_made_subclass_objects_come_back_as_their_classes(self):
        region = lift_region(make_shapes)
        got = region(7)
        self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))
        self.assertEqual([type(shape) for shape in got], [type(shape) for shape in make_shapes(7)])
        self.assertTrue(same(got, make_shapes(7)))
        self.assertEqual((got[0].turns, got[1].corners), (1, 4))
        self.assertFalse(hasattr(got[2], "turns"))

    def test_bitwise_and_a_global_range(self):
        region = self.agree(mixing, 12345)
        self.assertEqual(region(7), mixing(7))

    def test_raytrace_shaped_code(self):
        # Unrelated classes in one value, operators and class attributes on objects,
        # numbers and tuples that may be None, tuples in attributes and lists,
        # try/finally, a list comprehension, *args, array('B') and mixed min/max.
        for base in (Arrow(2, 3), Arrow(0.5, 1)):
            region = lift_region(draw)
            board, expected_board = Board(6, (1, 0.5, 0)), Board(6, (1, 0.5, 0))
            got, expected = region(board, base), draw(expected_board, copy.deepcopy(base))
            self.assertTrue(same(got, expected), (got, expected, region.problem, region.gave_up))
            self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))
            self.assertEqual(board.cells, expected_board.cells)
            self.assertTrue(same(board.items, expected_board.items))
            self.assertEqual(board.depth, 0)
            # Arrow.__add__ is compiled for an Arrow argument, where isSpot() is a
            # constant False: Spot never meets Arrow in one value, so the two
            # classes keep layouts of their own.
            for members in region.latest.members.values():
                self.assertFalse({Arrow, Spot} <= set(members), members)

    def test_tuples_and_optional_numbers_round_trip(self):
        region = self.agree(nearest, [(Spot(0, 0), 2.5), (Spot(1, 1), None), (Spot(2, 2), 0.5)])
        self.assertIsNone(region([(Spot(0, 0), None)]))
        self.agree(nearest, [])
        self.agree(hit, 1)
        self.agree(hit, 5)

    def test_int_or_float_as_plain_floats_where_unseen(self):
        points = [Pos(3, 4), Pos(2.5, -1), Pos(0, 7), Pos(-6, 0.25)]
        region = self.agree(pixel_sum, points, 5)
        self.assertTrue(region.latest.fast_mixed)
        self.agree(pixel_sum, points, 0)
        # An int product past 2**53 is exact in Python and not as a float: the call
        # goes back to Python.
        big = [Pos(2 ** 30 + 1, 3), Pos(1, 2)]
        self.assertEqual(region(big, 2 ** 23 + 1), pixel_sum(big, 2 ** 23 + 1))
        self.assertGreater(region.fallback_calls, 0)

    def test_int_or_float_kept_exact_where_it_shows(self):
        points = [Pos(3, 4), Pos(2.5, -1), Pos(0, -7)]
        region = self.agree(mixed_result, points)
        self.assertFalse(region.latest.fast_mixed)
        self.assertIs(type(region([Pos(2, 3)])), int)
        region = self.agree(mixed_written, [Pos(3, 4), Pos(2.5, -1), Pos(0, -7)])
        self.assertFalse(region.latest.fast_mixed)

    def test_locals_bound_on_some_paths(self):
        for xs in ([1, 2, 3], []):
            self.agree(last_index, xs, compiled=bool(xs))
        for a in (3, -2):
            self.agree(sign_of, a)
        self.agree(sign_of, 0, compiled=False)
        self.agree(first_above, [1.0, 5.0, 2.0], 3.0)
        self.agree(first_above, [1.0], 3.0)
        self.agree(carried, 5)
        self.agree(carried, 0)
        self.agree(largest_doubled, [1.0, 3.0, 2.0])
        self.agree(largest_doubled, [], compiled=False)
        self.agree(bumped, True, 4)
        self.agree(bumped, False, 4, compiled=False)
        region = lift_region(sign_of)
        self.assertRaises(UnboundLocalError, region, 0)
        self.assertEqual(region(5), 1)

    def test_super_calls_and_an_object_stored_before_its_last_attribute(self):
        self.agree(through_super, 4)

    def test_membership_in_lists(self):
        nodes = [Node(1), None, Node(2)]
        self.agree(members, [1, 2, 3], [0, 2, 3, 7], nodes, nodes[2])
        self.agree(members, [1.5, 2.0], [2, 3], [Node(1)], Node(1))
        self.agree(members, [], [1, 2], [], Node(3))
        self.agree(members, [1.0], [float("nan")], [], Node(3), compiled=False)

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
    test_recursion_reloads_from_the_disk_cache = None
    test_regions_built_ahead_of_time_run_without_numba = None


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
