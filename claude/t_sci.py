import sys, os, tempfile, time, copy, importlib.util
sys.path.insert(0, 'src'); sys.path.insert(0, r'D:\Code\Datathon\recompyler-codex-20261111\wave3-study\results-long-v2\shim')
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="rc-claude-"))
from recompyler.heap import lift_region
from array import array
spec = importlib.util.spec_from_file_location('scimark_mod', r'D:\Code\Datathon\recompyler-coverage\corpus\pyperformance-1.14.0\benchmarks\bm_scimark\run_benchmark.py')
m = importlib.util.module_from_spec(spec); sys.modules['scimark_mod'] = m; spec.loader.exec_module(m)
def state(x):
    if isinstance(x, array): return ('arr', x.typecode, x.tobytes())
    if isinstance(x, list): return [state(i) for i in x]
    if isinstance(x, tuple): return tuple(state(i) for i in x)
    if hasattr(x, '__dict__') and not isinstance(x, type): return (type(x).__name__, {k: state(v) for k, v in vars(x).items()})
    return (type(x).__name__, x)
def check(fn, make, reps=3):
    r = lift_region(fn)
    a1 = make(); a2 = make()
    t = time.perf_counter(); want = fn(*a1); tp = time.perf_counter() - t
    got = r(*a2)
    best = 1e9
    for _ in range(reps):
        a3 = make(); t = time.perf_counter(); r(*a3); best = min(best, time.perf_counter() - t)
    ok = state(got) == state(want) and state(a1) == state(a2)
    print('%-22s ok=%s py %.4fs rc %.5fs x%.1f problem=%s' % (fn.__name__, ok, tp, best, tp / best, r.problem), flush=True)
which = sys.argv[1:] or ['sor', 'lu', 'mc', 'sparse']
if 'sor' in which:
    check(m.SOR_execute, lambda: (1.25, m.Array2D(100, 100), 10, m.Array2D))
if 'lu' in which:
    def mk():
        rnd = m.Random(7); A = rnd.RandomMatrix(m.ArrayList(100, 100)); return (m.ArrayList(100, 100), A, array('i', [0]) * 100)
    check(m.LU, mk)
if 'mc' in which:
    check(m.MonteCarlo, lambda: (100000,))
if 'sparse' in which:
    check(m.bench_SparseMatMult, lambda: (20, 1000, 50000))
