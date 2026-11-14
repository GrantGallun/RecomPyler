"""Independently verify completed full-population records, never run workloads."""
import hashlib
import json
import math
import statistics
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
OUT = Path(sys.argv[1]).resolve()
HELPER_ROOT = Path(sys.argv[2]).resolve() if len(sys.argv) > 2 else OUT.parent
MANIFEST = json.loads((OUT / 'manifest.json').read_text())
VARIANTS = MANIFEST['source_order']
ROWS = []
PROCESSES = []


def read(path):
    return json.loads(path.read_text())


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def process(stem):
    data = read(stem.with_suffix('.json'))
    assert data['status'] == 'ok' and data['exit_code'] == 0, (stem, data['status'], data['exit_code'])
    for suffix in ('stdout', 'stderr'):
        path = stem.with_suffix('.' + suffix)
        assert sha(path) == data[suffix + '_sha256'], path
        assert path.stat().st_size == data[suffix + '_bytes'], path
    PROCESSES.append(str(stem.relative_to(OUT)))
    return data


assert len(MANIFEST['workloads']) == 2
assert (MANIFEST['limit'], MANIFEST['samples'], MANIFEST['repetitions'], MANIFEST['audit_repetitions'], MANIFEST['shim_loops'], MANIFEST['timeout_s']) == (40,8,5,5,2,180)
for name, digest in MANIFEST['helpers'].items():
    assert sha(HELPER_ROOT / name) == digest, name
for source in MANIFEST['sources'].values():
    base = Path(source['path']) / 'src'
    actual = {p.relative_to(base).as_posix(): sha(p) for p in sorted(base.rglob('*'))
              if p.is_file() and '__pycache__' not in p.parts and p.suffix not in {'.pyc', '.pyo'}}
    assert actual == source['src_sha256']
    for name, digest in source['src_sha256'].items():
        assert sha(Path(source['path']) / 'src' / name) == digest, name
excluded = {'__pycache__', '.venv', '.git', 'results', '.pytest_cache'}
for workload in MANIFEST['workloads']:
    folder = Path(workload['cwd'])
    actual = {p.relative_to(folder).as_posix(): sha(p) for p in sorted(folder.rglob('*'))
              if p.is_file() and not any(part in excluded for part in p.relative_to(folder).parts)
              and p.suffix not in {'.pyc', '.pyo'}
              and (workload['inventory_kind'] == 'corpus' or p.suffix in {'.py', '.pyd', '.dll', '.so'}
                   or 'models' in p.relative_to(folder).parts)}
    assert actual == workload['input_sha256'], workload['name']
for variant in VARIANTS:
    process(OUT / f'{variant}-native-preflight')

