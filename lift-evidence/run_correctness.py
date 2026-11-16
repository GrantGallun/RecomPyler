"""Correctness-only execution: S47 below-normal priority, no timing claims."""
from pathlib import Path
import datetime
import hashlib
import json
import os
import subprocess
import sys
import time
R=Path(__file__).resolve().parents[1]
W=R.parent
D=R/'lift-evidence'

def stamp(): return datetime.datetime.now(datetime.timezone.utc).isoformat()
def sources():
    files=[p for p in (R/'src').rglob('*') if p.is_file() and p.suffix in {'.py','.c','.h','.numba','.pyd'}]
    files += list((R/'tests').rglob('*.py'))
    return {str(p.relative_to(R)):hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(files)}

def main():
    label,*cmd=sys.argv[1:]
    single=False
    if cmd and cmd[0]=='--single-file': single=True;cmd=cmd[1:]
    logs=D/'logs';logs.mkdir(exist_ok=True)
    receipt=logs/(label+'.receipt.json')
    assert not receipt.exists(),'Refuse receipt overwrite'
    while True:
        owner=W/'TIMING.lock/owner.txt'
        held=owner.read_text(errors='replace') if owner.exists() else ''
        if 'class: acceptance' not in held or single: break
        print('WAIT final acceptance: '+held,flush=True)
        time.sleep(30)
    before=sources()
    env=os.environ.copy()
    tmp=D/'temp';tmp.mkdir(exist_ok=True)
    env.update(PYTHONPATH=str(R/'src'),PYTHONPYCACHEPREFIX=str(tmp/'bytecode'),RECOMPYLER_CACHE=str(tmp/'cache'),RECOMPYLER_CACHE_DIR=str(tmp/'cache'),NUMBA_CACHE_DIR=str(tmp/'numba'),TEMP=str(tmp),TMP=str(tmp),PYTHONHASHSEED='0',OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1',NUMBA_NUM_THREADS='1')
    started=stamp()
    flags=subprocess.BELOW_NORMAL_PRIORITY_CLASS|subprocess.CREATE_NO_WINDOW if os.name=='nt' else 0
    with (logs/(label+'.stdout')).open('wb') as out,(logs/(label+'.stderr')).open('wb') as err:
        done=subprocess.run(cmd,cwd=R,env=env,stdout=out,stderr=err,creationflags=flags)
    after=sources()
    result={'label':label,'class':'correctness','command':cmd,'exit_code':done.returncode,'priority':'below-normal','max_workers':4,'start':started,'end':stamp(),'lock_observed_at_start':held,'source_unchanged':before==after,'source_before':before,'source_after':after,'note':'No reported timing; wall duration is not performance evidence.'}
    receipt.write_text(json.dumps(result,indent=2))
    with (W/'WAVE18-LIFT-PLAN.md').open('a',encoding='utf-8') as f: f.write('CORRECTNESS '+label+' exit='+str(done.returncode)+' source_unchanged='+str(before==after)+'; below-normal, <=4 workers, no timing lock under S47; receipt wave18-lift/lift-evidence/logs/'+label+'.receipt.json\n')
    print(json.dumps({k:v for k,v in result.items() if k not in {'source_before','source_after','lock_observed_at_start'}}),flush=True)
    assert before==after,'Source changed during correctness gate'
    return done.returncode
if __name__=='__main__': sys.exit(main())
