import gc
import weakref
from test_prepared_cache import SOURCE,load_source,standalone

def test_unused_native_method_does_not_pin_detached_owner(tmp_path):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'native_lifetime.py'
    source.write_text(SOURCE+"\nevents=[]\nclass Sentinel:\n    def __del__(self): events.append('destroyed')\nRNG=random.Random()\nRNG.payload=Sentinel()\nBox.unused=RNG.random\n")
    module=load_source(source)
    region=heap.lift_region(module.read)
    assert region(module.Box(10))==10 and region.compiled_calls==1
    section=heap.build_regions([(('read',module.read.__code__.co_firstlineno),module.read,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.read),pc.last_miss()
    fast=heap.lift_region(module.read,index.exports,prepared=index)
    assert fast(module.Box(10))==10 and fast.aot_calls==1
    reference=weakref.ref(module.RNG.payload)
    module.Box.unused=None
    module.RNG=None
    gc.collect()
    assert reference() is None and module.events==['destroyed']
