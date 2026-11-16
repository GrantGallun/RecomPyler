"""Ordinary real-frame seeds use CPython's canonical binding defaults."""
import os,subprocess,sys
from pathlib import Path
import pytest

@pytest.mark.slow
@pytest.mark.parametrize('case',['defaulted_keywords','variadic_keywords','required_keyword','actual_lowerer'])
def test_canonical_ordinary_seed_binding(case):
    root=Path(__file__).resolve().parents[1]
    environment=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
    result=subprocess.run([sys.executable,str(root/'tests/ordinary_seed_cases.py'),case],cwd=root,env=environment,capture_output=True,text=True,timeout=240,creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(case,result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout
