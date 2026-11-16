"""Diagnostic only: validate complete build descriptors against real runner wrappers.
No native export is invoked, no compiler trust key is bypassed for execution.
"""
import sys,json,io,contextlib
from pathlib import Path
D=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(D/'integration-smoke20-v4/shim'),str(D)]
from recompyler import heap,_prepared as pc
from recompyler.runner import run_script
root=D/sys.argv[1];output=D/sys.argv[2]
assert json.loads((root/'summary.json').read_text())['complete'] and not (root/'FAILED.json').exists()
results=[]
def forbidden(*a,**kw): raise AssertionError('No native execution allowed in binding preflight')
for name in ('chaos','richards_super'):
    report=json.loads((root/name/'plan.json').read_text());section=report['plan']['aot_regions']
    checked=set()
    def lift(fn,*a,**kw):
        if fn.__qualname__ not in checked:
            checked.add(fn.__qualname__)
            for core in section['prepared']['cores']:
                if core['entry_id']['qualname']!=fn.__qualname__:continue
                pc.validate_core(core)
                program=pc._restore(core,fn,forbidden)
                assert program.guards_hold()
                results.append(dict(program=name,function=fn.__qualname__,core=pc.core_id(core),metadata_bound=True))
                del program
        return None
    heap.lift_region=lift
    script=Path(report['script']);old=D/'integration-smoke20-v4'/name
    command=json.loads((old/'saved-0.receipt.json').read_text())['command'];args=command[command.index(str(script))+1:]
    with contextlib.redirect_stdout(io.StringIO()),contextlib.redirect_stderr(io.StringIO()):
        result=run_script(script,args,root/name/'plan.json',False)
    assert result['exit_code'] in (None,0) and checked
with output.open('x') as f:json.dump(dict(complete=True,diagnostic_only=True,native_calls=0,compiler_key_acceptance=False,results=results),f,indent=2)
print(json.dumps(results))
