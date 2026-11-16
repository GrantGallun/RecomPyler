"""Short alternating library timings; resident preparation stays outside the lock."""
import argparse
import ctypes
from datetime import datetime,timezone
import json
import os
from pathlib import Path
from queue import Queue,Empty
from statistics import median
import subprocess
import sys
from threading import Thread
from bench.libs.runner import ROOT,timing_lock


class Resident:
    def __init__(self,name,mode,executable=None,*,worker_module="bench.libs.timing_worker"):
        self.mode=mode
        self.log=(ROOT/'bench/libs/results'/('resident-'+name+'-'+mode+'.log')).open('w')
        env=dict(os.environ,PYTHONHASHSEED='0',PYTHONPATH=str(ROOT/'src')+os.pathsep+str(ROOT),
                 PYTHON_JIT='1' if mode in ('native','jit') else '0',RECOMPYLER_CACHE=str(ROOT/'.cache/rc'),
                 NUMBA_CACHE_DIR=str(ROOT/'.cache/numba'),NUMBA_NUM_THREADS='2')
        self.process=subprocess.Popen([str(executable or sys.executable),'-m',worker_module,name,'--mode',mode],
            cwd=ROOT,env=env,stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=self.log,text=True,bufsize=1,
            creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
        self.queue=Queue()
        def read():
            try:
                for line in self.process.stdout:self.queue.put(line)
            finally:self.queue.put(None)
        self.reader=Thread(target=read,daemon=True);self.reader.start()
        try:self.ready=self.response()
        except BaseException:
            self.close();raise

    def response(self):
        try:line=self.queue.get(timeout=180)
        except Empty:raise TimeoutError(self.mode+' resident worker timed out') from None
        if line is None:raise RuntimeError(self.mode+' resident exited; see its log')
        return json.loads(line)

    def request(self,command):
        self.process.stdin.write(command+'\n');self.process.stdin.flush()
        return self.response()

    def close(self):
        try:
            if self.process.poll() is None:
                try:self.process.stdin.write('quit\n');self.process.stdin.flush()
                except (BrokenPipeError,OSError):pass
                try:self.process.wait(timeout=15)
                except subprocess.TimeoutExpired:
                    self.process.terminate();self.process.wait(timeout=15)
        finally:
            for stream in (self.process.stdin,self.process.stdout,self.log):
                try:stream.close()
                except OSError:pass


def sample_group(workers,pairs=3):
    expected=workers['cpython'].ready['digest']
    assert all(worker.ready['digest']==expected for worker in workers.values()),'prepared digest differs from stock'
    samples=[]
    for pair in range(pairs):
        order=list(workers)
        if pair%2:order.reverse()
        row={}
        for name in order:
            result=workers[name].request('measure')
            if result['status']!='ok':raise RuntimeError(name+': '+result['status'])
            assert result['digest']==expected,'measured digest differs from stock'
            row[name]=result
        samples.append(row)
    return samples


def test_processes():
    if os.name!='nt':return []
    script="Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'python|pypy' -and $_.CommandLine -match 'pytest|tools[/\\\\ ]+(fast_suite|full_suite)' } | Select-Object ProcessId,ParentProcessId,Name | ConvertTo-Json -Compress"
    result=subprocess.run(['powershell','-NoProfile','-Command',script],capture_output=True,text=True,
                          creationflags=0x4000|0x08000000,timeout=15)
    if result.returncode:raise RuntimeError('cannot record concurrent correctness load')
    values=json.loads(result.stdout) if result.stdout.strip() else []
    return values if isinstance(values,list) else [values]


def run_case(name,pypy=None):
    workers={};unavailable={}
    try:
        # Sequential initialization keeps at most one active preparation worker.
        for label,mode,executable in [('cpython','stock',None),('cpython_jit','jit',None),('native','native',None),('pypy','pypy',pypy)]:
            if label=='pypy' and pypy is None:continue
            worker=Resident(name,mode,executable)
            if worker.ready['status']=='unavailable':
                unavailable[label]=worker.ready;worker.close()
            else:
                workers[label]=worker
                if label in ('cpython','cpython_jit','native') and worker.ready.get('jit') is not (label!='cpython'):
                    raise RuntimeError(label+': requested JIT setting is not active')
        if 'cpython' not in workers:raise RuntimeError('stock workload unavailable')
        before=test_processes()
        with timing_lock(ROOT.parent/'TIMING.lock',ROOT.parent/'WAVE21-LIBS-PLAN.md',purpose='S85 paired '+name,expected=15):
            first=sample_group(workers)
        after=test_processes()
        repeat=None
        if before or after:
            # Repeat a disturbed development cohort once, without a third retry.
            with timing_lock(ROOT.parent/'TIMING.lock',ROOT.parent/'WAVE21-LIBS-PLAN.md',purpose='S85 paired '+name,expected=15):
                repeat=sample_group(workers)
        accepted=repeat or first
        summary={label:dict(seconds=median(pair[label]['seconds'] for pair in accepted),
                            warmup=worker.ready['warmup']) for label,worker in workers.items()}
        if 'native' in workers:
            summary['native']['relative_to_cpython']=median(pair['native']['seconds']/pair['cpython']['seconds'] for pair in accepted)
        if 'native' in workers and 'cpython_jit' in workers:
            summary['native']['relative_to_cpython_jit']=median(pair['native']['seconds']/pair['cpython_jit']['seconds'] for pair in accepted)
        if 'pypy' in workers:
            summary['pypy']['relative_to_cpython']=median(pair['pypy']['seconds']/pair['cpython']['seconds'] for pair in accepted)
        return dict(name=name,status='measured',class_='development',prepared={k:w.ready for k,w in workers.items()},
                    summary=summary,unavailable=unavailable,first=first,repeat=repeat,
                    concurrent_test_processes_before=before,concurrent_test_processes_after=after,
                    recorded_utc=datetime.now(timezone.utc).isoformat(),default_installation=False)
    finally:
        for worker in workers.values():worker.close()


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--only',nargs='*')
    parser.add_argument('--pypy',type=Path)
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    if os.name=='nt':ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    from bench.libs.workloads import workloads
    rows=[]
    for name in args.only or list(workloads()):
        print('PREPARE '+name,flush=True)
        try:row=run_case(name,args.pypy)
        except Exception as error:
            import traceback
            row=dict(name=name,status='error',reason=type(error).__name__+': '+str(error),traceback=traceback.format_exc())
        rows.append(row);args.output.write_text(json.dumps(rows,indent=2))
        print(json.dumps({k:v for k,v in row.items() if k in ('name','status','summary','reason')}),flush=True)
    return int(any(row['status']!='measured' for row in rows))


if __name__=='__main__':raise SystemExit(main())
