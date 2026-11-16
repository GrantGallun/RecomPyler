"""Compare S98 compile cost and total generated IR under the shared lock."""
import argparse
from contextlib import contextmanager
from datetime import datetime,timezone
import importlib
import json
import math
import os
from pathlib import Path
from statistics import median
import subprocess
import sys

ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'src')]
TARGETS=('recompyler.heap:_find','recompyler.heap:_Program.canon','recompyler.heap:_Program.merge',
         'recompyler.lift:_local_names','json.encoder:py_encode_basestring',
         'difflib:SequenceMatcher.find_longest_match','textwrap:TextWrapper._wrap_chunks',
         'json.decoder:py_scanstring')


def summarize(observations):
    """Plain samples only. Report nearest-rank p90, not a fitted distribution."""
    if len(observations)<3:raise ValueError('three fresh observations required')
    names=[row['name'] for row in observations[0]['rows']]
    if not names:raise ValueError('empty target set')
    expected=set(names)
    for sample in observations:
        observed=[row['name'] for row in sample['rows']]
        if len(set(observed))!=len(observed):raise ValueError('duplicate target')
        if set(observed)!=expected:raise ValueError('incomplete target set')
    result=[]
    for name in names:
        rows=[next((row for row in sample['rows'] if row['name']==name),None) for sample in observations]
        if any(row is None or row['status']!='ok' for row in rows):raise ValueError('incomplete target '+name)
        if len({row['code_digest'] for row in rows})!=1:raise ValueError('target code changed')
        times=sorted(row['compile_ms'] for row in rows)
        if any(type(t) not in (int,float) or not math.isfinite(t) or t<=0 for t in times):raise ValueError('invalid time')
        instructions=median(row['ir_instructions'] for row in rows);bytecodes=rows[0]['bytecodes']
        if bytecodes<=0 or any(row['bytecodes']!=bytecodes for row in rows):raise ValueError('invalid bytecode count')
        result.append(dict(name=name,median_ms=median(times),p90_ms=times[math.ceil(.9*len(times))-1],
            samples=len(times),ir_instructions=instructions,bytecodes=bytecodes,ir_per_bytecode=instructions/bytecodes,ir_lines=median(row['ir_lines'] for row in rows),
            ir_lines_per_bytecode=median(row['ir_lines'] for row in rows)/bytecodes))
    return result


def compile_observation(variant,profile,names):
    import cProfile,dis,hashlib,marshal,pstats,time
    from recompyler.ir import compiler,_entry_native
    from recompyler import heap
    ordinary=compiler.lower
    compiler.lower=lambda *a,**kw:ordinary(*a,**dict(kw,outline_frame_paths=variant=='outlined'))
    compiler.compile_function(heap._Cell.__init__,strict=True)
    rows=[]
    for name in names:
        module,qualname=name.split(':');function=importlib.import_module(module)
        for part in qualname.split('.'):function=getattr(function,part)
        _entry_native.forget_compilation(function)
        profiler=cProfile.Profile() if profile else None
        if profiler:profiler.enable()
        start=time.perf_counter_ns();compiler.compile_function(function,strict=True)
        milliseconds=(time.perf_counter_ns()-start)/1e6
        if profiler:profiler.disable()
        info=compiler.compilation_info(function)
        if not info or info['installed']:raise ValueError('expected prepared, uninstalled function')
        modules=[_entry_native._compilation_owner(function)[1].module]
        candidate=compiler._frameless_candidates.get(function)
        if candidate is not None:modules.append(candidate.owner.module)
        row=dict(name=name,status='ok',compile_ms=milliseconds,
            ir_instructions=sum(len(b.instructions) for m in modules for f in m.functions for b in f.blocks),
            ir_lines=sum(len(str(m).splitlines()) for m in modules),
            bytecodes=len(list(dis.get_instructions(function))),
            code_digest=hashlib.sha256(marshal.dumps(function.__code__)).hexdigest())
        if profiler:
            phases={}
            for (file,line,fn),(_,_,own,cumulative,_) in pstats.Stats(profiler).stats.items():
                file=file.replace('\\','/')
                key=None;duration=cumulative
                if file.endswith('/executionengine.py') and fn=='finalize_object':key='llvm_codegen_ms'
                elif file.endswith('/llvm_semantics.py') and fn=='optimize_module':key='llvm_opt_ms'
                elif file.endswith('/binding/module.py') and fn=='parse_assembly':key='llvm_parse_ms'
                elif file.endswith('/ir/builder.py') and fn=='build':key='ir_build_cumulative_ms'
                elif file.endswith('/ir/verifier.py') and fn=='verify':key='verify_cumulative_ms'
                elif '/llvmlite/ir/' in file:key='python_ir_objects_text_self_ms';duration=own
                elif '/recompyler/ir/' in file:key='our_ir_self_ms';duration=own
                if key:phases[key]=phases.get(key,0.)+duration*1000
            row['profile_ms']=phases
        rows.append(row);_entry_native.forget_compilation(function)
    return dict(variant=variant,profiled=profile,rows=rows)


