"""Explicit warm-kernel diagnostics and separate, untimed native-mode audits."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import sys

import compare_native as study

HERE = Path(__file__).resolve().parent


def context():
    paired = json.loads(Path(os.environ['RECOMPYLER_PAIRED_MANIFEST']).read_text())
    source = Path(os.environ.get('RECOMPYLER_NATIVE_SOURCE', study.ROOT / 'integration'))
    measured = json.loads((HERE / 'measured-source.json').read_text())
    head = subprocess.check_output(['git', '-C', str(source), 'rev-parse', 'HEAD'], text=True).strip()
    files = {str(p.relative_to(source / 'src')): study.sha(p)
             for p in sorted((source / 'src').rglob('*')) if p.is_file() and '__pycache__' not in p.parts}
    if head != measured['git_head'] or files != measured['source_sha256']:
        raise RuntimeError('Frozen native diagnostic source changed')
    for key, filename in [('harness_sha256', 'compare_native.py'), ('audit_sha256', 'audit_native.py'), ('extra_sha256', 'extra_native.py')]:
        if measured[key] != study.sha(HERE / filename):
            raise RuntimeError('Frozen native diagnostic helper changed: ' + filename)
    if measured['paired_manifest_sha256'] != study.sha(Path(os.environ['RECOMPYLER_PAIRED_MANIFEST'])):
        raise RuntimeError('Frozen paired environment manifest changed')
    manifest = json.loads((HERE / 'manifest.json').read_text())
    for row in manifest['programs'].values():
        for key in ('source', 'binary', 'script'):
            if study.sha(row[key]) != row[key + '_sha256']:
                raise RuntimeError('Changed native diagnostic input: ' + row[key])
    env = dict(paired['execution_environment'])
    paired_dir = Path(os.environ['RECOMPYLER_PAIRED_MANIFEST']).parent
    env.update(PYTHONPATH=os.pathsep.join([str(paired_dir / 'shim'), str(source / 'src')]),
               RECOMPYLER_CACHE=str(HERE / 'cache'), NUMBA_CACHE_DIR=str(HERE / 'cache/numba'),
               TEMP=str(HERE / 'temp'), TMP=str(HERE / 'temp'), PYTHONHASHSEED='0',
               PYTHONWARNINGS='ignore', PYTHONDONTWRITEBYTECODE='1',
               PYTHONPYCACHEPREFIX=str(HERE / 'bytecode'))
    return study.harness(), manifest, env


def warm():
    harness, manifest, env = context()
    results = {}
    for name in ('spectral_norm', 'richards', 'scimark'):
        plan = HERE / (name + '.plan.json')
        if not plan.exists():
            results[name] = {'status': 'missing profile'}
            continue
        data = json.loads(plan.read_text())
        selected = []
        for row in data.get('functions', []):
            candidate = row.get('candidate', {})
            accepted = candidate.get('status') == 'verified' and (candidate.get('speedup') or 0) > 1.05
            candidate['recommended'] = accepted
            if accepted:
                selected.append([row['function'], row['line']])
        data.setdefault('plan', {})['worth_running'] = True
        data['explicit_warm_diagnostic'] = 'Select verified candidates above 1.05x; force permits JIT. Not a default deployment result.'
        chosen = HERE / (name + '.warm-diagnostic.plan.json')
        study.save(chosen, data)
        label = name + '-warm-diagnostic'
        run = study.execute(label, [sys.executable, '-m', 'recompyler', 'run', '--force', '--plan', str(chosen),
                                   '--json', str(HERE / (label + '.counts.json')),
                                   manifest['programs'][name]['script'], '5'], env, HERE)
        checks, seconds = harness.parse(run['stdout']) if run['exit_code'] == 0 else ({}, {})
        reference, _ = harness.parse((HERE / (name + '-python.stdout')).read_text())
        results[name] = dict(exit_code=run['exit_code'], selected=selected, kernel_best_s=seconds,
                             process_wall_s=run['wall_s'], checks_match_python=bool(reference) and study.checks_equal(reference, checks))
        study.save(HERE / 'warm-diagnostic-results.json', results)
        print(name, results[name], flush=True)


def audit():
    harness, manifest, env = context()
    results = {}
    for name, row in manifest['programs'].items():
        reference, _ = harness.parse((HERE / (name + '-python.stdout')).read_text())
        for mode in ('default', 'forced', 'warm-diagnostic'):
            plan = HERE / (name + ('.warm-diagnostic.plan.json' if mode == 'warm-diagnostic' else '.plan.json'))
            if not plan.exists() or not (HERE / (name + '-' + mode + '.json')).exists():
                continue
            label = name + '-' + mode + '-audit'
            payload = HERE / (label + '.payload.json')
            command = [sys.executable, str(HERE / 'audit_native.py'), '--output', str(payload), '--plan', str(plan)]
            if mode != 'default':
                command.append('--force')
            command += [row['script'], '5']
            run = study.execute(label, command, env, HERE)
            checks, _ = harness.parse(run['stdout']) if run['exit_code'] == 0 else ({}, {})
            evidence = json.loads(payload.read_text()) if payload.exists() else {}
            result = dict(exit_code=run['exit_code'], checks_match_python=bool(reference) and study.checks_equal(reference, checks),
                          totals=evidence.get('totals'), compiled_total_reconciles=evidence.get('compiled_total_reconciles'),
                          product_exact_counter_matches_audit=evidence.get('product_exact_counter_matches_audit'),
                          numba_imported_after=evidence.get('numba_imported_after'), timing_eligible=False)
            results[name + '/' + mode] = result
            study.save(HERE / 'native-mode-audits.json', results)
            print(name, mode, result, flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('mode', choices=['warm', 'audit'])
    args = parser.parse_args()
    (warm if args.mode == 'warm' else audit)()
