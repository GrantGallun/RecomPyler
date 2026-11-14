"""Separate unchanged-source production-proof comparison; no manual variants."""
import argparse
import os
from pathlib import Path
import shutil
import statistics
import sys

HERE=Path(__file__).resolve().parent
STUDY=HERE.parent/'wave6-study'
sys.path.insert(0,str(STUDY))
import causal
import common

def sha(path): return causal.sha(path)

def prepare(args):
    out=args.output.resolve()
    if (out/'manifest.json').exists(): raise SystemExit('Manifest exists; choose new result path.')
    candidate=common.revision(args.candidate.resolve())
    if candidate['git_status'] or candidate['git_head']!=args.candidate_commit: raise SystemExit('Candidate must be clean at exact coordinator-frozen commit.')
    manual=common.read(STUDY/'results-v2'/'manifest.json')
    causal.verify(STUDY/'results-v2',manual)
    baseline=manual['source']
    out.mkdir(parents=True,exist_ok=True)
    for n in ['bin','c-sources','shim']:
        shutil.copytree(STUDY/'results-v2'/n,out/n,ignore=shutil.ignore_patterns('__pycache__'))
    (out/'plans').mkdir()
    shutil.copyfile(STUDY/'results-v2'/'cases'/'current-direct'/'plan.json',out/'plans'/'baseline.json')
    sources={'baseline':baseline,'candidate':candidate}
    helpers={str(STUDY/n):sha(STUDY/n) for n in ['profile_target.py','state_audit.py','arena_phase.py','audit.py','common.py','causal.py','warm_bytecode.py']}
    helpers[str(HERE/'proof.py')]=sha(HERE/'proof.py')
    manifest={'schema':1,'sources':sources,'runtime_identity':common.runtime_identity(),'python':sys.executable,
        'execution_environment':manual['execution_environment'],'script':manual['cases']['current-direct']['script'],
        'script_sha256':manual['cases']['current-direct']['script_sha256'],'reused_profile':manual['reused_profile'],
        'helpers':helpers,'input_inventory':{n:common.file_hashes(out/n) for n in ['bin','c-sources','shim']},
        'baseline_plan_sha256':sha(out/'plans'/'baseline.json'),'c_provenance':manual['c_provenance'],'timeout_s':300,
        'method':'Separate unchanged original source proof comparison. One fresh candidate target-only profile; exact baseline plan/profile reused.20 fresh rotating timing children five each plain/C/baseline/candidate; Python best5,Cbest20. Two separate100step state/actual-mode audits, two separate6reset phase processes. No manual-contract timing reuse.',
        'limits':['Finite state/output/alias/type corpus checks, not universal semantic proof','Explicit forced target-only diagnostic policy',
                  'RP generic AOT target versus C -march=native impact unmeasured','Shared background load; no OS-wide quiet claim','Instrumented phases not headline timing']}
    common.save(out/'manifest.json',manifest)
    print('FROZEN '+str(out/'manifest.json')+' sha256='+sha(out/'manifest.json'),flush=True)

def verify(out,m):
    if common.runtime_identity()!=m['runtime_identity']: raise SystemExit('Runtime changed.')
    for source in m['sources'].values():
        if common.revision(Path(source['path']))!=source: raise SystemExit('Frozen source changed.')
    for path,h in m['helpers'].items():
        if sha(path)!=h: raise SystemExit('Frozen helper changed.')
    for n,h in m['input_inventory'].items():
        if common.file_hashes(out/n)!=h: raise SystemExit('Frozen inputs changed.')
    if sha(m['script'])!=m['script_sha256']: raise SystemExit('Original driver changed.')
    if sha(out/'plans'/'baseline.json')!=m['baseline_plan_sha256']: raise SystemExit('Baseline plan changed.')
    for path,h in m['reused_profile']['artifact_sha256'].items():
        if sha(path)!=h: raise SystemExit('Reused AOT binary changed.')

def env(out,m,source,writes=False):
    cache=out/'cache'/source;temp=cache/'temp';temp.mkdir(parents=True,exist_ok=True)
    e=dict(m['execution_environment'])
    e.update(PYTHONPATH=os.pathsep.join([str(out/'shim'),str(Path(m['sources'][source]['path'])/'src')]),
        RECOMPYLER_CACHE=str(cache/'recompyler'),NUMBA_CACHE_DIR=str(cache/'numba'),TEMP=str(temp),TMP=str(temp),
        PYTHONHASHSEED='0',PYTHONWARNINGS='ignore',PYTHONPYCACHEPREFIX=str(out/'bytecode'),PYTHONDONTWRITEBYTECODE='0' if writes else '1')
    return e

def execute(out,m,stem,cmd,source='baseline',writes=False):
    r=common.execute(stem,cmd,out,env(out,m,source,writes),m['timeout_s'])
    if r['exit_code'] or r['status']!='ok': raise SystemExit('FAILED '+str(stem)+'; evidence preserved.')
    return r

def run(args):
    out=args.output.resolve();m=common.read(out/'manifest.json');verify(out,m);py=m['python'];script=m['script']
    warm=[py,str(STUDY/'warm_bytecode.py'),*[str(Path(s['path'])/'src') for s in m['sources'].values()],script,str(out/'shim')]
    freeze=out/'bytecode-frozen.json'
    if not freeze.exists(): execute(out,m,out/'warmup-before',warm,writes=True)
    reference_path=out/'plain-state.json'
    cmd=[py,str(STUDY/'state_audit.py'),'--script',script,'--target','advance_system','--group','1','--output',str(reference_path)]
    execute(out,m,out/'plain-state-process',cmd,writes=not freeze.exists())
    reference=common.read(reference_path)
    cmd=[py,str(STUDY/'profile_target.py'),'--script',script,'--target','advance_system','--output',str(out/'plans'/'candidate.json')]
    execute(out,m,out/'candidate-profile',cmd,'candidate',True)
    artifacts=dict(m['reused_profile']['artifact_sha256'])
    sec=common.read(out/'plans'/'candidate.json')['plan']['aot_regions']
    for p in Path(sec['folder']).glob(sec['module']+'*.pyd'): artifacts[str(p)]=sha(p)
    apath=out/'aot-artifacts-frozen.json'
    if apath.exists() and common.read(apath)!=artifacts: raise SystemExit('AOT inventory changed.')
    common.save(apath,artifacts)
    if not freeze.exists():
        execute(out,m,out/'warmup-final',warm,writes=True)
        common.save(freeze,common.bytecode_inventory(out/'bytecode'))
    common.verify_bytecode(out/'bytecode',common.read(freeze))
    for source in m['sources']:
        path=out/(source+'-state.json')
        cmd=[py,str(STUDY/'state_audit.py'),'--script',script,'--target','advance_system','--group','1','--plan',str(out/'plans'/(source+'.json')),'--output',str(path)]
        execute(out,m,out/(source+'-state-process'),cmd,source)
        data=common.read(path)
        comparison=causal.audit_compare(reference,{},data)
        if comparison['final_type_deltas'] or comparison['initial_type_differences']: raise SystemExit('Production proof changed observable types.')
        common.save(out/(source+'-state-comparison.json'),comparison)
        t=data['mode_evidence']['totals']
        if t['aot_calls']!=100 or any(t[k] for k in ['jit_calls','fallback_calls','rejected_attempts','unknown_native_calls']): raise SystemExit('Not exact AOT audit.')
    labels=['plain','c','baseline','candidate']
    for r in range(5):
        for label in labels[r%4:]+labels[:r%4]:
            source='baseline' if label in ['plain','c'] else label
            if label=='plain': cmd=[py,script,'5']
            elif label=='c': cmd=[str(out/'bin'/'barnes_hut.exe'),'20']
            else: cmd=[py,'-m','recompyler','run','--force','--plan',str(out/'plans'/(label+'.json')),'--json',str(out/'timings'/f'{label}-{r}.counts.json'),script,'5']
            execute(out,m,out/'timings'/f'{label}-{r}',cmd,source)
        print('PROOF TIMING ROTATION '+str(r+1),flush=True)
    for source,item in m['sources'].items():
        cmd=[py,str(STUDY/'arena_phase.py'),'--repo',item['path'],'--script',script,'--target','advance_system','--plan',str(out/'plans'/(source+'.json')),'--output',str(out/(source+'-phase.json'))]
        execute(out,m,out/(source+'-phase-process'),cmd,source)
    common.verify_bytecode(out/'bytecode',common.read(freeze));verify(out,m)
    if any(sha(p)!=h for p,h in artifacts.items()): raise SystemExit('AOT binaries changed.')
    common.save(out/'complete.json',{'completed':True,'manifest_sha256':sha(out/'manifest.json'),'artifact_sha256':artifacts,'bytecode_unchanged':True})
    summarize(args)

def summarize(args):
    out=args.output.resolve();m=common.read(out/'manifest.json');ref=causal.parse(out/'timings'/'plain-0.stdout')[0];rows={}
    for label in ['plain','c','baseline','candidate']:
        records=[];times=[];counts=[];valid=True
        for r in range(5):
            path=out/'timings'/f'{label}-{r}.json';record=common.read(path)
            checks,t=causal.parse(path.with_suffix('.stdout'));valid=valid and causal.check_equal(ref,checks) and record['exit_code']==0 and record['status']=='ok'
            records.append(record);times.append(t['seconds'])
            cp=out/'timings'/f'{label}-{r}.counts.json'
            if cp.exists():counts.append(common.read(cp))
        aot,jit=common.exact_timing_modes(counts,5) if counts else (None,None)
        fallback=sum(f.get('fallback_calls',0) for c in counts for f in c.get('functions',[])) if counts else None
        rows[label]={'checks_valid':valid,'kernel_samples_s':times,'median_best_kernel_s':statistics.median(times),
            'process_wall_samples_s':[r['wall_s'] for r in records],'median_process_wall_s':statistics.median(r['wall_s'] for r in records),
            'aot_calls_total':aot,'jit_calls_total':jit,'fallback_calls_total':fallback,
            'actual_modes_valid':(aot==2500 and jit==fallback==0) if counts else None}
    common.save(out/'SUMMARY.json',{'manifest_sha256':sha(out/'manifest.json'),'rows':rows,
        'candidate_profile_wall_s':common.read(out/'candidate-profile.json')['wall_s'],
        'baseline_profile_cost_note':'Reused historical profile evidence; no fresh baseline profiling cost.'})

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('action',choices=['prepare','run','summary']);p.add_argument('--candidate',type=Path);p.add_argument('--candidate-commit');p.add_argument('--output',type=Path,default=HERE/'results');a=p.parse_args()
    {'prepare':prepare,'run':run,'summary':summarize}[a.action](a)
