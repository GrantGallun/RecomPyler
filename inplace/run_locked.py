"""Serialize every workload; audit before and after atomic lock acquisition."""
from pathlib import Path
import sys,os,subprocess,json,time,datetime,uuid
R=Path(__file__).resolve().parents[1]; W=R.parent; L=W/'TIMING.lock'; ledger=W/'WAVE16-INPLACE-PLAN.md'; D=R/'inplace'
def stamp():return datetime.datetime.now(datetime.timezone.utc).isoformat()
def note(s):
 with ledger.open('a',encoding='utf-8') as f:f.write(s+'\n')
def processes():
 p=subprocess.run(['powershell','-NoProfile','-Command','Get-CimInstance Win32_Process | Select-Object ProcessId,ParentProcessId,Name,CommandLine,KernelModeTime,UserModeTime | ConvertTo-Json -Compress'],capture_output=True,text=True,check=True)
 return json.loads(p.stdout)
def below_normal(pid):
 import ctypes
 k=ctypes.WinDLL('kernel32',use_last_error=True)
 k.OpenProcess.argtypes=(ctypes.c_uint32,ctypes.c_int,ctypes.c_uint32);k.OpenProcess.restype=ctypes.c_void_p
 k.GetPriorityClass.argtypes=(ctypes.c_void_p,);k.GetPriorityClass.restype=ctypes.c_uint32
 k.CloseHandle.argtypes=(ctypes.c_void_p,)
 handle=k.OpenProcess(0x1000,False,pid)
 if not handle:return False
 try:return k.GetPriorityClass(handle)==0x4000
 finally:k.CloseHandle(handle)

def peer_correctness_root(process):
 import shlex
 if not process['Name'].lower().startswith('python'):return False
 try:args=shlex.split(process.get('CommandLine') or '',posix=False)
 except ValueError:return False
 if len(args)<2:return False
 script=args[1].strip('"').replace('\\','/').lower()
 known=('matrix/run_correctness.py','matrix/provenance_gates.py','matrix/correctness_gates.py','lift-evidence/run_correctness.py')
 return script in known or any(script.endswith('/wave17-matrix/'+part) for part in known if part.startswith('matrix/')) or script.endswith('/wave18-lift/lift-evidence/run_correctness.py')

def audit(timing_class='acceptance'):
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
 roots={p['ProcessId'] for p in b if any(x in (p.get('CommandLine') or '').lower() for x in [str(W).lower(),'wave15-depth2','wave14-capture','wave16-inplace'])}
 codex_roots={p['ProcessId'] for p in b if p['Name'].lower().startswith('codex')}
 peer_roots={p['ProcessId'] for p in b if timing_class=='development' and peer_correctness_root(p)}
 blockers=[];active=[];allowed_correctness=[]
 for p in b:
  pid=p['ProcessId'];cmd=p.get('CommandLine') or '';name=p['Name'].lower();prev=old.get(pid)
  cpu=(int(p['KernelModeTime'])+int(p['UserModeTime'])-int(prev['KernelModeTime'])-int(prev['UserModeTime']))/1e7 if prev else 0
  if cpu>.06:active.append({'pid':pid,'name':name,'cpu_s':cpu,'command':cmd})
  if pid in excluded:continue
  workload=any(x in name for x in ['python','pytest','clang','gcc','cc1','cl.exe','link.exe','ninja','msbuild'])
  workspace=str(W).lower() in cmd.lower() or any(x in cmd.lower() for x in ['wave15-depth2','wave14-capture','wave16-inplace'])
  relative_job=(' -m pytest' in cmd.lower() or 'pytest.exe' in name or ' -m recompyler ' in cmd.lower())
  known=workspace or descends(pid,roots) or (descends(pid,codex_roots) and 'jobs-serve' not in cmd.lower()) or relative_job
  # Idle lock coordinators are not heavy jobs; their real python/compiler
  # children remain visible above. Counting waiters would deadlock two runs.
  coordinator=(pid in peer_roots or any(part in cmd.lower().replace('\\','/') for part in ('run_locked.py','lift-evidence/run_range_control.py','lift-evidence/run_range_control_v2.py')))
  if workload and known and not coordinator:
   if peer_roots and descends(pid,peer_roots):
    low=below_normal(pid)
    if low or os.environ.get('WAVE16_DESCRIPTIVE_OVERLAP')=='1':
     allowed_correctness.append({'pid':pid,'name':name,'command':cmd,'priority_verified':'BELOW_NORMAL' if low else 'NOT_BELOW_NORMAL','development_descriptive_overlap':not low});continue
   blockers.append({'pid':pid,'name':name,'command':cmd,'cpu_s':cpu})
 return {'time':stamp(),'blockers':blockers,'active':active,'allowed_correctness':allowed_correctness}
