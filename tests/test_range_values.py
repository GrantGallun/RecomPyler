"""Range value semantics under S49: exact types/values; numeric identity exempt."""
import struct
import pytest
from recompyler.heap import lift_region


def assigned(n):
    values = {0: 0}
    r = range(n)
    for i in r:
        values[0] += i
    return values


def repeated(r):
    total = 0
    for i in r:
        total += i
    for i in r:
        total += i
    return total


def consume(r):
    total = 0
    for i in r:
        total += i
    return total


def forward(r):
    return consume(r)


def make_range(n):
    return range(n)


def constructed_argument(n):
    r = range(n)
    return forward(r)


def internal_return(n):
    r = make_range(n)
    total = consume(r)
    return total + consume(r)


def break_and_repeat(r):
    total = 0
    for i in r:
        total += i
        break
    for j in r:
        total += j
        break
    return total


def nested_alias(r):
    alias = r
    total = 0
    for i in r:
        for j in alias:
            total += i + j
    return total


def length(r):
    return len(r)


def indexed(r, index):
    return r[index]


def contains(r, query):
    return query in r


def unused_zero_step(x):
    r = range(5, 5, 0)
    return x + 1


def construction_after_effect(values):
    r = range(values.pop(), values.pop(), values.pop())
    return len(r)


def checked_after_private_mutation(values, start, stop, step):
    values.append(9)
    r = range(start, stop, step)
    return len(r)


def selected_range(r):
    return r


def range_tuple(r):
    return (r,)


def range_list(r):
    return [r]


def range_dict(r):
    return {0: r}


def range_store(r, values):
    values.append(r)
    return None


def range_identity(r, other):
    return r is other


def explicit_iterator(r):
    it = iter(r)
    return next(it) + next(it)


def exact_value(got, want):
    assert type(got) is type(want)
    if type(want) is float:
        assert struct.pack('!d', got) == struct.pack('!d', want)
    elif type(want) in (list, tuple):
        assert len(got) == len(want)
        for left, right in zip(got, want):
            exact_value(left, right)
    elif type(want) is dict:
        assert len(got) == len(want)
        for (gk, gv), (wk, wv) in zip(got.items(), want.items()):
            exact_value(gk, wk)
            exact_value(gv, wv)
    elif want is None or type(want) is bool:
        assert got is want
    else:
        assert got == want


def native(fn, *args):
    compiled = lift_region(fn)
    want = fn(*args)
    got = compiled(*args)
    exact_value(got, want)
    assert compiled.compiled_calls == 1, compiled.problem
    return compiled


@pytest.mark.parametrize('n', [0, 1, 6, -6])
def test_assigned_range_native(n):
    native(assigned, n)


@pytest.mark.parametrize('r', [range(0), range(1), range(6), range(7, -2, -3), range(-7, 3, 2), range(7, 2, 3), range(2, 7, -3)])
@pytest.mark.parametrize('fn', [consume, repeated, forward, break_and_repeat, nested_alias])
def test_argument_iteration_reuse_and_internal_calls_native(fn, r):
    native(fn, r)


@pytest.mark.parametrize('fn', [constructed_argument, internal_return])
def test_constructed_range_passes_between_functions(fn):
    native(fn, 7)


@pytest.mark.parametrize('r', [range(0), range(7, -5, -3), range(-(2**63), -(2**63)+1), range(2**63-2, 2**63-1, 2**63-1)])
def test_length_uses_safe_count(r):
    native(length, r)


@pytest.mark.parametrize('r,index', [(range(1, 9, 2), 0), (range(1, 9, 2), -1), (range(9, 0, -2), 2), (range(3), True)])
def test_indexing_matches_type_value(r, index):
    native(indexed, r, index)


@pytest.mark.parametrize('index', [3, -4, 2**100, None, 1.5])
def test_index_failure_keeps_exact_exception(index):
    r = range(3)
    with pytest.raises(Exception) as reference:
        indexed(r, index)
    compiled = lift_region(indexed)
    with pytest.raises(type(reference.value)) as actual:
        compiled(r, index)
    assert actual.value.args == reference.value.args
    assert compiled.fallback_calls == 1


@pytest.mark.parametrize('r,query', [(range(0), 0), (range(1, 9, 2), 7), (range(1, 9, 2), 8), (range(9, 0, -2), 3), (range(3), True)])
def test_integer_membership_native(r, query):
    native(contains, r, query)


def test_zero_step_is_checked_at_construction_even_unused():
    compiled = lift_region(unused_zero_step)
    with pytest.raises(ValueError) as reference:
        unused_zero_step(3)
    with pytest.raises(ValueError) as actual:
        compiled(3)
    assert actual.value.args == reference.value.args == ('range() arg 3 must not be zero',)
    assert compiled.fallback_calls == 1


