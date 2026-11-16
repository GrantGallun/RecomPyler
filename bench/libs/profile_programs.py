"""Native py-spy sampling of the same whole-program entry point."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import sys
from bench.libs.runner import ROOT,timing_lock
from bench.libs.shared_harness import environment,source_fingerprint
from bench.libs.attribution import summarize,opportunities


def workload_result(stdout):
    for line in stdout.splitlines():
        if line.startswith('{'):
            try:
                row=json.loads(line)
                if 'status' in row: return row
            except ValueError: pass
    return dict(status='error',reason='no benchmark child result')


def record(command,*,env,timeout=90):
    process=subprocess.Popen(command,cwd=ROOT,env=env,stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,
        creationflags=0x08004000 if os.name=='nt' else 0)
    try:
        stdout,stderr=process.communicate(timeout=timeout)
        return subprocess.CompletedProcess(command,process.returncode,stdout,stderr)
    except subprocess.TimeoutExpired:
        if os.name=='nt':
            subprocess.run(['taskkill','/PID',str(process.pid),'/T','/F'],capture_output=True)
        else: process.kill()
        if process.poll() is None: process.kill()
        stdout,stderr=process.communicate(timeout=15)
        return subprocess.CompletedProcess(command,124,stdout,stderr+'\nnative sampler exceeded bounded timeout')


def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--spy',type=Path,required=True)
    p.add_argument('--only',nargs='+');p.add_argument('--output',type=Path,required=True)
    p.add_argument('--engine',choices=['cpython_off','cpython_on','recompyler'],default='recompyler')
    p.add_argument('--split',choices=['train','heldout','libraries','cpu','cpu_long'],default='train')
    p.add_argument('--samples',type=int,default=3)
    p.add_argument('--rate',type=int,default=10);p.add_argument('--timeout',type=float,default=90);args=p.parse_args()
    from bench.libs.programs import manifest
    cases=args.only or list(manifest(args.split));reports=[]
    frozen=source_fingerprint()
    if not set(cases)<=set(manifest(args.split)): p.error('program outside training set')
    if args.samples<1:p.error('positive sample count required')
    if args.rate<1 or args.timeout<=0: p.error('positive rate and timeout required')
    args.output.mkdir(parents=True,exist_ok=True)
    from collections import Counter
    from bench.libs.amdahl import ceiling
    from bench.libs.timing_runner import test_processes
    from bench.libs.cpu_programs import fixture_identity
    fixture_hash=fixture_identity() if args.split in ('cpu','cpu_long') else None
    from bench.libs.bytecode_cache import prepare
    bytecode=prepare(sys.executable,split=args.split,names=cases)
    for name in cases:
        attempts=[];bodies=[];digest=None
        for attempt in range(2):
            observations=[];counts=Counter();failed=False;before=test_processes()
            if source_fingerprint()!=frozen:raise ValueError('source changed during profile')
            if fixture_hash is not None and fixture_identity()!=fixture_hash:raise ValueError('CPU fixture changed during profile')
            with timing_lock(ROOT.parent/'TIMING.lock',ROOT.parent/'WAVE21-LIBS-PLAN.md',purpose='native '+args.engine+' '+args.split+':'+name+' attempt'+str(attempt+1),expected=90):
                for sample in range(args.samples):
                    dest=args.output/(name+f'-{attempt}-{sample}.speedscope.json')
                    mapping=args.output/(name+f'-{attempt}-{sample}.bodies.json')
                    command=[str(args.spy),'record','--native','--rate',str(args.rate),'--format','speedscope','--output',str(dest),
                        '--',sys.executable,'-m','bench.libs.program_worker',name,'--engine',args.engine,'--split',args.split,
                        '--repeats',str(manifest(args.split)[name].repeats),'--body-map',str(mapping)]
                    env=environment(args.engine);env.update(_NT_SYMBOL_PATH='',_NT_ALTERNATE_SYMBOL_PATH='')
                    completed=record(command,env=env,timeout=args.timeout)
                    child=workload_result(completed.stdout)
                    observation=dict(command=command,returncode=completed.returncode,workload=child,stderr=completed.stderr[-3000:])
                    if completed.returncode==0 and child['status']=='ok' and dest.exists() and mapping.exists():
                        if digest is not None and digest!=child['digest']:raise ValueError('profile output changed')
                        digest=child['digest'];bodies=json.loads(mapping.read_text())
                        attribution=summarize(json.loads(dest.read_text()),bodies);counts.update(attribution['counts'])
                        observation['attribution']=attribution
                    else:failed=True
                    observations.append(observation)
            after=test_processes()
            attempts.append(dict(observations=observations,concurrent_tests_before=before,concurrent_tests_after=after))
            if not (before or after):break
        if source_fingerprint()!=frozen:raise ValueError('source changed during profile')
        if fixture_hash is not None and fixture_identity()!=fixture_hash:raise ValueError('CPU fixture changed during profile')
        total=sum(counts.values())
        row=dict(bytecode=bytecode,name=name,engine=args.engine,split=args.split,source_sha256=frozen,fixture_sha256=fixture_hash,
            status='unavailable' if failed or not total else 'ok',workload={'digest':digest},attempts=attempts,
            attribution=dict(counts=dict(counts),shares={key:value/total for key,value in counts.items()} if total else {},total_weight=total),
            body_ranges_complete=all(body['bounds']=='published native owner range' for body in bodies))
        if args.engine in ('cpython_off','cpython_on') and row['status']=='ok':row['amdahl']=ceiling(counts)
        reports.append(row);(args.output/'index.json').write_text(json.dumps(reports,indent=2))
        print(name,row['status'],flush=True)

    return int(any(r['status']!='ok' for r in reports))


if __name__=='__main__':raise SystemExit(main())
