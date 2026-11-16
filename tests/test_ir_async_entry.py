"""Real coroutine and async-generator entry without compile-time body execution."""
import os,subprocess,sys
from pathlib import Path
import pytest
pytestmark=pytest.mark.slow
@pytest.mark.parametrize('case',['coroutine','async_generator','coroutine_throw','async_generator_hooks_and_throw','coroutine_seed_decline'])
def test_real_async_entry(case):
    root=Path(__file__).resolve().parents[1]
    result=subprocess.run([sys.executable,str(root/'tests/async_entry_cases.py'),case],cwd=root,env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src')),capture_output=True,text=True,timeout=90,creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(case,result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout
