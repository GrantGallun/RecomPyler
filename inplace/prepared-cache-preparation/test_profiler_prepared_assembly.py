"""Plan freezing uses the real profiler orchestration and unchanged gate."""
import json
from types import SimpleNamespace
import pytest
from recompyler import profiler

@pytest.mark.parametrize('build_fails', [False, True])
def test_full_primitive_plan_is_frozen_before_native_build(tmp_path, monkeypatch, build_fails):
    script = tmp_path / 'script.py'
    script.write_text('pass\n')
    def fn(x): return x
    key = (str(script), 'work', 1)
    sample = SimpleNamespace(function=fn, samples=[((1,),1,(1,))], signatures={('int',):1},
                             list_reuse=0., generator=False, extra=lambda:())
    class Monitor:
        backend = 'synthetic'
        total_s = 1.
        def __init__(self, *args, **kwargs):
            self.samplers = {key:sample}
            self.skipped = {}
        def __enter__(self): return self
        def __exit__(self,*args): return False
        def rows(self): return [dict(_key=key,file=str(script),function='work',line=1,calls=20,self_s=1.,cumulative_s=1.)]
    monkeypatch.setattr(profiler, 'CallMonitor', Monitor)
    monkeypatch.setattr(profiler.importlib.util, 'find_spec', lambda name: object())
    candidate = dict(status='verified',recommended=True,engine='region',net_s_cached=1.,
                     batch_backends={},_region=object(),_captured=object())
    monkeypatch.setattr(profiler, 'test_candidate', lambda *a,**k:dict(candidate))
    gates = []
    def gate(chosen, section=None, region_section=None):
        gates.append(region_section)
        result = dict(startup_s=.1,saving_s=1.,worth_running=True)
        if region_section is not None: result['aot_regions'] = region_section
        return result
    monkeypatch.setattr(profiler, 'run_plan', gate)
    snapshots = []
    def build(entries, *, plan_factory=None):
        assert plan_factory is not None, 'no full-plan freeze before native compilation'
        preview = dict(functions=[dict(function='work',line=1,exports={'digest':'r0'},seeds={})])
        snapshot = plan_factory(preview)
        json.dumps(snapshot, allow_nan=False)  # excludes live compiler instances
        assert snapshot['mode'] == 'saved' and snapshot['force'] is False
        assert snapshot['script'] == str(script)
        assert snapshot['functions'][0]['candidate']['recommended'] is True
        assert snapshot['plan']['aot_regions'] is preview
        assert all(not k.startswith('_') for k in snapshot['functions'][0]['candidate'])
        snapshots.append(snapshot)
        if build_fails: return None
        preview.update(module='new_native',folder=str(tmp_path),prepared={'seal':'new'})
        return preview
    monkeypatch.setattr(profiler, 'build_regions_ahead_of_time', build)
    report = profiler.profile_script(script, [], 128, 8, True)
    assert len(snapshots) == 1
    assert len(gates) == (2 if build_fails else 1)
    if build_fails: assert 'aot_regions' not in report['plan']
    else: assert report['plan']['aot_regions']['module'] == 'new_native'
