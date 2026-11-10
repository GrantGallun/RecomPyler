import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


def cli(*args, cwd=ROOT):
    env = os.environ.copy()
    env["PYTHONPATH"] = os.pathsep.join(filter(None, (str(ROOT / "src"), env.get("PYTHONPATH"))))
    return subprocess.run([sys.executable, "-m", "recompyler", *map(str, args)], cwd=cwd,
                          env=env, capture_output=True, text=True, timeout=90)


class CliTests(unittest.TestCase):
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
