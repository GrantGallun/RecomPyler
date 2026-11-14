"""One fresh short cohort; conditional deltas, no historical rung pooling."""
from pathlib import Path
import json,os,statistics,sys,subprocess,time
import study
D=Path(__file__).resolve().parent;m=json.loads((D/'protocol.json').read_text());name='raytrace'
base=json.loads((D/'ray-current-base.json').read_text())['variant'] if (D/'ray-current-base.json').exists() else 'numeric-final-v2'
variants=['product','current','lists','tuples','float','float-tuples','float-stream','calls-replay','calls-inline','hand-core','hand','c'];result={}
for rep in range(3):
 order=variants[:] if rep%2==0 else list(reversed(variants))
 for mode in order:
  stem=D/'raw/ray-current'/f'{mode}-{rep}';stem.parent.mkdir(parents=True,exist_ok=True);assert not stem.with_suffix('.process.json').exists()
  env=study.env(name);env['PYTHONPATH']=os.pathsep.join([str(D/'shim'),str(D/'product-sources-v2'/base/'src')]);timekey='seconds'
  if mode=='product':cmd=[sys.executable,'-m','recompyler','run','--force','--plan',D/'product-artifacts-v2/raytrace'/base/'plan.json','--json',stem.with_suffix('.counts.json'),m['programs'][name]['script'],'5']
  elif mode=='hand-core':cmd=[sys.executable,D/'hand_current_core_driver.py','core']
  elif mode=='hand':cmd=[sys.executable,D/'hand_current_driver.py',name,'verify']
  elif mode=='c':cmd=[m['programs'][name]['binary'],'20']
  else:cmd=[sys.executable,D/'ray_current_native.py',mode];timekey='seconds_native'
  start=time.perf_counter()
  with stem.with_suffix('.stdout').open('wb') as out,stem.with_suffix('.stderr').open('wb') as err:r=subprocess.run([str(x) for x in cmd],env=env,cwd=D.parent,stdout=out,stderr=err,timeout=180)
  study.save(stem.with_suffix('.process.json'),{'exit_code':r.returncode,'command':[str(x) for x in cmd],'wall_s':time.perf_counter()-start,'stdout_sha256':study.sha(stem.with_suffix('.stdout')),'stderr_sha256':study.sha(stem.with_suffix('.stderr'))});assert r.returncode==0,stem
  checks,times=study.checks(stem.with_suffix('.stdout'));ref=study.checks(D.parent.parent/'wave11-ledger/gap-ledger/work/raytrace/plain-0.stdout')[0];assert checks==ref,(mode,checks,ref)
  raw=stem.with_suffix('.stdout').read_text()
  if mode=='product':
   count=json.loads(stem.with_suffix('.counts.json').read_text());assert sum(x.get('aot_calls',0) for x in count['functions'])==5 and not any(x.get('jit_calls',0) or x.get('fallback_calls',0) for x in count['functions']) and not count.get('not_found') and not count.get('batches')
  elif mode=='hand-core':assert 'CORE_AOT_CALLS 5' in raw
  elif mode=='hand':assert 'HAND_AOT_CALLS 5' in raw and 'FULL_PIXEL_MATCH' in raw
  elif mode!='c':assert 'NATIVE_CURRENT_CALLS 5' in raw
  study.save(stem.with_suffix('.valid.json'),{'valid':True,'checks':checks,'times':times,'timekey':timekey});result.setdefault(mode,[]).append(times[timekey]*1000);print(mode,rep,result[mode][-1],flush=True)
summary={k:{'samples_ms':v,'median_ms':statistics.median(v)} for k,v in result.items()}
steps=[]
for a,b,scope in [('product','current','packing/validation/writeback and setup excluded from native timer'),('current','lists','all scene/light list growth and copy removed; upfront capacity reservation retained'),('lists','tuples','all per-intersection tuple bumps batched; every tuple payload/handle store retained'),('tuples','float-tuples','whole-graph fixedFLOAT storage/scalar payload ABI and numeric checks together; diagnostic not general Python'),('float-tuples','float-stream','all intersection tuple payloads plus private list materialization and firstIntersection consumer fused; grouped, not pure tuple latency'),('calls-replay','calls-inline','one recursive dispatch/packed return edge removed, rayColour recursion retained'),('calls-inline','hand-core','unclosed grouped representation/control/remaining-call gap, not a single cost')]:
 delta=[x-y for x,y in zip(result[a],result[b])];steps.append({'from':a,'to':b,'median_difference_ms':summary[a]['median_ms']-summary[b]['median_ms'],'median_paired_saved_ms':statistics.median(delta),'paired_savings_ms':delta,'scope':scope,'development_noise_floor_percent':6})
study.save(D/'ray-current-summary.json',{'variants':summary,'conditional_steps':steps,'method':'three fresh alternating processes per variant, each best-of-five native/product or Cbest20; all checks exact; signed conditional differences, partial ablations explicit; no historical timings reused'})
