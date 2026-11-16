import sys, os, tempfile, math, random, struct
sys.path.insert(0, 'src')
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="rc-claude-"))
from recompyler.heap import lift_region
from array import array
def fmod_(a, b): return a % b
def ffloor(a, b): return a // b
def imodf(a, b): return a % b
def shl(a, b): return a << b
def shr(a, b): return a >> b
def isin(x): return (isinstance(x, tuple), isinstance(x, int), isinstance(x, (float, list)), isinstance(x, object))
def zipenum(xs, ys):
    out = []
    for i, x in enumerate(xs, 3):
        out.append(i * x)
    for a, b in zip(xs, ys):
        out.append(a - b)
    for a, b, c in zip(xs, range(10, 0, -3), ys):
        out.append(a + b + c)
    for pair in enumerate(ys):
        out.append(pair[0] + pair[1])
    return out
def arrs(n):
    a = array('d', [0]) * n
    b = array('i', [1, 2, 3])
    c = array('d', [1, 2, 3])
    d = array('d')
    e = b * 2
    a[0] = 7
    d[:] = c[:]

    return a, b, c, d, e, c[1:], [1, 2] * n, n * [1.5, 2.5]
def same(x, y):
    if type(x) is not type(y): return False
    if isinstance(x, float): return struct.pack('d', x) == struct.pack('d', y)
    if isinstance(x, (tuple, list)): return len(x) == len(y) and all(same(a, b) for a, b in zip(x, y))
    if isinstance(x, array): return x.typecode == y.typecode and x.tobytes() == y.tobytes()
    return x == y
bad = 0; total = 0
def run(fn, cases):
    global bad, total
    r = lift_region(fn); native0 = 0
    for args in cases:
        try: want = fn(*args)
        except Exception as e: want = ('exc', type(e).__name__)
        try: got = r(*args)
        except Exception as e: got = ('exc', type(e).__name__)
        total += 1
        if not same(got, want):
            bad += 1
            if bad < 15: print('MISMATCH', fn.__name__, args, got, want)
    print(fn.__name__, 'problem=', r.problem, 'cases', len(cases))
F = [0.0, -0.0, 1.0, -1.0, 0.5, -0.5, 3.0, -3.0, 2.5, -2.5, 1e308, -1e308, 5e-324, -5e-324, float('inf'), float('-inf'), float('nan'), 7.25, -7.25, 1e-9, 123456789.125, 2**53+0.0, 0.1, -0.1, 0.3]
rnd = random.Random(5)
F += [rnd.uniform(-100, 100) for _ in range(40)] + [rnd.uniform(-1e15, 1e15) for _ in range(10)]
run(fmod_, [(a, b) for a in F for b in F])
run(ffloor, [(a, b) for a in F for b in F])
IN = [0, 1, -1, 2, -2, 7, -7, 3, 2**31, -2**31, 2**53, 2**53+1, -(2**53)-1, 2**62, -2**62, 2**63-1, -2**63, 12345]
run(imodf, [(a, b) for a in IN for b in F[:25]] + [(a, b) for a in F[:25] for b in IN])
run(ffloor, [(a, b) for a in IN for b in F[:25]] + [(a, b) for a in F[:25] for b in IN])
S = [0, 1, 2, 5, 31, 32, 61, 62, 63, 64, 65, 100, -1, -5, 2**40]
run(shl, [(a, b) for a in IN for b in S]); run(shr, [(a, b) for a in IN for b in S])
run(isin, [(1,), (1.5,), ((1, 2),), ([1, 2],), (True,), (None,), ("s",)])
run(zipenum, [([1, 2, 3], [4, 5, 6]), ([1.5, 2.5], [1.0, 2.0, 3.0]), ([], []), ([1, 2, 3, 4, 5], [9])])
run(arrs, [(0,), (3,), (17,)])
print('total', total, 'bad', bad)
r = lift_region(ffloor)
for a, b in [(1.0, 5e-324), (7.5, 2.0), (float('nan'), 1.0)]: r(a, b)
print({k: v for k, v in vars(r).items() if isinstance(v, (int, str)) and not k.startswith('__')})
r = lift_region(arrs); r(3); print({k: v for k, v in vars(r).items() if isinstance(v, (int, str)) and not k.startswith('__')})
