import sys, os, tempfile, time
sys.path.insert(0, 'src')
os.environ.setdefault("RECOMPYLER_CACHE", tempfile.mkdtemp(prefix="rc-claude-"))
from recompyler.heap import lift_region

def eval_A(i, j):
    return 1.0 / ((i + j) * (i + j + 1) // 2 + i + 1)
def eval_times_u(func, u):
    return [func((i, u)) for i in range(len(list(u)))]
def eval_AtA_times_u(u):
    return eval_times_u(part_At_times_u, eval_times_u(part_A_times_u, u))
def part_A_times_u(i_u):
    i, u = i_u
    partial_sum = 0
    for j, u_j in enumerate(u):
        partial_sum += eval_A(i, j) * u_j
    return partial_sum
def part_At_times_u(i_u):
    i, u = i_u
    partial_sum = 0
    for j, u_j in enumerate(u):
        partial_sum += eval_A(j, i) * u_j
    return partial_sum

r = lift_region(eval_AtA_times_u)
for u in ([1]*130, [1.5]*130, [1]*130, [0.25*k for k in range(130)]):
    want = eval_AtA_times_u(u)
    got = r(list(u))
    print(type(got), got == want, [type(x) for x in got[:2]], getattr(r,'problem',None), getattr(r,'native_calls',None))
t=time.perf_counter(); 
for _ in range(100): eval_AtA_times_u(u)
a=time.perf_counter()-t; t=time.perf_counter()
for _ in range(100): r(u)
b=time.perf_counter()-t; print('py %.4f rc %.4f x%.1f'%(a,b,a/b))
print('compiled', r.compiled_calls, 'fallback', r.fallback_calls)
