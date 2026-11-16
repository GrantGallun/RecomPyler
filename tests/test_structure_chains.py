"""Whole callers, native callees and equivalent object chains; fail first."""
from recompyler import heap

def compile_chain(fn, callees=()):
    return heap.lift_structures(fn, callees=callees)

def entry(value):
    return value

def inference_chain(program, first, second, kind):
    program.unify(first, second)
    program.widen_cell(first, kind)
    return heap._find(first)

class Node:
    def __init__(self, value):
        self.link, self.value = self, value

def follow(node):
    while node.link is not node:
        node = node.link
    return node

class Operations:
    def attach(self, first, second):
        first, second = follow(first), follow(second)
        second.link = first
        first.value = second.value

def attach_and_follow(operations, first, second):
    operations.attach(first, second)
    return follow(second)

def test_actual_inference_chain_interprets_unproved_children_with_exact_owners():
    region = compile_chain(inference_chain, callees=(heap._Program.unify, heap._Program.widen_cell, heap._find))
    assert region.run is not None, region.problem
    program = heap._Program(entry)
    first, second = heap._Cell(), heap._Cell()
    second.elem, second.mutated = heap.INT, True
    assert region(program, first, second, heap.INT) is first
    assert second.parent is first and first.elem is heap.INT and first.mutated is True
    assert region.compiled_calls == 1 and region.fallback_calls == 0
    assert region.native_helper_calls == 0 and region.managed_calls == 3

def test_unrelated_method_and_record_chain_compiles_same_family():
    region = compile_chain(attach_and_follow, callees=(Operations.attach, follow))
    assert region.run is not None, region.problem
    marker, first = [], Node(None)
    second = Node(marker)
    assert region(Operations(), first, second) is first
    assert second.link is first and first.value is marker
    assert region.compiled_calls == 1 and region.fallback_calls == 0
    assert region.native_helper_calls == 0 and region.managed_calls == 2

def test_replaced_method_runs_once_after_native_entry():
    region = compile_chain(attach_and_follow, callees=(Operations.attach, follow))
    assert region.run is not None, region.problem
    operations, first, second, events = Operations(), Node(None), Node(None), []
    def replaced(a, b):
        events.append((a, b))
        b.link = a
    operations.attach = replaced
    assert region(operations, first, second) is first
    assert events == [(first, second)] and region.fallback_calls == 0

def changed_follow(node):
    return node.value

def find_only(node):
    return follow(node)

def test_changed_callee_code_uses_current_body_without_replay():
    region = compile_chain(find_only, callees=(follow,))
    assert region.run is not None, region.problem
    original = follow.__code__
    try:
        follow.__code__ = changed_follow.__code__
        marker = []
        node = Node(marker)
        assert find_only(node) is marker
        assert region(node) is marker
    finally:
        follow.__code__ = original
    assert region.compiled_calls == 1 and region.fallback_calls == 0


def local_snapshot(value, action):
    current = value
    return action()

def test_context_call_sees_native_local_snapshot():
    region = compile_chain(local_snapshot, callees=())
    assert region.run is not None, region.problem
    marker = []
    result = region(marker, locals)
    assert list(result) == ['value', 'action', 'current']
    assert result['value'] is marker and result['current'] is marker and result['action'] is locals


def unpack_alias(value):
    value, tail = value
    return value, tail

def test_local_assignment_keeps_rhs_owner_until_unpack_finishes():
    region = compile_chain(unpack_alias)
    assert region.run is not None, region.problem
    marker = []
    actual = region((marker, marker))
    assert actual[0] is marker and actual[1] is marker

class FailingOperations:
    def attach(self, first, second):
        second.link = first
        raise ValueError(second.value)

def test_native_child_exception_keeps_partial_stores_without_replay():
    import pytest
    region = compile_chain(attach_and_follow, callees=(FailingOperations.attach, follow))
    assert region.run is not None, region.problem
    first, marker = Node(None), []
    second = Node(marker)
    with pytest.raises(ValueError) as caught:
        region(FailingOperations(), first, second)
    assert caught.value.args[0] is marker and second.link is first
    assert region.compiled_calls == 1 and region.fallback_calls == 0

def read_modify(record, value):
    old = record.value
    record.value = value
    return old, record.value

