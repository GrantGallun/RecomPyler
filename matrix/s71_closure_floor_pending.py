import os
os.environ['NUMBA_NRT_STATS']='1'
import dis,json,statistics,subprocess,sys,time,timeit
from pathlib import Path
import psutil
psutil.Process().nice(psutil.BELOW_NORMAL_PRIORITY_CLASS)
from numba import njit
from numba.core import types
from numba.core.runtime import rtsys
from recompyler import _managed_native as refs,heap
from recompyler._managed_entry import root_argument,as_managed
from recompyler._closure_ops import new_cell,function_from_cells,bind_function_from_cells
from recompyler._managed_native import getitem_object


def loop_factory(count,owner):
    for index in range(count):
        def read():
            return owner
    return read


@njit
def body(pool,frame,count,store):
    code,ok=refs.pool_item(pool,0)
    namespace,ok=refs.pool_item(pool,1)
    owner,ok=refs.pool_item(pool,2)
    none,ok=refs.pool_item(pool,3)
    name,ok=refs.pool_item(pool,4)
    cell,ok=new_cell(owner)
    value=none
    for index in range(count):
        if store:
            ok=bind_function_from_cells(frame,name,code,namespace,(cell,),none,none)
        else:
            value,ok=function_from_cells(code,namespace,(cell,),none,none)
        if not ok:raise RuntimeError('function construction failed')
    if store:
        value,ok=getitem_object(frame,name)
        if not ok:raise RuntimeError('source slot read failed')
    return value

@njit
def adapter(pool,frame,count,store):return body(as_managed(pool),as_managed(frame),count,store)

sig=(root_argument,root_argument,types.intp,types.boolean)
adapter.compile(sig)
entry=adapter.overloads[sig].entry_point
owner=object();template=loop_factory(1,owner)
pool=(template.__code__,globals(),owner,None,'read')
plain=heap.lift_structures(loop_factory)
assert plain.run is not None,plain.problem
for call in (lambda:entry(pool,{},17,True),lambda:entry(pool,{},17,False),lambda:plain(17,owner)):
    fn=call();assert fn() is owner and fn.__code__ is template.__code__
assert plain.fallback_calls==0
allocations={}
for store in (False,True):
    before=rtsys.get_allocation_stats();fn=entry(pool,{},10000,store);after=rtsys.get_allocation_stats()
    allocations['bound' if store else 'value']=after.alloc-before.alloc
root=Path(__file__).resolve().parents[2]
lock=root/'TIMING.lock'
token='wave17-matrix-s71-'+str(os.getpid())
while True:
    try:
        lock.mkdir()
        break
    except FileExistsError:
        print('LOCK_BUSY',flush=True)
        if '--wait' not in sys.argv:raise SystemExit(2)
        time.sleep(30)
started=time.strftime('%Y-%m-%dT%H:%M:%SZ',time.gmtime())
(lock/'owner.txt').write_text('run: wave17-matrix\ntoken: '+token+'\npid: '+str(os.getpid())+'\nclass: development\nstart: '+started+'\npurpose: S71 closure floor CPython/plain/native/PyPy\nexpected: 30 seconds\n')
ledger=root/'WAVE17-MATRIX-PLAN.md'
with ledger.open('a') as stream:stream.write('TIMING-ACQUIRE S71: '+token+' at '+started+'; closure floor, concurrent correctness workers noted.\n')
try:
    n=10000
    calls={'cpython':lambda:loop_factory(n,owner),'plain_parent':lambda:plain(n,owner),'native_value':lambda:entry(pool,{},n,False),'native_bound':lambda:entry(pool,{},n,True)}
    samples={key:[] for key in calls}
    for pair in range(3):
        for key in (list(calls) if pair%2==0 else list(reversed(calls))):
            reps=3 if key=='plain_parent' else 20
            samples[key].append(timeit.timeit(calls[key],number=reps)/reps/n*1e9)
    source='''import timeit,json,statistics

def loop_factory(count,owner):
    for index in range(count):
        def read():
            return owner
    return read

owner=object()
for i in range(200):assert loop_factory(10000,owner)() is owner
samples=[timeit.timeit(lambda:loop_factory(10000,owner),number=20)/20/10000*1e9 for i in range(3)]
print(json.dumps({'warmup_iterations':2000000,'ns_per_creation':statistics.median(samples),'samples':samples}))
'''
    pypy=root/'pypy-compare/pypy-dist/pypy3.11-v8.0.1-win64/pypy3.exe'
    result=subprocess.run([str(pypy),'-c',source],capture_output=True,text=True,check=True)
    medians={key:statistics.median(value) for key,value in samples.items()}
    output={'operations_per_entry':n,'ns_per_creation':medians,'samples':samples,'nrt_allocations_per_entry':allocations,'pypy':json.loads(result.stdout),'concurrent_correctness':True,'no_speed_acceptance':True}
    print(json.dumps(output,indent=2),flush=True)
    Path('matrix/s71-closure-floor-result.json').write_text(json.dumps(output,indent=2)+'\n')
finally:
    if token in (lock/'owner.txt').read_text():
        (lock/'owner.txt').unlink();lock.rmdir()
    with ledger.open('a') as stream:stream.write('TIMING-RELEASE S71: '+token+' at '+time.strftime('%Y-%m-%dT%H:%M:%SZ',time.gmtime())+'.\n')
