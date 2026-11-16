"""S94 fresh-process medians, paired bootstrap CIs and whole-set headlines."""
import argparse
from contextlib import contextmanager
from datetime import datetime, timezone
import hashlib
import json
import math
import os
from pathlib import Path
import random
from statistics import median
import subprocess
import sys
import tempfile
from time import perf_counter
from bench.libs.runner import ROOT, timing_lock

ENGINES=('cpython_off','cpython_on','recompyler')


def interval(values, draws=2000):
    values=list(values)
    if not values or any(not math.isfinite(x) or x<=0 for x in values): raise ValueError('positive finite observations required')
    rng=random.Random(94)
    samples=sorted(median(rng.choices(values,k=len(values))) for _ in range(draws))
    return dict(median=median(values),low=samples[int(draws*.025)],high=samples[min(draws-1,int(draws*.975))],n=len(values))


def headline(rows, expected):
    byname={row['name']:row for row in rows}
    if len(byname)!=len(rows) or set(byname)!=set(expected) or any(row['status']!='ok' for row in rows):
        return dict(status='incomplete',missing=sorted(set(expected)-set(byname)),installed_default=None)
    ratios={engine:[] for engine in ('cpython_off','cpython_on','pypy')}
    installed=[];identities=set();count_known=True
    for name in expected:
        samples=byname[name]['samples']
        if len(samples)<3: return dict(status='incomplete',reason='at least three fresh processes required')
        for sample in samples:
            if any(sample[e].get('digest')!=sample['cpython_off'].get('digest') for e in ENGINES): raise ValueError('digest mismatch')
            candidate=sample['recompyler'];installed.append(candidate['installed'])
            ids=candidate.get('installed_ids',[])
            if len(ids)!=candidate['installed']: count_known=False
            identities.update(ids)
        for engine in ratios:
            if all(s.get(engine,{}).get('status','ok')=='ok' and engine in s and s[engine].get('digest')==s['cpython_off'].get('digest') for s in samples):
                ratios[engine].append([s[engine]['seconds']/s['recompyler']['seconds'] for s in samples])
    report=dict(status='ok',workloads=len(expected),installed_default=len(identities) if count_known else None,installed_instances_per_process=[min(installed),max(installed)])
    rng=random.Random(94)
    for engine, groups in ratios.items():
        if not groups: continue
        estimate=math.exp(sum(math.log(median(v)) for v in groups)/len(groups))
        boot=sorted(math.exp(sum(math.log(median(rng.choices(v,k=len(v)))) for v in groups)/len(groups)) for _ in range(2000))
        report[engine]=dict(median=estimate,low=boot[50],high=boot[1950],workloads=len(groups),subset=engine=='pypy' and len(groups)!=len(expected))
    return report


def environment(engine):
    env=dict(os.environ,PYTHONHASHSEED='0',PYTHONPATH=str(ROOT/'src')+os.pathsep+str(ROOT),
        PYTHON_JIT='1' if engine in ('cpython_on','recompyler') else '0',
        RECOMPYLER_CACHE=str(ROOT/'.cache/rc'),NUMBA_CACHE_DIR=str(ROOT/'.cache/numba'),NUMBA_NUM_THREADS='2',PYTHONPYCACHEPREFIX=str(ROOT/'.cache/pyc'))
    env.pop('PYTHONDONTWRITEBYTECODE',None)
    return env


def cache_fingerprint(directory):
    """Bind a warm receipt to its decision files and relocatable native objects."""
    digest=hashlib.sha256()
    for path in sorted(Path(directory).rglob('*')):
        if path.is_file() and path.suffix in ('.json','.o'):
            digest.update(path.relative_to(directory).as_posix().encode())
            digest.update(hashlib.sha256(path.read_bytes()).digest())
    return digest.hexdigest()


@contextmanager
def observation_cache(state, directory):
    if state=='cold':
        if directory is not None: raise ValueError('cold cache must be isolated, not supplied')
        temporary_root=ROOT/'.cache';temporary_root.mkdir(parents=True,exist_ok=True)
        with tempfile.TemporaryDirectory(prefix='library-cold-',dir=temporary_root) as temporary:
            yield Path(temporary)
    elif state=='warm':
        if directory is None or not Path(directory).is_dir():
            raise ValueError('warm measurement requires an explicit existing library cache')
        yield Path(directory).resolve()
    elif state=='existing' and directory is None:
        yield None
    else:
        raise ValueError('invalid cache state or unexpected library cache')


def observe(name,engine,*,executable=None,repeats=1,split='train',timeout=1800,body_map=None,worker_module='bench.libs.program_worker',cache_state='existing',library_cache=None,run_name='wave21-libs'):
    command=[str(executable or sys.executable),'-m',worker_module,name,'--engine',engine,'--split',split,'--repeats',str(repeats)]
    if body_map is not None: command+=['--body-map',str(body_map)]
    with observation_cache(cache_state,library_cache) as directory:
        env=environment(engine)
        env.update(RECOMPYLER_BENCH_RUN_NAME=run_name,RECOMPYLER_TIMING_RUN=run_name,RECOMPYLER_BENCH_LOCK=str(ROOT.parent/'TIMING.lock'))
        before=cache_fingerprint(directory) if directory is not None else None
        if directory is not None: env['RECOMPYLER_LIBRARY_CACHE']=str(directory)
        start=perf_counter()
        try:
            result=subprocess.run(command,cwd=ROOT,env=env,capture_output=True,text=True,timeout=timeout,
                creationflags=0x08004000 if os.name=='nt' else 0)
        except (OSError,subprocess.TimeoutExpired) as error: return dict(status='error',reason=str(error))
        elapsed=perf_counter()-start
        after=cache_fingerprint(directory) if directory is not None else None
        if cache_state=='warm' and before!=after: raise ValueError('warm library cache changed during observation')
        if result.returncode: return dict(status='error',returncode=result.returncode,stderr=result.stderr[-6000:])
        try: row=json.loads(result.stdout.splitlines()[-1])
        except (ValueError,IndexError): return dict(status='error',stdout=result.stdout[-1000:])
        row.update(seconds=elapsed,command=command,cache_state=cache_state,
                   cache_sha256_before=before,cache_sha256_after=after)
        return row


def validate_samples(samples):
    if not samples or any(s[e]['status']!='ok' for s in samples for e in ENGINES): return False
    expected=samples[0]['cpython_off']['digest']
    valid=all(s[e]['digest']==expected for s in samples for e in ENGINES)
    for sample in samples:
        baseline=sample.get('pypy',{})
        if baseline.get('status')=='ok' and baseline['digest']!=expected:
            baseline['status']='different-output'
            baseline['comparison']='different-output'
    return valid


def run_case(name,*,pairs=5,pypy=None,split='train',lock=None,ledger=None,worker_module='bench.libs.program_worker',cache_state='existing',library_cache=None,run_name='wave21-libs'):
    if pairs<3: raise ValueError('at least three fresh processes required')
    engines=list(ENGINES)+(['pypy'] if pypy else [])
    # Fixed repetition count is shared across engines; no engine-specific calibration.
    from bench.libs.programs import manifest
    repeats=manifest(split)[name].repeats
    from bench.libs.bytecode_cache import prepare
    bytecode={engine:prepare(pypy if engine=='pypy' else sys.executable,split=split,names=[name]) for engine in ('cpython_off',)+(('pypy',) if pypy else ())}
    samples=[]
    from bench.libs.timing_runner import test_processes
    before=test_processes()
    with timing_lock(Path(lock) if lock is not None else ROOT.parent/'TIMING.lock',Path(ledger) if ledger is not None else ROOT.parent/'WAVE21-LIBS-PLAN.md',run_name=run_name,purpose='S97 '+cache_state+' whole-program '+name,expected=600 if name=='selfcompile' else 30):
        for pair in range(pairs):
            sample={}
            for engine in engines[::1 if pair%2==0 else -1]:
                sample[engine]=observe(name,engine,executable=pypy if engine=='pypy' else None,repeats=repeats,split=split,worker_module=worker_module if engine=='recompyler' else 'bench.libs.program_worker',cache_state=cache_state if engine=='recompyler' else 'existing',library_cache=library_cache if engine=='recompyler' else None,run_name=run_name)
            samples.append(sample)
    after=test_processes()
    ok=validate_samples(samples)
    return dict(name=name,status='ok' if ok else 'error',repeats=repeats,samples=samples,cache_state=cache_state,bytecode=bytecode,
        summary={e:interval([s[e]['seconds'] for s in samples]) for e in engines if all(s[e]['status']=='ok' for s in samples)},
        concurrent_tests_before=before,concurrent_tests_after=after)


def source_fingerprint(worker_module=None):
    paths=sorted(p for p in (ROOT/'src').rglob('*') if p.suffix in ('.py','.c','.h','.pyd'))
    paths+=sorted((ROOT/'bench/libs').glob('*.py'))
    paths+=sorted((ROOT/'tools').rglob('*.py'))
    if worker_module is not None:
        if not all(part.isidentifier() for part in worker_module.split('.')):raise ValueError('local worker module required')
        worker=ROOT.joinpath(*worker_module.split('.')).with_suffix('.py')
        if not worker.is_file():raise ValueError('worker source must exist in this checkout')
        if worker not in paths:paths.append(worker)
    digest=hashlib.sha256()
    for path in paths:
        digest.update(path.relative_to(ROOT).as_posix().encode());digest.update(path.read_bytes())
    return digest.hexdigest()


def resume_rows(report,split,source_sha256,config=None):
    if report['split']!=split: raise ValueError('resume split differs')
    if report['source_sha256']!=source_sha256: raise ValueError('resume source differs')
    if config is not None and report.get('config')!=config: raise ValueError('resume interpreter/config differs')
    return report['rows']


def main():
    from bench.libs.programs import SPLITS
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--split',choices=SPLITS,default='train')
    p.add_argument('--pairs',type=int,default=5);p.add_argument('--pypy',type=Path);p.add_argument('--only',nargs='+')
    p.add_argument('--lock',type=Path,default=ROOT.parent/'TIMING.lock');p.add_argument('--ledger',type=Path,default=ROOT.parent/'WAVE21-LIBS-PLAN.md')
    p.add_argument('--run-name',default='wave21-libs')
    p.add_argument('--worker-module',default='bench.libs.program_worker',help='RecomPyler worker only; stock baselines retain the canonical worker')
    p.add_argument('--cache-state',choices=['existing','cold','warm'],default='existing')
    p.add_argument('--library-cache',type=Path,help='explicit prefilled library cache for warm observations')
    p.add_argument('--output',type=Path,required=True);p.add_argument('--resume',action='store_true')
    args=p.parse_args()
    if args.cache_state=='warm' and (args.library_cache is None or not args.library_cache.is_dir()): p.error('warm requires --library-cache pointing to an existing directory')
    if args.cache_state!='warm' and args.library_cache is not None: p.error('--library-cache requires warm cache state')
    from bench.libs.programs import manifest
    names=list(manifest(args.split));selected=args.only or names
    if not set(selected)<=set(names): p.error('program outside selected split')
    source_hash=source_fingerprint(args.worker_module)
    from bench.libs.cpu_programs import fixture_identity
    fixture_hash=fixture_identity() if args.split in ('cpu','cpu_long') else None
    config=dict(bytecode_treatment='pyc-fixed; checked-hash runtime precompile; inherited disable unset; clone-local pycache prefix',pairs=args.pairs,python=str(Path(sys.executable).resolve()),python_version=sys.version,pypy=str(args.pypy.resolve()) if args.pypy else None,lock=str(args.lock.resolve()),ledger=str(args.ledger.resolve()),worker_module=args.worker_module,cache_state=args.cache_state,library_cache=str(args.library_cache.resolve()) if args.library_cache else None,cache_sha256=cache_fingerprint(args.library_cache) if args.library_cache else None,run_name=args.run_name,fixture_sha256=fixture_hash)
    rows=[]
    if args.resume and args.output.exists(): rows=resume_rows(json.loads(args.output.read_text()),args.split,source_hash,config)
    for name in selected:
        if any(r['name']==name and r['status']=='ok' for r in rows): continue
        print('MEASURE '+name,flush=True)
        if source_fingerprint(args.worker_module)!=source_hash: raise ValueError('source changed during measurement cohort')
        if fixture_hash is not None and fixture_identity()!=fixture_hash:raise ValueError('CPU fixture source changed during cohort')
        if args.library_cache and cache_fingerprint(args.library_cache)!=config['cache_sha256']: raise ValueError('warm library cache changed during cohort')
        row=run_case(name,pairs=args.pairs,pypy=args.pypy,split=args.split,lock=args.lock,ledger=args.ledger,worker_module=args.worker_module,cache_state=args.cache_state,library_cache=args.library_cache,run_name=args.run_name)
        if source_fingerprint(args.worker_module)!=source_hash: raise ValueError('source changed during measurement cohort')
        if fixture_hash is not None and fixture_identity()!=fixture_hash:raise ValueError('CPU fixture source changed during cohort')
        if args.library_cache and cache_fingerprint(args.library_cache)!=config['cache_sha256']: raise ValueError('warm library cache changed during cohort')
        row['source_sha256']=source_hash
        rows=[r for r in rows if r['name']!=name]+[row]
        provenance=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()

        report=dict(schema=1,metric='whole process wall seconds including startup, imports, setup, compilation and exit',
            confidence='95% percentile bootstrap; fixed programs; resample fresh process pairs within each program',
            split=args.split,config=config,head=provenance,source_sha256=source_hash,dirty=bool(subprocess.check_output(['git','status','--porcelain','-uno'],cwd=ROOT)),
            utc=datetime.now(timezone.utc).isoformat(),rows=rows,headline=headline(rows,names))
        args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(report,indent=2))
        print(json.dumps(dict(name=name,status=row['status'],headline=report['headline'])),flush=True)
    return int(any(r['status']!='ok' for r in rows))


if __name__=='__main__':raise SystemExit(main())
