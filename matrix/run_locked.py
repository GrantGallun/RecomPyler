"""Serialize every workload; audit before and after atomic lock acquisition."""
from pathlib import Path
import sys,os,subprocess,json,time,datetime
R=Path(__file__).resolve().parents[1]; W=R.parent; L=W/'TIMING.lock'; ledger=W/'WAVE17-MATRIX-PLAN.md'; D=R/'matrix'
def stamp():return datetime.datetime.now(datetime.timezone.utc).isoformat()
def note(s):
 with ledger.open('a',encoding='utf-8') as f:f.write(s+'\n')
def processes():
 p=subprocess.run(['powershell','-NoProfile','-Command','Get-CimInstance Win32_Process | Select-Object ProcessId,ParentProcessId,Name,CommandLine,KernelModeTime,UserModeTime | ConvertTo-Json -Compress'],capture_output=True,text=True,check=True)
 return json.loads(p.stdout)
def audit():
 a=processes();time.sleep(.6);b=processes();old={p['ProcessId']:p for p in a}; by={p['ProcessId']:p for p in b};excluded={os.getpid()}; cur=os.getpid()
 while cur in by:
  cur=by[cur]['ParentProcessId']
  if cur in excluded:break
  excluded.add(cur)
 def descends(pid,roots):
  seen=set()
  while pid in by and pid not in seen:
   if pid in roots:return True
   seen.add(pid);pid=by[pid]['ParentProcessId']
  return False
 roots={p['ProcessId'] for p in b if any(x in (p.get('CommandLine') or '').lower() for x in [str(W).lower(),'wave15-depth2','wave14-capture','wave16-inplace','wave17-matrix'])}
 codex_roots={p['ProcessId'] for p in b if p['Name'].lower().startswith('codex')}
 blockers=[];active=[]
 for p in b:
  pid=p['ProcessId'];cmd=p.get('CommandLine') or '';name=p['Name'].lower();prev=old.get(pid)
  cpu=(int(p.get('KernelModeTime') or 0)+int(p.get('UserModeTime') or 0)-int(prev.get('KernelModeTime') or 0)-int(prev.get('UserModeTime') or 0))/1e7 if prev else 0
  if cpu>.06:active.append({'pid':pid,'name':name,'cpu_s':cpu,'command':cmd})
  if pid in excluded:continue
  workload=any(x in name for x in ['python','pytest','clang','gcc','cc1','cl.exe','link.exe','ninja','msbuild'])
  workspace=str(W).lower() in cmd.lower() or any(x in cmd.lower() for x in ['wave15-depth2','wave14-capture','wave16-inplace','wave17-matrix'])
  relative_job=(' -m pytest' in cmd.lower() or 'pytest.exe' in name or ' -m recompyler ' in cmd.lower())
  known=workspace or descends(pid,roots) or (descends(pid,codex_roots) and 'jobs-serve' not in cmd.lower()) or relative_job
  coordinator=any(x in cmd.lower() for x in ['run_locked.py','codex exec','app-server','exec-server','jobs-serve'])
  shell_heavy=name in ('powershell.exe','pwsh.exe','cmd.exe') and known and cpu>.3 and not coordinator
  if (workload and known and not (coordinator and cpu < .06)) or shell_heavy:
   blockers.append({'pid':pid,'name':name,'command':cmd,'cpu_s':cpu})
 return {'time':stamp(),'blockers':blockers,'active':active}
def main():
 label=sys.argv[1]; cmd=sys.argv[2:];logs=D/'logs';logs.mkdir(exist_ok=True);events=[]
 if (logs/(label+'.receipt.json')).exists():raise RuntimeError('Refuse result overwrite')
 while True:
  if L.exists():
   print('WAIT lock '+((L/'owner.txt').read_text(errors='replace') if (L/'owner.txt').exists() else 'initializing'),flush=True);time.sleep(30);continue
  before=audit();events.append({'before':before})
  if before['blockers']:print('WAIT competing workload '+json.dumps(before['blockers']),flush=True);time.sleep(30);continue
  try:L.mkdir()
  except FileExistsError:continue
  import uuid
  token='wave17-matrix '+uuid.uuid4().hex
  owned=True
  try:
   (L/'owner.txt').write_text(token+'\npurpose: '+label+'\nstart: '+stamp()+'\nexpected duration: 20 minutes\n')
   after=audit();events[-1]['after_atomic_create']=after
   if after['blockers']:
    print('WAIT post-acquisition workload',flush=True)
   else:
    (logs/(label+'.audit.json')).write_text(json.dumps(events,indent=2))
    note('TIMING ACQUIRE '+stamp()+' '+label+'; no competing workspace workload before/after atomic create; audit: wave17-matrix/matrix/logs/'+label+'.audit.json')
    start=time.perf_counter();env=os.environ.copy();env.pop('PYTHONDONTWRITEBYTECODE',None);tmp=D/'temp';tmp.mkdir(exist_ok=True)
    env.update(PYTHONPATH=str(R/'src'),PYTHONPYCACHEPREFIX=str(tmp/'bytecode'),RECOMPYLER_CACHE=str(tmp/'cache'),RECOMPYLER_CACHE_DIR=str(tmp/'cache'),NUMBA_CACHE_DIR=str(tmp/'numba'),TEMP=str(tmp),TMP=str(tmp),PYTHONHASHSEED='0',OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1',NUMBA_NUM_THREADS='1')
    print('ACQUIRED '+label,flush=True)
    with (logs/(label+'.stdout')).open('wb') as out,(logs/(label+'.stderr')).open('wb') as err:
     p=subprocess.run(cmd,cwd=R,env=env,stdout=out,stderr=err)
    receipt={'label':label,'command':cmd,'exit_code':p.returncode,'wall_s':time.perf_counter()-start,'end':stamp()};(logs/(label+'.receipt.json')).write_text(json.dumps(receipt,indent=2));print(json.dumps(receipt),flush=True)
    return p.returncode
  finally:
   if (L/'owner.txt').exists():
    if token not in (L/'owner.txt').read_text():raise RuntimeError('lock ownership changed')
    (L/'owner.txt').unlink()
   L.rmdir();note('TIMING RELEASE '+stamp()+' '+label)
  time.sleep(30)
if __name__=='__main__':sys.exit(main())
