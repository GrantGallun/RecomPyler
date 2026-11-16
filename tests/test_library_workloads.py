"""Library benchmark contract tests: typed, deterministic and complete."""
import importlib
import pytest


def api():
    try:
        return importlib.import_module('bench.libs.workloads')
    except ModuleNotFoundError:
        pytest.fail('S85 library workload suite is missing')


def test_numeric_type_is_part_of_output_digest():
    w = api()
    assert w.output_digest(1) != w.output_digest(1.0)
    assert w.output_digest(True) != w.output_digest(1)
    assert w.output_digest(0.0) != w.output_digest(-0.0)
    assert w.output_digest([1, 'a']) != w.output_digest(('a', 1))


def test_required_packages_have_real_deterministic_workloads():
    w = api()
    cases = w.workloads()
    assert {x.package for x in cases.values()} == {
        'networkx', 'sympy', 'jinja2', 'markdown', 'pygments', 'pyparsing',
        'dateutil', 'yaml', 'jsonschema', 'json', 'difflib', 'email', 'tomllib', 'numpy'}
    assert 'networkx_pagerank' in cases and 'networkx_shortest_paths' in cases
    for case in cases.values():
        try: run = case.prepare()
        except ModuleNotFoundError: continue
        first = run()
        assert first is not None, case.name
        assert w.output_digest(first) == w.output_digest(run()), case.name


def test_pure_python_json_and_yaml_paths():
    w = api()
    import json.encoder
    yaml = pytest.importorskip('yaml')
    cases = w.workloads()
    original = json.encoder.c_make_encoder
    assert cases['json_encode'].prepare()() == '{"a":[1,2,3],"b":"caf\\u00e9","nested":{"x":true}}'
    assert json.encoder.c_make_encoder is original
    assert cases['yaml_load'].prepare()()['rows'][0] == {'name': 'alpha', 'value': 7}
    assert yaml.Loader.__module__ == 'yaml.loader'


def test_oracle_digest_does_not_execute_the_library_under_test(monkeypatch):
    import json
    w = api()
    first = w.output_digest({'answer': 42})
    monkeypatch.setattr(json, 'dumps', lambda *a, **k: 'corrupted')
    assert w.output_digest({'answer':42}) == first
    assert w.output_digest({'answer':43}) != first

