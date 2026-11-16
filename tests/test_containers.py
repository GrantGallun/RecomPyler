"""Strings, dicts, sets and calling conventions in heap regions."""
import copy
import os
from pathlib import Path
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

GREETING = "hello"
SIZES = (3, 5)
COUNTS = {"a": 1}


class Item:
    def __init__(self, name, weight):
        self.name = name
        self.weight = weight


class Base:
    def __init__(self, x):
        self.x = x

    def value(self):
        return self.x * 2


class Child(Base):
    def __init__(self, x, y):
        super().__init__(x)
        self.y = y

    def value(self):
        return super().value() + self.y


def word_lengths(words):
    out = {}
    for word in words:
        out[word] = len(word)
    return out


def count_words(words):
    counts = {}
    for word in words:
        counts[word] = counts.get(word, 0) + 1
    return counts


def tally(counts, words):
    for word in words:
        if word in counts:
            counts[word] += 1
        else:
            counts[word] = 1
    total = 0
    for key, value in counts.items():
        total += value * len(key)
    return total


def strings(a, b):
    c = a + b
    d = c[1:4]
    e = c[-1]
    out = []
    if a == "ab":
        out.append(1)
    if a < b:
        out.append(2)
    if "b" in c:
        out.append(3)
    if not d:
        out.append(4)
    return c, d, e, len(c), out, c.startswith(a), c.endswith("z"), c.find(b)


def fmt(n, name):
    return f"{name}={n};" + str(n * 2) + str(n > 3) + GREETING


def join_up(words):
    return ", ".join(words) + "!"


def chars(text):
    total = 0
    for ch in text:
        total += ord(ch)
    return total, chr(65 + len(text))


def pairs(n):
    seen = {}
    for i in range(n):
        for j in range(n):
            seen[(i % 3, j % 2)] = seen.get((i % 3, j % 2), 0) + i * j
    del seen[(0, 0)]
    keys = []
    for key in seen:
        keys.append(key[0] * 10 + key[1])
    return keys, len(seen), seen.pop((1, 1)), seen.pop((9, 9), -1)


def by_object(items):
    weights = {}
    for item in items:
        weights[item] = item.weight
    names = {}
    for item, weight in weights.items():
        names[item.name] = weight + names.setdefault(item.name, 0)
    return names


def grow_dict(d, n):
    for i in range(n):
        d[i] = i * i
    for i in range(0, n, 3):
        del d[i]
    return sum_values(d)


def sum_values(d):
    total = 0
    for value in d.values():
        total += value
    return total


def mutate_during_loop(d):
    for key in d:
        d[key + 100] = 1
    return len(d)


def sets(values):
    s = set()
    for v in values:
        s.add(v % 7)
    s.discard(3)
    s.discard(100)
    t = {1, 2, 3}
    t.add(9)
    return s, t, len(s), 4 in s, (5 not in t)


def set_member(s, values):
    hits = 0
    for v in values:
        if v in s:
            hits += 1
        else:
            s.add(v)
    return hits


def empty_contains(container, key, effects):
    effects.append(1)
    return key in container


def empty_not_contains(container, key, effects):
    effects.append(1)
    return key not in container


def scale(x, factor=2, *, offset=0.5, label="x"):
    return x * factor + offset, label


def keywords(n):
    a = scale(n)
    b = scale(n, 3)
    c = scale(n, offset=1.5)
    d = scale(factor=4, x=n, label="y")
    return a, b, c, d


def total(*values):
    out = 0
    for v in values:
        out += v
    return out


def starred(n):
    return total(n, 1, 2) + total() + total(n)


def maybe_name(flag):
    name = None
    if flag:
        name = "set"
    if name is None:
        return "none"
    return name


def nested_call(x):
    return inner(x, label="in")


def inner(x, label=None):
    if label is None:
        return 0
    return len(label) + x


def supers(n):
    out = 0
    for i in range(n):
        c = Child(i, 1)
        out += c.value()
    return out


def make_items(n):
    out = []
    for i in range(n):
        out.append(Item("item" + str(i % 3), i))
    return out


def counts_global(word):
    return COUNTS.get(word, 0) + SIZES[1]


def closure_maker(k):
    def scaled(x):
        return x * k + len(GREETING)
    return scaled


def unicode_bits(text):
    return len(text), text[1], text[-2:], str(-9223372036854775807 - 1), str(0), "😀" in text


def reinsert(d):
    del d["a"]
    d["a"] = 9
    d["b"] = d["b"] + 1
    for key in d:
        d[key] = len(key)
    return list_keys(d)


def list_keys(d):
    out = []
    for key, value in d.items():
        out.append(key + str(value))
    return out


def set_order(s):
    out = []
    for item in s:
        out.append(item)
    return out


def made_set_order(values):
    s = set()
    for v in values:
        s.add(v)
    return set_order(s)


def constant_set():
    s = {24, 8, 16, 0, 40}
    s.discard(16)
    s.add(56)
    return s


def rename(items, suffix):
    for item in items:
        item.name = item.name + suffix
    return len(items)


def only_keywords(a, *, b, c=2):
    return a + b * c


def text_methods(text):
    words = text.split()
    parts = text.split(",")
    return (words, parts, text.strip(), text.lstrip(), text.rstrip(), text.upper(), text.lower(),
            text.count("a"), text.replace("a", "<>"), "-" * 3 + text * 2, len(words))


