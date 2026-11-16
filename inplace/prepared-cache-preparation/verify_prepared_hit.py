"""Prepare-only independent fresh-process prepared-hit verifier; run via run_locked.

Every child executes the real saved runner once, with no prior fixture. Sentinels
forbid regeneration. Native metadata seal calls are excluded from program.run audit.
"""
from pathlib import Path
import argparse
import hashlib
import json
import os
import subprocess
import sys

D = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(D))


def read(path):
    return json.loads(Path(path).read_text(encoding='utf-8-sig'))


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def write(path, value):
    with Path(path).open('x', encoding='utf-8') as stream:
        json.dump(value, stream, indent=2, allow_nan=False)
        stream.write('\n')


def inventory(root):
    return {p.relative_to(root).as_posix(): sha(p) for p in sorted(root.rglob('*'))
            if p.is_file() and '__pycache__' not in p.parts and p.suffix not in ('.pyc', '.pyo', '.nbi', '.nbc')}


def native_counts(report):
    assert report['exit_code'] in (None, 0) and not report['not_found'] and not report['batches'] and not report.get('batch_failures')
    result = {}
    for row in report['functions']:
        identity = (str(Path(row.get('file', report['script'])).resolve()), row['function'], bool(row.get('region')))
        assert identity not in result
        assert row['compiled_calls'] == row['aot_calls'] and row['jit_calls'] == row['fallback_calls'] == 0
        result[identity] = row['aot_calls']
    assert sum(result.values()) == 20
    return result


def job(options, name):
    plan = options.plan_root / name / 'plan.json'
    script = Path(read(plan)['script']).resolve()
    common = options.common_smoke / name
    assert script.is_relative_to(common / 'input'), 'Build new plans against the exact common input path'
    command = read(common / 'saved-0.receipt.json')['command']
    arguments = command[command.index(str(script)) + 1:]
    return plan, script, arguments, read(common / 'counts-0.json')


