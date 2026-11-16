"""Fresh S49 held-out count; historical 59/375 baseline is labelled, never replayed implicitly."""
from pathlib import Path
import collections,hashlib,json,os,subprocess,sys
R=Path(__file__).resolve().parents[1]; D=R/'lift-evidence'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()

def main():
 out=D/'range-s49-heldout-v1';out.mkdir(exist_ok=False)
 old=R/'matrix/sets-heldout-v1'; receipt=json.loads((old/'complete.json').read_text());assert receipt['complete']
 assert sha(old/'summary.json')==receipt['summary_sha256']
 historical=json.loads((old/'summary.json').read_text())
 result={'programs':{},'fixed_all_program_defined':375,'baseline_note':'before is historical accepted pre-range replay, 59/375, not a new run on merged trunk; after is fresh candidate replay. No deployment selection or timing claim.'}
 for name,pair in historical['programs'].items():
  target=out/(name+'-after');cmd=[sys.executable,'matrix/heldout_native.py',name,str(target)]
  with (out/(name+'.stdout')).open('wb') as stdout,(out/(name+'.stderr')).open('wb') as stderr:
   done=subprocess.run(cmd,cwd=R,env=os.environ.copy(),stdout=stdout,stderr=stderr,timeout=1800)
  item={'command':cmd,'exit_code':done.returncode,'stdout_sha256':sha(out/(name+'.stdout')),'stderr_sha256':sha(out/(name+'.stderr'))}
  (out/(name+'.receipt.json')).write_text(json.dumps(item,indent=2));assert done.returncode==0,item
  complete=json.loads((target/'complete.json').read_text());assert complete['complete'] and sha(target/'results.json')==complete['results_sha256']
  current=json.loads((target/'results.json').read_text())
  assert current['source_sha256']==pair['after']['source_sha256'],name
  result['programs'][name]={'before':pair['after'],'after':current}
  print(name,{k:current[k] for k in ('own_defined','captured','verified','whole_function_native','deployed')},flush=True)
 result['totals']={v:{k:sum(d[v][k] for d in result['programs'].values()) for k in ('own_defined','captured','verified','whole_function_native','deployed')} for v in ('before','after')}
 for v in ('before','after'):result['totals'][v]['whole_function_share_of375']=result['totals'][v]['whole_function_native']/375
 (out/'summary.json').write_text(json.dumps(result,indent=2));(out/'complete.json').write_text(json.dumps({'complete':True,'summary_sha256':sha(out/'summary.json')},indent=2))
 print(result['totals'],flush=True)
if __name__=='__main__':main()