class ContainerTests(unittest.TestCase):

    def agree(self, function, *args, compiled=True, **kwargs):
        region = function if hasattr(function, "original") else lift_region(function)
        mine, theirs = copy.deepcopy(args), copy.deepcopy(args)
        try:
            expected = region.original(*theirs, **kwargs)
        except Exception as exc:
            self.assertRaises(type(exc), region, *mine, **kwargs)
            self.assertTrue(same(list(mine), list(theirs)))
            return region
        got = region(*mine, **kwargs)
        self.assertTrue(same(got, expected), (got, expected, region.problem, region.gave_up))
        self.assertTrue(same(list(mine), list(theirs)), ("arguments differ after the call", mine, theirs))
        if compiled:
            self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))
        return region

    def test_dict_of_strings(self):
        self.agree(word_lengths, ["a", "bb", "a", "ccc", ""], compiled=False)
        self.agree(count_words, ["x", "y", "x", "z", "x"], compiled=False)
        self.agree(count_words, [], compiled=False)

    def test_dict_passed_in_is_changed(self):
        self.agree(tally, {"a": 2, "q": 5}, ["a", "b", "a", "c"], compiled=False)
        self.agree(tally, {}, ["a"], compiled=False)

    def test_strings(self):
        self.agree(strings, "ab", "cd", compiled=False)
        self.agree(strings, "zz", "b", compiled=False)
        self.agree(strings, "", "x", compiled=False)
        self.agree(fmt, 5, "n", compiled=False)
        self.agree(fmt, -12, "", compiled=False)
        self.agree(join_up, ["a", "b", "c"], compiled=False)
        self.agree(join_up, [], compiled=False)
        self.agree(chars, "héllo", compiled=False)

    def test_tuple_keys_and_deletion(self):
        self.agree(pairs, 5)
        self.agree(pairs, 1, compiled=False)

    def test_objects_as_keys(self):
        self.agree(by_object, [Item("a", 1), Item("b", 2), Item("a", 3)], compiled=False)

    def test_dict_growth_and_order(self):
        self.agree(grow_dict, {-1: 5}, 40)
        self.agree(grow_dict, {}, 0)

    def test_changed_during_iteration_is_python(self):
        region = lift_region(mutate_during_loop)
        self.assertRaises(RuntimeError, region, {1: 1, 2: 2})

    def test_sets(self):
        self.agree(sets, [1, 2, 3, 10, 17, 24])
        self.agree(set_member, {1, 5, 9}, [1, 2, 2, 5, 33])

    def test_empty_membership_rejects_unhashable_keys_once(self):
        for function in (empty_contains, empty_not_contains):
            for container in ({}, set()):
                for key in ([], ([1],)):
                    with self.subTest(function=function.__name__, container=type(container), key=key):
                        region = lift_region(function)
                        effects = []
                        with self.assertRaises(TypeError):
                            region(container, key, effects)
                        self.assertEqual(effects, [1])
                        self.assertEqual(region.compiled_calls, 0)
                        self.assertEqual(region.fallback_calls, 1)

    def test_empty_membership_of_supported_keys_compiles(self):
        self.agree(empty_contains, {}, 5, [])
        self.agree(empty_not_contains, {}, "absent", [])
        self.agree(empty_contains, set(), (3, "absent"), [], compiled=False)
        self.agree(empty_not_contains, set(), 5, [])

    def test_keyword_and_default_arguments(self):
        self.agree(keywords, 3, compiled=False)
        self.agree(keywords, 2.5, compiled=False)
        self.agree(starred, 4)
        self.agree(scale, 1.5, offset=2.0, compiled=False)
        self.agree(total, 1, 2, 3)
        self.agree(nested_call, 3, compiled=False)

    def test_none_and_str_values(self):
        self.agree(maybe_name, True, compiled=False)
        self.agree(maybe_name, False, compiled=False)

    def test_super(self):
        self.agree(supers, 6)

    def test_made_objects_with_strings(self):
        region = self.agree(make_items, 5, compiled=False)
        self.assertEqual([item.name for item in region(4)], ["item0", "item1", "item2", "item0"])

    def test_str_methods(self):
        self.agree(text_methods, "  a,b  c,,aa 	", compiled=False)
        self.agree(text_methods, "", compiled=False)
        self.agree(text_methods, "x y", compiled=False)

    def test_unicode_and_extremes(self):
        self.agree(unicode_bits, "a😀bc", compiled=False)
        self.agree(unicode_bits, "xé😀", compiled=False)

    def test_dict_order_after_changes(self):
        self.agree(reinsert, {"a": 1, "b": 2, "c": 3}, compiled=False)

    def test_set_order_is_python_order(self):
        region = self.agree(set_order, {24, 8, 16, 0, 40, 3})
        region = self.agree(made_set_order, [24, 8, 16, 0], compiled=False)
        self.assertEqual(region([5, 13, 21]), made_set_order([5, 13, 21]))
        region = self.agree(constant_set)
        self.assertEqual(list(region()), list(constant_set()))

    def test_str_attributes_written_back(self):
        self.agree(rename, [Item("a", 1), Item("b", 2)], "!", compiled=False)

    def test_keyword_only_entry(self):
        self.agree(only_keywords, 1, b=3)
        self.agree(only_keywords, 1, b=3, c=5)

    def test_globals_and_closures(self):
        self.agree(counts_global, "a", compiled=False)
        self.agree(counts_global, "b", compiled=False)
        self.agree(closure_maker(3), 4, compiled=False)


@unittest.skipIf(heap._native is None, "the C loader is not built")
class PythonLoaderContainerTests(ContainerTests):
    def setUp(self):
        heap.NATIVE = False

    def tearDown(self):
        heap.NATIVE = True


if __name__ == "__main__":
    unittest.main()
