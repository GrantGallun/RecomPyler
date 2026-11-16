import json
import os
from pathlib import Path
import subprocess
import sys
import pytest


@pytest.mark.parametrize('mode',['stock','jit','native','gpu'])
def test_gpu_resident_checks_exact_output_and_active_backend_without_timings(mode):
    env=dict(os.environ,PYTHON_JIT='1' if mode in ('jit','native') else '0',
             PYTHONPATH=os.pathsep.join([str(Path.cwd()/'src'),str(Path.cwd())]),
             RECOMPYLER_CACHE=str(Path.cwd()/'.cache/rc'),NUMBA_CACHE_DIR=str(Path.cwd()/'.cache/numba'))
    result=subprocess.run([sys.executable,'-m','bench.libs.gpu_timing_worker','affine-512','--mode',mode],
                          input='check\nquit\n',capture_output=True,text=True,env=env,timeout=90,
                          creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
    assert result.returncode==0,result.stdout+result.stderr
    rows=[json.loads(line) for line in result.stdout.splitlines()]
    assert rows[0]['status']=='ready' and rows[1]['status']=='checked'
    assert rows[0]['digest']==rows[1]['digest']
    assert all('seconds' not in row for row in rows)
    assert rows[0]['jit'] is (mode in ('jit','native'))
    if mode=='native':
        assert rows[0]['native_entries']>0 and rows[0]['counted_wrappers_installed']==0
        assert rows[0]['ordinary_entries_live']==1
    if mode=='gpu':
        assert rows[0]['backend']=='cuda' and rows[0]['transfers_included'] is True
        assert rows[0]['verified_shapes']==1


def test_gpu_timing_reports_both_jit_baselines_and_never_promotes_by_default(monkeypatch):
    from contextlib import nullcontext
    import bench.libs.gpu_timing_runner as runner
    created=[]
    class Resident:
        def __init__(self,name,mode,**kwargs):
            created.append((mode,kwargs['worker_module']));self.mode=mode
            self.ready=dict(status='ready',digest='same',jit=mode in ('jit','native'),warmup=8,
                            transfers_included=True,backend='cuda')
        def request(self,command):
            return dict(status='ok',digest='same',seconds={'stock':1.,'jit':.8,'native':2.,'gpu':.1}[self.mode])
        def close(self):pass
    monkeypatch.setattr(runner,'Resident',Resident)
    monkeypatch.setattr(runner,'timing_lock',lambda *args,**kwargs:nullcontext())
    monkeypatch.setattr(runner,'test_processes',lambda:[])
    row=runner.run_case(512)
    assert [mode for mode,_ in created]==['stock','jit','native','gpu']
    assert all(module=='bench.libs.gpu_timing_worker' for _,module in created)
    assert row['default_installation'] is False and row['gpu_candidate_faster'] is True
    assert row['summary']['gpu']['relative_to_cpython_jit']==.125
    assert row['summary']['gpu']['relative_to_native']==.05
    assert len(row['first'])==3
