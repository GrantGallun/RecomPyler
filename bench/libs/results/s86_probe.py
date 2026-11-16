"""S86 diagnostic: raw GPU bytes, LTO options and generated arithmetic."""
import ctypes, json, sys
from pathlib import Path
ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
root=Path(__file__).resolve().parents[3]
sys.path[:0]=[str(root/'src'),str(root/'tests')]
import numpy as np
from recompyler.lift import lift
from test_backends import particle
fn=lift(particle)
launch=fn._launch
observed={}
def capture(backend,driver,out,status,arrays):
    launch(backend,driver,out,status,arrays)
    observed[backend]=out.copy()
    if backend=='gpu':
        for kernel in driver.overloads.values():
            lib=kernel._codelibrary
            print('lto',lib._lto,'nvvm_options',lib._nvvm_options)
            ptx=lib.get_lto_ptx() if lib._lto else lib.get_asm_str()
            Path(__file__).with_name('s86-before.ptx').write_text(ptx)
            print('fma_lines',[s.strip() for s in ptx.splitlines() if 'fma.' in s][:8])
fn._launch=capture
original_driver=fn._driver
def trace_driver(*args, **kwargs):
    try: return original_driver(*args, **kwargs)
    except Exception:
        import traceback
        traceback.print_exc()
        raise
fn._driver=trace_driver
rows=[(i/73,0.5,0.0125) for i in range(73)]
fn.map(rows,'gpu')
a,b=observed['gpu'],observed['cpu']
wrong=np.flatnonzero(a.view(np.uint64)!=b.view(np.uint64))
print('mismatch_rows',len(wrong),'of',len(a),'note',fn.gpu_note)
for i in wrong[:4]:print(int(i),float(a[i]).hex(),float(b[i]).hex())

