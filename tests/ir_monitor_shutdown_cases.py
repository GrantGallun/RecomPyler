"""Actual compiled monitoring activation must preserve CPython executor lists."""
import sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))
from ir_self_host import CountedBody,install_candidate
from recompyler.ir import compile_function,_entry_native
from recompyler.monitor import CallMonitor
functions=[CallMonitor.__enter__,CallMonitor.__init__,CallMonitor._callbacks,CallMonitor.start]
owners={}
for function in functions:
    compile_function(function,strict=True)
    code,original=_entry_native._compilation_owner(function)
    owner=CountedBody(original)
    _entry_native.forget_compilation(function)
    _entry_native.prepare_frame_entry(function,owner.body_address,owner,code)
    owners[function]=owner
for function in functions: assert install_candidate(function)
def target(value): return value+1
try:
    with CallMonitor([__file__],backend='python',bias=0,yield_bias=0):
        assert target(3)==4
    assert all(owner.calls.value==1 for owner in owners.values()),[owner.calls.value for owner in owners.values()]
finally:
    for function in functions:_entry_native.forget_compilation(function)
print('PASS actual monitoring activation native=4',flush=True)