def test_constructor_argument_effects_order_before_zero_step():
    values = [0, 5, 5]
    compiled = lift_region(construction_after_effect)
    with pytest.raises(ValueError) as actual:
        compiled(values)
    assert actual.value.args == ('range() arg 3 must not be zero',)
    assert values == []
    assert compiled.fallback_calls == 1


@pytest.mark.parametrize('r', [range(2**100), range(-(2**63), 2**63-1), range(0, 1, -(2**63)), range(2**100, 0)])
def test_huge_or_unproved_ranges_decline_exactly(r):
    compiled = lift_region(length)
    try:
        want = length(r)
    except Exception as reference:
        with pytest.raises(type(reference)) as actual:
            compiled(r)
        assert actual.value.args == reference.args
    else:
        assert compiled(r) == want
    assert compiled.fallback_calls == 1


def test_guard_miss_after_private_mutation_replays_once_preserving_owners():
    owner = int('10000')
    values = [owner]
    compiled = lift_region(checked_after_private_mutation)
    assert compiled(values, 2**100, 0, 1) == 0
    assert values == [owner, 9] and values[0] is owner
    assert compiled.fallback_calls == 1


def test_warmed_range_argument_checks_current_bounds_each_call():
    compiled = lift_region(consume)
    for r in [range(3), range(1, 8, 2), range(8, -2, -3), range(0)]:
        assert compiled(r) == consume(r)
    assert compiled.compiled_calls == 4, compiled.problem
    assert compiled(range(2**100, 0)) == 0
    assert compiled.fallback_calls == 1


@pytest.mark.parametrize('fn', [selected_range, range_tuple, range_list, range_dict])
def test_public_range_escape_keeps_original_owner(fn):
    r = range(10000, 10003)
    compiled = lift_region(fn)
    got = compiled(r)
    selected = got if fn is selected_range else got[0]
    assert selected is r
    assert compiled.fallback_calls == 1


def test_borrowed_store_of_range_is_python_and_keeps_alias():
    r, values = range(3), []
    compiled = lift_region(range_store)
    assert compiled(r, values) is None
    assert values == [r] and values[0] is r
    assert compiled.fallback_calls == 1


def test_range_identity_is_not_bound_equality():
    r, other = range(3), range(3)
    compiled = lift_region(range_identity)
    assert compiled(r, r) is True
    assert compiled(r, other) is False
    assert compiled.fallback_calls == 2


def test_explicit_iterator_is_not_restarted():
    compiled = lift_region(explicit_iterator)
    assert compiled(range(2, 8, 2)) == 6
    assert compiled.fallback_calls == 1


def test_custom_membership_query_is_not_speculated():
    events = []
    class Query:
        def __eq__(self, other):
            events.append(other)
            return other == 2
    compiled = lift_region(contains)
    assert compiled(range(4), Query()) is True
    assert events == [0, 1, 2]
    assert compiled.fallback_calls == 1
    events.clear()
    assert compiled(range(0), Query()) is False
    assert events == []


@pytest.mark.parametrize('query', [1.0, complex(1, 0)])
def test_noninteger_membership_stays_python(query):
    compiled = lift_region(contains)
    assert compiled(range(3), query) is True
    assert compiled.fallback_calls == 1

# Additional reviewer cases: these guard exact owners, never infer from equality.
def first_range(r):
    for x in r:
        return x
    return None


def constructed_first(start, stop, step):
    r = range(start, stop, step)
    for x in r:
        return x
    return None


def ignored_range(n):
    r = range(n)
    return n


def repeated_number_owner(r):
    for x in r:
        return [x, x]
    return []


@pytest.mark.parametrize('r', [range(2**40,2**40+1),range(10000,10001,2**40),range(2**31-2,2**31-1,3)])
def test_long_iterator_first_value_has_exact_integer_type_value(r):
    reference = first_range(r)
    assert reference is r.start
    compiled = lift_region(first_range)
    got = compiled(r)
    assert type(got) is int and got == reference
    assert compiled.compiled_calls == 1, compiled.problem


def test_constructed_long_iterator_returns_exact_integer_value():
    start = int('1099511627776')
    compiled = lift_region(constructed_first)
    got = compiled(start,start+1,1)
    assert type(got) is int and got == start
    assert compiled.compiled_calls == 1, compiled.problem


def test_unused_range_returns_exact_integer_value():
    n = int('10000')
    compiled = lift_region(ignored_range)
    got = compiled(n)
    assert type(got) is int and got == n
    assert compiled.compiled_calls == 1, compiled.problem


