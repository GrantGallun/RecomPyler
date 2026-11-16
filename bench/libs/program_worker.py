"""One whole-program observation. No preparation hidden in a resident parent."""
import argparse
import json
import os
import sys
from time import perf_counter
from bench.libs.programs import manifest,SPLITS
from bench.libs.workloads import output_digest


def installation_snapshot(session):
    if session is None or session.report['installed']==0: return 0,[]
    from recompyler.libraries.hook import _functions
    from recompyler.ir import compilation_info
    identities=set();seen=set();count=0
    for name,module in tuple(sys.modules.items()):
        if module is None or not session.selected(name): continue
        for fn in _functions(module):
            if id(fn) in seen: continue
            seen.add(id(fn));info=compilation_info(fn)
            if info and info.get('installed'):
                count+=1
                identities.add(fn.__module__+':'+fn.__qualname__+':'+str(fn.__code__.co_firstlineno))
    return count,sorted(identities)


def body_map(session):
    if session is None or session.report['installed']==0: return []
    from recompyler.libraries.hook import _functions
    from recompyler.ir import compilation_info
    from recompyler.ir._entry_native import _compilation_owner
    result=[];seen=set()
    for name,module in tuple(sys.modules.items()):
        if module is None or not session.selected(name): continue
        for fn in _functions(module):
            info=compilation_info(fn)
            if not info or not info.get('installed') or info['body_address'] in seen: continue
            address=info['body_address'];seen.add(address)
            state=_compilation_owner(fn)
            owner=state[1] if state is not None else None
            ranges=getattr(owner,'native_ranges',()) if getattr(owner,'body_address',None)==address else ()
            valid=(type(ranges) is tuple and bool(ranges)
                   and all(type(item) is tuple and len(item)==2 and type(item[0]) is int and item[0]>0
                           and type(item[1]) is int and item[1]>0 for item in ranges)
                   and any(start<=address<start+size for start,size in ranges))
            if valid:
                for start,size in ranges:
                    result.append(dict(start=start,size=size,function=fn.__module__+':'+fn.__qualname__,bounds='published native owner range'))
            else:
                result.append(dict(start=address,size=1,function=fn.__module__+':'+fn.__qualname__,bounds='entry address only; native extent not published'))
    return result


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('name');p.add_argument('--engine',choices=['cpython_off','cpython_on','recompyler','pypy'],required=True)
    p.add_argument('--split',choices=SPLITS,default='train');p.add_argument('--repeats',type=int,default=1)
    p.add_argument('--body-map')
    args=p.parse_args()
    if args.repeats<1: raise ValueError('positive repeats required')
    jit=bool(getattr(sys,'_jit',None) and sys._jit.is_enabled())
    if args.engine!='pypy' and jit!=(args.engine!='cpython_off'): raise RuntimeError('requested JIT state unavailable')
    session=None
    try:
        case=manifest(args.split)[args.name]
        if args.engine=='recompyler':
            from recompyler.libraries.hook import enable
            session=enable(packages=(case.package,),profile=False)
        run=case.prepare()
        if session is not None and args.split in ('cpu','cpu_long'):
            module=sys.modules.get(case.package)
            if module is not None:session.process_module(module)
        start=perf_counter();digests=[]
        for _ in range(args.repeats): digests.append(output_digest(run()))
        elapsed=perf_counter()-start
        if len(set(digests))!=1: raise ValueError('nondeterministic workload output')
        installed,ids=installation_snapshot(session)
        if args.body_map:
            from pathlib import Path
            Path(args.body_map).write_text(json.dumps(body_map(session),indent=2))
        row=dict(status='ok',digest=digests[0],work_seconds=elapsed,repeats=args.repeats,
                 pid=os.getpid(),jit=jit,python=sys.version,installed=installed,installed_ids=ids,
                 delivery=dict(session.report) if session else None)
    except ModuleNotFoundError as error:
        row=dict(status='unavailable',reason=str(error))
    finally:
        if session is not None: session.close()
    print(json.dumps(row),flush=True)


if __name__=='__main__':main()
