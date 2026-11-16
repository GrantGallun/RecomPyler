"""Compile-only census counts definitions without running their bodies."""
import importlib.util
from pathlib import Path
import sys


def census_module():
    path = Path(__file__).parents[1] / 'tools' / 'self_census.py'
    spec = importlib.util.spec_from_file_location('self_census', path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def test_inventory_keeps_methods_nested_async_and_lambda_without_execution(tmp_path):
    source = tmp_path / 'sample.py'
    source.write_text('''events.append("module must not execute")
def outer(x):
    def inner(y): return x + y
    return inner
class Example:
    @property
    def value(self): return 1
async def waiting(): return 2
callback = lambda x: x
''')
    census = census_module()
    rows = census.inventory(source)
    assert [(row['qualname'], row['kind'], row['nested']) for row in rows] == [
        ('outer', 'function', False), ('outer.<locals>.inner', 'function', True),
        ('Example.value', 'method', False), ('waiting', 'async-function', False),
        ('<lambda>', 'lambda', False)]
    functions = census.source_functions(source, {})
    assert len(functions) == 5
    assert functions[1].__code__.co_freevars == ('x',)
    assert functions[1].__code__.co_filename == str(source)


def test_real_api_compiles_body_without_calling_it(tmp_path):
    source = tmp_path / 'sample.py'
    source.write_text('def target(action):\n    return action()\n')
    census = census_module()
    result = census.attempt(census.source_functions(source, {})[0])
    assert result['status'] == 'compiled'
    assert result['backend'] == 'lift_structures'
    assert result['execution_verified'] is False
    assert result['attempts'][0]['status'] == 'compiled'


def test_compiled_entry_with_unsupported_kwargs_is_not_counted(tmp_path):
    source = tmp_path / 'sample.py'
    source.write_text('def target(**values):\n    return values\n')
    census = census_module()
    result = census.attempt(census.source_functions(source, {})[0])
    assert result['status'] == 'declined'
    assert result['family'] == 'variadic-keywords'
    assert len(result['attempts']) == 3


def test_rankings_do_not_promise_completion_from_first_refusal():
    census = census_module()
    rows = [dict(status='compiled', nested=False),
            dict(status='declined', family='with', nested=False),
            dict(status='declined', family='with', nested=True),
            dict(status='error', family='compiler-error', nested=False),
            dict(status='not-attempted', family='budget', nested=True)]
    result = census.summarize(rows)
    assert result['compiled'] == 1 and result['total'] == 5
    assert result['nested']['total'] == 2
    assert result['ranked_families'][0] == dict(family='with', functions=2, nested=1,
        completion_upper_bound=2, completion_proven=0)
    assert result['errors'] == 1 and result['not_attempted'] == 1


def test_generator_refusal_is_not_mislabelled_as_a_closure(tmp_path):
    census = census_module()
    source = tmp_path / 'sample.py'
    source.write_text('def suspended():\n    yield 1\n')
    result = census.attempt(census.source_functions(source, {})[0])
    assert result['status'] == 'declined'
    assert result['family'] == 'generators'


def test_normalization_keeps_construct_families_together():
    census = census_module()
    for reason, expected in [
        ('expression ListComp', 'comprehensions'),
        ('expression DictComp', 'comprehensions'),
        ('expression SetComp', 'comprehensions'),
        ('expanded call arguments are not supported', 'starred-arguments'),
        ('for-else is not supported', 'for-else'),
        ('instruction positions unavailable', 'source-binding'),
        ('expression Lambda', 'closures-functions-cells'),
        ('binary operator is unsupported', 'binary-operators'),
    ]:
        assert census.family(reason) == expected


def test_resume_keeps_verdicts_but_rejects_a_different_source_population():
    census = census_module()
    rows = [dict(path='src/recompyler/sample.py', index=0, qualname='done', line=1,
                 status='not-attempted'),
            dict(path='src/recompyler/sample.py', index=1, qualname='later', line=3,
                 status='not-attempted')]
    previous = dict(commit='same', functions=[dict(rows[0], status='compiled'),dict(rows[1])])
    restored = census.restore_previous(previous, rows, 'same')
    assert [row['status'] for row in restored] == ['compiled', 'not-attempted']
    import pytest
    with pytest.raises(ValueError, match='commit'):
        census.restore_previous(previous, rows, 'different')
    added=dict(path='src/recompyler/new_ir.py',index=0,qualname='new_helper',line=1,status='not-attempted')
    with pytest.raises(ValueError,match='population'):
        census.restore_previous(previous,rows+[added],'same')
    previous['functions'][0]['qualname'] = 'renamed'
    with pytest.raises(ValueError, match='population'):
        census.restore_previous(previous, rows, 'same')
