import sys, os, tempfile, traceback
sys.path.insert(0, 'claude')
sys.argv = ['x', 'none']
import t_sci
from t_sci import m, lift_region, array
from recompyler import heap
which = os.environ.get('WHICH', 'sor')
if which == 'sor':
    fn, args = m.SOR_execute, (1.25, m.Array2D(100, 100), 10, m.Array2D)
elif which == 'mc':
    fn, args = m.MonteCarlo, (1000,)
else:
    rnd = m.Random(7); A = rnd.RandomMatrix(m.ArrayList(100, 100)); fn, args = m.LU, (m.ArrayList(100, 100), A, array('i', [0]) * 100)
r = lift_region(fn); r(*args)
for program in r.programs.values():
    print('program', program is not None and (program.broken, getattr(program, 'ahead_of_time', False), len(getattr(program.run, 'overloads', {}))))
orig = heap.Unsupported.__init__
def init(self, *a):
    orig(self, *a); print('UNSUPPORTED', a); traceback.print_stack(limit=5)
heap.Unsupported.__init__ = init
folder = tempfile.mkdtemp(prefix='rc-aot-')
try:
    out = heap.build_regions([((fn.__name__, fn.__code__.co_firstlineno), fn, r)], folder)
    print('RESULT', None if out is None else {k: (v if k != 'functions' else [(f['function'], f['seed_policy'], list(f['exports'])) for f in v]) for k, v in out.items() if k in ('functions', 'module')})
except Exception:
    traceback.print_exc()
