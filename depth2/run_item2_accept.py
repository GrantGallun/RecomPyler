"""Reuse wave13 build and fresh-process confirmation; never write prior evidence."""
from pathlib import Path
import json, os, subprocess, sys, time
D=Path(__file__).resolve().parent
ROOT=D.parent.parent
ledger=ROOT/'WAVE15-DEPTH2-PLAN.md'
lock=ROOT/'TIMING.lock'
def note(s):
    with ledger.open('a',encoding='utf-8') as f:f.write(s+'\n')
def run(cmd,stem,env):
    with (D/(stem+'.stdout')).open('wb') as out,(D/(stem+'.stderr')).open('wb') as err:
        p=subprocess.run([str(x) for x in cmd],stdout=out,stderr=err,env=env,cwd=D.parent)
    if p.returncode:raise RuntimeError(f'{stem}: exit {p.returncode}; see logs')
def other_heavy():
    command="Get-CimInstance Win32_Process | Where-Object { $_.Name -match '^(python|pytest).*' -and $_.CommandLine -match 'wave14-capture' } | Select-Object -ExpandProperty ProcessId"
    found=subprocess.run(['powershell','-NoProfile','-Command',command],capture_output=True,text=True)
    if found.returncode:raise RuntimeError('Cannot check other run processes')
    return bool(found.stdout.strip())
while True:
    if lock.exists() or other_heavy():time.sleep(30);continue
    try:lock.mkdir()
    except FileExistsError:time.sleep(30);continue
    break
(lock/'owner.txt').write_text(f'wave15-depth2\npurpose: Item 2 final suite and four-kernel acceptance\nstart: {time.strftime("%Y-%m-%dT%H:%M:%S%z")}\nexpected duration: 18 minutes\n')
note('TIMING ACQUIRE '+time.strftime('%Y-%m-%dT%H:%M:%S%z')+' Item 2 final suite and four-kernel acceptance')
try:
    import study
    for filename in ('scalar.py','escape.py','heap.py','facts.py'):
        assert study.sha(D.parent/'src/recompyler'/filename)==study.sha(D/'product-sources-v2/scalar-abc-v1/src/recompyler'/filename),filename
    env=study.env('raytrace')
    env['PYTHONPATH']=str(D.parent/'src')
    env['RECOMPYLER_CACHE_DIR']=str(D/'item2-final-suite-cache')
    env['NUMBA_CACHE_DIR']=str(D/'item2-final-numba-cache')
    run([sys.executable,'-m','pytest','-q','tests','--basetemp',D/'item2-final-pytest-temp'],'item2-final-suite',env)
    print('full suite passed',flush=True)
    for n in ('barnes_hut','fannkuch','scimark'):
        script='build_scalar_candidate.py' if n=='barnes_hut' else 'build_product.py'
        run([sys.executable,D/script,'scalar-abc-v1',n],f'build-scalar-abc-v1-{n}',study.env(n))
        print('built',n,flush=True)
    run([sys.executable,D/'item2_accept_cohort.py'],'item2-accept-cohort',study.env('fannkuch'))
    print('acceptance cohort passed',flush=True)

finally:
    (lock/'owner.txt').unlink()
    lock.rmdir()
    note('TIMING RELEASE '+time.strftime('%Y-%m-%dT%H:%M:%S%z')+' Item 2 final suite and four-kernel acceptance')
