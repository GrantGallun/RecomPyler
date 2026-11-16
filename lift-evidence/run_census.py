"""One serial below-normal census; every program needs its own complete receipt."""
from pathlib import Path
import hashlib,json,subprocess,sys
R=Path(__file__).resolve().parents[1];D=R/'lift-evidence';OUT=D/sys.argv[1]
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
OUT.mkdir(exist_ok=False)
pop=D/'census-population-v2.json';data=json.loads(pop.read_text());results=[]
common_files=[Path(__file__),D/'all_blockers.py',D/'census_population.py',D/'census_collect.py',pop,R.parent/'wave14-capture/capture/input-manifest.json']
common_files += [p for p in (R/'src/recompyler').rglob('*') if p.is_file() and p.suffix in ('.py','.c','.h','.pyd')]
common={str(p.resolve()):sha(p) for p in common_files}
(OUT/'frozen-inputs.json').write_text(json.dumps(common,indent=2))
def verify_common():
 assert all(sha(Path(p))==h for p,h in common.items()),'whole-census source/helper/input changed'
verify_common()
for name in sorted({r['program'] for r in data['rows']}):
 verify_common()
 target=OUT/name;command=[sys.executable,str(D/'census_collect.py'),name,str(target),str(pop)]
 with (OUT/(name+'.stdout')).open('wb') as stdout,(OUT/(name+'.stderr')).open('wb') as stderr:
  try:
   done=subprocess.run(command,cwd=R,stdout=stdout,stderr=stderr,timeout=600)
   code=done.returncode;error=None
  except Exception as exc:code=None;error=type(exc).__name__+': '+str(exc)
 item=dict(program=name,command=command,exit_code=code,error=error,stdout_sha256=sha(OUT/(name+'.stdout')),stderr_sha256=sha(OUT/(name+'.stderr')))
 if code==0:
  complete=json.loads((target/'complete.json').read_text());assert complete['complete'] and complete['results_sha256']==sha(target/'results.json')
  assert all(complete['input_sha256'].get(p)==h for p,h in common.items()),'child from different census version'
  item.update(complete_sha256=sha(target/'complete.json'),results_sha256=sha(target/'results.json'))
 verify_common()
 results.append(item);(OUT/(name+'.receipt.json')).write_text(json.dumps(item,indent=2));print(name,code,flush=True)
(OUT/'summary.json').write_text(json.dumps({'program_attempts':results,'population_sha256':sha(pop)},indent=2))
(OUT/'complete.json').write_text(json.dumps({'complete':True,'collection_complete':all(r['exit_code']==0 for r in results),'summary_sha256':sha(OUT/'summary.json'),'frozen_inputs_sha256':sha(OUT/'frozen-inputs.json'),'note':'Failed/incomplete program attempts are excluded from diagnostics and preserved as unknown population rows, never reused.'},indent=2))
