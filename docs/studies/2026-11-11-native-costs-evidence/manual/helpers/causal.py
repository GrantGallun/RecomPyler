"""Small frozen six-case Barnes causal diagnostic. No production source writes."""
import argparse
import json
import os
from pathlib import Path
import shutil
import statistics
import struct
import sys

import common
import variants

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
OLD = ROOT / 'wave5-study' / 'results'
HELPERS = ['causal.py','common.py','variants.py','profile_target.py','state_audit.py','audit.py','arena_phase.py','warm_bytecode.py','PROTOCOL.md']

def sha(path):
    return common.digest(Path(path).read_bytes())

def parse(path):
    checks, times = {}, {}
    for line in Path(path).read_text(errors='replace').splitlines():
        f = line.split()
        if len(f) == 3 and f[0] == 'check': checks[f[1]] = f[2]
        if len(f) == 2 and f[0].startswith('seconds'): times[f[0]] = float(f[1])
    return checks, times

def check_equal(a,b):
    return a.keys() == b.keys() and all(struct.pack('!d',float.fromhex(v)) == struct.pack('!d',float.fromhex(b[k])) for k,v in a.items())

def prepare(out):
    if (out/'manifest.json').exists(): raise SystemExit('Existing frozen manifest; choose new output.')
    repo = HERE/'baseline'
    source = common.revision(repo)
    old = common.read(OLD/'manifest.json')
    if source['git_status'] or source['git_head'] != '0aeb157e8d272e0b1d4787a173f5b66f75d81b01': raise SystemExit('Baseline not frozen/clean.')
    if source['src_sha256'] != old['sources']['candidate']['src_sha256']: raise SystemExit('Reused plan product bytes mismatch.')
    if common.runtime_identity() != old['runtime_identity']: raise SystemExit('Reused plan runtime mismatch.')
    original = OLD/'drivers'/'barnes_hut.py'
    if sha(original) != old['programs']['barnes_hut']['script_sha256']: raise SystemExit('Original driver changed.')
    (out/'drivers').mkdir(parents=True,exist_ok=True)
    shutil.copyfile(original,out/'drivers'/'current-direct.py')
    shutil.copytree(OLD/'shim',out/'shim',ignore=shutil.ignore_patterns('__pycache__'),dirs_exist_ok=True)
    for folder, name in [('bin','barnes_hut.exe'),('c-sources','barnes_hut.c')]:
        (out/folder).mkdir(exist_ok=True)
        shutil.copyfile(OLD/folder/name,out/folder/name)
    if sha(out/'bin'/'barnes_hut.exe') != old['programs']['barnes_hut']['binary_sha256']: raise SystemExit('C changed.')
    cases = {}
    for name, contract, group in variants.CASES:
        text, target, edits = variants.driver(original.read_text(),contract,group)
        script = original if name == 'current-direct' else out/'drivers'/(name+'.py')
        if name != 'current-direct': script.write_text(text,encoding='utf-8')
        cases[name] = {'script':str(script),'script_sha256':sha(script),'contract':contract,'group':group or 1,
                       'target':target,'edits':edits,'reused_profile':name=='current-direct'}
    planpath = OLD/'programs'/'barnes_hut'/'candidate.plan.json'
    report = common.read(planpath)
    sec = report['plan']['aot_regions']
    artifacts = {str(p):sha(p) for p in Path(sec['folder']).glob(sec['module']+'*.pyd')}
    if not artifacts: raise SystemExit('Reused AOT binary missing.')
    provenance = {'report':str(planpath),'report_sha256':sha(planpath),'manifest_sha256':sha(OLD/'manifest.json'),
                  'artifact_sha256':artifacts,'profile_record':common.read(OLD/'programs'/'barnes_hut'/'candidate-profile.json'),
                  'note':'Historical profile cost only; all wave6 latency/audits fresh. Original executing path retained.'}
    common.save(out/'reused-profile-provenance.json',provenance)
    report['functions'] = [r for r in report['functions'] if r['function']=='advance_system']
    for r in report['functions']:
        if r['candidate'].get('status') != 'verified' or r['candidate'].get('engine') != 'region': raise SystemExit('Reused target not verified heapRegion.')
        r['candidate']['diagnostic_original_recommended'] = r['candidate'].get('recommended')
        r['candidate']['recommended'] = True
    report['manual_diagnostic_contract']='Reused verified target-only selection; force explicitly diagnostic.'
    common.save(out/'cases'/'current-direct'/'plan.json',report)
    manifest = {'schema':1,'source':source,'baseline_evidence_sha256':sha(HERE/'BASELINE.json'),
        'python':sys.executable,'runtime_identity':common.runtime_identity(),
        'execution_environment':common.execution_environment(ROOT.parent/'heads-up-bot'),
        'helpers':{n:sha(HERE/n) for n in HELPERS},'cases':cases,
        'input_inventory':{n:common.file_hashes(out/n) for n in ['drivers','shim','bin','c-sources']},
        'reused_profile':provenance,'repetitions':5,'python_inner_reps':5,'c_inner_reps':20,'timeout_s':300,
        'c_provenance':old['c_provenance'],'aot_target':'generic Numba AOT; C -march=native; impact unmeasured',
        'method':'Manual target-only forced diagnostic; six cases, five fresh profiles and reused exact current plan; full-state untimed audits; 40 rotating fresh timing children; six separate instrumented phase processes.'}
    common.save(out/'manifest.json',manifest)
    print('FROZEN manifest sha256='+sha(out/'manifest.json'),flush=True)

def verify(out,m):
    if common.runtime_identity()!=m['runtime_identity']: raise SystemExit('Runtime changed.')
    if common.revision(Path(m['source']['path']))!=m['source']: raise SystemExit('Baseline changed.')
    for n,h in m['helpers'].items():
        if sha(HERE/n)!=h: raise SystemExit('Helper changed: '+n)
    for n,h in m['input_inventory'].items():
        if common.file_hashes(out/n)!=h: raise SystemExit('Input inventory changed: '+n)
    for item in m['cases'].values():
        if sha(item['script'])!=item['script_sha256']: raise SystemExit('Executing script changed.')
    for p,h in m['reused_profile']['artifact_sha256'].items():
        if sha(p)!=h: raise SystemExit('Reused AOT changed.')

def env(out,m,name,writes=False):
    cache=out/'cache'/name
    temp=cache/'temp';temp.mkdir(parents=True,exist_ok=True)
    e=dict(m['execution_environment'])
    e.update(PYTHONPATH=os.pathsep.join([str(out/'shim'),str(Path(m['source']['path'])/'src')]),
        RECOMPYLER_CACHE=str(cache/'recompyler'),NUMBA_CACHE_DIR=str(cache/'numba'),TEMP=str(temp),TMP=str(temp),
        PYTHONHASHSEED='0',PYTHONWARNINGS='ignore',PYTHONPYCACHEPREFIX=str(out/'bytecode'),PYTHONDONTWRITEBYTECODE='0' if writes else '1')
    return e

def execute(out,m,stem,command,name='current-direct',writes=False):
    result=common.execute(stem,command,out,env(out,m,name,writes),m['timeout_s'])
    if result['exit_code'] or result['status']!='ok': raise SystemExit('FAILED '+str(stem)+'; evidence retained.')
    return result

def audit_compare(reference,item,data):
    points={r['step']:r for r in reference['checkpoints']}
    for p in data['checkpoints']:
        if p['numeric_sha256']!=points[p['step']]['numeric_sha256']: raise SystemExit('Numeric checkpoint differs at '+str(p['step']))
        if p['aliases_sha256']!=points[p['step']]['aliases_sha256']: raise SystemExit('Mutable alias checkpoint differs.')
    if data['final']['numbers']!=reference['final']['numbers']: raise SystemExit('Full numeric final state differs.')
    if data['final']['aliases']!=reference['final']['aliases']: raise SystemExit('Full mutable alias state differs.')
    type_deltas={}
    for i,(a,b) in enumerate(zip(reference['final']['types'],data['final']['types'])):
        if a!=b:
            field=('position.x','position.y','velocity.x','velocity.y','acceleration.x','acceleration.y','mass')[i%7]
            key=field+':'+a+'->'+b
            type_deltas[key]=type_deltas.get(key,0)+1
    return {'numeric_checkpoints_match':True,'final_numeric_bits_match':True,'mutable_aliases_match':True,'final_type_deltas':type_deltas,
        'initial_type_differences':sum(a!=b for a,b in zip(reference['initial']['types'],data['initial']['types']))}

