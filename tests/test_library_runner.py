"""Fresh-process library suite execution and census contracts."""
import importlib
import types
import pytest


def runner():
    try: return importlib.import_module('bench.libs.runner')
    except ModuleNotFoundError: pytest.fail('isolated library runner is missing')


def test_stock_worker_reports_a_real_typed_output_without_timing():
    row = runner().run_one('json_encode')
    assert row['status'] == 'ok'
    assert row['digest'] and row['calls'] == 1
    assert 'seconds' not in row
    assert row['installed'] == 0


def test_absent_interpreter_is_reported_without_download():
    row = runner().run_one('json_encode', executable='Z:/absent/pypy.exe')
    assert row['status'] == 'unavailable'


def test_census_visits_owned_descriptors_and_deduplicates_aliases():
    try: census = importlib.import_module('bench.libs.census')
    except ModuleNotFoundError: pytest.fail('library census is missing')
    module = types.ModuleType('fixture_lib')
    exec('def f(x): return x\nclass Box:\n @staticmethod\n def s(x): return x\n @classmethod\n def c(cls): return cls\n @property\n def p(self): return 1\n', module.__dict__)
    module.alias = module.f
    module.foreign = lambda: None
    rows = list(census.functions([module]))
    assert len(rows) == 4
    assert {f.__qualname__ for _, f in rows} == {'f','Box.s','Box.c','Box.p'}


def test_compile_census_records_real_native_admission_without_installing():
    row = runner().run_one('json_encode', mode='census', module_names=['json.encoder'])
    assert row['status'] == 'ok'
    census = row['census']
    assert census['total'] >= 4
    assert census['attempted'] == census['total']
    assert census['compiled'] > 0
    assert census['installed_before'] == 0 and census['installed_after'] == 0
    assert all(x['status'] in ('compiled', 'declined') for x in census['rows'])


def test_pypy_wrong_results_and_errors_fail_the_suite():
    r = runner()
    assert hasattr(r, 'exit_status'), 'runner does not fail PyPy wrong results'
    assert r.exit_status([{'cpython':{'status':'ok'}, 'pypy':{'status':'ok','comparison':'different-output'}}]) == 1
    assert r.exit_status([{'cpython':{'status':'ok'}, 'pypy':{'status':'error'}}]) == 1
    assert r.exit_status([{'cpython':{'status':'ok'}, 'pypy':{'status':'unavailable'}}]) == 0


def test_failed_timing_initialization_releases_its_own_lock(tmp_path):
    r = runner()
    assert hasattr(r, 'timing_lock'), 'timing initialization can leak the shared lock'
    lock = tmp_path/'TIMING.lock'
    bad_ledger = tmp_path/'ledger'
    bad_ledger.mkdir()
    with pytest.raises(OSError):
        with r.timing_lock(lock, bad_ledger):
            pytest.fail('an unwritable ledger should fail initialization')
    assert not lock.exists()


def test_explicit_correctness_installation_has_live_native_entries():
    row = runner().run_one('json_encode', mode='installed', module_names=['json.encoder'])
    assert row['status'] == 'ok', row
    assert row['installed'] > 0, row
    assert row['installed_after_workload'] > 0, row


def test_installed_correctness_requires_the_workload_to_execute_native_code():
    row = runner().run_one('json_encode', mode='installed', module_names=['json.decoder'])
    assert row['status'] == 'not-exercised', row
    assert row['native_entries'] == 0
    row = runner().run_one('json_encode', mode='installed', budget=0)
    assert row['status'] == 'not-installed', row


def test_json_correctness_reports_actual_native_workload_entries(tmp_path):
    journal = tmp_path/'journal.jsonl'
    row = runner().run_one('json_encode', mode='installed', module_names=['json.encoder'], journal=journal)
    assert row['status'] == 'ok', row
    assert row['native_entries'] > 0
    import json
    events = [json.loads(line) for line in journal.read_text().splitlines()]
    assert any(e.get('phase')=='compile' and e.get('event')=='begin' and e.get('function') for e in events)
    assert any(e.get('phase')=='install' and e.get('event')=='begin' for e in events)
    assert any(e.get('phase')=='workload' and e.get('event')=='begin' for e in events)


def test_workload_profile_counts_hot_library_calls_without_argument_capture():
    census = importlib.import_module('bench.libs.census')
    assert hasattr(census,'profile_workload'), 'library hot functions are not prioritized'
    module = types.ModuleType('fixture_profile_lib')
    exec('def used(): return 1\ndef unused(): return 2\n',module.__dict__)
    value, counts = census.profile_workload(lambda:[module.used() for _ in range(3)],'fixture_profile_lib')
    assert value == [1,1,1]
    assert counts == {'fixture_profile_lib.used':3}
    import sys
    assert sys.getprofile() is None


def test_census_does_not_execute_metaclass_descriptors():
    census = importlib.import_module('bench.libs.census')
    module = types.ModuleType('fixture_meta_census')
    exec('class Meta(type):\n @property\n def __dict__(cls): raise RuntimeError("descriptor")\nclass Box(metaclass=Meta):\n def f(self): return 1\n',module.__dict__)
    rows = list(census.functions([module]))
    assert any(f.__qualname__ == 'Box.f' for _,f in rows)


def test_install_journal_preserves_precise_canonical_refusals(tmp_path):
    import json
    journal = tmp_path/'install.jsonl'
    row = runner().run_one('json_encode',mode='installed',module_names=['json.encoder'],journal=journal)
    assert row['status'] == 'ok',row
    installs=[r for r in map(json.loads,journal.read_text().splitlines()) if r.get('phase')=='install' and r.get('event')=='end']
    assert installs
    assert all(r.get('installed') or r.get('reason') for r in installs)
