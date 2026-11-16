from pathlib import Path
import runpy,sys
R=Path(__file__).resolve().parents[2];W=R.parent
SHIM=W/"wave3-study/results-long-v2/shim"
SPECTRAL=Path("D:/Code/Datathon/recompyler-coverage/corpus/pyperformance-1.14.0/benchmarks/bm_spectral_norm/run_benchmark.py")
FFT=W/"wave5-study/results/drivers/scimark.py"
def spectral():
 sys.path.insert(0,str(SHIM))
 return runpy.run_path(str(SPECTRAL),run_name="_wave16_spectral")
def fft():
 sys.path.insert(0,str(SHIM))
 text=FFT.read_text();scope={"__name__":"_wave16_fft","__file__":str(FFT)}
 exec(compile(text.split("import sys as _sys")[0],str(FFT),"exec"),scope)
 return scope
