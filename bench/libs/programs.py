"""Fixed S94 programs. Held-out inputs are never used for selection/tuning."""
import importlib
from pathlib import Path
from bench.libs.workloads import Workload, workloads


def _nbody():
    def run():
        bodies=[[i*.1+1, i*.03-.2, 0.0] for i in range(12)]
        for step in range(120):
            for i, a in enumerate(bodies):
                for b in bodies[i+1:]:
                    dx=b[0]-a[0]; dy=b[1]-a[1]
                    force=.00001/(dx*dx+dy*dy+.01)
                    a[2]+=force; b[2]-=force
            for b in bodies: b[0]+=b[2]*.001
        return bodies
    return run


def _spectral():
    def run():
        u=[1.0]*65
        for _ in range(6):
            u=[sum(x/(((i+j)*(i+j+1)//2)+i+1) for j,x in enumerate(u)) for i in range(65)]
        return u
    return run


def _binarytrees():
    def tree(n): return (tree(n-1),tree(n-1)) if n else None
    def check(t): return 1 if t is None else 1+check(t[0])+check(t[1])
    return lambda: [check(tree(d)) for d in range(6,12)]


def selfcompile_targets():
    from tools.ir_self_host import live_functions
    root=Path(__file__).resolve().parents[2]/'src'
    modules=[importlib.import_module(name) for name in
             ('recompyler.ir.builder','recompyler.ir.lower_llvm','recompyler.ir.compiler')]
    return [fn for fn in live_functions(modules,{module.__name__ for module in modules}) if Path(fn.__code__.co_filename).is_relative_to(root)]


def _selfcompile():
    from recompyler.ir import compile_function, compilation_info
    from recompyler.ir._entry_native import forget_compilation
    from tools.ir_self_host import identity
    functions=selfcompile_targets()
    def run():
        result=[]
        for fn in functions:
            try:
                compile_function(fn,strict=True)
                info=compilation_info(fn)
                result.append([identity(fn),bool(info and info['compiled'])])
            except (ValueError,TypeError,NotImplementedError) as error:
                result.append([identity(fn),type(error).__name__])
            finally: forget_compilation(fn)
        return result
    return run


def _held_csv():
    import csv, io
    text='name,value,comment\n'+''.join('row%d,%d,"a,b"\n'%(i,i*i) for i in range(300))
    return lambda: list(csv.reader(io.StringIO(text)))


def _held_decimal():
    from decimal import Decimal, localcontext
    def run():
        with localcontext() as ctx:
            ctx.prec=34
            return str(sum((Decimal(i)/Decimal(i+7) for i in range(1,700)),Decimal(0)))
    return run


def _held_graph():
    def run():
        edges={i:((i+7)%201,(i*3+1)%201) for i in range(201)}
        seen={0}; queue=[0]
        for i in queue:
            for j in edges[i]:
                if j not in seen: seen.add(j);queue.append(j)
        return queue
    return run


SPLITS=('train','heldout','libraries','cpu','cpu_long')


def manifest(split='train'):
    if split=='libraries':return workloads()
    if split in ('cpu','cpu_long'):
        from .cpu_programs import cpu_workloads
        return cpu_workloads(long=split=='cpu_long')
    if split=='train':
        result=workloads()
        for name,prepare in [('selfcompile',_selfcompile),('nbody',_nbody),('spectral_norm',_spectral),('binary_trees',_binarytrees)]:
            result[name]=Workload(name,'recompyler' if name=='selfcompile' else 'bench',prepare,1 if name=='selfcompile' else 64)
        return result
    if split=='heldout':
        return {name:Workload(name,'stdlib',prepare) for name,prepare in
                [('held_csv',_held_csv),('held_decimal',_held_decimal),('held_graph',_held_graph)]}
    raise ValueError('unknown benchmark group')
