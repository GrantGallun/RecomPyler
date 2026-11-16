"""Resident library worker: prepare before lock; measure only on a locked command."""
import argparse
import ctypes
import json
import os
from pathlib import Path
import sys
from time import perf_counter
from bench.libs.workloads import workloads, output_digest


def jit_enabled():
    return bool(getattr(sys,'_jit',None) and sys._jit.is_enabled())


def emit(row):
    print(json.dumps(row),flush=True)


def lock_owned():
    path=Path(__file__).resolve().parents[3]/'TIMING.lock'/'owner.txt'
    return path.is_file() and 'wave21-libs' in path.read_text()


def serve(run, expected, ready, live=None, *, digest=output_digest):
    emit(dict(status='ready',digest=expected,**ready))
    batch_count=None
    for command in sys.stdin:
        command=command.strip()
        if command=='quit':return
        if command=='check':
            actual=digest(run())
            if actual!=expected:raise AssertionError('resident output differs from stock')
            emit(dict(status='checked',digest=actual));continue
        if command!='measure':raise ValueError('unknown resident command')
        if not lock_owned():raise RuntimeError('resident measurement needs root TIMING.lock')
        before=live() if live else None
        count=batch_count or 1
        while True:
            start=perf_counter()
            for _ in range(count): result=run()
            elapsed=perf_counter()-start
            if batch_count or elapsed>=0.2:break
            count*=2
        batch_count=count
        actual=digest(result)
        if actual!=expected:raise AssertionError('measured output differs from stock')
        after=live() if live else None
        emit(dict(status='ok' if live is None or before and after else 'not-exercised',digest=actual,
                  seconds=elapsed/count,batch_seconds=elapsed,calls=count,
                  ordinary_entries_before=before,ordinary_entries_after=after))


def native(name):
    from bench.libs.diagnose import diagnose
    from recompyler.ir import compilation_info
    from recompyler.ir._entry_native import _compilation_owner,forget_compilation,prepare_frame_entry
    from tools.ir_self_host import install_candidate
    def prepared(report,run,targets,counters):
        if report['status']!='verified':raise RuntimeError('no verified native workload entry')
        exercised={row['function_id'] for row in report['rows'] if row.get('native_entries',0)>0}
        originals=[]
        for target,row in targets:
            counter=counters.get(id(target))
            state=_compilation_owner(target)
            if counter is None or state is None or state[1] is not counter:continue
            code=state[0]
            forget_compilation(target)
            if id(target) not in exercised:continue
            owner=counter.original
            prepare_frame_entry(target,owner.body_address,owner,code)
            if install_candidate(target):originals.append((target,owner))
        expected=report['digest']
        for _ in range(32):assert output_digest(run())==expected
        def live():
            return sum(bool((compilation_info(target) or {}).get('installed')) and
                       _compilation_owner(target)[1] is owner for target,owner in originals)
        counted=sum((_compilation_owner(target) or (None,None))[1] is counters.get(id(target))
                    for target,row in targets if id(target) in counters)
        ready=dict(mode='native',jit=jit_enabled(),python=sys.version.split()[0],native_entries=report['native_entries'],warmup=32,
                   counted_wrappers_installed=counted,ordinary_entries_live=live(),
                   compiled=report['compiled'],attempted=report['attempted'],not_attempted=report['not_attempted'])
        if counted or not ready['ordinary_entries_live']:raise RuntimeError('ordinary native bodies unavailable')
        serve(run,expected,ready,live=live)
    diagnose(name,after_correctness=prepared)


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('name')
    parser.add_argument('--mode',choices=['stock','jit','native','pypy'],default='stock')
    args=parser.parse_args()
    if os.name=='nt':ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    if args.mode=='native':return native(args.name)
    case=workloads()[args.name]
    try:run=case.prepare()
    except ModuleNotFoundError as error:
        emit(dict(status='unavailable',reason=str(error)));return
    expected=output_digest(run());warmup=1000 if args.mode=='pypy' else 32
    for _ in range(warmup):assert output_digest(run())==expected
    serve(run,expected,dict(mode=args.mode,warmup=warmup,python=sys.version.split()[0],jit=jit_enabled()))


if __name__=='__main__':main()
