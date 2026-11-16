"""Fresh-process compile scaling. cProfile stages overlap; targets never execute.

Run under the shared timing lock; ordinary tests exercise only the verdict math.
T1 requires a compiler adapter explicitly marked recompyler_tier='T1'. The
production full pipeline is T2. Timed totals exclude imports and one warm-up.
"""
import argparse
import cProfile
import dis
import importlib
import json
import math
import os
from pathlib import Path
import pstats
from statistics import median
import subprocess
import sys
from time import perf_counter
from bench.libs.runner import ROOT, timing_lock

STAGES={'build':('builder.py','build'),'lower_all':('lower_llvm.py','lower'),
        'llvm_opt':(None,'optimize_module'),'llvm_codegen':(None,'finalize_object'),
        'parse':(None,'parse_assembly'),'ir_text':('module.py','__repr__')}


def make(size,kind):
    if type(size) is not int or size<1 or kind not in ('straight','branchy'):
        raise ValueError('positive size and straight/branchy kind required')
    if kind=='straight':
        body=''.join(f'    x = x + a[{i%7}] * {i}\n' for i in range(size))
        source='def f(a,b):\n    x=0\n'+body+'    return x\n'
    else:
        body=''.join(f'        if v == {i}: t = t + d.get(k,{i})\n' for i in range(size))
        source='def f(d,keys):\n    t=0\n    for k in keys:\n        v=d[k]\n'+body+'    return t\n'
    scope={'__name__':'compile_scaling_fixture'}
    exec(compile(source,f'<compile-scaling:{kind}:{size}>','exec'),scope)
    return scope['f']


def validate_compiler(compiler,tier):
    if tier not in ('T1','T2') or not callable(compiler): raise ValueError('compiler and tier required')
    if tier=='T1' and getattr(compiler,'diagnostic_only',False):
        raise ValueError('T1 budget cannot use diagnostic serialization timings')
    if tier=='T1' and getattr(compiler,'recompyler_tier',None)!='T1':
        raise ValueError('T1 requires an explicitly identified T1 compiler adapter')
    return compiler


def profile_stages(stats):
    result=dict.fromkeys(STAGES,0.0)
    for (filename,line,name),values in stats.items():
        for stage,(suffix,entry) in STAGES.items():
            if name==entry and (suffix is None or filename.replace('\\','/').endswith('/'+suffix)):
                result[stage]=max(result[stage],values[3])
    return result


def growth_exponent(sizes,values):
    if len(sizes)<3 or len(sizes)!=len(values) or not all(value is not None and math.isfinite(value) and value>0 for value in values):
        return None
    xs=[math.log(n) for n in sizes];ys=[math.log(value) for value in values]
    mx=sum(xs)/len(xs);my=sum(ys)/len(ys)
    return sum((x-mx)*(y-my) for x,y in zip(xs,ys))/sum((x-mx)**2 for x in xs)


def summarize(rows,*,tier):
    if tier not in ('T1','T2') or not rows: raise ValueError('tier and complete series required')
    kinds={}
    for kind in sorted({row['kind'] for row in rows}):
        series=sorted((row for row in rows if row['kind']==kind),key=lambda row:row['bytecodes'])
        sizes=[row['bytecodes'] for row in series]
        if len(sizes)<3 or len(set(sizes))!=len(sizes) or any(type(n) is not int or n<=0 for n in sizes):
            raise ValueError('three distinct positive bytecode sizes required')
        if any(row['tier']!=tier for row in series): raise ValueError('mixed tiers')
        if tier=='T1' and any(row.get('diagnostic_only') for row in series): raise ValueError('diagnostic data cannot grade T1')
        for row in series:
            if not row['stages'].get('total',0)>0: raise ValueError('total stage missing')
            if any(not math.isfinite(v) or v<0 for v in row['stages'].values()): raise ValueError('finite stage times required')
        stages={}
        for stage in sorted(set().union(*(row['stages'] for row in series))):
            values=[row['stages'].get(stage,0) for row in series]
            exponent=growth_exponent(sizes,values)
            stages[stage]=dict(exponent=exponent,max_ms_per_bytecode=max(v*1000/n for n,v in zip(sizes,values)),
                               ms_per_bytecode=[v*1000/n for n,v in zip(sizes,values)])
        kinds[kind]=stages
    failures=[]
    if tier=='T1':
        for kind,stages in kinds.items():
            if stages['total']['max_ms_per_bytecode']>.01+1e-12: failures.append(kind+': total exceeds 10 us/bytecode')
            if stages['total']['exponent']>1.05+1e-12: failures.append(kind+': total exponent exceeds 1.05')
    return dict(ok=not failures,tier=tier,budget_enforced=tier=='T1',failures=failures,kinds=kinds)


