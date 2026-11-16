"""Owned, serialized preparation-phase diagnostic. Prepare now; run only under lock.

No product mutation, optimizer disabling, gate change, JIT compilation, or AOT
build is performed. The parent copies frozen source into its new output folder,
then launches one fresh child per source in sequence. Phase times are diagnostic.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import shutil
import subprocess
import sys
import time
import types

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
WORKSPACE = ROOT.parent


def digest_file(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def inside(path, parent):
    return path.resolve().is_relative_to(parent.resolve())


def write_new(path, value):
    with path.open('x', encoding='utf-8') as stream:
        json.dump(value, stream, indent=2)
        stream.write('\n')


class Phases:
    def __init__(self):
        self.active = []
        self.rows = {}
        self.originals = []

    def wrap(self, owner, attribute, label):
        original = getattr(owner, attribute, None)
        if original is None:
            return
        self.originals.append((owner, attribute, original))
        def measured(*args, **kwargs):
            selected = label
            if label == 'scalar_checked_lower':
                selected += '_empty' if not args[3] and not args[4] and args[5] is None and not args[6] else '_nonempty'
            elif label == 'scalar_lower_construct':
                selected += '_empty' if not args[4] and not args[5] and args[6] is None and not (args[7] if len(args)>7 else kwargs.get('fresh')) else '_nonempty'
            elif label == 'scalar_lower_visit':
                instance=args[0]
                selected += '_empty' if not instance.locals and not instance.params and instance.clone is None and not instance.fresh else '_nonempty'
            record = [time.perf_counter(), 0.0]
            self.active.append(record)
            try:
                return original(*args, **kwargs)
            finally:
                elapsed = time.perf_counter() - record[0]
                self.active.pop()
                if self.active:
                    self.active[-1][1] += elapsed
                row = self.rows.setdefault(selected, dict(calls=0, inclusive_s=0.0, exclusive_s=0.0))
                row['calls'] += 1
                row['inclusive_s'] += elapsed
                row['exclusive_s'] += elapsed - record[1]
        setattr(owner, attribute, measured)

    def restore(self):
        for owner, attribute, original in reversed(self.originals):
            setattr(owner, attribute, original)


def child(options):
    source, script, shim, output = map(Path, (options.source, options.input, options.shim, options.output))
    assert inside(source, ROOT), source
    assert inside(script, ROOT) and inside(output, ROOT)
    sys.path[:0] = [str(source.resolve()), str(shim.resolve()), str(script.parent.resolve())]
    import numpy  # Import cost is deliberately outside preparation phase times.
    import recompyler.heap as heap
    import recompyler.profiler as profiler
    import recompyler._origin as origin
    import recompyler.aot as aot
    assert inside(Path(heap.__file__), source), heap.__file__
    assert 'numba' not in sys.modules

    # Execute exactly the owned twenty-iteration driver as __main__, preserving
    # function code, co_filename, globals, class cells, and source-origin seals.
    original_argv, original_main = sys.argv, sys.modules.get('__main__')
    module = types.ModuleType('__main__')
    module.__dict__.update(__file__=str(script.resolve()), __package__='', __spec__=None)
    sys.modules['__main__'] = module
    sys.argv = [str(script.resolve())]
    fixture_start = time.perf_counter()
    try:
        exec(compile(script.read_bytes(), str(script.resolve()), 'exec'), module.__dict__)
    finally:
        sys.argv = original_argv
    fixture_s = time.perf_counter() - fixture_start
    import pyperf
    assert pyperf.LOOPS == 20
    fn = module.Richards.run
    args = (module.richard, 1)
    assert fn.__module__ == '__main__' and fn.__code__.co_filename == str(script.resolve())
    state = profiler._global_state(module.taskWorkArea)
    reference = fn(*args)
    reference_counts = dict(hold=module.taskWorkArea.holdCount, queued=module.taskWorkArea.qpktCount)
    assert reference is True and reference_counts == dict(hold=9297, queued=23246)
    profiler._restore_global(module.taskWorkArea, state)

    plan = json.loads(Path(options.plan).read_text(encoding='utf-8'))
    section = plan['plan']['aot_regions']
    entry = next(item for item in section['functions'] if item['qualname'] == 'Richards.run')
    live_origin = origin.identity(fn)
    assert live_origin == entry['origin'], (live_origin, entry['origin'])

    sentinel = object()
    class Discovery(dict):
        def __bool__(self): return True
        def get(self, key, default=None):
            self[key] = sentinel
            return sentinel
    class ExactHits(dict):
        def __init__(self, values):
            super().__init__(values)
            self.hits, self.misses = [], []
        def get(self, key, default=None):
            (self.hits if key in self else self.misses).append(key)
            return super().get(key, default)

    def prepare(exports):
        program = heap._Program(fn)
        seen = {}
        kinds = [heap._seed(program, value, seen) for value in args]
        for name, kind in zip(program.entry.params, kinds):
            program.widen(program.entry.vars, name, kind)
        program.compile(exports)
        assert program.run is sentinel
        return program

    # Unmeasured deterministic discovery avoids JIT entirely. The measured repeat
    # accepts ONLY this exact generated digest; no pass is bypassed or disabled.
    discovery = Discovery()
    priming_start = time.perf_counter()
    first = prepare(discovery)
    priming_s = time.perf_counter() - priming_start
    assert list(discovery) == [first.digest]
    exports = ExactHits({first.digest: sentinel})
    phases = Phases()
    hooks = [(heap._Program, '__init__', 'program_construct'),
             (heap._Program, 'compile', 'compile'),
             (heap._Program, 'settle', 'settle'),
             (heap._Program, 'prove_zero_int_results', 'zero_proofs'),
             (heap, '_source_digest', 'source_digest'),
             (origin, 'cache_identity', 'origin_identity')]
    if hasattr(heap, '_escape'):
        hooks.append((heap._escape.EscapeAnalysis, '__init__', 'escape_fixed_point'))
    if hasattr(heap, '_scalar'):
        hooks += [(heap._scalar.ScalarReplacer, 'run', 'scalar_run'),
                  (heap._scalar.ScalarReplacer, 'lower', 'scalar_lower'),
                  (heap._scalar.ScalarReplacer, 'checked_lower', 'scalar_checked_lower'),
                  (heap._scalar.Lower, '__init__', 'scalar_lower_construct'),
                  (heap._scalar.Lower, 'lower', 'scalar_lower_visit')]
    for owner, attribute, label in hooks:
        phases.wrap(owner, attribute, label)
    measured_start = time.perf_counter()
    try:
        prepared = prepare(exports)
    finally:
        preparation_s = time.perf_counter() - measured_start
        phases.restore()
    assert prepared.digest == first.digest and exports.hits == [first.digest] and not exports.misses
    assert 'numba' not in sys.modules

    copies = []
    for _ in range(4):
        started = time.perf_counter()
        copied = profiler.fresh_copy(args)
        copies.append(time.perf_counter() - started)
        assert type(copied[0]) is module.Richards and copied[1] == 1
        del copied
    analysis = getattr(prepared, 'escape_analysis', None)
    scalar = getattr(prepared, 'scalar_report', {})
    report = dict(label=options.label, mode='compile-only pre-AOT phase bound',
                  source=str(source.resolve()), source_files={str(p.relative_to(source)):digest_file(p)
                    for p in sorted((source/'recompyler').glob('*.py'))},
                  input=str(script.resolve()), input_sha256=digest_file(script), origin=live_origin,
                  fixture_iterations=20, fixture_s=fixture_s, args=['Richards instance', 1],
                  reference=reference, reference_counts=reference_counts,
                  unmeasured_discovery_s=priming_s, preparation_s=preparation_s,
                  phases=phases.rows, four_fresh_copy_s=copies,
                  generated_digest=prepared.digest, digest_hits=exports.hits, digest_misses=exports.misses,
                  generated_source_sha256=hashlib.sha256(prepared.source.encode()).hexdigest(),
                  generated_source_bytes=len(prepared.source.encode()), function_count=len(prepared.order),
                  source_ast_nodes=sum(sum(1 for _ in __import__('ast').walk(__import__('ast').parse(i.source))) for i in prepared.order),
                  analysis_iterations=getattr(analysis, 'iterations', None),
                  scalar_report=scalar,
                  scalar_removed_sites=scalar.get('removed_sites', []),
                  scalar_field_clones=scalar.get('field_clones', []),
                  scalar_fresh_return_clones=scalar.get('fresh_return_clones', []),
                  existing_plan_digest_match=prepared.digest in entry['exports'],
                  recorded_warm_start_s=next(r['candidate']['warm_start_s'] for r in plan['functions'] if r.get('qualname')=='Richards.run'),
                  note='Comparison excludes module imports/JIT/native work; four native calls in warm_start_time are not simulated by dummy exports.')

    if hasattr(heap, '_scalar'):
        started=time.perf_counter()
        engine=heap._scalar.ScalarReplacer(prepared,heap,classes=('a','b','c'))
        local_candidates=[];fresh_candidates=[];blocked=[]
        for name,tree in engine.originals.items():
            for token,row in engine.analysis.allocations.items():
                if row['function']!=name or row['class'] not in ('a','b'):continue
                try:engine.virtual(engine.analysis.functions[name].allocations[row['variable']],token,'_sr_'+row['variable'])
                except heap._scalar.CannotScalar as exc:blocked.append({'site':token,'unknown':'F2/F5 '+str(exc)})
                else:local_candidates.append(token)
            for node in __import__('ast').walk(tree):
                if isinstance(node,__import__('ast').Assign) and len(node.targets)==1 and isinstance(node.targets[0],__import__('ast').Name) and isinstance(node.value,__import__('ast').Call) and isinstance(node.value.func,__import__('ast').Name):
                    cls=engine.fresh_class(node.value.func.id)
                    if cls is not None:
                        try:engine.virtual(cls,'@call:'+name+':'+node.targets[0].id,'_sr_call_'+node.targets[0].id)
                        except heap._scalar.CannotScalar:pass
                        else:fresh_candidates.append(name+':'+node.targets[0].id)
        report['noop_preflight']=dict(seconds=time.perf_counter()-started,local_candidates=local_candidates,fresh_candidates=fresh_candidates,blocked=blocked,allocation_classes=engine.analysis.allocations)
    write_new(output/'phases.json', report)
    if options.label == 'integration-fixed':
        assert report['existing_plan_digest_match'], 'Generated integration digest differs from its recorded export; inspect before claiming like-for-like preparation.'
        # One ordinary complete call uses the actual existing AOT artifact and its
        # guarded seeds. No JIT fallback is permitted. Snapshot is restored afterward.
        compiled_module = aot.load(section)
        assert compiled_module is not None
        class AotOnly(dict):
            allow_jit = False
        actual_exports = AotOnly({key:getattr(compiled_module, symbol) for key,symbol in entry['exports'].items()})
        profiler._restore_global(module.taskWorkArea, state)
        region = heap.lift_region(fn, actual_exports, entry.get('seeds'))
        call_start = time.perf_counter()
        result = region(*args)
        elapsed = time.perf_counter() - call_start
        assert result is True and region.compiled_calls == 1 and region.aot_calls == 1 and region.jit_calls == 0
        assert module.taskWorkArea.holdCount == 9297 and module.taskWorkArea.qpktCount == 23246
        assert 'numba' not in sys.modules
        report['actual_saved_aot_first_call'] = dict(seconds=elapsed, result=result,
            compiled_calls=region.compiled_calls, aot_calls=region.aot_calls,
            jit_calls=region.jit_calls, fallback_calls=region.fallback_calls,
            digest=region.latest.digest, seed_policy=entry.get('seed_policy'))
        profiler._restore_global(module.taskWorkArea, state)
    else:
        report['actual_saved_aot_first_call'] = None
        report['native_note'] = 'No compatible artifact is supplied for this source/origin. This is deterministic compile-only phase evidence, with no native performance claim.'
    write_new(output/'report.json', report)
    print(json.dumps(dict(label=options.label, preparation_s=preparation_s, phases=phases.rows,
                         digest=prepared.digest, plan_digest_match=report['existing_plan_digest_match'])), flush=True)
    if original_main is not None:
        sys.modules['__main__'] = original_main


def parent(options):
    output = Path(options.output).resolve()
    assert inside(output, HERE) and output != HERE
    output.mkdir(exist_ok=False)
    frozen = WORKSPACE/'wave14-capture/stages/item1-s23-final2'
    freeze = json.loads((frozen/'freeze.json').read_text(encoding='utf-8'))
    copied = output/'frozen-src'
    for rel, expected in freeze['source'].items():
        source = frozen/'src'/rel
        assert digest_file(source) == expected, source
        target = copied/rel
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(source, target)
    source_choices = [('frozen-coverage', copied), (options.integration_label, Path(options.integration_source).resolve())]
    jobs = []
    for label, source in source_choices:
        assert inside(source, ROOT)
        child_output = output/label
        child_output.mkdir()
        env = os.environ.copy()
        env.update(PYTHONPATH=os.pathsep.join([str(source), options.shim]),
                   PYTHONPYCACHEPREFIX=str(child_output/'bytecode'),
                   RECOMPYLER_CACHE=str(child_output/'cache'), RECOMPYLER_CACHE_DIR=str(child_output/'cache'),
                   NUMBA_CACHE_DIR=str(child_output/'numba'), TEMP=str(child_output), TMP=str(child_output),
                   PYTHONHASHSEED='0', OMP_NUM_THREADS='1', OPENBLAS_NUM_THREADS='1', MKL_NUM_THREADS='1', NUMBA_NUM_THREADS='1')
        env.pop('PYTHONDONTWRITEBYTECODE', None)
        command = [sys.executable, str(Path(__file__).resolve()), '--child', '--label', label,
                   '--source', str(source), '--output', str(child_output), '--input', options.input,
                   '--shim', options.shim, '--plan', options.plan]
        with (child_output/'stdout').open('xb') as stdout, (child_output/'stderr').open('xb') as stderr:
            done = subprocess.run(command, cwd=child_output, env=env, stdout=stdout, stderr=stderr)
        receipt = dict(label=label, command=command, exit_code=done.returncode)
        write_new(child_output/'receipt.json', receipt)
        assert done.returncode == 0, receipt
        jobs.append(json.loads((child_output/'report.json').read_text(encoding='utf-8')))
    write_new(output/'summary.json', dict(schema='preparation-phases-v1', children=jobs))
    print(json.dumps([dict(label=r['label'], preparation_s=r['preparation_s'], phases=r['phases']) for r in jobs], indent=2))


def main():
    smoke = HERE/'integration-smoke20-v2'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', default=str(HERE/'preparation-phases'))
    parser.add_argument('--integration-label', default='integration-fixed')
    parser.add_argument('--integration-source', default=str(HERE/'bases/integration-fixed/src'))
    parser.add_argument('--input', default=str(smoke/'richards_super/input/run_benchmark.py'))
    parser.add_argument('--shim', default=str(smoke/'shim'))
    parser.add_argument('--plan', default=str(smoke/'richards_super/plan.json'))
    parser.add_argument('--child', action='store_true')
    parser.add_argument('--source')
    parser.add_argument('--label')
    options = parser.parse_args()
    (child if options.child else parent)(options)


if __name__ == '__main__':
    main()
