"""Prepared missing-component cohort; do not run before accepted Step0 RESULT.

Example after acceptance (through run_locked with the same label):
 python inplace/kernel_phase_cohort.py --variant integration-cache --output inplace/bounds/kernel-cache-components --step0-result-checkpoint N --lock-label LABEL
This script does not acquire/wait for a lock or build any artifact.
"""
from pathlib import Path
from collections import Counter
import argparse,hashlib,json,os,struct,subprocess,sys
import kernel_phases as phase
D=Path(__file__).resolve().parent;R=D.parent;W=R.parent
NAMES=('barnes_hut','scimark','raytrace')

def write(path,value):
 with Path(path).open('x',encoding='utf-8') as stream:json.dump(value,stream,indent=2);stream.write('\n')

def checks(path):
 result={}
 for line in path.read_text(encoding='utf-8').splitlines():
  fields=line.split()
  if len(fields)==3 and fields[0]=='check':
   assert fields[1] not in result
   result[fields[1]]=struct.pack('!d',float.fromhex(fields[2])).hex() if '0x' in fields[2].lower() else fields[2]
 assert result, 'No correctness checks in child stdout'
 return result

def application_bytes(path):
 # Driver timing records are the only bytes excluded. Preserve all other
 # stdout and compare stderr exactly between plain/on/off children.
 output=[]
 for line in path.read_bytes().splitlines(keepends=True):
  fields=line.split()
  if len(fields)==2 and fields[0].startswith(b'seconds'):
   float(fields[1]);continue
  output.append(line)
 return b''.join(output)

def identity(row,script):return str(Path(row.get('file',script)).resolve()),row['function']

def counters(report):
 assert report['exit_code'] in (None,0) and not report['not_found'] and not report['batches'] and not report.get('batch_failures')
 rows={}
 for row in report['functions']:
  key=identity(row,report['script']);assert key not in rows
  assert row['compiled_calls']==row['aot_calls'] and row['jit_calls']==row['fallback_calls']==0
  rows[key]=row['aot_calls']
 return rows

