"""Fresh product ablations and matched C; all validated before summarizing."""
import json,sys,statistics,os,subprocess,time
from pathlib import Path
import study
D=Path(__file__).resolve().parent;m=json.loads((D/'protocol.json').read_text())
variants=['item1-final','scalar-abc-v1','c'];result={}
for n in ['fannkuch','scimark','barnes_hut','raytrace']:
 result[n]={}
 for rep in range(10):
  at=rep%len(variants)
  for v in variants[at:]+variants[:at]:
   stem=D/'raw/item2-accept'/f'{n}-{v}-{rep}';stem.parent.mkdir(parents=True,exist_ok=True)
   env=study.env(n)
   env['PYTHONPATH']=os.pathsep.join([str(D/'shim'),str(D/'product-sources-v2'/v/'src')]) if v!='c' else env['PYTHONPATH']
   countpath=stem.with_suffix('.counts.json')
   cmd=[m['programs'][n]['binary'],'20'] if v=='c' else [sys.executable,'-m','recompyler','run','--force','--plan',D/'product-artifacts-v2'/n/v/'plan.json','--json',countpath,m['programs'][n]['script'],'5']
   assert not stem.with_suffix('.process.json').exists()
   start=time.perf_counter()
   with stem.with_suffix('.stdout').open('wb') as out,stem.with_suffix('.stderr').open('wb') as err:
    child=subprocess.run([str(x) for x in cmd],env=env,cwd=D.parent,stdout=out,stderr=err,timeout=600)
   receipt={'command':[str(x) for x in cmd],'exit_code':child.returncode,'wall_s':time.perf_counter()-start,'stdout_sha256':study.sha(stem.with_suffix('.stdout')),'stderr_sha256':study.sha(stem.with_suffix('.stderr'))}
   study.save(stem.with_suffix('.process.json'),receipt);assert child.returncode==0,stem
   checks,times=study.checks(stem.with_suffix('.stdout'))
   reference=study.checks(D.parent.parent/'wave11-ledger/gap-ledger/work'/n/'plain-0.stdout')[0];assert checks==reference,(n,v,checks,reference)
   if v!='c':
    counts=json.loads(countpath.read_text());audit=json.loads((D.parent.parent/'wave11-ledger/gap-ledger/work'/n/'audit.counts.json').read_text());key=lambda x:(x['function'],x.get('line'))
    assert {key(x):x.get('aot_calls',0) for x in counts['functions']}=={key(x):5*x.get('aot_calls',0) for x in audit['functions']}
    assert not any(x.get('jit_calls',0) or x.get('fallback_calls',0) for x in counts['functions']) and not counts.get('not_found') and not counts.get('batches')
   study.save(stem.with_suffix('.valid.json'),{'valid':True,'checks':checks,'times':times})
   result[n].setdefault(v,[]).append(times['seconds_fft' if n=='scimark' else 'seconds']*1000)
   print(n,v,rep,round(result[n][v][-1],5),flush=True)
for n,vs in result.items():
 for v,ts in vs.items():assert len(ts)==10;vs[v]={'samples_ms':ts,'median_ms':statistics.median(ts)}
study.save(D/'item2-accept-summary.json',result)
