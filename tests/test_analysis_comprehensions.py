"""Next container comprehension targets; separate from layout acceptance."""
from recompyler import heap

class Record:
    def __init__(self):
        self.x, self.y = 1, 2

def entry(value):
    return value

def list_pairs(items, key):
    result = [(key, value) for key, value in items]
    return result, key

def dict_pairs(items, key):
    result = {key: value for key, value in items}
    return result, key

def compile_structure(fn):
    region = heap.lift_structures(fn)
    assert region.run is not None, region.problem
    return region

def test_real_constant_strings_keeps_original_text_owner():
    program = heap._Program(entry)
    text = ''.join(['original', ' constant owner'])
    program.global_objects = [({}, text, None)]
    program._constant_blocks = (12, {0: 21}, [])
    region = compile_structure(heap._Program.constant_strings)
    result = region(program)
    assert result == [(text, 21)] and result[0][0] is text
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_real_load_plan_creates_exact_field_order_and_reuses_cache():
    program = heap._Program(entry)
    program.register(Record)
    program.fields[Record] = {'x': heap.INT, 'y': heap.FLOAT}
    expected = program.load_plan(Record)
    program._load_plans.clear()
    region = compile_structure(heap._Program.load_plan)
    result = region(program, Record)
    assert result == expected and result is program._load_plans[Record]
    assert region(program, Record) is result
    assert region.compiled_calls == 2 and region.fallback_calls == 0

def test_list_comprehension_scope_and_aliases():
    region = compile_structure(list_pairs)
    marker, value = object(), []
    result, key = region([('first', value), ('last', value)], marker)
    assert result == [('first', value), ('last', value)]
    assert result[0][1] is value and result[1][1] is value and key is marker
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_dict_comprehension_scope_and_last_store():
    region = compile_structure(dict_pairs)
    marker, first, last = object(), [], []
    result, key = region([('same', first), ('same', last)], marker)
    assert result == {'same': last} and result['same'] is last and key is marker
    assert region.compiled_calls == 1 and region.fallback_calls == 0

class Key:
    def __init__(self, name, events):
        self.name, self.events = name, events
    def __hash__(self):
        self.events.append(('hash', self.name))
        return 1
    def __eq__(self, other):
        self.events.append(('eq', self.name, other.name))
        return self.name == other.name

def called_dict_pairs(items, key, value):
    return {key(item): value(item) for item in items}

def filtered_lists(items, predicate, emit):
    return [emit(item) for group in items for item in group if predicate(item)]

def test_dict_key_value_and_hash_order_matches_cpython():
    region = compile_structure(called_dict_pairs)
    def execute(target):
        events = []
        def key(item):
            events.append(('key', item))
            return Key(item, events)
        def value(item):
            events.append(('value', item))
            return item
        result = target(['a', 'a'], key, value)
        return events, [(k.name, v) for k, v in result.items()]
    assert execute(region) == execute(called_dict_pairs)
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def test_nested_list_comprehension_filters_in_order():
    region = compile_structure(filtered_lists)
    def execute(target):
        events = []
        def predicate(item):
            events.append(('predicate', item))
            return item % 2
        def emit(item):
            events.append(('emit', item))
            return item
        result = target([[0, 1], [], [2, 3]], predicate, emit)
        return events, result
    assert execute(region) == execute(filtered_lists)
    assert region.compiled_calls == 1 and region.fallback_calls == 0

comprehension_global = ('original global',)

def global_after_list(items):
    result = [comprehension_global for comprehension_global in items]
    return result, comprehension_global

def global_after_dict(items):
    result = {comprehension_global: comprehension_global for comprehension_global in items}
    return result, comprehension_global

def outer_list_iterable():
    return [comprehension_global for comprehension_global in comprehension_global]

def test_list_and_dict_private_targets_restore_global_scope():
    for fn in (global_after_list, global_after_dict):
        region = compile_structure(fn)
        result, original = region(['temporary'])
        assert original is comprehension_global and result == fn(['temporary'])[0]
        assert region.compiled_calls == 1 and region.fallback_calls == 0
    region = compile_structure(outer_list_iterable)
    assert region() == outer_list_iterable()
    assert region.compiled_calls == 1 and region.fallback_calls == 0
