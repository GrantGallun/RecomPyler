"""S31 matched plain/frozen-coverage/integrated smoke; execute only via run_locked.

One coverage profile/select per program. New integrated plans must preserve
exact common v4 input paths. Three fresh balanced triples; no selection override.
"""
from pathlib import Path
import argparse
import ast
import hashlib
import io
import json
import os
import statistics
import subprocess
import sys
import time
from contextlib import redirect_stderr
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from capture_behavior import extract

D = Path(__file__).resolve().parents[1]
W = D.parent.parent


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def read(path):
    return json.loads(Path(path).read_text(encoding='utf-8-sig'))


def write(path, value):
    with Path(path).open('x', encoding='utf-8') as stream:
        json.dump(value, stream, indent=2, allow_nan=False)
        stream.write('\n')


def inventory(folder):
    return {p.relative_to(folder).as_posix(): sha(p) for p in sorted(Path(folder).rglob('*'))
            if p.is_file() and '__pycache__' not in p.parts and p.suffix not in ('.pyc', '.pyo', '.nbi', '.nbc')}


def source_seal(source):
    manifest = source.parent / 'source-manifest.json'
    expected = read(manifest)
    assert inventory(source) == expected
    return dict(root=str(source), manifest_sha256=sha(manifest), files=expected)


def counts(report):
    assert report['exit_code'] in (None, 0) and not report['not_found'] and not report['batches'] and not report.get('batch_failures')
    result = {}
    for row in report['functions']:
        key = (str(Path(row.get('file', report['script'])).resolve()), row['function'], bool(row.get('region')))
        assert key not in result
        assert row['compiled_calls'] == row['aot_calls'] and row['jit_calls'] == row['fallback_calls'] == 0
        result[key] = row['aot_calls']
    assert sum(result.values()) == 20
    return result


def application_stderr(raw, report, source, codec):
    tree = ast.parse((source / 'recompyler/runner.py').read_text(encoding='utf-8-sig'))
    printer = next(n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name == 'print_run')
    namespace = {'sys': sys}
    exec(compile(ast.Module(body=[printer], type_ignores=[]), '<exact-frozen-print_run>', 'exec'), namespace)
    buffer = io.BytesIO()
    stream = io.TextIOWrapper(buffer, encoding=codec['encoding'], errors=codec['errors'], newline=None)
    try:
        with redirect_stderr(stream):
            namespace['print_run'](report)
        stream.flush()
        footer = buffer.getvalue()
    finally:
        stream.detach()
    assert footer and raw.endswith(footer), 'Unexpected saved CLI stderr boundary'
    return raw[:-len(footer)]