def main():
 label=sys.argv[1]; cmd=sys.argv[2:];logs=D/'logs';logs.mkdir(exist_ok=True); events=[]
 token=str(os.getpid())+':'+uuid.uuid4().hex
 timing_class=os.environ.get('WAVE16_TIMING_CLASS','development');assert timing_class in ('development','acceptance')
 if (logs/(label+'.receipt.json')).exists():raise RuntimeError('Refuse result overwrite')
 while True:
  if L.exists():print('WAIT lock '+(L/'owner.txt').read_text(errors='replace') if (L/'owner.txt').exists() else 'WAIT initializing lock',flush=True);time.sleep(30);continue
  before=audit(timing_class);events.append({'before':before})
  if before['blockers']:print('WAIT competing workload '+json.dumps(before['blockers']),flush=True);time.sleep(30);continue
  try:L.mkdir()
  except FileExistsError:continue
  (L/'owner.txt').write_text('wave16-inplace\npurpose: '+label+'\nstart: '+stamp()+'\nexpected duration: '+os.environ.get('WAVE16_EXPECTED_DURATION','20 minutes')+'\nclass: '+timing_class+'\nowner token: '+token+'\n')
  after=audit(timing_class);events[-1]['after_atomic_create']=after
  if after['blockers']:
   (L/'owner.txt').unlink();L.rmdir();print('WAIT post-acquisition workload',flush=True);time.sleep(30);continue
  break
 (logs/(label+'.audit.json')).write_text(json.dumps(events,indent=2))
 note('TIMING ACQUIRE '+stamp()+' '+label+'; no competing timing/unknown workspace workload before/after atomic create; peer correctness activity recorded, not quiet-time evidence; audit: wave16-inplace/inplace/logs/'+label+'.audit.json')
 start=time.perf_counter();env=os.environ.copy();env.pop('PYTHONDONTWRITEBYTECODE',None);tmp=D/'temp';tmp.mkdir(exist_ok=True)
 env.update(PYTHONPATH=str(R/'src'),PYTHONPYCACHEPREFIX=str(tmp/'bytecode'),RECOMPYLER_CACHE=str(D/'cache'),RECOMPYLER_CACHE_DIR=str(D/'cache'),NUMBA_CACHE_DIR=str(D/'numba'),TEMP=str(tmp),TMP=str(tmp),PYTHONHASHSEED='0',OMP_NUM_THREADS='1',OPENBLAS_NUM_THREADS='1',MKL_NUM_THREADS='1',NUMBA_NUM_THREADS='1')
 try:
  print('ACQUIRED '+label,flush=True)
  with (logs/(label+'.stdout')).open('wb') as out,(logs/(label+'.stderr')).open('wb') as err:
   p=subprocess.Popen(cmd,cwd=R,env=env,stdout=out,stderr=err)
   samples=[]
   def sample_tests():
    try:rows=processes()
    except Exception as exc:
     samples.append(dict(time=stamp(),other_correctness_processes=[],sampling_error=type(exc).__name__+': '+str(exc)))
     return
    by={r['ProcessId']:r for r in rows}
    def owned(pid):
     seen=set()
     while pid in by and pid not in seen:
      if pid==os.getpid():return True
      seen.add(pid);pid=by[pid]['ParentProcessId']
     return False
    tests=[dict(pid=r['ProcessId'],command=r.get('CommandLine'),priority_verified='BELOW_NORMAL' if below_normal(r['ProcessId']) else 'NOT_BELOW_NORMAL') for r in rows
           if 'python' in r['Name'].lower() and not owned(r['ProcessId'])
           and any(t in (r.get('CommandLine') or '').lower() for t in ('pytest','run_correctness.py','provenance_gates.py','correctness_gates.py','heldout_compare.py','heldout_native.py'))]
    samples.append(dict(time=stamp(),other_correctness_processes=tests))
   sample_tests()
   while True:
    try:p.wait(timeout=30);break
    except subprocess.TimeoutExpired:sample_tests()
   sample_tests()
  receipt={'label':label,'command':cmd,'exit_code':p.returncode,'wall_s':time.perf_counter()-start,'end':stamp(),'class':timing_class,'owner_token':token,'development_descriptive_overlap_enabled':os.environ.get('WAVE16_DESCRIPTIVE_OVERLAP')=='1','correctness_samples':samples,'correctness_sampling_interval_s':30,'other_correctness_seen':any(s['other_correctness_processes'] for s in samples),'correctness_observation_complete':not any('sampling_error' in s for s in samples)};(logs/(label+'.receipt.json')).write_text(json.dumps(receipt,indent=2));print(json.dumps(receipt),flush=True)
 finally:
  # Never expose a running owned workload to another timing holder.
  if 'p' in locals() and p.poll() is None:p.wait()
  assert 'owner token: '+token+'\n' in (L/'owner.txt').read_text();(L/'owner.txt').unlink();L.rmdir();note('TIMING RELEASE '+stamp()+' '+label)
 return p.returncode
if __name__=='__main__':sys.exit(main())
