import importlib.util
from pathlib import Path
import random
import sys
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from recompyler import lift as lifting  # noqa: E402
from recompyler.lift import lift, same  # noqa: E402

OFFSETS = (0.5, -0.25, 2.0)


def particle(position, velocity, dt):
    for _ in range(64):
        velocity += (-9.81 - 0.04 * velocity) * dt
        position += velocity * dt
        if position < 0.0:
            position = -position
            velocity *= -0.7
    return position


def grow(n):
    x = 1
    for _ in range(n):
        x *= 3
    return x


def ratio(a, b):
    return a / b


def offset(x, index):
    return x + OFFSETS[index]


def weighted(pair, scale):
    return (pair[0] * 3 + pair[1]) * scale


def float_remainder(a, b):
    return a % b


def tally(n):
    counts = [0] * 4
    for i in range(n):
        counts[i & 3] += i
    return counts[1] - counts[2]


def python_loop(function, calls):
    results = []
    for args in calls:
        try:
            results.append(function(*args))
        except Exception as exc:
            results.append(type(exc))
    return results


@unittest.skipUnless(importlib.util.find_spec("numba"), "numba is not installed")
class BackendTests(unittest.TestCase):
    def test_every_backend_matches_a_python_loop(self):
        rng = random.Random(11)
        cases = (
            (particle, [(rng.uniform(0, 4), rng.uniform(-4, 4), rng.uniform(0.01, 0.02)) for _ in range(700)]),
            (grow, [(n,) for n in range(70)]),
            (offset, [(float(i), i % 6 - 3) for i in range(40)]),
            (weighted, [((i, i + 1), 0.5) for i in range(40)] + [((2**61, 5), 2.0)]),
            (float_remainder, [(float(i) - 7.5, 2.5) for i in range(40)] + [(1.0, float("inf")), (-1.0, float("inf"))]),
            (tally, [(n,) for n in range(40)]),
        )
        for function, calls in cases:
            expected = python_loop(function, calls)
            for backend in lifting.BACKENDS:
                lifted = lift(function)
                self.assertTrue(same(lifted.map(calls, backend), expected), (function.__name__, backend))
                self.assertGreater(lifted.compiled_calls, 0, (function.__name__, backend))

    def test_backends_raise_like_a_python_loop(self):
        for backend in lifting.BACKENDS:
            with self.assertRaises(ZeroDivisionError):
                lift(ratio).map([(1, 2), (1, 0), (3, 4)], backend)
            with self.assertRaises(IndexError):
                lift(offset).map([(1.0, 0), (1.0, 3)], backend)
        with self.assertRaises(ValueError):
            lift(ratio).map([(1, 2)], "quantum")

    def test_gpu_runs_exactly_or_explains_why_not(self):
        rng = random.Random(5)
        calls = [(rng.uniform(0, 4), rng.uniform(-4, 4), rng.uniform(0.01, 0.02)) for _ in range(300)]
        lifted = lift(particle)
        self.assertTrue(same(lifted.map(calls, "gpu"), python_loop(particle, calls)))
        trusted = [value for key, value in lifted._drivers.items() if key[1] == "gpu-trusted"]
        if lifting._gpu_ready():
            # Multiply-add fusion is off, so the GPU reproduces the CPU bit for bit.
            self.assertEqual((trusted, lifted.gpu_note), ([True], None))
        else:
            self.assertEqual(trusted, [False])
            self.assertIn("GPU", lifted.gpu_note)

    def test_gpu_declines_what_it_cannot_reproduce(self):
        for function, calls in ((tally, [(n,) for n in range(20)]), (float_remainder, [(7.5, 2.0), (-7.5, 2.0)])):
            lifted = lift(function)
            self.assertTrue(same(lifted.map(calls, "gpu"), python_loop(function, calls)))
            self.assertIn("GPU", lifted.gpu_note)
        # A declined or failed GPU attempt must leave CPU compilation working.
        self.assertEqual(lift(grow).map([(3,), (4,)]), [27, 81])

    def test_auto_measures_once_per_size_and_matches(self):
        rng = random.Random(9)
        calls = [(rng.uniform(0, 4), rng.uniform(-4, 4), rng.uniform(0.01, 0.02)) for _ in range(600)]
        expected = python_loop(particle, calls)
        lifted = lift(particle)
        self.assertTrue(same(lifted.map(calls[:20], "auto"), expected[:20]))
        self.assertEqual(lifted.choices, {})
        self.assertTrue(same(lifted.map(calls, "auto"), expected))
        (choice,) = lifted.choices.values()
        self.assertIn(choice["backend"], choice["seconds"])
        self.assertEqual(choice["backend"], min(choice["seconds"], key=choice["seconds"].get))
        self.assertLessEqual({"cpu", "parallel"}, set(choice["seconds"]))
        self.assertTrue(same(lifted.map(calls[:590], "auto"), expected[:590]))
        self.assertEqual(len(lifted.choices), 1)
        self.assertTrue(same(lift(tally).map([(n,) for n in range(300)], "auto"),
                             python_loop(tally, [(n,) for n in range(300)])))

    def test_arrays_in_arrays_out(self):
        import numpy as np

        rng = np.random.default_rng(3)
        rows = rng.uniform([0, -4, 0.01], [4, 4, 0.02], size=(500, 3))
        expected = [particle(*row) for row in rows.tolist()]
        for backend in lifting.BACKENDS:
            result = lift(particle).map(rows, backend)
            self.assertEqual((type(result), result.dtype), (np.ndarray, np.float64))
            self.assertTrue(same(result.tolist(), expected), backend)

    def test_array_results_stay_exact_when_python_takes_over(self):
        import numpy as np

        small = lift(grow).map(np.arange(30, dtype=np.int64).reshape(-1, 1))
        self.assertEqual(small.dtype, np.int64)
        self.assertEqual(small.tolist(), [3**n for n in range(30)])
        large = lift(grow).map(np.arange(70, dtype=np.int64).reshape(-1, 1))
        self.assertEqual(large.dtype, object)
        self.assertTrue(same(large.tolist(), [3**n for n in range(70)]))
        with self.assertRaises(ZeroDivisionError):
            lift(ratio).map(np.array([[1, 2], [1, 0]], dtype=np.int64))
        narrow = lift(ratio).map(np.array([[1, 2], [3, 4]], dtype=np.float32))
        self.assertTrue(same(narrow.tolist(), [0.5, 0.75]))


if __name__ == "__main__":
    unittest.main()