def run(out):
    m=common.read(out/'manifest.json');verify(out,m)
    py=m['python'];repo=Path(m['source']['path'])
    warm=[py,str(HERE/'warm_bytecode.py'),str(repo/'src'),str(out/'drivers'),str(out/'shim'),str(OLD/'drivers')]
    freeze=out/'bytecode-frozen.json'
    if not freeze.exists(): execute(out,m,out/'warmup-before',warm,writes=True)
    reference=None
    for name,item in m['cases'].items():
        folder=out/'cases'/name
        command=[py,str(HERE/'state_audit.py'),'--script',item['script'],'--target',item['target'],'--group',str(item['group']),'--output',str(folder/'plain-state.json')]
        execute(out,m,folder/'plain-state-process',command,name,not freeze.exists())
        data=common.read(folder/'plain-state.json')
        if reference is None: reference=data
        common.save(folder/'plain-state-comparison.json',audit_compare(reference,item,data))
        if not item['reused_profile']:
            command=[py,str(HERE/'profile_target.py'),'--script',item['script'],'--target',item['target'],'--output',str(folder/'plan.json')]
            execute(out,m,folder/'profile',command,name,True)
        print('PROFILE READY '+name,flush=True)
    artifacts=dict(m['reused_profile']['artifact_sha256'])
    for name in m['cases']:
        plan=common.read(out/'cases'/name/'plan.json')
        s=plan['plan']['aot_regions']
        for p in Path(s['folder']).glob(s['module']+'*.pyd'): artifacts[str(p)]=sha(p)
    apath=out/'aot-artifacts-frozen.json'
    if apath.exists() and common.read(apath)!=artifacts: raise SystemExit('AOT inventory changed.')
    common.save(apath,artifacts)
    if not freeze.exists():
        execute(out,m,out/'warmup-final',warm,writes=True)
        common.save(freeze,common.bytecode_inventory(out/'bytecode'))
    common.verify_bytecode(out/'bytecode',common.read(freeze))
    for name,item in m['cases'].items():
        folder=out/'cases'/name
        command=[py,str(HERE/'state_audit.py'),'--script',item['script'],'--target',item['target'],'--group',str(item['group']),'--plan',str(folder/'plan.json'),'--output',str(folder/'native-state.json')]
        execute(out,m,folder/'native-state-process',command,name)
        data=common.read(folder/'native-state.json')
        common.save(folder/'native-state-comparison.json',audit_compare(reference,item,data))
        modes=data['mode_evidence']['totals']
        if modes['aot_calls']!=100//item['group'] or any(modes[k] for k in ['jit_calls','fallback_calls','unknown_native_calls','rejected_attempts']): raise SystemExit('Non-AOT primary audit: '+name)
        print('STATE/AOT AUDIT PASS '+name,flush=True)
    labels=['plain','c']+list(m['cases'])
    for r in range(5):
        for label in labels[r:]+labels[:r]:
            name='current-direct' if label in ['plain','c'] else label
            item=m['cases'][name]
            if label=='plain': command=[py,item['script'],'5']
            elif label=='c': command=[str(out/'bin'/'barnes_hut.exe'),'20']
            else: command=[py,'-m','recompyler','run','--force','--plan',str(out/'cases'/name/'plan.json'),'--json',str(out/'timings'/f'{label}-{r}.counts.json'),item['script'],'5']
            execute(out,m,out/'timings'/f'{label}-{r}',command,name)
        print('TIMING ROTATION COMPLETE '+str(r+1),flush=True)
        summarize(out)
    for name,item in m['cases'].items():
        folder=out/'cases'/name
        command=[py,str(HERE/'arena_phase.py'),'--repo',str(repo),'--script',item['script'],'--target',item['target'],'--plan',str(folder/'plan.json'),'--output',str(folder/'phase.json')]
        execute(out,m,folder/'phase-process',command,name)
    common.verify_bytecode(out/'bytecode',common.read(freeze))
    if any(sha(p)!=h for p,h in artifacts.items()): raise SystemExit('AOT artifacts changed.')
    verify(out,m);summarize(out)
    common.save(out/'complete.json',{'manifest_sha256':sha(out/'manifest.json'),'artifact_sha256':artifacts,'bytecode_unchanged':True,'completed':True})

def summarize(out):
    m=common.read(out/'manifest.json');rows={}
    ref=parse(out/'timings'/'plain-0.stdout')[0]
    for label in ['plain','c']+list(m['cases']):
        records=[];times=[];counts=[];valid=True
        for r in range(5):
            path=out/'timings'/f'{label}-{r}.json'
            if not path.exists(): continue
            record=common.read(path);checks,t=parse(path.with_suffix('.stdout'))
            records.append(record);times.append(t['seconds'])
            valid=valid and check_equal(ref,checks) and record['status']=='ok' and record['exit_code']==0
            cp=out/'timings'/f'{label}-{r}.counts.json'
            if cp.exists(): counts.append(common.read(cp))
        aot,jit=common.exact_timing_modes(counts,len(records)) if counts else (None,None)
        rows[label]={'records':len(records),'checks_valid':valid and len(records)==5,'kernel_samples_s':times,
          'median_best_kernel_s':statistics.median(times) if times else None,'process_wall_samples_s':[v['wall_s'] for v in records],
          'median_process_wall_s':statistics.median(v['wall_s'] for v in records) if records else None,
          'aot_calls_total':aot,'jit_calls_total':jit,'fallback_calls_total':sum(f.get('fallback_calls',0) for c in counts for f in c.get('functions',[])) if counts else None}
    common.save(out/'SUMMARY.json',{'manifest_sha256':sha(out/'manifest.json'),'rows':rows})

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('action',choices=['prepare','run','summary']);p.add_argument('--output',type=Path,default=HERE/'results')
    a=p.parse_args();out=a.output.resolve()
    {'prepare':prepare,'run':run,'summary':summarize}[a.action](out)
