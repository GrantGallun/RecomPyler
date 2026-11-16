"""S58 serial below-normal correctness, plain raw log only."""
from pathlib import Path
import ctypes,os,subprocess,sys
R=Path(__file__).resolve().parents[1]
k=ctypes.WinDLL("kernel32",use_last_error=True);k.GetCurrentProcess.restype=ctypes.c_void_p
k.SetPriorityClass.argtypes=(ctypes.c_void_p,ctypes.c_uint32)
assert k.SetPriorityClass(k.GetCurrentProcess(),0x4000)
temp=R/"inplace/flat-temp";temp.mkdir(exist_ok=True)
env=os.environ.copy();env.update(TEMP=str(temp),TMP=str(temp),PYTHONPYCACHEPREFIX=str(R/"inplace/flat-bytecode"),PYTHONPATH=str(R/"src"),PYTHONHASHSEED="0",OMP_NUM_THREADS="1",OPENBLAS_NUM_THREADS="1",MKL_NUM_THREADS="1",NUMBA_NUM_THREADS="1",RECOMPYLER_CACHE=str(R/"inplace/flat-cache"),NUMBA_CACHE_DIR=str(R/"inplace/flat-numba"))
log=R/"inplace"/sys.argv[1]
with log.open("wb") as f:
 p=subprocess.run(sys.argv[2:],cwd=R,env=env,stdout=f,stderr=subprocess.STDOUT,creationflags=subprocess.BELOW_NORMAL_PRIORITY_CLASS|subprocess.CREATE_NO_WINDOW)
print("exit",p.returncode,"log",str(log),flush=True);sys.exit(p.returncode)
