import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch

import compare


class HarnessTests(unittest.TestCase):
    def fixture_manifest(self, root):
        shim = root / "shim"
        shim.mkdir()
        inputs = root / "inputs"
        inputs.mkdir()
        (inputs / "entry.py").write_text("pass")
        return {"harness_sha256": compare.digest(Path(compare.__file__).read_bytes()),
                "shim_sha256": compare.file_hashes(shim), "runtime_identity": compare.runtime_identity(),
                "sources": {}, "workloads": [{"cwd": str(inputs), "inventory_kind": "corpus",
                                               "input_sha256": compare.input_inventory(inputs, "corpus")}]}

    def test_environment_is_sanitized_and_frozen_without_credentials(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            with patch.dict(compare.os.environ, {"NUMBA_DISABLE_JIT": "1", "SECRET_TOKEN": "credential", "POKER_BOT": "Z:/other", "POKER_MODE": "surprise", "OMP_NUM_THREADS": "2"}):
                frozen = compare.execution_environment(root / "hashed-bot")
            with patch.dict(compare.os.environ, {"NUMBA_DISABLE_JIT": "1", "OMP_NUM_THREADS": "99", "SECRET_TOKEN": "other"}):
                child = compare.environment(root, "fixture", "baseline", root, frozen)
            self.assertEqual(child["NUMBA_DISABLE_JIT"], "0")
            self.assertEqual(child["OMP_NUM_THREADS"], "2")
            self.assertEqual(child["POKER_BOT"], str((root / "hashed-bot").resolve()))
            self.assertEqual(child["POKER_MODE"], "adaptive")
            self.assertNotIn("SECRET_TOKEN", child)
            self.assertNotIn("credential", json.dumps(frozen))

    def test_runtime_and_package_identity_changes_reject_resume(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            manifest = self.fixture_manifest(root)
            compare.check_frozen(root, manifest)
            for key in ("executable_sha256", "packages", "version"):
                changed = dict(manifest["runtime_identity"], **{key: "changed"})
                with self.subTest(key=key), patch.object(compare, "runtime_identity", return_value=changed):
                    with self.assertRaisesRegex(SystemExit, "runtime/dependency"):
                        compare.check_frozen(root, manifest)

    def test_new_local_module_or_optional_model_rejects_resume(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            manifest = self.fixture_manifest(root)
            inputs = Path(manifest["workloads"][0]["cwd"])
            (inputs / "shadow.py").write_text("pass")
            with self.assertRaisesRegex(SystemExit, "inventory"):
                compare.check_frozen(root, manifest)
            (inputs / "shadow.py").unlink()
            manifest["workloads"][0]["inventory_kind"] = "bot"
            manifest["workloads"][0]["input_sha256"] = compare.input_inventory(inputs, "bot")
            (inputs / "models").mkdir()
            (inputs / "models" / "optional.json").write_text("{}")
            with self.assertRaisesRegex(SystemExit, "inventory"):
                compare.check_frozen(root, manifest)

    def test_overlap_is_max_not_sum(self):
        report = {"total_s": 10, "script_self_s": 8, "functions": [
            {"self_s": 3, "cumulative_s": 7, "candidate": {"status": "verified", "engine": "region", "recommended": True}},
            {"self_s": 2, "cumulative_s": 6, "candidate": {"status": "verified", "engine": "region"}},
        ]}
        self.assertEqual(compare.coverage(report)["largest_verified_fraction"], .7)
        self.assertEqual(compare.coverage(report)["largest_recommended_fraction"], .7)

    def test_resume_and_timeout_preserve_raw_evidence(self):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "case"
            env = dict(__import__("os").environ)
            result = compare.execute(path, [sys.executable, "-c", "print('fixture'); raise SystemExit(3)"], Path(folder), env, 3)
            self.assertEqual(result["exit_code"], 3)
            self.assertEqual(path.with_suffix(".stdout").read_bytes(), b"fixture\r\n" if sys.platform == "win32" else b"fixture\n")
            again = compare.execute(path, [sys.executable, "-c", "raise SystemExit(9)"], Path(folder), env, 3)
            self.assertEqual(again["exit_code"], 3)
            timeout = compare.execute(Path(folder) / "timeout", [sys.executable, "-c", "import time; print('start', flush=True); time.sleep(2)"], Path(folder), env, .1)
            self.assertEqual(timeout["status"], "timeout")
            self.assertIn(b"start", (Path(folder) / "timeout.stdout").read_bytes())

    def test_output_or_exit_mismatch_rejected(self):
        self.assertTrue(compare.same_output({"status": "ok", "exit_code": 0, "stdout_sha256": "a"}, {"status": "ok", "exit_code": 0, "stdout_sha256": "a"}))
        self.assertFalse(compare.same_output({"status": "ok", "exit_code": 0, "stdout_sha256": "a"}, {"status": "ok", "exit_code": 0, "stdout_sha256": "b"}))


if __name__ == "__main__":
    unittest.main()
