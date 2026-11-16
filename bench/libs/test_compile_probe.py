import pytest
from bench.libs.compile_probe import PhaseTimer


def test_nested_phases_are_exclusive_and_count_exceptions():
    ticks=iter([0.0,1.0,4.0,7.0])
    timer=PhaseTimer(clock=lambda:next(ticks))
    def child(): raise ValueError('same error')
    nested=timer.wrap('child',child)
    parent=timer.wrap('parent',lambda:nested())
    with pytest.raises(ValueError,match='same error'):parent()
    assert timer.seconds=={'child':3.0,'parent':4.0}
    assert timer.calls=={'child':1,'parent':1}
    assert timer.stack==[]
