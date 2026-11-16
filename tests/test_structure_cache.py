"""Cache transitions must preserve the live CPython object protocol."""
import pytest

def test_inline_cache_warms_then_observes_dict_detachment():
    from recompyler import _structure_ops_native as ops
    class Record: pass
    node = Record()
    first, second, third = [], [], []
    node.value = first
    cache = ops.new_cache()
    assert ops.load(node, 'value', cache) is first
    assert ops.load(node, 'value', cache) is first
    assert ops.hits(cache) >= 1
    ops.store(node, 'value', second, cache)
    assert node.value is second
    namespace = node.__dict__
    namespace['value'] = third
    assert ops.load(node, 'value', cache) is third
    node.__dict__ = {'value': first}
    assert ops.load(node, 'value', cache) is first
    ops.store(node, 'value', second, cache)
    assert node.__dict__ == {'value': second}

def test_warmed_cache_invalidates_on_property_or_class_change():
    from recompyler import _structure_ops_native as ops
    class Record: pass
    class Other: pass
    node, original, changed, events = Record(), [], [], []
    node.value = original
    cache = ops.new_cache()
    assert ops.load(node, 'value', cache) is original
    assert ops.load(node, 'value', cache) is original
    def get(self):
        events.append('get')
        return changed
    def put(self, value):
        events.append(value)
    Record.value = property(get, put)
    assert ops.load(node, 'value', cache) is changed
    ops.store(node, 'value', original, cache)
    assert events == ['get', original]
    node.__class__ = Other
    assert ops.load(node, 'value', cache) is original

def test_store_publishes_before_old_value_finalizer_and_rechecks_after_it():
    from recompyler import _structure_ops_native as ops
    class Record: pass
    node, events, replacement = Record(), [], []
    cache = ops.new_cache()
    class Old:
        def __del__(self):
            events.append(node.value is replacement)
            node.__dict__ = {'value': 'changed'}
    node.value = None
    ops.load(node, 'value', cache)
    node.value = Old()
    ops.store(node, 'value', replacement, cache)
    assert events == [True]
    assert ops.load(node, 'value', cache) == 'changed'

def test_same_cache_name_change_cannot_reuse_another_field_index():
    from recompyler import _structure_ops_native as ops
    class Record: pass
    node = Record()
    node.first, node.second = [], []
    cache = ops.new_cache()
    assert ops.load(node, 'first', cache) is node.first
    assert ops.load(node, 'second', cache) is node.second
    ops.store(node, 'first', None, cache)
    assert node.first is None and node.second == []


def test_deletion_and_reinsertion_preserve_inline_dictionary_order():
    from recompyler import _structure_ops_native as ops
    class Record: pass
    node = Record()
    node.first, node.second = 1, 2
    first_cache, second_cache = ops.new_cache(), ops.new_cache()
    assert ops.load(node, 'first', first_cache) == 1
    assert ops.load(node, 'second', second_cache) == 2
    del node.first
    ops.store(node, 'first', 3, first_cache)
    assert list(node.__dict__.items()) == [('second', 2), ('first', 3)]

def test_non_data_descriptor_yields_to_current_inline_value():
    from recompyler import _structure_ops_native as ops
    class Descriptor:
        def __get__(self, owner, cls): return 'descriptor'
    class Record:
        value = Descriptor()
    node, marker, cache = Record(), [], ops.new_cache()
    node.value = marker
    assert ops.load(node, 'value', cache) is marker
    assert ops.load(node, 'value', cache) is marker
    del node.value
    assert ops.load(node, 'value', cache) == 'descriptor'
