"""Passive entry observation must coexist with the authenticated flat guard."""
from pathlib import Path
import os
import subprocess
import sys
import pytest


@pytest.mark.parametrize('order',['flat-first','entry-first','foreign-hook'])
def test_flat_guard_recognizes_only_the_canonical_passive_audit(order,tmp_path):
    source='''
import sys
from recompyler.ir.frameless import prepare_frameless
if sys.argv[1]=='flat-first':from recompyler._flat import FlatLifted
def identity(value):return value
candidate=prepare_frameless(identity)
assert candidate is not None
candidate.install();candidate.close()
from recompyler._flat import FlatLifted
if sys.argv[1]=='foreign-hook':sys.addaudithook(lambda event,args:None)
def first(values):return values[0]
wrapped=FlatLifted(first)
assert wrapped([1.25])==1.25
if sys.argv[1]=='foreign-hook':
 assert wrapped.flat_calls==0 and wrapped.fallback_calls==1
else:
 assert wrapped.compiled_calls==1 and wrapped.flat_calls==1 and wrapped.fallback_calls==0,wrapped.problem
 assert wrapped.last_audit['commits']==1
print('PASS',sys.argv[1])
'''
    root=Path(__file__).resolve().parents[1]
    env=dict(os.environ,PYTHONPATH=os.pathsep.join((str(root/'src'),str(root))),PYTHON_JIT='1')
    script=tmp_path/'flat_audit_case.py';script.write_text(source)
    result=subprocess.run([sys.executable,str(script),order],cwd=root,env=env,
        capture_output=True,text=True,timeout=120,creationflags=0x08004000 if os.name=='nt' else 0)
    assert result.returncode==0,(result.stdout,result.stderr)
