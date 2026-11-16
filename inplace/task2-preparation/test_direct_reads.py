"""Fail-first direct-read behavior tests.

Preparation artifact only: move into tests/ after coordinator sends IMPLEMENT.
The execution counter is part of runtime observability, not a test-only switch.
"""
import math
import struct
import sys
import weakref

import pytest

from recompyler import heap


class Cell:
    def __init__(self, value):
        self.value = value


class Pair:
    def __init__(self, left, right):
        self.left = left
        self.right = right


class SlotsCell:
    __slots__ = ("value",)

    def __init__(self, value):
        self.value = value


def field_comparison(cell):
    return cell.value > 0.0


def field_value(cell):
    return cell.value


def list_total(values):
    total = 0.0
    for value in values:
        total += value
    return total


def list_first(values):
    return values[0]


def list_last(values):
    return values[len(values) - 1]


def alias_values(pair, values):
    return pair.left[0], pair.right[0], values[0]


def input_objects(pair):
    return pair, pair.left


def forwarded(value):
    return value


def field_through_call(cell):
    return forwarded(cell.value)


def field_through_phi(left, right, choose):
    value = left.value
    if choose:
        value = right.value
    return value


def field_through_loop(left, right, count):
    value = left.value
    for index in range(count):
        if index % 2 == 0:
            value = right.value
        else:
            value = left.value
    return value


def private_field_forward(cell):
    temporary = Cell(cell.value)
    return temporary.value


def one_producer_shared(cell):
    value = cell.value + 1.0
    return value, value


def distinct_equal_producers(cell):
    left = cell.value + 1.0
    right = cell.value + 1.0
    return left, right


def dynamic_producers(cell, count):
    first = cell.value
    last = cell.value
    for index in range(count):
        value = cell.value + 1.0
        if index == 0:
            first = value
        last = value
    return first, last


def unary_forward(cell):
    return +cell.value


def exact_float_forward(cell):
    return float(cell.value)


def scalar_arithmetic(cell):
    temporary = Cell(cell.value + 1.0)
    return temporary.value * temporary.value


def mixed_field(pair, choose):
    selected = pair.left if choose else pair.right
    return selected.value


def mutate_other_field(pair):
    value = pair.left
    pair.right += 1
    return value


def change_alias(cell):
    cell.value += 1.0


def transitive_alias_write(left, right):
    change_alias(right)
    return left.value


def append_alias(values):
    values.append(9.5)


def transitive_topology(left, right):
    append_alias(right)
    return left[len(left) - 1]


def shared_private_list(cell):
    value = cell.value
    result = [value, value]
    return result


def equal_existing_boxes(left, right):
    return left.value, right.value


def replacement_identity(pair, value):
    pair.left = value
    return pair.right, pair.left


