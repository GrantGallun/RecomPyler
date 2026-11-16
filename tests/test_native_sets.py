"""Strict set reuse: native success must not lose Python aliases or effects."""
import pytest
from recompyler.lift import lift


def difference(a, b):
    return a - b


def subset(a, b):
    return a <= b


def chain(a, b):
    return a == b == a


def local_copy(x):
    a = {1, 2, x}
    return a.copy()


def local_union(x):
    a = {1, 2}
    return a.union({x, 3})


def disjoint(a, b):
    return a.isdisjoint(b)


def selected(a):
    return a


def mutate(a, b):
    a.update(b)
    return a


def iterate(a):
    for x in a:
        return x
    return 0

def difference_size(a, b):
    return len(a - b)


def local_copy_size(x):
    a = {1, 2, x}
    return len(a.copy())


def local_union_size(x):
    a = {1, 2}
    return len(a.union({x, 3}))


def local_update_size(x):
    y = {1, 2}
    y.update({2, x})
    return len(y)


def local_summary(x):
    y = {1, 2, x}
    return len(y.copy()), y.issubset({1, 2, 3, 4})


@pytest.mark.parametrize('fn,args,want', [
    (difference_size, ({1, 2}, {2, 3}), 1),
    (subset, ({1, 2}, {1, 2, 3}), True),
    (chain, ({1, 2}, {2, 1}), True),
    (local_copy_size, (3,), 3),
    (local_union_size, (4,), 4),
    (disjoint, ({1, 2}, {3, 4}), True),
])
def test_pure_set_operation_runs_natively(fn, args, want):
    compiled = lift(fn)
    assert compiled(*args) == want
    assert compiled.compiled_calls == 1, compiled.problem
    assert type(compiled(*args)) is type(want)


def test_python_set_materialization_keeps_element_identity():
    compiled = lift(local_copy)
    result = compiled(7)
    assert result == {1, 2, 7}
    cached = 7
    assert next(x for x in result if x == cached) is cached
    assert compiled.fallback_calls == 1


@pytest.mark.parametrize('a,b', [({1000}, {2}), ({2**100}, {2}), ({True}, {2}), (set(), {2}), ({2}, set())])
def test_unrepresented_elements_or_empty_input_fall_back(a, b):
    compiled = lift(difference)
    assert compiled(a, b) == a - b
    assert compiled.fallback_calls == 1


def test_selected_input_keeps_set_identity():
    compiled = lift(selected)
    a = {1, 2}
    assert compiled(a) is a
    assert compiled.fallback_calls == 1


def test_input_mutation_is_original_python_once():
    compiled = lift(mutate)
    a = {1, 2}
    assert compiled(a, {3}) is a
    assert a == {1, 2, 3}
    assert compiled.fallback_calls == 1


def test_set_iteration_keeps_python_order():
    compiled = lift(iterate)
    a = {1, 2, 3}
    assert compiled(a) == iterate(a)
    assert compiled.fallback_calls == 1
    assert compiled.problem


def test_subclass_effect_is_not_speculated():
    events = []
    class Special(set):
        def __sub__(self, other):
            events.append('sub')
            return 42
    compiled = lift(difference)
    assert compiled(Special({1}), {2}) == 42
    assert events == ['sub']
    assert compiled.fallback_calls == 1

def listed(a):
    return list(a)


def comprehension(a):
    return [x for x in a]


def enumerated(a):
    result = []
    for i, x in enumerate(a):
        result.append(x)
    return result


@pytest.mark.parametrize('fn', [listed, comprehension, enumerated])
def test_iteration_consumers_preserve_original_traversal(fn):
    a = {-5, -4, -3, -2, -1, 0, 1, 2, 32, 64, 96, 128, 160, 192, 224, 256}
    a.remove(32)
    a.add(32)
    compiled = lift(fn)
    for _ in range(2):
        assert compiled(a) == fn(a)
    assert compiled.compiled_calls == 0
    assert compiled.fallback_calls == 2

def mixed_chain(a, b):
    return a < b < 1


def alias_branch(a, flag):
    if flag:
        result = a.copy()
    else:
        result = a
    return result


class Holder:
    def __init__(self, values):
        self.values = values
    def copy(self):
        return self.values
    def __sub__(self, other):
        return self.values


def record_copy(obj):
    return obj.copy()


def record_sub(obj, other):
    return obj - other


@pytest.mark.parametrize('fn,args', [(record_copy, (Holder({1, 2}),)), (record_sub, (Holder({1, 2}), 1))])
def test_polymorphic_set_result_keeps_record_field_identity(fn, args):
    compiled = lift(fn)
    assert compiled(*args) is args[0].values


def test_phi_cannot_hide_selected_input_set():
    compiled = lift(alias_branch)
    a = {1, 2}
    assert compiled(a, False) is a
    assert compiled(a, True) == a
    assert compiled.fallback_calls == 2


def test_mixed_set_chain_is_named_decline():
    compiled = lift(mixed_chain)
    with pytest.raises(TypeError):
        compiled({1}, {1, 2})
    assert compiled.fallback_calls == 1
    assert compiled.problem


def test_selected_input_decline_has_reason():
    compiled = lift(selected)
    a = {1}
    assert compiled(a) is a
    assert compiled.problem

def nested_alias(a):
    return (a, [a, a])


def local_listed(x):
    return list({x, 32, 64, 128, 256, -1, -2})


