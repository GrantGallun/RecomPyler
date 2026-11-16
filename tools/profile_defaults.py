"""Profile TRAIN fixtures offline, retaining weak identities and no call arguments."""
import argparse
from contextlib import nullcontext
import ctypes
import json
import math
import os
from pathlib import Path
import sys
from time import perf_counter

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT));sys.path.insert(0,str(ROOT/'src'))


def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--only',nargs='+')
    parser.add_argument('--repeats',type=int,default=64)
    parser.add_argument('--costs',action='store_true',help='collect self time under TIMING.lock; never compile candidates')
    parser.add_argument('--expected-runs',type=int,default=64)
    parser.add_argument('--compile-estimate-ms',type=float,default=100)
    parser.add_argument('--lock',type=Path,default=ROOT.parent/'TIMING.lock')
    parser.add_argument('--ledger',type=Path,default=ROOT.parent/'WAVE18-LIFT-PLAN.md')
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args(argv)
    if args.repeats<1 or args.expected_runs<0:parser.error('positive profile repeats and nonnegative future runs required')
    if not math.isfinite(args.compile_estimate_ms) or args.compile_estimate_ms<=0:parser.error('positive finite compile estimate required')
    if os.name=='nt':ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    from bench.libs.programs import manifest
    from bench.libs.workloads import output_digest
    from bench.libs.diagnose import collect_calls,public_row
    from bench.libs.runner import timing_lock
    from default_installation import payback_bound
    cases=manifest('train');rows=[]
    if args.only and not set(args.only)<=set(cases):parser.error('program outside TRAIN manifest')
    for name in args.only or cases:
        case=cases[name]
        repeats=1 if name=='selfcompile' else args.repeats
        context=timing_lock(args.lock,args.ledger,run_name='wave18-lift',
            purpose='S97 offline self-time '+name,expected=600 if name=='selfcompile' else 60) if args.costs else nullcontext()
        try:
            with context:
                run=case.prepare();expected=output_digest(run())
                def repeated():
                    result=None
                    for _ in range(repeats):
                        result=run()
                        if output_digest(result)!=expected:raise AssertionError('profile workload output changed')
                    return result
                value,observed=collect_calls(repeated,case.package,
                    include_driver=name=='numpy_loop' or case.package=='bench',
                    clock=perf_counter if args.costs else None)
            if output_digest(value)!=expected:raise AssertionError('profile digest changed')
            functions=[]
            for profile in sorted(observed,key=lambda item:-item['calls']):
                function=profile['function']();code=profile['code']()
                detail=public_row(profile)
                detail['still_live']=function is not None and code is not None and function.__code__ is code
                detail['hot']=profile['calls']>=100
                if args.costs:
                    detail['compile_cost_bound']=payback_bound(self_seconds=profile['self_seconds'],
                        profile_runs=repeats,expected_runs=args.expected_runs,
                        compile_seconds=args.compile_estimate_ms/1000)
                    detail['compile_candidate']=detail['hot'] and detail['still_live'] and detail['compile_cost_bound']['eligible']
                functions.append(detail)
                function=None;code=None
            row=dict(name=name,status='ok',repeats=repeats,digest=expected,functions=functions,
                hot=sum(item['hot'] and item['still_live'] for item in functions),
                compile_candidates=sum(item.get('compile_candidate',False) for item in functions),
                compiled=0,installed_default=0,expected_future_runs=args.expected_runs)
        except ModuleNotFoundError as error:row=dict(name=name,status='unavailable',reason=str(error))
        rows.append(row)
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(json.dumps(rows,indent=2))
        print(name,row['status'],'hot='+str(row.get('hot',0)),
              'compile_candidates='+str(row.get('compile_candidates',0)),flush=True)
    return int(any(row['status']!='ok' for row in rows))


if __name__=='__main__':raise SystemExit(main())
