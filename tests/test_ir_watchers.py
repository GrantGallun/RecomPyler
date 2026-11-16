"""Native dependency invalidation, independent of the entry implementation."""
import gc
import weakref
import pytest


def subscription(*dicts, types=()):
    from recompyler.ir.watchers import watch_dependencies
    return watch_dependencies(dicts=dicts, types=types)


@pytest.mark.parametrize('mutation', [
    lambda d: d.__setitem__('x', 2),
    lambda d: d.__delitem__('x'),
    lambda d: d.clear(),
    lambda d: d.update({'y': 3}),
])
def test_dict_mutation_invalidates_once(mutation):
    d = {'x': 1}
    handle = subscription(d)
    assert handle.valid
    mutation(d)
    assert not handle.valid
    d['again'] = 4
    assert not handle.valid


def test_empty_dict_update_clone_and_shared_subscribers():
    d = {}
    first = subscription(d)
    second = subscription(d)
    first.close()
    d.update({'a': 1, 'b': 2})
    assert not first.valid and not second.valid


def test_unrelated_dict_does_not_invalidate():
    d = {'x': 1}
    handle = subscription(d)
    other = {'x': 2}
    other.clear()
    assert handle.valid
    handle.close()


def test_types_invalidate_on_direct_and_inherited_changes():
    class Base: x = 1
    class Child(Base): pass
    first = subscription(types=(Child,))
    assert first.valid
    Base.x = 2
    assert not first.valid
    second = subscription(types=(Child,))
    Child.y = 3
    assert not second.valid


def test_close_and_gc_release_dependencies():
    class Owner: pass
    owner = Owner()
    ref = weakref.ref(owner)
    d = {'x': owner}
    handle = subscription(d)
    del d, owner
    gc.collect()
    assert ref() is not None
    handle.close()
    gc.collect()
    assert ref() is None
    handle.close()
    assert not handle.valid


def test_cyclic_subscription_is_collectable():
    class Owner: pass
    owner = Owner()
    ref = weakref.ref(owner)
    d = {'owner': owner}
    handle = subscription(d)
    d['handle'] = handle
    owner.handle = handle
    del owner, d, handle
    gc.collect()
    assert ref() is None


def test_invalid_dependencies_do_not_leave_partial_watches():
    d = {}
    with pytest.raises(TypeError): subscription(d, [])
    with pytest.raises(TypeError): subscription(d, types=(object(),))
    handle = subscription(d, d)
    d['x'] = 1
    assert not handle.valid

def test_bind_rejects_non_entry_and_invalid_capsules():
    from recompyler.ir import _entry_native
    handle = subscription({})
    api = _entry_native.invalidation_api()
    with pytest.raises(TypeError): handle.bind(object(), api)
    with pytest.raises((TypeError, ValueError)): handle.bind(object(), object())


def test_dict_change_routes_native_entry_to_original_without_guard_calls():
    from recompyler.ir import _entry_native
    from recompyler.ir.entry import create_callable
    from test_ir_entry import NativeBody, original_path
    body = NativeBody()
    d = {'name': 1}
    handle = subscription(d)
    entry = create_callable(original_path, body.address, (body, handle))
    handle.bind(entry, _entry_native.invalidation_api())
    marker = object()
    assert entry(marker) is marker
    d['name'] = 2
    assert entry(marker) == ('original', marker)
    assert not handle.valid


def test_invalidated_or_closed_subscription_cannot_bind_a_fresh_entry():
    from recompyler.ir import _entry_native
    from recompyler.ir.entry import create_callable
    from test_ir_entry import NativeBody, original_path
    handle = subscription({})
    handle.close()
    body = NativeBody()
    entry = create_callable(original_path, body.address, body)
    with pytest.raises(RuntimeError): handle.bind(entry, _entry_native.invalidation_api())

def test_type_change_and_explicit_close_route_bound_entries_to_original():
    from recompyler.ir import _entry_native
    from recompyler.ir.entry import create_callable
    from test_ir_entry import NativeBody,original_path
    class Owner:x=1
    body=NativeBody();handle=subscription(types=(Owner,))
    entry=create_callable(original_path,body.address,(body,handle));handle.bind(entry,_entry_native.invalidation_api())
    marker=object();assert entry(marker) is marker
    Owner.x=2
    assert entry(marker)==('original',marker)
    other=subscription({});second=create_callable(original_path,body.address,(body,other))
    other.bind(second,_entry_native.invalidation_api());assert second(marker) is marker
    other.close();assert second(marker)==('original',marker)


def test_bound_entry_cycle_releases_engine_after_collection():
    from recompyler.ir import _entry_native
    from recompyler.ir.entry import create_callable
    from test_ir_entry import NativeBody,original_path
    body=NativeBody();ref=weakref.ref(body);handle=subscription({})
    entry=create_callable(original_path,body.address,(body,handle));handle.bind(entry,_entry_native.invalidation_api())
    del body,entry,handle
    gc.collect()
    assert ref() is None

def test_specialized_type_is_not_kept_alive_by_a_subscription():
    events=[]
    class Meta(type):
        def __del__(cls):events.append('type-drop')
    class Owner(metaclass=Meta):pass
    ref=weakref.ref(Owner)
    handle=subscription(types=(Owner,))
    del Owner
    gc.collect()
    assert ref() is None and events==['type-drop']
    assert not handle.valid

def test_type_death_invalidates_bound_entry_without_retaining_class():
    from recompyler.ir import _entry_native
    from recompyler.ir.entry import create_callable
    from test_ir_entry import NativeBody,original_path
    class Owner:pass
    ref=weakref.ref(Owner);body=NativeBody();handle=subscription(types=(Owner,))
    entry=create_callable(original_path,body.address,(body,handle));handle.bind(entry,_entry_native.invalidation_api())
    marker=object();assert entry(marker) is marker
    del Owner
    gc.collect()
    assert ref() is None and not handle.valid
    assert entry(marker)==('original',marker)

def test_type_subscription_releases_dictionary_immediately_without_gc():
    events=[]
    class Token:
        def __del__(self):events.append('drop')
    class Owner:pass
    d={'token':Token()}
    handle=subscription(d,types=(Owner,))
    del d,handle
    assert events==['drop']


def test_bound_subscription_does_not_delay_original_defaults_finalizer():
    from recompyler.ir import _entry_native
    from recompyler.ir.entry import create_callable
    from test_ir_entry import NativeBody,original_path
    from types import FunctionType
    events=[]
    class Token:
        def __del__(self):events.append('drop')
    fn=FunctionType(original_path.__code__,{},argdefs=(Token(),))
    body=NativeBody();handle=subscription(fn.__globals__)
    entry=create_callable(fn,body.address,(body,handle));handle.bind(entry,_entry_native.invalidation_api())
    del fn,entry,body,handle
    assert events==['drop']
