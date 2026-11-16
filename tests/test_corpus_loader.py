"""Frozen experiment imports cannot execute their native setup/assertions."""
import pytest
from corpus_loader import load_corpus_module


@pytest.mark.parametrize('suffix', ['-red.py', '_red.py'])
def test_red_experiment_preserves_source_without_running_setup(tmp_path,suffix):
    path=tmp_path/('experiment'+suffix)
    path.write_text('global_value=99\nraise RuntimeError("native experiment setup executed")\ndef original(value): return value + global_value\n')
    module=load_corpus_module(path)
    assert module.original.__code__.co_filename==str(path)
    assert module.original.__code__.co_names==('global_value',)
    assert 'global_value' not in vars(module)
    with pytest.raises(NameError): module.original(1)


def test_ordinary_corpus_fixture_still_executes_its_globals(tmp_path):
    path=tmp_path/'ordinary.py'
    path.write_text('global_value=99\ndef original(value): return value + global_value\n')
    assert load_corpus_module(path).original(1)==100