def validate(data,variant,name,resets,frozen):
 assert data['variant']==variant and data['resets']==resets and data['frozen']==frozen
 actual=counters(data['report'])
 reference=json.loads((W/'wave11-ledger/gap-ledger/work'/name/'audit.counts.json').read_text(encoding='utf-8-sig'))
 expected={identity(row,reference['script']):resets*row.get('aot_calls',0) for row in reference['functions']}
 assert actual==expected, ('Selected function identities/counts changed',name,actual,expected)
 if data['mode']=='uninstrumented':
  assert not data['attempts'];return dict(counts={key[1]:value for key,value in actual.items()})
 plan=json.loads((D/'artifacts'/variant/name/'plan.json').read_text(encoding='utf-8-sig'))
 allowed=set()
 folder=D/'artifacts'/variant/name
 for kind in ('aot','aot_regions'):
  section=plan.get('plan',{}).get(kind)
  if not section:continue
  for module in folder.glob(section['module']+'*'):
   if module.suffix not in ('.pyd','.so','.dll'):continue
   for row in section['functions']:
    for key,symbol in row['exports'].items():allowed.add((key if kind=='aot_regions' else row['digest'],symbol,str(module.resolve())))
 counted=Counter();groups={}
 for index,attempt in enumerate(data['attempts']):
  assert attempt['components_reconcile'] and all(v>=0 for v in attempt['exclusive_ns'].values())
  assert set(attempt['exclusive_ns'])==set(phase.LABELS)
  assert sum(attempt['exclusive_ns'].values())==attempt['component_sum_ns']==attempt['attempt_ns']
  assert attempt['exclusive_boundary_ns']+attempt['exclusive_native_ns']+attempt['exclusive_other_ns']==attempt['attempt_ns']
  assert attempt['aot_calls']==1 and attempt['jit_calls']==0
  events=attempt['native_events'];assert len(events)==attempt['native_entries']==attempt['phase_entries']['native_ns']>0
  assert [event['entry'] for event in events]==list(range(1,len(events)+1))
  for event in events:
   assert event['mode']=='aot' and (event['digest'],event['export'],event['module']) in allowed
   relative=Path(event['module']).relative_to(folder.resolve()).as_posix()
   assert frozen['artifacts'][relative]==event['module_sha256']==phase.sha(event['module'])
  # Capacity-growth retries belong to this single complete attempt. They are
  # not extra successful calls and are never divided out of the timer.
  assert events[-1]['status_after']==0 and all(event['status_after']==2 for event in events[:-1])
  counted[attempt['function']]+=1;groups.setdefault(attempt['function'],[]).append((index,attempt))
 assert counted==Counter({key[1]:count for key,count in actual.items() if count}), (name,counted,actual)
 summary={}
 for function,rows in groups.items():
  per_reset=[row.get('aot_calls',0) for row in reference['functions'] if row['function']==function]
  assert len(per_reset)==1 and per_reset[0]>0 and len(rows)==resets*per_reset[0]
  per_reset=per_reset[0]
  mean=lambda subset:{key:sum(row['exclusive_ns'][key] for _,row in subset)/len(subset)/1000 for key in phase.LABELS}
  summary[function]=dict(attempts=len(rows),mean_exclusive_us=mean(rows),
      first_attempt_index=rows[0][0],first_native_entries=rows[0][1]['native_entries'],
      native_entries_per_attempt=[row['native_entries'] for _,row in rows],
      statuses_per_attempt=[[event['status_after'] for event in row['native_events']] for _,row in rows],
      excluding_first_attempt_mean_exclusive_us=mean(rows[1:]) if len(rows)>1 else None,
      calls_per_reset=per_reset,derived_reset_by_attempt={str(index):position//per_reset for position,(index,row) in enumerate(rows)},
      per_reset_mean_exclusive_us=[mean(rows[reset*per_reset:(reset+1)*per_reset]) for reset in range(resets)],
      warmed_resets_excluding_entire_first=dict(resets=resets-1,attempts=len(rows)-per_reset,
          mean_exclusive_us=mean(rows[per_reset:])) if resets>1 else None,
      timing_scope='All-attempt means include cold preparation/retries; warmed subset excludes the entire first reset (100 Barnes, 50 of each FFT, 1 raytrace call). Neither scope is additive to the independently printed minimum reset duration.')
 return summary

def main():
 parser=argparse.ArgumentParser(description=__doc__)
 parser.add_argument('--variant',default='integration-cache')
 parser.add_argument('--output',type=Path,required=True)
 parser.add_argument('--resets',type=int,default=5)
 parser.add_argument('--step0-result-checkpoint',type=int,required=True)
 parser.add_argument('--lock-label',required=True)
 options=parser.parse_args();assert options.resets>0
 accepted=phase.gate(options.variant,options.step0_result_checkpoint,options.lock_label)
 frozen={name:phase.frozen_inputs(options.variant,name) for name in NAMES}
 output=options.output.resolve();assert output.is_relative_to(D/'bounds') and not output.exists()
 output.mkdir(parents=True)
 provenance=dict(accepted_step0=accepted,variant=options.variant,resets=options.resets,
     harness_sha256=phase.sha(__file__),worker_sha256=phase.sha(D/'kernel_phases.py'),
     frozen=frozen,diagnostic_only=True,timing_eligible=False)
 write(output/'freeze.json',provenance)
 summaries={}
 try:
  for name in NAMES:
   directory=output/name;directory.mkdir()
   env=os.environ.copy();env.pop('PYTHONDONTWRITEBYTECODE',None)
   cache=directory/'cache';temporary=directory/'temp';temporary.mkdir()
   env.update(PYTHONPATH=os.pathsep.join([str(W/'wave5-study/results/shim'),str(D/'bases'/options.variant/'src'),str(D)]),
       PYTHONPYCACHEPREFIX=str(directory/'bytecode'),RECOMPYLER_CACHE=str(cache),RECOMPYLER_CACHE_DIR=str(cache),
       NUMBA_CACHE_DIR=str(directory/'numba'),TEMP=str(temporary),TMP=str(temporary),PYTHONHASHSEED='0',PYTHONWARNINGS='ignore',
       OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1',NUMBA_NUM_THREADS='1')
   def child(mode,command):
    phase.gate(options.variant,options.step0_result_checkpoint,options.lock_label)
    invocation=dict(command=[str(value) for value in command],cwd=str(R),
        environment={key:env[key] for key in ('PYTHONPATH','PYTHONPYCACHEPREFIX','RECOMPYLER_CACHE','NUMBA_CACHE_DIR','TEMP','TMP','PYTHONHASHSEED','PYTHONWARNINGS','OMP_NUM_THREADS','OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','NUMBA_NUM_THREADS')})
    write(directory/(mode+'.invocation.json'),invocation)
    with (directory/(mode+'.stdout')).open('xb') as out,(directory/(mode+'.stderr')).open('xb') as err:
     result=subprocess.run([str(value) for value in command],cwd=R,env=env,stdout=out,stderr=err)
    write(directory/(mode+'.receipt.json'),dict(exit_code=result.returncode,stdout_sha256=phase.sha(directory/(mode+'.stdout')),stderr_sha256=phase.sha(directory/(mode+'.stderr')),timing_eligible=False))
    assert result.returncode==0, (name,mode,result.returncode)
   script=W/'wave5-study/results/drivers'/(name+'.py')
   child('plain',[sys.executable,script,str(options.resets)])
   for mode in ('uninstrumented','instrumented'):
    child(mode,[sys.executable,D/'kernel_phases.py',name,'--variant',options.variant,'--mode',mode,
        '--output',directory/(mode+'.json'),'--resets',str(options.resets),'--step0-result-checkpoint',str(options.step0_result_checkpoint),'--lock-label',options.lock_label])
   baseline=checks(directory/'plain.stdout')
   assert baseline==checks(W/'wave11-ledger/gap-ledger/work'/name/'plain-0.stdout')
   for mode in ('uninstrumented','instrumented'):
    assert checks(directory/(mode+'.stdout'))==baseline
    assert application_bytes(directory/(mode+'.stdout'))==application_bytes(directory/'plain.stdout'), (name,mode,'stdout beyond timing records changed')
    assert (directory/(mode+'.stderr')).read_bytes()==(directory/'plain.stderr').read_bytes(), (name,mode,'stderr changed')
   off=json.loads((directory/'uninstrumented.json').read_text(encoding='utf-8'))
   on=json.loads((directory/'instrumented.json').read_text(encoding='utf-8'))
   validate(off,options.variant,name,options.resets,frozen[name])
   assert counters(off['report'])==counters(on['report'])
   summaries[name]=validate(on,options.variant,name,options.resets,frozen[name])
   assert frozen[name]==phase.frozen_inputs(options.variant,name)
   write(directory/'complete.json',dict(accepted=True,checks=baseline,counter_and_partition_checks=True,instrumentation_behavior_equal=True,
       evidence=phase.inventory(directory),summary=summaries[name]))
   print(name,'exact checks/counters/retry entries/exclusive sums match',flush=True)
  assert all(frozen[name]==phase.frozen_inputs(options.variant,name) for name in NAMES)
  write(output/'summary.json',dict(complete=True,variant=options.variant,resets=options.resets,programs=summaries,
      freeze_sha256=phase.sha(output/'freeze.json'),diagnostic_only=True,timing_eligible=False,
      limitations=['Per-program instrumented contexts remain separate; no cross-kernel time aggregate.',
        'First attempts and full first resets are explicit; warmed means exclude the entire first reset using exact per-function call counts, never just the first call.',
        'Driver whole-kernel printed time is the minimum of reset durations; diagnostic component means cannot be added to or subtracted from that minimum.',
        'Historical checksum/count references are reused; historical timing components are not pooled or subtracted.',
        'Observer overhead remains in every bucket; zero non-applicable FFT labels are explicitly documented in the worker scope audit.']))
 except BaseException as exc:
  write(output/'FAILED.json',dict(error=type(exc).__name__+': '+str(exc),aggregate_eligible=False))
  raise

if __name__=='__main__':main()
