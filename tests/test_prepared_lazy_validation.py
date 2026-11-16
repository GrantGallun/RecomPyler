import pytest
from test_prepared_cache import artifact,row_for,standalone

@pytest.mark.parametrize('first_misses',[False,True])
def test_region_stops_restoring_after_first_compatible_candidate(artifact,monkeypatch,first_misses):
    pc,heap,module,source,section=artifact
    index=pc.open_index(section,row_for(section),plan_snapshot=standalone(section))
    assert index is not None and len(index.cores)>1
    original=pc._restore;calls=[]
    def restore(*a,**kw):
        calls.append(True)
        if first_misses and len(calls)==1:raise pc.PreparedMiss('first candidate incompatible')
        assert len(calls)<=1+int(first_misses),'unused later descriptor was restored'
        return original(*a,**kw)
    monkeypatch.setattr(pc,'_restore',restore)
    fast=heap.lift_region(module.work,index.exports,prepared=index)
    box,items=module.Box(10),[]
    assert fast(box,items)==(box,items,18)
    assert fast.aot_calls==fast.prepared_hits==1 and fast.jit_calls==fast.fallback_calls==0
    assert len(calls)==1+int(first_misses)
    assert len(fast.prepared_reasons)==int(first_misses)


def test_resolution_cache_uses_exact_immutable_recipe_structure(artifact,monkeypatch):
    pc,heap,module,source,section=artifact
    refs=pc.References(module.work)
    def forbidden(*a,**kw):raise AssertionError('recipe lookup serialized JSON')
    monkeypatch.setattr(pc,'canonical',forbidden)
    assert refs.resolve(['entry']) is module.work
    assert refs.resolve(['globals',['entry']]) is module.work.__globals__
    assert refs.resolve(['literal',['bool',True]]) is True
    value=refs.resolve(['literal',['int','1']]);assert type(value) is int and value==1
    recipe=['literal',['int','1']]
    assert refs.resolve(recipe)==1
    recipe[1][1]='2'
    assert refs.resolve(recipe)==2
    assert refs.resolve(['literal',['int','1']])==1
    assert pc._recipe_key(['mro',['entry'],True])!=pc._recipe_key(['mro',['entry'],1])
    events=[]
    class Hostile:
        def __hash__(self):events.append('hash');return 0
        def __eq__(self,other):events.append('equal');return False
        def __iter__(self):events.append('iter');return iter(())
    with pytest.raises(pc.PreparedMiss):refs.resolve(['literal',Hostile()])
    assert events==[]


def test_inert_snapshot_has_no_native_image_io_but_class_key_still_seals_it(artifact,monkeypatch):
    pc,heap,module,source,section=artifact
    class Plain: unused=abs
    monkeypatch.setattr(module,'SnapshotClass',Plain,raising=False)
    calls=[];original=pc.file_key
    def record(path):calls.append(str(path));return original(path)
    monkeypatch.setattr(pc,'file_key',record)
    snapshot=pc._class_snapshot(Plain)
    assert calls==[],'identity snapshot redundantly hashed native images'
    assert pc._class_unchanged(snapshot)
    pc._class_key(Plain,pc.References(module.work))
    assert calls,'full class fingerprint did not seal the native dependency'
    Plain.unused=len
    assert not pc._class_unchanged(snapshot)
