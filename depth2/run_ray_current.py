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
    # Idle lock-wait wrappers are not CPU jobs; count their real descendants.
    command="$ps=Get-CimInstance Win32_Process; $roots=@($ps | Where-Object { $_.Name -match '^(python|pytest).*' -and $_.CommandLine -match 'wave14-capture|wave16-inplace' -and $_.CommandLine -match 'run_locked.py' } | Select-Object -ExpandProperty ProcessId); $busy=@($ps | Where-Object { $_.Name -match '^(python|pytest|cl|link).*' -and (($_.CommandLine -match 'wave14-capture|wave16-inplace' -and $_.CommandLine -notmatch 'run_locked.py') -or $_.ParentProcessId -in $roots) }); $busy | Select-Object -ExpandProperty ProcessId"
    found=subprocess.run(['powershell','-NoProfile','-Command',command],capture_output=True,text=True)
    if found.returncode:raise RuntimeError('Cannot check other run processes')
    return bool(found.stdout.strip())
while True:
    if lock.exists() or other_heavy():time.sleep(30);continue
    try:lock.mkdir()
    except FileExistsError:time.sleep(30);continue
    break
(lock/'owner.txt').write_text(f'wave15-depth2\npurpose: S30 current ray short ablation ladder\nstart: {time.strftime("%Y-%m-%dT%H:%M:%S%z")}\nexpected duration: 10 minutes\n')
note('TIMING ACQUIRE '+time.strftime('%Y-%m-%dT%H:%M:%S%z')+' S30 current ray short ablation ladder')
try:
    import study,hashlib
    manifest=json.loads((D/'ray-current-input-manifest-v2.json').read_text())
    def verify():
        for path,digest in manifest.items():assert hashlib.sha256(Path(path).read_bytes()).hexdigest()==digest,path
    verify()
    run([sys.executable,D/'ray_current_counts.py'],'ray-current-counts',study.env('raytrace'))
    for mode in ('lists','tuples','float','float-tuples','float-stream'):
        run([sys.executable,D/'ray_current_build.py',mode],'ray-current-build-'+mode,study.env('raytrace'))
        print('Current-ray built',mode,flush=True)
    run([sys.executable,D/'ray_current_calls.py'],'ray-current-calls-build',study.env('raytrace'))
    for mode in ('current','lists','tuples','float','float-tuples','float-stream','calls-replay','calls-inline'):
        run([sys.executable,D/'ray_current_native.py',mode],'ray-current-smoke-'+mode,study.env('raytrace'))
    run([sys.executable,D/'ray_current_cohort.py'],'ray-current-cohort',study.env('raytrace'))
    verify()
    print('Current ray ladder complete',flush=True)

finally:
    (lock/'owner.txt').unlink()
    lock.rmdir()
    note('TIMING RELEASE '+time.strftime('%Y-%m-%dT%H:%M:%S%z')+' S30 current ray short ablation ladder')
