"""S47 serial correctness runner: no timing lock, below-normal owned processes."""
from pathlib import Path
import ctypes,json,os,subprocess,sys,time,datetime
R=Path(__file__).resolve().parents[1];D=R/'inplace';W=R.parent
label=sys.argv[1];command=sys.argv[2:];out=D/'correctness'/label;out.mkdir(parents=True,exist_ok=False)
assert os.name=='nt'
kernel=ctypes.WinDLL('kernel32',use_last_error=True)
kernel.GetCurrentProcess.restype=ctypes.c_void_p
kernel.SetPriorityClass.argtypes=(ctypes.c_void_p,ctypes.c_uint32)
kernel.GetPriorityClass.argtypes=(ctypes.c_void_p,);kernel.GetPriorityClass.restype=ctypes.c_uint32
assert kernel.SetPriorityClass(kernel.GetCurrentProcess(),0x4000)
assert kernel.GetPriorityClass(kernel.GetCurrentProcess())==0x4000
# Only final acceptance holds restrict correctness to single files.
single=bool(command and '-m' in command and 'pytest' in command and sum(x.endswith('.py') for x in command)==1 and 'tests' not in command)
while True:
 lock=W/'TIMING.lock/owner.txt';owner=lock.read_text(errors='replace') if lock.exists() else ''
 if 'class: acceptance' not in owner or single:break
 print('WAIT acceptance exception; correctness otherwise never waits',flush=True);time.sleep(30)
cache=out/'cache';temp=out/'temp';temp.mkdir()
env=os.environ.copy();env.pop('PYTHONDONTWRITEBYTECODE',None)
env.update(WAVE16_CORRECTNESS_LABEL=label,PYTHONPATH=str(R/'src'),PYTHONPYCACHEPREFIX=str(out/'bytecode'),RECOMPYLER_CACHE=str(cache),RECOMPYLER_CACHE_DIR=str(cache),NUMBA_CACHE_DIR=str(out/'numba'),TEMP=str(temp),TMP=str(temp),PYTHONHASHSEED='0',OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1',NUMBA_NUM_THREADS='1')
start=datetime.datetime.now(datetime.timezone.utc).isoformat()
with (out/'stdout').open('wb') as stdout,(out/'stderr').open('wb') as stderr:
 child=subprocess.Popen(command,cwd=R,env=env,stdout=stdout,stderr=stderr,creationflags=subprocess.BELOW_NORMAL_PRIORITY_CLASS|subprocess.CREATE_NO_WINDOW)
 priority=kernel.GetPriorityClass(int(child._handle));assert priority==0x4000
 code=child.wait()
receipt=dict(label=label,command=command,exit_code=code,complete=code==0,execution_class='correctness',timing_eligible=False,process_priority='BELOW_NORMAL',priority_verified=priority,workers='serial; thread env1; total run cap4',start=start,end=datetime.datetime.now(datetime.timezone.utc).isoformat(),timing_lock_taken=False)
(out/'receipt.json').write_text(json.dumps(receipt,indent=2));print(json.dumps(receipt),flush=True)
sys.exit(code)
