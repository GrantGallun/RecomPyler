from pathlib import Path
from types import SimpleNamespace
import pytest


def test_gate_partitions_every_fast_suite_file_once(tmp_path):
    from bench.libs.fast_gate import plan_batches
    tests=tmp_path/'tests';tests.mkdir()
    for number,size in enumerate([100,90,80,20,10]):
        (tests/f'test_{number}.py').write_text(' '*size)
    (tests/'helper.py').write_text('helper')
    batches=plan_batches(tmp_path,3)
    paths=[p for batch in batches for p in batch]
    assert sorted(paths)==sorted(p.relative_to(tmp_path).as_posix() for p in tests.glob('test_*.py'))
    assert len(paths)==len(set(paths)) and len(batches)==3 and all(batches)


def test_gate_keeps_cache_flags_and_reports_a_crash_as_failure(tmp_path):
    from bench.libs.fast_gate import run_gate
    tests=tmp_path/'tests';tests.mkdir()
    for number in range(4):(tests/f'test_{number}.py').write_text('pass')
    calls=[]
    def run(command,**kwargs):
        calls.append((command,kwargs))
        return SimpleNamespace(returncode=-11 if len(calls)==1 else 0)
    report=run_gate(tmp_path,'unit',workers=1,batches=3,run=run)
    assert report['ok'] is False and len(calls)==3
    assert sorted(p for command,_ in calls for p in command if p.startswith('tests/'))==[f'tests/test_{n}.py' for n in range(4)]
    for command,kwargs in calls:
        assert command[1:4]==['-m','pytest','-q']
        assert command[command.index('-m',3)+1]=='not slow'
        assert Path(kwargs['env']['RECOMPYLER_CACHE'])==tmp_path/'.cache'/'rc'
        assert Path(kwargs['env']['NUMBA_CACHE_DIR'])==tmp_path/'.cache'/'numba'
        assert kwargs['cwd']==tmp_path
    assert sorted(row['returncode'] for row in report['batches'])==[-11,0,0]


@pytest.mark.parametrize('workers',[0,3])
def test_gate_rejects_worker_counts_outside_run_scope(tmp_path,workers):
    from bench.libs.fast_gate import run_gate
    with pytest.raises(ValueError,match='1 or 2'):run_gate(tmp_path,'invalid',workers=workers)


def test_gate_clears_inherited_pytest_filters_and_allows_fully_deselected_groups(tmp_path,monkeypatch):
    from bench.libs.fast_gate import run_gate
    tests=tmp_path/'tests';tests.mkdir()
    (tests/'test_only_slow.py').write_text('import pytest\n@pytest.mark.slow\ndef test_slow():pass\n')
    monkeypatch.setenv('PYTEST_ADDOPTS','-k nonexistent -n 8')
    def run(command,**kwargs):
        assert kwargs['env'].get('PYTEST_ADDOPTS')==''
        kwargs['stdout'].write('1 deselected in 0.01s\n')
        return SimpleNamespace(returncode=5)
    report=run_gate(tmp_path,'all-slow',batches=16,run=run)
    assert report['ok'] is True and report['batches'][0]['returncode']==5
