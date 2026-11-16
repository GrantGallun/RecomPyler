"""Prepared-region candidate observations retain canonical baseline workers."""
import json
from pathlib import Path
from types import SimpleNamespace


def test_prepared_candidate_never_claims_default_installation(monkeypatch,tmp_path):
    from bench.libs import prepared_worker as worker
    from recompyler import heap,_prepared as pc
    path=tmp_path/'section.json';path.write_text(json.dumps({'functions':[{'function':'target'}]}))
    fn=lambda:42
    index=SimpleNamespace(exports={})
    monkeypatch.setattr(pc,'open_index',lambda section,row,**kw:index)
    region=SimpleNamespace(compiled_calls=3,aot_calls=3,jit_calls=0,fallback_calls=0)
    monkeypatch.setattr(heap,'lift_region',lambda original,**kw:region)
    assert worker.load_candidate(fn,path) is region
    snapshot=worker.candidate_snapshot(region)
    assert snapshot['installed']==0 and snapshot['installed_ids']==[]
    assert snapshot['candidate_native_calls']==3 and snapshot['candidate_aot_calls']==3


def test_prepared_candidate_missing_index_fails_before_execution(monkeypatch,tmp_path):
    import pytest
    from bench.libs import prepared_worker as worker
    from recompyler import heap,_prepared as pc
    path=tmp_path/'section.json';path.write_text(json.dumps({'functions':[{}]}))
    monkeypatch.setattr(pc,'open_index',lambda *a,**kw:None)
    monkeypatch.setattr(pc,'last_miss',lambda:'stale artifact')
    monkeypatch.setattr(heap,'lift_region',lambda *a,**kw:pytest.fail('unverified artifact acquired execution'))
    with pytest.raises(ValueError,match='stale artifact'):worker.load_candidate(lambda:42,path)
