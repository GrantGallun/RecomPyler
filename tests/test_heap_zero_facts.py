"""Integer-zero certificates remove work without erasing Python numeric types."""
import copy
import json
import math
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
from recompyler import heap
from recompyler.lift import same


def recursive_components(depth, value, empty):
    if depth <= 0:
        return 0, 0
    if depth == 1:
        if empty:
            return 0, 0
        return value / 1.0, -value / 1.0
    ax, ay = recursive_components(depth - 1, value, empty)
    bx, by = recursive_components(0, value, empty)
    ax += bx
    ay += by
    return ax, ay


def recursive_nonzero(depth, value, integer):
    if depth <= 0:
        return integer, 0
    if depth == 1:
        return value / 1.0, value / 1.0
    ax, ay = recursive_nonzero(depth - 1, value, integer)
    bx, by = recursive_nonzero(0, value, integer)
    return ax + bx, ay + by


def literal_nonzero(depth, value):
    if depth <= 0:
        return 1, 0
    if depth == 1:
        return value / 1.0, value / 1.0
    ax, ay = literal_nonzero(depth - 1, value)
    bx, by = literal_nonzero(0, value)
    return ax + bx, ay + by


def zero_operations(depth, value, empty):
    ax, ay = recursive_components(depth, value, empty)
    bx, by = recursive_components(0, value, empty)
    left = right = ax
    return left + bx, right - by, ax * by


def branch_unknown(depth, value, integer, choose):
    ax, ay = recursive_components(depth, value, False)
    other = 0
    if choose:
        other = integer
    return ax + other


def loop_unknown(depth, value, integer, count):
    ax, ay = recursive_components(depth, value, False)
    other = 0
    for i in range(count):
        other = integer
    return ax + other


def conditional_unknown(depth, value, integer, choose):
    ax, ay = recursive_components(depth, value, False)
    other = 0 if choose else integer
    return ax + other


class ZeroEmitter:
    def __init__(self):
        self.kind = 0

    def emit(self, value):
        if value < 0:
            return 0
        return value / 1.0


class IntegerEmitter:
    def __init__(self, integer):
        self.integer = integer

    def emit(self, value):
        return self.integer


def polymorphic_unknown(emitters, value):
    total = 0
    for emitter in emitters:
        total += emitter.emit(value)
    return total


class EffectBox:
    def __init__(self, value):
        self.value = value
        self.calls = 0


def effect_then_failure(box, alias, depth, value, denominator):
    box.calls += 1
    x, y = recursive_components(depth, value, False)
    alias.value = x + y
    return x / denominator


class _SourceOnly:
    """Stop actual compiler generation at AOT lookup; never execute this entry."""

    def get(self, digest):
        return object()


def generated(function, *args):
    program = heap._Program(function)
    seen = {}
    for name, value in zip(program.entry.params, args):
        program.entry.vars[name] = heap._seed(program, value, seen)
    program.compile(ahead_of_time=_SourceOnly())
    return program


class CodegenTests(unittest.TestCase):
    def test_recursive_zero_cases_remove_exact_integer_guards(self):
        program = generated(recursive_components, 4, 2.5, False)
        for info in program.order:
            if info.fn is recursive_components:
                self.assertNotIn(str(heap.EXACT), info.source)
        self.assertEqual(heap._machine_types(program.entry.ret), ["f", "b", "f", "b"])
        self.assertFalse(program.fast_mixed)

    def test_zero_add_subtract_multiply_and_temporary_copies(self):
        program = generated(zero_operations, 4, -0.0, False)
        self.assertNotIn(str(heap.EXACT), program.entry.source)

    def test_repeated_compile_preserves_source_and_digest(self):
        program = generated(recursive_components, 4, 2.5, False)
        before = program.source, program.digest
        program.compile(ahead_of_time=_SourceOnly())
        self.assertEqual((program.source, program.digest), before)

    def test_nonzero_and_unknown_integer_returns_keep_guards(self):
        for fn, args in ((literal_nonzero, (4, 2.5)),
                         (recursive_nonzero, (4, 2.5, 0))):
            with self.subTest(function=fn.__name__):
                program = generated(fn, *args)
                self.assertIn(str(heap.EXACT), program.entry.source)

    def test_branch_loop_and_conditional_temporaries_keep_unknown_guards(self):
        for fn, tail in ((branch_unknown, False), (loop_unknown, 0),
                         (conditional_unknown, True)):
            with self.subTest(function=fn.__name__):
                program = generated(fn, 4, 2.5, 0, tail)
                self.assertIn(str(heap.EXACT), program.entry.source)

    def test_polymorphic_result_merge_keeps_unknown_guard(self):
        program = generated(polymorphic_unknown, [ZeroEmitter(), IntegerEmitter(0)], 2.5)
        self.assertIn(str(heap.EXACT), program.entry.source)

    def test_peek_restores_facts_before_reusing_temporary_numbers(self):
        program = generated(conditional_unknown, 4, 2.5, 0, True)
        gen = heap._Gen(program, program.entry)
        before = copy.copy(getattr(gen, "zero_codes", set()))
        node = program.entry.node.body[1].value
        gen.peek(node)
        self.assertEqual(getattr(gen, "zero_codes", set()), before)