@contextmanager
def timing_lock(lock,ledger,run_name):
    lock.mkdir();token=run_name+'-'+str(os.getpid())
    def record(action):
        with ledger.open('a',encoding='utf8') as stream:stream.write('\nTIMING '+action+' '+token+' '+datetime.now(timezone.utc).isoformat()+' S98 compile-cost comparison\n')
    try:
        (lock/'owner.txt').write_text('run: '+run_name+'\ntoken: '+token+'\nclass: development\npurpose: S98 compile-cost comparison\nstart: '+datetime.now(timezone.utc).isoformat()+'\nexpected: 120 seconds\n')
        record('ACQUIRE');yield token
    finally:
        assert token in (lock/'owner.txt').read_text()
        (lock/'owner.txt').unlink();lock.rmdir();record('RELEASE')


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--worker',choices=('inline','outlined'));parser.add_argument('--profile',action='store_true')
    parser.add_argument('--only',nargs='+',choices=TARGETS);parser.add_argument('--pairs',type=int,default=3)
    parser.add_argument('--lock',type=Path);parser.add_argument('--ledger',type=Path);parser.add_argument('--output',type=Path)
    parser.add_argument('--token');parser.add_argument('--run-name',default='wave16-inplace');args=parser.parse_args()
    if os.name=='nt':
        import ctypes
        ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    names=args.only or TARGETS
    if args.worker:
        if not args.lock or not args.token or args.token not in (args.lock/'owner.txt').read_text():parser.error('worker requires active parent timing lock')
        print(json.dumps(compile_observation(args.worker,args.profile,names)));return 0
    if args.pairs<3 or not all((args.lock,args.ledger,args.output)):parser.error('three pairs and lock/ledger/output required')
    from bench.libs.shared_harness import source_fingerprint
    fingerprint=source_fingerprint();samples={key:[] for key in ('inline','outlined')};profiles={}
    env=dict(os.environ,PYTHONPATH=str(ROOT/'src')+os.pathsep+str(ROOT),PYTHON_JIT='1',PYTHONDONTWRITEBYTECODE='1')
    args.output.parent.mkdir(parents=True,exist_ok=True)
    def observe(variant,token,profile=False):
        command=[sys.executable,__file__,'--worker',variant,'--lock',str(args.lock),'--token',token,'--only',*names]+(['--profile'] if profile else [])
        output=subprocess.run(command,cwd=ROOT,env=env,capture_output=True,text=True,timeout=300,
            creationflags=0x08004000 if os.name=='nt' else 0)
        if output.returncode:raise RuntimeError(output.stdout+output.stderr)
        row=json.loads(output.stdout.splitlines()[-1])
        with args.output.with_suffix('.jsonl').open('a',encoding='utf8') as stream:stream.write(json.dumps(dict(source_sha256=fingerprint,observation=row))+'\n')
        return row
    with timing_lock(args.lock,args.ledger,args.run_name) as token:
        from bench.libs.timing_runner import test_processes
        before=test_processes()
        for pair in range(args.pairs):
            for variant in (('inline','outlined') if pair%2==0 else ('outlined','inline')):
                print('OBSERVE',pair,variant,flush=True);samples[variant].append(observe(variant,token))
        if args.profile:
            for variant in samples:profiles[variant]=observe(variant,token,True)
        after=test_processes()
        if source_fingerprint()!=fingerprint:raise ValueError('source changed during cohort')
    for left,right in zip(samples['inline'],samples['outlined']):
        if [(r['name'],r['code_digest']) for r in left['rows']]!=[(r['name'],r['code_digest']) for r in right['rows']]:raise ValueError('variant target code differs')
    report=dict(source_sha256=fingerprint,whole_program=dict(cold='unmeasured',warm='unmeasured',default_installed=0),
        metric='compile_function milliseconds after imports and one compiler warmup; target never executed',
        observations=samples,summary={v:summarize(rows) for v,rows in samples.items()},
        profiles_separate=profiles,profile_note='profiled samples excluded from medians; cumulative build/verify may overlap self-time buckets',
        concurrent_tests_before=before,concurrent_tests_after=after,p90_method='nearest rank; three samples give a coarse upper observation')
    args.output.write_text(json.dumps(report,indent=2));print(json.dumps(report['summary'],indent=2));return 0


if __name__=='__main__':raise SystemExit(main())
