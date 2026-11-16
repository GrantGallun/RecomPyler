"""S89 correctness-only diagnosis by actual function identity, never call arguments."""
import argparse
import ctypes
import json
import os
import sys
import types
import weakref
from pathlib import Path


def collect_calls(run, package, *, include_driver=False, clock=None):
    from bench.libs._frame_function_native import function as frame_function
    rows, by_identity = [], {}
    stack = []
    driver_code = run.__code__
    def called(frame, event, argument):
        if clock is not None:
            now = clock()
            if event in ('return', 'c_return', 'c_exception'):
                kind = 'python' if event == 'return' else 'c'
                if stack and stack[-1][0:2] == [id(frame), kind]:
                    _, _, start, children, row = stack.pop()
                    elapsed = now - start
                    if row is not None: row['self_seconds'] += max(0.0, elapsed - children)
                    if stack: stack[-1][3] += elapsed
                return
            if event in ('call', 'c_call'):
                stack.append([id(frame), 'python' if event == 'call' else 'c', now, 0.0, None])
        if event != 'call': return
        code = frame.f_code
        module = frame.f_globals.get('__name__')
        if type(module) is str and (module == package or module.startswith(package + '.')):
            origin = 'package'
        elif package == 'jinja2' and code.co_filename == '<template>':
            origin = 'generated template'
        elif include_driver and code is driver_code:
            origin = 'driver'
        else: return
        target = frame_function(frame)
        if type(target) is not types.FunctionType: return
        key = (id(target), id(code))
        row = by_identity.get(key)
        if row is None or row['function']() is not target or row['code']() is not code:
            row = dict(function=weakref.ref(target), code=weakref.ref(code), calls=0,
                       name=(module if type(module) is str else '<generated>') + '.' + code.co_qualname,
                       filename=code.co_filename, line=code.co_firstlineno, origin=origin,
                       function_id=id(target), code_id=id(code))
            if clock is not None: row['self_seconds'] = 0.0
            rows.append(row); by_identity[key] = row
        row['calls'] += 1
        if clock is not None: stack[-1][4] = row
    previous = sys.getprofile()
    sys.setprofile(called)
    try: value = run()
    finally: sys.setprofile(previous)
    return value, rows


def select_targets(rows, limit=128):
    selected, excluded, codes = [], [], set()
    for row in sorted(rows, key=lambda row: -row['calls']):
        target, code = row['function'](), row['code']()
        reason = None
        if target is None or code is None:
            reason = 'function owner no longer live after workload'
        elif target.__code__ is not code:
            reason = 'function code changed after workload'
        elif id(code) in codes:
            reason = 'shared code: hotter function identity selected'
        elif len(selected) >= limit:
            reason = 'hot-function diagnosis limit'
        if reason: excluded.append(dict(public_row(row), reason=reason))
        else:
            selected.append(row); codes.add(id(code))
    return selected, excluded


def public_row(row):
    return {key: value for key, value in row.items() if key not in ('function', 'code')}


def entry_state(function):
    from recompyler.ir import compilation_info
    from recompyler.ir._entry_native import _compilation_handle
    info = compilation_info(function) or {}
    handle = _compilation_handle(function)
    return dict(prepared=bool(info), installed=bool(info.get('installed')),
                active=bool(handle is not None and handle.active),
                body_address=info.get('body_address'), kind=info.get('compilation_kind'),
                native_prefix=bool(info.get('native_prefix')))


