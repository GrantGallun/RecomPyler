"""Owned adaptation of the existing fixed-nominee phase replay instrument.

Ordinary selection never imports this diagnostic. The caller checks exact full
application bytes and every marked Python/AOT replay pair before accepting it.
"""
import argparse
import functools
import hashlib
import json
import os
from pathlib import Path
import secrets
import sys
import time
from contextlib import ExitStack
from recompyler import aot, heap, profiler, _heap, _monitor
from recompyler.runner import _AotOnlyExports
from capture_behavior import ApplicationOutput
from heldout_identity import (canonical_file, function_identity, key, jsonable,
                              counter_state, rule_deltas)

ROOT = Path(__file__).resolve().parent
clock = time.perf_counter_ns


def read(path):
    return json.loads(Path(path).read_text(encoding='utf-8-sig'))


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def write(path, value):
    with Path(path).open('x', encoding='utf-8') as stream:
        json.dump(value, stream, indent=2, allow_nan=False)
        stream.write('\n')


def begin():
    token = secrets.token_hex(24)
    markers = dict(start='\nRECOMPYLER_REPLAY_START_' + token + '\n',
                   end='\nRECOMPYLER_REPLAY_END_' + token + '\n')
    sys.stdout.flush()
    sys.stderr.flush()
    for fd in (1, 2):
        os.write(fd, markers['start'].encode('ascii'))
    return markers


def end(markers):
    sys.stdout.flush()
    sys.stderr.flush()
    for fd in (1, 2):
        os.write(fd, markers['end'].encode('ascii'))


def loaded_sources(stage, frozen):
    product, native = {}, {}
    for name, value in list(sys.modules.items()):
        filename = getattr(value, '__file__', None)
        if not filename:
            continue
        path = Path(filename).resolve()
        if not path.is_file():
            continue
        if name == 'recompyler' or name.startswith('recompyler.'):
            assert path.is_relative_to(stage / 'src'), ('Wrong product source/native module', name, path)
            relative = path.relative_to(stage / 'src').as_posix()
            assert frozen['source'][relative] == sha(path), ('Loaded source/native bytes changed', name)
            product[name] = dict(path=canonical_file(path), sha256=sha(path))
        if path.suffix.lower() in ('.pyd', '.so', '.dll'):
            native[name] = dict(path=canonical_file(path), sha256=sha(path))
    assert 'recompyler._heap' in product and 'recompyler._monitor' in product
    return dict(product=product, native_dependencies=native)


