"""Run the short S85 library suite in fresh interpreters; never install packages."""
import argparse
from contextlib import contextmanager, nullcontext
import ctypes
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]


def run_one(name, executable=None, timing=False, warmup=3, mode='stock', module_names=None, budget=120, journal=None):
    command = [str(executable or sys.executable), str(Path(__file__).with_name('worker.py')), name,
               '--mode', mode, '--budget', str(budget)]
    if timing: command += ['--timing', '--warmup', str(warmup)]
    if module_names: command += ['--modules'] + list(module_names)
    if journal: command += ['--journal', str(journal)]
    env = dict(os.environ, PYTHONHASHSEED='0', PYTHONPATH=str(ROOT/'src') + os.pathsep + str(ROOT))
    for variable, folder in [('RECOMPYLER_CACHE','rc'),('NUMBA_CACHE_DIR','numba')]:
        directory = ROOT/'.cache'/folder
        directory.mkdir(parents=True, exist_ok=True)
        env[variable] = str(directory)
    if mode == 'installed': env['PYTHON_JIT'] = '1'
    try:
        result = subprocess.run(command, cwd=ROOT, env=env, text=True, capture_output=True,
                                timeout=max(180, budget+90), creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
    except FileNotFoundError: return {'name':name, 'status':'unavailable', 'reason':'interpreter is not installed'}
    except subprocess.TimeoutExpired: return {'name':name, 'status':'timeout'}
    if result.returncode:
        return {'name':name, 'status':'crash' if result.returncode < 0 else 'error',
                'returncode':result.returncode, 'stderr':result.stderr[-6000:]}
    try: return json.loads(result.stdout.strip().splitlines()[-1])
    except (ValueError, IndexError): return {'name':name, 'status':'invalid-output', 'stdout':result.stdout[-1000:]}


def exit_status(rows):
    for row in rows:
        if row['cpython']['status'] != 'ok': return 1
        pypy = row.get('pypy', {})
        if pypy.get('comparison') == 'different-output': return 1
        if pypy.get('status', 'unavailable') not in ('ok','unavailable'): return 1
    return 0


@contextmanager
def timing_lock(lock, ledger, *, purpose='S85 library baseline', expected=90, run_name='wave21-libs'):
    """Acquire atomically and release even if receipt initialization fails."""
    if type(run_name) is not str or not run_name or '\n' in run_name or '\r' in run_name:
        raise ValueError('single-line run name required')
    try: lock.mkdir()
    except FileExistsError: raise SystemExit('timing deferred: root TIMING.lock is held')
    def record(action):
        with ledger.open('a', encoding='utf-8') as f:
            f.write('\nTIMING '+action+': '+purpose+' '+datetime.now(timezone.utc).isoformat()+'\n')
    try:
        (lock/'owner.txt').write_text(run_name+'\nclass: development\npurpose: '+purpose+'\nstart: '+datetime.now(timezone.utc).isoformat()+'\nexpected: '+str(expected)+' seconds\n')
        record('acquire')
        yield
    finally:
        (lock/'owner.txt').unlink(missing_ok=True)
        lock.rmdir()
        record('release')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--timing', action='store_true')
    parser.add_argument('--pypy', type=Path)
    parser.add_argument('--only', nargs='*')
    parser.add_argument('--output', type=Path, default=ROOT/'.cache/wave21-evidence/stock.json')
    args = parser.parse_args()
    if os.name=='nt': ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    sys.path.insert(0, str(ROOT))
    from bench.libs.workloads import workloads
    rows = []
    context = timing_lock(ROOT.parent/'TIMING.lock', ROOT.parent/'WAVE21-LIBS-PLAN.md') if args.timing else nullcontext()
    with context:
        for name in args.only or list(workloads()):
            row = {'name':name, 'cpython':run_one(name, timing=args.timing)}
            if args.pypy:
                row['pypy'] = run_one(name, executable=args.pypy, timing=args.timing, warmup=1000)
                if row['pypy'].get('digest') and row['pypy']['digest'] != row['cpython'].get('digest'):
                    row['pypy']['comparison'] = 'different-output'
            rows.append(row)
            args.output.parent.mkdir(parents=True, exist_ok=True)
            args.output.write_text(json.dumps(rows, indent=2))
            print(name, row['cpython']['status'], 'pypy='+row.get('pypy',{}).get('status','not-requested'), flush=True)
    return exit_status(rows)


if __name__=='__main__': raise SystemExit(main())


