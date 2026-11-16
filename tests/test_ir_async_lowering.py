"""Actual suspended frames, enabled in fresh CPython JIT processes."""
import os,subprocess,sys
from pathlib import Path
import pytest

@pytest.mark.slow
@pytest.mark.parametrize('case',['immediate','await_protocol','async_iteration','async_iterator_error','async_generator','real_region_helper','await_error','async_generator_lifetime','original_replay_admission'])
def test_original_async_frame_enters_counted_native_body(case):
    root=Path(__file__).resolve().parents[1]
    env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
    result=subprocess.run([sys.executable,str(root/'tests/async_lowering_cases.py'),case],cwd=root,env=env,capture_output=True,text=True,timeout=90,creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(case,result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout


@pytest.mark.parametrize('name',['region','replay','collect','drain'])
def test_real_async_compiler_helper_prepares_first_prefix(name):
    import dis
    from recompyler import heap,profiler
    from recompyler.ir import build
    from recompyler.ir.lower_llvm import lower
    async def values():yield None
    if name=='region':function=heap.Region._resumed
    elif name=='replay':function=heap._replay
    else:
        wrapper=(profiler._collected if name=='collect' else profiler._drained_async)(values)
        cells=dict(zip(wrapper.__code__.co_freevars,wrapper.__closure__))
        function=cells['function'].cell_contents
    graph=build(function)
    first=next(i.offset for i in dis.get_instructions(function) if i.opname=='RESUME')
    result=lower(graph,frame_entry=True,entry_offset=first)
    assert result.graph is graph and result.graph.code is function.__code__
    assert result.entry_offset==first and result.body_address>0


def test_async_after_first_resume_is_explicitly_deferred():
    import dis
    from recompyler import heap
    from recompyler.ir import build,UnsupportedBytecode
    from recompyler.ir.lower_llvm import lower
    first,after=[i.offset for i in dis.get_instructions(heap._replay) if i.opname=='RESUME']
    graph=build(heap._replay)
    assert lower(graph,frame_entry=True,entry_offset=first).body_address>0
    with pytest.raises(UnsupportedBytecode,match='first|prefix'):
        lower(build(heap._replay),frame_entry=True,entry_offset=after)
