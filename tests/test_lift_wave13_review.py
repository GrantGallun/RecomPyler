import unittest
import numpy as np
from recompyler.lift import lift, Unsupported


def changing_source(n, rounds):
    s = list(range(n))
    t = list(range(n))
    total = 0
    for k in range(rounds):
        s[0] = k
        t = s[:]
        total += t[0]
    return total


def self_copy(n):
    a = list(range(n))
    for k in range(4):
        a[0] = k
        a = a[:]
    return a[0]


def aliased_copy(n):
    a = list(range(n))
    b = a
    a = b[:]
    a[0] = 99
    return b[0]


def overlapping_copy(n):
    a = list(range(n))
    a[1:] = a[:-1]
    return a


def enumerated(n):
    a = list(range(n))
    result = 0
    for i, v in enumerate(a):
        a = [9] * n
        result += v
    return result


def zipped(n):
    a = list(range(n))
    result = 0
    for x, y in zip(a, range(n)):
        a = [9] * n
        result += x + y
    return result


def comprehension(n):
    a = list(range(n))
    b = [x + 1 for x in a]
    a = [9] * n
    return b


def try_init(n):
    source = list(range(n))
    try:
        target = source[:]
    except ValueError:
        target = [0] * n
    return target[0]


def continue_init(n):
    source = list(range(n))
    total = 0
    for k in range(4):
        if k == 0:
            continue
        target = source[:]
        total += target[0]
    return total


def replay(values, n):
    source = list(range(n))
    target = list(range(n))
    total = 0
    for k in range(3):
        values[0] += 1
        source[0] = k
        target = source[:]
        total += target[0]
    return total + 2**62 * values[0]


def kind_change(n):
    source = list(range(n))
    target = list(range(n))
    total = 0.0
    for k in range(3):
        source[0] = k + 0.5
        target = source[:]
        total += target[0]
    return total


def nested(n):
    a = list(range(n))
    def inner():
        return a[0]
    a = a[:]
    return inner()


def lambda_capture(n):
    a = list(range(n))
    fn = lambda: a[0]
    a = a[:]
    return fn()


def read_index(values, index):
    return values[index]


def write_index(values, index):
    values[index] = 19
    return values[0]


class ReviewBehaviourTests(unittest.TestCase):
    def test_reuse_reads_current_source(self):
        compiled = lift(changing_source)
        for n in (1, 7):
            for r in (0, 1, 8):
                self.assertEqual(compiled(n, r), changing_source(n, r))
        self.assertGreater(compiled.compiled_calls, 0)
        self.assertIn('_rc_copy_into', compiled.source)

    def test_copy_alias_and_iterator_behaviour(self):
        for fn in (self_copy, aliased_copy, overlapping_copy, enumerated, comprehension, continue_init, kind_change):
            with self.subTest(fn=fn.__name__):
                compiled = lift(fn)
                for n in (1, 5):
                    self.assertEqual(compiled(n), fn(n))
                if fn in (aliased_copy, enumerated, zipped, comprehension, continue_init):
                    self.assertNotIn('_rc_copy_into', compiled.source)

    def test_try_and_nested_functions_decline(self):
        for fn in (try_init, nested, lambda_capture, zipped):
            with self.subTest(fn=fn.__name__):
                with self.assertRaises(Unsupported):
                    lift(fn)
                self.assertEqual(fn(4), 12 if fn is zipped else 0)

    def test_native_failure_replays_original_input_once(self):
        compiled = lift(replay)
        actual, expected = [1], [1]
        self.assertEqual(compiled(actual, 4), replay(expected, 4))
        self.assertEqual(actual, expected)
        self.assertGreater(compiled.fallback_calls, 0)

    def test_signed_and_large_index_getitem_setitem(self):
        for fn in (read_index, write_index):
            compiled = lift(fn)
            for i in (-5, -4, -1, 0, 3, 4, 2**63-1, 2**63, 2**64-1, np.uint64(2**63)):
                with self.subTest(fn=fn.__name__, index=i):
                    actual, expected = [1, 2, 3, 4], [1, 2, 3, 4]
                    try:
                        result = fn(expected, i)
                    except IndexError:
                        with self.assertRaises(IndexError):
                            compiled(actual, i)
                    else:
                        self.assertEqual(compiled(actual, i), result)
                    self.assertEqual(actual, expected)
            self.assertGreater(compiled.compiled_calls, 0)

