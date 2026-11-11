import os
from pathlib import Path
import runpy
import sys
import tempfile
import textwrap
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from recompyler.monitor import CallMonitor, _accelerator  # noqa: E402
from recompyler.profiler import snapshot  # noqa: E402

SCRIPT = textwrap.dedent("""
    import cProfile, json, sys, threading

    def busy(n):
        total = 0.0
        for i in range(n):
            total += i * 0.5
        return total

    def uses_json(n):
        return len(json.loads(json.dumps(list(range(n)))))

    def fib(n):
        return n if n < 2 else fib(n - 1) + fib(n - 2)

    def counter(n):
        for i in range(n):
            yield busy(100)

    def key(x):
        return -x

    def boom():
        raise ValueError

    def catcher():
        for _ in range(10):
            try:
                boom()
            except ValueError:
                pass

    def shape(x):
        return x * 2

    def worker():
        busy(1000)

    def main():
        busy(20000)
        uses_json(20000)
        fib(12)
        sum(counter(5))
        sorted(range(100), key=key)
        catcher()
        for _ in range(300):
            shape(3)
        shape(2.5)
        thread = threading.Thread(target=worker)
        thread.start()
        thread.join()
        # The script's own profiler must still work under the monitor.
        cProfile.Profile().runcall(busy, 10)

    main()
""")


class MonitorTest(unittest.TestCase):
    backend = "python"

    @classmethod
    def setUpClass(cls):
        cls.folder = tempfile.TemporaryDirectory()
        cls.script = os.path.join(cls.folder.name, "target.py")
        Path(cls.script).write_text(SCRIPT, encoding="utf-8")

        def trace(*_):
            return None

        before = sys.gettrace()
        sys.settrace(trace)
        try:
            cls.monitor = CallMonitor([cls.script], 8, snapshot, backend=cls.backend)
            with cls.monitor:
                runpy.run_path(cls.script, run_name="__main__")
            cls.trace_kept = sys.gettrace() is trace
        finally:
            sys.settrace(before)
        cls.rows = {row["function"]: row for row in cls.monitor.rows()}

    @classmethod
    def tearDownClass(cls):
        cls.folder.cleanup()

    def sampler(self, name):
        return next(s for key, s in self.monitor.samplers.items() if key[1] == name)

    def test_leaves_settrace_alone(self):
        self.assertTrue(self.trace_kept)

    def test_counts_calls_once_per_call(self):
        self.assertEqual(self.rows["fib"]["calls"], 465)
        # A generator is one call however often it resumes.
        self.assertEqual(self.rows["counter"]["calls"], 1)
        self.assertEqual(self.rows["key"]["calls"], 100)
        self.assertEqual(self.rows["boom"]["calls"], 10)
        self.assertEqual(self.rows["busy"]["calls"], 1 + 5 + 1 + 1)

    def test_sees_other_threads(self):
        self.assertEqual(self.rows["worker"]["calls"], 1)
        self.assertGreater(self.rows["worker"]["cumulative_s"], 0)

    def test_recursion_counts_outermost_call_once(self):
        fib = self.rows["fib"]
        self.assertAlmostEqual(fib["cumulative_s"], fib["self_s"], delta=fib["self_s"] * 0.05 + 1e-6)

    def test_library_time_is_kept_apart(self):
        uses_json = self.rows["uses_json"]
        self.assertGreater(uses_json["library_s"], 5 * uses_json["self_s"])
        self.assertAlmostEqual(uses_json["cumulative_s"], uses_json["self_s"] + uses_json["library_s"],
                               delta=uses_json["cumulative_s"] * 0.01)

    def test_callbacks_from_library_code_are_children(self):
        main = self.rows["main"]
        children = sum(row["cumulative_s"] for name, row in self.rows.items()
                       if name in ("busy", "uses_json", "fib", "counter", "catcher", "shape"))
        self.assertLess(main["self_s"], main["cumulative_s"] - children + 1e-3)
        self.assertGreater(main["cumulative_s"], children)

    def test_stack_survives_exceptions(self):
        # Had an unwind been missed, catcher would absorb every later call's time.
        self.assertLess(self.rows["catcher"]["cumulative_s"], self.rows["main"]["cumulative_s"] / 2)

    def test_uniform_sample_and_rare_signatures(self):
        shape = self.sampler("shape")
        self.assertEqual(shape.seen, 301)
        self.assertEqual(len(shape.samples), 8)
        self.assertEqual(shape.signatures, {(int,): 300, (float,): 1})
        extra = shape.extra()
        if not any(type(arguments[0]) is float for arguments, *_ in shape.samples):
            self.assertEqual([(arguments, result) for arguments, result, _ in extra], [((2.5,), 5.0)])

    def test_reasons_for_functions_not_captured(self):
        reasons = {key[1]: reason for key, reason in self.monitor.skipped.items()}
        self.assertEqual(reasons["counter"], "is a generator")
        self.assertIn("<module>", reasons)

    def test_failed_calls_are_not_sampled(self):
        self.assertEqual(self.sampler("boom").samples, [])

    def test_watches_folders(self):
        monitor = CallMonitor([self.folder.name])
        self.assertTrue(monitor.watches(self.script))
        self.assertFalse(monitor.watches(os.__file__))


