"""The reviewed ownership pass only elides proved no-op stackref helpers."""
import dis
import pytest
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.types import ValueType


def identity_relation(left,right):return left is right


def owned_fields(left,right):return left.value is right.value


def short_circuit(value):return value is None or value is False


def returned_argument(value):return value


def protected(value):
    try:return value.value
    finally:value=None


def test_real_profile_hot_helper_has_a_verified_reference_plan():
    from recompyler.ir.refcount_lowering import prepare_reference_plan
    graph=build(ValueType.__eq__);result=prepare_reference_plan(graph)
    assert result is not None
    assert result.plan.in_states and result.skip_retire
    assert all(not actions for actions in result.plan.before.values())
    assert all(not actions for actions in result.plan.edges.values())


def test_owned_attribute_results_are_never_classified_as_noop_retirements():
    from recompyler.ir.refcount_lowering import prepare_reference_plan
    graph=build(owned_fields);result=prepare_reference_plan(graph)
    assert result is not None
    identity=next(op for block in graph.blocks.values() for op in block.operations if op.name=='is')
    assert not result.skip_retire.get(identity.offset)
    for block in graph.blocks.values():
        for op in block.operations:
            if op.name=='load_attr':assert result.skip_retire[op.offset]==frozenset({0})


def test_borrowed_or_immortal_copies_have_no_duplicate_reference_work():
    from recompyler.ir.refcount_lowering import prepare_reference_plan
    graph=build(short_circuit);result=prepare_reference_plan(graph)
    assert result is not None and result.skip_copy
    assert result.skip_copy <= {op.offset for block in graph.blocks.values() for op in block.operations if op.name=='copy'}


@pytest.mark.parametrize('function',[returned_argument,protected])
def test_unhandled_promotions_or_protected_state_keep_original_lowering(function):
    from recompyler.ir.refcount_lowering import prepare_reference_plan
    assert prepare_reference_plan(build(function)) is None
    result=lower(build(function),frame_entry=True)
    assert result.body_address and result.refcount_stats['active'] is False


def test_common_lowerer_consumes_plan_by_default_and_has_a_timing_control():
    optimized=lower(build(identity_relation),frame_entry=True)
    baseline=lower(build(identity_relation),frame_entry=True,refcounts=False)
    assert optimized.refcount_stats['active']
    assert optimized.refcount_stats['noop_closes']>=2
    assert baseline.refcount_stats=={'active':False,'noop_closes':0,'noop_dups':0}
    assert optimized.reference_plan is not None and baseline.reference_plan is None


@pytest.mark.slow
@pytest.mark.parametrize('case',['profile_hot_equality','owned_finalizers','owned_error','contains_finalizers'])
def test_actual_refcount_optimized_original_function(case):
    import os,subprocess,sys
    from pathlib import Path
    root=Path(__file__).resolve().parents[1]
    result=subprocess.run([sys.executable,str(root/'tests/refcount_lowering_cases.py'),case],
        cwd=root,env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src')),
        capture_output=True,text=True,timeout=90,
        creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(case,result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout
