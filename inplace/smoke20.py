from pathlib import Path
import shutil,json,subprocess,sys,os,time,statistics,hashlib,ast,io,argparse
from contextlib import redirect_stderr
D=Path(__file__).resolve().parent;R=D.parent;W=R.parent
sys.path.insert(0,str(D));from capture_behavior import extract,stderr_class
def application_stderr(folder,rep,report,metadata):
 source=SOURCE/'recompyler/runner.py';tree=ast.parse(source.read_text(encoding='utf-8'))
 printer=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='print_run')
 namespace={'sys':sys};exec(compile(ast.Module(body=[printer],type_ignores=[]),str(source),'exec'),namespace)
 buffer=io.BytesIO();stream=io.TextIOWrapper(buffer,encoding=metadata['encoding'],errors=metadata['errors'],newline=None)
 try:
  with redirect_stderr(stream):namespace['print_run'](report)
  stream.flush();banner=buffer.getvalue()
 finally:stream.detach()
 raw=(folder/f'saved-{rep}.stderr').read_bytes();assert banner and raw.endswith(banner),'Unexpected CLI stderr footer'
 app=raw[:-len(banner)];(folder/f'saved-{rep}.application.stderr').write_bytes(app)
 return app

def count_identity(report):
 assert report.get('exit_code') in (None,0) and not report.get('not_found') and not report.get('batches')
 rows={}
 for f in report['functions']:
  assert f['aot_calls']+f['jit_calls']==f['compiled_calls']
  rows[(f.get('file',report['script']),f['function'],f.get('line'),bool(f.get('region')))]=(f['aot_calls'],f['jit_calls'],f['fallback_calls'])
 return rows

parser=argparse.ArgumentParser();parser.add_argument('--variant',default='integration-fixed');parser.add_argument('--output',default='integration-smoke20-v2');parser.add_argument('names',nargs='*');options=parser.parse_args()
SOURCE=D/'bases'/options.variant/'src';names=options.names or ['chaos','richards_super'];out=D/options.output;out.mkdir(exist_ok=False);shim=out/'shim'
if not shim.exists():
 shutil.copytree(W/'wave14-capture/capture/inputs/shim',shim);p=shim/'pyperf.py';data=p.read_bytes();assert b'LOOPS = 2' in data;p.write_bytes(data.replace(b'LOOPS = 2',b'LOOPS = 20'))
manifest=json.loads((W/'wave14-capture/capture/input-manifest.json').read_text());results=[]
for name in names:
 original=next(w for w in manifest['workloads'] if w['name']==name);folder=out/name;folder.mkdir(exist_ok=False);inputdir=folder/'input';shutil.copytree(original['cwd'],inputdir,ignore=shutil.ignore_patterns('__pycache__'));script=inputdir/Path(original['script']).name
 env=os.environ.copy();env['PYTHONPATH']=os.pathsep.join([str(shim),str(SOURCE)]);env['RECOMPYLER_CACHE']=str(folder/'cache');env['RECOMPYLER_CACHE_DIR']=str(folder/'cache');plan=folder/'plan.json'
 def execute(label,cmd):
  start=time.perf_counter()
  with (folder/(label+'.stdout')).open('wb') as stdout,(folder/(label+'.stderr')).open('wb') as stderr:p=subprocess.run([str(x) for x in cmd],env=env,cwd=inputdir,stdout=stdout,stderr=stderr)
  val={'command':[str(x) for x in cmd],'exit_code':p.returncode,'wall_s':time.perf_counter()-start};(folder/(label+'.receipt.json')).write_text(json.dumps(val,indent=2));assert p.returncode==0,(label,name)
  return val
 plain=[sys.executable,script,*original['args']];execute('behavior-plain',plain);execute('profile',[sys.executable,D/'capture_profile_s23.py',script,plan,*original['args']]);meta=extract(plan,folder/'profile')
 assert Path(str(plan)+'.application.stdout').read_bytes()==(folder/'behavior-plain.stdout').read_bytes();assert meta['exit_code']==0;assert Path(str(plan)+'.application.stderr').read_bytes()==(folder/'behavior-plain.stderr').read_bytes()
 probe=subprocess.run([sys.executable,'-B','-c',"import sys,json;print(json.dumps(dict(encoding=sys.stderr.encoding,errors=sys.stderr.errors)))"],env=env,cwd=inputdir,capture_output=True,check=True);assert not probe.stderr;metadata=json.loads(probe.stdout);(folder/'stdio.json').write_text(json.dumps(metadata))
 records=[];timed_counts=[]
 for rep in range(3):
  times={}
  for mode in (['plain','saved'] if rep%2==0 else ['saved','plain']):
   cmd=plain if mode=='plain' else [sys.executable,'-m','recompyler','run','--plan',plan,'--json',folder/f'counts-{rep}.json',script,*original['args']]
   times[mode]=execute(f'{mode}-{rep}',cmd)['wall_s']
  assert (folder/f'plain-{rep}.stdout').read_bytes()==(folder/f'saved-{rep}.stdout').read_bytes()==(folder/'behavior-plain.stdout').read_bytes();records.append(times)
  count=json.loads((folder/f'counts-{rep}.json').read_text());timed_counts.append(count_identity(count))
  expected_stderr=(folder/'behavior-plain.stderr').read_bytes();assert (folder/f'plain-{rep}.stderr').read_bytes()==expected_stderr;assert application_stderr(folder,rep,count,metadata)==expected_stderr

 execute('audit',[sys.executable,D/'capture_audit.py','--output',folder/'audit.json','--plan',plan,script,*original['args']]);audit=json.loads((folder/'audit.json').read_text());assert audit['compiled_total_reconciles'] and audit['product_exact_counter_matches_audit'] and not audit['totals']['unknown_native_calls'];assert (folder/'audit.stdout').read_bytes()==(folder/'behavior-plain.stdout').read_bytes()
 assert (folder/'audit.stderr').read_bytes()==(folder/'behavior-plain.stderr').read_bytes()
 assert all(c==count_identity(audit['runner_report']) for c in timed_counts),'Timed and independently audited execution modes differ'
 report=json.loads(plan.read_text());inventory=json.loads((folder/'plan.inventory.json').read_text())['capture_inventory'];verified=[f for f in report['functions'] if f.get('candidate',{}).get('status')=='verified'];assert audit['totals']['aot_calls']>0 and audit['totals']['jit_calls']==0
 row={'name':name,'behavior_preserved':True,'captured':sum(f['captured'] for f in inventory),'verified':len(verified),'deployed':sum(f['aot_calls']>0 for f in audit['functions']),'aot_calls':audit['totals']['aot_calls'],'pairs':records,'ratio':statistics.median(r['plain'] for r in records)/statistics.median(r['saved'] for r in records)};results.append(row);(folder/'complete.json').write_text(json.dumps(row,indent=2));print(json.dumps(row),flush=True)
(out/'summary.json').write_text(json.dumps(results,indent=2))
