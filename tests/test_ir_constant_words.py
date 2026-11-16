"""Compile-time immortal words preserve CPython's actual tagged references."""
import dis,sys,types
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler import _structure_ops_native as provider


def singleton(flag):
    while flag:flag=False
    return None


def literal(flag):
    while flag:flag=False
    return 'word_constant_marker'


def helper_calls(body):
    return [instruction for block in body.module.get_global('body').blocks
            for instruction in block.instructions
            if instruction.opname=='call' and getattr(instruction.callee,'name','')=='rc_ir_frame_word_newref']


def test_header_derived_immortality_query_distinguishes_mortal_objects():
    marker=object()
    assert provider.is_immortal(None) is True
    assert provider.is_immortal(True) is True
    assert provider.is_immortal(marker) is False


def test_immortal_constant_words_remove_helper_calls_and_keep_a_control():
    optimized=lower(build(singleton),frame_entry=True,constant_words=True)
    baseline=lower(build(singleton),frame_entry=True,constant_words=False)
    assert not helper_calls(optimized)
    assert helper_calls(baseline)


def test_mortal_forged_constant_keeps_original_new_reference_path():
    marker=object();constants=tuple(marker if value=='word_constant_marker' else value for value in literal.__code__.co_consts)
    function=types.FunctionType(literal.__code__.replace(co_consts=constants),globals())
    body=lower(build(function),frame_entry=True,constant_words=True)
    assert helper_calls(body)


def test_all_original_contract_constant_words_follow_live_immortality():
    from recompyler.ir.semantics import contract
    graph=build(contract);body=lower(graph,frame_entry=True,constant_words=True)
    mortal={id(graph.code.co_consts[op.attributes['oparg']]) for block in graph.blocks.values()
            for op in block.operations if op.name=='constant' and not provider.is_immortal(graph.code.co_consts[op.attributes['oparg']])}
    for instruction in helper_calls(body):
        assert any(str(address) in str(instruction) for address in mortal)

import pytest

@pytest.mark.slow
@pytest.mark.parametrize('case',['contract','mortal_lifetime','error_handoff'])
def test_original_frame_constant_words(case):
    import os,subprocess
    from pathlib import Path
    root=Path(__file__).resolve().parents[1]
    result=subprocess.run([sys.executable,'tests/constant_word_cases.py',case],cwd=root,
        env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src')),
        capture_output=True,text=True,timeout=90,creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(case,result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout
