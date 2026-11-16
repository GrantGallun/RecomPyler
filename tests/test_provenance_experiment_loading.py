"""Frozen RED witnesses are analyzed without executing their experiments."""
import pytest
from corpus_loader import load_corpus_module

@pytest.mark.parametrize('suffix', ['_pending.py', '_red.py', '-red.py'])
def test_frozen_experiment_keeps_original_definitions_only(tmp_path, suffix):
    path = tmp_path / ('experiment' + suffix)
    path.write_text('def witness(value): return unavailable(value)\nraise AssertionError("experiment executed")\n')
    module = load_corpus_module(path)
    assert module.witness.__code__.co_names == ('unavailable',)
    assert 'unavailable' not in vars(module)

def test_ordinary_fixture_still_executes(tmp_path):
    path = tmp_path / 'fixture.py'
    path.write_text('sentinel = 42\ndef witness(value): return value\n')
    assert load_corpus_module(path).sentinel == 42
