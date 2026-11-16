"""Whole-process prepared-region candidates; these are not default installs.

The shared harness keeps its canonical stock workers. An explicitly supplied
warm cache may contain prepared-section.json exported by heap.build_regions.
This diagnostic measures the existing load-only route before runtime admission.
"""
import argparse
import json
import os
from pathlib import Path
import sys
from time import perf_counter
from bench.libs.programs import manifest
from bench.libs.workloads import output_digest


def load_candidate(function,path):
    from recompyler import heap,_prepared as pc
    section=json.loads(Path(path).read_text())
    if len(section['functions'])!=1: raise ValueError('one prepared entry required')
    snapshot=dict(mode='standalone',functions=[],plan=dict(aot_regions=section))
    index=pc.open_index(section,section['functions'][0],plan_snapshot=snapshot)
    if index is None: raise ValueError('prepared artifact unavailable: '+str(pc.last_miss()))
    return heap.lift_region(function,prepared=index,prepared_only=True)


def candidate_snapshot(candidate):
    return dict(installed=0,installed_ids=[],candidate_native_calls=candidate.compiled_calls,
                candidate_aot_calls=candidate.aot_calls,candidate_jit_calls=candidate.jit_calls,
                candidate_fallback_calls=candidate.fallback_calls)


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('name');p.add_argument('--engine',choices=['recompyler'],required=True)
    p.add_argument('--split',choices=['train','heldout'],default='train')
    p.add_argument('--repeats',type=int,default=1)
    args=p.parse_args()
    if args.repeats<1: raise ValueError('positive repeats required')
    jit=bool(getattr(sys,'_jit',None) and sys._jit.is_enabled())
    if not jit: raise RuntimeError('requested JIT state unavailable')
    case=manifest(args.split)[args.name]
    from recompyler.libraries.hook import enable
    session=enable(packages=(case.package,),profile=False)
    candidate=None
    try:
        run=case.prepare()
        cache=os.environ.get('RECOMPYLER_LIBRARY_CACHE')
        path=Path(cache)/'prepared-section.json' if cache else None
        if path is not None and path.is_file():
            candidate=load_candidate(run,path);run=candidate
        start=perf_counter();digests=[output_digest(run()) for _ in range(args.repeats)]
        elapsed=perf_counter()-start
        if len(set(digests))!=1: raise ValueError('nondeterministic workload output')
        stats=candidate_snapshot(candidate) if candidate else dict(installed=0,installed_ids=[])
        if candidate is not None and (candidate.aot_calls!=args.repeats or candidate.jit_calls or candidate.fallback_calls):
            raise ValueError('candidate did not execute exclusively from its prepared artifact')
        if 'numba' in sys.modules or 'llvmlite.binding' in sys.modules:
            raise ValueError('compiler imported during prepared observation')
        print(json.dumps(dict(status='ok',digest=digests[0],work_seconds=elapsed,repeats=args.repeats,
            pid=os.getpid(),jit=jit,python=sys.version,delivery=dict(session.report),**stats)),flush=True)
    finally:session.close()


if __name__=='__main__':main()
