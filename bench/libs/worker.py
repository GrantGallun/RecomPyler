"""Isolated stock/library worker. Correctness runs record no timings."""
import argparse
import ctypes
import json
import os
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path[:0] = [str(ROOT), str(ROOT/'src')]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('name')
    parser.add_argument('--timing', action='store_true')
    parser.add_argument('--warmup', type=int, default=3)
    parser.add_argument('--mode', choices=['stock','census','installed'], default='stock')
    parser.add_argument('--modules', nargs='*')
    parser.add_argument('--budget', type=float, default=120)
    parser.add_argument('--journal')
    args = parser.parse_args()
    if os.name == 'nt': ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(), 0x4000)
    from bench.libs.workloads import workloads, output_digest
    case = workloads()[args.name]
    try: run = case.prepare()
    except ModuleNotFoundError as exc:
        print(json.dumps({'name':args.name, 'status':'unavailable', 'reason':str(exc)})); return
    hotness = {}
    if args.mode != 'stock':
        from bench.libs.census import profile_workload
        initial, hotness = profile_workload(run,case.package)
        expected = output_digest(initial)
        # Profiling disables CPython's adaptive warm-up. Warm the deterministic
        # fixture normally before requesting canonical executor seeds.
        for _ in range(8):
            if output_digest(run()) != expected: raise AssertionError('unstable stock output')
    else: expected = output_digest(run())
    row = {'name':args.name, 'package':case.package, 'status':'ok', 'digest':expected, 'calls':1, 'installed':0,
           'python':sys.version.split()[0]}
    if args.mode != 'stock':
        from bench.libs.census import compile_library, journal_event
        census, compiled, counters = compile_library(case.package, args.modules, install=args.mode=='installed', budget=args.budget, journal=args.journal, count_entries=args.mode=='installed' and not args.timing, hotness=hotness)
        row['census'] = census
        row['hot_calls'] = hotness
        row['installed'] = census['installed_after']
        if args.mode == 'installed':
            journal_event(args.journal,'workload','begin',name=args.name)
            for counter in counters.values(): counter.calls.value = 0
            try:
                for attempt in range(32):
                    result = run()
                    if output_digest(result) != expected: raise AssertionError('native workload output differs')
                row['calls'] = 32
                counts = {name:c.calls.value for name,c in counters.items() if c.calls.value}
                row['native_entries'] = sum(counts.values())
                row['executed_functions'] = counts
                actual = output_digest(result)
                row['digest'] = actual
                if actual != expected: row['status'] = 'mismatch'
            except Exception as exc:
                row.update(status='mismatch', exception=type(exc).__name__+': '+str(exc))
            from recompyler.ir import compilation_info
            row['installed_after_workload'] = sum(bool((compilation_info(f) or {}).get('installed')) for f in compiled)
            if row['status']=='ok' and not row['installed']: row['status']='not-installed'
            elif row['status']=='ok' and counters and not row.get('native_entries'): row['status']='not-exercised'
            journal_event(args.journal,'workload','end',name=args.name,status=row['status'],native_entries=row.get('native_entries'))
    if args.timing:
        lock = ROOT.parent/'TIMING.lock'/'owner.txt'
        if not lock.exists() or 'wave21-libs' not in lock.read_text():
            raise RuntimeError('wave21 timing requires its root TIMING.lock')
        from time import perf_counter
        for _ in range(args.warmup): run()
        count = 1
        while True:
            start = perf_counter()
            for _ in range(count): result = run()
            elapsed = perf_counter() - start
            if elapsed >= 0.2: break
            count *= 2
        samples = []
        for _ in range(3):
            start = perf_counter()
            for _ in range(count): result = run()
            samples.append((perf_counter() - start)/count)
            if output_digest(result) != expected: raise AssertionError('unstable output')
        row.update(seconds=min(samples), samples=samples, calls=count, warmup=args.warmup,
                   batch_seconds=min(samples)*count)
    print(json.dumps(row))


if __name__ == '__main__': main()