def child(options):
    # Install before importing any product module; fail even if an unexpected
    # regeneration path catches an ordinary Exception and would silently replay.
    assert not any(n == 'recompyler' or n.startswith('recompyler.') for n in sys.modules)
    violations = []
    class ForbiddenWork(BaseException):
        pass
    def forbidden(label):
        def fail(*args, **kwargs):
            violations.append(label)
            raise ForbiddenWork(label)
        return fail
    class NoCompiler:
        def find_spec(self, fullname, path=None, target=None):
            if fullname.split('.')[0] in ('numba', 'llvmlite'):
                return forbidden('import ' + fullname)()
            return None
    sys.meta_path.insert(0, NoCompiler())
    shim = options.common_smoke / 'shim'
    sys.path[:0] = [str(shim), str(options.source)]
    import ast
    from recompyler import heap, lift, _region_seed
    from capture_audit import Auditor
    from heldout_identity import function_identity, product_functions, native_reconciles
    guarded = []
    def block(owner, attribute, label):
        assert hasattr(owner, attribute), ('Required guard interface absent', label)
        setattr(owner, attribute, forbidden(label))
        guarded.append(label)
    for owner, names, prefix in (
        (heap.Region, ('_make_program',), 'Region'),
        (heap._Program, ('__init__', 'function', 'register', 'compile', 'settle', 'prove_zero_int_results'), 'Program'),
        (heap._Function, ('__init__',), 'Function'),
        (heap._Gen, ('__init__', 'run'), 'Gen'),
        (heap, ('_seed', '_init_assigned', '_source_digest', '_merge_cycles', '_borrow_heap_context'), 'heap'),
        (_region_seed, ('restore',), 'seed'),
        (heap._escape.EscapeAnalysis, ('__init__',), 'EscapeAnalysis'),
        (heap._scalar.ScalarReplacer, ('__init__', 'run'), 'ScalarReplacer'),
        (heap._flow, ('analyse',), 'flow'),
        (ast, ('unparse',), 'ast'),
    ):
        for attribute in names:
            block(owner, attribute, prefix + '.' + attribute)
    # NumericVersions is added by the newly authorized later depth merge. Guard
    # its real entry wherever the imported package exposes it, without inventing
    # an API or requiring that an unmerged module already exists.
    for name, module in list(sys.modules.items()):
        if name.startswith('recompyler.'):
            cls = vars(module).get('NumericVersions')
            if isinstance(cls, type) and hasattr(cls, 'run') and not getattr(cls, '_prepared_verifier_guarded', False):
                block(cls, 'run', name + '.NumericVersions.run')
                cls._prepared_verifier_guarded = True
    assert Path(heap.__file__).resolve().is_relative_to(options.source)
    manifest = read(options.source.parent / 'source-manifest.json')
    assert inventory(options.source) == manifest
    plan_path, script, arguments, expected = job(options, options.name)
    plan = read(plan_path)
    snapshots = {}
    class HitAuditor(Auditor):
        def record_rule(self, row, value, before, successful, program=None):
            if row['kind'] == 'region':
                hit, miss = value.prepared_hits, value.prepared_misses
                assert type(hit) is int and hit >= 0 and type(miss) is int and miss >= 0
                # Primitive copies only; retain no Region/Program/argument graph.
                reasons = json.loads(json.dumps(value.prepared_reasons, allow_nan=False))
                snapshots[id(value)] = dict(function_identity(value.original), prepared_hits=hit, prepared_misses=miss, prepared_reasons=reasons)
            return super().record_rule(row, value, before, successful, program)
    auditor = HitAuditor()
    auditor.patch_region(heap.Region)
    auditor.start_profile()
    report, verified, error_type = None, False, None
    try:
        from recompyler.runner import run_script
        os.chdir(script.parent)
        report = run_script(script, arguments, plan_path, False)
        independent = auditor.result()
        assert not violations
        assert native_counts(report) == native_counts(expected)
        assert independent['audit_accounting_complete']
        assert independent['totals']['aot_calls'] == 20
        assert all(independent['totals'][key] == 0 for key in ('jit_calls', 'unknown_native_calls', 'fallback_calls', 'rejected_attempts'))
        assert native_reconciles(product_functions(report, plan), independent['functions'])
        assert snapshots and all(row['prepared_hits'] > 0 for row in snapshots.values())
        for row in independent['functions']:
            assert row['native_entries'] >= row['aot_calls']
            assert row['unobserved_successes'] == 0
        assert not any(n.split('.')[0] in ('numba', 'llvmlite') for n in sys.modules)
        verified = True
    except BaseException as exc:
        error_type = type(exc).__module__ + '.' + type(exc).__qualname__
        raise
    finally:
        result = auditor.result()
        auditor.restore()
        loaded = {}
        for name, module in list(sys.modules.items()):
            if (name == 'recompyler' or name.startswith('recompyler.')) and getattr(module, '__file__', None):
                path = Path(module.__file__).resolve()
                assert path.is_relative_to(options.source), (name, path)
                assert manifest[path.relative_to(options.source).as_posix()] == sha(path)
                loaded[name] = dict(path=str(path), sha256=sha(path))
        result.update(verified=verified, diagnostic_only=True, timing_eligible=False, runner_report=report,
            error_type=error_type, forbidden_calls=violations, guarded_entries=guarded,
            prepared_regions=list(snapshots.values()), source=str(options.source), loaded_product_modules=loaded,
            source_manifest_sha256=sha(options.source.parent / 'source-manifest.json'), plan_sha256=sha(plan_path),
            script_sha256=sha(script), shim_sha256=sha(shim / 'pyperf.py'),
            workload_executions=1, fixture_executed_before_runner=False, force=False,
            audit_helper_sha256=sha(D / 'capture_audit.py'), identity_helper_sha256=sha(D / 'heldout_identity.py'),
            metadata_seal_calls_counted_as_computational=False)
        write(options.output / 'child-report.json', result)


