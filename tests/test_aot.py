import importlib.util
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import textwrap
import unittest

ROOT = Path(__file__).resolve().parents[1]

BUILD = textwrap.dedent("""
    import sys

    class NoPycc:
        # Numba has deprecated numba.pycc: the build must not need it.
        def find_spec(self, name, path=None, target=None):
            if name == "numba.pycc" or name.startswith("numba.pycc."):
                raise ImportError("numba.pycc is not available")
            return None

    sys.meta_path.insert(0, NoPycc())
    sys.path.insert(0, sys.argv[2])
    import work
    from recompyler.aot import build
    from recompyler.lift import lift

    lifted = lift(work.scale)
    rows = [([1.5, 2.5, -0.5], 3.0), ([1.0, 2.0], 0.5)]
    for args in rows:
        lifted(*[list(item) if type(item) is list else item for item in args])
    section = build([(("scale", 1), work.scale, lifted, rows)], sys.argv[1])
    print(section["module"])
""")

USE = textwrap.dedent("""
    import sys

    class NoNumba:
        def find_spec(self, name, path=None, target=None):
            if name.split(".")[0] in ("numba", "llvmlite"):
                raise ImportError("Numba is not allowed in this process")
            return None

    sys.meta_path.insert(0, NoNumba())
    import numpy as np
    sys.path.insert(0, sys.argv[1])
    module = __import__(sys.argv[2])
    flag = np.zeros(1, dtype=np.uint8)
    values = np.array([1.5, 2.5, -0.5])
    module.f0(flag, values, 3.0)
    print(values.tolist(), int(flag[0]))
""")


@unittest.skipUnless(importlib.util.find_spec("numba"), "optional compiler unavailable")
class AheadOfTimeTests(unittest.TestCase):
    def test_vendored_pycc_builds_a_module_that_runs_without_numba(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "work.py").write_text(
                "def scale(values, k):\n    for i in range(len(values)):\n        values[i] = values[i] * k\n",
                encoding="utf-8")
            (root / "build.py").write_text(BUILD, encoding="utf-8")
            (root / "use.py").write_text(USE, encoding="utf-8")
            out = root / "out"
            out.mkdir()
            env = dict(os.environ, RECOMPYLER_CACHE=str(root / "cache"),
                       PYTHONPATH=os.pathsep.join(filter(None, (str(ROOT / "src"), os.environ.get("PYTHONPATH")))))
            built = subprocess.run([sys.executable, str(root / "build.py"), str(out), str(root)],
                                   capture_output=True, text=True, env=env, timeout=600)
            if built.returncode and ("Microsoft Visual C++" in built.stderr or "compiler" in built.stderr.lower()
                                     and "not found" in built.stderr.lower()):
                self.skipTest("no C compiler for the ahead-of-time build")
            self.assertEqual(built.returncode, 0, built.stderr[-2000:])
            module = built.stdout.strip().splitlines()[-1]
            used = subprocess.run([sys.executable, str(root / "use.py"), str(out), module],
                                  capture_output=True, text=True, env=env, timeout=120)
            self.assertEqual(used.returncode, 0, used.stderr[-2000:])
            self.assertEqual(used.stdout.split("]")[0] + "]", "[4.5, 7.5, -1.5]")
            self.assertTrue(used.stdout.strip().endswith(" 0"))


if __name__ == "__main__":
    unittest.main()
