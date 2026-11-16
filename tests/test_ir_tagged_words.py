"""Locally constructed refcount tags remain no-ops in unsupported ownership graphs."""
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from llvmlite import ir


def branching(value):
    mapping={'key':value}
    return (value is None) and mapping


def chained(value):
    mapping={'key':value}
    return value is None is None,mapping


def calls(body,name):
    return [instruction for block in body.module.get_global('body').blocks for instruction in block.instructions
            if instruction.opname=='call' and getattr(instruction.callee,'name','')=='rc_ir_frame_'+name]


def test_boolean_and_borrow_closes_need_no_whole_graph_plan():
    body=lower(build(branching),frame_entry=True)
    assert body.reference_plan is None
    assert not any(getattr(call.args[0],'opname',None) in ('or','select') for call in calls(body,'word_close'))
    baseline=lower(build(branching),frame_entry=True,refcounts=False)
    assert any(getattr(call.args[0],'opname',None)=='select' for call in calls(baseline,'word_close'))
    assert any(getattr(call.args[0],'opname',None)=='or' for call in calls(baseline,'word_close'))


def test_copy_of_proven_tagged_constant_is_the_original_word():
    body=lower(build(chained),frame_entry=True)
    assert body.reference_plan is None
    assert not any(isinstance(call.args[0],ir.Constant) for call in calls(body,'word_dup'))
    baseline=lower(build(chained),frame_entry=True,refcounts=False)
    assert any(isinstance(call.args[0],ir.Constant) for call in calls(baseline,'word_dup'))


def test_dynamic_owned_reference_copies_still_use_original_helper():
    def subject(value):
        mapping={'key':value}
        return value is int('1000') is value,mapping
    body=lower(build(subject),frame_entry=True)
    assert body.reference_plan is None
    assert any(getattr(call.args[0],'opname',None)=='call' for call in calls(body,'word_dup'))


import pytest

@pytest.mark.slow
@pytest.mark.parametrize('case',['owned_copy','error'])
def test_original_frame_tagged_retirement_and_error(case):
    import os,subprocess,sys
    from pathlib import Path
    root=Path(__file__).resolve().parents[1]
    result=subprocess.run([sys.executable,'tests/tagged_word_cases.py',case],cwd=root,
        env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src')),
        capture_output=True,text=True,timeout=90,creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(case,result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout
