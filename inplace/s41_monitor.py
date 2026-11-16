"""S41 isolation comparison; existing complete Step0 snapshot and current source."""
from pathlib import Path
import json, os, subprocess, sys
D=Path(__file__).resolve().parent; R=D.parent
out=D/'s41-monitor-isolation-v1'; out.mkdir(exist_ok=False)
base=D/'bases/integration-native-shapes-s37'
assert json.loads((base/'complete.json').read_text())['complete']
rows=[]
for variant, source in [('step0',base/'src'),('current',R/'src')]:
 for repeat in range(3):
  code="import sys; sys.path.insert(0,sys.argv[1]); import recompyler.monitor; print(recompyler.monitor.__file__,flush=True); import pytest; raise SystemExit(pytest.main(['tests/test_monitor.py::MonitorTest::test_library_time_is_kept_apart','-q']))"
  p=subprocess.run([sys.executable,'-c',code,str(source)],cwd=R,capture_output=True,text=True)
  (out/f'{variant}-{repeat}.stdout').write_text(p.stdout,encoding='utf-8')
  (out/f'{variant}-{repeat}.stderr').write_text(p.stderr,encoding='utf-8')
  assert str(source) in p.stdout
  rows.append(dict(variant=variant,repeat=repeat,exit_code=p.returncode))
result=dict(complete=True,rows=rows)
(out/'complete.json').write_text(json.dumps(result,indent=2));print(json.dumps(result),flush=True)
