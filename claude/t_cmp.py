import sys, os, tempfile
sys.path.insert(0, 'src'); sys.path.insert(0, 'tests')
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="rc-claude-"))
from recompyler.heap import lift_region
from array import array
from test_region_callables_arrays import same, outcome
def eq(a, b): return (a == b, a != b)
def eq_list(a, b): return a == [1.0, 2.0]
def contains(a, x): return x in a
def summed(a): return sum(a), len(a), min(a[0], a[1])
def truthy(a): return (1 if a else 0)
def both(a, b):
    n = 0
    for x in a:
        for y in b:
            if x == y: n += 1
    return n
def test(fn, *argsets):
    r = lift_region(fn)
    for args in argsets:
        w, g = outcome(fn, args), outcome(r, args)
        print(fn.__name__, 'OK' if same(g, w) else 'MISMATCH %r %r' % (g, w), 'problem=%s compiled=%s' % (r.problem, r.compiled_calls))
A = lambda *v: array('d', v); I_ = lambda *v: array('i', v)
test(eq, (A(1, 2), A(1, 2)), (A(1, 2), A(1, 3)), (A(1, 2), A(1, 2, 3)))
test(eq, (A(1, 2), I_(1, 2)))
test(eq, (A(1, 2), [1.0, 2.0]))
test(eq_list, (A(1, 2), 0))
test(contains, (A(1, 2), 2.0), (A(1, 2), 2), (I_(1, 2), 2), (I_(1, 2), 2.0))
test(summed, (A(1, 2),), (I_(4, 2),))
test(truthy, (A(),), (A(1),))
test(both, (A(1, 2), I_(1, 2)))
