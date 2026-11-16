"""Prepared S34 GC invalidation probe. Run only through matrix/run_locked.py.

Each threshold/binding/variant owns a fresh child so sticky watcher invalidation
from the Python reference cannot affect the C call. No product changes.
"""
from pathlib import Path
import argparse
import json
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def child(variant, binding, threshold):
    import builtins
    import gc
    import random
    sys.path.insert(0, str(HERE))
    import run_c as fixtures
    sys.path.insert(0, str(ROOT / 'matrix/temp/s34'))
    import wave17_s34 as ext

    gc.disable()
    ext.configure(tuple(c[1] for c in fixtures.cases),
                  fixtures.chaos['GVector'], random.Random,
                  fixtures.mdp['halfstate_t'], fixtures.mdp['fixeddata_t'])
    original = fixtures.jsonloads['mutate_dict']
    fn = original if variant == 'cpython' else ext.dict_loop
    namespace = original.__globals__
    # All state, functions and callback objects exist before arming GC.
    source = {'a': 1, 'b': 2}
    rng = random.Random(5)
    rng.__dict__['inert_probe_key'] = 0
    events = []
    phase = ['setup']
    armed = [False]
    substitute = builtins.float if binding == 'str' else (lambda *args: False)
    previous_present = binding in namespace
    previous = namespace.get(binding)
    old_thresholds = gc.get_threshold()

    def callback(event, info):
        if event == 'start' and armed[0]:
            armed[0] = False
            namespace[binding] = substitute
            events.append({'phase': phase[0], 'generation': info['generation'],
                           'binding': binding, 'action': 'rebound'})

    # Warm the selected entry before installing the hook; C must demonstrate
    # a real fast route in this same fresh configured process.
    warm_before = ext.stats()
    fn(source, rng)
    warm_after = ext.stats()
    warm_delta = {k: [b-a for a, b in zip(warm_before[k], warm_after[k])]
                  for k in warm_before}
    rng.seed(5)
    gc.callbacks.append(callback)
    gc.collect()
    before = ext.stats()
    baseline_state = rng.getstate()
    count_before = gc.get_count()
    # These operations do not allocate tracked probe scaffolding. Any callback
    # before entering the call is labelled explicitly, never assumed to be C.
    phase[0] = 'arming'
    gc.set_threshold(threshold, 1000000, 1000000)
    armed[0] = True
    gc.enable()
    phase[0] = 'call'
    value = None
    error = None
    try:
        value = fn(source, rng)
    except BaseException as exc:
        gc.disable()
        error = [type(exc).__module__, type(exc).__qualname__, str(exc)]
    else:
        gc.disable()
    finally:
        gc.disable()
        armed[0] = False
        phase[0] = 'after'
    after = ext.stats()
    final_state = rng.getstate()
    gc.callbacks.remove(callback)
    gc.set_threshold(*old_thresholds)
    result = {
        'variant': variant, 'binding': binding, 'threshold': threshold,
        'events': events, 'callback_in_call': any(e['phase'] == 'call' for e in events),
        'count_before_arming': count_before,
        'result': fixtures.snapshot(value), 'error': error,
        'source': fixtures.snapshot(source),
        'random_state_before': fixtures.snapshot(baseline_state),
        'random_state_after': fixtures.snapshot(final_state),
        'warm_route_delta': warm_delta,
        'route_delta': {k: [b-a for a, b in zip(before[k], after[k])] for k in before},
        'binding_changed': namespace.get(binding) is substitute,
    }
    # Cleanup is after every observation and with GC disabled. No second call
    # can reuse this child or its sticky-dirty watcher state.
    if previous_present:
        namespace[binding] = previous
    else:
        namespace.pop(binding, None)
    print(json.dumps(result), flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--child', action='store_true')
    parser.add_argument('--variant', choices=['cpython', 'handwritten_c'])
    parser.add_argument('--binding', choices=['str', 'isinstance'])
    parser.add_argument('--threshold', type=int)
    parser.add_argument('--thresholds', type=int, nargs='+', default=[1,2,3,4,8,16,32,64])
    parser.add_argument('--output')
    args = parser.parse_args()
    if args.child:
        if args.variant is None or args.binding is None or args.threshold is None:
            parser.error('child requires variant, binding, threshold')
        child(args.variant, args.binding, args.threshold)
        return 0
    if not args.output:
        parser.error('--output is required for retained evidence')
    target = ROOT / args.output
    if not target.resolve().is_relative_to(ROOT.resolve()):
        parser.error('output must remain inside wave17-matrix')
    if target.exists():
        raise RuntimeError('refuse overwrite ' + str(target))
    report = {'script': str(Path(__file__).relative_to(ROOT)), 'pairs': [], 'guard_witnesses': 0,
              'child_failures': 0, 'note': 'GC schedule differences are disclosed separately from both-hook fast-route mismatches.'}
    for binding in ('str', 'isinstance'):
        for threshold in args.thresholds:
            pair = {'binding': binding, 'threshold': threshold}
            for variant in ('cpython', 'handwritten_c'):
                command = [sys.executable, '-B', str(Path(__file__).resolve()), '--child',
                           '--variant', variant, '--binding', binding, '--threshold', str(threshold)]
                try:
                    completed = subprocess.run(command, capture_output=True, text=True, timeout=120)
                except subprocess.TimeoutExpired as exc:
                    def decoded(value):
                        return value.decode(errors='replace') if isinstance(value, bytes) else value
                    record = {'exit_code': 'timeout', 'stderr': decoded(exc.stderr),
                              'stdout': decoded(exc.stdout)}
                else:
                    record = {'exit_code': completed.returncode, 'stderr': completed.stderr}
                    try:
                        record['observation'] = json.loads(completed.stdout)
                    except (ValueError, TypeError):
                        record['stdout'] = completed.stdout
                pair[variant] = record
            py = pair['cpython'].get('observation')
            c = pair['handwritten_c'].get('observation')
            if py is None or c is None or any(pair[v]['exit_code'] for v in ('cpython', 'handwritten_c')):
                pair['classification'] = 'child_failure'
                report['child_failures'] += 1
            else:
                pair['same_result_error'] = (py['result'], py['error']) == (c['result'], c['error'])
                pair['same_random_state'] = py['random_state_after'] == c['random_state_after']
                pair['same_events'] = py['events'] == c['events']
                pair['c_fast_calls'] = c['route_delta']['dict'][0]
                both_hook = py['callback_in_call'] and c['callback_in_call']
                differs = not (pair['same_result_error'] and pair['same_random_state'])
                if both_hook and pair['c_fast_calls'] and differs:
                    pair['classification'] = 'guard_witness'
                    report['guard_witnesses'] += 1
                elif differs:
                    pair['classification'] = 'allocation_schedule_or_fallback_difference'
                else:
                    pair['classification'] = 'no_observed_guard_difference'
            report['pairs'].append(pair)
            target.write_text(json.dumps(report, indent=2), encoding='utf-8')
            print(json.dumps(pair), flush=True)
    report['complete'] = True
    target.write_text(json.dumps(report, indent=2), encoding='utf-8')
    print(json.dumps({'complete': True, 'pairs': len(report['pairs']),
                      'guard_witnesses': report['guard_witnesses'],
                      'child_failures': report['child_failures']}), flush=True)
    return 1 if report['guard_witnesses'] or report['child_failures'] else 0


if __name__ == '__main__':
    raise SystemExit(main())

