"""S58 development timing lock, plain raw output, exact-token release."""
from pathlib import Path
import datetime,json,os,subprocess,sys,time,uuid
R=Path(__file__).resolve().parents[2];W=R.parent;L=W/'TIMING.lock'
label=sys.argv[1];token=str(os.getpid())+':'+uuid.uuid4().hex
stamp=lambda:datetime.datetime.now(datetime.timezone.utc).isoformat()
def note(text):
    with (W/'WAVE16-INPLACE-PLAN.md').open('a') as f:f.write(text+'\n')
while True:
    try:L.mkdir();break
    except FileExistsError:print('Waiting for timing lock',flush=True);time.sleep(30)
(L/'owner.txt').write_text('wave16-inplace\npurpose: '+label+'\nstart: '+stamp()+'\nexpected duration: 20 minutes\nclass: development\nowner token: '+token+'\n')
note('TIMING ACQUIRE '+stamp()+' '+label+' (S58 three-pair development; peer correctness may overlap).')
log=R/'inplace'/(label+'.txt')
env=os.environ.copy();temp=R/'inplace/flat-temp';temp.mkdir(exist_ok=True)
env.update(PYTHONPATH=str(R/'src'),TEMP=str(temp),TMP=str(temp),PYTHONPYCACHEPREFIX=str(R/'inplace/flat-bytecode'),RECOMPYLER_CACHE=str(R/'inplace/flat-cache'),NUMBA_CACHE_DIR=str(R/'inplace/flat-numba'),PYTHONHASHSEED='0',OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1',NUMBA_NUM_THREADS='1')
def activity(out):
    cmd="Get-CimInstance Win32_Process | Where-Object { $_.Name -like 'python*' } | Select-Object ProcessId,ParentProcessId,CommandLine | ConvertTo-Json -Compress"
    result=subprocess.run(['powershell','-NoProfile','-Command',cmd],capture_output=True)
    out.write(b'PEER_PROCESS_SNAPSHOT '+stamp().encode()+b'\n'+result.stdout+b'\n');out.flush()
try:
    with log.open('wb') as out:
        activity(out)
        child=subprocess.Popen(sys.argv[2:],cwd=R,env=env,stdout=out,stderr=subprocess.STDOUT)
        code=child.wait();activity(out)
    print('exit',code,'raw',str(log),flush=True)
finally:
    if 'child' in locals() and child.poll() is None:child.wait()
    assert 'owner token: '+token+'\n' in (L/'owner.txt').read_text()
    (L/'owner.txt').unlink();L.rmdir();note('TIMING RELEASE '+stamp()+' '+label)
sys.exit(code)
