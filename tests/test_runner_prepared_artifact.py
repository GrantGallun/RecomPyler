"""Prepared metadata never routes an invalid artifact through the legacy loader."""
import json
from types import SimpleNamespace, ModuleType
import sys
import pytest

@pytest.mark.parametrize('kind', ['absent','null','bad-core','bad-artifact','verified'])
def test_runner_validates_present_prepared_payload_before_legacy_load(tmp_path, monkeypatch, kind):
    from recompyler import runner, heap, aot
    import recompyler
    script = tmp_path / 'work.py'
    script.write_text('def work(x):\n    return x + 1\nassert work(10) == 11\n')
    section = dict(module='unused_native',folder=str(tmp_path),functions=[dict(function='work',line=1,exports={'digest':'r0'})])
    if kind != 'absent': section['prepared'] = None if kind == 'null' else {'fixture':'present'}
    data = dict(script=str(script),functions=[dict(function='work',line=1,candidate=dict(status='verified',recommended=True,engine='region'))],
                plan=dict(worth_running=True,aot_regions=section))
    plan = tmp_path / 'plan.json'; plan.write_text(json.dumps(data))
    old_loads, opens, lifts = [], [], []
    export = lambda *args: None
    native = SimpleNamespace(r0=export)
    index = SimpleNamespace(module=native,exports={'digest':export},bind=lambda fn:[])
    pc = ModuleType('recompyler._prepared')
    class PreparedArtifactMismatch(Exception): pass
    pc.PreparedArtifactMismatch = PreparedArtifactMismatch
    def open_index(received, row, *, plan_snapshot, module=None):
        opens.append(plan_snapshot)
        assert plan_snapshot['functions'] == data['functions']
        assert plan_snapshot['mode'] == 'saved' and plan_snapshot['force'] is False
        if kind == 'bad-artifact': raise PreparedArtifactMismatch('changed artifact')
        return index if kind == 'verified' else None
    pc.open_index = open_index
    monkeypatch.setitem(sys.modules, 'recompyler._prepared', pc)
    monkeypatch.setattr(recompyler, '_prepared', pc, raising=False)
    def old_load(section): old_loads.append(section); return native
    monkeypatch.setattr(aot, 'load', old_load)
    def lift(fn, exports, **kwargs): lifts.append((exports,kwargs)); return None
    monkeypatch.setattr(heap, 'lift_region', lift)
    runner.run_script(script, [], plan)
    assert len(old_loads) == (1 if kind == 'absent' else 0)
    assert len(opens) == (0 if kind == 'absent' else 1)
    assert len(lifts) == 1
    exports, kwargs = lifts[0]
    assert exports.allow_jit is False
    if kind in ('verified','absent'): assert exports['digest'] is export
    else: assert not dict(exports)
    if kind == 'verified': assert kwargs['prepared'] is index