def test_nested_selected_aliases_survive_decline():
    a = {1, 2}
    compiled = lift(nested_alias)
    result = compiled(a)
    assert result[0] is result[1][0] is result[1][1] is a
    assert compiled.fallback_calls == 1
    assert compiled.problem


def test_local_set_traversal_also_declines():
    compiled = lift(local_listed)
    assert compiled(1) == local_listed(1)
    assert compiled.fallback_calls == 1
    assert compiled.problem


@pytest.mark.xfail(strict=True, reason='open managed set-element and table-state provenance for escaping results')
def test_general_integer_elements_keep_identity_natively():
    compiled = lift(difference)
    value = int('10000')
    result = compiled({value}, {2})
    assert next(iter(result)) is value
    assert compiled.compiled_calls == 1


@pytest.mark.xfail(strict=True, reason='open mutable input-set ownership and write-back analysis')
def test_mutable_input_set_is_native_and_keeps_identity():
    compiled = lift(mutate)
    a = {1, 2}
    assert compiled(a, {3}) is a
    assert compiled.compiled_calls == 1

def local_tuple(x):
    y = {1, 2, x}
    result = y.copy()
    return result, y


def local_update(x):
    y = {1, 2}
    result = y.update({2, x})
    return result, y


def local_alias_tuple(x):
    y = {1, 2, x}
    return y, y


def test_distinct_local_set_results_are_materialized_in_python():
    compiled = lift(local_tuple)
    result = compiled(3)
    assert result == ({1, 2, 3}, {1, 2, 3})
    assert result[0] is not result[1]
    assert compiled.fallback_calls == 1


def test_escaping_local_set_mutation_is_python():
    compiled = lift(local_update)
    assert compiled(3) == (None, {1, 2, 3})
    assert compiled.fallback_calls == 1


def test_repeated_fresh_set_result_keeps_alias():
    compiled = lift(local_alias_tuple)
    result = compiled(3)
    assert result[0] is result[1]
    assert compiled.fallback_calls == 1

def copied(a):
    return a.copy()


def optional_selected(a, flag, missing):
    return a if flag else missing


def optional_tuple(a, flag, missing):
    return (a if flag else missing,)


def collision_local(x):
    return {x, -5, -4, -3, -2, -1, 0, 1, 2, 32, 64, 96, 128, 160, 192, 224, 256}


def pop_sequence(value):
    result = []
    while value:
        result.append(value.pop())
    return result


@pytest.mark.parametrize('fn', [copied, difference])
def test_escaped_set_external_traversal_matches_python(fn):
    a = {-5, -4, -3, -2, -1, 0, 1, 2, 32, 64, 96, 128, 160, 192, 224, 256}
    a.remove(32)
    a.add(32)
    args = (a,) if fn is copied else (a, {1, 2})
    compiled = lift(fn)
    for _ in range(2):
        assert list(compiled(*args)) == list(fn(*args))
        assert pop_sequence(compiled(*args)) == pop_sequence(fn(*args))
        assert repr(compiled(*args)) == repr(fn(*args))


def test_local_set_external_traversal_matches_python():
    compiled = lift(collision_local)
    assert list(compiled(3)) == list(collision_local(3))
    assert pop_sequence(compiled(3)) == pop_sequence(collision_local(3))


@pytest.mark.parametrize('fn', [optional_selected, optional_tuple])
def test_optional_set_does_not_lose_selected_identity(fn):
    a = {1, 2}
    compiled = lift(fn)
    result = compiled(a, True, None)
    assert (result[0] if fn is optional_tuple else result) is a
    result = compiled(a, False, None)
    assert (result[0] if fn is optional_tuple else result) is None
    assert compiled.fallback_calls == 2


def missing_after_effect(a, value):
    a.append(7)
    y = {1, 2}
    y.remove(value)
    return len(a)


def test_error_after_private_copy_effect_replays_python_once():
    compiled = lift(missing_after_effect)
    a = [0]
    with pytest.raises(KeyError) as exc:
        compiled(a, 3)
    assert exc.value.args == (3,)
    assert a == [0, 7]
    assert compiled.fallback_calls == 1
def local_removed_set(x):
    y = {0, 1, 2, 3, 4, 5, 6, 7}
    y.remove(1)
    y.remove(2)
    y.remove(3)
    y.remove(4)
    y.remove(5)
    y.remove(6)
    y.remove(7)
    return y


@pytest.mark.parametrize('fn,args', [(copied, ({0, 1, 2, 3, 4},)), (local_removed_set, (1,))])
def test_escaped_set_future_mutation_keeps_python_table_behavior(fn, args):
    compiled = lift(fn)
    actual, expected = compiled(*args), fn(*args)
    actual.add(16 if fn is copied else 8)
    expected.add(16 if fn is copied else 8)
    actual.add(5 if fn is copied else 1)
    expected.add(5 if fn is copied else 1)
    assert list(actual) == list(expected)
    assert pop_sequence(actual) == pop_sequence(expected)


@pytest.mark.parametrize('fn,args,want', [(difference_size, ({10000,2},{2}),1), (local_copy_size,(10000,),3), (local_union_size,(10000,),4), (local_update_size,(10000,),3)])
def test_order_independent_non_escaping_set_is_native(fn, args, want):
    compiled = lift(fn)
    assert compiled(*args) == want
    assert compiled.compiled_calls == 1
