import json
import os
from pathlib import Path
import subprocess
import sys
import pytest


@pytest.mark.parametrize('mode',['stock','jit','native'])
def test_resident_worker_checks_outputs_without_recording_times(mode):
    env=dict(os.environ,PYTHON_JIT='0' if mode=='stock' else '1',PYTHONHASHSEED='0')
    env['PYTHONPATH']=os.pathsep.join([str(Path.cwd()/'src'),str(Path.cwd())])
    result=subprocess.run([sys.executable,'-m','bench.libs.timing_worker','json_encode','--mode',mode],
                          input='check\nquit\n',capture_output=True,text=True,env=env,timeout=60)
    assert result.returncode==0,result.stdout+result.stderr
    rows=[json.loads(line) for line in result.stdout.splitlines()]
    assert rows[0]['status']=='ready' and rows[1]['status']=='checked'
    assert rows[0]['digest']==rows[1]['digest']
    assert all('seconds' not in row for row in rows)
    assert rows[0]['jit'] is (mode!='stock')
    if mode=='native':
        assert rows[0]['native_entries']>0
        assert rows[0]['counted_wrappers_installed']==0
        assert rows[0]['ordinary_entries_live']>0



def test_resident_serve_can_digest_arrays_after_execution(monkeypatch):
    import io
    import bench.libs.timing_worker as worker
    events=[];result=object()
    def run():events.append('run');return result
    def digest(value):
        assert value is result
        events.append('digest');return 'same'
    monkeypatch.setattr(worker.sys,'stdin',io.StringIO('check\nquit\n'))
    monkeypatch.setattr(worker,'emit',lambda row:events.append(row['status']))
    worker.serve(run,'same',{'mode':'test'},digest=digest)
    assert events==['ready','run','digest','checked']
