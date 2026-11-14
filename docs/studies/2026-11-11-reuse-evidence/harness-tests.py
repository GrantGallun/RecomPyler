from pathlib import Path
import os
import subprocess
import sys
import tempfile
import unittest

import audit
import study


class Wave3Tests(unittest.TestCase):
    def test_compile_only_warmup_never_executes_workload(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            source = root / "source"
            source.mkdir()
            (source / "fixture.py").write_text("raise RuntimeError('must not execute')\n")
            (source / ".venv").mkdir()
            (source / ".venv" / "invalid.py").write_text("invalid python ???")
            prefix = root / "bytecode"
            env = dict(os.environ, PYTHONPYCACHEPREFIX=str(prefix), PYTHONDONTWRITEBYTECODE="0")
            run = subprocess.run([sys.executable, str(study.HERE / "warm_bytecode.py"), str(source)],
                                 capture_output=True, text=True, env=env, timeout=10)
            self.assertEqual(run.returncode, 0, run.stderr + run.stdout)
            cached = list(prefix.rglob("fixture.*.pyc"))
            self.assertEqual(len(cached), 1)
            self.assertEqual(int.from_bytes(cached[0].read_bytes()[4:8], "little"), 3)
            self.assertFalse((source / "__pycache__").exists())

    def test_legacy_or_partial_timing_mode_fields_stay_unknown(self):
        legacy = [{"functions": [{"compiled_calls": 2}]}] * 5
        self.assertEqual(study.exact_timing_modes(legacy, 5), (None, None))
        partial = [{"functions": [{"compiled_calls": 2, "aot_calls": 1, "jit_calls": 1}]}] * 4 + legacy[:1]
        self.assertEqual(study.exact_timing_modes(partial, 5), (None, None))
        exact = [{"functions": [{"compiled_calls": 2, "aot_calls": 1, "jit_calls": 1}]}] * 5
        self.assertEqual(study.exact_timing_modes(exact, 5), (5, 5))

    def test_region_audit_counts_successful_program_not_export_presence(self):
        class Program:
            def __init__(self, aot):
                self.ahead_of_time = aot
                self.digest = str(aot)
        class Region:
            def __init__(self):
                self.latest = None
                self.compiled_calls = self.fallback_calls = 0
                self.original = lambda: None
            def attempt(self, mode):
                self.latest = Program(mode == "aot")
                return mode != "fallback", 1
        auditor = audit.Auditor()
        auditor.patch_region(Region)
        r = Region()
        r.attempt("aot")
        r.attempt("jit")
        r.attempt("fallback")
        totals = auditor.result()["totals"]
        self.assertEqual(totals["aot_calls"], 1)
        self.assertEqual(totals["jit_calls"], 1)
        self.assertEqual(totals["rejected_attempts"], 1)
        auditor.restore()

    def test_unknown_region_mode_is_never_called_jit(self):
        class Region:
            compiled_calls = fallback_calls = 0
            original = None
            latest = object()
            def attempt(self):
                return True, None
        auditor = audit.Auditor()
        auditor.patch_region(Region)
        Region().attempt()
        self.assertEqual(auditor.result()["totals"]["unknown_native_calls"], 1)
        auditor.restore()

    def test_ordinary_aot_and_fallback_use_counter_deltas(self):
        class Lifted:
            def __init__(self):
                self.compiled_calls = self.fallback_calls = 0
                self.original = None
            def __call__(self, ok):
                if ok:
                    self.compiled_calls += 1
                else:
                    self.fallback_calls += 1
        class Aot(Lifted):
            pass
        auditor = audit.Auditor()
        auditor.patch_lifted(Lifted, Aot)
        a, j = Aot(), Lifted()
        a(True)
        a(False)
        j(True)
        totals = auditor.result()["totals"]
        self.assertEqual((totals["aot_calls"], totals["jit_calls"], totals["fallback_calls"]), (1, 1, 1))
        auditor.restore()

    def test_bytecode_inventory_is_frozen_and_additions_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "cache").mkdir()
            (root / "cache" / "a.pyc").write_bytes(b"fixture")
            frozen = study.bytecode_inventory(root / "cache")
            study.verify_bytecode(root / "cache", frozen)
            (root / "cache" / "new.pyc").write_bytes(b"new")
            with self.assertRaisesRegex(SystemExit, "bytecode"):
                study.verify_bytecode(root / "cache", frozen)

    def test_timing_and_audit_environment_share_frozen_prefix(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            env = study.environment(root, "tiny", "baseline", root, {"PATH": "fixture"})
            self.assertEqual(env["PYTHONPYCACHEPREFIX"], str(root / "bytecode" / "tiny"))
            self.assertEqual(env["PYTHONDONTWRITEBYTECODE"], "1")


if __name__ == "__main__":
    unittest.main()
