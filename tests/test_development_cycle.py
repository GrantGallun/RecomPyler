"""Fast development-cycle selection without importing compiler modules."""
import importlib.util
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
SPEC=importlib.util.spec_from_file_location('affected',ROOT/'tools'/'affected_tests.py')


def load():
    module=importlib.util.module_from_spec(SPEC)
    SPEC.loader.exec_module(module)
    return module


def test_module_imports_and_changed_tests_are_selected(tmp_path):
    tests=tmp_path/'tests';tests.mkdir()
    (tests/'test_a.py').write_text('from recompyler import heap\n')
    (tests/'test_b.py').write_text('from recompyler.ir.entry import create_callable\n')
    (tests/'test_c.py').write_text('import recompyler.ir.entry as entry\n')
    assert load().affected_tests(tmp_path,['src/recompyler/ir/entry.py','tests/test_a.py'])==[
        'tests/test_a.py','tests/test_b.py','tests/test_c.py']


def test_slow_selection_follows_helpers_and_fixtures():
    source='''import subprocess as sp

def build():
    sp.run(['python'])

def artifact():
    return build()

def test_build(artifact):
    pass

def test_fast():
    return 1
'''
    assert load().slow_test_names(source)=={'test_build'}


def test_persistent_cache_overrides_inherited_clone_cache(tmp_path):
    env=load().cache_environment(tmp_path,{'RECOMPYLER_CACHE':'foreign'},force=True)
    assert env['RECOMPYLER_CACHE']==str(tmp_path/'.cache'/'rc')
    assert env['NUMBA_CACHE_DIR']==str(tmp_path/'.cache'/'numba')


def test_transitive_source_imports_and_dynamic_tool_tests(tmp_path):
    source=tmp_path/'src'/'recompyler';source.mkdir(parents=True)
    (source/'heap.py').write_text('from . import _call_bridge\n')
    (source/'_call_bridge.py').write_text('from ._managed_vector import call\n')
    tests=tmp_path/'tests';tests.mkdir()
    (tests/'test_vector.py').write_text('from recompyler import heap\n')
    (tests/'test_tools.py').write_text("TOOL='affected_tests.py'\n")
    tool=load()
    assert tool.affected_tests(tmp_path,['src/recompyler/_managed_vector.py'])==['tests/test_vector.py']
    assert tool.affected_tests(tmp_path,['tools/affected_tests.py'])==['tests/test_tools.py']


def test_fast_gate_creates_pytest_temp_parent_before_starting_workers(tmp_path,monkeypatch):
    import sys
    from types import SimpleNamespace
    monkeypatch.syspath_prepend(str(ROOT/'tools'))
    import full_suite
    root=tmp_path/'checkout';(root/'tests').mkdir(parents=True)
    (root/'tests/test_one.py').write_text('def test_one():pass\n')
    monkeypatch.setattr(full_suite,'__file__',str(root/'tools/full_suite.py'))
    def run(command,**kwargs):
        base=next(value.split('=',1)[1] for value in command if value.startswith('--basetemp='))
        assert Path(base).parent.is_dir()
        assert Path(base).is_relative_to(root/'.cache')
        return SimpleNamespace(returncode=0)
    monkeypatch.setattr(full_suite.subprocess,'run',run)
    assert full_suite.main(['fresh','--workers','1'])==0
    assert (root/'.cache/evidence/fresh-shard0.log').exists()
    assert not (root/'lift-evidence').exists()


def test_gate_can_bound_retained_memory_with_fresh_chunks(tmp_path,monkeypatch):
    from types import SimpleNamespace
    monkeypatch.syspath_prepend(str(ROOT/'tools'))
    import full_suite
    root=tmp_path/'checkout';(root/'tests').mkdir(parents=True)
    files=['tests/test_one.py','tests/test_two.py','tests/test_three.py','tests/test_four.py']
    for name in files:(root/name).write_text('def test_ok():pass\n')
    monkeypatch.setattr(full_suite,'__file__',str(root/'tools/full_suite.py'))
    commands=[]
    def run(command,**kwargs):
        commands.append(command)
        return SimpleNamespace(returncode=0)
    monkeypatch.setattr(full_suite.subprocess,'run',run)
    assert full_suite.main(['chunks','--workers','1','--chunks','3','--include-slow'])==0
    assert len(commands)==3
    assert sorted(value.replace('\\','/') for command in commands for value in command if value.endswith('.py'))==sorted(files)
    assert len({next(value for value in command if value.startswith('--basetemp=')) for command in commands})==3


def test_s94_gate_rejects_more_than_two_correctness_workers(tmp_path, monkeypatch):
    import pytest
    from types import SimpleNamespace
    monkeypatch.syspath_prepend(str(ROOT/'tools'))
    import full_suite
    root=tmp_path/'checkout';(root/'tests').mkdir(parents=True)
    (root/'tests/test_one.py').write_text('def test_one():pass\n')
    monkeypatch.setattr(full_suite,'__file__',str(root/'tools/full_suite.py'))
    monkeypatch.setattr(full_suite.subprocess,'run',lambda *a,**kw:SimpleNamespace(returncode=0))
    with pytest.raises(SystemExit) as error:
        full_suite.main(['too-many', '--workers', '3'])
    assert error.value.code == 2


def test_s94_gate_defaults_to_two_workers(tmp_path, monkeypatch):
    from types import SimpleNamespace
    monkeypatch.syspath_prepend(str(ROOT/'tools'))
    import full_suite
    root=tmp_path/'checkout';(root/'tests').mkdir(parents=True)
    (root/'tests/test_one.py').write_text('def test_one():pass\n')
    monkeypatch.setattr(full_suite,'__file__',str(root/'tools/full_suite.py'))
    monkeypatch.delenv('WAVE18_CORRECTNESS_WORKERS',raising=False)
    monkeypatch.setattr(full_suite.subprocess,'run',lambda *a,**kw:SimpleNamespace(returncode=0))
    pools=[]
    original=full_suite.ThreadPoolExecutor
    def pool(*,max_workers):
        pools.append(max_workers)
        return original(max_workers=max_workers)
    monkeypatch.setattr(full_suite,'ThreadPoolExecutor',pool)
    assert full_suite.main(['default-workers'])==0
    assert pools==[2]
