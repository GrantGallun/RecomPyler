"""Opt-in integer policies share the heap compiler without changing strict calls."""
import importlib
import importlib.util
import inspect
import itertools
import json
import os
from pathlib import Path
import sys
import subprocess
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
from recompyler import heap


def mul_add(x, y, z):
    return x * y + z


def signed_ops(x, y, z):
    product = x * y
    product -= z
    return product + y


def narrow_final(x):
    product = x * x
    return product - product


def binding(x, /, y=2, *, z=3):
    return x * y + z


def real_empty_default(x=inspect.Parameter.empty):
    return x


def trailing_empty_defaults(x=1, y=inspect.Parameter.empty, *, z=inspect.Parameter.empty):
    return x * y + z


def keyword_empty_default(x=1, *, y=inspect.Parameter.empty):
    return y


def proved_source(x):
    return x * 1


def proved_product(x):
    return x * x


def positional_defaults(x, y=2, z=3):
    return x * y + z


def positional_only(x, /, y=2):
    return x + y


def fibonacci(n):
    a, b = 0, 1
    for i in range(n):
        a, b = b, a + b
    return a


def indexed_sum(n, x):
    result = x
    for i in range(n):
        result += i
    return result


def loop_unbound(n):
    for i in range(n):
        value = i + 1
    return value


def unsupported_branch(x):
    if x:
        return x + 1
    return 0


def unsupported_call(x):
    return abs(x)


def unsupported_heap(x):
    return x[0] + 1


def unsupported_division(x):
    return x // 2


def unsupported_nested(n):
    x = 0
    for i in range(n):
        for j in range(n):
            x += 1
    return x


def minimum_literal(x):
    return x + -9223372036854775808


def shadowed_range(n, range):
    x = 0
    for i in range(n):
        x += 1
    return x


def dead_global(n):
    result = 0
    for i in range(n):
        result += NOT_A_PILOT_PARAMETER
    return result


class SourceOnly:
    def __bool__(self):
        return True

    def get(self, digest, default=None):
        return object()


def source_program(region):
    program = region._make_program()
    for name in program.entry.params:
        program.entry.vars[name] = heap.INT
    program.compile(SourceOnly())
    return program


