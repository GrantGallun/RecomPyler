"""Unpack must consume the temporary container before any target callback."""
import gc
import pytest
from recompyler import heap

def unpack_targets(target,make):
    target.first,target.second,target.third=make()

@pytest.mark.parametrize('kind',[tuple,list])
def test_temporary_unpack_container_is_released_before_first_store(kind):
    region=heap.lift_structures(unpack_targets,callees=())
    assert region.run is not None,region.problem
    logs=[]
    for call in (unpack_targets,region):
        events=[];state={}
        def make():
            value=kind(([],[],[]))
            state['container']=id(value)
            state['elements']=tuple(map(id,value))
            return value
        class Target:
            def __setattr__(self,name,value):
                alive=any(type(obj) is kind and id(obj)==state['container'] and
                    len(obj)==3 and tuple(map(id,obj))==state['elements'] for obj in gc.get_objects())
                events.append((name,alive))
        assert call(Target(),make) is None
        logs.append(events)
    assert logs[0]==[('first',False),('second',False),('third',False)]
    assert logs[1]==logs[0]
    assert region.compiled_calls==1 and region.fallback_calls==0
