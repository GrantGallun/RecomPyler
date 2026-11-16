import sys, os, tempfile, traceback
sys.path.insert(0, 'claude'); sys.argv = ['x', 'none']
from t_sci import m, lift_region, array
from recompyler import heap
def lu_args():
    rnd = m.Random(7); A = rnd.RandomMatrix(m.ArrayList(100, 100)); return (m.ArrayList(100, 100), A, array('i', [0]) * 100)
def luf_args():
    rnd = m.Random(7); A = rnd.RandomMatrix(m.ArrayList(100, 100)); return (A, array('i', [0]) * 100)
cases = {'sor': (m.SOR_execute, (1.25, m.Array2D(100, 100), 10, m.Array2D)), 'mc': (m.MonteCarlo, (1000,)), 'lu': (m.LU, lu_args()), 'luf': (m.LU_factor, luf_args())}
entries = []
for name in sys.argv[1:] if False else os.environ.get('WHICH', 'sor,mc,lu,luf').split(','):
    fn, args = cases[name]; r = lift_region(fn); r(*args); entries.append(((fn.__name__, fn.__code__.co_firstlineno), fn, r))
try:
    out = heap.build_regions(entries, tempfile.mkdtemp(prefix='rc-aot-'))
    print('RESULT', [(f['function'], f['seed_policy']) for f in out['functions']])
except Exception as e:
    print('ERR', str(e)[:1500])
