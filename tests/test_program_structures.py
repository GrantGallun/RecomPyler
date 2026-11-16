"""Fail-first next slice: unchanged inference helper bodies."""
from recompyler import heap

class First: pass
class Second: pass

def entry(value):
    return value

def make_program():
    return heap._Program(entry)

def test_real_program_merge():
    region = heap.lift_structures(heap._Program.merge)
    assert region.run is not None, region.problem
    program = make_program()
    program.fields = {First: {'x': heap.INT}, Second: {'y': heap.FLOAT}}
    program.members = {First: [First], Second: [Second]}
    assert region(program, First, Second) is First
    assert program.alias[Second] is First
    assert program.fields[First] == {'x': heap.INT, 'y': heap.FLOAT}
    assert program.members[First] == [First, Second]
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_real_written_set():
    region = heap.lift_structures(heap._Program.written_set)
    assert region.run is not None, region.problem
    program = make_program()
    program.alias[Second] = First
    program.written = {(First, 'x'), (Second, 'y')}
    assert region(program) == {(First, 'x'), (First, 'y')}
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_real_program_initializer():
    region = heap.lift_structures(heap._Program.__init__)
    assert region.run is not None, region.problem
    program = object.__new__(heap._Program)
    assert region(program, entry) is None
    assert program.entry_fn is entry and program.alias == {} and program.written == set()
    assert region.compiled_calls == 1 and region.fallback_calls == 0
"""Unrelated next-slice programs for real inference container patterns."""
def merge_records(first, second):
    values = {}
    for name, value in second.items():
        values[name] = first.get(name, value)
    return values

def selected_pairs(items):
    return {(key, value) for key, value in items}

def scoped_pairs(items, key):
    result = {(key, value) for key, value in items}
    return result, key

def test_equivalent_dictionary_merge():
    from recompyler import heap
    region = heap.lift_structures(merge_records)
    assert region.run is not None, region.problem
    value = []
    assert region({'a': value}, {'a': None})['a'] is value
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_equivalent_set_comprehension_preserves_scope():
    from recompyler import heap
    region = heap.lift_structures(scoped_pairs)
    assert region.run is not None, region.problem
    marker = object()
    result, key = region([('a', True), ('b', None)], marker)
    assert result == {('a', True), ('b', None)} and key is marker
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_real_unify_links_original_cells():
    region = heap.lift_structures(heap._Program.unify)
    assert region.run is not None, region.problem
    program = make_program()
    first, second = heap._Cell(), heap._Cell()
    second.elem = heap.INT
    second.mutated = True
    assert region(program, first, second) is None
    assert second.parent is first and first.elem is heap.INT and first.mutated is True
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_real_widen_cell_and_class_aliases():
    region = heap.lift_structures(heap._Program.widen_cell)
    assert region.run is not None, region.problem
    program = make_program()
    cell = heap._Cell()
    assert region(program, cell, heap.INT) is None
    assert cell.elem is heap.INT
    assert region.compiled_calls == 1 and region.fallback_calls == 0
    canon = heap.lift_structures(heap._Program.canon)
    assert canon.run is not None, canon.problem
    program.alias = {Second: First}
    assert canon(program, Second) is First
    assert canon.compiled_calls == 1 and canon.fallback_calls == 0

def raise_after_store(mapping, value):
    mapping['done'] = value
    raise ValueError('after store')

def test_explicit_raise_keeps_prior_effects():
    import pytest
    from recompyler import heap
    region = heap.lift_structures(raise_after_store)
    assert region.run is not None, region.problem
    mapping, marker = {}, []
    with pytest.raises(ValueError, match='after store'):
        region(mapping, marker)
    assert mapping['done'] is marker
    assert region.compiled_calls == 1 and region.fallback_calls == 0

comprehension_global = ('global',)

def global_after_comprehension(items):
    result = {comprehension_global for comprehension_global in items}
    return comprehension_global

def global_comprehension_iterable():
    return {comprehension_global for comprehension_global in comprehension_global}

def test_comprehension_global_is_visible_after_private_target():
    region = heap.lift_structures(global_after_comprehension)
    assert region.run is not None, region.problem
    assert region(['local']) is comprehension_global
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_comprehension_global_outer_iterable():
    region = heap.lift_structures(global_comprehension_iterable)
    assert region.run is not None, region.problem
    assert region() == {'global'}
    assert region.compiled_calls == 1 and region.fallback_calls == 0