def test_two_stores_of_one_iteration_value_have_exact_integer_values():
    compiled = lift_region(repeated_number_owner)
    got = compiled(range(10000,10001))
    assert type(got) is list and got == [10000,10000]
    assert all(type(x) is int for x in got)
    assert compiled.compiled_calls == 1, compiled.problem

def two_ranges(a, r, b, s, c):
    return a + consume(r) + b + consume(s) + c


def choose_range(n, choose):
    if choose:
        r = range(n)
    else:
        r = range(n, 0, -1)
    return consume(r)


def construction_order(start, stop, step):
    r = range(start, stop, step)
    return len(r)


def successful_effect_order(values):
    r = range(values.pop(), values.pop(), values.pop())
    return consume(r)


def nested_public_range(r):
    return ([r],)


def input_aggregate(values):
    return len(values)


@pytest.mark.parametrize('choose', [False, True])
def test_range_branch_join_and_multiple_flat_parameters(choose):
    native(choose_range, 6, choose)
    native(two_ranges, 10, range(4), 20, range(7, 1, -2), 30)


def test_successful_constructor_evaluates_every_argument_once_in_order():
    values = [2, 9, 1]
    compiled = lift_region(successful_effect_order)
    assert compiled(values) == 16
    assert values == []
    assert compiled.compiled_calls == 1, compiled.problem


def test_custom_index_conversion_order_is_original_once():
    events = []
    class Index:
        def __init__(self, label, value):
            self.label, self.value = label, value
        def __index__(self):
            events.append(self.label)
            return self.value
    compiled = lift_region(construction_order)
    assert compiled(Index('start', 1), Index('stop', 9), Index('step', 2)) == 4
    assert events == ['start', 'stop', 'step']
    assert compiled.fallback_calls == 1


@pytest.mark.parametrize('start,stop,step', [(2**63-1,-2**63,1),(-2**63,2**63-1,-1)])
def test_runtime_span_miss_after_native_private_append_replays_once(start, stop, step):
    compiled = lift_region(checked_after_private_mutation)
    warm = []
    assert compiled(warm, 0, 3, 1) == 3 and warm == [9]
    assert compiled.compiled_calls == 1, compiled.problem
    owner = int('10000')
    values = [owner]
    assert compiled(values, start, stop, step) == 0
    assert values == [owner, 9] and values[0] is owner
    assert compiled.fallback_calls == 1


def test_deep_public_range_and_aggregate_input_are_refused():
    r = range(3)
    compiled = lift_region(nested_public_range)
    got = compiled(r)
    assert got[0][0] is r and compiled.fallback_calls == 1
    for values in [(r,), [r]]:
        compiled = lift_region(input_aggregate)
        assert compiled(values) == 1 and compiled.fallback_calls == 1


@pytest.mark.parametrize('query', [float('nan'), float('inf'), -float('inf'), 2**100, -(2**100)])
def test_unproved_membership_queries_replay_exact_result(query):
    compiled = lift_region(contains)
    got = compiled(range(-3, 5, 2), query)
    assert type(got) is bool and got == contains(range(-3, 5, 2), query)
    assert compiled.fallback_calls == 1


def test_numpy_index_and_membership_keep_python_kinds():
    import numpy as np
    r = range(1, 9, 2)
    for fn, value in [(indexed,np.int64(-1)),(contains,np.int64(3)),(contains,np.float64(3))]:
        compiled = lift_region(fn)
        got, want = compiled(r,value), fn(r,value)
        assert type(got) is type(want) and got == want
        assert compiled.fallback_calls == 1


def numeric_is(n):
    r = range(1)
    return n is n


def numeric_is_not(n, other):
    r = range(1)
    return n is not other


def numeric_id(n):
    r = range(1)
    return id(n)


def identity_helper(n):
    return n is n


def transitive_numeric_identity(n):
    r = range(1)
    return identity_helper(n)


@pytest.mark.parametrize('fn', [numeric_is, numeric_is_not, numeric_id, transitive_numeric_identity])
def test_numeric_identity_observers_stay_python(fn):
    n = int('10000')
    args = (n, int('10000')) if fn is numeric_is_not else (n,)
    wrapped = lift_region(fn)
    got = wrapped(*args)
    want = fn(*args)
    assert type(got) is type(want) and got == want
    assert wrapped.fallback_calls == 1


def bool_result(r):
    for x in r:
        return True
    return False


def test_boolean_results_keep_singleton_identity():
    wrapped = lift_region(bool_result)
    assert wrapped(range(1)) is True
    assert wrapped(range(0)) is False
    assert wrapped.compiled_calls == 2, wrapped.problem