class NativeTests(unittest.TestCase):
    def check_call(self, region, *args):
        expected_args = copy.deepcopy(args)
        expected = region.original(*expected_args)
        actual = region(*args)
        self.assertTrue(same(actual, expected), (actual, expected, region.problem, region.gave_up))
        return actual

    def test_direct_entry_types_signed_zero_large_float_nan_and_infinity(self):
        for native in (False, True):
            with self.subTest(native=native), patch.object(heap, "NATIVE", native):
                region = heap.lift_region(recursive_components)
                for value in (2.5, 0.0, -0.0, float(2**55), math.inf, math.nan):
                    for depth, empty in ((0, False), (1, False), (4, False), (4, True)):
                        self.check_call(region, depth, value, empty)
                self.assertEqual(region.fallback_calls, 0, (region.problem, region.gave_up))

    def test_zero_arithmetic_and_unknown_integer_fallback(self):
        region = heap.lift_region(zero_operations)
        for value in (-0.0, -2.5, math.inf):
            for empty in (False, True):
                self.check_call(region, 4, value, empty)
        self.assertEqual(region.fallback_calls, 0, region.problem)
        unknown = heap.lift_region(recursive_nonzero)
        self.check_call(unknown, 4, 2.5, 0)
        # An integer return beyond the mixed payload's exact range must bail out.
        self.check_call(unknown, 0, 2.5, 2**53 + 1)
        self.assertGreater(unknown.fallback_calls, 0)

    def test_alias_effects_and_division_failure_happen_once(self):
        for native in (False, True):
            with self.subTest(native=native), patch.object(heap, "NATIVE", native):
                region = heap.lift_region(effect_then_failure)
                box = EffectBox(5.0)
                self.assertEqual(region(box, box, 4, 2.5, 1.0), 2.5)
                self.assertEqual((box.calls, box.value), (1, 0.0))
                with self.assertRaises(ZeroDivisionError):
                    region(box, box, 4, 2.5, 0.0)
                self.assertEqual((box.calls, box.value), (2, 0.0))
                self.assertEqual(region.fallback_calls, 1)

    def test_unknown_local_and_polymorphic_integer_producers_remain_guarded(self):
        for fn, choice in ((branch_unknown, True), (loop_unknown, 1),
                           (conditional_unknown, False)):
            with self.subTest(function=fn.__name__):
                region = heap.lift_region(fn)
                self.check_call(region, 0, 2.5, 0, choice)
                self.check_call(region, 0, 2.5, 2**53 + 1, choice)
                self.assertEqual(region.compiled_calls, 1, region.problem)
                self.assertEqual(region.fallback_calls, 1)
        region = heap.lift_region(polymorphic_unknown)
        self.check_call(region, [ZeroEmitter(), IntegerEmitter(0)], -1.0)
        self.check_call(region, [ZeroEmitter(), IntegerEmitter(2**53 + 1)], -1.0)
        self.assertEqual(region.compiled_calls, 1, region.problem)
        self.assertEqual(region.fallback_calls, 1)

    def test_recursion_limit_still_falls_back(self):
        region = heap.lift_region(recursive_components)
        self.check_call(region, 4, 2.5, False)
        with self.assertRaises(RecursionError):
            region(10**6, 2.5, False)
        self.assertEqual(region.fallback_calls, 1)

    def test_real_llvm_removes_only_proved_integer_range_checks(self):
        with patch.object(heap, "_cached_module", lambda source: None):
            for fn, args, guarded in ((recursive_components, (4, 2.5, False), False),
                                      (recursive_nonzero, (4, 2.5, 0), True)):
                with self.subTest(function=fn.__name__):
                    region = heap.lift_region(fn)
                    self.check_call(region, *args)
                    self.assertEqual(region.compiled_calls, 1, region.problem)
                    llvm = region.latest.run.inspect_llvm(region.latest.run.signatures[0])
                    # LLVM spells the exact double threshold in scientific notation.
                    bound = r"9007199254740992|0x4340000000000000|9\.007199254740992[eE]\+15"
                    self.assertEqual(bool(re.search(bound, llvm)), guarded)

    def test_fresh_process_aot_reuse_preserves_types_without_numba(self):
        region = heap.lift_region(recursive_components)
        self.check_call(region, 4, 2.5, False)
        with tempfile.TemporaryDirectory(prefix="recompyler-zero-aot-") as folder:
            section = heap.build_regions([(("recursive_components", recursive_components.__code__.co_firstlineno),
                                           recursive_components, region)], folder)
            self.assertIsNotNone(section)
            plan = Path(folder, "artifact.json")
            plan.write_text(json.dumps(section), encoding="utf-8")
            env = dict(os.environ, PYTHONPATH=os.pathsep.join((str(Path(__file__).parent),
                                                              str(Path(heap.__file__).parents[1]))),
                       RECOMPYLER_CACHE=str(Path(folder, "cache")),
                       NUMBA_CACHE_DIR=str(Path(folder, "numba")))
            code = '''import json, math, sys
from recompyler import heap, aot
from recompyler.runner import _AotOnlyExports
from test_heap_zero_facts import recursive_components, same
section = json.load(open(sys.argv[1]))
entry = section['functions'][0]
module = aot.load(section)
exports = _AotOnlyExports({digest: getattr(module, export) for digest, export in entry['exports'].items()})
counts = []
for native in (False, True):
    heap.NATIVE = native
    region = heap.lift_region(recursive_components, exports, seeds=entry.get('seeds'))
    for args in ((0, 2.5, False), (4, -0.0, False), (4, 2.5, True),
                 (4, float(2**55), False), (1, math.nan, False)):
        assert same(region(*args), recursive_components(*args)), (args, region.problem)
    counts.append((region.aot_calls, region.jit_calls, region.fallback_calls))
assert 'numba' not in sys.modules
print(json.dumps(counts))
'''
            child = subprocess.run([sys.executable, "-c", code, str(plan)], env=env,
                                   capture_output=True, text=True, timeout=240)
            self.assertEqual(child.returncode, 0, child.stderr[-6000:])
            self.assertEqual(json.loads(child.stdout.splitlines()[-1]), [[5, 0, 0], [5, 0, 0]])


if __name__ == "__main__":
    unittest.main()
