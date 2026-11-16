"""One source-sealed three-pair four-kernel control under an acceptance lock."""
from pathlib import Path
import hashlib,json,os,subprocess,sys,threading,time,uuid
from run_locked import audit,processes,stamp,note
R=Path(__file__).resolve().parents[1];W=R.parent;D=R/'lift-evidence';L=W/'TIMING.lock'
label='range-s49-kernel-control-v1';logs=D/'logs'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()

def verify():
 seal=json.loads((D/'range-s49-source-seal-v1.json').read_text())
 for variant,manifest in seal.items():
  root=R if variant=='tests_and_matrix' else R/'matrix/temp/bases'/variant
  assert all(sha(root/p)==value for p,value in manifest.items()),variant
 assert all(sha(R/p)==v for p,v in seal['lift-range-s49-v1'].items()),'live source changed'
 built=json.loads((D/'kernel-build-s49-v1/complete.json').read_text());assert built['complete']
 assert all(sha(R/p)==v for p,v in built['artifact_sha256'].items()),'kernel artifacts changed'
 return {'source_seal_sha256':sha(D/'range-s49-source-seal-v1.json'),'artifact_receipt_sha256':sha(D/'kernel-build-s49-v1/complete.json')}

def tests_alive():
 rows=processes()
 return [{'pid':p['ProcessId'],'name':p['Name']} for p in rows if p['ProcessId']!=os.getpid() and
         any(word in (p.get('CommandLine') or '').lower() for word in ('pytest','heldout_native.py','current_heldout.py','run_matrix.py')) and
         not any(word in (p.get('CommandLine') or '').lower() for word in ('app-server','jobs-serve','exec-server','-command'))]

def main():
 assert not (logs/(label+'.receipt.json')).exists(),'receipt exists'
 while True:
  if L.exists():print('WAIT foreign timing lock',flush=True);time.sleep(30);continue
  before=audit()
  if before['blockers']:print('WAIT other workloads',flush=True);time.sleep(30);continue
  token='wave18-lift '+uuid.uuid4().hex
  try:L.mkdir()
  except FileExistsError:continue
  try:
   owner=L/'owner.txt';owner.write_text(token+'\npid: '+str(os.getpid())+'\npurpose: '+label+'\nclass: acceptance\nstart: '+stamp()+'\nexpected duration: 10 minutes\n')
   after=audit()
   if after['blockers']:print('REQUEUE post-create workload',flush=True);continue
   seals=verify();start=stamp();note('TIMING ACQUIRE '+start+' '+label+'; class acceptance; owner '+token)
   samples=[];stop=threading.Event()
   def observe():
    while not stop.is_set():
     try:samples.append({'time':stamp(),'test_processes':tests_alive()})
     except Exception as exc:samples.append({'time':stamp(),'observation_error':type(exc).__name__})
     stop.wait(5)
   observer=threading.Thread(target=observe,daemon=True);observer.start()
   command=[sys.executable,'matrix/kernel_pairs.py','lift-range-s49-v1',label,'3','lift-range-base-s49-v1']
   try:
    with (logs/(label+'.stdout')).open('wb') as stdout,(logs/(label+'.stderr')).open('wb') as stderr:
     done=subprocess.run(command,cwd=R,env=os.environ.copy(),stdout=stdout,stderr=stderr)
   finally:stop.set();observer.join(15)
   verify();out=R/'matrix'/label
   result={'complete':done.returncode==0,'label':label,'class':'acceptance','command':command,'start':start,'end':stamp(),'exit_code':done.returncode,'source_unchanged':True,'seals':seals,'audit_before':before,'audit_after_atomic_create':after,'test_process_observations':samples,'tests_seen_during_cohort':any(s.get('test_processes') for s in samples),'stdout_sha256':sha(logs/(label+'.stdout')),'stderr_sha256':sha(logs/(label+'.stderr'))}
   if done.returncode==0:
    result['summary_sha256']=sha(out/'summary.json')
    result['ratios']={name:row['lift-range-s49-v1']['median_ms']/row['lift-range-base-s49-v1']['median_ms'] for name,row in json.loads((out/'summary.json').read_text()).items()}
    (out/'complete.json').write_text(json.dumps(result,indent=2))
   (logs/(label+'.receipt.json')).write_text(json.dumps(result,indent=2));print(json.dumps({k:result[k] for k in ('complete','exit_code','source_unchanged','tests_seen_during_cohort','ratios') if k in result}),flush=True)
   return done.returncode
  finally:
   if not (L/'owner.txt').exists() or token not in (L/'owner.txt').read_text():raise RuntimeError('timing owner changed')
   (L/'owner.txt').unlink();L.rmdir();note('TIMING RELEASE '+stamp()+' '+label+' owner '+token)
if __name__=='__main__':raise SystemExit(main())