class TestDirectReads:
    def call_direct(self, fn, *args):
        region = heap.Region(fn)
        actual = region(*args)
        assert region.compiled_calls == 1, region.problem
        assert region.direct_calls == 1, getattr(region, "direct_problem", None)
        return region, actual

    def test_whole_pure_field_and_comparison(self):
        region, actual = self.call_direct(field_comparison, Cell(1.25))
        assert actual is True
        assert region.fallback_calls == 0

    def test_whole_numeric_list_reader(self):
        _, actual = self.call_direct(list_total, [1.25, 2.5, -0.5])
        assert actual == 3.25

    def test_record_list_argument_aliases_preserve_boxes(self):
        number = float("7.25")
        values = [number]
        pair = Pair(values, values)
        _, actual = self.call_direct(alias_values, pair, values)
        assert len(actual) == 3
        assert all(value is number for value in actual)
        assert pair.left is pair.right is values

    def test_returned_input_record_and_list_are_originals(self):
        values = [float("7.25")]
        pair = Pair(values, values)
        _, actual = self.call_direct(input_objects, pair)
        assert actual[0] is pair
        assert actual[1] is values

    @pytest.mark.parametrize("value", [
        float("7.25"), float("-0.0"), float("nan"),
        int("9007199254740993"), int("-9223372036854775808"),
        int("9223372036854775807"),
    ])
    @pytest.mark.parametrize("record", [Cell, SlotsCell])
    def test_numeric_field_return_preserves_original_box(self, value, record):
        _, actual = self.call_direct(field_value, record(value))
        assert actual is value
        assert type(actual) is type(value)
        if type(value) is float:
            assert struct.pack("d", actual) == struct.pack("d", value)

    @pytest.mark.parametrize("value", [
        float("-0.0"), float("nan"), int("9007199254740993"),
        int("-9223372036854775808"), int("9223372036854775807"),
    ])
    def test_numeric_list_return_preserves_original_box(self, value):
        _, actual = self.call_direct(list_first, [value])
        assert actual is value

    def test_distinct_equal_inputs_are_not_coalesced(self):
        left, right = float("7.25"), float("7.25")
        assert left == right and left is not right
        _, actual = self.call_direct(equal_existing_boxes, Cell(left), Cell(right))
        assert actual[0] is left
        assert actual[1] is right
        assert actual[0] is not actual[1]

    @pytest.mark.parametrize("choose", [False, True])
    def test_phi_forwards_selected_numeric_identity(self, choose):
        left, right = Cell(float("7.25")), Cell(float("7.25"))
        _, actual = self.call_direct(field_through_phi, left, right, choose)
        assert actual is (right.value if choose else left.value)

    @pytest.mark.parametrize("count", [0, 1, 2, 3])
    def test_loop_forwards_dynamic_numeric_identity(self, count):
        left, right = Cell(float("7.25")), Cell(float("7.25"))
        _, actual = self.call_direct(field_through_loop, left, right, count)
        expected = right.value if count % 2 else left.value
        assert actual is expected

    @pytest.mark.parametrize("fn", [field_through_call, private_field_forward])
    def test_call_and_virtual_field_forward_identity(self, fn):
        value = float("7.25")
        region, actual = self.call_direct(fn, Cell(value))
        assert actual is value
        if fn is private_field_forward:
            assert region.latest.scalar_report["removed_sites"]

    def test_one_dynamic_arithmetic_result_keeps_sharing(self):
        _, actual = self.call_direct(one_producer_shared, Cell(float("7.25")))
        assert actual == (8.25, 8.25)
        assert actual[0] is actual[1]

    def test_distinct_arithmetic_definitions_do_not_merge_equal_results(self):
        _, actual = self.call_direct(distinct_equal_producers, Cell(float("7.25")))
        assert actual == (8.25, 8.25)
        assert actual[0] is not actual[1]

    def test_loop_producer_uses_dynamic_identity(self):
        _, actual = self.call_direct(dynamic_producers, Cell(float("7.25")), 2)
        assert actual == (8.25, 8.25)
        assert actual[0] is not actual[1]

    @pytest.mark.parametrize("value", [float("7.25"), int("9007199254740993")])
    def test_unary_plus_forwards_exact_numeric_identity(self, value):
        _, actual = self.call_direct(unary_forward, Cell(value))
        assert actual is value

    def test_float_of_exact_float_forwards_identity(self):
        value = float("7.25")
        _, actual = self.call_direct(exact_float_forward, Cell(value))
        assert actual is value

    def test_mixed_payload_tag_and_identity_come_from_one_box(self):
        integer = int("1048577")
        floating = float("-0.0")
        pair = Pair(Cell(integer), Cell(floating))
        for choose, expected in [(True, integer), (False, floating)]:
            region, actual = self.call_direct(mixed_field, pair, choose)
            assert actual is expected
            assert type(actual) is type(expected)
            assert region.latest.saw_mixed

    def test_out_of_int64_domain_replays_without_rounding(self):
        value = int("9223372036854775808")
        region = heap.Region(field_value)
        assert region(Cell(value)) is value
        assert region.direct_calls == 0

    def test_scalar_replacement_still_runs_on_executed_direct_path(self):
        region, actual = self.call_direct(scalar_arithmetic, Cell(2.5))
        assert actual == 12.25
        assert region.latest.scalar_report["removed_sites"]

    def test_identity_tokens_follow_private_list_items(self):
        value = float("7.25")
        _, actual = self.call_direct(shared_private_list, Cell(value))
        assert actual == [7.25, 7.25]
        assert actual[0] is actual[1] is value

    def test_readonly_location_in_mutating_region(self):
        value = float("7.25")
        pair = Pair(value, 3)
        _, actual = self.call_direct(mutate_other_field, pair)
        assert actual is value
        assert pair.left is value
        assert pair.right == 4

    def test_transitive_write_through_alias_is_never_stale(self):
        cell = Cell(2.5)
        region = heap.Region(transitive_alias_write)
        actual = region(cell, cell)
        assert actual == 3.5
        assert cell.value == 3.5
        assert region.direct_calls == 0

    def test_transitive_list_resize_through_alias_is_never_stale(self):
        values = [2.5]
        region = heap.Region(transitive_topology)
        actual = region(values, values)
        assert actual == 9.5
        assert values == [2.5, 9.5]
        assert region.direct_calls == 0

    def test_arena_writeback_preserves_equal_replacement_identity(self):
        previous, replacement = float("7.25"), float("7.25")
        pair = Pair(previous, previous)
        _, actual = self.call_direct(replacement_identity, pair, replacement)
        assert actual[0] is previous
        assert actual[1] is replacement
        assert pair.left is replacement
        assert pair.right is previous

    def test_descriptor_change_after_preparation_is_observed(self):
        cell = Cell(2.5)
        region, _ = self.call_direct(field_value, cell)
        calls = region.direct_calls
        observed = []
        replacement = float("91.25")

        def read(instance):
            observed.append(instance)
            return replacement

        Cell.value = property(read)
        try:
            assert region(cell) is replacement
            assert region.direct_calls == calls
            assert observed == [cell]
        finally:
            del Cell.value

    def test_list_reallocation_after_preparation_reads_current_storage(self):
        values = [float("2.5")]
        region, _ = self.call_direct(list_last, values)
        values.extend(float(index) for index in range(1024))
        last = float("91.25")
        values.append(last)
        calls = region.direct_calls
        assert region(values) is last
        assert region.direct_calls == calls + 1

    def test_final_c_walk_observes_mutation_from_profile_callback(self):
        cell = Cell(float("2.5"))
        region, _ = self.call_direct(field_value, cell)
        native_entry = heap._native.direct_execute
        original_profile = sys.getprofile()
        replacement = float("91.25")
        mutated = []

        def profile(frame, event, arg):
            if event == "c_call" and arg is native_entry and not mutated:
                mutated.append(True)
                cell.value = replacement

        calls = region.direct_calls
        try:
            sys.setprofile(profile)
            actual = region(cell)
        finally:
            sys.setprofile(original_profile)
        assert mutated == [True], "the test must reach the final native boundary"
        assert actual is replacement
        assert cell.value is replacement
        assert region.direct_calls in (calls, calls + 1)

    def test_final_c_walk_observes_late_list_resize(self):
        values = [float("2.5")]
        region, _ = self.call_direct(list_last, values)
        native_entry = heap._native.direct_execute
        original_profile = sys.getprofile()
        replacement = float("91.25")
        mutated = []

        def profile(frame, event, arg):
            if event == "c_call" and arg is native_entry and not mutated:
                mutated.append(True)
                values.extend([0.0] * 1024)
                values.append(replacement)

        calls = region.direct_calls
        try:
            sys.setprofile(profile)
            actual = region(values)
        finally:
            sys.setprofile(original_profile)
        assert mutated == [True], "the test must reach the final native boundary"
        assert actual is replacement
        assert region.direct_calls in (calls, calls + 1)

    def test_borrowed_owner_is_neither_copied_nor_retained_after_call(self):
        callbacks = []
        cell = Cell(float("2.5"))
        reference = weakref.ref(cell, lambda ref: callbacks.append(ref))
        _, actual = self.call_direct(field_comparison, cell)
        assert actual is True
        assert callbacks == []
        del cell
        assert reference() is None
        assert callbacks == [reference]

    def test_late_class_hook_declines_without_extra_hook_calls(self):
        cell = Cell(float("2.5"))
        region, _ = self.call_direct(field_value, cell)
        replacement = float("91.25")
        seen = []

        def read(instance, name):
            if name == "value":
                seen.append(name)
                return replacement
            return object.__getattribute__(instance, name)

        calls = region.direct_calls
        Cell.__getattribute__ = read
        try:
            actual = region(cell)
            assert actual is replacement
            assert region.direct_calls == calls
            assert seen == ["value"]
        finally:
            del Cell.__getattribute__




