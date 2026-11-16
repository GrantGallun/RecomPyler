"""S102 CPU fixtures from the existing local pyperformance corpus; no downloads.

Original source is loaded read-only, without external bytecode writes. Wrappers
return semantic state, never elapsed-time values. Image writers capture bytes in
memory. Poker uses its public in-process API and timing-free result dictionary.
"""
from contextlib import contextmanager,redirect_stdout
import hashlib
import importlib
import importlib.util
import io
import os
from pathlib import Path
import sys
import time
import types
from .workloads import Workload

ROOT=Path(__file__).resolve().parents[2]
NAMES=('nbody','spectral_norm','richards','raytrace','chaos','deltablue','go','float','fannkuch','nqueens','poker','scimark')
REPEATS={'richards':16,'raytrace':8,'chaos':8,'deltablue':16,'go':1,'float':16,'fannkuch':16,'nqueens':8,'poker':1,'scimark':32}


def corpus_root():
    return Path(os.environ.get('RECOMPYLER_CPU_CORPUS',str(ROOT.parent.parent/'recompyler-coverage/corpus/pyperformance-1.14.0/benchmarks')))


def poker_root():
    return Path(os.environ.get('POKER_BOT',str(ROOT.parent.parent/'heads-up-bot')))


@contextmanager
def no_bytecode_writes():
    previous=sys.dont_write_bytecode;sys.dont_write_bytecode=True
    try:yield
    finally:sys.dont_write_bytecode=previous


def load_fixture(name,*,corpus=None):
    path=(Path(corpus) if corpus is not None else corpus_root())/('bm_'+name)/'run_benchmark.py'
    if not path.is_file():raise ModuleNotFoundError('local CPU fixture unavailable: '+str(path))
    data=path.read_bytes();module_name='_recompyler_cpu_'+name
    spec=importlib.util.spec_from_file_location(module_name,path)
    module=importlib.util.module_from_spec(spec)
    shim=types.ModuleType('pyperf');shim.perf_counter=time.perf_counter
    shim.python_implementation=lambda:'PyPy' if sys.implementation.name=='pypy' else 'CPython'
    shim.python_has_jit=lambda:bool(getattr(sys,'_jit',None) and sys._jit.is_enabled())
    missing=object();previous=sys.modules.get('pyperf',missing)
    sys.modules[module_name]=module;sys.modules['pyperf']=shim
    try:
        with no_bytecode_writes():exec(compile(data,str(path),'exec'),module.__dict__)
    except BaseException:
        sys.modules.pop(module_name,None);raise
    finally:
        if previous is missing:sys.modules.pop('pyperf',None)
        else:sys.modules['pyperf']=previous
    module._fixture_sha256=hashlib.sha256(data).hexdigest()
    return module


def fixture_identity():
    digest=hashlib.sha256()
    for name in NAMES:
        path=poker_root()/'benchmark.py' if name=='poker' else corpus_root()/('bm_'+name)/'run_benchmark.py'
        digest.update(name.encode());digest.update(str(path.resolve()).encode())
        digest.update(path.read_bytes() if path.is_file() else b'unavailable')
    return digest.hexdigest()


def _nbody(m):
    saved=[(list(position),list(velocity)) for position,velocity,mass in m.SYSTEM]
    def run():
        for (position,velocity,mass),(old_position,old_velocity) in zip(m.SYSTEM,saved):
            position[:]=old_position;velocity[:]=old_velocity
        m.offset_momentum(m.BODIES['sun']);m.advance(.01,1000)
        return m.report_energy(),[(list(position),list(velocity),mass) for position,velocity,mass in m.SYSTEM]
    return run


def _spectral(m):
    def run():
        u=[1.0]*40
        for _ in range(10):v=m.eval_AtA_times_u(u);u=m.eval_AtA_times_u(v)
        return u,v
    return run


def _richards(m):
    def run():
        m.taskWorkArea=m.TaskWorkArea()
        verdict=m.Richards().run(1)
        if not verdict:raise ValueError('Richards invariant failed')
        return verdict,m.taskWorkArea.holdCount,m.taskWorkArea.qpktCount
    return run


