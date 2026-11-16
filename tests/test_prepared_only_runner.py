"""A saved AOT-only plan keeps guard/cache misses off the compiler path."""
from unittest.mock import Mock
from test_prepared_cache_adversarial import runner_artifact


def test_saved_prepared_plan_missing_index_runs_source(runner_artifact,monkeypatch,capsys):
    pc,heap,module,source,section,report,plan_file=runner_artifact
    from recompyler.runner import run_script
    inference=Mock(side_effect=AssertionError('saved AOT-only miss inferred a program'))
    monkeypatch.setattr(pc,'open_index',lambda *args,**kwargs:None)
    monkeypatch.setattr(heap.Region,'_make_program',inference)
    result=run_script(source,[],plan_file,False)
    assert capsys.readouterr().out=='18\n4\n'
    assert result['exit_code'] in (None,0)
    inference.assert_not_called()
    assert result['functions']
    assert all(row['jit_calls']==row['aot_calls']==row['compiled_calls']==0 for row in result['functions'])
