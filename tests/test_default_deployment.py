"""Public default deployment must use the measured ordinary frameless owner."""
from pathlib import Path
import sys
import pytest

sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))


def test_published_winner_installs_through_public_default_policy():
    from recompyler.ir import compile_function,compilation_info,_entry_native
    from recompyler.ir.compiler import _frameless_candidates
    from default_installation import publish_canonical_measurement
    def getter(value): return value.answer
    compile_function(getter,strict=True)
    candidate=_frameless_candidates[getter]
    try:
        assert not candidate.active
        # Deterministic policy fixture, never performance evidence.
        publish_canonical_measurement(getter,candidate,{'python_seconds':[2]*3,'native_seconds':[1]*3})
        assert compilation_info(getter)['installed'], 'verified receipt did not activate public default policy'
        assert candidate.active
    finally:
        candidate.close();_entry_native.forget_compilation(getter)


def test_hook_requires_portable_artifact_for_prepared_frameless_handle(tmp_path):
    import types
    from recompyler.ir import compile_function,compilation_info,_entry_native
    from recompyler.ir.compiler import _frameless_candidates,_record_measurement
    from recompyler.libraries.cache import DecisionCache
    from recompyler.libraries.hook import enable,disable
    module=types.ModuleType('fixture_frameless_default')
    exec('def getter(value): return value.answer',module.__dict__)
    sys.modules[module.__name__]=module
    candidate=None
    try:
        compile_function(module.getter,strict=True)
        candidate=_frameless_candidates[module.getter]
        _record_measurement(module.getter,2,1) # Policy fixture only.
        cache=DecisionCache(tmp_path/'cache',compiler_tag='default-fixture')
        cache.record(module.getter,calls=100,cpython_ns=2,native_ns=1,verified=True)
        session=enable(packages=(module.__name__,),cache=cache)
        assert not compilation_info(module.getter)['installed']
        assert session.report['installed']==0 and session.handles==[]
        assert 'prepare offline' in session.report['declined'][0]['reason']
        disable()
        assert not candidate.active, 'library close left its ordinary slot installed'
    finally:
        disable()
        if candidate is not None:candidate.close()
        _entry_native.forget_compilation(module.getter)
        sys.modules.pop(module.__name__,None)


def test_shared_observer_forwards_explicit_worker_module(monkeypatch):
    import json
    from types import SimpleNamespace
    from bench.libs import shared_harness as harness
    calls=[]
    def run(command,**kwargs):
        calls.append((command,kwargs))
        return SimpleNamespace(returncode=0,stdout=json.dumps({'status':'ok'}),stderr='')
    monkeypatch.setattr(harness.subprocess,'run',run)
    harness.observe('json_encode','recompyler',worker_module='tools.default_program_worker')
    assert calls[0][0][1:3]==['-m','tools.default_program_worker']


def test_shared_timing_lock_records_configured_owner_and_ledger(tmp_path):
    from bench.libs.runner import timing_lock
    lock=tmp_path/'TIMING.lock';ledger=tmp_path/'wave18.md'
    with timing_lock(lock,ledger,run_name='wave18-lift',purpose='fixture'):
        assert (lock/'owner.txt').read_text().splitlines()[0]=='wave18-lift'
    assert not lock.exists()
    receipt=ledger.read_text()
    assert 'TIMING acquire' in receipt and 'TIMING release' in receipt


def test_selector_source_participates_in_measurement_fingerprint(tmp_path,monkeypatch):
    from bench.libs import shared_harness as harness
    (tmp_path/'src').mkdir()
    (tmp_path/'bench/libs').mkdir(parents=True)
    (tmp_path/'tools').mkdir()
    selector=tmp_path/'tools/default_installation.py'
    selector.write_text('policy = 1\n')
    monkeypatch.setattr(harness,'ROOT',tmp_path)
    before=harness.source_fingerprint()
    selector.write_text('policy = 2\n')
    assert harness.source_fingerprint()!=before, 'resume accepted a changed deployment selector'


def test_suite_runner_keeps_new_evidence_in_untracked_cache(tmp_path,monkeypatch):
    from types import SimpleNamespace
    monkeypatch.syspath_prepend(str(Path(__file__).resolve().parents[1]/'tools'))
    import full_suite
    root=tmp_path/'checkout';(root/'tests').mkdir(parents=True)
    (root/'tests/test_one.py').write_text('def test_one():pass\n')
    monkeypatch.setattr(full_suite,'__file__',str(root/'tools/full_suite.py'))
    def run(command,**kwargs):
        assert Path(kwargs['stdout'].name).is_relative_to(root/'.cache'), 'evidence leaked into product tree'
        return SimpleNamespace(returncode=0)
    monkeypatch.setattr(full_suite.subprocess,'run',run)
    assert full_suite.main(['evidence','--workers','1'])==0