def test_cached_attributes_follow_materialized_and_replaced_dictionaries():
    region = compile_chain(read_modify)
    assert region.run is not None, region.problem
    node, first, second, third = Node(None), [], [], []
    node.value = first
    for _ in range(3):
        result = region(node, first)
        assert result[0] is first and result[1] is first
    node.__dict__['value'] = second
    result = region(node, third)
    assert result[0] is second and result[1] is third
    node.__dict__ = {'value': first}
    result = region(node, second)
    assert result[0] is first and result[1] is second

def test_cached_attributes_recheck_type_descriptors_and_custom_protocols():
    region = compile_chain(read_modify)
    assert region.run is not None, region.problem
    class Record: pass
    node, marker, replacement, events = Record(), [], [], []
    node.value = marker
    region(node, marker)
    def get(self):
        events.append('get')
        return marker
    def put(self, value):
        events.append(('set', value))
    Record.value = property(get, put)
    result = region(node, replacement)
    assert result[0] is marker and result[1] is marker
    assert events == ['get', ('set', replacement), 'get']

def test_cached_attribute_metadata_does_not_keep_classes_or_instances_alive():
    import weakref, gc
    region = compile_chain(read_modify)
    assert region.run is not None, region.problem
    class Record: pass
    node = Record()
    node.value = None
    observed = weakref.ref(Record), weakref.ref(node)
    region(node, None)
    del node, Record
    gc.collect()
    assert observed[0]() is None and observed[1]() is None


def keep_until_return(action):
    owner = action()
    action()
    return None

def test_native_slot_keeps_dead_source_local_alive_until_function_exit():
    events = []
    class Owned:
        def __del__(self): events.append('drop')
    def action():
        events.append('call')
        return Owned() if len(events) == 1 else None
    region = compile_chain(keep_until_return)
    assert region.run is not None, region.problem
    region(action)
    assert events == ['call', 'call', 'drop']


def keep_two_until_return(action):
    first = action('first')
    second = action('second')
    action('check')
    return None

def test_dead_locals_release_in_original_frame_order():
    events = []
    class Owned:
        def __init__(self, label): self.label = label
        def __del__(self): events.append(self.label)
    def action(label):
        if label == 'check': events.append('check')
        else: return Owned(label)
    keep_two_until_return(action)
    assert events == ['check', 'second', 'first']
    events.clear()
    region = compile_chain(keep_two_until_return)
    assert region.run is not None, region.problem
    region(action)
    assert events == ['check', 'second', 'first']


def dict_set_chain(mapping, seen, key, value):
    old = mapping[key]
    mapping[key] = value
    return old, key in seen, key not in mapping

def test_dict_and_set_ops_preserve_custom_hash_errors_and_partial_stores():
    import pytest
    region = compile_chain(dict_set_chain)
    assert region.run is not None, region.problem
    marker, replacement = [], []
    mapping = {'key': marker}
    result = region(mapping, {'key'}, 'key', replacement)
    assert result[0] is marker and result[1] is True and result[2] is False
    assert mapping['key'] is replacement
    class Key:
        calls = 0
        def __hash__(self):
            self.calls += 1
            if self.calls == 4: raise ValueError('contains')
            return 17
    key = Key()
    mapping = {key: marker}
    with pytest.raises(ValueError, match='contains'):
        region(mapping, set(), key, replacement)
    assert mapping[key] is replacement and key.calls == 5

class CustomMapping(dict):
    def __getitem__(self, key): return self['events'].append(('read', key)) or self['value']

def test_mapping_subclasses_keep_overridden_protocols():
    class Mapping(dict):
        def __getitem__(self, key):
            events.append(('read', key))
            return marker
        def __setitem__(self, key, value):
            events.append(('write', key, value))
        def __contains__(self, key):
            events.append(('contains', key))
            return True
    events, marker, replacement = [], [], []
    region = compile_chain(dict_set_chain)
    assert region.run is not None, region.problem
    result = region(Mapping(), set(), 'key', replacement)
    assert result[0] is marker and result[1] is False and result[2] is False
    assert events == [('read', 'key'), ('write', 'key', replacement), ('contains', 'key')]


def inference_pass(program, pairs, kind):
    for first, second in pairs:
        program.unify(first, second)
        program.widen_cell(first, kind)
    return heap._find(first)

