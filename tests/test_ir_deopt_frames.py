"""Real executor deopt cases in a process with its CPython JIT enabled."""
import os
from pathlib import Path
import subprocess
import sys
import pytest


@pytest.mark.slow
@pytest.mark.parametrize('case',['normal','pending','pending_uncaught','generator_normal','generator_pending'])
def test_actual_frame_deopt(case):
    root=Path(__file__).resolve().parents[1]
    result=subprocess.run([sys.executable,str(root/'tests/deopt_frame_cases.py'),case],
        cwd=root,env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src')),
        capture_output=True,text=True,timeout=90,
        creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
    assert result.returncode==0,(result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout
