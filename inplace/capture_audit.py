"""Independent untimed native-completion audit with canonical function identities."""
import argparse
import contextvars
import functools
import inspect
import hashlib
import json
from pathlib import Path
import sys

from heldout_identity import (function_identity, key, native_reconciles, product_functions,
                              jsonable, counter_state, rule_deltas)


class Auditor:
    def __init__(self, rule_counters=()):
        self.patches, self.rows = [], {}
        self.contexts = contextvars.ContextVar('heldout_audit_contexts', default=())
        self.attempts = contextvars.ContextVar('heldout_native_attempts', default=())
        self.rule_counters = tuple(rule_counters)
        self.native_bindings = {}
        self.previous_profile = None
        self.observer = None
        self.observer_lost = False

    def row(self, value, kind):
        identifier = id(value)
        if identifier not in self.rows:
            fn = value.original
            self.rows[identifier] = dict(function_identity(fn), kind=kind,
                aot_calls=0, jit_calls=0, unknown_native_calls=0, rejected_attempts=0,
                fallback_calls=0, programs={}, rule_counters={}, modes_observed=[], native_entries=0, unobserved_successes=0)
        return self.rows[identifier]

    def binding(self, native):
        identifier = id(native)
        if identifier not in self.native_bindings:
            name = getattr(native, '__name__', None)
            owner = sys.modules.get(getattr(native, '__module__', ''))
            filename = getattr(owner, '__file__', None)
            if not filename and name:
                owners = [m for m in list(sys.modules.values())
                          if type(m).__name__ == 'module' and vars(m).get(name) is native and vars(m).get('__file__')]
                if len(owners) == 1:
                    filename = vars(owners[0])['__file__']
            self.native_bindings[identifier] = dict(
                module_path=str(Path(filename).resolve()) if filename else None,
                module_sha256=hashlib.sha256(Path(filename).read_bytes()).hexdigest() if filename else None,
                export=name)
        return self.native_bindings[identifier]

    def patch(self, cls, name, wrapper):
        original = getattr(cls, name)
        self.patches.append((cls, name, original))
        setattr(cls, name, wrapper(original))

    def start_profile(self):
        self.previous_profile = sys.getprofile()
        previous = self.previous_profile
        def observer(frame, event, arg):
            if event == 'call':
                for context in reversed(self.contexts.get()):
                    if frame.f_code is context['code']:
                        context['python_fallback'] = True
                        break
            if previous is not None:
                previous(frame, event, arg)
        self.observer = observer
        sys.setprofile(observer)

    def begin(self, value):
        context = dict(value=value, code=value.original.__code__, python_fallback=False, native=None)
        context['token'] = self.contexts.set(self.contexts.get() + (context,))
        return context

    def finish(self, value, kind, context):
        assert self.contexts.get()[-1] is context
        self.contexts.reset(context['token'])
        if sys.getprofile() is not self.observer:
            self.observer_lost = True
        row = self.row(value, kind)
        row['fallback_calls'] += int(context['python_fallback'])
        if kind == 'ordinary' and not context['python_fallback'] and context['native'] is not None:
            ok, mode = context['native']
            if ok:
                row[mode + '_calls'] += 1
                if mode not in row['modes_observed']:
                    row['modes_observed'].append(mode)
                event = context['native_event']
                record = row['programs'].setdefault(event['generated_source_sha256'], dict(aot_calls=0, jit_calls=0, unknown_native_calls=0, native_events=[]))
                record[mode + '_calls'] += 1
                record['native_events'] = [event]

    def record_rule(self, row, value, before, successful, program=None):
        deltas = rule_deltas(before, counter_state(value, self.rule_counters), successful)
        for name, delta in deltas.items():
            old = row['rule_counters'].setdefault(name, dict(implemented=delta['implemented'], successful_calls=0))
            assert old['implemented'] == delta['implemented']
            if delta['implemented']:
                old['successful_calls'] += delta['successful_calls']
            else:
                old['backend_reach'] = 'unimplemented'
        if program is not None and self.rule_counters:
            assert all(item['implemented'] for item in deltas.values()), 'Region does not implement requested rule counter'
            assert hasattr(program, 'direct_report'), 'Requested Region rule lacks computed direct_report/decline'
        return deltas

    def patch_region(self, cls):
        auditor = self
        def wrap_load(original):
            @functools.wraps(original)
            def load(region, program, *args, **kwargs):
                result = original(region, program, *args, **kwargs)
                if not getattr(program, '_heldout_audit_native_wrapped', False):
                    native = program.run
                    event = dict(auditor.binding(native), digest=program.digest,
                        generated_source_sha256=hashlib.sha256(program.source.encode()).hexdigest(),
                        mode='aot' if program.ahead_of_time is True else 'jit' if program.ahead_of_time is False else 'unknown_native')
                    @functools.wraps(native)
                    def run(*args, **kwargs):
                        contexts = auditor.attempts.get()
                        if contexts:
                            contexts[-1].append(event)
                        return native(*args, **kwargs)
                    program.run = run
                    program._heldout_audit_native_wrapped = True
                return result
            return load
        self.patch(cls, 'load', wrap_load)
        def wrap_attempt(original):
            missing = object()
            @functools.wraps(original)
            def attempt(region, *args, **kwargs):
                before = counter_state(region, auditor.rule_counters)
                row = auditor.row(region, 'region')
                events = []
                token = auditor.attempts.set(auditor.attempts.get() + (events,))
                result, original_error = missing, None
                try:
                    result = original(region, *args, **kwargs)
                    return result
                except BaseException as exc:
                    original_error = exc
                    raise
                finally:
                    try:
                        auditor.attempts.reset(token)
                        row['native_entries'] += len(events)
                        successful = result is not missing and bool(result[0])
                        if not successful:
                            row['rejected_attempts'] += 1
                        program = getattr(region, 'latest', None)
                        digest = str(getattr(program, 'digest', 'unknown'))
                        event = row['programs'].setdefault(digest, dict(aot_calls=0, jit_calls=0,
                            unknown_native_calls=0, direct_report=jsonable(getattr(program, 'direct_report', None))))
                        raised = None
                        if original_error is not None:
                            # Retain only serializable facts, never exception args,
                            # traceback frames, or the application exception object.
                            raised = dict(exception_type=type(original_error).__module__ + '.' + type(original_error).__qualname__,
                                native_events=list(events), rule_counters_before=before)
                            event.setdefault('raising_attempts', []).append(raised)
                            raised['rule_counters_after'] = counter_state(region, auditor.rule_counters)
                        elif not successful:
                            event['last_rejected_native_events'] = list(events)
                        deltas = auditor.record_rule(row, region, before, successful, program)
                        if raised is not None:
                            raised['rule_deltas'] = deltas
                        if successful:
                            # Raw direct adapters may bypass program.run. Until a
                            # trusted C ABI observer exists, success is unproven.
                            matching = [e for e in events if e['digest'] == digest]
                            mode = matching[-1]['mode'] if matching else 'unknown_native'
                            if not matching:
                                row['unobserved_successes'] += 1
                            row[mode + '_calls'] += 1
                            if mode not in row['modes_observed']:
                                row['modes_observed'].append(mode)
                            event[mode + '_calls'] += 1
                            event['last_rule_deltas'] = deltas
                            event['native_events'] = events
                    except BaseException as audit_error:
                        if original_error is None:
                            raise
                        # The original exception remains in flight. Make secondary
                        # audit failure explicit and fail reconciliation closed.
                        row.setdefault('attempt_accounting_errors', []).append(dict(
                            exception_type=type(audit_error).__module__ + '.' + type(audit_error).__qualname__))
            return attempt
        self.patch(cls, 'attempt', wrap_attempt)
        for name in ('__call__', 'values', '_resumed'):
            if not hasattr(cls, name):
                continue
            original = getattr(cls, name)
            if inspect.iscoroutinefunction(original):
                def async_wrapper(original):
                    @functools.wraps(original)
                    async def call(region, *args, **kwargs):
                        context = auditor.begin(region)
                        try:
                            return await original(region, *args, **kwargs)
                        finally:
                            auditor.finish(region, 'region', context)
                    return call
                self.patch(cls, name, async_wrapper)
            else:
                def sync_wrapper(original):
                    @functools.wraps(original)
                    def call(region, *args, **kwargs):
                        context = auditor.begin(region)
                        try:
                            return original(region, *args, **kwargs)
                        finally:
                            auditor.finish(region, 'region', context)
                    return call
                self.patch(cls, name, sync_wrapper)

    def patch_lifted(self, cls, aot_cls):
        auditor = self
        for target, mode in ((cls, 'jit'), (aot_cls, 'aot')):
            def run_wrapper(original, mode=mode):
                @functools.wraps(original)
                def run(lifted, *args, **kwargs):
                    native = lifted._by_shape[lifted._last] if mode == 'aot' else lifted._compiled
                    event = dict(auditor.binding(native), mode=mode,
                        generated_source_sha256=hashlib.sha256(lifted.source.encode()).hexdigest())
                    auditor.row(lifted, 'ordinary')['native_entries'] += 1
                    result = original(lifted, *args, **kwargs)
                    for context in reversed(auditor.contexts.get()):
                        if context['value'] is lifted:
                            context['native'] = (bool(result[0]), mode)
                            context['native_event'] = event
                            break
                    return result
                return run
            self.patch(target, '_run', run_wrapper)
        def wrapper(original):
            @functools.wraps(original)
            def call(lifted, *args, **kwargs):
                context = auditor.begin(lifted)
                before = counter_state(lifted, auditor.rule_counters)
                try:
                    return original(lifted, *args, **kwargs)
                finally:
                    successful = (not context['python_fallback'] and context['native'] is not None and context['native'][0])
                    auditor.record_rule(auditor.row(lifted, 'ordinary'), lifted, before, successful)
                    auditor.finish(lifted, 'ordinary', context)
            return call
        self.patch(cls, '__call__', wrapper)

    def restore(self):
        if self.observer is not None:
            sys.setprofile(self.previous_profile)
        for cls, name, original in reversed(self.patches):
            setattr(cls, name, original)
        self.patches.clear()

    def result(self):
        fields = ('aot_calls', 'jit_calls', 'unknown_native_calls', 'rejected_attempts', 'fallback_calls')
        rows = list(self.rows.values())
        complete = not self.observer_lost and not any(row.get('attempt_accounting_errors') for row in rows)
        return dict(audit_accounting_complete=complete, observer_lost=self.observer_lost,
                    totals={name: sum(row[name] for row in rows) for name in fields},
                    functions=rows, independent_functions=rows,
                    native_counter_source='Observed program.run entry plus successful Region.attempt result; ordinary _run result without Python fallback; no product compiled/aot/jit counter reads',
                    fallback_counter_source='Original Python code-entry observation within each wrapper call',
                    independent_direct_abi_observer='unimplemented; missing program.run entry fails closed')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--plan', required=True, type=Path)
    parser.add_argument('--rule-counter', action='append', default=[])
    parser.add_argument('script', type=Path)
    parser.add_argument('script_args', nargs=argparse.REMAINDER)
    args = parser.parse_args()
    assert not args.output.exists(), 'Preserve prior audit evidence'
    initial = set(sys.modules)
    from recompyler.heap import Region
    from recompyler.lift import Lifted
    from recompyler.aot import AotLifted
    from recompyler.runner import run_script
    bootstrap = set(sys.modules)
    auditor, report = Auditor(args.rule_counter), None
    auditor.patch_region(Region)
    auditor.patch_lifted(Lifted, AotLifted)
    auditor.start_profile()
    try:
        report = run_script(args.script.resolve(), args.script_args, args.plan.resolve(), False)
    finally:
        result = auditor.result()
        auditor.restore()
        loaded = {}
        for name, value in list(sys.modules.items()):
            filename = getattr(value, '__file__', None)
            if (name == 'recompyler' or name.startswith('recompyler.')) and filename:
                path = Path(filename).resolve()
                if path.is_file():
                    loaded[name] = dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest())
        result.update(runner_report=report, timing_eligible=False, requested_rule_counters=args.rule_counter,
            loaded_product_modules=loaded,
            numba_imported_before='numba' in initial, numba_imported_by_audit_bootstrap='numba' in bootstrap,
            numba_imported_after='numba' in sys.modules,
            limitations=['Audit observers add overhead; never use this process as a latency sample.',
                         'Preparation/retry native entries do not count as successful complete calls.',
                         'Direct runner preparation-failure Python calls have no lifted wrapper and remain runner-only fallbacks.'])
        if report is not None:
            fields = product_functions(report, json.loads(args.plan.read_text(encoding='utf-8-sig')))
            result['product_functions'] = fields
            result['runner_total_compiled_calls'] = sum(f['compiled_calls'] for f in fields)
            result['runner_total_fallback_calls'] = sum(f['fallback_calls'] for f in fields)
            result['product_exact_aot_calls'] = sum(f['aot_calls'] for f in fields)
            result['product_exact_jit_calls'] = sum(f['jit_calls'] for f in fields)
            totals = result['totals']
            result['compiled_total_reconciles'] = result['audit_accounting_complete'] and sum(totals[k] for k in ('aot_calls', 'jit_calls', 'unknown_native_calls')) == result['runner_total_compiled_calls']
            result['runner_only_fallback_calls'] = result['runner_total_fallback_calls'] - totals['fallback_calls']
            result['per_function_native_matches_product'] = result['audit_accounting_complete'] and native_reconciles(fields, result['independent_functions'])
            result['product_exact_counter_matches_audit'] = result['per_function_native_matches_product']
            result['batch_execution_needs_separate_audit'] = bool(report.get('batches'))
        args.output.parent.mkdir(parents=True, exist_ok=True)
        with args.output.open('x', encoding='utf-8') as stream:
            json.dump(result, stream, indent=2, allow_nan=False)
            stream.write('\n')
    if report and report['exit_code'] not in (None, 0):
        return report['exit_code'] if isinstance(report['exit_code'], int) else 1
    return 0


if __name__ == '__main__':
    sys.exit(main())