def preparation_receipt(function,expected_code):
    from recompyler.ir import compilation_info
    info=compilation_info(function)
    if (function.__code__ is not expected_code or not info or info.get('compiled') is not True
            or type(info.get('body_address')) is not int or info['body_address']<=0):
        raise ValueError('adapter must prepare a real prepared native body on the unchanged function')
    return dict(body_address=info['body_address'],abi=info.get('deployment_abi',info.get('abi')))


def measure(size,kind,tier,adapter):
    module,name=adapter.split(':',1)
    compiler=validate_compiler(getattr(importlib.import_module(module),name),tier)
    compiler(make(1,kind),strict=True)
    function=make(size,kind);expected_code=function.__code__
    profiler=cProfile.Profile()
    start=perf_counter();profiler.enable()
    try: compiler(function,strict=True)
    finally: profiler.disable()
    total=perf_counter()-start
    preparation=preparation_receipt(function,expected_code)
    result=dict(kind=kind,size=size,tier=tier,bytecodes=len(list(dis.get_instructions(function))),
                stages=dict(profile_stages(pstats.Stats(profiler).stats),total=total),
                diagnostic_only=bool(getattr(compiler,'diagnostic_only',False)),preparation=preparation)
    measurements=getattr(compiler,'measurements',None)
    if callable(measurements):result['diagnostics']=measurements()
    return result


def main(argv=None):
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tier',choices=['T1','T2'],default='T2')
    parser.add_argument('--compiler',help='module:callable; T1 adapter must declare recompyler_tier')
    parser.add_argument('--sizes',type=int,nargs='+',default=[8,16,32,64,128,256])
    parser.add_argument('--samples',type=int,default=3)
    parser.add_argument('--output',type=Path)
    parser.add_argument('--lock',type=Path,default=ROOT.parent/'TIMING.lock')
    parser.add_argument('--ledger',type=Path,default=ROOT.parent/'WAVE21-LIBS-PLAN.md')
    parser.add_argument('--worker',choices=['straight','branchy'],help=argparse.SUPPRESS)
    args=parser.parse_args(argv)
    if args.tier=='T1' and not args.compiler: parser.error('T1 requires --compiler with a real T1 adapter')
    adapter=args.compiler or 'recompyler.ir:compile_function'
    if args.worker:
        print(json.dumps(measure(args.sizes[0],args.worker,args.tier,adapter)));return 0
    if args.output is None: parser.error('--output required')
    if args.samples<3 or len(set(args.sizes))<3 or len(set(args.sizes))!=len(args.sizes) or min(args.sizes)<1:
        parser.error('at least three distinct positive sizes and three samples required')
    from bench.libs.shared_harness import source_fingerprint
    from bench.libs.timing_runner import test_processes
    fingerprint=source_fingerprint();rows=[];raw=[]
    env=dict(os.environ,PYTHONPATH=str(ROOT/'src')+os.pathsep+str(ROOT),PYTHON_JIT='1',NUMBA_NUM_THREADS='2')
    for kind in ('straight','branchy'):
        for size in args.sizes:
            if source_fingerprint()!=fingerprint: raise ValueError('source changed during scaling')
            attempts=[]
            for attempt in range(2):
                before=test_processes();observations=[]
                with timing_lock(args.lock,args.ledger,purpose=f'S99 {args.tier} {kind} {size} attempt{attempt+1}',expected=300):
                    for _ in range(args.samples):
                        command=[sys.executable,'-m','bench.libs.compile_scaling','--worker',kind,'--sizes',str(size),'--tier',args.tier,'--compiler',adapter]
                        result=subprocess.run(command,cwd=ROOT,env=env,capture_output=True,text=True,timeout=600,
                                              creationflags=0x08004000 if os.name=='nt' else 0)
                        if result.returncode: raise RuntimeError(result.stderr[-4000:])
                        observations.append(json.loads(result.stdout.splitlines()[-1]))
                after=test_processes()
                attempts.append(dict(samples=observations,concurrent_tests_before=before,concurrent_tests_after=after))
                if not (before or after): break
            if source_fingerprint()!=fingerprint: raise ValueError('source changed during scaling')
            if len({row['bytecodes'] for row in observations})!=1: raise ValueError('bytecode shape changed')
            row=dict(observations[0]);row['stages']={stage:median(sample['stages'][stage] for sample in observations) for stage in row['stages']}
            rows.append(row);raw.append(dict(kind=kind,size=size,attempts=attempts))
            print(json.dumps(row),flush=True)
    diagnostic=any(row.get('diagnostic_only') for row in rows)
    report=dict(schema=1,source_sha256=fingerprint,compiler=adapter,python=sys.version,rows=rows,samples=raw,
                diagnostic_only=diagnostic,
                metric='diagnostic compiler run with IR snapshots; not compile-budget timing' if diagnostic else 'profiled compile seconds; stages overlap; imports and warm-up excluded',
                limits={'T1_us_per_bytecode':10,'T1_exponent':1.05},summary=summarize(rows,tier=args.tier))
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(report,indent=2))
    return 0 if report['summary']['ok'] else 1


if __name__=='__main__':raise SystemExit(main())
