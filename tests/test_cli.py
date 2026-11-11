import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

# Keep compiled code from the tests out of the user's cache.
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="recompyler-tests-"))


ROOT = Path(__file__).resolve().parents[1]


def cli(*args, cwd=ROOT):
    env = os.environ.copy()
    env["PYTHONPATH"] = os.pathsep.join(filter(None, (str(ROOT / "src"), env.get("PYTHONPATH"))))
    return subprocess.run([sys.executable, "-m", "recompyler", *map(str, args)], cwd=cwd,
                          env=env, capture_output=True, text=True, timeout=90)


class CliTests(unittest.TestCase):
    def test_compact_profile_is_one_versioned_json_line(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            script = root / "work.py"
            script.write_text("def twice(n):\n    return n + n\nprint(twice(3))\n", encoding="utf-8")
            report = root / "compact.json"
            run = cli("profile", "--format", "compact", "--json", report, "--no-compile", script, cwd=root)
            self.assertEqual(run.returncode, 0, run.stderr)
            self.assertEqual(run.stdout.strip(), "6")
            self.assertEqual(len(run.stderr.splitlines()), 1)
            data = json.loads(run.stderr)
            self.assertEqual(json.loads(report.read_text()), data)
            self.assertEqual(data["schema"], "recompyler.profile.v1")
            self.assertEqual(data["script"], "work.py")
            row = next(row for row in data["hotspots"] if row["function"] == "twice")
            self.assertEqual((row["line"], row["calls"], row["status"]), (1, 1, "skipped"))

    def test_report_cannot_overwrite_the_script(self):
        with tempfile.TemporaryDirectory() as tmp:
            script = Path(tmp) / "work.py"
            source = "print('should not run')\n"
            script.write_text(source, encoding="utf-8")
            run = cli("profile", "--json", script, "--no-compile", script)
            self.assertEqual(run.returncode, 2)
            self.assertEqual(run.stdout, "")
            self.assertEqual(script.read_text(), source)

    def test_profile_normal_script_runs_once_and_forwards_arguments(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            scripts = root / "scripts with spaces"
            scripts.mkdir()
            script = scripts / "work.py"
            script.write_text(
                "from pathlib import Path\nimport sys\nfrom local_helper import offset\n"
                "def slow(x):\n    for i in range(200):\n        x += i\n    return x\n"
                "with Path('calls.txt').open('a') as file:\n    file.write(sys.argv[1] + '\\n')\n"
                "print(sum(slow(i + offset) for i in range(50)))\n"
                "raise SystemExit(0)\n", encoding="utf-8")
            (scripts / "local_helper.py").write_text("offset = 3\n", encoding="utf-8")
            report = root / "report.json"
            run = cli("profile", "--json", report, "--no-compile", script, "--", "hello world", cwd=root)
            self.assertEqual(run.returncode, 0, run.stderr)
            self.assertEqual((root / "calls.txt").read_text(), "hello world\n")
            rows = json.loads(report.read_text())["functions"]
            self.assertEqual(next(row for row in rows if row["function"] == "slow")["calls"], 50)

    @unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
    def test_profile_compiles_pure_helper_and_skips_side_effects(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            script = root / "work.py"
            script.write_text(
                "def arithmetic(x):\n    for i in range(200):\n        x += i\n    return x\n"
                "def external(x):\n    print(x)\n    return x\n"
                "for i in range(32):\n    arithmetic(i)\n    external(i)\n", encoding="utf-8")
            report = root / "report.json"
            run = cli("profile", "--json", report, script, cwd=root)
            self.assertEqual(run.returncode, 0, run.stderr)
            rows = {row["function"]: row for row in json.loads(report.read_text())["functions"]}
            self.assertEqual(rows["arithmetic"]["candidate"]["status"], "verified")
            self.assertEqual(rows["arithmetic"]["candidate"]["samples"], 32)
            self.assertEqual(rows["external"]["candidate"]["status"], "skipped")
            self.assertEqual(len(run.stdout.splitlines()), 32)

    @unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
    def test_profile_counts_calls_that_reuse_a_list(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            script = root / "work.py"
            body = "    total = 0.0\n    for i in range(len(xs)):\n        total += xs[i] * xs[i]\n    return total\n"
            script.write_text(
                f"def same_list(xs):\n{body}def new_lists(xs):\n{body}"
                "data = [i * 0.5 for i in range(2000)]\n"
                "for k in range(300):\n    same_list(data)\n    new_lists([i * 0.5 + k for i in range(2000)])\n",
                encoding="utf-8")
            report = root / "report.json"
            run = cli("profile", "--json", report, script, cwd=root)
            self.assertEqual(run.returncode, 0, run.stderr)
            rows = {row["function"]: row["candidate"] for row in json.loads(report.read_text())["functions"]}
            same, new = rows["same_list"], rows["new_lists"]
            self.assertEqual((same["status"], new["status"]), ("verified", "verified"))
            self.assertGreater(same["list_reuse"], 0.99)
            self.assertEqual(new["list_reuse"], 0.0)
            self.assertIsNone(new["compiled_reused_us_per_call"])
            self.assertLess(same["compiled_reused_us_per_call"], same["compiled_fresh_us_per_call"] / 2)
            self.assertGreater(same["speedup"], new["speedup"])

    @unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
    def test_profile_lifts_helpers_constants_and_lists(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            script = root / "work.py"
            script.write_text(
                "WEIGHTS = (0.5, 0.25, 0.125)\n"
                "def clamp(x, lo, hi):\n    return lo if x < lo else hi if x > hi else x\n"
                "def score(cards):\n    counts = [0] * 4\n    total = 0.0\n"
                "    for index, card in enumerate(cards):\n        counts[card & 3] += 1\n"
                "        total += WEIGHTS[index] * (card >> 2)\n"
                "    return clamp(total + max(counts[0], counts[1]), 0.0, 9.5)\n"
                "def grow(n):\n    x = 1\n    for _ in range(n):\n        x *= 3\n    return x\n"
                "def label(n):\n    return 'n' * n\n"
                "class Box:\n    def half(self, x):\n        return x / 2\n"
                "for i in range(200):\n    score((i % 20, (i * 7) % 20, (i * 3) % 20))\n"
                "    score([i % 20, 1, 2])\n    grow(i % 60)\n    label(i % 3)\n    Box().half(i)\n",
                encoding="utf-8")
            report = root / "report.json"
            run = cli("profile", "--json", report, "--samples", "50", script, cwd=root)
            self.assertEqual(run.returncode, 0, run.stderr)
            rows = {row["function"]: row["candidate"] for row in json.loads(report.read_text())["functions"]}
            self.assertEqual((rows["score"]["status"], rows["score"]["samples"]), ("verified", 50))
            self.assertEqual(rows["score"]["fallback_samples"], 0)
            # A third of grow's calls overflow 64 bits and fall back, so it does not count as verified.
            self.assertEqual(rows["grow"]["status"], "skipped")
            self.assertIn("fell back to Python", rows["grow"]["reason"])
            self.assertGreater(rows["grow"]["compiled_samples"], 0)
            self.assertIn("outside the supported subset", rows["label"]["reason"])
            self.assertEqual(rows["half"]["status"], "verified", rows["half"])
            self.assertIn("cpu", rows["score"]["batch_backends"])

    @unittest.skipUnless(importlib.util.find_spec("numba") and importlib.util.find_spec("scipy"),
                         "needs Numba and SciPy")
    def test_starting_the_compiler_skips_scipy_without_breaking_it(self):
        probe = (
            "import sys\n"
            "from recompyler.lift import lift\n"
            "def total(n):\n    s = 0.0\n    for i in range(n):\n        s += i * 0.5\n    return s\n"
            "assert lift(total)(10) == 22.5\n"
            "print('scipy' in sys.modules)\n"
            "import numpy as np\n"
            "from numba import njit\n"
            "print(njit(lambda a, b: np.dot(a, b))(np.ones(3), np.ones(3)))\n"
            "import scipy.linalg\n"
            "print(scipy.linalg.__name__)\n")
        with tempfile.TemporaryDirectory() as tmp:
            script = Path(tmp) / "probe.py"
            script.write_text(probe, encoding="utf-8")
            env = os.environ.copy()
            env["PYTHONPATH"] = os.pathsep.join(filter(None, (str(ROOT / "src"), env.get("PYTHONPATH"))))
            run = subprocess.run([sys.executable, str(script)], capture_output=True, text=True, env=env, timeout=300)
        self.assertEqual(run.returncode, 0, run.stderr)
        self.assertEqual(run.stdout.split(), ["False", "3.0", "scipy.linalg"])

    def test_recommendation_counts_start_up_cost(self):
        sys.path.insert(0, str(ROOT / "src"))
        from recompyler.profiler import recommend

        self.assertFalse(recommend(1000, 1e-6, 2e-6, 0.5, 0.01)["recommended"])
        self.assertFalse(recommend(10, 1e-3, 1e-4, 0.5, 0.05)["recommended"])
        self.assertTrue(recommend(10, 1e-3, 1e-4, 0.5, 0.001)["recommended"])
        first_run = recommend(1000, 1e-3, 1e-4, 0.5, 0.01)
        self.assertTrue(first_run["recommended"])
        self.assertIn("first run", first_run["recommendation"])

    @unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
    def test_run_uses_an_ahead_of_time_module_without_numba(self):
        source = (
            "import sys\n"
            "SCALE = 0.999\n"
            "def step(values, k):\n    for _ in range(50):\n        for i in range(len(values)):\n"
            "            values[i] = values[i] * k * SCALE + 0.001\n"
            "    if k > 10.0:\n        raise ValueError('k too large')\n"
            "    return len(values) + float(k)\n"
            "data = [float(i) for i in range(500)]\n"
            "for _ in range(200):\n    step(data, 1.0)\n"
            "print(repr(sum(data)))\n"
            "try:\n    step(data, 11.0)\nexcept ValueError as exc:\n    print('raised', exc)\n"
            "print('numba loaded', 'numba' in sys.modules, file=sys.stderr)\n")
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            script = root / "work.py"
            script.write_text(source, encoding="utf-8")
            plain = subprocess.run([sys.executable, str(script)], capture_output=True, text=True, cwd=root)
            plan = root / "plan.json"
            run = cli("profile", "--json", plan, script, cwd=root)
            self.assertEqual(run.returncode, 0, run.stderr)
            section = json.loads(plan.read_text())["plan"].get("aot")
            if section is None:
                self.skipTest("no ahead-of-time build here (it needs a C compiler)")
            fast = cli("run", "--force", "--plan", plan, script, cwd=root)
            self.assertEqual((fast.returncode, fast.stdout), (0, plain.stdout), fast.stderr)
            self.assertIn("raised k too large", fast.stdout)
            self.assertIn("step: compiled ahead of time, 200 compiled calls, 1 handed back", fast.stderr)
            self.assertIn("numba loaded False", fast.stderr)
            # A changed constant must not use the module built for the old one.
            script.write_text(source.replace("SCALE = 0.999", "SCALE = 0.998"), encoding="utf-8")
            plain = subprocess.run([sys.executable, str(script)], capture_output=True, text=True, cwd=root)
            changed = cli("run", "--force", "--plan", plan, script, cwd=root)
            self.assertEqual(changed.stdout, plain.stdout, changed.stderr)
            self.assertIn("step: compiled, 200 compiled calls", changed.stderr)

    @unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
    def test_run_uses_only_what_the_plan_recommends(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            script = root / "work.py"
            script.write_text(
                "import sys\n"
                "def step(values, k):\n    for _ in range(50):\n        for i in range(len(values)):\n"
                "            values[i] = values[i] * k + 0.001\n"
                "data = [float(i) for i in range(500)]\n"
                "for _ in range(200):\n    step(data, 0.999)\n"
                "print(repr(sum(data)))\nsys.exit(int(sys.argv[1]) if len(sys.argv) > 1 else 0)\n",
                encoding="utf-8")
            plain = subprocess.run([sys.executable, str(script)], capture_output=True, text=True, cwd=root)
            plan = root / "plan.json"
            run = cli("profile", "--json", plan, script, cwd=root)
            self.assertEqual(run.returncode, 0, run.stderr)
            rows = {row["function"]: row["candidate"] for row in json.loads(plan.read_text())["functions"]}
            self.assertTrue(rows["step"]["recommended"], rows["step"])
            forced = cli("run", "--force", "--plan", plan, script, cwd=root)
            self.assertEqual((forced.returncode, forced.stdout), (0, plain.stdout), forced.stderr)
            self.assertRegex(forced.stderr, r"step: compiled( ahead of time)?, 200 compiled calls")
            self.assertEqual(cli("run", "--force", "--plan", plan, script, "3", cwd=root).returncode, 3)
            report = json.loads(plan.read_text())
            report["plan"] = {"startup_s": 9.0, "saving_s": 0.1, "worth_running": False}
            plan.write_text(json.dumps(report))
            skipped = cli("run", "--plan", plan, script, cwd=root)
            self.assertEqual(skipped.stdout, plain.stdout)
            self.assertIn("ran in plain Python", skipped.stderr)

    @unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
    def test_profile_falls_back_to_a_region_and_run_uses_it(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            script = root / "tree.py"
            script.write_text(
                "class Node:\n    def __init__(self, key):\n        self.key = key\n        self.left = None\n"
                "        self.right = None\n\n"
                "    def insert(self, key):\n        if key < self.key:\n            if self.left is None:\n"
                "                self.left = Node(key)\n            else:\n                self.left.insert(key)\n"
                "        elif self.right is None:\n            self.right = Node(key)\n        else:\n"
                "            self.right.insert(key)\n\n"
                "    def total(self):\n        result = self.key\n        if self.left is not None:\n"
                "            result += self.left.total()\n        if self.right is not None:\n"
                "            result += self.right.total()\n        return result\n\n"
                "def build(keys):\n    root = Node(keys[0])\n    for key in keys[1:]:\n        root.insert(key)\n"
                "    return root.total()\n\n"
                "data = [(i * 7919) % 1000 * 0.5 for i in range(300)]\ntotal = 0.0\n"
                "for _ in range(40):\n    total += build(data)\nprint(repr(total))\n", encoding="utf-8")
            plain = subprocess.run([sys.executable, str(script)], capture_output=True, text=True, cwd=root)
            plan = root / "plan.json"
            run = cli("profile", "--json", plan, "--limit", "6", script, cwd=root)
            self.assertEqual(run.returncode, 0, run.stderr)
            report = json.loads(plan.read_text())
            rows = {row["function"]: row for row in report["functions"]}
            self.assertEqual((rows["build"]["candidate"]["status"], rows["build"]["candidate"]["engine"]),
                             ("verified", "region"), rows["build"])
            self.assertIn("lift_reason", rows["build"]["candidate"])
            for row in report["functions"]:
                row["candidate"]["recommended"] = row["function"] == "build"
            plan.write_text(json.dumps(report))
            forced = cli("run", "--force", "--plan", plan, script, cwd=root)
            self.assertEqual((forced.returncode, forced.stdout), (0, plain.stdout), forced.stderr)
            self.assertIn("build: compiled as one region, 40 compiled calls, 0 handed back", forced.stderr)

    @unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
    def test_profile_checks_functions_that_change_their_arguments(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            script = root / "work.py"
            script.write_text(
                "from array import array\n"
                "def scale(values, k, offset=0.0):\n    for i in range(len(values)):\n"
                "        values[i] = values[i] * k + offset\n"
                "data, grid = [1.0, 2.0, 3.0], array('d', [0.5] * 64)\n"
                "for i in range(300):\n    scale(data, 1.0001)\n    scale(grid, 0.999, 1e-3)\n"
                "print(data[0], grid[0])\n",
                encoding="utf-8")
            report = root / "report.json"
            run = cli("profile", "--json", report, script, cwd=root)
            self.assertEqual(run.returncode, 0, run.stderr)
            rows = {row["function"]: row["candidate"] for row in json.loads(report.read_text())["functions"]}
            self.assertEqual(rows["scale"]["status"], "verified", rows["scale"])
            self.assertTrue(rows["scale"]["changes_arguments"])
            self.assertEqual((rows["scale"]["fallback_samples"], rows["scale"]["batch_backends"]), (0, {}))

    @unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
    def test_profile_compares_batch_backends(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            script = root / "work.py"
            script.write_text(
                "def drift(x, v):\n    for _ in range(16):\n        x += v * 0.5\n        v *= 0.99\n    return x\n"
                "def tally(n):\n    counts = [0] * 4\n    for i in range(n):\n        counts[i & 3] += i\n"
                "    return counts[1]\n"
                "for i in range(1500):\n    drift(i * 0.25, 1.5)\n    tally(i % 9)\n", encoding="utf-8")
            report = root / "report.json"
            run = cli("profile", "--format", "compact", "--json", report, script, cwd=root)
            self.assertEqual(run.returncode, 0, run.stderr)
            rows = {row["function"]: row for row in json.loads(report.read_text())["hotspots"]}
            for row in (rows["drift"], rows["tally"]):
                self.assertEqual(row["status"], "verified", row)
                self.assertLessEqual({"cpu", "parallel"}, set(row["backends_x"]))
                self.assertEqual(row["best_backend"], max(row["backends_x"], key=row["backends_x"].get))
            self.assertNotIn("gpu", rows["tally"]["backends_x"])
            self.assertIn("lists", rows["tally"]["backend_note"])
            # The GPU either reproduced the captured results or the report says why it was left out.
            self.assertTrue("gpu" in rows["drift"]["backends_x"] or "GPU" in rows["drift"]["backend_note"])

    @unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
    def test_profile_does_not_replay_a_shadowed_builtin(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            script = root / "work.py"
            script.write_text(
                "import builtins\ndef range(n):\n    print('custom range')\n    return builtins.range(n)\n"
                "def total(n):\n    s = 0\n    for i in range(n):\n        s += i\n    return s\n"
                "print(total(10))\n", encoding="utf-8")
            report = root / "report.json"
            run = cli("profile", "--json", report, script, cwd=root)
            self.assertEqual(run.returncode, 0, run.stderr)
            rows = {row["function"]: row for row in json.loads(report.read_text())["functions"]}
            self.assertEqual(rows["total"]["candidate"]["status"], "skipped")
            self.assertEqual(run.stdout.splitlines(), ["custom range", "45"])

    @unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
    def test_benchmark_falls_back_if_cuda_toolkit_cannot_compile(self):
        code = """
from unittest.mock import patch
from numba.cuda.cudadrv.error import NvvmSupportError
from recompyler.benchmark import benchmark

with patch('recompyler.benchmark.cuda_device', return_value=('GPU', None)), patch(
    'numba.cuda.to_device', side_effect=NvvmSupportError('missing toolkit')
):
    report = benchmark([8], 1, False)
assert report['gpu'] is None and 'missing toolkit' in report['gpu_note']
assert 'cpu_serial' in report['timings'][0]['milliseconds']
"""
        env = os.environ.copy()
        env["PYTHONPATH"] = str(ROOT / "src")
        run = subprocess.run([sys.executable, "-c", code], cwd=ROOT, env=env, capture_output=True,
                             text=True, timeout=90)
        self.assertEqual(run.returncode, 0, run.stderr)

    @unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
    def test_benchmark_cpu_only_checks_outputs(self):
        with tempfile.TemporaryDirectory() as tmp:
            report = Path(tmp) / "bench.json"
            run = cli("benchmark", "--cpu-only", "--sizes", "8", "32", "--repeats", "1", "--json", report)
            self.assertEqual(run.returncode, 0, run.stderr)
            data = json.loads(report.read_text())
            self.assertEqual([row["batch"] for row in data["timings"]], [8, 32])
            self.assertEqual([row["verified"] for row in data["timings"]], [8, 32])


if __name__ == "__main__":
    unittest.main()
