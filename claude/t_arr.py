import sys, os, tempfile, time, copy
sys.path.insert(0, 'src')
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="rc-claude-"))
from recompyler.heap import lift_region
from array import array

def dot(a, b, idx):
    s = 0.0
    for k in range(len(a)):
        s += a[k] * b[idx[k]]
    a[0] = 3            # int stored in array('d') becomes a float
    idx[1] = idx[0] + 2
    return s
def over(idx):
    idx[0] = 1 << 40
def check(fn, *args):
    r = lift_region(fn)
    a1 = copy.deepcopy(args); a2 = copy.deepcopy(args)
    try: want = fn(*a1)
    except Exception as e: want = type(e)
    try: got = r(*a2)
    except Exception as e: got = type(e)
    print(fn.__name__, got == want and a1 == a2 and type(got) is type(want), 'problem=%s'%r.problem, got, a2 if a1!=a2 else '')
check(dot, array('d',[1.5,2.5,3.5]), array('d',[1,2,3]), array('i',[2,1,0]))
check(dot, array('d',[1.5,2.5,3.5]), array('d',[1,2,3]), array('q',[2,1,0]))
check(over, array('i',[2,1,0]))
check(over, array('q',[2,1,0]))