GLOBAL_NUMBER = float("37.125")
DEFAULT_NUMBER = float("38.125")


def guarded_global(cell):
    if cell.value > 0:
        return GLOBAL_NUMBER
    return cell.value


def guarded_default(cell, value=DEFAULT_NUMBER):
    if cell.value > 0:
        return value
    return cell.value


def guarded_constant(cell):
    if cell.value > 0:
        return 1234.56789
    return cell.value


def nested_value(pair):
    return pair.left.value


class FinalizingCell:
    events = []

    def __init__(self, value):
        self.value = value

    def __del__(self):
        type(self).events.append("finalized")


class TestDirectOriginAndLifetime:
    call_direct = TestDirectReads.call_direct
    def test_global_return_uses_original_box_and_identity_guard(self):
        global GLOBAL_NUMBER
        cell = Cell(1.0)
        original = GLOBAL_NUMBER
        region, actual = self.call_direct(guarded_global, cell)
        assert actual is original
        replacement = float("37.125")
        assert replacement == original and replacement is not original
        GLOBAL_NUMBER = replacement
        try:
            assert region(cell) is replacement
        finally:
            GLOBAL_NUMBER = original

    def test_default_return_uses_original_box(self):
        _, actual = self.call_direct(guarded_default, Cell(1.0))
        assert actual is DEFAULT_NUMBER

    def test_constant_return_uses_original_code_constant(self):
        cell = Cell(1.0)
        expected = guarded_constant(cell)
        _, actual = self.call_direct(guarded_constant, cell)
        assert actual is expected

    def test_finalizer_shape_declines_without_copying_or_extra_finalization(self):
        FinalizingCell.events.clear()
        cell = FinalizingCell(float("2.5"))
        reference = weakref.ref(cell)
        region = heap.Region(field_value)
        actual = region(cell)
        assert actual is cell.value
        assert region.direct_calls == 0
        assert FinalizingCell.events == []
        del cell
        assert reference() is None
        assert FinalizingCell.events == ["finalized"]

    def test_late_hook_and_detach_do_not_delay_nested_finalizer(self):
        pair = Pair(Cell(float("2.5")), Cell(float("3.5")))
        region, _ = self.call_direct(nested_value, pair)
        old = weakref.ref(pair.left)
        native_entry = heap._native.direct_execute
        original_profile = sys.getprofile()
        events = []

        def finalize(instance):
            events.append("finalized")

        def profile(frame, event, arg):
            if event == "c_call" and arg is native_entry and not events:
                events.append("enter")
                Cell.__del__ = finalize
                pair.left = pair.right
                events.append("leave")

        try:
            sys.setprofile(profile)
            actual = region(pair)
        finally:
            sys.setprofile(original_profile)
            if "__del__" in vars(Cell):
                del Cell.__del__
        assert events == ["enter", "finalized", "leave"]
        assert old() is None
        assert actual is pair.right.value




