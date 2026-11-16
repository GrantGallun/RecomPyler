from test_prepared_cache import load_source,standalone,SOURCE

def test_module_global_record_rebinds_current_input_without_regeneration(tmp_path,monkeypatch):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'global_fixture.py'
    source.write_text(SOURCE+'\nGLOBAL_BOX=Box(10)\ndef global_read():\n    return GLOBAL_BOX.value\n')
    module=load_source(source)
    region=heap.lift_region(module.global_read)
    assert region()==10 and region.compiled_calls==1
    section=heap.build_regions([(('global_read',module.global_read.__code__.co_firstlineno),module.global_read,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.global_read),pc.last_miss()
    def forbidden(*a,**k): raise AssertionError('regeneration on global-input prepared hit')
    monkeypatch.setattr(heap.Region,'_make_program',forbidden)
    fast=heap.lift_region(module.global_read,index.exports,prepared=index)
    assert fast()==10 and fast.aot_calls==1 and fast.prepared_hits==1
    module.GLOBAL_BOX=module.Box(20)
    assert fast()==20 and fast.aot_calls==1 and fast.fallback_calls==1
    fresh=heap.lift_region(module.global_read,index.exports,prepared=index)
    assert fresh()==20 and fresh.aot_calls==1 and fresh.prepared_hits==1
    assert fresh.jit_calls==fresh.fallback_calls==0