def parent(options):
    assert read(options.plan_root/'summary.json')['complete']
    assert read(options.source.parent/'complete.json')['complete']
    assert not (options.plan_root/'FAILED.json').exists()
    options.output.mkdir()
    assert read(options.reference / 'summary.json')['complete'] and not (options.reference / 'FAILED.json').exists()
    manifest = read(options.source.parent / 'source-manifest.json')
    assert inventory(options.source) == manifest
    records = []
    for name in ('chaos', 'richards_super'):
        directory = options.output / name
        directory.mkdir()
        plan, script, arguments, expected = job(options, name)
        # Artifacts are read-only evidence; native binding bytes are independently
        # observed by the child's computational program.run audit below.
        sections = read(plan).get('plan', {})
        artifacts = {kind: dict(root=section['folder'], files=inventory(Path(section['folder'])))
                     for kind, section in sections.items() if kind in ('aot', 'aot_regions')}
        assert artifacts and all(Path(value['root']).resolve().is_relative_to(D) for value in artifacts.values())
        allowed = set()
        for kind, section in sections.items():
            if kind not in ('aot', 'aot_regions'):
                continue
            root = Path(section['folder']).resolve()
            for relative in artifacts[kind]['files']:
                module = root / relative
                if module.suffix not in ('.pyd', '.so', '.dll') or not module.name.startswith(section['module']):
                    continue
                for entry in section['functions']:
                    for digest, symbol in entry['exports'].items():
                        allowed.add((digest if kind == 'aot_regions' else entry['digest'], symbol, str(module)))
        env = os.environ.copy()
        env.pop('PYTHONDONTWRITEBYTECODE', None)
        env.update(PYTHONPATH=os.pathsep.join([str(options.common_smoke / 'shim'), str(options.source), str(D)]),
            PYTHONPYCACHEPREFIX=str(options.output / 'bytecode'), TEMP=str(directory), TMP=str(directory),
            RECOMPYLER_CACHE=str(directory / 'cache'), RECOMPYLER_CACHE_DIR=str(directory / 'cache'),
            NUMBA_CACHE_DIR=str(directory / 'numba'), PYTHONWARNINGS='ignore', PYTHONIOENCODING='utf-8:strict', PYTHONUTF8='1')
        command = [sys.executable, str(Path(__file__).resolve()), '--child', '--name', name,
            '--source', str(options.source), '--plan-root', str(options.plan_root), '--common-smoke', str(options.common_smoke),
            '--reference', str(options.reference), '--output', str(directory), '--lock-label', options.lock_label]
        with (directory / 'stdout').open('xb') as out, (directory / 'stderr').open('xb') as err:
            done = subprocess.run(command, cwd=script.parent, env=env, stdout=out, stderr=err)
        write(directory / 'receipt.json', dict(command=command, exit_code=done.returncode, timing_eligible=False))
        assert done.returncode == 0
        assert (directory / 'stdout').read_bytes() == (options.reference / name / 'plain-0.stdout').read_bytes()
        assert (directory / 'stderr').read_bytes() == (options.reference / name / 'plain-0.stderr').read_bytes()
        result = read(directory / 'child-report.json')
        assert result['verified'] and not result['forbidden_calls']
        for function in result['functions']:
            for program in function['programs'].values():
                for event in program.get('native_events', []):
                    path = Path(event['module_path']).resolve()
                    assert (event['digest'], event['export'], str(path)) in allowed
                    section = next(value for value in artifacts.values() if path.is_relative_to(Path(value['root']).resolve()))
                    assert event['module_sha256'] == section['files'][path.relative_to(section['root']).as_posix()] == sha(path)
        assert all(inventory(Path(value['root'])) == value['files'] for value in artifacts.values())
        records.append(dict(name=name, verified=True, child_sha256=sha(directory / 'child-report.json'),
            exact_output=True, aot_successes=20, prepared_regions=result['prepared_regions']))
    assert inventory(options.source) == manifest
    write(options.output / 'summary.json', dict(complete=True, programs=records, verifier_sha256=sha(__file__),
        source_manifest_sha256=sha(options.source.parent / 'source-manifest.json'), timing_eligible=False))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--plan-root', type=Path, required=True)
    parser.add_argument('--common-smoke', type=Path, default=D / 'integration-smoke20-v4')
    parser.add_argument('--reference', type=Path, default=D / 's31-matched-smoke-v1')
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--lock-label', required=True)
    parser.add_argument('--child', action='store_true')
    parser.add_argument('--name', choices=('chaos', 'richards_super'))
    options = parser.parse_args()
    for name in ('source', 'plan_root', 'common_smoke', 'reference', 'output'):
        path = getattr(options, name).resolve()
        assert path.is_relative_to(D), (name, path)
        setattr(options, name, path)
    owner = (D.parent.parent / 'TIMING.lock/owner.txt').read_text(encoding='utf-8-sig')
    assert 'wave16-inplace' in owner and ('purpose: ' + options.lock_label + '\n') in owner
    if options.child:
        assert options.name and options.output.is_dir()
        child(options)
    else:
        assert not options.output.exists()
        try:
            parent(options)
        except BaseException as exc:
            if options.output.is_dir():
                write(options.output / 'FAILED.json', dict(error_type=type(exc).__name__, aggregate_eligible=False))
            raise


if __name__ == '__main__':
    main()
