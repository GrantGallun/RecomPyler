from pathlib import Path
import sys,subprocess,os,json,time,statistics,hashlib,struct
D=Path(__file__).resolve().parent;R=D.parent;W=R.parent
candidate=sys.argv[1] if len(sys.argv)>1 else 'integration-fixed';output=sys.argv[2] if len(sys.argv)>2 else 'integration-kernel-pairs-v2';repeats=int(sys.argv[3]) if len(sys.argv)>3 else 3;base=sys.argv[4] if len(sys.argv)>4 else 'depth'
names=['barnes_hut','fannkuch','scimark','raytrace'];sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
def checks(path):
 result={};times={}
 for line in path.read_text().splitlines():
  f=line.split()
  if len(f)==3 and f[0]=='check':result[f[1]]=struct.pack('!d',float.fromhex(f[2])).hex() if '0x' in f[2].lower() else f[2]
  if len(f)==2 and f[0].startswith('seconds'):times[f[0]]=float(f[1])
 return result,times
result={};out=D/output;out.mkdir(exist_ok=False)
for n in names:
 result[n]={}
 for rep in range(repeats):
  for v in ([base,candidate] if rep%2==0 else [candidate,base]):
   stem=out/f'{n}-{v}-{rep}';env=os.environ.copy();env['PYTHONPATH']=os.pathsep.join([str(W/'wave5-study/results/shim'),str(D/'bases'/v/'src')]);count=stem.with_suffix('.counts.json')
   cmd=[sys.executable,'-m','recompyler','run','--force','--plan',str(D/'artifacts'/('integration' if v=='integration-fixed' else v)/n/'plan.json'),'--json',str(count),str(W/'wave5-study/results/drivers'/(n+'.py')),'5']
   start=time.perf_counter()
   with stem.with_suffix('.stdout').open('wb') as stdout,stem.with_suffix('.stderr').open('wb') as stderr:p=subprocess.run(cmd,env=env,cwd=R,stdout=stdout,stderr=stderr)
   receipt={'command':cmd,'exit_code':p.returncode,'wall_s':time.perf_counter()-start,'stdout_sha256':sha(stem.with_suffix('.stdout'))};stem.with_suffix('.receipt.json').write_text(json.dumps(receipt,indent=2));assert p.returncode==0,stem
   check,ts=checks(stem.with_suffix('.stdout'));ref=checks(W/'wave11-ledger/gap-ledger/work'/n/'plain-0.stdout')[0];assert check==ref,(n,v,check,ref)
   c=json.loads(count.read_text());audit=json.loads((W/'wave11-ledger/gap-ledger/work'/n/'audit.counts.json').read_text());key=lambda x:(x['function'],x.get('line'))
   assert {key(x):x.get('aot_calls',0) for x in c['functions']}=={key(x):5*x.get('aot_calls',0) for x in audit['functions']},(n,v,c)
   assert not any(x.get('jit_calls',0) or x.get('fallback_calls',0) for x in c['functions']) and not c.get('not_found') and not c.get('batches')
   result[n].setdefault(v,[]).append(ts['seconds_fft' if n=='scimark' else 'seconds']*1000);print(n,v,rep,result[n][v][-1],flush=True)
for n,vs in result.items():
 for v,ts in list(vs.items()):vs[v]={'samples_ms':ts,'median_ms':statistics.median(ts)}
(out/'summary.json').write_text(json.dumps(result,indent=2))