def phases(region, fn, inputs, candidate, entry, extension, rule_names):
    """Existing phase scopes, with exact marked Python/AOT calls and provenance."""
    fields = ('load_ns', 'guards_ns', 'native_ns', 'result_ns', 'writeback_ns')
    active, attempts, saved, patches, native_patches = [], [], [], [], []
    for program in region.programs.values():
        if program is not None:
            for namespace, name, _ in getattr(program, 'global_objects', ()):
                value = namespace.get(name)
                state = profiler._global_state(value)
                if state is not None and all(value is not other for other, _ in saved):
                    saved.append((value, state))
    def reset():
        for value, state in saved:
            profiler._restore_global(value, state)
    compiled_before = region.aot_calls, region.jit_calls
    rules_before = counter_state(region, rule_names)
    assert all(value is not None for value in rules_before.values()), 'Region lacks requested rule counter'
    with ExitStack() as cleanup:
        def timed(cls, method, label):
            old, depth = getattr(cls, method), 0
            @functools.wraps(old)
            def call(*args, **kwargs):
                nonlocal depth
                if not active:
                    return old(*args, **kwargs)
                outer = depth == 0
                depth += 1
                started = clock() if outer else 0
                try:
                    return old(*args, **kwargs)
                finally:
                    depth -= 1
                    if outer:
                        active[-1][label] += clock() - started
            setattr(cls, method, call)
            patches.append((cls, method, old, call))
            cleanup.callback(setattr, cls, method, old)
        for cls, method, label in ((heap.Region, 'load', 'load_ns'),
                (heap._Program, 'guards_hold', 'guards_ns'),
                (heap._Unloader, 'result', 'result_ns'),
                (heap._Unloader, 'write_back', 'writeback_ns')):
            timed(cls, method, label)
        for program in region.programs.values():
            if program is None:
                continue
            digest, native = program.digest, program.run
            symbol = entry['exports'].get(digest)
            assert symbol and program.ahead_of_time is True and native is getattr(extension, symbol)
            event = dict(digest=digest, export=symbol,
                generated_source_sha256=hashlib.sha256(program.source.encode()).hexdigest(),
                module=canonical_file(extension.__file__), module_sha256=sha(extension.__file__),
                mode='aot')
            def wrap(native, event):
                def call(*args, **kwargs):
                    started = clock()
                    try:
                        return native(*args, **kwargs)
                    finally:
                        if active:
                            active[-1]['native_ns'] += clock() - started
                            active[-1]['native_entries'] += 1
                            active[-1]['native_events'].append(event)
                return call
            program.run = wrap(native, event)
            native_patches.append((program, native, program.run))
            cleanup.callback(setattr, program, 'run', native)
        try:
            for arguments, expected, after in inputs:
                reset()
                refargs = profiler.fresh_copy(arguments)
                python_markers = begin()
                try:
                    reference = (profiler._collected(fn)(*refargs) if fn.__code__.co_flags & profiler._GENERATORS
                                 else profiler._bound_caller(fn, fn)(*refargs))
                finally:
                    end(python_markers)
                    reset()
                if not saved:
                    assert profiler._same_result(reference, expected) and profiler.same(refargs, after)
                # Restore the exact original phase methods/native callable for
                # an uninstrumented replay at the same Python stack depth.
                for cls, method, original, wrapped in patches:
                    setattr(cls, method, original)
                for program, native, wrapped in native_patches:
                    program.run = native
                rawgiven = profiler.fresh_copy(arguments)
                raw_rules = counter_state(region, rule_names)
                raw_counts = region.aot_calls, region.jit_calls
                raw_markers = begin()
                try:
                    if fn.__code__.co_flags & profiler._GENERATORS:
                        rawgot = region.values(tuple(rawgiven))
                        rawok = rawgot is not None
                    else:
                        rawok, rawgot = region.attempt(tuple(rawgiven))
                finally:
                    end(raw_markers)
                    for cls, method, original, wrapped in patches:
                        setattr(cls, method, wrapped)
                    for program, native, wrapped in native_patches:
                        program.run = wrapped
                baseline = dict(ok=bool(rawok and profiler._same_result(rawgot, reference) and profiler.same(rawgiven, refargs)),
                    aot_calls=region.aot_calls - raw_counts[0], jit_calls=region.jit_calls - raw_counts[1],
                    rule_counters=rule_deltas(raw_rules, counter_state(region, rule_names), bool(rawok)))
                assert baseline['aot_calls'] == int(rawok) and baseline['jit_calls'] == 0
                reset()
                given = profiler.fresh_copy(arguments)
                rec = {field: 0 for field in fields}
                rec.update(native_entries=0, native_events=[], baseline=baseline,
                           streams={'python': python_markers, 'uninstrumented': raw_markers})
                rules = counter_state(region, rule_names)
                native_counts = region.aot_calls, region.jit_calls
                compiled_markers = begin()
                rec['streams']['compiled'] = compiled_markers
                active.append(rec)
                started = clock()
                try:
                    if fn.__code__.co_flags & profiler._GENERATORS:
                        got = region.values(tuple(given))
                        ok = got is not None
                    else:
                        ok, got = region.attempt(tuple(given))
                finally:
                    rec['attempt_ns'] = clock() - started
                    active.pop()
                    end(compiled_markers)
                rec['ok'] = bool(ok and profiler._same_result(got, reference) and profiler.same(given, refargs))
                rec['aot_calls'] = region.aot_calls - native_counts[0]
                rec['jit_calls'] = region.jit_calls - native_counts[1]
                assert rec['aot_calls'] == int(ok) and rec['jit_calls'] == 0
                rec['rule_counters'] = rule_deltas(rules, counter_state(region, rule_names), bool(ok))
                selected = region.latest
                if rule_names:
                    assert hasattr(selected, 'direct_report'), 'Current-rule replay lacks computed effect/decline report'
                rec['direct_report'] = jsonable(getattr(selected, 'direct_report', None))
                rec['boundary_ns'] = sum(rec[field] for field in ('load_ns', 'guards_ns', 'result_ns', 'writeback_ns'))
                rec['other_ns'] = rec['attempt_ns'] - rec['boundary_ns'] - rec['native_ns']
                attempts.append(rec)
        finally:
            reset()
    mean = lambda field: sum(r[field] for r in attempts) / len(attempts) / 1000 if attempts else None
    result = dict(function_identity(fn), python_us=candidate['python_us_per_call'],
        complete_compiled_gate_us=candidate['compiled_cpu_us_per_call'],
        native_us=mean('native_ns'), boundary_us=mean('boundary_ns'), other_us=mean('other_ns'),
        instrumented_complete_us=mean('attempt_ns'), attempts=attempts,
        aot_calls=region.aot_calls - compiled_before[0], jit_calls=region.jit_calls - compiled_before[1],
        independent_successful_completions=sum(int(r['ok']) + int(r['baseline']['ok']) for r in attempts))
    # Per-call deltas reconcile against actual successful complete calls; the
    # aggregate may exceed one, so do not apply the single-call delta bound here.
    result['rule_counters'] = {}
    for name, before in rules_before.items():
        delta = counter_state(region, rule_names)[name] - before
        assert delta == sum(r['rule_counters'][name]['successful_calls'] + r['baseline']['rule_counters'][name]['successful_calls'] for r in attempts)
        assert 0 <= delta <= result['independent_successful_completions']
        result['rule_counters'][name] = dict(implemented=True, successful_calls=delta)
    result['valid'] = bool(attempts and all(r['ok'] and r['baseline']['ok'] and r['native_entries'] > 0 and r['other_ns'] >= 0 for r in attempts)
                           and result['aot_calls'] == result['independent_successful_completions'] and result['jit_calls'] == 0)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('name')
    parser.add_argument('output', type=Path)
    parser.add_argument('--freeze', type=Path, required=True)
    args = parser.parse_args()
    frozen = read(args.freeze)
    stage = args.freeze.resolve().parent
    names = frozen.get('rule_counters', [])
    workload = next(w for w in read(ROOT / 'capture/input-manifest.json')['workloads'] if w['name'] == args.name)
    metadata = read(ROOT / 'capture/base' / args.name / 'plan.json')
    nominees = {(canonical_file(r.get('file', metadata['script'])), r.get('qualname', r['function']), r['line']): r
                for r in metadata['functions']}
    pending, records = [], []
    profile_boundary = args.output.parent / 'profile-application'
    OriginalMonitor = profiler.CallMonitor
    class Monitor(OriginalMonitor):
        def __enter__(self):
            self.application = ApplicationOutput(profile_boundary)
            self.application.__enter__()
            try:
                return super().__enter__()
            except BaseException:
                self.application.__exit__(*sys.exc_info())
                raise
        def __exit__(self, *exc):
            try:
                return super().__exit__(*exc)
            finally:
                self.application.__exit__(*exc)
        def rows(self):
            return [r for r in super().rows()
                    if (canonical_file(r['file']), r.get('qualname', r['function']), r['line']) in nominees]
    profiler.CallMonitor = Monitor
    def candidate(fn, inputs, calls, *extra, **kwargs):
        identity = function_identity(fn)
        assert key(identity) in nominees
        result = profiler.test_region(fn, inputs, calls,
            extra[1] if len(extra) > 1 else kwargs.get('extra', ()),
            extra[2] if len(extra) > 2 else kwargs.get('cumulative_s'))
        if result.get('status') == 'verified' and result.get('engine') == 'region':
            pending.append((fn, inputs, dict(result)))
        else:
            records.append(dict(identity, valid=False, error='Fresh diagnostic no longer verifies',
                                candidate={k: v for k, v in result.items() if not k.startswith('_')}))
        result['recommended'] = False
        return result
    profiler.test_candidate = candidate
    loaded_before = loaded_sources(stage, frozen)
    report = profiler.profile_script(Path(workload['script']), workload['args'], 40, 8, True)
    folder = args.output.parent / 'aot'
    folder.mkdir(exist_ok=False)
    section = heap.build_regions([((fn.__name__, fn.__code__.co_firstlineno), fn, result['_region'])
                                  for fn, inputs, result in pending], folder)
    section_path = args.output.parent / 'aot-section.json'
    write(section_path, section)
    before_load = {canonical_file(path): sha(path)
                   for path in folder.glob(section['module'] + '*')
                   if path.suffix in ('.pyd', '.so', '.dll')} if section else {}
    assert before_load or not pending, 'Build produced no owned AOT artifact'
    extension = aot.load(section) if section else None
    artifacts = dict(before_load)
    artifacts[canonical_file(section_path)] = sha(section_path)
    if extension is not None:
        module_path = Path(extension.__file__).resolve()
        assert module_path.is_relative_to(folder.resolve()), 'AOT module loaded outside owned new build'
        assert before_load[canonical_file(module_path)] == sha(module_path)
    entries = {(canonical_file(e.get('file', workload['script'])), e['qualname'], e['line']): e
               for e in section['functions']} if section else {}
    for fn, inputs, candidate_report in pending:
        identity = function_identity(fn)
        try:
            entry = entries[key(identity)]
            region = heap.lift_region(fn, _AotOnlyExports({digest: getattr(extension, symbol)
                for digest, symbol in entry['exports'].items()}), seeds=entry.get('seeds'))
            for sample in inputs:
                arguments = tuple(profiler.fresh_copy(sample[0]))
                if fn.__code__.co_flags & profiler._GENERATORS:
                    arguments += ([],)
                region.program_for(arguments)
            generated = {}
            for program in region.programs.values():
                if program is None:
                    continue
                source_path = args.output.parent / (program.digest + '.generated.py')
                data = program.source.encode('utf-8')
                if source_path.exists():
                    assert source_path.read_bytes() == data
                else:
                    with source_path.open('xb') as stream:
                        stream.write(data)
                generated[program.digest] = dict(path=str(source_path), sha256=sha(source_path))
                artifacts[canonical_file(source_path)] = sha(source_path)
            row = phases(region, fn, inputs, candidate_report, entry, extension, names)
            row['generated_sources'] = generated
            row['exports'] = entry['exports']
            row['source_definition_sha256'] = sha(fn.__code__.co_filename)
            records.append(row)
        except Exception as exc:
            records.append(dict(identity, valid=False, error=type(exc).__name__ + ': ' + str(exc)))
    seen = {key(row) for row in records}
    records.extend(dict(file=k[0], canonical_file=k[0], qualname=k[1], function=k[1], line=k[2],
        valid=False, error='Nominee missing from fresh capture') for k in nominees if k not in seen)
    assert all(sha(path) == digest for path, digest in artifacts.items())
    loaded_after = loaded_sources(stage, frozen)
    for item in loaded_before['product'].values():
        assert sha(item['path']) == item['sha256']
    write(args.output, dict(program=args.name, expected_nominees=len(nominees), rows=records,
        profile_boundary=str(profile_boundary), loaded_before=loaded_before, loaded_after=loaded_after,
        aot_build_artifacts_before_load=before_load, new_aot_artifacts=artifacts, snapshot_freeze_sha256=sha(args.freeze),
        requested_rule_counters=names, diagnostic_only=True,
        source=str(Path(heap.__file__).resolve()), scope='Owned adaptation of historical phase_child.py with exact Python/uninstrumented/instrumented replay gates'))
    assert len(records) == len(nominees) and all(row['valid'] for row in records), 'Incomplete six replay'


if __name__ == '__main__':
    main()