def test_inference_loop_keeps_one_parent_entry_and_interprets_children():
    region = compile_chain(inference_pass, callees=(heap._Program.unify, heap._Program.widen_cell, heap._find))
    assert region.run is not None, region.problem
    program = heap._Program(entry)
    pairs = [(heap._Cell(), heap._Cell()) for _ in range(8)]
    for first, second in pairs:
        second.elem, second.mutated = heap.INT, True
    assert region(program, pairs, heap.INT) is pairs[-1][0]
    assert all(second.parent is first and first.elem is heap.INT and first.mutated is True for first, second in pairs)
    assert region.compiled_calls == 1 and region.fallback_calls == 0
    assert region.native_helper_calls == 0 and region.managed_calls == 17

def test_contains_unhashable_set_key_uses_language_conversion():
    region = compile_chain(dict_set_chain)
    assert region.run is not None, region.problem
    class Mapping:
        def __getitem__(self, key): return key
        def __setitem__(self, key, value): pass
        def __contains__(self, key): return False
    key = set()
    result = region(Mapping(), {frozenset()}, key, None)
    assert result[0] is key and result[1] is True and result[2] is True


def snapshot_and_rebind(action):
    owner = action('make')
    action(locals())
    owner = None
    action('after')
    return None

def test_temporary_context_snapshot_does_not_extend_replaced_local_lifetime():
    events = []
    class Owned:
        def __del__(self): events.append('drop')
    def action(value):
        if value == 'make': return Owned()
        if value == 'after': events.append('after')
    region = compile_chain(snapshot_and_rebind)
    assert region.run is not None, region.problem
    region(action)
    assert events == ['drop', 'after']


def test_prepared_constant_owners_do_not_hide_region_globals_cycles():
    import gc, types, weakref
    namespace = dict(globals())
    child = types.FunctionType(follow.__code__, namespace)
    namespace['follow'] = child
    root = types.FunctionType(find_only.__code__, namespace)
    region = compile_chain(root, callees=(child,))
    assert region.run is not None, region.problem
    namespace['cycle'] = region
    marker = weakref.ref(region)
    assert region(Node(None)).link is not None
    del region, root, child, namespace
    gc.collect()
    assert marker() is None


def owned_child(action):
    owner = action('make')
    action('inside')
    return None

def owned_parent(action):
    owned_child(action)
    action('after')
    return None

def test_native_child_releases_its_locals_before_parent_continues():
    events = []
    class Owned:
        def __del__(self): events.append('drop')
    def action(value):
        if value == 'make': return Owned()
        events.append(value)
    region = compile_chain(owned_parent, callees=(owned_child,))
    assert region.run is not None, region.problem
    region(action)
    assert events == ['inside', 'drop', 'after']
    assert region.native_helper_calls == 0 and region.fallback_calls == 0


def fresh_record(source, value):
    node = Node(source)
    old = node.value
    node.value = value
    return node, old

def test_new_record_inline_store_keeps_original_and_replacement_owners():
    marker, replacement = [], []
    region = compile_chain(fresh_record)
    assert region.run is not None, region.problem
    for _ in range(32):
        result, old = region(marker, replacement)
        assert old is marker and result.value is replacement and result.link is result
    assert region.compiled_calls == 32 and region.fallback_calls == 0


def test_invalid_callee_catalogue_declines_without_entering_source():
    region = compile_chain(entry, callees=(len,))
    assert region.run is None
    marker = []
    assert region(marker) is marker and region.fallback_calls == 1

def test_missing_dictionary_tuple_key_keeps_one_original_key_argument():
    import pytest
    class Mapping:
        def __getitem__(self, key): return None
        def __setitem__(self, key, value): pass
        def __contains__(self, key): return False
    region = compile_chain(dict_set_chain)
    assert region.run is not None, region.problem
    key = ('one', 'two')
    with pytest.raises(KeyError) as caught:
        region({}, set(), key, None)
    assert len(caught.value.args) == 1 and caught.value.args[0] is key

def child_cleanup(make):
    first=make('first')
    second=make('second')
    third=make('third')
    return None

def cleanup_caller(make):
    return child_cleanup(make)

def test_native_child_cleanup_matches_cpython_three_local_order():
    events=[]
    class Token:
        def __init__(self,name):self.name=name
        def __del__(self):events.append(self.name)
    def make(name):return Token(name)
    cleanup_caller(make)
    assert events==['third','second','first']
    events.clear()
    region=compile_chain(cleanup_caller,callees=(child_cleanup,))
    assert region.run is not None,region.problem
    region(make)
    assert events==['third','second','first']
    assert region.compiled_calls==1 and region.native_helper_calls==0 and region.fallback_calls==0
