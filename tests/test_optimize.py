from pathlib import Path
import sys
import unittest
from unittest.mock import patch


sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from recompyler import optimize


def squared(x):
    return x * x


class Candidate:
    def __init__(self, function):
        self.function = function
        self.calls = []
        self.compiled_calls = 0

    def __call__(self, *args):
        self.calls.append(args)
        self.compiled_calls += 1
        return self.function(*args)

    def map(self, rows):
        return [self(*row) for row in rows]


class OptimizeTests(unittest.TestCase):
    def build(self, native, samples, speed=2.0):
        with patch("recompyler._optimize.lift", return_value=native), patch(
            "recompyler._optimize._speedup", return_value=speed
        ):
            return optimize(squared, samples=samples)

    def test_uses_verified_values_and_preserves_normal_calls(self):
        native = Candidate(squared)
        fast = self.build(native, [(2,), (3,)])
        self.assertEqual(fast.report["call"]["status"], "active")
        self.assertEqual(fast.report["batch"]["status"], "active")
        native.calls.clear()
        self.assertEqual(fast(3), 9)
        self.assertEqual(fast(4), 16)
        self.assertEqual(fast(x=2), 4)
        self.assertEqual(fast(2.0), 4.0)
        self.assertEqual(fast.map([(2,), (3,)]), [4, 9])
        self.assertEqual(fast.map([(2,), (4,)]), [4, 16])
        self.assertEqual(fast.map([(3,), (2,)]), [9, 4])
        self.assertEqual(fast.map([(2,)]), [4])
        self.assertEqual(native.calls, [(3,), (2,), (3,)])

    def test_mismatches_and_slow_candidates_fall_back(self):
        bad = Candidate(lambda x: 7)
        self.assertEqual(self.build(bad, [(2,)]).report["call"]["status"], "rejected")
        slow = Candidate(squared)
        result = self.build(slow, [(2,)], speed=0.9)
        self.assertEqual(result.report["call"]["status"], "slower")
        slow.calls.clear()
        self.assertEqual(result(2), 4)
        self.assertEqual(slow.calls, [])

    def test_guard_keys_preserve_float_bits(self):
        native = Candidate(squared)
        fast = self.build(native, [(-0.0,)])
        native.calls.clear()
        self.assertEqual(fast(0.0), 0.0)
        self.assertEqual(native.calls, [])

    def test_iterables_keep_python_evaluation_order(self):
        current = 0

        def with_offset(x):
            return x + current

        def rows():
            nonlocal current
            current = 3
            yield (2,)
            current = 5
            yield (2,)

        with patch("recompyler._optimize.lift", return_value=Candidate(with_offset)), patch(
            "recompyler._optimize._speedup", return_value=2.0
        ):
            fast = optimize(with_offset, samples=[(2,), (2,)])
        self.assertEqual(fast.map(rows()), [5, 7])


if __name__ == "__main__":
    unittest.main()
