"""Real compiler passes through compiled parents and managed analysis children."""
import pytest
from recompyler import heap

def scalar_subject(value):return value+1
def child_subject(value):return value*2
def call_subject(value):return child_subject(value)+1

def program_for(fn):
    program=heap._Program(fn)
    program.entry.vars['value']=heap.INT
    return program

@pytest.mark.parametrize('fn',[scalar_subject,call_subject])
def test_real_settle_pass_preserves_generated_sources_and_type_fixedpoint(fn):
    plain,actual=program_for(fn),program_for(fn)
    plain.settle()
    region=heap.lift_structures(heap._Program.settle)
    assert region.run is not None,region.problem
    assert region(actual) is None
    assert [(info.fn,info.ret,info.source) for info in actual.order]==[(info.fn,info.ret,info.source) for info in plain.order]
    assert actual.changed is plain.changed is False
    assert region.compiled_calls==1 and region.fallback_calls==0
    assert region.managed_calls>0

@pytest.mark.parametrize('fn',[scalar_subject,call_subject])
def test_real_prepare_boundary_pass_preserves_all_boundary_proofs(fn):
    plain,actual=program_for(fn),program_for(fn)
    plain.settle();actual.settle();plain.prepare_boundary()
    region=heap.lift_structures(heap._Program.prepare_boundary)
    assert region.run is not None,region.problem
    assert region(actual) is None
    for name in ('rng_used','boundary_no_writeback','needs_recursion_budget','scalar_entry'):
        assert getattr(actual,name) is getattr(plain,name)
    assert region.compiled_calls==1 and region.fallback_calls==0
    assert region.managed_calls>0
