import json
import sys
from pathlib import Path


def test_observe_launches_selected_worker_in_fresh_process(tmp_path, monkeypatch):
    from bench.libs import shared_harness as harness
    (tmp_path/'probe.py').write_text('import json,os; print(json.dumps(dict(status="ok",digest="probe-worker",installed=0,pid=os.getpid())))')
    monkeypatch.setattr(harness, 'ROOT', tmp_path)
    row=harness.observe('json_encode','cpython_off',worker_module='probe')
    assert row['status']=='ok' and row['digest']=='probe-worker'
    assert row['pid']!=__import__('os').getpid()


def test_cohort_uses_requested_lock_ledger_and_worker(tmp_path, monkeypatch):
    from bench.libs import shared_harness as harness
    lock=tmp_path/'TIMING.lock'; ledger=tmp_path/'ledger.md'
    seen=[]
    def observation(name,engine,**kwargs):
        assert lock.is_dir() and 'acquire' in ledger.read_text()
        seen.append(kwargs['worker_module'])
        return dict(status='ok',digest='same',seconds=1,installed=0)
    monkeypatch.setattr(harness,'observe',observation)
    monkeypatch.setattr('bench.libs.timing_runner.test_processes',lambda:[])
    report=harness.run_case('json_encode',pairs=3,lock=lock,ledger=ledger,worker_module='peer.worker')
    assert report['status']=='ok' and seen.count('peer.worker')==3
    assert seen.count('bench.libs.program_worker')==6
    assert not lock.exists() and 'release' in ledger.read_text()


def test_worker_tools_changes_invalidate_saved_measurements(tmp_path,monkeypatch):
    from bench.libs import shared_harness as harness
    (tmp_path/'src').mkdir(); (tmp_path/'bench/libs').mkdir(parents=True)
    tools=tmp_path/'tools';tools.mkdir()
    worker=tools/'peer_worker.py';worker.write_text('answer=1\n')
    monkeypatch.setattr(harness,'ROOT',tmp_path)
    before=harness.source_fingerprint()
    worker.write_text('answer=2\n')
    after=harness.source_fingerprint()
    assert before!=after
    with __import__('pytest').raises(ValueError,match='source'):
        harness.resume_rows(dict(split='train',source_sha256=before,rows=[]),'train',after)


def test_cold_observations_use_distinct_empty_library_caches(tmp_path, monkeypatch):
    from types import SimpleNamespace
    from bench.libs import shared_harness as harness
    monkeypatch.setattr(harness, 'ROOT', tmp_path)
    seen = []
    def launch(command, **kwargs):
        cache = Path(kwargs['env']['RECOMPYLER_LIBRARY_CACHE'])
        assert cache.is_dir() and not list(cache.iterdir())
        seen.append(cache)
        (cache/'residue.json').write_text('{}')
        return SimpleNamespace(returncode=0, stdout=json.dumps(dict(status='ok',digest='same',installed=0)))
    monkeypatch.setattr(harness.subprocess, 'run', launch)
    for _ in range(2):
        row = harness.observe('json_encode','recompyler',cache_state='cold')
        assert row['cache_state'] == 'cold'
    assert seen[0] != seen[1] and not any(p.exists() for p in seen)


def test_warm_observations_require_a_frozen_explicit_library_cache(tmp_path, monkeypatch):
    import pytest
    from types import SimpleNamespace
    from bench.libs import shared_harness as harness
    monkeypatch.setattr(harness, 'ROOT', tmp_path)
    with pytest.raises(ValueError, match='explicit'):
        harness.observe('json_encode','recompyler',cache_state='warm')
    cache = tmp_path/'prepared'; cache.mkdir()
    artifact = cache/'body.o'; artifact.write_bytes(b'object')
    def launch(command, **kwargs):
        assert Path(kwargs['env']['RECOMPYLER_LIBRARY_CACHE']) == cache
        return SimpleNamespace(returncode=0, stdout=json.dumps(dict(status='ok',digest='same',installed=0)))
    monkeypatch.setattr(harness.subprocess, 'run', launch)
    row = harness.observe('json_encode','recompyler',cache_state='warm',library_cache=cache)
    assert row['cache_state'] == 'warm'
    assert row['cache_sha256_before'] == row['cache_sha256_after']
    assert artifact.read_bytes() == b'object'
    original = launch
    def changed(command, **kwargs):
        result = original(command, **kwargs)
        artifact.write_bytes(b'changed')
        return result
    monkeypatch.setattr(harness.subprocess, 'run', changed)
    with pytest.raises(ValueError, match='cache changed'):
        harness.observe('json_encode','recompyler',cache_state='warm',library_cache=cache)


def test_body_map_never_runs_codegen_to_describe_a_live_body(monkeypatch):
    import types
    from bench.libs.program_worker import body_map
    import recompyler.ir as ir
    from recompyler.ir import _entry_native
    from llvmlite import binding
    module=types.ModuleType('fixture_sample_map')
    exec('def f(x): return x',module.__dict__)
    monkeypatch.setitem(sys.modules,module.__name__,module)
    monkeypatch.setattr(ir,'compilation_info',lambda function:dict(installed=True,body_address=4096))
    owner=types.SimpleNamespace(native_module=object(),body_address=4096)
    monkeypatch.setattr(_entry_native,'_compilation_owner',lambda function:(function.__code__,owner))
    def unexpected():raise AssertionError('profiling map performed LLVM code generation')
    monkeypatch.setattr(binding.Target,'from_default_triple',unexpected)
    session=types.SimpleNamespace(report={'installed':1},selected=lambda name:name==module.__name__)
    result=body_map(session)
    assert result[0]['start']==4096 and result[0]['size']==1
    assert 'entry address only' in result[0]['bounds']

def test_measured_environment_removes_inherited_bytecode_disable(monkeypatch):
    from bench.libs.shared_harness import environment
    monkeypatch.setenv('PYTHONDONTWRITEBYTECODE','1')
    for engine in ('cpython_off','cpython_on','recompyler','pypy'):
        env=environment(engine)
        assert 'PYTHONDONTWRITEBYTECODE' not in env
        assert Path(env['PYTHONPYCACHEPREFIX']).is_relative_to(Path(env['RECOMPYLER_CACHE']).parent)


def test_package_precompile_stays_inside_cache(tmp_path,monkeypatch):
    from bench.libs import bytecode_cache
    root=tmp_path/'clone';(root/'src/pkg').mkdir(parents=True)
    (root/'src/pkg/__init__.py').write_text('value=42\n')
    cache=root/'.cache/pyc';cache.mkdir(parents=True)
    monkeypatch.setattr(bytecode_cache,'ROOT',root)
    monkeypatch.setattr(sys,'pycache_prefix',str(cache))
    monkeypatch.setattr(sys,'dont_write_bytecode',False)
    report=bytecode_cache.precompile()
    assert report['label']=='pyc-fixed' and report['files']==1
    assert list(cache.rglob('*.pyc'))
    assert not (root/'src/pkg/__pycache__').exists()
