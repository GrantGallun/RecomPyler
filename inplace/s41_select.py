"""Unchanged20-loop profile/select, exact behavior and actual saved-run counts."""
from pathlib import Path
import argparse, ast, hashlib, io, json, os, shutil, subprocess, sys
from contextlib import redirect_stderr
D=Path(__file__).resolve().parent; R=D.parent; W=R.parent
sys.path.insert(0,str(D))
from capture_behavior import extract
from freeze_build_step0 import inventory
def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()
p=argparse.ArgumentParser();p.add_argument('--variant',required=True);p.add_argument('--output',required=True);p.add_argument('--names',nargs='*');o=p.parse_args()
source=D/'bases'/o.variant/'src';assert source.is_dir()
frozen_source=inventory(source);assert frozen_source==json.loads((source.parent/'source-manifest.json').read_text())
out=D/o.output;out.mkdir(exist_ok=False)
manifest_path=W/'wave14-capture/capture/input-manifest.json';manifest_sha=sha(manifest_path)
manifest=json.loads(manifest_path.read_text())
helpers={str(path):sha(path) for path in [Path(__file__),*(D/name for name in ('capture_profile_s23.py','capture_behavior.py','capture_audit.py','heldout_identity.py','freeze_build_step0.py'))]}
def unchanged_helpers():return sha(manifest_path)==manifest_sha and all(sha(path)==digest for path,digest in helpers.items())
eligible=[]
for work in manifest['workloads']:
 old=W/'wave14-capture/capture/item1-s23-final2'/work['name']
 receipt=json.loads((old/'stage-complete.json').read_text());assert receipt.get('complete') or receipt.get('accepted')
 assert receipt['inputs_manifest_sha256']==manifest_sha
 assert sha(old/'plan.json')==receipt['plan_sha256']
 plan=json.loads((old/'plan.json').read_text())
 if any(f.get('candidate',{}).get('status')=='verified' and f['candidate'].get('engine')=='region' for f in plan['functions']):eligible.append(work['name'])
assert len(eligible)==33,eligible
names=o.names or eligible;assert set(names)<=set(eligible)
shim=out/'shim';shutil.copytree(W/'wave14-capture/capture/inputs/shim',shim)
assert inventory(shim)==manifest['shim']
pyperf=shim/'pyperf.py';body=pyperf.read_bytes();assert body.count(b'LOOPS = 2')==1;pyperf.write_bytes(body.replace(b'LOOPS = 2',b'LOOPS = 20'))
frozen_shim=inventory(shim)
rows=[]
for work in manifest['workloads']:
 name=work['name']
 if name not in names:continue
 folder=out/name;folder.mkdir();inputs=folder/'input';shutil.copytree(work['cwd'],inputs,ignore=shutil.ignore_patterns('__pycache__'))
 assert inventory(inputs)=={k:v for k,v in work['inputs'].items() if '__pycache__' not in k and not k.endswith(('.pyc','.pyo','.nbi','.nbc'))}
 frozen_inputs=inventory(inputs);assert inventory(shim)==frozen_shim and unchanged_helpers()
 script=inputs/Path(work['script']).name;plan=folder/'plan.json'
 env=os.environ.copy();env.update(PYTHONPATH=os.pathsep.join([str(shim),str(source)]),RECOMPYLER_CACHE=str(folder/'cache'),RECOMPYLER_CACHE_DIR=str(folder/'cache'))
 def run(label,args):
  with (folder/(label+'.stdout')).open('wb') as stdout,(folder/(label+'.stderr')).open('wb') as stderr: child=subprocess.run([sys.executable,*map(str,args)],cwd=inputs,env=env,stdout=stdout,stderr=stderr)
  (folder/(label+'.receipt.json')).write_text(json.dumps(dict(exit_code=child.returncode,command=list(map(str,args)))))
  assert child.returncode==0,(name,label)
 run('plain',[script,*work['args']]);run('profile',[D/'capture_profile_s23.py',script,plan,*work['args']]);meta=extract(plan,folder/'profile');assert meta['exit_code']==0
 assert Path(str(plan)+'.application.stdout').read_bytes()==(folder/'plain.stdout').read_bytes()
 assert Path(str(plan)+'.application.stderr').read_bytes()==(folder/'plain.stderr').read_bytes()
 report=json.loads(plan.read_text());counts=folder/'counts.json'
 frozen_plan=sha(plan)
 artifact_folders={str(Path(s['folder'])):inventory(Path(s['folder'])) for s in [report.get('plan',{}).get('aot'),report.get('plan',{}).get('aot_regions')] if s and s.get('folder')}
 run('saved',['-m','recompyler','run','--plan',plan,'--json',counts,script,*work['args']])
 assert (folder/'saved.stdout').read_bytes()==(folder/'plain.stdout').read_bytes()
 count=json.loads(counts.read_text());assert not count.get('not_found') and not count.get('batches')
 tree=ast.parse((source/'recompyler/runner.py').read_text(encoding='utf-8'))
 printer=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='print_run')
 namespace={'sys':sys};exec(compile(ast.Module(body=[printer],type_ignores=[]),'<print_run>','exec'),namespace)
 probe=subprocess.run([sys.executable,'-c','import json,sys;print(json.dumps(dict(encoding=sys.stderr.encoding,errors=sys.stderr.errors)))'],env=env,cwd=inputs,capture_output=True,check=True)
 stdio=json.loads(probe.stdout);buffer=io.BytesIO();stream=io.TextIOWrapper(buffer,encoding=stdio['encoding'],errors=stdio['errors'],newline=None)
 with redirect_stderr(stream):namespace['print_run'](count)
 stream.flush();banner=buffer.getvalue();stream.detach()
 raw=(folder/'saved.stderr').read_bytes();assert banner and raw.endswith(banner)
 assert raw[:-len(banner)]==(folder/'plain.stderr').read_bytes(),(name,'saved application stderr')
 run('audit',[D/'capture_audit.py','--output',folder/'audit.json','--plan',plan,script,*work['args']])
 audit=json.loads((folder/'audit.json').read_text());assert audit['compiled_total_reconciles'] and audit['product_exact_counter_matches_audit'] and not audit['totals']['unknown_native_calls']
 assert (folder/'audit.stdout').read_bytes()==(folder/'plain.stdout').read_bytes()
 assert (folder/'audit.stderr').read_bytes()==(folder/'plain.stderr').read_bytes()
 def native_counts(report):return {(f.get('file',report['script']),f['function'],f.get('line'),bool(f.get('region'))):(f['aot_calls'],f['jit_calls'],f['fallback_calls']) for f in report['functions']}
 assert native_counts(count)==native_counts(audit['runner_report'])
 assert all(f.get('aot_calls',0)+f.get('jit_calls',0)==f.get('compiled_calls',0) for f in count['functions'])
 assert not any(f.get('jit_calls',0) for f in count['functions'])
 capture_inventory=json.loads((folder/'plan.inventory.json').read_text())['capture_inventory']
 assert inventory(source)==frozen_source and inventory(inputs)==frozen_inputs and inventory(shim)==frozen_shim and unchanged_helpers()
 assert sha(plan)==frozen_plan and all(inventory(Path(path))==digest for path,digest in artifact_folders.items())
 verified=[f for f in report['functions'] if f.get('candidate',{}).get('status')=='verified' and f['candidate'].get('engine')=='region']
 row=dict(name=name,complete=True,captured=sum(bool(f['captured']) for f in capture_inventory),verified=len(verified),deployed=sum(f.get('aot_calls',0)>0 and f.get('region',False) for f in count['functions']),aot_calls=sum(f.get('aot_calls',0) for f in count['functions']),worth_running=report.get('plan',{}).get('worth_running',False),region_times=[dict(function=f.get('qualname',f['function']),line=f['line'],python_us=f['candidate'].get('python_us_per_call'),compiled_us=f['candidate'].get('compiled_cpu_us_per_call'),recommended=f['candidate'].get('recommended',False)) for f in verified])
 rows.append(row);(folder/'complete.json').write_text(json.dumps(row,indent=2));print(json.dumps(row),flush=True)
result=dict(complete=True,eligible=eligible,requested=names,rows=rows,programs_deploying=sum(r['deployed']>0 for r in rows),baseline_programs_deploying=2,cohort_complete=set(names)==set(eligible),timing_scope='gate warm complete Region wrapper replay; excludes fresh_copy and cold preparation; includes any gate fallback',source_manifest=frozen_source,shim_manifest=frozen_shim,input_manifest_sha256=manifest_sha,helper_sha256=helpers,selection='unchanged normal gate;20-loop shim; no force or selection threshold change')
assert unchanged_helpers() and inventory(shim)==frozen_shim and inventory(source)==frozen_source
(out/'complete.json').write_text(json.dumps(result,indent=2))



