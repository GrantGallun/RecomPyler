"""Experimental RED scripts are source witnesses, not executable fixtures."""
import pytest
from corpus_loader import load_corpus_module


@pytest.mark.parametrize('suffix',['_pending.py','-red.py','_red.py'])
def test_frozen_experiment_preserves_functions_without_running_its_setup(tmp_path,suffix):
    path=tmp_path/('experiment'+suffix)
    path.write_text("raise AssertionError('experiment setup executed')\ndef identity(value):return value\ndef needs_context(value):return unavailable(value)\n")
    module=load_corpus_module(path)
    assert module.identity(7)==7
    assert set(name for name in vars(module) if not name.startswith('__'))=={'identity','needs_context'}
    assert module.identity.__module__==module.__name__
    assert module.identity.__code__.co_filename==str(path)
    from recompyler import provenance
    assert provenance.analyze(module.needs_context).result.unknown


def test_regular_corpus_fixture_retains_its_real_module_context(tmp_path):
    path=tmp_path/'fixture.py'
    path.write_text('CONTEXT=7\ndef target():return CONTEXT\n')
    module=load_corpus_module(path)
    assert module.target()==7 and module.CONTEXT==7
