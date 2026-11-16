"""S80 first-suspension prefixes retain canonical CPython delegation."""
import dis
import pytest
from recompyler import heap
from recompyler._prepared import PreparedIndex
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower


def delegated(source):
    result=yield from source
    return result


@pytest.mark.parametrize('function',[delegated,PreparedIndex.iter_bind,heap._zero_parts])
def test_original_delegating_producer_prepares_first_prefix(function):
    graph=build(function)
    first=next(i.offset for i in dis.get_instructions(function) if i.opname=='RESUME')
    result=lower(graph,frame_entry=True,entry_offset=first)
    assert result.graph is graph and result.entry_offset==first and result.body_address>0


@pytest.mark.slow
@pytest.mark.parametrize('case',['delegation_protocol','list_iterator','iterator_lifetime','iterator_error','coroutine_rejection','original_bind','original_zero_parts'])
def test_actual_first_suspension_prefix(case):
    import os,subprocess,sys
    from pathlib import Path
    root=Path(__file__).resolve().parents[1]
    env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
    result=subprocess.run([sys.executable,str(root/'tests/generator_prefix_cases.py'),case],
        cwd=root,env=env,capture_output=True,text=True,timeout=90,
        creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(case,result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout
