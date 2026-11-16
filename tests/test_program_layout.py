"""Next unchanged compiler layout helper and equivalent store semantics."""
import pytest
from recompyler import heap

class LayoutRecord:
    def __init__(self):
        self.x, self.y = 1, 2

def entry(value):
    return value

def choose_and_update(mapping, key, amount, choose):
    value = mapping[key] if choose else amount
    mapping[key] += value
    return mapping[key]

def update_attribute(record, values):
    record.x += values
    return record.x

def compile_structure(fn):
    region = heap.lift_structures(fn)
    assert region.run is not None, region.problem
    return region

def test_actual_layout():
    program = heap._Program(entry)
    program.register(LayoutRecord)
    program.fields[LayoutRecord] = {'x': heap.INT, 'y': heap.FLOAT}
    expected = program.layout(LayoutRecord)
    region = compile_structure(heap._Program.layout)
    assert region(program, LayoutRecord) == expected
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_equivalent_conditional_and_store():
    region = compile_structure(choose_and_update)
    mapping = {'a': 2}
    assert region(mapping, 'a', 8, True) == 4
    assert region(mapping, 'a', 8, False) == 12
    assert region.compiled_calls == 2 and region.fallback_calls == 0

def test_inplace_list_alias_is_preserved():
    region = compile_structure(update_attribute)
    record = LayoutRecord()
    original = record.x = [1]
    assert region(record, [2]) is original
    assert record.x is original and original == [1, 2]
    assert region.compiled_calls == 1 and region.fallback_calls == 0

class LoggedMapping(dict):
    def __init__(self, events, fail=False):
        super().__init__(item=[1])
        self.events, self.fail = events, fail
    def __getitem__(self, key):
        self.events.append('get')
        return super().__getitem__(key)
    def __setitem__(self, key, value):
        self.events.append('store')
        if self.fail:
            raise ValueError('store failed')
        return super().__setitem__(key, value)

def add_from_calls(owner, key, rhs):
    owner()[key()] += rhs()

def choose_from_calls(condition, first, second):
    return first() if condition else second()

@pytest.mark.parametrize('fail', [False, True])
def test_augmented_store_order_and_no_replay(fail):
    region = compile_structure(add_from_calls)
    events = []
    mapping = LoggedMapping(events, fail)
    original = dict.__getitem__(mapping, 'item')
    def owner():
        events.append('owner')
        return mapping
    def key():
        events.append('key')
        return 'item'
    def rhs():
        events.append('rhs')
        return [2]
    if fail:
        with pytest.raises(ValueError, match='store failed'):
            region(owner, key, rhs)
    else:
        assert region(owner, key, rhs) is None
    assert events == ['owner', 'key', 'get', 'rhs', 'store']
    assert dict.__getitem__(mapping, 'item') is original and original == [1, 2]
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_conditional_expression_evaluates_one_branch():
    region = compile_structure(choose_from_calls)
    events = []
    marker = object()
    def first():
        events.append('first')
        return marker
    def second():
        events.append('second')
        return None
    assert region(True, first, second) is marker
    assert region(False, first, second) is None
    assert events == ['first', 'second']
    assert region.compiled_calls == 2 and region.fallback_calls == 0
"""Directed conditional-expression truth protocol checks."""
from recompyler import heap

class Stateful:
    def __init__(self, values):
        self.values = list(values)
        self.calls = 0
    def __bool__(self):
        value = self.values[self.calls]
        self.calls += 1
        return value

def conditional_branch(a, b, c, choose):
    if (a and b) if choose else c:
        return 1
    return 0

def conditional_and(a, b, c, choose, d):
    return ((a and b) if choose else c) and d

def test_conditional_branch_tests_short_circuit_operand_once():
    region = heap.lift_structures(conditional_branch)
    assert region.run is not None, region.problem
    def execute(target):
        value = Stateful([False, True])
        result = target(value, object(), False, True)
        return result, value.calls
    assert execute(region) == execute(conditional_branch)
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_conditional_and_tests_short_circuit_operand_once():
    region = heap.lift_structures(conditional_and)
    assert region.run is not None, region.problem
    def execute(target):
        value = Stateful([False, True])
        result = target(value, object(), False, True, 'last')
        return result is value, value.calls
    assert execute(region) == execute(conditional_and)
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def conditional_and_branch(a, b, c, choose, d):
    if ((a and b) if choose else c) and d:
        return 1
    return 0

def conditional_or_branch(a, b, c, choose, d):
    if ((a or b) if choose else c) or d:
        return 1
    return 0

def test_conditional_under_boolean_condition_tests_once():
    for fn, values, final in [(conditional_and_branch, [False, True], True), (conditional_or_branch, [True, False], False)]:
        region = heap.lift_structures(fn)
        assert region.run is not None, region.problem
        def execute(target):
            value = Stateful(values)
            result = target(value, False, False, True, final)
            return result, value.calls
        assert execute(region) == execute(fn)
        assert region.compiled_calls == 1 and region.fallback_calls == 0

