"""Cold saved-run seed diagnostics; prepared only, execute under run_locked.

One fresh process calls the unmodified runner.run_script exactly once, with its
real saved plan/input/shim. No fixture execution, JIT, gate forcing or seed reorder.
Observer times are diagnostic and include wrapper overhead, not headline samples.
"""
import sys
import time
ENTRY_NS = time.perf_counter_ns()
import argparse
import hashlib
import importlib.machinery
import json
import os
from pathlib import Path

D = Path(__file__).resolve().parent
CLONE, WORKSPACE = D.parent, D.parent.parent


def read(path):
    return json.loads(Path(path).read_text(encoding='utf-8-sig'))


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def seed_identity(seed):
    return hashlib.sha256(json.dumps(seed, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def nullable_summary(seed):
    result = {'nullable_object_types': 0, 'strict_object_types': 0}
    def visit(value):
        if isinstance(value, dict):
            for item in value.values():
                visit(item)
        elif isinstance(value, list):
            if len(value) == 4 and value[0] == 'object' and type(value[2]) is bool:
                result['nullable_object_types' if value[2] else 'strict_object_types'] += 1
            for item in value:
                visit(item)
    visit(seed)
    return result


class Trace:
    def __init__(self, offered):
        self.events, self.stack, self.offered, self.restores = [], [], offered, {}
        self.regions, self.blocked_imports = {}, []

    def start(self, phase, metadata=None):
        row = dict(sequence=len(self.events), phase=phase, start_ns=time.perf_counter_ns() - ENTRY_NS,
                   parent=self.stack[-1]['sequence'] if self.stack else None, children_ns=0)
        if metadata:
            row.update(metadata)
        self.events.append(row)
        self.stack.append(row)
        return row

    def end(self, row, error=None, metadata=None):
        now = time.perf_counter_ns() - ENTRY_NS
        assert self.stack.pop() is row
        row.update(end_ns=now, elapsed_ns=now - row['start_ns'])
        row['exclusive_ns'] = row['elapsed_ns'] - row['children_ns']
        if error is not None:
            row.update(exception_type=type(error).__module__ + '.' + type(error).__qualname__,
                       exception_message=str(error), mismatch_reason_available=bool(str(error)))
            if not str(error):
                row['mismatch_note'] = 'The original exception has no message; no field-specific cause is inferred.'
        if metadata:
            row.update(metadata)
        if self.stack:
            self.stack[-1]['children_ns'] += row['elapsed_ns']

    def program(self, program):
        identity = getattr(program, 'seed_identity', None)
        result = dict(seed_identity=identity, digest=getattr(program, 'digest', None),
                      ahead_of_time=getattr(program, 'ahead_of_time', None),
                      expected_seed_exports=self.offered.get(identity, []))
        if hasattr(program, 'source'):
            result['generated_source_sha256'] = hashlib.sha256(program.source.encode()).hexdigest()
        return result

    def region(self, region):
        self.regions[id(region)] = region
        fn = region.original
        return dict(function=fn.__qualname__, file=str(Path(fn.__code__.co_filename).resolve()),
                    line=fn.__code__.co_firstlineno,
                    aot_completed_before=region.aot_calls, jit_completed_before=region.jit_calls,
                    fallback_before=region.fallback_calls)

    def install_heap(self, heap):
        old_compile, old_load, old_program_for = heap._Program.compile, heap.Region.load, heap.Region.program_for
        def compile(program, *args, **kwargs):
            row = self.start('Program.compile', self.program(program))
            error = None
            try:
                return old_compile(program, *args, **kwargs)
            except BaseException as exc:
                error = exc
                raise
            finally:
                self.end(row, error, self.program(program))
        def load(region, program, *args, **kwargs):
            row = self.start('Region.load', dict(self.region(region), **self.program(program)))
            error = None
            try:
                return old_load(region, program, *args, **kwargs)
            except BaseException as exc:
                error = exc
                raise
            finally:
                metadata = self.program(program)
                metadata.update(aot_completed_after=region.aot_calls, jit_completed_after=region.jit_calls,
                                region_problem=region.problem)
                self.end(row, error, metadata)
        def program_for(region, *args, **kwargs):
            row = self.start('Region.program_for', self.region(region))
            error, selected = None, None
            try:
                selected = old_program_for(region, *args, **kwargs)
                return selected
            except BaseException as exc:
                error = exc
                raise
            finally:
                metadata = dict(selected=None if selected is None else self.program(selected),
                                region_problem=region.problem, aot_completed_after=region.aot_calls,
                                jit_completed_after=region.jit_calls)
                self.end(row, error, metadata)
        heap._Program.compile, heap.Region.load, heap.Region.program_for = compile, load, program_for

    def install_seeds(self, seeds):
        original = seeds.restore
        def restore(fn, seed):
            identity = seed_identity(seed)
            row = self.start('seed.restore', dict(seed_identity=identity,
                expected_seed_exports=self.offered.get(identity, []), function=fn.__qualname__))
            error, program = None, None
            try:
                program = original(fn, seed)
                return program
            except BaseException as exc:
                error = exc
                raise
            finally:
                self.end(row, error, dict(restored=None if program is None else self.program(program)))
        seeds.restore = restore


class Imports:
    TARGETS = {'numpy', 'recompyler.runner', 'recompyler.heap', 'recompyler.aot', 'recompyler._region_seed'}
    def __init__(self, trace, source, manifest):
        self.trace, self.source, self.manifest = trace, source, manifest

    def find_spec(self, fullname, path=None, target=None):
        if fullname == 'numba' or fullname.startswith('numba.'):
            self.trace.blocked_imports.append(fullname)
            raise RuntimeError('Seed diagnostic forbids Numba import; saved AOT path requested JIT.')
        if fullname not in self.TARGETS:
            return None
        spec = importlib.machinery.PathFinder.find_spec(fullname, path)
        assert spec is not None and spec.loader is not None, ('Missing observed module', fullname)
        original, trace, source, manifest = spec.loader, self.trace, self.source, self.manifest
        class Loader:
            def create_module(self, selected):
                return original.create_module(selected) if hasattr(original, 'create_module') else None
            def exec_module(self, module):
                row, error = trace.start('startup.import', {'module': fullname}), None
                try:
                    original.exec_module(module)
                    if fullname.startswith('recompyler.'):
                        filename = Path(module.__file__).resolve()
                        assert filename.is_relative_to(source)
                        assert sha(filename) == manifest[filename.relative_to(source).as_posix()]
                    if fullname == 'recompyler.heap':
                        trace.install_heap(module)
                    elif fullname == 'recompyler._region_seed':
                        trace.install_seeds(module)
                except BaseException as exc:
                    error = exc
                    raise
                finally:
                    trace.end(row, error, {'module_file': getattr(module, '__file__', None)})
            def __getattr__(self, name):
                return getattr(original, name)
        spec.loader = Loader()
        return spec


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=D / 'bases/integration-noop/src')
    parser.add_argument('--plan', type=Path, default=D / 'integration-smoke20-v3/richards_super/plan.json')
    parser.add_argument('--shim', type=Path, default=D / 'integration-smoke20-v3/shim')
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--lock-label', required=True)
    options = parser.parse_args()
    source, plan, shim, output = (p.resolve() for p in (options.source, options.plan, options.shim, options.output))
    assert all(p.is_relative_to(D.resolve()) for p in (source, plan, shim, output))
    assert not output.exists(), 'Preserve earlier diagnostic evidence'
    owner = (WORKSPACE / 'TIMING.lock/owner.txt').read_text(encoding='utf-8-sig')
    assert 'wave16-inplace' in owner and ('purpose: ' + options.lock_label + '\n') in owner
    assert not any(n == 'recompyler' or n.startswith('recompyler.') or n == 'numba' or n.startswith('numba.') for n in sys.modules)
    assert os.environ.get('PYTHONPYCACHEPREFIX'), 'Use the owned run_locked environment'
    assert Path(os.environ['PYTHONPYCACHEPREFIX']).resolve().is_relative_to(D.resolve())
    os.environ.pop('PYTHONDONTWRITEBYTECODE', None)
    os.environ['PYTHONPATH'] = os.pathsep.join([str(shim), str(source)])
    sys.path[:0] = [str(shim), str(source)]
    manifest_path = source.parent / 'source-manifest.json'
    manifest, saved = read(manifest_path), read(plan)
    script = Path(saved['script']).resolve()
    assert script.is_relative_to(D.resolve())
    saved_receipt = read(plan.parent / 'saved-0.receipt.json')
    command = saved_receipt['command']
    arguments = command[command.index(str(script)) + 1:]
    expected = read(plan.parent / 'counts-0.json')
    offered, seed_rows = {}, []
    for section_name in ('aot', 'aot_regions'):
        section = saved.get('plan', {}).get(section_name)
        if not section:
            continue
        assert Path(section['folder']).resolve().is_relative_to(D.resolve())
        for entry in section['functions']:
            for ordinal, (digest, seed) in enumerate(entry.get('seeds', {}).items()):
                identity = seed_identity(seed)
                info = dict(function=entry['qualname'], ordinal=ordinal, expected_digest=digest,
                            export=entry['exports'].get(digest), seed_identity=identity, **nullable_summary(seed))
                offered.setdefault(identity, []).append(info)
                seed_rows.append(info)
    trace = Trace(offered)
    imports = Imports(trace, source, manifest)
    sys.meta_path.insert(0, imports)
    bootstrap_ns = time.perf_counter_ns() - ENTRY_NS
    report, error = None, None
    original_cwd = Path.cwd()
    outer = trace.start('real_saved_script', {'script': str(script), 'arguments': arguments, 'force': False})
    try:
        from recompyler.runner import run_script
        os.chdir(script.parent)
        report = run_script(script, arguments, plan, False)
    except BaseException as exc:
        error = exc
        raise
    finally:
        trace.end(outer, error)
        os.chdir(original_cwd)
        sys.meta_path.remove(imports)
        loaded = {}
        for name, value in list(sys.modules.items()):
            filename = getattr(value, '__file__', None)
            if (name == 'recompyler' or name.startswith('recompyler.')) and filename:
                path = Path(filename).resolve()
                assert path.is_relative_to(source), ('Wrong saved-run source/native module', name, path)
                digest = sha(path)
                assert manifest[path.relative_to(source).as_posix()] == digest
                loaded[name] = dict(path=str(path), sha256=digest)
        modes = [dict(function=r.original.__qualname__, aot_calls=r.aot_calls, jit_calls=r.jit_calls,
                      fallback_calls=r.fallback_calls, latest=None if r.latest is None else trace.program(r.latest))
                 for r in trace.regions.values()]
        result = dict(schema='wave16-cold-seed-attempts-v1', diagnostic_only=True, headline_timing_eligible=False,
            source=str(source), source_manifest_sha256=sha(manifest_path), loaded_product_modules=loaded,
            plan=str(plan), plan_sha256=sha(plan), script=str(script), script_sha256=sha(script),
            shim_sha256=sha(shim / 'pyperf.py'), script_args=arguments, workload_executions=1,
            fixture_executed_before_runner=False, force=False, bootstrap_observer_ns=bootstrap_ns,
            script_entry_elapsed_ns=time.perf_counter_ns() - ENTRY_NS, events=trace.events,
            offered_seeds=seed_rows, region_final_counts=modes, runner_report=report,
            numba_modules=[n for n in sys.modules if n == 'numba' or n.startswith('numba.')],
            blocked_numba_imports=trace.blocked_imports,
            environment={k: os.environ.get(k) for k in ('PYTHONPYCACHEPREFIX', 'PYTHONDONTWRITEBYTECODE',
                'PYTHONWARNINGS', 'PYTHONIOENCODING', 'PYTHONUTF8', 'PYTHONHASHSEED', 'PYTHONPATH',
                'OMP_NUM_THREADS', 'NUMBA_NUM_THREADS', 'OPENBLAS_NUM_THREADS', 'MKL_NUM_THREADS')},
            limitations=['One real cold script execution; wrapper/import-observer overhead retained.',
                'Startup spans measure imports inside an already-started interpreter; parent receipt supplies process wall time.',
                'Bare C Mismatch exceptions contain no field reason; no nullability cause is invented.',
                'No schema preflight, seed reordering, gate change, replayed fixture or Numba execution.'])
        output.parent.mkdir(parents=True, exist_ok=True)
        with output.open('x', encoding='utf-8') as stream:
            json.dump(result, stream, indent=2, allow_nan=False)
            stream.write('\n')
    assert not result['numba_modules'] and not result['blocked_numba_imports']
    assert report['exit_code'] in (None, 0) and not report['not_found'] and not report['batches']
    counts = lambda rows: {(r.get('file'), r['function']): (r['compiled_calls'], r['aot_calls'], r['jit_calls'], r['fallback_calls']) for r in rows}
    assert counts(report['functions']) == counts(expected['functions']), 'Actual cold native counts differ from v3 saved child'
    assert sum(r['aot_calls'] for r in report['functions']) == 20 and all(r['jit_calls'] == r['fallback_calls'] == 0 for r in report['functions'])


if __name__ == '__main__':
    main()

