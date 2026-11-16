"""Original-function executor installation is isolated from the default runtime."""
import os
from pathlib import Path
import subprocess
import sys
import pytest

pytestmark=pytest.mark.slow

@pytest.mark.parametrize('case',['identity','lifetime','error','defaults','code_change','active_close','cycle','observation','seed_decline','automatic_retention','explicit_resume_offset','measured_policy','install_code_race','observer_transition','observer_finalizers','observer_deletions','observer_unary_scope'])
def test_original_frame_installation(case):
    root=Path(__file__).resolve().parents[1]
    env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
    completed=subprocess.run([sys.executable,str(root/'tests'/'frame_install_cases.py'),case],
        cwd=root,env=env,capture_output=True,text=True,timeout=90,
        creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
    assert completed.returncode==0,(case,completed.stdout,completed.stderr)
    assert 'PASS '+case in completed.stdout
