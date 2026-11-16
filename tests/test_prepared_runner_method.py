import json
import pytest
from test_prepared_cache import load_source

@pytest.fixture(scope='module')
def method_artifact(tmp_path_factory):
    from recompyler import heap,profiler
    folder=tmp_path_factory.mktemp('runner-method')
    source=folder/'method_workload.py'
    source.write_text("class Box:\n    def __init__(self,value): self.value=value\n    def read(self): return self.value\nif __name__=='__main__': print(Box(10).read())\n")
    module=load_source(source);fn=module.Box.read
    region=heap.lift_region(fn)
    assert region(module.Box(10))==10 and region.compiled_calls==1
    candidate=dict(status='verified',recommended=True,engine='region',net_s_cached=1.,python_us_per_call=10.,batch_backends={})
    report=dict(script=str(source),functions=[dict(file=str(source),function='read',qualname='Box.read',line=fn.__code__.co_firstlineno,calls=1,candidate=candidate)],mode='saved',force=False)
    def factory(preview):
        report['plan']=profiler.run_plan([candidate],None,preview)
        return report
    with pytest.MonkeyPatch.context() as patch:
        patch.setattr(profiler,'process_startup',lambda **k:.01)
        section=heap.build_regions([(('read',fn.__code__.co_firstlineno),fn,region)],folder,plan_factory=factory)
    assert section and section['prepared']['cores']
    plan=folder/'plan.json';plan.write_text(json.dumps(report))
    return source,plan

@pytest.mark.parametrize('mutation',['code','marker','metadata-subclass','metadata-key'])
def test_selected_class_method_hits_and_late_adapter_change_declines(method_artifact,monkeypatch,capsys,mutation):
    from recompyler import heap,_prepared as pc
    from recompyler.runner import run_script
    source,plan=method_artifact;regions=[];original=heap.lift_region
    def lift(*a,**kw):
        value=original(*a,**kw);regions.append(value);return value
    def forbidden(*a,**kw): raise AssertionError(('regeneration',pc.last_miss()))
    monkeypatch.setattr(heap,'lift_region',lift)
    monkeypatch.setattr(heap.Region,'_make_program',forbidden)
    result=run_script(source,[],plan,False)
    assert capsys.readouterr().out=='10\n'
    assert result['functions'][0]['aot_calls']==1
    region=regions[0]
    assert region.prepared_hits==1 and region.jit_calls==region.fallback_calls==0
    module=region.original.__globals__;wrapper=module['Box'].read
    events=[]
    if mutation=='code': wrapper.__code__=wrapper.__code__.replace(co_consts=wrapper.__code__.co_consts+('changed',))
    elif mutation=='marker': wrapper.__recompyler_original__=lambda self:999
    else:
        class Hostile(dict):
            def get(self,key,default=None):events.append('get');return default
            def __contains__(self,key):events.append('contains');return False
        class Key:
            def __hash__(self):return hash('__recompyler_original__')
            def __eq__(self,other):events.append('equal');return False
        if mutation=='metadata-subclass':wrapper.__dict__=Hostile(wrapper.__dict__)
        else:
            wrapper.__dict__.pop('__recompyler_original__')
            wrapper.__dict__[Key()]=None
        events.clear()
    assert region.attempt((module['Box'](20),))==(False,None)
    assert events==[]


@pytest.mark.parametrize('shape',['subclass','foreign-key'])
def test_function_attribute_metadata_never_runs_user_hooks(shape):
    from recompyler import _prepared as pc,_runner_wrapper as rw
    events=[]
    class Hostile(dict):
        def __contains__(self,key): events.append('contains');return False
        def get(self,key,default=None):events.append('get');return default
    class Key:
        def __hash__(self):return hash('__recompyler_original__')
        def __eq__(self,other):events.append('equal');return False
    def fn():return 1
    fn.__dict__=Hostile() if shape=='subclass' else {Key():1}
    events.clear()
    assert rw.original(fn) is None
    with pytest.raises(pc.PreparedMiss):pc._plain_function(fn)
    assert events==[]

@pytest.fixture(scope='module')
def two_method_artifact(tmp_path_factory):
    from recompyler import heap, profiler
    folder = tmp_path_factory.mktemp('runner-two-methods')
    source = folder / 'two_methods.py'
    source.write_text("class Box:\n    def __init__(self, value): self.value = value\n    def read(self): return self.value\n    def work(self): return self.read() + 1\nif __name__ == '__main__': print(Box(10).work())\n")
    module = load_source(source)
    entries, rows = [], []
    for name in ('read', 'work'):
        fn = vars(module.Box)[name]
        region = heap.lift_region(fn)
        assert region(module.Box(10)) == (10 if name == 'read' else 11)
        assert region.compiled_calls == 1
        candidate = dict(status='verified', recommended=True, engine='region', net_s_cached=1., python_us_per_call=10., batch_backends={})
        entries.append(((name, fn.__code__.co_firstlineno), fn, region))
        rows.append(dict(file=str(source), function=name, qualname='Box.' + name, line=fn.__code__.co_firstlineno, calls=1, candidate=candidate))
    report = dict(script=str(source), functions=rows, mode='saved', force=False)
    def factory(preview):
        report['plan'] = profiler.run_plan([row['candidate'] for row in rows], None, preview)
        return report
    with pytest.MonkeyPatch.context() as patch:
        patch.setattr(profiler, 'process_startup', lambda **kw: .01)
        section = heap.build_regions(entries, folder, plan_factory=factory)
    assert section and section['prepared']['cores']
    plan = folder / 'plan.json'
    plan.write_text(json.dumps(report))
    return source, plan


def test_selected_method_can_bind_another_selected_methods_original(two_method_artifact, monkeypatch, capsys):
    from recompyler import heap, _prepared as pc
    from recompyler.runner import run_script
    source, plan = two_method_artifact
    regions = []
    original = heap.lift_region
    def lift(*args, **kwargs):
        region = original(*args, **kwargs)
        regions.append(region)
        return region
    def forbidden(*args, **kwargs):
        raise AssertionError(('regeneration', pc.last_miss()))
    monkeypatch.setattr(heap, 'lift_region', lift)
    monkeypatch.setattr(heap.Region, '_make_program', forbidden)
    result = run_script(source, [], plan, False)
    assert capsys.readouterr().out == '11\n'
    work = next(region for region in regions if region.original.__name__ == 'work')
    read = vars(work.original.__globals__['Box'])['read']
    refs = pc.References(work.original)
    recipe = refs.ref(pc._plain_function(read))
    assert pc._plain_function(refs.resolve(recipe)) is pc._plain_function(read)
    assert work.prepared_hits == 1
    assert work.aot_calls == 1 and work.jit_calls == work.fallback_calls == 0
    assert sum(row['aot_calls'] for row in result['functions']) == 1
