from pathlib import Path
import tempfile
import unittest

import bench


class ProtocolTests(unittest.TestCase):
    def test_checks_require_same_keys_and_float_bits(self):
        self.assertTrue(bench.checks_equal({"x": "0x1.0p+0"}, {"x": "0x1.0p+0"}))
        self.assertFalse(bench.checks_equal({"x": "0x0.0p+0"}, {"x": "-0x0.0p+0"}))
        self.assertFalse(bench.checks_equal({"x": "3"}, {"x": "3", "y": "4"}))

    def test_kernel_view_is_declared_before_results(self):
        self.assertEqual(bench.kernel_view("barnes_hut"), "forced")
        self.assertEqual(bench.kernel_view("richards"), "warm")
        self.assertEqual(bench.kernel_view("scimark"), "warm")

    def test_parse_separates_check_values_from_timing(self):
        checks, times = bench.parse("check energy -0x0.0p+0\nseconds 1.234\nseconds_fft 0.02\n")
        self.assertEqual(checks, {"energy": "-0x0.0p+0"})
        self.assertEqual(times, {"seconds": 1.234, "seconds_fft": 0.02})

    def test_input_addition_invalidates_snapshot(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "fixture.py").write_text("pass")
            frozen = bench.common.file_hashes(root)
            (root / "shadow.py").write_text("pass")
            self.assertNotEqual(bench.common.file_hashes(root), frozen)


if __name__ == "__main__":
    unittest.main()
