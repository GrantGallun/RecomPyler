"""S86 development timings including allocation and both host/device transfers."""
import argparse
import ctypes
from datetime import datetime,timezone
import json
import os
from pathlib import Path
from statistics import median
from bench.libs.timing_runner import Resident,sample_group,test_processes
from bench.libs.runner import ROOT,timing_lock


def run_case(size):
    name='affine-'+str(size);workers={}
    try:
        for label,mode in [('cpython','stock'),('cpython_jit','jit'),('native','native'),('gpu','gpu')]:
            worker=Resident(name,mode,worker_module='bench.libs.gpu_timing_worker')
            workers[label]=worker
            if worker.ready['status']!='ready':raise RuntimeError(label+' not ready')
            if worker.ready.get('jit') is not (mode in ('jit','native')):raise RuntimeError(label+' JIT mode differs')
        if workers['gpu'].ready.get('transfers_included') is not True or workers['gpu'].ready.get('backend')!='cuda':
            raise RuntimeError('GPU transfers or execution not proven')
        before=test_processes()
        with timing_lock(ROOT.parent/'TIMING.lock',ROOT.parent/'WAVE21-LIBS-PLAN.md',purpose='S86 GPU '+name,expected=30):
            first=sample_group(workers)
        after=test_processes();repeat=None
        if before or after:
            with timing_lock(ROOT.parent/'TIMING.lock',ROOT.parent/'WAVE21-LIBS-PLAN.md',purpose='S86 GPU '+name,expected=30):
                repeat=sample_group(workers)
        chosen=repeat or first
        summary={label:{'seconds':median(pair[label]['seconds'] for pair in chosen)} for label in workers}
        for baseline in ('cpython','cpython_jit','native'):
            summary['gpu']['relative_to_'+baseline]=median(pair['gpu']['seconds']/pair[baseline]['seconds'] for pair in chosen)
        faster=all(summary['gpu']['relative_to_'+baseline]<.94 for baseline in ('cpython','cpython_jit','native'))
        return dict(name=name,status='measured',class_='development',summary=summary,
                    prepared={label:worker.ready for label,worker in workers.items()},first=first,repeat=repeat,
                    concurrent_test_processes_before=before,concurrent_test_processes_after=after,
                    recorded_utc=datetime.now(timezone.utc).isoformat(),gpu_candidate_faster=faster,
                    default_installation=False,pypy='NumPy unavailable in the installed PyPy environment',
                    spike='no matching library GPU spike',
                    limitation='Explicit benchmark candidate; shared CALL/public model hooks remain pending')
    finally:
        for worker in workers.values():worker.close()


def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--sizes',type=int,nargs='+',default=[512,65536,1048576])
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args(argv)
    if os.name=='nt':ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    rows=[]
    for size in args.sizes:
        print('PREPARE affine-'+str(size),flush=True)
        try:row=run_case(size)
        except Exception as exc:
            import traceback
            row=dict(name='affine-'+str(size),status='error',reason=type(exc).__name__+': '+str(exc),traceback=traceback.format_exc())
        rows.append(row);args.output.write_text(json.dumps(rows,indent=2)+'\n')
        print(json.dumps({key:row[key] for key in ('name','status','summary','reason') if key in row}),flush=True)
    return int(any(row['status']!='measured' for row in rows))


if __name__=='__main__':raise SystemExit(main())