def diagnose(name, *, limit=128, journal=None, after_correctness=None, cases=None):
    from bench.libs.workloads import workloads, output_digest
    from bench.libs.census import journal_event
    from recompyler.ir import compile_function
    from recompyler.ir._entry_native import _compilation_owner, forget_compilation, prepare_frame_entry
    from tools.ir_self_host import CountedBody, install_candidate
    case = (workloads() if cases is None else cases)[name]
    run = case.prepare()
    expected = output_digest(run())
    for _ in range(8): assert output_digest(run()) == expected
    output, observed = collect_calls(run, case.package, include_driver=name == 'numpy_loop' or case.package=='bench')
    assert output_digest(output) == expected
    for _ in range(8): assert output_digest(run()) == expected
    selected, excluded = select_targets(observed, limit)
    records, counters, targets = [], {}, []
    try:
        for candidate in selected:
            target = candidate['function']()
            row = public_row(candidate)
            if target is None:
                row.update(status='unavailable', reason='function owner no longer live before compile')
                records.append(row); continue
            targets.append((target, row))
            journal_event(journal, 'hot-compile', 'begin', **row)
            try:
                compile_function(target, strict=True)
                state = _compilation_owner(target)
                if state is None: raise ValueError('no canonical compilation owner')
                code, owner = state
                counter = CountedBody(owner)
                forget_compilation(target)
                prepare_frame_entry(target, counter.body_address, counter, code)
                row.update(status='compiled', compiled_state=entry_state(target))
                counters[id(target)] = counter
            except Exception as error:
                row.update(status='declined', reason=type(error).__name__ + ': ' + str(error))
            records.append(row)
            journal_event(journal, 'hot-compile', 'end', **row)
        # All preparation precedes seeding; inspect identities individually afterward.
        for target, row in targets:
            if row['status'] != 'compiled': continue
            journal_event(journal, 'hot-install', 'begin', function=row['name'])
            try:
                row['install_accepted'] = bool(install_candidate(target))
                if not row['install_accepted']: row['install_reason'] = 'canonical entry declined'
            except Exception as error:
                row.update(install_accepted=False, install_reason=type(error).__name__ + ': ' + str(error))
            row['after_install'] = entry_state(target)
            journal_event(journal, 'hot-install', 'end', **row)
        journal_event(journal, 'hot-workload', 'begin', name=name)
        for target, row in targets:
            row['before_workload'] = entry_state(target)
            if id(target) in counters: counters[id(target)].calls.value = 0
        mismatches = 0
        for _ in range(32):
            if output_digest(run()) != expected: mismatches += 1
        for target, row in targets:
            row['after_workload'] = entry_state(target)
            row['native_entries'] = counters[id(target)].calls.value if id(target) in counters else 0
            if row['native_entries']: cause = 'native exercised'
            elif row['status'] != 'compiled': cause = 'compile declined'
            elif not row.get('install_accepted'): cause = 'canonical seed declined'
            elif not row['before_workload']['active']: cause = 'entry invalidated before workload'
            elif not row['after_workload']['active']: cause = 'entry invalidated during workload'
            else: cause = 'active entry bypassed or cold path'
            row['cause'] = cause
        entries = sum(row.get('native_entries', 0) for row in records)
        report = dict(name=name, digest=expected, status='mismatch' if mismatches else ('verified' if entries else 'not-exercised'),
                      attempted=sum(row['status'] != 'unavailable' for row in records), compiled=sum(row['status']=='compiled' for row in records),
                      not_attempted=len(excluded) + sum(row['status'] == 'unavailable' for row in records), observed_function_identities=len(observed),
                      native_entries=entries, mismatches=mismatches, rows=records, excluded=excluded)
        journal_event(journal, 'hot-workload', 'end', name=name, status=report['status'], native_entries=entries)
        if after_correctness is not None:
            after_correctness(report, run, targets, counters)
        return report
    finally:
        # Remove only the wrapper this diagnostic owns, including error exits.
        for target, row in targets:
            state = _compilation_owner(target)
            counter = counters.get(id(target))
            if state is not None and counter is not None and (state[1] is counter or state[1] is counter.original):
                forget_compilation(target)



def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('name')
    parser.add_argument('--limit', type=int, default=128)
    parser.add_argument('--output', required=True)
    parser.add_argument('--journal')
    args = parser.parse_args()
    if os.name == 'nt': ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(), 0x4000)
    report = diagnose(args.name, limit=args.limit, journal=args.journal)
    Path(args.output).write_text(json.dumps(report, indent=2), encoding='utf-8')
    print(json.dumps({key:value for key,value in report.items() if key not in ('rows','excluded')}))
    return int(bool(report['mismatches']))


if __name__ == '__main__': raise SystemExit(main())

