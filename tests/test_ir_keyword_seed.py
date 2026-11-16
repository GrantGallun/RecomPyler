"""Fresh canonical keyword-only and suspended seed binding."""
import os
from pathlib import Path
import subprocess
import sys
import pytest

@pytest.mark.parametrize('case',['required_ordinary','variadic_keywords','positional_by_keyword','suspended_keywords','invalid_keywords','seed_owner_lifetime','public_candidate','real_helper'])
def test_canonical_keyword_seed(case):
    root=Path(__file__).resolve().parents[1]
    env=dict(os.environ,PYTHONPATH=str(root/'src'),PYTHON_JIT='1')
    result=subprocess.run([sys.executable,str(root/'tests/keyword_seed_cases.py'),case],cwd=root,env=env,
        capture_output=True,text=True,timeout=120,creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(case,result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout
