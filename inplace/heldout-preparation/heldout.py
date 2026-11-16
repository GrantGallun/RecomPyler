"""Owned held-out acceptance preparation; no workload runs during prepare."""
import sys
sys.dont_write_bytecode = True
import argparse, ast, hashlib, io, json, os, runpy, shutil, subprocess, time, types
from contextlib import redirect_stderr
from pathlib import Path

HERE = Path(__file__).resolve().parent
CLONE = HERE.parents[1]
WORKSPACE = CLONE.parent
OLD = WORKSPACE / 'wave14-capture'
STAGES = HERE / 'stages'
SMOKE = ('chaos', 'richards_super')
SIX = {'chaos': {'Chaosgame.transform_point'},
       'gc_collect': {'create_cycle', 'create_gc_cycles'},
       'hexiom': {'Hex.link_nodes'},
       'richards_super': {'DeviceTask.fn', 'Task.qpkt'}}
HELPERS = ('capture_profile_s23.py', 'capture_behavior.py', 'capture_audit.py',
           'capture_warm.py', 'capture_preflight.py', 'capture_common.py', 'phase_child.py', 'heldout_identity.py')
WARNING_STDIO_KEYS = ('PYTHONWARNINGS', 'PYTHONIOENCODING', 'PYTHONUTF8', 'PYTHONCOERCECLOCALE',
    'PYTHONLEGACYWINDOWSSTDIO', 'PYTHONLEGACYWINDOWSFSENCODING', 'LANG', 'LC_ALL', 'LC_CTYPE')


def read(path):
    return json.loads(Path(path).read_text(encoding='utf-8-sig'))


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def write(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open('x', encoding='utf-8') as stream:
        json.dump(value, stream, indent=2, sort_keys=True, allow_nan=False)
        stream.write('\n')


def inventory(root, excluded=()):
    return {p.relative_to(root).as_posix(): sha(p) for p in sorted(root.rglob('*'))
            if p.is_file() and not any(x in excluded for x in p.relative_to(root).parts)}


def module(path):
    # Load only copied study helpers, without creating parent-process pycache.
    value = types.ModuleType('_heldout_' + path.stem)
    value.__file__ = str(path)
    exec(compile(path.read_text(encoding='utf-8-sig'), str(path), 'exec'), value.__dict__)
    return value


def stage_path(name):
    assert name and Path(name).name == name and name not in ('.', '..')
    path = (STAGES / name).resolve()
    assert path.parent == STAGES.resolve()
    return path


def prepare(options):
    stage, source = stage_path(options.name), options.source.resolve()
    assert source.is_relative_to(CLONE.resolve()), 'Snapshot only owned wave16 source'
    assert (source / 'src/recompyler/profiler.py').is_file()
    historical = OLD / 'capture/s19-realistic-length3'
    accepted = read(historical / 'complete.json')
    assert accepted['accepted'] and accepted['completed_programs'] == accepted['eligible_programs'] == 33
    assert sha(historical / 'summary.json') == accepted['summary_sha256']
    previous = read(historical / 'summary.json')
    eligible = previous['eligible_programs']
    assert len(eligible) == len(set(eligible)) == 33 and previous['complete']
    manifest = read(OLD / 'capture/input-manifest.json')
    stage.mkdir(parents=True, exist_ok=False)
    shutil.copytree(source / 'src', stage / 'src', ignore=shutil.ignore_patterns(
        '__pycache__', '*.pyc', '*.pyo', '*.nbc', '*.nbi', 'cache', 'artifacts', 'build'))
    tools = stage / 'tools'
    tools.mkdir()
    provenance = {}
    for name in HELPERS:
        origin = (HERE / name if name == 'phase_child.py' else CLONE / 'inplace' / name
                  if name in ('capture_profile_s23.py', 'capture_behavior.py', 'capture_audit.py', 'heldout_identity.py') else OLD / name)
        shutil.copyfile(origin, tools / name)
        provenance[str(origin)] = sha(origin)
    origin = CLONE / 'inplace/trivial_bench.py'
    shutil.copyfile(origin, tools / origin.name)
    provenance[str(origin)] = sha(origin)
    warning_stdio = None
    environment_evidence = {}
    for name in eligible:
        for mode in ('behavior-plain', 'profile', 'plain-0', 'saved-0', 'audit'):
            invocation = historical / name / (mode + '.invocation.json')
            policy = {k: read(invocation)['environment'].get(k) for k in WARNING_STDIO_KEYS}
            if warning_stdio is None:
                warning_stdio = policy
            assert policy == warning_stdio, ('Historical stdio/warning policy varies', invocation)
            environment_evidence[str(invocation)] = sha(invocation)
    assert warning_stdio['PYTHONWARNINGS'] == 'ignore'
    assert len(options.rule_counter) == len(set(options.rule_counter))
    assert all(n.isidentifier() and not n.startswith('_') for n in options.rule_counter)
    workloads = []
    for old in manifest['workloads']:
        if old['name'] not in eligible:
            continue
        assert not old['include'], 'Explicitly remap widened origins first'
        original = Path(old['cwd']).resolve()
        target = stage / 'inputs' / old['name']
        target.mkdir(parents=True)
        for relative, digest in old['inputs'].items():
            origin, destination = (original / relative).resolve(), (target / relative).resolve()
            assert origin.is_relative_to(original) and destination.is_relative_to(target.resolve())
            assert sha(origin) == digest, ('Historical input changed', origin)
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(origin, destination)
        script = target / Path(old['script']).resolve().relative_to(original)
        assert script.is_file() and sha(script) == sha(old['script'])
        arguments = [str(target) + arg[len(str(original)):] if arg.startswith(str(original)) else arg for arg in old['args']]
        workloads.append(dict(old, cwd=str(target), script=str(script), args=arguments))
    assert {w['name'] for w in workloads} == set(eligible)
    for loops in (2, 20):
        shim = stage / 'inputs' / ('shim' + str(loops))
        shim.mkdir()
        for relative, digest in manifest['shim'].items():
            origin = OLD / 'capture/inputs/shim' / relative
            assert sha(origin) == digest
            destination = shim / relative
            assert destination.resolve().is_relative_to(shim.resolve())
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(origin, destination)
        if loops == 20:
            path = shim / 'pyperf.py'
            data = path.read_bytes()
            assert data.count(b'LOOPS = 2\n') + data.count(b'LOOPS = 2\r\n') == 1
            path.write_bytes(data.replace(b'LOOPS = 2', b'LOOPS = 20'))
    # Reuse the historical diagnostic unchanged, with owned data dependencies.
    write(tools / 'capture/input-manifest.json', dict(manifest, workloads=workloads))
    for name, wanted in SIX.items():
        old = read(OLD / 'capture/base' / name / 'plan.json')
        rows = [r for r in old['functions'] if r.get('qualname', r['function']) in wanted]
        assert {r.get('qualname', r['function']) for r in rows} == wanted
        assert all(r['candidate']['status'] == 'verified' and r['candidate']['engine'] == 'region' for r in rows)
        workload = next(w for w in workloads if w['name'] == name)
        original_workload = next(w for w in manifest['workloads'] if w['name'] == name)
        remapped = []
        for row in rows:
            original_file = Path(row.get('file', old['script'])).resolve()
            original_cwd = Path(original_workload['cwd']).resolve()
            file = (Path(workload['cwd']) / original_file.relative_to(original_cwd)
                    if original_file.is_relative_to(original_cwd) else original_file)
            remapped.append(dict(row, file=str(file)))
        write(tools / 'capture/base' / name / 'plan.json', dict(old, script=workload['script'], functions=remapped))
    common = module(tools / 'capture_common.py')
    frozen = dict(schema='wave16-heldout-prepared-v1', stage=options.name,
        harness_sha256=sha(__file__), source_origin=str(source), source=inventory(stage / 'src'),
        tools=inventory(tools), inputs=inventory(stage / 'inputs'), workloads=workloads, eligible=eligible,
        six={k: sorted(v) for k, v in SIX.items()}, helper_origins=provenance,
        runtime=common.runtime_identity(), environment=read(historical / 'freeze.json')['environment'],
        warning_stdio=warning_stdio, effective_environment_evidence=environment_evidence,
        rule_counters=options.rule_counter,
        baseline_summary_sha256=sha(historical / 'summary.json'),
        baseline_programs_deploying=sum(bool(r['unique_compiled_functions']) for r in previous['rows']),
        coordination_helper_sha256=sha(CLONE / 'inplace/run_locked.py'),
        loops=20, selection_force=False, profile_limit=128, samples=8)
    write(stage / 'freeze.json', frozen)
    print('PREPARED', stage, flush=True)


def verify(stage, frozen, runtime=False):
    assert not (stage / 'FAILED.json').exists(), 'Preserve failed stage; prepare a new stage'
    assert frozen['harness_sha256'] == sha(__file__), 'Harness changed; prepare a new stage'
    assert inventory(stage / 'src') == frozen['source'], 'Source snapshot changed'
    assert inventory(stage / 'tools') == frozen['tools'], 'Frozen helpers changed'
    assert inventory(stage / 'inputs') == frozen['inputs'], 'Owned inputs changed'
    assert sha(CLONE / 'inplace/run_locked.py') == frozen['coordination_helper_sha256']
    if runtime:
        assert module(stage / 'tools/capture_common.py').runtime_identity() == frozen['runtime']


def lock(label):
    owner = (WORKSPACE / 'TIMING.lock/owner.txt').read_text(encoding='utf-8-sig')
    assert 'wave16-inplace' in owner and ('purpose: ' + label + '\n') in owner, 'Use external run_locked with this exact label'


def environment(stage, frozen, name, cwd, loops=20):
    root = stage / 'runs' / name
    temporary = root / 'temp'
    temporary.mkdir(parents=True, exist_ok=True)
    env = dict(frozen['environment'])
    env.pop('PYTHONDONTWRITEBYTECODE', None)
    env.update(PYTHONPATH=os.pathsep.join([str(stage / 'inputs' / ('shim' + str(loops))), str(stage / 'src'), str(stage / 'tools')]),
        PYTHONPYCACHEPREFIX=str(root / 'bytecode'), PYTHONHASHSEED='0',
        RECOMPYLER_CACHE=str(root / 'cache'), RECOMPYLER_CACHE_DIR=str(root / 'cache'),
        NUMBA_CACHE_DIR=str(root / 'numba'), MPLCONFIGDIR=str(root / 'matplotlib'),
        TEMP=str(temporary), TMP=str(temporary), OMP_NUM_THREADS='1', NUMBA_NUM_THREADS='1',
        OPENBLAS_NUM_THREADS='1', MKL_NUM_THREADS='1', POKER_BOT=str(cwd),
        POKER_COUNTER_MODEL=str(Path(cwd) / 'models/response_policy.json'))
    for key, value in frozen['warning_stdio'].items():
        if value is None:
            env.pop(key, None)
        else:
            env[key] = value
    assert {k: env.get(k) for k in WARNING_STDIO_KEYS} == frozen['warning_stdio']
    return env


def execute(stage, label, directory, name, command, cwd, env):
    lock(label)
    assert {k: env.get(k) for k in WARNING_STDIO_KEYS} == read(stage / 'freeze.json')['warning_stdio']
    stem = directory / name
    write(Path(str(stem) + '.invocation.json'), dict(command=[str(x) for x in command], cwd=str(cwd), environment=env))
    start = time.perf_counter()
    with Path(str(stem) + '.stdout').open('xb') as out, Path(str(stem) + '.stderr').open('xb') as err:
        process = subprocess.run([str(x) for x in command], cwd=cwd, env=env, stdout=out, stderr=err)
    write(Path(str(stem) + '.receipt.json'), dict(exit_code=process.returncode,
        wall_s=time.perf_counter() - start, timing_eligible=False,
        stdout_sha256=sha(Path(str(stem) + '.stdout')), stderr_sha256=sha(Path(str(stem) + '.stderr'))))
    assert process.returncode == 0, ('Incomplete child; preserve stage', stem)


def count_identity(report, plan, identities):
    assert report['exit_code'] in (None, 0) and not report['not_found'] and not report['batches'] and not report.get('batch_failures')
    rows = {}
    for row in identities.product_functions(report, plan):
        assert row['aot_calls'] + row['jit_calls'] == row['compiled_calls']
        key = (*identities.key(row), bool(row.get('region')))
        assert key not in rows, ('Ambiguous counter identity', key)
        rows[key] = (row['aot_calls'], row['jit_calls'], row['fallback_calls'])
    return rows


def saved_stderr(stage, directory, report, stdio):
    path = stage / 'src/recompyler/runner.py'
    tree = ast.parse(path.read_text(encoding='utf-8-sig'))
    printers = [n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name == 'print_run']
    assert len(printers) == 1 and not printers[0].decorator_list
    namespace = {'sys': sys}
    exec(compile(ast.Module(body=printers, type_ignores=[]), str(path), 'exec'), namespace)
    buffer = io.BytesIO()
    stream = io.TextIOWrapper(buffer, encoding=stdio['encoding'], errors=stdio['errors'], newline=None)
    try:
        with redirect_stderr(stream):
            namespace['print_run'](report)
        stream.flush()
        banner = buffer.getvalue()
    finally:
        stream.detach()
    raw = (directory / 'saved.stderr').read_bytes()
    assert banner and raw.endswith(banner), 'Unexpected CLI stderr suffix'
    application = raw[:-len(banner)]
    (directory / 'saved.application.stderr').write_bytes(application)
    write(directory / 'stderr-boundary.json', dict(runner_sha256=sha(path), encoding=stdio,
        suffix_sha256=hashlib.sha256(banner).hexdigest(), suffix_bytes=len(banner),
        application_sha256=hashlib.sha256(application).hexdigest()))
    return application


def evidence(directory):
    return {k: v for k, v in inventory(directory, ('cache', 'numba', 'bytecode', 'temp', 'matplotlib')).items() if k != 'complete.json'}


def completed(directory, stage):
    assert not (stage / 'FAILED.json').exists()
    done = read(directory / 'complete.json')
    assert done['accepted'] and done['freeze_sha256'] == sha(stage / 'freeze.json')
    assert done['evidence'] == evidence(directory)
    assert all(sha(path) == digest for path, digest in done.get('artifacts', {}).items())
    return done['row']


def preflight(stage, frozen, label):
    destination = stage / 'preflight-complete.json'
    if destination.exists():
        receipt = read(destination)
        assert receipt['freeze_sha256'] == sha(stage / 'freeze.json')
        assert receipt['evidence'] == inventory(stage / 'preflight')
        return
    directory = stage / 'preflight'
    directory.mkdir(exist_ok=False)
    env = environment(stage, frozen, '_preflight', stage)
    execute(stage, label, directory, 'native', [sys.executable, stage / 'tools/capture_preflight.py', stage], stage, env)
    report = json.loads((directory / 'native.stdout').read_text(encoding='utf-8'))
    for item in report['extensions'].values():
        assert Path(item['path']).resolve().is_relative_to(stage / 'src')
    execute(stage, label, directory, 'stdio', [sys.executable, '-c',
        "import sys,json;print(json.dumps(dict(encoding=sys.stderr.encoding,errors=sys.stderr.errors,warning_options=sys.warnoptions,utf8_mode=sys.flags.utf8_mode)))"], stage, env)
    assert not (directory / 'stdio.stderr').read_bytes()
    assert json.loads((directory / 'stdio.stdout').read_text(encoding='utf-8'))['warning_options'] == ['ignore']
    write(destination, dict(freeze_sha256=sha(stage / 'freeze.json'), evidence=inventory(directory)))


def selection(stage, frozen, options):
    preflight(stage, frozen, options.lock_label)
    smoke_receipt = stage / 'smoke-complete.json'
    if options.scope == 'full':
        smoke = read(smoke_receipt)
        assert smoke['freeze_sha256'] == sha(stage / 'freeze.json') and smoke['accepted']
        assert smoke['program_receipts'] == {n: sha(stage / 'selection' / n / 'complete.json') for n in SMOKE}
    wanted = set(SMOKE if options.scope == 'smoke' else frozen['eligible'])
    stdio = json.loads((stage / 'preflight/stdio.stdout').read_text(encoding='utf-8'))
    behavior = module(stage / 'tools/capture_behavior.py')
    identities = module(stage / 'tools/heldout_identity.py')
    for workload in frozen['workloads']:
        name = workload['name']
        if name not in wanted:
            continue
        directory = stage / 'selection' / name
        if directory.exists():
            completed(directory, stage)
            continue
        directory.mkdir(parents=True, exist_ok=False)
        verify(stage, frozen)
        script, cwd = Path(workload['script']), Path(workload['cwd'])
        env = environment(stage, frozen, name, cwd)
        def child(label, command):
            execute(stage, options.lock_label, directory, label, command, cwd, env)
        child('bytecode', [sys.executable, stage / 'tools/capture_warm.py', stage / 'src', stage / 'tools', stage / 'inputs/shim20', cwd])
        child('plain', [sys.executable, script, *workload['args']])
        plan = directory / 'plan.json'
        child('profile', [sys.executable, stage / 'tools/capture_profile_s23.py', script, plan, *workload['args']])
        meta = behavior.extract(plan, directory / 'profile')
        assert meta['exit_code'] == 0 and meta['exception'] is None
        for suffix in ('stdout', 'stderr'):
            assert Path(str(plan) + '.application.' + suffix).read_bytes() == (directory / ('plain.' + suffix)).read_bytes(), ('Profiling changed application bytes', name, suffix)
        report, artifacts = read(plan), {}
        for kind in ('aot', 'aot_regions'):
            section = report.get('plan', {}).get(kind)
            if section:
                folder = Path(section['folder']).resolve()
                assert folder.is_relative_to(stage)
                paths = [p for p in folder.glob(section['module'] + '*') if p.suffix in ('.pyd', '.so', '.dll')]
                assert paths, ('Missing AOT artifact', kind)
                artifacts.update({str(p): sha(p) for p in paths})
        counts = directory / 'saved.counts.json'
        child('saved', [sys.executable, '-m', 'recompyler', 'run', '--plan', plan, '--json', counts, script, *workload['args']])
        saved = read(counts)
        identity = count_identity(saved, report, identities)
        saved_functions = identities.product_functions(saved, report)
        assert (directory / 'saved.stdout').read_bytes() == (directory / 'plain.stdout').read_bytes()
        assert saved_stderr(stage, directory, saved, stdio) == (directory / 'plain.stderr').read_bytes()
        audit_path = directory / 'audit.json'
        rule_args = [arg for name in frozen['rule_counters'] for arg in ('--rule-counter', name)]
        child('audit', [sys.executable, stage / 'tools/capture_audit.py', '--output', audit_path, '--plan', plan, *rule_args, script, *workload['args']])
        audit = read(audit_path)
        assert audit['compiled_total_reconciles'] and audit['product_exact_counter_matches_audit'] is True
        assert not audit['totals']['unknown_native_calls'] and not audit['batch_execution_needs_separate_audit']
        assert audit['runner_only_fallback_calls'] >= 0 and identity == count_identity(audit['runner_report'], report, identities)
        assert audit['per_function_native_matches_product']
        assert identities.native_reconciles(saved_functions, audit['independent_functions']), 'Saved native counts differ from independent per-function observations'
        for loaded in audit['loaded_product_modules'].values():
            loaded_path = Path(loaded['path']).resolve()
            assert loaded_path.is_relative_to(stage / 'src')
            assert frozen['source'][loaded_path.relative_to(stage / 'src').as_posix()] == loaded['sha256'] == sha(loaded_path)
        canonical_artifacts = {identities.canonical_file(path): digest for path, digest in artifacts.items()}
        for observed in audit['independent_functions']:
            for program_record in observed['programs'].values():
                for event in program_record.get('native_events', []):
                    if event['mode'] == 'aot':
                        assert event['module_path'], 'Observed AOT entry has no loaded module identity'
                        assert canonical_artifacts[identities.canonical_file(event['module_path'])] == event['module_sha256'] == sha(event['module_path'])
        for suffix in ('stdout', 'stderr'):
            assert (directory / ('audit.' + suffix)).read_bytes() == (directory / ('plain.' + suffix)).read_bytes()
        assert all(sha(path) == digest for path, digest in artifacts.items())
        verify(stage, frozen)
        inventory_rows = read(directory / 'plan.inventory.json')['capture_inventory']
        verified = [r for r in report['functions'] if r.get('candidate', {}).get('status') == 'verified']
        deployed = [r for r in saved_functions if r['aot_calls'] + r['jit_calls'] > 0]
        row = dict(name=name, accepted=True, behavior_byte_exact=True,
            captured=sum(bool(r['captured']) for r in inventory_rows), verified=len(verified), deployed=len(deployed),
            verified_regions=sum(r['candidate'].get('engine') == 'region' for r in verified),
            deployed_regions=sum(bool(r.get('region')) for r in deployed),
            deployed_functions=deployed, observed_functions=saved_functions,
            independent_functions=audit['independent_functions'], loaded_product_modules=audit['loaded_product_modules'],
            ordinary_gate=report.get('plan', {}).get('worth_running', False),
            candidates=[dict({k: r[k] for k in ('function', 'line', 'candidate') if k in r},
                qualname=r.get('qualname', r['function']), file=identities.canonical_file(r.get('file', report['script'])),
                canonical_file=identities.canonical_file(r.get('file', report['script']))) for r in report['functions']],
            captured_inventory=inventory_rows, timing_eligible=False)
        write(directory / 'row.json', row)
        write(directory / 'complete.json', dict(accepted=True, freeze_sha256=sha(stage / 'freeze.json'),
            row=row, artifacts=artifacts, evidence=evidence(directory)))
        print('SELECTED', name, row['captured'], row['verified'], row['deployed'], flush=True)
    verify(stage, frozen, runtime=True)
    if options.scope == 'smoke':
        for name in SMOKE:
            completed(stage / 'selection' / name, stage)
        value = dict(accepted=True, freeze_sha256=sha(stage / 'freeze.json'),
                     program_receipts={n: sha(stage / 'selection' / n / 'complete.json') for n in SMOKE})
        if smoke_receipt.exists():
            assert read(smoke_receipt) == value
        else:
            write(smoke_receipt, value)
    else:
        rows = [completed(stage / 'selection' / name, stage) for name in frozen['eligible']]
        assert len(rows) == 33 and all(r['accepted'] for r in rows)
        value = dict(complete=True, eligible=33, completed=33, loops=20,
            baseline_programs_deploying=frozen['baseline_programs_deploying'],
            programs_deploying=sum(r['deployed'] > 0 for r in rows),
            captured=sum(r['captured'] for r in rows), verified=sum(r['verified'] for r in rows),
            deployed=sum(r['deployed'] for r in rows), rows=rows, timing_eligible=False,
            freeze_sha256=sha(stage / 'freeze.json'))
        path = stage / 'selection-summary.json'
        if path.exists():
            assert read(path) == value
        else:
            write(path, value)


def marker_bytes(data, markers):
    start, end = markers['start'].encode('ascii'), markers['end'].encode('ascii')
    assert data.count(start) == data.count(end) == 1, 'Missing/ambiguous replay boundary'
    before, _, rest = data.partition(start)
    value, _, after = rest.partition(end)
    assert len(before) + len(start) <= data.index(end), 'Reordered replay markers'
    return value


def six(stage, frozen, options):
    assert read(stage / 'selection-summary.json')['complete'], 'Finish ordinary selection first'
    directory = stage / 'six'
    directory.mkdir(exist_ok=False)
    identities = module(stage / 'tools/heldout_identity.py')
    behavior = module(stage / 'tools/capture_behavior.py')
    rows = []
    for name, wanted in SIX.items():
        ordinary = completed(stage / 'selection' / name, stage)
        metadata = read(stage / 'tools/capture/base' / name / 'plan.json')
        expected = {r.get('qualname', r['function']): dict(file=identities.canonical_file(r.get('file', metadata['script'])),
                    qualname=r.get('qualname', r['function']), line=r['line']) for r in metadata['functions']}
        assert set(expected) == wanted
        candidates = {fn: [r for r in ordinary['candidates'] if identities.key(r) == identities.key(expected[fn])]
                      for fn in wanted}
        pending, observed = set(), []
        for fn in sorted(wanted):
            matches = candidates[fn]
            candidate = matches[0].get('candidate', {}) if len(matches) == 1 else {}
            executed = [r for r in ordinary['deployed_functions'] if identities.key(r) == identities.key(expected[fn])]
            independent = [r for r in ordinary['independent_functions'] if identities.key(r) == identities.key(expected[fn])]
            reusable = (candidate.get('status') == 'verified' and candidate.get('engine') == 'region'
                        and all(k in candidate for k in ('python_us_per_call', 'compiled_cpu_us_per_call'))
                        and len(executed) == 1 and executed[0]['aot_calls'] > 0 and executed[0]['jit_calls'] == 0
                        and identities.native_reconciles(executed, independent))
            if reusable:
                observed.append(dict(expected[fn], function=fn, canonical_file=expected[fn]['file'], valid=True,
                    python_us=candidate['python_us_per_call'], complete_compiled_gate_us=candidate['compiled_cpu_us_per_call'],
                    aot_calls=executed[0]['aot_calls'], jit_calls=0, independent_functions=independent,
                    selection_receipt_sha256=sha(stage / 'selection' / name / 'complete.json'),
                    loaded_product_modules=ordinary['loaded_product_modules'],
                    evidence_source='ordinary complete-call profile plus independently observed per-function native execution',
                    instrumented_phase_measurement=False, behavior_byte_exact=True,
                    rule_counters={rule: dict(implemented=all(r['rule_counters'][rule]['implemented'] for r in independent),
                        successful_calls=sum(r['rule_counters'][rule]['successful_calls'] for r in independent))
                        for rule in frozen['rule_counters']},
                    current_rule_reports=[p.get('direct_report') for r in independent for p in r['programs'].values()]))
            else:
                pending.add(fn)
        if pending:
            workload = next(w for w in frozen['workloads'] if w['name'] == name)
            cwd = Path(workload['cwd'])
            program, child = directory / name, directory / name / 'helper'
            child.mkdir(parents=True)
            original = stage / 'tools/phase_child.py'
            shutil.copyfile(original, child / original.name)
            assert sha(child / original.name) == sha(original)
            write(child / 'capture/input-manifest.json', read(stage / 'tools/capture/input-manifest.json'))
            nominees = [r for r in metadata['functions'] if r.get('qualname', r['function']) in pending]
            assert {r.get('qualname', r['function']) for r in nominees} == pending
            write(child / 'capture/base' / name / 'plan.json', dict(metadata, functions=nominees))
            env = environment(stage, frozen, '_six-' + name, cwd, loops=2)
            output = program / 'data.json'
            execute(stage, options.lock_label, program, 'plain2', [sys.executable, workload['script'], *workload['args']], cwd, env)
            execute(stage, options.lock_label, program, 'replay',
                [sys.executable, child / 'phase_child.py', name, output, '--freeze', stage / 'freeze.json'], cwd, env)
            result = read(output)
            assert result['snapshot_freeze_sha256'] == sha(stage / 'freeze.json')
            assert result['requested_rule_counters'] == frozen['rule_counters']
            assert Path(result['source']).resolve() == (stage / 'src/recompyler/heap.py').resolve()
            assert all(result['new_aot_artifacts'][p] == h for p, h in result['aot_build_artifacts_before_load'].items())
            meta = behavior.extract(Path(result['profile_boundary']), program / 'replay')
            assert meta['exit_code'] == 0 and meta['exception'] is None
            for suffix in ('stdout', 'stderr'):
                assert Path(result['profile_boundary'] + '.application.' + suffix).read_bytes() == (program / ('plain2.' + suffix)).read_bytes(), ('Two-loop profiling changed application bytes', name, suffix)
            for group in ('loaded_before', 'loaded_after'):
                for item in result[group]['product'].values():
                    path = Path(item['path']).resolve()
                    assert path.is_relative_to(stage / 'src')
                    assert frozen['source'][path.relative_to(stage / 'src').as_posix()] == item['sha256'] == sha(path)
                for item in result[group]['native_dependencies'].values():
                    assert sha(item['path']) == item['sha256']
            for filename, digest in result['new_aot_artifacts'].items():
                path = Path(filename).resolve()
                assert path.is_relative_to(program)
                assert sha(path) == digest
            assert result['expected_nominees'] == len(pending)
            assert {r['qualname'] for r in result['rows']} == pending
            assert all(r['valid'] and r['aot_calls'] > 0 and r['jit_calls'] == 0 for r in result['rows'])
            comparisons = []
            for row in result['rows']:
                assert identities.key(row) == identities.key(expected[row['qualname']])
                assert row['source_definition_sha256'] == sha(row['file'])
                assert row['independent_successful_completions'] == row['aot_calls']
                assert set(row['rule_counters']) == set(frozen['rule_counters'])
                for rule in frozen['rule_counters']:
                    counter = row['rule_counters'][rule]
                    assert counter['implemented'] and 0 <= counter['successful_calls'] <= row['aot_calls']
                for attempt in row['attempts']:
                    for suffix in ('stdout', 'stderr'):
                        raw = (program / ('replay.' + suffix)).read_bytes()
                        python = marker_bytes(raw, attempt['streams']['python'])
                        compiled = marker_bytes(raw, attempt['streams']['compiled'])
                        uninstrumented = marker_bytes(raw, attempt['streams']['uninstrumented'])
                        assert python == compiled == uninstrumented, ('Replay changed Python bytes', row['qualname'], suffix)
                        comparisons.append(dict(identity=expected[row['qualname']], stream=suffix,
                            python_sha256=hashlib.sha256(python).hexdigest(), compiled_sha256=hashlib.sha256(compiled).hexdigest(),
                            uninstrumented_sha256=hashlib.sha256(uninstrumented).hexdigest()))
                    for event in attempt['native_events']:
                        assert event['mode'] == 'aot' and row['exports'][event['digest']] == event['export']
                        assert result['new_aot_artifacts'][event['module']] == event['module_sha256'] == sha(event['module'])
                        generated = row['generated_sources'][event['digest']]
                        assert generated['sha256'] == event['generated_source_sha256'] == sha(generated['path'])
                row.update(evidence_source='owned existing-protocol replay with exact Python/AOT streams and sealed native/source provenance',
                           instrumented_phase_measurement=True, behavior_byte_exact=True,
                           loaded_product_modules=result['loaded_after']['product'], new_aot_artifacts=result['new_aot_artifacts'])
                observed.append(row)
            write(program / 'behavior.json', dict(accepted=True, profile_on_off_byte_exact=True, replay_pairs_byte_exact=True, instrumentation_on_off_byte_exact=True,
                                                 profile_metadata=meta, comparisons=comparisons))
        assert {r['qualname'] for r in observed} == wanted and len(observed) == len(wanted)
        for row in observed:
            fn = row['qualname']
            matches = candidates[fn]
            details = [r for r in ordinary['captured_inventory']
                       if (identities.canonical_file(r.get('file', metadata['script'])), r.get('qualname', r['function']), r['line']) == identities.key(expected[fn])]
            row.update(program=name, ordinary_candidates=matches, ordinary_capture_details=details,
                ordinary_captured=any(r['captured'] for r in details),
                ordinary_verified=any(r.get('candidate', {}).get('status') == 'verified' for r in matches),
                ordinary_deployed=any(identities.key(r) == identities.key(expected[fn]) for r in ordinary['deployed_functions']))
            rows.append(row)
        verify(stage, frozen)
    assert len(rows) == 6
    verify(stage, frozen, runtime=True)
    write(stage / 'six-summary.json', dict(complete=True, expected=6, observed=6, rows=rows,
        evidence=inventory(directory), freeze_sha256=sha(stage / 'freeze.json'), diagnostic_only=True,
        limitations=['Reuse ordinary complete-call timings and independent per-function native audit when they cover the exact nominee identity.',
            'Otherwise fresh eight-sample two-loop owned replay with byte-exact full-application and Python/AOT stream gates.',
            'Candidate complete-call timers are separate from instrumented phase timers.',
            'Raw direct ABI-entry observation is not implemented; missing independent native entries fail closed.']))


def trivial(stage, frozen, options):
    directory = stage / 'trivial-run'
    directory.mkdir(exist_ok=False)
    env = environment(stage, frozen, '_trivial', stage)
    execute(stage, options.lock_label, directory, 'trivial',
        [sys.executable, stage / 'tools/trivial_bench.py', 'acceptance'], stage, env)
    result = read(stage / 'tools/trivial-acceptance.json')
    assert result['fallback_calls'] == 0 and result['compiled_calls'] > 0
    # The existing helper writes beside itself; relocate its result before
    # verifying the frozen helper inventory.
    (stage / 'tools/trivial-acceptance.json').rename(directory / 'result.json')
    verify(stage, frozen, runtime=True)
    write(stage / 'trivial.json', dict(result, freeze_sha256=sha(stage / 'freeze.json')))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest='command', required=True)
    command = commands.add_parser('prepare')
    command.add_argument('--name', required=True)
    command.add_argument('--source', type=Path, default=CLONE)
    command.add_argument('--rule-counter', action='append', default=[], help='Require named successful-call counter for a stage rule claim; repeat for journal/features')
    for name in ('select', 'six', 'trivial'):
        command = commands.add_parser(name)
        command.add_argument('--stage', required=True)
        command.add_argument('--lock-label', required=True)
        if name == 'select':
            command.add_argument('--scope', choices=('smoke', 'full'), required=True)
    options = parser.parse_args()
    if options.command == 'prepare':
        prepare(options)
        return
    stage = stage_path(options.stage)
    frozen = read(stage / 'freeze.json')
    assert not (stage / 'FAILED.json').exists(), 'Preserve failed stage; prepare a new stage'
    try:
        verify(stage, frozen, runtime=True)
        lock(options.lock_label)
        coordination = runpy.run_path(str(CLONE / 'inplace/run_locked.py'), run_name='_heldout_guard')
        audit = coordination['audit']()
        assert not audit['blockers'], ('Competing workload; preserve stage', audit)
        write(stage / ('entry-' + options.command + '-' + str(time.time_ns()) + '.json'), audit)
        {'select': selection, 'six': six, 'trivial': trivial}[options.command](stage, frozen, options)
    except BaseException as exc:
        if not (stage / 'FAILED.json').exists():
            write(stage / 'FAILED.json', dict(command=vars(options),
                error=type(exc).__name__ + ': ' + str(exc), aggregate_eligible=False))
        raise


if __name__ == '__main__':
    main()


