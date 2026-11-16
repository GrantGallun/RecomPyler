import gc
import types
import weakref


def test_collector_keeps_distinct_functions_sharing_code():
    from bench.libs.diagnose import collect_calls, select_targets
    namespace = {'__name__': 'sample_library'}
    exec('def body(): return 7', namespace)
    body = namespace['body']
    alias = types.FunctionType(body.__code__, body.__globals__, 'alias')
    def run(): return body() + alias() + alias()
    value, rows = collect_calls(run, 'sample_library')
    assert value == 21
    assert sorted(row['calls'] for row in rows) == [1, 2]
    targets, excluded = select_targets(rows)
    assert len(targets) == 1 and targets[0]['function']() is alias
    assert excluded[0]['reason'] == 'shared code: hotter function identity selected'


def test_collector_preserves_no_ephemeral_function_or_code():
    from bench.libs.diagnose import collect_calls, select_targets
    refs = []
    def run():
        namespace = {'__name__': 'sample_library'}
        exec('def transient(): return 7', namespace)
        target = namespace.pop('transient')
        refs.extend((weakref.ref(target), weakref.ref(target.__code__)))
        return target()
    value, rows = collect_calls(run, 'sample_library')
    gc.collect()
    assert value == 7 and all(ref() is None for ref in refs)
    targets, excluded = select_targets(rows)
    assert targets == []
    assert excluded[0]['reason'] == 'function owner no longer live after workload'


def test_generated_template_and_driver_are_candidates():
    from bench.libs.diagnose import collect_calls
    namespace = {'__name__': None}
    exec(compile('def root(): return 5', '<template>', 'exec'), namespace)
    def run(): return namespace['root']()
    value, rows = collect_calls(run, 'jinja2', include_driver=True)
    assert value == 5
    assert {row['origin'] for row in rows} == {'driver', 'generated template'}



def test_repeated_diagnosis_releases_its_counted_preparations(monkeypatch):
    from bench.libs.diagnose import diagnose
    from bench.libs import workloads as fixtures
    from recompyler.ir import compilation_info
    namespace = {'__name__': 'sample_library'}
    exec('def run(x=1):\n return x+1', namespace)
    target = namespace['run']
    case = fixtures.Workload('sample', 'sample_library', lambda: target)
    monkeypatch.setattr(fixtures, 'workloads', lambda: {'sample': case})
    first = diagnose('sample')
    second = diagnose('sample')
    assert first['compiled'] == second['compiled'] == 1
    assert compilation_info(target) is None


def test_json_journal_writes_are_excluded_from_workload_entry_counts(tmp_path):
    from bench.libs.diagnose import diagnose
    report=diagnose('json_encode',journal=tmp_path/'events.jsonl')
    encoder=next(row for row in report['rows'] if row['name']=='json.encoder.JSONEncoder.iterencode')
    assert encoder['native_entries']==32,encoder
