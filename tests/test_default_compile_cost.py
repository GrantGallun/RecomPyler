"""Offline compilation needs enough measured Python self time to repay its cost."""
from pathlib import Path
import itertools
import sys
import weakref
import gc
import pytest

sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))


def test_nested_profile_charges_only_self_time_without_retaining_functions():
    from bench.libs.diagnose import collect_calls
    def child():return 3
    def run():return child()+child()
    value,rows=collect_calls(run,__name__,clock=lambda:next(ticks))
    assert value==6
    observed={row['name'].rsplit('.',1)[-1]:row for row in rows}
    assert observed['child']['calls']==2 and observed['child']['self_seconds']==2
    assert observed['run']['self_seconds']==3
    reference=weakref.ref(run)
    del run
    gc.collect()
    assert reference() is None


ticks=iter(())


@pytest.fixture(autouse=True)
def fresh_clock():
    global ticks
    ticks=itertools.count()


@pytest.mark.parametrize('self_seconds,expected_runs,compile_seconds,eligible',[
    (.25,100,.1,True),(.001,10,.1,False),(0,100,.1,False),(.1,0,.1,False),(.1,10,.1,False),
])
def test_optimistic_saved_time_must_exceed_compile_cost(self_seconds,expected_runs,compile_seconds,eligible):
    from default_installation import payback_bound
    row=payback_bound(self_seconds=self_seconds,profile_runs=10,expected_runs=expected_runs,
                      compile_seconds=compile_seconds)
    assert row['eligible'] is eligible
    assert row['projected_saved_seconds']<=self_seconds*expected_runs/10


@pytest.mark.parametrize('values',[
    {'self_seconds':float('nan')},{'self_seconds':-1},{'profile_runs':0},
    {'expected_runs':True},{'compile_seconds':0},{'compile_seconds':float('inf')},
])
def test_invalid_profile_cost_cannot_admit_compilation(values):
    from default_installation import payback_bound
    options=dict(self_seconds=1,profile_runs=1,expected_runs=100,compile_seconds=.1)
    options.update(values)
    with pytest.raises(ValueError):payback_bound(**options)


def test_hopeless_profile_never_prepares_native_code():
    from default_installation import select_workload
    from test_default_installation import harness,target
    prepared,prepare,run,measure=harness()
    selection=select_workload(run=run,functions=[(target,100)],prepare=prepare,measure=measure,
        digest=lambda value:value,compile_admission=lambda function,calls:{'eligible':False})
    assert not prepared and selection.report['installed_default']==0
    assert selection.report['rows'][0]['status']=='compile-cost-not-repaid'


def test_faster_calls_do_not_install_when_measured_compile_cost_is_not_repaid(monkeypatch):
    import default_installation as policy
    from test_default_installation import harness,target
    prepared,prepare,run,measure=harness()
    clock=iter([10,110])
    monkeypatch.setattr(policy,'perf_counter',lambda:next(clock))
    selection=policy.select_workload(run=run,functions=[(target,100)],prepare=prepare,measure=measure,
        digest=lambda value:value,expected_runs=10)
    assert selection.report['installed_default']==0
    assert selection.report['rows'][0]['status']=='compile-cost-not-repaid'
    assert not any(candidate.active for candidate in prepared)


def test_offline_profile_rejects_cold_cost_before_preparing_any_body(tmp_path,monkeypatch):
    import weakref
    from default_installation import select_profiled_workload
    from bench.libs import diagnose
    lock=tmp_path/'TIMING.lock';lock.mkdir();(lock/'owner.txt').write_text('wave18-lift\n')
    def target(value):return value
    def run():return 42
    observed=dict(function=weakref.ref(target),code=weakref.ref(target.__code__),
                  function_id=id(target),code_id=id(target.__code__),calls=100,self_seconds=.000001,
                  name='fixture.target',filename=__file__,line=1,origin='package')
    monkeypatch.setattr(diagnose,'collect_calls',lambda *args,**kwargs:(42,[observed]))
    prepared=[]
    selection=select_profiled_workload(run,'fixture',lock=lock,repeats=1,expected_runs=64,
        prepare=lambda *args,**kwargs:prepared.append(args))
    assert not prepared
    assert selection.report['installed_default']==0
    assert selection.report['rows'][0]['status']=='compile-cost-not-repaid'


def test_offline_profile_requires_our_lock_before_invoking_workload(tmp_path):
    from default_installation import select_profiled_workload
    lock=tmp_path/'TIMING.lock';lock.mkdir();(lock/'owner.txt').write_text('another-run\n')
    called=[]
    with pytest.raises(RuntimeError,match='lock'):
        select_profiled_workload(lambda:called.append(1),'fixture',lock=lock,repeats=1)
    assert not called