for workload in MANIFEST['workloads']:
    directory = OUT / 'programs' / workload['name']
    process(directory / 'bytecode-before-profiles')
    process(directory / 'bytecode-before-timing')
    for path, digest in read(directory / 'aot-artifacts-frozen.json').items():
        assert sha(Path(path)) == digest, path
    expected_bytecode = read(directory / 'bytecode-frozen.json')
    actual_bytecode = {p.relative_to(OUT / 'bytecode' / workload['name']).as_posix():sha(p)
                       for p in sorted((OUT / 'bytecode' / workload['name']).rglob('*.pyc'))}
    assert actual_bytecode == expected_bytecode, workload['name']
    plain = [process(directory / f'plain-{i}') for i in range(5)]
    assert len({(p['stdout_sha256'],p['stdout_bytes'],p['exit_code']) for p in plain}) == 1, workload['name']
    plain_median = statistics.median(p['wall_s'] for p in plain)
    row = {'name': workload['name'], 'group': workload['group'], 'meaningful':workload['meaningful_work'],
           'plain_median_s':plain_median}
    for variant in VARIANTS:
        profile = process(directory / f'{variant}-profile')
        plan = read(directory / f'{variant}.plan.json')
        process(directory / f'{variant}-deployment-preflight')
        deployment = read(directory / f'{variant}-deployment-preflight.audit.json')
        assert deployment['compiled_total_reconciles']
        assert deployment['totals']['unknown_native_calls'] == 0
        if plan.get('plan', {}).get('worth_running'):
            selected = [r for r in deployment['functions'] if r['function'] == MANIFEST['deployment_preflight_entry']]
            assert selected and sum(r['aot_calls'] for r in selected) > 0
            assert all(deployment['totals'][k] == 0 for k in ('jit_calls', 'fallback_calls', 'rejected_attempts'))
        timed = [process(directory / f'{variant}-{i}') for i in range(5)]
        assert all((p['stdout_sha256'],p['stdout_bytes'],p['exit_code']) ==
                   (plain[0]['stdout_sha256'],plain[0]['stdout_bytes'],0) for p in timed), (workload['name'],variant)
        totals = {key:0 for key in ('compiled_calls','aot_calls','jit_calls','fallback_calls')}
        statuses = []
        for i in range(5):
            counts = read(directory / f'{variant}-{i}.counts.json')
            assert not counts.get('batches'), 'Batch execution requires separate mode proof.'
            for fn in counts['functions']:
                assert fn['aot_calls'] + fn['jit_calls'] == fn['compiled_calls'], fn
                for key in totals:
                    totals[key] += fn[key]
            statuses.append('native' if any(f['compiled_calls'] for f in counts['functions']) else
                            'fallback' if any(f['fallback_calls'] for f in counts['functions']) else
                            'uncalled' if counts['functions'] else 'not_found' if counts['not_found'] else 'unselected')
        audit_totals = {key:0 for key in ('aot_calls','jit_calls','fallback_calls','unknown_native_calls','rejected_attempts')}
        audit_native = []
        for i in range(5):
            p = process(directory / f'{variant}-audit-{i}')
            assert (p['stdout_sha256'],p['stdout_bytes'],p['exit_code']) == (plain[0]['stdout_sha256'],plain[0]['stdout_bytes'],0)
            audit = read(directory / f'{variant}-{i}.audit.json')
            assert audit['compiled_total_reconciles'] and audit['product_exact_counter_matches_audit']
            assert audit['totals']['unknown_native_calls'] == 0
            assert not audit.get('batch_execution_needs_separate_audit')
            assert audit['runner_only_fallback_calls'] >= 0
            for key in audit_totals:
                audit_totals[key] += audit['totals'].get(key,0)
            audit_native.append(audit['totals']['aot_calls'] + audit['totals']['jit_calls'])
        native_median = statistics.median(p['wall_s'] for p in timed)
        row[variant] = {'median_s':native_median,'speed_vs_python':plain_median/native_median,
                        'timing_modes':totals,'timing_statuses':statuses,'audit_totals':audit_totals,
                        'audit_native_by_repetition':audit_native,'profile_wall_s':profile['wall_s'],
                        'recommended_functions':sum(bool(r.get('candidate',{}).get('recommended')) for r in plan.get('functions',[]))}
    ROWS.append(row)

groups = {}
for group, expected in [('heldout',1),('diagnostic',1)]:
    rows = [r for r in ROWS if r['group'] == group]
    assert len(rows) == expected
    meaningful = [r for r in rows if r['meaningful']]
    if group == 'heldout':
        assert len(meaningful) == 1
    groups[group] = {'fixed_population':len(rows),'meaningful_pairs':len(meaningful)}
    for variant in VARIANTS:
        groups[group][variant] = {
            'speed_vs_python_geomean':math.exp(statistics.mean(math.log(r[variant]['speed_vs_python']) for r in meaningful)),
            'timed_native_programs':sum(r[variant]['timing_modes']['compiled_calls']>0 for r in rows),
            'timing_modes':{key:sum(r[variant]['timing_modes'][key] for r in rows) for key in ('compiled_calls','aot_calls','jit_calls','fallback_calls')},
            'audit_native_programs_by_repetition':[sum(r[variant]['audit_native_by_repetition'][i]>0 for r in rows) for i in range(5)]}

expected_processes = len(VARIANTS) + 2*(2+2*len(VARIANTS)+5*(1+len(VARIANTS))+5*len(VARIANTS))
assert len(PROCESSES) == expected_processes
summary = read(OUT / 'summary.json')
for group, values in groups.items():
    assert summary['groups'][group]['fixed_population'] == values['fixed_population']
    for variant in VARIANTS:
        # Check the published geomean against raw independent calculation.
        reported = summary['groups'][group][variant]['process_speedup_geomean_paired']
        assert math.isclose(reported, values[variant]['speed_vs_python_geomean'],rel_tol=1e-12)

receipt = {'all_verified':True,'manifest_sha256':sha(OUT/'manifest.json'),'successful_process_records':len(PROCESSES),
           'groups':groups,'rows':ROWS,'note':'Complete successful cohort only. Raw output/exit/hash/bytecode/artifact/mode verification; no workload executed. Empty stdout is not full semantic equivalence.'}
path = ROOT / 'wave10-root-coverage-verification.json'
path.write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf8')
print(json.dumps({k:v for k,v in receipt.items() if k!='rows'},indent=2))