class NumericTestCase(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(importlib.util.find_spec("recompyler.experimental"),
                             "the opt-in experimental numeric API is missing")
        self.api = importlib.import_module("recompyler.experimental")

    def contract(self, **bounds):
        return self.api.IntIntervals(**bounds)


class ContractTests(NumericTestCase):
    def test_interval_names_require_exact_strings_before_identifier_hooks(self):
        calls = []
        class HookedName(str):
            def isidentifier(self):
                calls.append("isidentifier")
                return True
        with self.assertRaises(TypeError):
            self.api.IntIntervals(**{HookedName("x"): (0, 1)})
        self.assertEqual(calls, [])

    def test_contract_subclass_cannot_supply_different_proof_and_guard_bounds(self):
        class DivergentIntervals(self.api.IntIntervals):
            def __getitem__(self, name):
                return (-1, 1)
            def __iter__(self):
                return iter(("x",))
        contract = DivergentIntervals(x=(-2**32, 2**32))
        try:
            region = self.api.lift_numeric(proved_product, mode="checked", contract=contract)
        except ValueError:
            return
        self.assertEqual(region(2**32), 2**64)

    def test_only_exact_immutable_interval_configuration_is_accepted(self):
        calls = []
        class DivergentIntervals(self.api.IntIntervals):
            def __getitem__(self, name):
                calls.append("getitem")
                return (-1, 1)
            def __iter__(self):
                calls.append("iter")
                return iter(("x",))
        for mode in ("checked", "unchecked-int64"):
            with self.subTest(mode=mode), self.assertRaises(ValueError):
                self.api.lift_numeric(proved_product, mode=mode,
                                      contract=DivergentIntervals(x=(-2**32, 2**32)))
        self.assertEqual(calls, [])

    def test_real_empty_defaults_remain_present_in_python_binding(self):
        contract = self.contract(x=(-10, 10), y=(-10, 10), z=(-10, 10))
        for mode in ("checked", "unchecked-int64"):
            with self.subTest(mode=mode):
                region = self.api.lift_numeric(trailing_empty_defaults, mode=mode, contract=contract)
                self.assertIs(region.original, trailing_empty_defaults)

    def test_unchecked_binding_failure_never_calls_original_body(self):
        region = self.api.lift_numeric(real_empty_default, mode="unchecked-int64",
                                       contract=self.contract(x=(-10, 10)))
        original_calls = []
        def observe(frame, event, arg):
            if event == "call" and frame.f_code is real_empty_default.__code__:
                original_calls.append(event)
        previous = sys.getprofile()
        sys.setprofile(observe)
        try:
            with self.assertRaises(self.api.NumericContractError):
                region()
        finally:
            sys.setprofile(previous)
        self.assertEqual(original_calls, [])
        self.assertEqual(region.fallback_calls, 0)

    def test_unchecked_invalid_arguments_raise_contract_error_without_python_replay(self):
        region = self.api.lift_numeric(real_empty_default, mode="unchecked-int64",
                                       contract=self.contract(x=(-10, 10)))
        with self.assertRaises(self.api.NumericContractError):
            region(1, unknown=2)
        self.assertEqual(region.fallback_calls, 0)

    def test_contract_canonicalizes_and_is_immutable(self):
        left = self.contract(y=(-3, 4), x=(0, 2))
        right = self.contract(x=(0, 2), y=(-3, 4))
        self.assertEqual(left, right)
        self.assertEqual(hash(left), hash(right))
        self.assertEqual(dict(left), {"x": (0, 2), "y": (-3, 4)})
        with self.assertRaises((AttributeError, TypeError)):
            left.x = (1, 1)

    def test_invalid_bounds_rejected_without_coercion(self):
        for bounds in ((True, 1), (0, False), (1, 0), (0.0, 1),
                       (-(2**63)-1, 0), (0, 2**63), (0,), "01"):
            with self.subTest(bounds=bounds), self.assertRaises((TypeError, ValueError)):
                self.contract(x=bounds)

    def test_contract_must_match_all_parameters(self):
        for values in ({"x": (0, 1)}, {"x": (0, 1), "y": (0, 1),
                                        "z": (0, 1), "extra": (0, 1)}):
            with self.subTest(values=values), self.assertRaises(ValueError):
                self.api.lift_numeric(mul_add, mode="checked", contract=self.contract(**values))

    def test_strict_default_accepts_programs_outside_pilot(self):
        strict = self.api.lift_numeric(unsupported_branch)
        self.assertIs(type(strict), heap.Region)
        self.assertEqual(strict.original, unsupported_branch)

    def test_opt_in_requires_explicit_valid_mode_and_contract(self):
        with self.assertRaises(ValueError):
            self.api.lift_numeric(mul_add, mode="unchecked")
        with self.assertRaises(ValueError):
            self.api.lift_numeric(mul_add, mode="checked")

    def test_unsupported_regions_are_explicitly_rejected(self):
        for fn, bounds in ((unsupported_branch, {"x": (-1, 1)}),
                           (unsupported_call, {"x": (-1, 1)}),
                           (unsupported_heap, {"x": (-1, 1)}),
                           (unsupported_division, {"x": (-1, 1)}),
                           (unsupported_nested, {"n": (0, 3)})):
            for mode in ("checked", "unchecked-int64"):
                with self.subTest(fn=fn.__name__, mode=mode):
                    with self.assertRaises(self.api.UnsupportedNumericRegion):
                        self.api.lift_numeric(fn, mode=mode, contract=self.contract(**bounds))

    def test_signature_metadata_cannot_replace_real_python_binding(self):
        for attribute, value in (("__signature__", inspect.Signature()),
                                 ("__wrapped__", unsupported_branch)):
            setattr(binding, attribute, value)
            try:
                with self.assertRaises(self.api.UnsupportedNumericRegion):
                    self.api.lift_numeric(binding, mode="checked", contract=self.contract(
                        x=(-10, 10), y=(-10, 10), z=(-10, 10)))
            finally:
                delattr(binding, attribute)

    def test_deferred_annotations_are_not_evaluated_for_binding(self):
        if not hasattr(binding, "__annotate__"):
            self.skipTest("deferred annotation hook requires Python 3.14")
        original = binding.__annotate__
        def annotation_effect(format):
            raise AssertionError("calling a function must not evaluate its annotations")
        binding.__annotate__ = annotation_effect
        try:
            region = self.api.lift_numeric(binding, mode="checked", contract=self.contract(
                x=(-10, 10), y=(-10, 10), z=(-10, 10)))
            self.assertEqual(region.contract["x"], (-10, 10))
        finally:
            binding.__annotate__ = original


class ProofTests(NumericTestCase):
    def test_reparsed_ast_must_match_the_certified_origin(self):
        from unittest.mock import patch
        region = self.api.lift_numeric(proved_source, mode="checked",
                                       contract=self.contract(x=(2**60, 2**60)))
        original_source = heap._source_lines
        def changed_source(code):
            lines, first = original_source(code)
            if code is proved_source.__code__:
                lines = [line.replace("x * 1", "x * 9") for line in lines]
            return lines, first
        with patch.object(heap, "_source_lines", side_effect=changed_source):
            with self.assertRaises(self.api.UnsupportedNumericRegion):
                source_program(region)

    def test_signed_minimum_literal_uses_valid_machine_constant(self):
        region = self.api.lift_numeric(minimum_literal, mode="checked", contract=self.contract(x=(0, 0)))
        program = source_program(region)
        self.assertIn("-9223372036854775808", program.entry.source)

    def test_range_parameter_shadow_is_rejected_at_construction(self):
        with self.assertRaises(self.api.UnsupportedNumericRegion):
            self.api.lift_numeric(shadowed_range, mode="checked", contract=self.contract(n=(0, 4), range=(1, 1)))

    def test_zero_trip_contract_does_not_admit_global_reads(self):
        for mode in ("checked", "unchecked-int64"):
            with self.subTest(mode=mode), self.assertRaises(self.api.UnsupportedNumericRegion):
                self.api.lift_numeric(dead_global, mode=mode, contract=self.contract(n=(0, 0)))

    def test_negative_products_reassignment_and_per_operation_intervals(self):
        region = self.api.lift_numeric(signed_ops, mode="checked", contract=self.contract(
            x=(-3, 2), y=(-4, 5), z=(2, 7)))
        proofs = region.proof_certificates
        self.assertEqual([proof.result for proof in proofs], [(-15, 12), (-22, 10), (-26, 15)])
        for x, y, z in itertools.product(range(-3, 3), range(-4, 6), range(2, 8)):
            self.assertTrue(-26 <= signed_ops(x, y, z) <= 15)

    def test_overflowing_intermediate_cannot_be_hidden_by_final_result(self):
        with self.assertRaises(self.api.UnsupportedNumericRegion):
            self.api.lift_numeric(narrow_final, mode="checked", contract=self.contract(x=(2**32, 2**32)))

    def test_int64_endpoint_additions_are_certified(self):
        region = self.api.lift_numeric(mul_add, mode="checked", contract=self.contract(
            x=(-(2**63), 2**63-1), y=(1, 1), z=(0, 0)))
        self.assertEqual([p.result for p in region.proof_certificates],
                         [(-(2**63), 2**63-1), (-(2**63), 2**63-1)])

    def test_loop_proof_covers_every_iteration_and_retains_runtime_loop(self):
        region = self.api.lift_numeric(fibonacci, mode="checked", contract=self.contract(n=(0, 80)))
        self.assertEqual(len(region.proof_certificates), 1)
        self.assertEqual(region.proof_certificates[0].result, (1, 37889062373143906))
        program = source_program(region)
        self.assertIn("for ", program.entry.source)
        self.assertNotIn("add_i(st", program.entry.source)

    def test_loop_proof_rejects_overflow_and_excessive_work(self):
        for bound in (93, 1025):
            with self.subTest(bound=bound), self.assertRaises(self.api.UnsupportedNumericRegion):
                self.api.lift_numeric(fibonacci, mode="checked", contract=self.contract(n=(0, bound)))

    def test_loop_zero_count_exit_preserves_definite_assignment(self):
        with self.assertRaises(self.api.UnsupportedNumericRegion):
            self.api.lift_numeric(loop_unbound, mode="checked", contract=self.contract(n=(0, 4)))

    def test_checked_sites_remove_only_integer_overflow_checks(self):
        region = self.api.lift_numeric(mul_add, mode="checked", contract=self.contract(
            x=(-20, 20), y=(-20, 20), z=(-20, 20)))
        checked = source_program(region)
        strict = heap._Program(mul_add)
        strict.entry.vars.update(x=heap.INT, y=heap.INT, z=heap.INT)
        strict.compile(SourceOnly())
        self.assertIn("mul_i(st", strict.entry.source)
        self.assertIn("add_i(st", strict.entry.source)
        self.assertNotIn("mul_i(st", checked.entry.source)
        self.assertNotIn("add_i(st", checked.entry.source)
        self.assertIn("st[0]", checked.source)

    def test_mode_contract_and_intrinsic_identity_are_isolated(self):
        contract = self.contract(x=(-2, 2), y=(-2, 2), z=(-2, 2))
        checked = self.api.lift_numeric(mul_add, mode="checked", contract=contract)
        unchecked = self.api.lift_numeric(mul_add, mode="unchecked-int64", contract=contract)
        wider = self.api.lift_numeric(mul_add, mode="checked", contract=self.contract(
            x=(-3, 3), y=(-2, 2), z=(-2, 2)))
        again = self.api.lift_numeric(mul_add, mode="checked", contract=contract)
        programs = [source_program(r) for r in (checked, unchecked, wider, again)]
        self.assertEqual(programs[0].digest, programs[3].digest)
        self.assertEqual(len({p.digest for p in programs[:3]}), 3)
        self.assertNotEqual(heap._signature(programs[0], [heap.INT]*3),
                            heap._signature(programs[1], [heap.INT]*3))

    def test_policy_implementation_and_intrinsics_participate_in_identity(self):
        from unittest.mock import patch
        contract = self.contract(x=(-2, 2), y=(-2, 2), z=(-2, 2))
        original = source_program(self.api.lift_numeric(mul_add, mode="checked", contract=contract))
        with patch.object(self.api, "_WRAP_RUNTIME", self.api._WRAP_RUNTIME + "\n# changed intrinsic\n"):
            changed = source_program(self.api.lift_numeric(mul_add, mode="checked", contract=contract))
        self.assertNotEqual(original.digest, changed.digest)


class NativeTests(NumericTestCase):
    def test_current_keyword_empty_defaults_and_explicit_placeholder_are_not_missing(self):
        contract = self.contract(x=(-10, 10), y=(-10, 10))
        checked = self.api.lift_numeric(keyword_empty_default, mode="checked", contract=contract)
        unchecked = self.api.lift_numeric(keyword_empty_default, mode="unchecked-int64", contract=contract)
        original_defaults = keyword_empty_default.__kwdefaults__
        try:
            self.assertIs(checked(), inspect.Parameter.empty)
            with self.assertRaises(self.api.NumericContractError):
                unchecked()
            original_defaults["y"] = 4
            self.assertEqual(checked(), 4)
            self.assertEqual(unchecked(), 4)
            keyword_empty_default.__kwdefaults__ = {"y": inspect.Parameter.empty}
            self.assertIs(checked(), inspect.Parameter.empty)
            with self.assertRaises(self.api.NumericContractError):
                unchecked()
            self.assertIs(checked(y=self.api._PRESENT), self.api._PRESENT)
            with self.assertRaises(self.api.NumericContractError):
                unchecked(y=self.api._PRESENT)
            self.assertEqual(checked.contract_native_calls, 1)
            self.assertEqual(unchecked.contract_native_calls, 1)
            self.assertEqual(unchecked.fallback_calls, 0)
        finally:
            keyword_empty_default.__kwdefaults__ = original_defaults
            original_defaults["y"] = inspect.Parameter.empty

    def test_real_empty_defaults_explicit_values_compile_and_current_defaults_replay(self):
        contract = self.contract(x=(-10, 10), y=(-10, 10), z=(-10, 10))
        for mode in ("checked", "unchecked-int64"):
            with self.subTest(mode=mode):
                region = self.api.lift_numeric(trailing_empty_defaults, mode=mode, contract=contract)
                self.assertEqual(region(3, 4, z=1), 13)
                self.assertEqual(region.contract_native_calls, 1)
                self.assertEqual(region.fallback_calls, 0)
        checked = self.api.lift_numeric(real_empty_default, mode="checked", contract=self.contract(x=(-10, 10)))
        unchecked = self.api.lift_numeric(real_empty_default, mode="unchecked-int64", contract=self.contract(x=(-10, 10)))
        original_defaults = real_empty_default.__defaults__
        try:
            self.assertIs(checked(), inspect.Parameter.empty)
            real_empty_default.__defaults__ = (3,)
            self.assertEqual(checked(), 3)
            self.assertEqual(unchecked(), 3)
            real_empty_default.__defaults__ = (inspect.Parameter.empty,)
            self.assertIs(checked(), inspect.Parameter.empty)
            with self.assertRaises(self.api.NumericContractError):
                unchecked()
        finally:
            real_empty_default.__defaults__ = original_defaults

    def test_changed_same_span_ast_cannot_use_old_numeric_certificate(self):
        from unittest.mock import patch
        contract = self.contract(x=(2**60, 2**60))
        checked = self.api.lift_numeric(proved_source, mode="checked", contract=contract)
        unchecked = self.api.lift_numeric(proved_source, mode="unchecked-int64", contract=contract)
        original_source = heap._source_lines
        def changed_source(code):
            lines, first = original_source(code)
            if code is proved_source.__code__:
                lines = [line.replace("x * 1", "x * 9") for line in lines]
            return lines, first
        with patch.object(heap, "_source_lines", side_effect=changed_source):
            self.assertEqual(checked(2**60), 2**60)
            self.assertEqual(checked.fallback_calls, 1)
            self.assertEqual(checked.jit_calls, 0)
            with self.assertRaises(self.api.NumericContractError):
                unchecked(2**60)
        self.assertEqual(unchecked.fallback_calls, 0)
        self.assertEqual(unchecked.jit_calls, 0)

    def test_checked_native_and_outside_contract_python_replay(self):
        region = self.api.lift_numeric(mul_add, mode="checked", contract=self.contract(
            x=(-20, 20), y=(-20, 20), z=(-20, 20)))
        self.assertEqual(region(3, -4, 5), -7)
        self.assertEqual(region.contract_native_calls, 1)
        self.assertEqual(region.jit_calls, 1)
        for args in ((21, 3, 4), (True, 3, 4), (2.5, 3, 4), (2**80, 3, 4)):
            with self.subTest(args=args):
                result = region(*args)
                self.assertEqual(result, mul_add(*args))
                self.assertIs(type(result), type(mul_add(*args)))
        self.assertEqual(region.guard_misses, 4)
        self.assertEqual(region.fallback_calls, 4)

    def test_checked_attempt_cannot_bypass_guards(self):
        region = self.api.lift_numeric(mul_add, mode="checked", contract=self.contract(
            x=(-2, 2), y=(-2, 2), z=(-2, 2)))
        self.assertEqual(region.attempt((1, 1, 1)), (True, 2))
        self.assertEqual(region.attempt((2**62, 2**62, 0)), (False, None))
        self.assertEqual(region.jit_calls, 1)

    def test_argument_binding_matches_python(self):
        region = self.api.lift_numeric(binding, mode="checked", contract=self.contract(
            x=(-10, 10), y=(-10, 10), z=(-10, 10)))
        self.assertEqual(region(4), 11)
        self.assertEqual(region(4, z=5), 13)
        self.assertEqual(region.contract_native_calls, 2)
        self.assertEqual(region.fallback_calls, 0)
        for args, kwargs in (((4, 5, 6), {}), ((), {"x": 4}), ((4,), {"oops": 5})):
            with self.subTest(args=args, kwargs=kwargs), self.assertRaises(TypeError):
                region(*args, **kwargs)

    def test_current_defaults_are_used_after_first_native_call(self):
        region = self.api.lift_numeric(binding, mode="checked", contract=self.contract(
            x=(-100, 100), y=(-100, 100), z=(-100, 100)))
        defaults, kwdefaults = binding.__defaults__, binding.__kwdefaults__
        try:
            self.assertEqual(region(4), 11)
            binding.__defaults__ = (5,)
            binding.__kwdefaults__["z"] = 7
            self.assertEqual(region(4), 27)
            binding.__kwdefaults__ = {"z": 9}
            self.assertEqual(region(4), 29)
        finally:
            binding.__defaults__ = defaults
            binding.__kwdefaults__ = kwdefaults
            kwdefaults["z"] = 3

    def test_annotation_hook_is_not_evaluated_on_native_keyword_call(self):
        if not hasattr(binding, "__annotate__"):
            self.skipTest("deferred annotation hook requires Python 3.14")
        original = binding.__annotate__
        def annotation_effect(format):
            raise AssertionError("native binding evaluated annotations")
        binding.__annotate__ = annotation_effect
        try:
            region = self.api.lift_numeric(binding, mode="checked", contract=self.contract(
                x=(-10, 10), y=(-10, 10), z=(-10, 10)))
            self.assertEqual(region(4, z=5), 13)
            self.assertEqual(region.contract_native_calls, 1)
        finally:
            binding.__annotate__ = original

    def test_changed_code_replays_checked_and_rejects_unchecked(self):
        contract = self.contract(x=(-2, 2), y=(-2, 2), z=(-2, 2))
        checked = self.api.lift_numeric(mul_add, mode="checked", contract=contract)
        unchecked = self.api.lift_numeric(mul_add, mode="unchecked-int64", contract=contract)
        original_code = mul_add.__code__
        try:
            self.assertEqual(checked(1, 1, 1), 2)
            mul_add.__code__ = signed_ops.__code__
            self.assertEqual(checked(1, 1, 1), 1)
            with self.assertRaises(self.api.NumericContractError):
                unchecked(1, 1, 1)
        finally:
            mul_add.__code__ = original_code

    def test_unchecked_cannot_silently_replay_on_native_failure(self):
        region = self.api.lift_numeric(mul_add, mode="unchecked-int64", contract=self.contract(
            x=(-2, 2), y=(-2, 2), z=(-2, 2)))
        self.assertEqual(region(1, 1, 1), 2)
        region.latest.broken = True
        with self.assertRaises(self.api.NumericContractError):
            region(2**40, 2**40, 1)
        self.assertEqual(region.fallback_calls, 0)

    def test_unchecked_recursion_error_cannot_trigger_inherited_python_replay(self):
        from unittest.mock import patch
        region = self.api.lift_numeric(mul_add, mode="unchecked-int64", contract=self.contract(
            x=(-2, 2), y=(-2, 2), z=(-2, 2)))
        with patch.object(region, "attempt", side_effect=RecursionError("native unavailable")):
            with self.assertRaises(self.api.NumericContractError):
                region(2**40, 2**40, 1)
        self.assertEqual(region.fallback_calls, 0)

    def test_unchecked_operational_loop_limit_is_guarded(self):
        region = self.api.lift_numeric(fibonacci, mode="unchecked-int64", contract=self.contract(n=(0, 80)))
        self.assertEqual(region(-1), 0)
        with self.assertRaises(self.api.NumericContractError):
            region(1025)

    def test_rebound_range_cannot_run_cached_unchecked_code(self):
        region = self.api.lift_numeric(fibonacci, mode="unchecked-int64", contract=self.contract(n=(0, 80)))
        self.assertEqual(region(10), 55)
        fibonacci.__globals__["range"] = lambda n: ()
        try:
            with self.assertRaises(self.api.NumericContractError):
                region(10)
        finally:
            del fibonacci.__globals__["range"]

    def test_unchecked_wraps_each_op_and_rejects_nonrepresentable_inputs(self):
        region = self.api.lift_numeric(mul_add, mode="unchecked-int64", contract=self.contract(
            x=(-2, 2), y=(-2, 2), z=(-2, 2)))
        for args in ((2**40, 2**40, 1), (2**63-1, 1, 1), (-(2**63), -1, -1)):
            mathematical = mul_add(*args)
            expected = ((mathematical + 2**63) % 2**64) - 2**63
            self.assertEqual(region(*args), expected)
        self.assertEqual(region.contract_native_calls, 3)
        class IntSubclass(int):
            pass
        for value in (True, IntSubclass(1), 1.0, 2**63, -(2**63)-1):
            with self.subTest(value=value), self.assertRaises(self.api.NumericContractError):
                region.attempt((value, 1, 0))
        self.assertEqual(region.representation_rejections, 5)
        self.assertEqual(region.jit_calls, 3)

    def test_fibonacci_native_is_python_exact_over_proved_range(self):
        region = self.api.lift_numeric(fibonacci, mode="checked", contract=self.contract(n=(0, 80)))
        for n in (0, 1, 2, 10, 40, 80):
            self.assertEqual(region(n), fibonacci(n))
        self.assertEqual(region.contract_native_calls, 6)
        self.assertEqual(region(-1), fibonacci(-1))
        self.assertEqual(region(94), fibonacci(94))
        self.assertEqual(region.guard_misses, 2)

    def test_default_strict_still_replays_integer_overflow(self):
        region = self.api.lift_numeric(mul_add)
        self.assertEqual(region(2**40, 2**40, 1), 2**80+1)
        self.assertEqual(region.fallback_calls, 1)


class ArtifactTests(NumericTestCase):
    def test_explicit_artifact_api_exists_without_legacy_seed_export(self):
        self.assertTrue(hasattr(self.api, "build_numeric"), "explicit policy-tagged builder is missing")
        self.assertTrue(hasattr(self.api, "load_numeric"), "explicit policy-tagged loader is missing")
        checked = self.api.lift_numeric(mul_add, mode="checked", contract=self.contract(
            x=(-2, 2), y=(-2, 2), z=(-2, 2)))
        self.assertIsNone(heap.build_regions([(("mul_add", 1), mul_add, checked)], "."))

    def test_explicit_artifact_replay_and_policy_mismatch_in_new_process(self):
        contract = self.contract(x=(-2, 2), y=(-2, 2), z=(-2, 2))
        region = self.api.lift_numeric(mul_add, mode="checked", contract=contract)
        self.assertEqual(region(1, 1, 1), 2)
        with tempfile.TemporaryDirectory() as folder:
            manifest = self.api.build_numeric(region, folder)
            with self.assertRaises(self.api.NumericContractError):
                self.api.load_numeric(mul_add, manifest, mode="unchecked-int64", contract=contract)
            child = '''
import json, sys
import test_experimental_numeric as fixture
from recompyler.experimental import IntIntervals, load_numeric
region = load_numeric(fixture.mul_add, sys.argv[1], mode="checked", contract=IntIntervals(x=(-2,2),y=(-2,2),z=(-2,2)))
assert region(2,2,1) == 5
assert region(2**80,2,1) == 2**81+1
assert region.aot_calls == 1 and region.jit_calls == 0 and region.fallback_calls == 1
assert "numba" not in sys.modules
print(json.dumps({"aot": region.aot_calls, "fallback": region.fallback_calls, "numba": "numba" in sys.modules}))
'''
            environment = dict(os.environ)
            environment["PYTHONPATH"] = os.pathsep.join((str(Path(__file__).resolve().parent),
                                                        str(Path(__file__).resolve().parents[1] / "src")))
            result = subprocess.run([sys.executable, "-c", child, str(manifest)], env=environment,
                                    text=True, capture_output=True, check=True)
            self.assertEqual(json.loads(result.stdout), {"aot": 1, "fallback": 1, "numba": False})

    def test_unchecked_artifact_wraps_and_rejects_changed_contract_or_binary(self):
        contract = self.contract(x=(-2, 2), y=(-2, 2), z=(-2, 2))
        region = self.api.lift_numeric(mul_add, mode="unchecked-int64", contract=contract)
        self.assertEqual(region(2**40, 2**40, 1), 1)
        with tempfile.TemporaryDirectory() as folder:
            manifest = self.api.build_numeric(region, folder)
            record = json.loads(manifest.read_text(encoding="utf-8"))
            with self.assertRaises(self.api.NumericContractError):
                self.api.load_numeric(mul_add, manifest, mode="unchecked-int64", contract=self.contract(
                    x=(-3, 3), y=(-2, 2), z=(-2, 2)))
            tampered = Path(folder) / "tampered.json"
            record["binary_sha256"] = "0" * 64
            tampered.write_text(json.dumps(record), encoding="utf-8")
            with self.assertRaises(self.api.NumericContractError):
                self.api.load_numeric(mul_add, tampered, mode="unchecked-int64", contract=contract)
            child = '''
import json, sys
import test_experimental_numeric as fixture
from recompyler.experimental import IntIntervals, NumericContractError, load_numeric
region=load_numeric(fixture.mul_add,sys.argv[1],mode="unchecked-int64",contract=IntIntervals(x=(-2,2),y=(-2,2),z=(-2,2)))
assert region(2**40,2**40,1)==1
try:
    region(2**80,1,0)
except NumericContractError:
    pass
else:
    raise AssertionError("huge int was not rejected")
assert region.aot_calls==1 and region.jit_calls==0 and region.fallback_calls==0
assert "numba" not in sys.modules
print(json.dumps({"aot":region.aot_calls,"rejected":region.representation_rejections,"numba":False}))
'''
            environment = dict(os.environ)
            environment["PYTHONPATH"] = os.pathsep.join((str(Path(__file__).resolve().parent),
                                                        str(Path(__file__).resolve().parents[1] / "src")))
            result = subprocess.run([sys.executable, "-c", child, str(manifest)], env=environment,
                                    text=True, capture_output=True, check=True)
            self.assertEqual(json.loads(result.stdout), {"aot": 1, "rejected": 1, "numba": False})


class FastBindingTests(NumericTestCase):
    def test_positional_guard_misses_and_arity_checks_do_not_construct_signatures(self):
        from unittest.mock import patch
        contract = self.contract(x=(-2, 2), y=(-2, 2), z=(-2, 2))
        for mode in ("checked", "unchecked-int64"):
            region = self.api.lift_numeric(mul_add, mode=mode, contract=contract)
            cases = (((), None), ((1, 2, 3, 4), {}), ((True, 1, 1), None), ((2**80, 1, 1), {}))
            with self.subTest(mode=mode), patch.object(self.api.inspect, "Signature", wraps=inspect.Signature) as construction:
                for args, kwargs in cases:
                    if mode == "checked":
                        self.assertEqual(region.attempt(args, kwargs), (False, None))
                    else:
                        with self.assertRaises(self.api.NumericContractError):
                            region.attempt(args, kwargs)
                construction.assert_not_called()
            self.assertEqual(region.contract_native_calls, 0)
            self.assertEqual(region.fallback_calls, 0)

    def test_actual_native_positional_calls_do_not_construct_signatures(self):
        from unittest.mock import patch
        contract = self.contract(x=(-20, 20), y=(-20, 20), z=(-20, 20))
        for mode in ("checked", "unchecked-int64"):
            region = self.api.lift_numeric(mul_add, mode=mode, contract=contract)
            self.assertEqual(region(3, -4, 5), -7)
            with self.subTest(mode=mode), patch.object(self.api.inspect, "Signature", wraps=inspect.Signature) as construction:
                self.assertEqual(region(4, 2, 1), 9)
                self.assertEqual(region.attempt((1, 2, 3), {}), (True, 5))
                construction.assert_not_called()
            self.assertEqual(region.contract_native_calls, 3)
            self.assertEqual(region.jit_calls, 3)
            self.assertEqual(region.fallback_calls, 0)

    def test_positional_binding_reads_live_and_oversized_defaults_without_subclass_hooks(self):
        from unittest.mock import patch
        class HookedDefaults(tuple):
            def __len__(self):
                raise AssertionError("default tuple length hook ran")
            def __getitem__(self, index):
                raise AssertionError("default tuple indexing hook ran")
            def __iter__(self):
                raise AssertionError("default tuple iteration hook ran")
            def __bool__(self):
                raise AssertionError("default tuple truth hook ran")
        contract = self.contract(x=(-100, 100), y=(-100, 100), z=(-100, 100))
        original = positional_defaults.__defaults__
        try:
            for mode in ("checked", "unchecked-int64"):
                positional_defaults.__defaults__ = (2, 3)
                region = self.api.lift_numeric(positional_defaults, mode=mode, contract=contract)
                self.assertEqual(region(4), 11)
                positional_defaults.__defaults__ = HookedDefaults((100, 6, 7, 8))
                with self.subTest(mode=mode), patch.object(self.api.inspect, "Signature", wraps=inspect.Signature) as construction:
                    self.assertEqual(region(), 50)
                    self.assertEqual(region(1), 15)
                    self.assertEqual(region(1, 2), 10)
                    construction.assert_not_called()
                self.assertEqual(region.contract_native_calls, 4)
        finally:
            positional_defaults.__defaults__ = original

    def test_positional_only_calls_bind_natively_and_keep_python_keyword_errors(self):
        from unittest.mock import patch
        checked = self.api.lift_numeric(positional_only, mode="checked", contract=self.contract(x=(-10, 10), y=(-10, 10)))
        self.assertEqual(checked(3), 5)
        with patch.object(self.api.inspect, "Signature", wraps=inspect.Signature) as construction:
            self.assertEqual(checked(3, 4), 7)
            construction.assert_not_called()
        with self.assertRaises(TypeError):
            checked(x=3)
        self.assertEqual(checked.contract_native_calls, 2)
        self.assertEqual(checked.fallback_calls, 1)

    def test_keyword_keyword_only_and_other_attempt_containers_keep_signature_binding(self):
        from unittest.mock import patch
        checked = self.api.lift_numeric(mul_add, mode="checked", contract=self.contract(x=(-10, 10), y=(-10, 10), z=(-10, 10)))
        self.assertEqual(checked(1, 2, 3), 5)
        with patch.object(self.api, "_binding_signature", wraps=self.api._binding_signature) as binding_calls:
            self.assertEqual(checked(x=1, y=2, z=3), 5)
            self.assertEqual(checked.attempt([1, 2, 3]), (True, 5))
            self.assertEqual(binding_calls.call_count, 2)
        keyword_only = self.api.lift_numeric(binding, mode="checked", contract=self.contract(x=(-10, 10), y=(-10, 10), z=(-10, 10)))
        self.assertEqual(keyword_only(2), 7)
        with patch.object(self.api, "_binding_signature", wraps=self.api._binding_signature) as binding_calls:
            self.assertEqual(keyword_only(2, z=5), 9)
            self.assertEqual(binding_calls.call_count, 1)

    def test_checked_loop_misses_replay_and_unchecked_operational_cap_stays(self):
        contract = self.contract(n=(0, 80))
        checked = self.api.lift_numeric(fibonacci, mode="checked", contract=contract)
        unchecked = self.api.lift_numeric(fibonacci, mode="unchecked-int64", contract=contract)
        for n in (-1, 1025):
            self.assertEqual(checked(n), fibonacci(n))
        self.assertEqual(checked.guard_misses, 2)
        self.assertEqual(checked.contract_native_calls, 0)
        self.assertEqual(unchecked(-1), 0)
        with self.assertRaises(self.api.NumericContractError):
            unchecked(1025)
        self.assertEqual(unchecked.loop_limit_rejections, 1)


if __name__ == "__main__":
    unittest.main()