def choose_min(left, right):
    return min(left.value, right.value)


def choose_max(left, right):
    return max(left.value, right.value)


def positive_integer_abs(cell):
    return abs(cell.value)


def call_constant_one(cell):
    if cell.value > 0:
        return 4321.12345
    return 0.0


def call_constant_two(cell):
    if cell.value > 0:
        return 4321.12345
    return 0.0


def two_function_constants(cell):
    return call_constant_one(cell), call_constant_two(cell)


class TestDemandedProducerIdentity:
    call_direct = TestDirectReads.call_direct

    @pytest.mark.parametrize("fn", [choose_min, choose_max])
    def test_min_max_equal_values_keep_first_operand(self, fn):
        left = Cell(float("7.25"))
        right = Cell(float("7.25"))
        assert left.value is not right.value
        _, actual = self.call_direct(fn, left, right)
        assert actual is left.value

    def test_positive_integer_abs_uses_exact_producer_recipe(self):
        value = int("9007199254740993")
        expected = positive_integer_abs(Cell(value))
        _, actual = self.call_direct(positive_integer_abs, Cell(value))
        assert actual is expected

    def test_callee_constant_folding_preserves_each_original_origin(self):
        cell = Cell(1.0)
        expected = two_function_constants(cell)
        _, actual = self.call_direct(two_function_constants, cell)
        assert actual[0] is expected[0]
        assert actual[1] is expected[1]
        assert (actual[0] is actual[1]) == (expected[0] is expected[1])



def arithmetic_consumer(cell):
    return cell.value * cell.value


def arithmetic_only_clone(root):
    temporary = Cell(root.value)
    return arithmetic_consumer(temporary)


class TestDemandedCloneABI:
    call_direct = TestDirectReads.call_direct

    def test_arithmetic_only_clone_parameters_have_no_identity_tokens(self):
        region, actual = self.call_direct(arithmetic_only_clone, Cell(3.5))
        assert actual == 12.25
        program = region.latest
        assert program.scalar_report["removed_sites"]
        clones = [info for info in program.order
                  if info.name.startswith("sr")
                  and info.fn is arithmetic_consumer]
        assert clones, "this case must exercise a real scalar field clone"
        counts = program.direct_report["identity"]["parameter_tokens"]
        assert all(counts[info.name] == 0 for info in clones)


