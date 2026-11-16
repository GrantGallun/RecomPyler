from pathlib import Path
import sys,subprocess
D=Path(__file__).resolve().parent
for n in ['barnes_hut','fannkuch','scimark','raytrace']:
 subprocess.run([sys.executable,str(D/'build_kernels.py'),sys.argv[1],n],check=True)
