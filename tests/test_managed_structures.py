"""S60 generic managed structures, including real compiler helpers."""
import pytest
from recompyler import heap

class Record:
    def __init__(self):
        self.parent, self.value = None, 'unknown'

def other_root(record):
    while record.parent is not None:
        record = record.parent
    return record

def mutate(mapping, seen, key, value):
    mapping[key] = value
    seen.add(key)
    if key in mapping and key in seen:
        return mapping.get(key)
    return None

def iterate_keys(mapping):
    result = []
    for key in mapping:
        result.append(key)
    return result

def assign_pair(record, value):
    record.parent, record.value = value
    return record

def compile_structure(fn):
    constructor = getattr(heap, 'lift_structures', None)
    assert constructor is not None, 'generic structure compiler is missing'
    result = constructor(fn)
    assert result.run is not None, result.problem
    return result

def test_actual_cell_init_compiles():
    region = compile_structure(heap._Cell.__init__)
    cell = object.__new__(heap._Cell)
    assert region(cell) is None
    assert cell.parent is None and cell.elem is heap.BOTTOM and cell.mutated is False
    assert (region.compiled_calls, region.fallback_calls) == (1, 0)

@pytest.mark.parametrize('function,cls', [(heap._find, heap._Cell), (other_root, Record)])
def test_actual_and_unrelated_find(function, cls):
    root, middle, leaf = cls(), cls(), cls()
    middle.parent = root
    leaf.parent = middle
    region = compile_structure(function)
    for value in (root, middle, leaf):
        assert region(value) is root
    assert (region.compiled_calls, region.fallback_calls) == (3, 0)

@pytest.mark.parametrize('key', ['item', Record, object()])
def test_mixed_alias_mutation(key):
    region = compile_structure(mutate)
    mapping, seen, value = {}, set(), []
    assert region(mapping, seen, key, value) is value
    assert mapping[key] is value and key in seen
    assert (region.compiled_calls, region.fallback_calls) == (1, 0)

def test_dictionary_iteration_order():
    region = compile_structure(iterate_keys)
    mapping = {'a': [], Record: None, 'b': True}
    result = region(mapping)
    assert result == list(mapping)
    assert all(a is b for a, b in zip(result, mapping))
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_unpack_error_leaves_targets_unchanged():
    region = compile_structure(assign_pair)
    record = Record()
    with pytest.raises(ValueError, match='not enough values to unpack'):
        region(record, [None])
    assert record.parent is None and record.value == 'unknown'
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def original_identity(value):
    return value

def test_actual_program_widen_dictionary():
    region = compile_structure(heap._Program.widen)
    program = heap._Program(original_identity)
    mapping = {}
    assert region(program, mapping, Record, heap.INT) is heap.INT
    assert mapping[Record] is heap.INT and program.changed is True
    program.changed = False
    assert region(program, mapping, Record, heap.FLOAT) is heap.MIXED
    assert mapping[Record] is heap.MIXED and program.changed is True
    assert (region.compiled_calls, region.fallback_calls) == (2, 0)

def partial_then_error(mapping, key, value):
    mapping[key] = value
    return mapping['missing']

def nested_targets(record, values):
    record.parent, (record.value, other) = values
    return other

def short_circuit(first, action):
    if first and action():
        return first
    return None

def compare_chain(first, middle, last):
    return first < middle() < last()

def test_partial_store_is_not_replayed_on_error():
    region = compile_structure(partial_then_error)
    class Counting(dict):
        def __setitem__(self, key, value):
            self.writes += 1
            super().__setitem__(key, value)
    mapping = Counting()
    mapping.writes = 0
    value = []
    with pytest.raises(KeyError, match='missing'):
        region(mapping, 'first', value)
    assert mapping['first'] is value and mapping.writes == 1
    assert (region.compiled_calls, region.fallback_calls) == (1, 0)

def test_nested_unpack_keeps_completed_store_on_later_failure():
    region = compile_structure(nested_targets)
    record = Record()
    marker = object()
    with pytest.raises(ValueError, match='not enough values to unpack'):
        region(record, (marker, [1]))
    assert record.parent is marker and record.value == 'unknown'
    assert (region.compiled_calls, region.fallback_calls) == (1, 0)

def test_short_circuit_keeps_operand_and_call_order():
    region = compile_structure(short_circuit)
    events = []
    def action():
        events.append('action')
        return True
    assert region(False, action) is None and events == []
    first = [1]
    assert region(first, action) is first and events == ['action']
    assert region.compiled_calls == 2 and region.fallback_calls == 0

def test_comparison_chain_evaluates_middle_once_and_short_circuits():
    region = compile_structure(compare_chain)
    events = []
    def middle():
        events.append('middle')
        return 2
    def last():
        events.append('last')
        return 3
    assert region(1, middle, last) is True and events == ['middle', 'last']
    events.clear()
    assert region(5, middle, last) is False and events == ['middle']
    assert region.compiled_calls == 2 and region.fallback_calls == 0

class StatefulTruth:
    def __init__(self, first):
        self.first, self.calls = first, 0
    def __bool__(self):
        self.calls += 1
        return self.first if self.calls == 1 else not self.first

class ComparisonResult:
    def __init__(self, answer):
        self.answer = answer
    def __lt__(self, other):
        return self.answer

def and_three(a, b, c):
    return a and b and c

def or_three(a, b, c):
    return a or b or c

def condition_and(a, b):
    if a and b:
        return True
    return False

def condition_or(a, b):
    if a or b:
        return True
    return False

def condition_chain(a, b, c):
    if a < b < c:
        return True
    return False

@pytest.mark.parametrize('function,first', [(and_three, False), (or_three, True)])
def test_returned_boolean_expression_short_circuits_once(function, first):
    region = compile_structure(function)
    a = StatefulTruth(first)
    assert region(a, None, object()) is a
    assert a.calls == 1
    assert region.compiled_calls == 1 and region.fallback_calls == 0

@pytest.mark.parametrize('function,first', [(condition_and, False), (condition_or, True)])
def test_condition_boolean_expression_short_circuits_once(function, first):
    region = compile_structure(function)
    a = StatefulTruth(first)
    assert region(a, True) is first
    assert a.calls == 1
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_conditional_comparison_chain_short_circuits_once():
    region = compile_structure(condition_chain)
    answer = StatefulTruth(False)
    assert region(ComparisonResult(answer), object(), object()) is False
    assert answer.calls == 1
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def nested_and(a, b, c):
    return (a and b) and c

def nested_mixed(a, b, c):
    return (a and b) or c

def nested_not(a, b):
    return not (a and b)

@pytest.mark.parametrize('function', [nested_and, nested_mixed, nested_not])
def test_nested_boolean_decisions_match_cpython(function):
    region = compile_structure(function)
    for first in (False, True):
        actual, expected = StatefulTruth(first), StatefulTruth(first)
        args = (None, object()) if function is not nested_not else (None,)
        wanted = function(expected, *args)
        result = region(actual, *args)
        assert actual.calls == expected.calls
        if wanted is expected:
            assert result is actual
        else:
            assert result is wanted
    assert region.compiled_calls == 2 and region.fallback_calls == 0