@unittest.skipIf(_accelerator is None, "the C extension is not built")
class CMonitorTest(MonitorTest):
    backend = "c"


LIBRARY = textwrap.dedent("""
    def spin(n):
        total = 0
        for i in range(n):
            total += i
        return total

    spin(300000)  # work done at import time

    class Money:
        def __init__(self, value):
            self.value = value

        def __add__(self, other):
            spin(2000)
            return Money(self.value + other.value)

    def numbers(n):
        for i in range(n):
            spin(2000)
            yield i
""")

IMPLICIT = textwrap.dedent("""
    def importer():
        import slowlib
        return slowlib

    def adder(slowlib):
        total = slowlib.Money(0)
        for _ in range(100):
            total = total + slowlib.Money(1)
        return total.value

    def iterator(slowlib):
        return sum(item for item in slowlib.numbers(100))

    def looper(slowlib):
        count = 0
        for _ in slowlib.numbers(100):
            count += 1
        return count

    lib = importer()
    adder(lib)
    iterator(lib)
    looper(lib)
""")


class ImplicitLibraryTest(unittest.TestCase):
    """Library code entered without a CALL event is library time, not self time."""
    backend = "python"

    @classmethod
    def setUpClass(cls):
        cls.folder = tempfile.TemporaryDirectory()
        script = os.path.join(cls.folder.name, "implicit.py")
        Path(cls.folder.name, f"slowlib_{cls.backend}.py").write_text(LIBRARY, encoding="utf-8")
        Path(script).write_text(IMPLICIT.replace("slowlib", f"slowlib_{cls.backend}"), encoding="utf-8")
        sys.path.insert(0, cls.folder.name)
        try:
            cls.monitor = CallMonitor([script], backend=cls.backend)
            with cls.monitor:
                runpy.run_path(script, run_name="__main__")
        finally:
            sys.path.remove(cls.folder.name)
            sys.modules.pop(f"slowlib_{cls.backend}", None)
        cls.rows = {row["function"]: row for row in cls.monitor.rows()}

    @classmethod
    def tearDownClass(cls):
        cls.folder.cleanup()

    def assert_library(self, name):
        row = self.rows[name]
        self.assertGreater(row["library_s"], 5 * row["self_s"], row)

    def test_import(self):
        self.assert_library("importer")
        self.assertLess(self.rows["<module>"]["self_s"], self.rows["<module>"]["cumulative_s"] / 5)

    def test_operator_hook(self):
        self.assert_library("adder")

    def test_library_generator(self):
        self.assert_library("looper")

    def test_library_generator_in_a_genexpr(self):
        self.assert_library("<genexpr>")


@unittest.skipIf(_accelerator is None, "the C extension is not built")
class CImplicitLibraryTest(ImplicitLibraryTest):
    backend = "c"


if __name__ == "__main__":
    unittest.main()
