"""Fork comparison keeps stock references and lock ownership separate."""
from contextlib import contextmanager
import importlib.util
from pathlib import Path
from types import SimpleNamespace

import pytest


def adapter():
    path = Path(__file__).resolve().parents[1] / 'tools/bench_fork_shared.py'
    assert path.exists(), 'missing fork shared-harness adapter'
    spec = importlib.util.spec_from_file_location('fork_shared', path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_fork_candidate_never_replaces_stock_reference_executables(tmp_path):
    module = adapter()
    calls = []
    def observe(name, engine, **kwargs):
        calls.append((engine, kwargs['executable'], kwargs['repeats']))
        return dict(status='ok', digest='same', seconds=1.0, installed=0, installed_ids=[])
    harness = SimpleNamespace(ENGINES=('cpython_off', 'cpython_on', 'recompyler'),
        observe=observe, validate_samples=lambda samples: True,
        interval=lambda values: {'n': len(values)})
    row = module.run_case('nbody', stock=Path('stock.exe'), fork=Path('fork.exe'),
        pypy=Path('pypy.exe'), pairs=3, root=tmp_path, harness=harness, test_processes=lambda: [])
    assert calls[:4] == [('cpython_off', Path('stock.exe').resolve(), 64),
        ('cpython_on', Path('stock.exe').resolve(), 64), ('recompyler', Path('fork.exe').resolve(), 64),
        ('pypy', Path('pypy.exe').resolve(), 64)]
    assert [item[0] for item in calls[4:8]] == ['pypy', 'recompyler', 'cpython_on', 'cpython_off']
    assert len(row['samples']) == 3 and row['status'] == 'ok'
    assert not (tmp_path / 'TIMING.lock').exists()
    ledger = (tmp_path / 'WAVE20-CINDER-PLAN.md').read_text()
    assert 'acquire' in ledger and 'release' in ledger
    assert not (tmp_path / 'WAVE21-LIBS-PLAN.md').exists()


def test_foreign_lock_survives_rejected_acquisition(tmp_path):
    module = adapter()
    lock = tmp_path / 'TIMING.lock'
    lock.mkdir()
    (lock / 'owner.txt').write_text('peer')
    with pytest.raises(FileExistsError):
        with module.timing_session(tmp_path, 'test'):
            pytest.fail('foreign lock admitted')
    assert (lock / 'owner.txt').read_text() == 'peer'


def test_lock_releases_after_failed_observation(tmp_path):
    module = adapter()
    with pytest.raises(ValueError, match='wrong'):
        with module.timing_session(tmp_path, 'test'):
            owner = (tmp_path / 'TIMING.lock/owner.txt').read_text()
            assert owner.startswith('wave20-cinder') and 'class: development' in owner
            raise ValueError('wrong')
    assert not (tmp_path / 'TIMING.lock').exists()


def test_short_pairs_rejected_before_lock_or_process(tmp_path):
    module = adapter()
    with pytest.raises(ValueError, match='three'):
        module.run_case('selfcompile', stock=Path('stock'), fork=Path('fork'),
            pairs=2, root=tmp_path, harness=SimpleNamespace(), test_processes=lambda: [])
    assert not (tmp_path / 'TIMING.lock').exists()

def test_relative_executable_paths_are_resolved_before_worker_changes_directory(tmp_path, monkeypatch):
    module = adapter()
    monkeypatch.chdir(tmp_path)
    paths = {name: tmp_path / (name + '.exe') for name in ('stock', 'fork', 'pypy')}
    for path in paths.values(): path.touch()
    observed = []
    def observe(name, engine, **kwargs):
        observed.append(kwargs['executable'])
        assert kwargs['executable'].is_absolute(), 'worker cwd would reinterpret executable'
        return dict(status='ok', digest='same', seconds=1.0, installed=0, installed_ids=[])
    harness = SimpleNamespace(ENGINES=('cpython_off', 'cpython_on', 'recompyler'),
        observe=observe, validate_samples=lambda samples: True,
        interval=lambda values: {'n': len(values)})
    module.run_case('nbody', stock=Path('stock.exe'), fork=Path('fork.exe'),
        pypy=Path('pypy.exe'), root=tmp_path, harness=harness, test_processes=lambda: [])
    assert observed[:4] == [paths['stock'], paths['stock'], paths['fork'], paths['pypy']]

@pytest.mark.parametrize('state',['cold','warm'])
def test_cache_state_is_candidate_only_and_run_lock_name_is_explicit(tmp_path,state):
    module=adapter()
    cache=tmp_path/'cache';cache.mkdir()
    calls=[]
    def observe(name,engine,**kwargs):
        calls.append((engine,kwargs))
        return dict(status='ok',digest='same',seconds=1.0,installed=0,installed_ids=[])
    harness=SimpleNamespace(ENGINES=('cpython_off','cpython_on','recompyler'),
        observe=observe,validate_samples=lambda samples:True,interval=lambda values:{'n':len(values)})
    row=module.run_case('nbody',stock=Path('stock'),fork=Path('fork'),pairs=3,root=tmp_path,
        harness=harness,test_processes=lambda:[],cache_state=state,library_cache=cache if state=='warm' else None)
    assert row['cache_state']==state
    for engine,arguments in calls:
        assert arguments['run_name']=='wave20-cinder'
        assert arguments['cache_state']==(state if engine=='recompyler' else 'existing')
        assert arguments['library_cache']==(cache if state=='warm' and engine=='recompyler' else None)


def test_missing_warm_cache_declines_before_lock_or_observation(tmp_path):
    module=adapter()
    with pytest.raises(ValueError,match='warm'):
        module.run_case('nbody',stock=Path('stock'),fork=Path('fork'),root=tmp_path,
            cache_state='warm',library_cache=tmp_path/'absent',harness=SimpleNamespace(),test_processes=lambda:[])
    assert not (tmp_path/'TIMING.lock').exists()
