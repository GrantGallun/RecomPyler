"""Explicit generator resume slices retain original suspension machinery."""
import dis
import pytest
from recompyler import depmap
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler.ir.semantics import UnsupportedBytecode


def exchange(value):
    sent=yield value
    yield sent


def held_iterator(values):
    for value in values:
        sent=yield value
        if sent is not None:yield sent


@pytest.mark.parametrize('function',[exchange,held_iterator,depmap._own_nodes])
def test_each_original_resume_slice_uses_shared_lowerer(function):
    graph=build(function)
    for instruction in dis.get_instructions(function):
        if instruction.opname!='RESUME':continue
        body=lower(graph,frame_entry=True,entry_offset=instruction.offset)
        assert body.graph is graph and body.entry_offset==instruction.offset
        assert body.body_address and body.abi=='frame'
        # Source graph remains whole; lowering only normal paths reachable
        # from this original RESUME before a suspension (never a new generator).
        assert 'PyGen_New' not in str(body.module)


def test_lowering_does_not_execute_generator_body():
    effects=[]
    def values():
        effects.append('body')
        yield effects
    graph=build(values)
    offset=next(i.offset for i in dis.get_instructions(values) if i.opname=='RESUME')
    lower(graph,frame_entry=True,entry_offset=offset)
    assert effects==[]


def test_partial_generator_slice_does_not_claim_default_whole_body():
    with pytest.raises(UnsupportedBytecode,match='explicit.*resume|generator.*resume'):
        lower(build(exchange),frame_entry=True)
    with pytest.raises(UnsupportedBytecode,match='existing-frame|resume'):
        lower(build(exchange),entry_offset=4)


def test_generator_entry_is_an_original_resume_instruction():
    graph=build(exchange)
    invalid=next(i.offset for i in dis.get_instructions(exchange) if i.opname=='YIELD_VALUE')
    with pytest.raises(UnsupportedBytecode,match='RESUME'):
        lower(graph,frame_entry=True,entry_offset=invalid)


@pytest.mark.slow
@pytest.mark.parametrize('case',['creation_and_send','original_own_nodes','error_before_yield','multiple_resume_values','retained_iterator_and_sent_ownership'])
def test_actual_original_generator_resume(case):
    import os,subprocess,sys
    from pathlib import Path
    root=Path(__file__).resolve().parents[1]
    env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
    result=subprocess.run([sys.executable,str(root/'tests/generator_resume_cases.py'),case],
        cwd=root,env=env,capture_output=True,text=True,timeout=90,
        creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(case,result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout
