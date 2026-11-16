"""Real generator entry is tested with process-enabled CPython JIT."""
import os,subprocess,sys
from pathlib import Path
import pytest
pytestmark=pytest.mark.slow
@pytest.mark.parametrize('case',['initial','close_and_error','post_yield','reject_forged_generator','multiple_offsets','seed_decline'])
def test_real_generator_entry(case):
    root=Path(__file__).resolve().parents[1]
    env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
    result=subprocess.run([sys.executable,str(root/'tests/generator_entry_cases.py'),case],cwd=root,env=env,capture_output=True,text=True,timeout=90,creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(case,result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout
