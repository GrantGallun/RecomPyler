"""Profile then time a workload, plain CPython vs recompyler run, at 20 loops.
usage: bench.py [--reps N] [--profile-only] name..."""
import json, os, statistics, subprocess, sys, time, shutil
from pathlib import Path
HERE=Path(__file__).resolve().parent; WS=HERE.parent.parent
SRC=HERE.parent/'src'
SHIM=WS/'wave3-study'/'results-long-v2'/'shim'
PY=r'C:\Python314\python.exe'
OUT=Path(os.environ.get('RECOMPYLER_BENCH_OUTPUT',str(HERE/'out')))
args=sys.argv[1:]; REPS=3; PONLY=False
if '--reps' in args: i=args.index('--reps'); REPS=int(args[i+1]); del args[i:i+2]
if '--profile-only' in args: PONLY=True; args.remove('--profile-only')
m=json.load(open(WS/'wave3-study'/'results-v2'/'manifest.json'))
W={w['name']:w for w in m['workloads']}
base=dict(m['execution_environment'])
def env(name):
    c=OUT/'cache'/name
    if c.exists(): shutil.rmtree(c,ignore_errors=True)
    (c/'temp').mkdir(parents=True,exist_ok=True)
    e=dict(base); e.update(PYTHONPATH=os.pathsep.join([str(SHIM),str(SRC)]),PYTHONWARNINGS='ignore',PYTHONHASHSEED='0',
      PYTHONPYCACHEPREFIX=str(OUT/'bytecode'/name),RECOMPYLER_CACHE=str(c/'rp'),NUMBA_CACHE_DIR=str(c/'numba'),TEMP=str(c/'temp'),TMP=str(c/'temp'))
    return e
def run(cmd,cwd,e,timeout):
    t=time.perf_counter()
    try:
        p=subprocess.run(cmd,cwd=cwd,env=e,capture_output=True,timeout=timeout); r=(p.returncode,p.stdout,p.stderr[-8000:].decode('utf-8','replace'))
    except subprocess.TimeoutExpired: r=('timeout',b'','')
    return time.perf_counter()-t,r
for n in args:
    w=W[n]; e=env(n); plan=OUT/'plans'/f'{n}.plan.json'; plan.parent.mkdir(parents=True,exist_ok=True)
    if plan.exists(): plan.unlink()
    pw,pr=run([PY,'-m','recompyler','profile','--json',str(plan),'--limit','40','--samples','8',w['script'],*w['args']],w['cwd'],e,1200)
    (OUT/f'{n}.profile.txt').write_bytes(pr[1]+b'\n--stderr--\n'+pr[2].encode())
    print(n,'profile %.1fs exit %s'%(pw,pr[0]),flush=True)
    if pr[0]!=0: print(pr[2]); continue
    if PONLY: continue
    plain=[];rp=[];same=True;ref=None;err='';counts=None
    for r in range(REPS):
        for mode in (['plain','rp'] if r%2==0 else ['rp','plain']):
            cp=OUT/f'{n}.counts.json'
            cmd=[PY,w['script'],*w['args']] if mode=='plain' else [PY,'-m','recompyler','run','--json',str(cp),'--plan',str(plan),w['script'],*w['args']]
            t,(code,out,er)=run(cmd,w['cwd'],e,900)
            (plain if mode=='plain' else rp).append(t)
            if code!=0: err=f'{mode} exit {code}: {er[-400:]}'
            if mode=='plain' and ref is None: ref=out
            if mode=='rp' and ref is not None and out!=ref: same=False
            if mode=='rp' and cp.exists(): counts=json.load(open(cp))
    fns=[(f['function'],f['compiled_calls'],f['fallback_calls']) for f in (counts or {}).get('functions',[])]
    print('%s plain %.3fs rp %.3fs x%.2f same=%s fns=%s err=%s'%(n,statistics.median(plain),statistics.median(rp),statistics.median(plain)/statistics.median(rp),same,fns,err),flush=True)
