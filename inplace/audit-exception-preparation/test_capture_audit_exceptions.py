"""Focused owned-helper regression; coordinator runs under run_locked, not pytest."""
from pathlib import Path
import argparse
import importlib.util
import sys
import types
import unittest

D = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser()
parser.add_argument('--helper', type=Path, default=D / 'capture_audit.py')
options, remaining = parser.parse_known_args()
sys.path.insert(0, str(D))
spec = importlib.util.spec_from_file_location('audit_exception_target', options.helper.resolve())
helper = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helper)


class Aborted(BaseException):
    pass


def original(value):
    return value


class AttemptExceptions(unittest.TestCase):
    def make_region(self, *, entry=True, increment=False, disable_observer=False, success=False):
        failure = Aborted('application sentinel')
        class Region:
            def __init__(self):
                self.original = original
                self.direct_calls = 0
                self.latest = types.SimpleNamespace(digest='exact-digest', source='return 1', ahead_of_time=True,
                    direct_report={'eligible': False, 'decline_reason': 'test'}, run=self.native)
            def native(self):
                if increment:
                    self.direct_calls += 1
                if disable_observer:
                    sys.setprofile(None)
                if not success:
                    raise failure
                return 7
            def load(self, program, args):
                return None
            def attempt(self, args):
                if not entry:
                    raise failure
                self.load(self.latest, args)
                return True, self.latest.run()
            def __call__(self, *args):
                return self.attempt(args)
        auditor = helper.Auditor(('direct_calls',))
        auditor.binding = lambda native: dict(module_path=None, module_sha256=None, export='native')
        auditor.patch_region(Region)
        self.addCleanup(auditor.restore)
        return auditor, Region(), failure

    def assert_failure(self, region, failure, *, wrapped=False):
        try:
            region() if wrapped else region.attempt(())
        except BaseException as actual:
            self.assertIs(actual, failure, 'Audit replaced the original application exception')
        else:
            self.fail('Original exception disappeared')

    def test_native_entry_then_raise_records_rejection_and_zero_rule_delta(self):
        auditor, region, failure = self.make_region()
        self.assert_failure(region, failure)
        row = auditor.row(region, 'region')
        self.assertEqual(row['native_entries'], 1)
        self.assertEqual(row['rejected_attempts'], 1)
        self.assertEqual((row['aot_calls'], row['jit_calls'], row['unknown_native_calls']), (0, 0, 0))
        self.assertEqual(row['rule_counters']['direct_calls'], dict(implemented=True, successful_calls=0))
        raised = row['programs']['exact-digest']['raising_attempts']
        self.assertEqual(len(raised), 1)
        self.assertEqual(raised[0]['exception_type'], __name__ + '.Aborted')
        self.assertEqual(len(raised[0]['native_events']), 1)
        self.assertEqual(auditor.attempts.get(), ())
        self.assertTrue(auditor.result()['audit_accounting_complete'])

    def test_raise_before_entry_is_rejected_without_claiming_native(self):
        auditor, region, failure = self.make_region(entry=False)
        self.assert_failure(region, failure)
        row = auditor.row(region, 'region')
        self.assertEqual((row['native_entries'], row['rejected_attempts']), (0, 1))
        self.assertEqual(row['rule_counters']['direct_calls']['successful_calls'], 0)
        self.assertEqual(auditor.attempts.get(), ())

    def test_invalid_rule_increment_marks_audit_invalid_without_masking_original(self):
        auditor, region, failure = self.make_region(increment=True)
        self.assert_failure(region, failure)
        row = auditor.row(region, 'region')
        self.assertEqual((row['native_entries'], row['rejected_attempts']), (1, 1))
        self.assertTrue(row['attempt_accounting_errors'])
        self.assertEqual(row['programs']['exact-digest']['raising_attempts'][0]['rule_counters_after'], {'direct_calls': 1})
        self.assertFalse(auditor.result()['audit_accounting_complete'])

    def test_lost_profile_observer_preserves_original_and_invalidates_audit(self):
        auditor, region, failure = self.make_region(disable_observer=True)
        auditor.start_profile()
        self.assert_failure(region, failure, wrapped=True)
        self.assertTrue(auditor.result()['observer_lost'])
        self.assertFalse(auditor.result()['audit_accounting_complete'])
        self.assertEqual((auditor.attempts.get(), auditor.contexts.get()), ((), ()))

    def test_success_still_requires_independently_observed_native_entry(self):
        auditor, region, _ = self.make_region(increment=True, success=True)
        self.assertEqual(region.attempt(()), (True, 7))
        row = auditor.row(region, 'region')
        self.assertEqual((row['native_entries'], row['aot_calls'], row['rejected_attempts']), (1, 1, 0))
        self.assertEqual(row['rule_counters']['direct_calls']['successful_calls'], 1)
        # An unobserved successful adapter must remain unknown until the separate
        # trusted raw C-ABI observer exists; product success counters are not proof.
        class Raw:
            original = staticmethod(original)
            direct_calls = 0
            latest = types.SimpleNamespace(digest='raw', direct_report={})
            def load(self, program, args):
                return None
            def attempt(self, args):
                return True, 9
        auditor.patch_region(Raw)
        raw = Raw()
        self.assertEqual(raw.attempt(()), (True, 9))
        unknown = auditor.row(raw, 'region')
        self.assertEqual((unknown['native_entries'], unknown['aot_calls'], unknown['unknown_native_calls'], unknown['unobserved_successes']), (0, 0, 1, 1))


if __name__ == '__main__':
    unittest.main(argv=[sys.argv[0], *remaining], verbosity=2)
