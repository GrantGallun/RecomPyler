from test_prepared_cache import artifact

def test_post_lowering_entry_and_order_can_include_infos_outside_registry(artifact):
    pc,heap,module,source,section=artifact
    region=heap.lift_region(module.work)
    assert region(module.Box(10),[])[2]==18
    program=next(p for p in region.programs.values() if getattr(p,'run',None))
    before=program.functions
    program.functions={k:v for k,v in before.items() if v is not program.entry}
    try:
        core=pc.capture(program,export='r0',plan_key={},build_key={})
        execution=core['execution']
        assert execution['functions'][execution['entry_function']]['name']==program.entry.name
        assert len(execution['order'])==len(program.order)
    finally: program.functions=before
