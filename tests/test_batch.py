import ast
import json
from pathlib import Path
import sys
import tempfile
import textwrap
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from recompyler.batch import READY, RUN, Sites, choose, plan_ratios  # noqa: E402
from recompyler.runner import run_script  # noqa: E402


def rewrite(source, names=("f",)):
    sites = Sites(names)
    tree = sites.visit(ast.parse(textwrap.dedent(source)))
    return ast.unparse(ast.fix_missing_locations(tree)), sites.found


def evaluate(source, ready, names=("f",)):
    """Run rewritten ``source`` with a fake batch runtime; returns its namespace and the batches seen."""
    code, _ = rewrite(source, names)
    seen = []

    def run(fn, rows):
        seen.append(len(rows))
        return [fn(*row) for row in rows]

    scope = {READY: lambda fn, consumer=None: ready, RUN: run}
    exec(code, scope)
    return scope, seen


class SiteTests(unittest.TestCase):
    SOURCE = """
        def f(x, y):
            return x * 2.0 + y
        k = 0.5
        xs = [1.0, 2.0, 3.0, 4.0]
        a = [f(x, k) for x in xs if x > 1.0]
        b = sum(f(x, i) for i, x in enumerate(xs))
        c = list(map(f, xs, [1.0, 2.0]))
        d = max(f(x, y) for x in xs for y in xs)
    """

    def test_sites_found(self):
        _, found = rewrite(self.SOURCE)
        self.assertEqual(len(found), 4)

    def test_same_results_batched_or_not(self):
        plain, _ = evaluate(self.SOURCE, ready=False)
        batched, seen = evaluate(self.SOURCE, ready=True)
        for name in "abcd":
            self.assertEqual(plain[name], batched[name], name)
        self.assertEqual(seen, [3, 4, 2, 16])

    def test_lazy_and_unusual_sites_left_alone(self):
        for source in ("any(f(x, 1) for x in xs)",
                       "[f(x, y=1) for x in xs]",
                       "[f(*x) for x in xs]",
                       "[g(x, 1) for x in xs]",
                       "[f(x, 1) + 1 for x in xs]",
                       "sum((f(x, 1) for x in xs), 0.0)",
                       "for x in xs:\n    f(x, 1)"):
            _, found = rewrite(source)
            self.assertEqual(found, [], source)

    def test_original_kept_when_not_ready(self):
        code, _ = rewrite("a = [f(x, 1) for x in xs]")
        self.assertIn("[f(x, 1) for x in xs]", code)
        self.assertIn(READY, code)


class ChooseTests(unittest.TestCase):
    def test_respects_minimum_sizes(self):
        ratios = {"cpu": 5.0, "parallel": 30.0, "gpu": 40.0}
        self.assertEqual(choose(ratios, 100), "cpu")
        self.assertEqual(choose(ratios, 500), "parallel")
        self.assertEqual(choose(ratios, 5000), "gpu")

    def test_plan_ratios_needs_a_real_speedup(self):
        data = {"functions": [
            {"function": "f", "line": 1, "candidate": {"status": "verified", "batch_backends": {"cpu": 3.0}}},
            {"function": "g", "line": 5, "candidate": {"status": "verified", "batch_backends": {"cpu": 1.01}}},
            {"function": "h", "line": 9, "candidate": {"status": "rejected", "batch_backends": {"cpu": 9.0}}}]}
        self.assertEqual(set(plan_ratios(data)), {("f", 1)})


SCRIPT = '''
from concurrent.futures import ThreadPoolExecutor
from multiprocessing.pool import ThreadPool
import json, sys


def step(x, v):
    for _ in range(32):
        v += (-9.81 - 0.04 * v) * 0.01
        x += v * 0.01
        if x < 0.0:
            x, v = -x, v * -0.7
    return x


def inverse(x):
    return 1.0 / x


n = 3000
xs = [i / n for i in range(n)]
out = {"comp": [step(x, 0.5) for x in xs],
       "sum": sum(step(x, -0.25) for x in xs),
       "map": list(map(step, xs, xs))}
with ThreadPool(2) as pool:
    out["pool"] = pool.starmap(step, [(x, 0.1) for x in xs])
with ThreadPoolExecutor(2) as executor:
    out["executor"] = list(executor.map(step, xs, [0.2] * n))
try:
    [inverse(x) for x in xs]
except ZeroDivisionError as exc:
    out["error"] = type(exc).__name__
json.dump(out, open(sys.argv[1], "w"))
'''


class RunTests(unittest.TestCase):
    def test_run_matches_python_and_batches(self):
        with tempfile.TemporaryDirectory() as folder:
            folder = Path(folder)
            script = folder / "script.py"
            script.write_text(SCRIPT, encoding="utf-8")
            lines = {name: SCRIPT.splitlines().index(f"def {name}({args}):") + 1
                     for name, args in (("step", "x, v"), ("inverse", "x"))}
            plan = folder / "plan.json"
            ratios = {"cpu": 5.0, "parallel": 20.0}
            plan.write_text(json.dumps({"plan": {"worth_running": False, "startup_s": 0.5, "saving_s": 0.0},
                                        "functions": [{"function": name, "line": line, "calls": 100_000,
                                                       "candidate": {"status": "verified", "batch_backends": ratios,
                                                                     "python_us_per_call": 5.0}}
                                                      for name, line in lines.items()]}), encoding="utf-8")
            import runpy

            saved = sys.argv
            try:
                sys.argv = [str(script), str(folder / "python.json")]
                runpy.run_path(str(script), run_name="__main__")
            finally:
                sys.argv = saved
            report = run_script(script, [str(folder / "batched.json")], plan)
            expected = json.loads((folder / "python.json").read_text())
            got = json.loads((folder / "batched.json").read_text())
        self.assertEqual(got, expected)
        self.assertEqual(expected["error"], "ZeroDivisionError")
        stats = report["batches"]
        self.assertEqual(stats["step"]["batches"], 5)
        self.assertEqual(stats["step"]["fallback"], 0)
        self.assertIn("parallel", stats["step"]["backends"])
        # The row with x == 0 fell back to Python, which raised the same error (checked above).
        self.assertEqual(stats["inverse"]["batches"], 1)


class GpuTrustTests(unittest.TestCase):
    def test_gpu_stays_in_use_after_first_batch(self):
        from recompyler.lift import _gpu_ready, lift

        try:
            available = _gpu_ready()
        except Exception:
            available = False
        if not available:
            self.skipTest("CUDA is unavailable")

        def glide(x, v):
            for _ in range(16):
                v += -0.5 * v * 0.01
                x += v * 0.01
            return x

        lifted = lift(glide)
        rows = [(i / 2048, 0.5) for i in range(2048)]
        expected = [glide(*row) for row in rows]
        for _ in range(3):
            self.assertEqual(lifted.map(rows, "gpu"), expected)
        self.assertIsNone(lifted.gpu_note)
        self.assertFalse(lifted._gpu_blocked())


if __name__ == "__main__":
    unittest.main()
