import pytest
from test_prepared_cache import artifact,load_source,standalone

@pytest.mark.parametrize('foreign',[False,True])
def test_slot_descriptor_owner_and_intrinsic_name_are_sealed(tmp_path,foreign):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'slots.py'
    source.write_text("class Box:\n    __slots__=('x','y')\n    def __init__(self):\n        self.x=2\n        self.y=8\nclass Other:\n    __slots__=('x','y')\ndef work(box):\n    box.x=1\n    return box.y\n")
    module=load_source(source)
    region=heap.lift_region(module.work)
    assert region(module.Box())==8 and region.compiled_calls==1
    section=heap.build_regions([(('work',9),module.work,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.work),pc.last_miss()
    module.Box.x=module.Other.x if foreign else module.Box.y
    assert index.bind(module.work)==[]
