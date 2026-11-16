from pathlib import Path
import shutil,subprocess,sys
R=Path(__file__).resolve().parents[2];out=R/"inplace"/sys.argv[1]
subprocess.run([sys.executable,str(R/"inplace/flat-preparation/setup_flat.py"),"build_ext","--force","--build-lib",str(out/"lib"),"--build-temp",str(out/"temp")],cwd=R,check=True)
paths=list((out/"lib/recompyler").glob("_flat_native*.pyd"));assert len(paths)==1
shutil.copy2(paths[0],R/"src/recompyler"/paths[0].name)
print("Built",paths[0])