def _raytrace(m):
    images=[]
    def capture(canvas,filename):images.append(canvas.bytes.tobytes())
    m.Canvas.write_ppm=capture
    def run():
        images.clear();m.bench_raytrace(1,20,20,'capture')
        return images[0]
    return run


def _chaos(m):
    images=[];calls=[]
    def capture(image,filename):images.append(b''.join(bytes(row) for row in image))
    m.write_ppm=capture
    class Runner:
        metadata={}
        def bench_func(self,name,function,*args):calls.append((function,args))
    args=types.SimpleNamespace(thickness=.25,width=40,height=40,iterations=1000,filename='capture',rng_seed=12345)
    m.main(Runner(),args)
    function,arguments=calls[0]
    def run():
        images.clear();function(*arguments)
        return images[0]
    return run


def _delta(m):
    def run():
        output=io.StringIO()
        with redirect_stdout(output):m.delta_blue(100)
        if output.getvalue():raise ValueError('DeltaBlue invariant failed: '+output.getvalue())
        return m.planner.current_mark
    return run


def _float(m):
    def run():
        point=m.benchmark(10000)
        return point.x,point.y,point.z
    return run


def _scimark(m):
    from array import array
    def run():
        random=m.Random(7);grid=random.RandomMatrix(m.Array2D(20,20))
        m.SOR_execute(1.25,grid,10,m.Array2D)
        original=random.RandomMatrix(m.ArrayList(16,16));lu=m.ArrayList(16,16);pivot=array('i',[0])*16
        m.LU(lu,original,pivot)
        data=random.RandomVector(64);m.FFT_transform(64,data);m.FFT_inverse(64,data)
        n=32;x=random.RandomVector(n);values=random.RandomVector(n*4);y=array('d',[0])*n
        rows=array('i',[i*4 for i in range(n+1)]);columns=array('i',[(row+7*j)%n for row in range(n) for j in range(4)])
        m.SparseCompRow_matmult(n,y,values,rows,columns,x,4)
        return list(grid.data),[list(row) for row in lu.data],list(pivot),list(data),list(y),m.MonteCarlo(2000)
    return run


def _poker():
    path=poker_root()
    if not (path/'benchmark.py').is_file():raise ModuleNotFoundError('local poker CPU fixture unavailable: '+str(path))
    for key,folder in (('NUMBA_CACHE_DIR','numba'),('CUDA_CACHE_PATH','cuda')):
        directory=ROOT/'.cache'/folder;directory.mkdir(parents=True,exist_ok=True)
        os.environ[key]=str(directory)
    sys.path.insert(0,str(path))
    with no_bytecode_writes():module=importlib.import_module('benchmark')
    if Path(module.__file__).resolve()!=(path/'benchmark.py').resolve():raise ValueError('different poker benchmark module already loaded')
    def run():
        with no_bytecode_writes():result=module.play_pair('adaptive','equity',2,'recompyler-workload')
        return result.to_dict(include_timing=False,include_logs=False)
    return module,run


def prepare(name):
    if name=='poker':module,run=_poker()
    else:
        module=load_fixture(name)
        factories={'nbody':_nbody,'spectral_norm':_spectral,'richards':_richards,'raytrace':_raytrace,'chaos':_chaos,'deltablue':_delta,'float':_float,'scimark':_scimark}
        if name in factories:run=factories[name](module)
        elif name=='go':run=module.versus_cpu
        elif name=='fannkuch':run=lambda:module.fannkuch(7)
        elif name=='nqueens':run=lambda:list(module.n_queens(8))
        else:raise ValueError('unknown CPU fixture')
    if name!='poker':
        run.__module__=module.__name__;module._cpu_work=run
    return run


# Frozen S106 preset: more work, same inputs and semantic checks on every engine.
LONG_REPEATS={'nbody':4096,'spectral_norm':2048,'richards':128,'raytrace':512,'chaos':512,'deltablue':512,'go':8,'float':2048,'fannkuch':512,'nqueens':512,'poker':8,'scimark':2048}


def cpu_workloads(*,long=False):
    from functools import partial
    return {name:Workload(name,'benchmark' if name=='poker' else '_recompyler_cpu_'+name,partial(prepare,name),(LONG_REPEATS[name] if long else REPEATS.get(name,64))) for name in NAMES}