def plan_keys(plan):
    result = {}
    for kind in ('aot', 'aot_regions'):
        section = plan.get('plan', {}).get(kind)
        if section:
            result[kind] = dict(module=section['module'], functions=len(section['functions']),
                export_keys=sum(len(row.get('exports', {})) for row in section['functions']),
                seed_keys=sum(len(row.get('seeds', {})) for row in section['functions']))
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--lock-label', required=True)
    parser.add_argument('--integration-smoke', type=Path, default=D / 'integration-smoke20-v4')
    parser.add_argument('--integration-variant', required=True)
    parser.add_argument('--integrated-plan-root', type=Path, required=True)
    parser.add_argument('--reuse-coverage-cohort',type=Path)
    options = parser.parse_args()
    output, smoke = options.output.resolve(), options.integration_smoke.resolve()
    plan_root = options.integrated_plan_root.resolve()
    assert plan_root.is_relative_to(D)
    assert read(plan_root/'summary.json')['complete'] and not (plan_root/'FAILED.json').exists()
    assert read(D/'bases'/options.integration_variant/'complete.json')['complete']
    assert output.is_relative_to(D) and smoke.is_relative_to(D) and not output.exists()
    assert options.integration_variant and Path(options.integration_variant).name == options.integration_variant
    owner = (W / 'TIMING.lock/owner.txt').read_text(encoding='utf-8-sig')
    assert 'wave16-inplace' in owner and ('purpose: ' + options.lock_label + '\n') in owner
    output.mkdir()
    sources = dict(coverage=D / 'bases/coverage-frozen/src', integrated=D / 'bases' / options.integration_variant / 'src')
    seals = {mode: source_seal(source) for mode, source in sources.items()}
    helpers = {name: sha(D / name) for name in ('capture_profile_s23.py', 'capture_behavior.py', 'capture_audit.py', 'heldout_identity.py')}
    shim = smoke / 'shim'
    assert b'LOOPS = 20' in (shim / 'pyperf.py').read_bytes()
    immutable = dict(sources=seals, helpers=helpers, shim=inventory(shim), integrated_smoke=str(smoke), integrated_plan_root=str(plan_root))
    for name in ('chaos', 'richards_super'):
        folder = smoke / name
        integrated = plan_root / name / 'plan.json'
        immutable[name] = dict(input=inventory(folder / 'input'), plan_sha256=sha(integrated),
            artifacts={kind: inventory(Path(section['folder'])) for kind, section in read(integrated).get('plan', {}).items()
                       if kind in ('aot', 'aot_regions')})
    write(output / 'freeze.json', immutable)
    shared = os.environ.copy()
    shared.pop('PYTHONDONTWRITEBYTECODE', None)
    temporary = output / 'temp'
    temporary.mkdir()
    shared.update(PYTHONPYCACHEPREFIX=str(output / 'bytecode'), RECOMPYLER_CACHE=str(output / 'cache'),
        RECOMPYLER_CACHE_DIR=str(output / 'cache'), NUMBA_CACHE_DIR=str(output / 'numba'), TEMP=str(temporary), TMP=str(temporary),
        PYTHONHASHSEED='0', PYTHONWARNINGS='ignore', PYTHONIOENCODING='utf-8:strict', PYTHONUTF8='1',
        NUMBA_DISABLE_JIT='0', OMP_NUM_THREADS='1', OPENBLAS_NUM_THREADS='1', MKL_NUM_THREADS='1', NUMBA_NUM_THREADS='1')
    rows = []
    reuse=options.reuse_coverage_cohort.resolve() if options.reuse_coverage_cohort else None
    if reuse is not None:
        assert reuse.is_relative_to(D) and read(reuse/'summary.json')['complete'] and not (reuse/'FAILED.json').exists()
        assert read(reuse/'summary.json')['freeze_sha256']==sha(reuse/'freeze.json')
        assert read(D/'logs'/(reuse.name+'.receipt.json'))['exit_code']==0
        old_freeze=read(reuse/'freeze.json')
        reused_inputs={str(p):sha(p) for p in (reuse/'summary.json',reuse/'freeze.json',D/'logs'/(reuse.name+'.receipt.json'))}
        assert old_freeze['sources']['coverage']==seals['coverage']
        assert old_freeze['helpers']==helpers and old_freeze['shim']==inventory(shim)
        merged={}
        for name in ('chaos','richards_super'):
            assert read(reuse/name/'complete.json')['complete']
            for p in (reuse/name/'coverage-plan.json',Path(str(reuse/name/'coverage-plan.json')+'.application.stdout'),Path(str(reuse/name/'coverage-plan.json')+'.application.stderr')):
                reused_inputs[str(p)]=sha(p)
            for section in read(reuse/name/'plan-artifacts.json')['coverage'].values():
                record=merged.setdefault(section['root'],{})
                for relative,value in section['files'].items():
                    assert relative not in record or record[relative]==value
                    record[relative]=value
        assert all(inventory(Path(root))==files for root,files in merged.items())
        write(output/'coverage-reuse.json',dict(complete_reference=str(reuse),summary_sha256=sha(reuse/'summary.json'),artifact_union=merged,note='Only completed source/plan/artifacts reused; all audits and timing triples below are new.'))
    try:
        for name in ('chaos', 'richards_super'):
            folder = output / name
            folder.mkdir()
            old = smoke / name
            integrated_plan = plan_root / name / 'plan.json'
            script = Path(read(integrated_plan)['script']).resolve()
            assert script.is_relative_to(old / 'input')
            prior = read(old / 'saved-0.receipt.json')['command']
            arguments = prior[prior.index(str(script)) + 1:]
            expected = counts(read(old / 'counts-0.json'))
            envs = {mode: dict(shared, PYTHONPATH=os.pathsep.join([str(shim), str(source), str(D)])) for mode, source in sources.items()}
            def execute(label, command, mode):
                env = envs[mode]
                write(folder / (label + '.invocation.json'), dict(command=[str(v) for v in command], cwd=str(script.parent),
                    environment={key: env.get(key) for key in ('PYTHONPATH', 'PYTHONPYCACHEPREFIX', 'PYTHONDONTWRITEBYTECODE',
                        'RECOMPYLER_CACHE', 'RECOMPYLER_CACHE_DIR', 'NUMBA_CACHE_DIR', 'TEMP', 'TMP', 'PYTHONHASHSEED',
                        'PYTHONWARNINGS', 'PYTHONIOENCODING', 'PYTHONUTF8', 'NUMBA_DISABLE_JIT',
                        'OMP_NUM_THREADS', 'OPENBLAS_NUM_THREADS', 'MKL_NUM_THREADS', 'NUMBA_NUM_THREADS')}))
                started = time.perf_counter()
                with (folder / (label + '.stdout')).open('xb') as out, (folder / (label + '.stderr')).open('xb') as err:
                    child = subprocess.run([str(v) for v in command], cwd=script.parent, env=env, stdout=out, stderr=err)
                receipt = dict(exit_code=child.returncode, wall_s=time.perf_counter() - started)
                write(folder / (label + '.receipt.json'), receipt)
                assert child.returncode == 0, (name, label, receipt)
                return receipt
            # Probe under exactly the same pipe/stdio environment as all children.
            execute('stdio', [sys.executable, '-c', 'import json,sys;print(json.dumps(dict(encoding=sys.stderr.encoding,errors=sys.stderr.errors)))'], 'integrated')
            assert not (folder / 'stdio.stderr').read_bytes()
            codec = read(folder / 'stdio.stdout')
            if reuse is None:
                coverage_plan = folder / 'coverage-plan.json'
                execute('coverage-profile', [sys.executable, D / 'capture_profile_s23.py', script, coverage_plan, *arguments], 'coverage')
                metadata = extract(coverage_plan, folder / 'coverage-profile')
                assert metadata['exit_code'] == 0
            else:
                old_row=read(reuse/name/'complete.json')
                assert old_row['shared_script']==str(script) and old_row['arguments']==arguments
                assert old_freeze[name]['input']==inventory(old/'input')
                coverage_plan=reuse/name/'coverage-plan.json'
                assert read(reuse/name/'coverage-profile.receipt.json')['exit_code']==0
                assert read(Path(str(coverage_plan)+'.application.json'))['exit_code']==0
                write(folder/'coverage-plan-reference.json',dict(path=str(coverage_plan),sha256=sha(coverage_plan),completed_cohort_summary_sha256=sha(reuse/'summary.json')))
            app_out = Path(str(coverage_plan) + '.application.stdout').read_bytes()
            app_err = Path(str(coverage_plan) + '.application.stderr').read_bytes()
            plans = dict(coverage=coverage_plan, integrated=integrated_plan)
            plan_hashes={mode:sha(path) for mode,path in plans.items()}
            plan_artifacts = {}
            allowed = {}
            for mode, path in plans.items():
                sections = read(path).get('plan', {})
                plan_artifacts[mode], allowed[mode] = {}, set()
                for kind in ('aot', 'aot_regions'):
                    section = sections.get(kind)
                    if not section:
                        continue
                    artifact_root = Path(section['folder']).resolve()
                    assert artifact_root.is_relative_to(D)
                    files = inventory(artifact_root)
                    plan_artifacts[mode][kind] = dict(root=str(artifact_root), files=files)
                    for relative in files:
                        module = artifact_root / relative
                        if module.suffix not in ('.pyd', '.so', '.dll') or not module.name.startswith(section['module']):
                            continue
                        for entry in section['functions']:
                            for digest, symbol in entry['exports'].items():
                                allowed[mode].add((digest if kind == 'aot_regions' else entry['digest'], symbol, str(module)))
            write(folder / 'plan-artifacts.json', plan_artifacts)
            audits = {}
            # One independent untimed audit per source also populates each source's
            # owned bytecode before any timed triple, with one shared stdlib prefix.
            for mode in ('coverage', 'integrated'):
                audit_path = folder / (mode + '-audit.json')
                execute(mode + '-audit', [sys.executable, D / 'capture_audit.py', '--output', audit_path, '--plan', plans[mode], script, *arguments], mode)
                audit = read(audit_path)
                assert audit['audit_accounting_complete'] and audit['compiled_total_reconciles'] and audit['product_exact_counter_matches_audit']
                assert not audit['totals']['unknown_native_calls'] and not audit['numba_imported_after']
                assert counts(audit['runner_report']) == expected
                assert (folder / (mode + '-audit.stdout')).read_bytes() == app_out
                assert (folder / (mode + '-audit.stderr')).read_bytes() == app_err
                for loaded in audit['loaded_product_modules'].values():
                    path = Path(loaded['path']).resolve()
                    assert path.is_relative_to(sources[mode])
                    assert loaded['sha256'] == seals[mode]['files'][path.relative_to(sources[mode]).as_posix()]
                for function in audit['functions']:
                    for program in function['programs'].values():
                        for event in program.get('native_events', []):
                            assert (event['digest'], event['export'], event['module_path']) in allowed[mode]
                            root = next(value for value in plan_artifacts[mode].values() if Path(event['module_path']).is_relative_to(Path(value['root'])))
                            assert event['module_sha256'] == root['files'][Path(event['module_path']).relative_to(root['root']).as_posix()] == sha(event['module_path'])
                audits[mode] = audit
            triples = []
            for rep, order in enumerate((('plain', 'coverage', 'integrated'), ('coverage', 'integrated', 'plain'), ('integrated', 'plain', 'coverage'))):
                times = {}
                for mode in order:
                    label = mode + '-' + str(rep)
                    count_path = folder / (label + '.counts.json')
                    command = [sys.executable, script, *arguments] if mode == 'plain' else [sys.executable, '-m', 'recompyler', 'run', '--plan', plans[mode], '--json', count_path, script, *arguments]
                    times[mode] = execute(label, command, 'integrated' if mode == 'plain' else mode)['wall_s']
                    assert (folder / (label + '.stdout')).read_bytes() == app_out
                    stderr = (folder / (label + '.stderr')).read_bytes()
                    if mode != 'plain':
                        report = read(count_path)
                        assert counts(report) == counts(audits[mode]['runner_report']) == expected
                        stderr = application_stderr(stderr, report, sources[mode], codec)
                    assert stderr == app_err, (name, mode, 'Application stderr bytes differ')
                triples.append(dict(order=list(order), wall_s=times))
            for sections in plan_artifacts.values():
                assert all(inventory(Path(value['root'])) == value['files'] for value in sections.values())
            medians = {mode: statistics.median(row['wall_s'][mode] for row in triples) for mode in ('plain', 'coverage', 'integrated')}
            row = dict(name=name, complete=True, shared_script=str(script), arguments=arguments, triples=triples,
                medians_s=medians, plain_over_coverage=medians['plain']/medians['coverage'],
                plain_over_integrated=medians['plain']/medians['integrated'], integrated_over_coverage=medians['integrated']/medians['coverage'],
                exact_behavior=True, exact_aot_calls=20, jit_calls=0, fallback_calls=0,
                plan_key_counts={mode: plan_keys(read(path)) for mode, path in plans.items()},
                persisted_source_preparation_cache_key_count=len(read(integrated_plan)['plan']['aot_regions']['prepared']['cores']),
                cache_key_note='Sealed core count from the actual integrated plan; hits are proven separately by the fresh-process verifier, not inferred from timing.')
            assert all(sha(path)==plan_hashes[mode] for mode,path in plans.items())
            if reuse is not None: assert all(sha(path)==value for path,value in reused_inputs.items())
            write(folder / 'complete.json', row)
            rows.append(row)
            print(json.dumps(row), flush=True)
        if reuse is not None:
            assert all(inventory(Path(root))==files for root,files in merged.items())
            assert all(sha(path)==value for path,value in reused_inputs.items())
        assert {mode: source_seal(source) for mode, source in sources.items()} == seals
        assert {name: sha(D / name) for name in helpers} == helpers
        assert inventory(shim) == immutable['shim']
        for name in ('chaos', 'richards_super'):
            old = smoke / name
            assert inventory(old / 'input') == immutable[name]['input']
            assert sha(plan_root / name / 'plan.json') == immutable[name]['plan_sha256']
            assert {kind: inventory(Path(section['folder'])) for kind, section in read(plan_root / name / 'plan.json').get('plan', {}).items()
                    if kind in ('aot', 'aot_regions')} == immutable[name]['artifacts']
        write(output / 'summary.json', dict(schema='s31-matched-smoke-v1', complete=True, programs=rows,
            freeze_sha256=sha(output / 'freeze.json'), harness_sha256=sha(__file__), source_preparation_model_used=False,
            source_preparation_cache_counts='Actual sealed core counts and AOT export/seed counts are reported per plan; hit evidence is separate.'))
    except BaseException as exc:
        write(output / 'FAILED.json', dict(exception_type=type(exc).__name__, aggregate_eligible=False))
        raise


if __name__ == '__main__':
    main()
