import copyreg
from test_prepared_cache import load_source,standalone,SOURCE

def test_derived_empty_pickle_slot_cache_does_not_change_runtime_key(tmp_path):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'pickle_cache.py';source.write_text(SOURCE)
    module=load_source(source)
    assert copyreg._slotnames(module.Box)==[]
    region=heap.lift_region(module.read)
    assert region(module.Box(10))==10
    section=heap.build_regions([(('read',module.read.__code__.co_firstlineno),module.read,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.read),pc.last_miss()
    del module.Box.__slotnames__
    assert index.bind(module.read),pc.last_miss()
    program=index.bind(module.read)[0]
    assert copyreg._slotnames(module.Box)==[]
    assert program.guards_hold()
    module.Box.__slotnames__.append('invented')
    assert not program.guards_hold()


def test_derived_cache_never_pins_later_finalizable_values(tmp_path):
    import gc,weakref
    from recompyler import heap,_prepared as pc
    source=tmp_path/'cache_lifetime.py';source.write_text(SOURCE)
    module=load_source(source)
    copyreg._slotnames(module.Box)
    region=heap.lift_region(module.read);assert region(module.Box(10))==10
    section=heap.build_regions([(('read',module.read.__code__.co_firstlineno),module.read,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.read),pc.last_miss()
    fast=heap.lift_region(module.read,index.exports,prepared=index)
    assert fast(module.Box(10))==10 and fast.prepared_hits==1
    events=[]
    class Sentinel:
        def __del__(self): events.append('destroyed')
    module.Box.__slotnames__.append(Sentinel())
    reference=weakref.ref(module.Box.__slotnames__[0])
    del module.Box.__slotnames__
    gc.collect()
    assert reference() is None and events==['destroyed']


def test_cache_name_observer_is_not_normalized(tmp_path):
    from types import SimpleNamespace
    import pytest
    from recompyler import _prepared as pc
    source=tmp_path/'cache_observer.py'
    source.write_text('def work(box):\n    return box.__slotnames__\n')
    module=load_source(source)
    info=SimpleNamespace(fn=module.work)
    program=SimpleNamespace(entry_fn=module.work,entry=info,order=[info],functions={0:info},class_fields={},guards={})
    with pytest.raises(pc.PreparedMiss): pc._definitions(pc.References(module.work,program),program)


def test_nested_code_cache_observer_is_not_normalized(tmp_path):
    from types import SimpleNamespace
    import pytest
    from recompyler import _prepared as pc
    source=tmp_path/'nested_observer.py'
    source.write_text('def work(box):\n    return (x.__slotnames__ for x in [box])\n')
    module=load_source(source)
    info=SimpleNamespace(fn=module.work)
    program=SimpleNamespace(entry_fn=module.work,entry=info,order=[info],functions={0:info},class_fields={},guards={})
    assert '__slotnames__' not in module.work.__code__.co_names
    with pytest.raises(pc.PreparedMiss): pc._definitions(pc.References(module.work,program),program)


def test_guard_cache_observer_is_not_normalized(tmp_path):
    from types import SimpleNamespace
    import pytest
    from recompyler import _prepared as pc
    source=tmp_path/'guard_observer.py';source.write_text(SOURCE)
    module=load_source(source);copyreg._slotnames(module.Box)
    info=SimpleNamespace(fn=module.read)
    program=SimpleNamespace(entry_fn=module.read,entry=info,order=[info],functions={0:info},class_fields={},guards={0:('own',module.Box,'__slotnames__',module.Box.__slotnames__)})
    with pytest.raises(pc.PreparedMiss): pc._definitions(pc.References(module.read,program),program)


def test_bad_slot_cache_shapes_do_not_run_hooks():
    import pytest
    from recompyler import _prepared as pc
    events=[]
    class BadList(list):
        def __len__(self): events.append('len'); raise AssertionError
        def __iter__(self): events.append('iter'); raise AssertionError
    class NoSlots: pass
    for value in (['invented'],(),BadList()):
        NoSlots.__slotnames__=value
        with pytest.raises(pc.PreparedMiss): list(pc._class_items(NoSlots))
    assert events==[]
    class Slotted:
        __slots__=('x',)
    class Child(Slotted):
        __slotnames__=[]
    with pytest.raises(pc.PreparedMiss): list(pc._class_items(Child))
