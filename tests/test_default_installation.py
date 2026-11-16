"""Selection never installs an unexercised, slower or changed native body."""
from pathlib import Path
import sys
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))
import pytest


def target(value): return value


class Candidate:
    def __init__(self, function, counted):
        self.function = function
        self.counted = counted
        self.body_address = 123 if counted else 456
        self.native_calls = 0
        self.active = False
        self.closed = 0
    def install(self):
        self.active = True
        return self
    def close(self):
        self.active = False
        self.closed += 1


def harness(*, native=1.0, stock=2.0, hit=True, wrong=False):
    prepared=[]
    def prepare(function, *, counted=False):
        candidate=Candidate(function,counted);prepared.append(candidate)
        return candidate
    def run():
        for c in prepared:
            if c.active and c.counted and hit: c.native_calls += 1
        return 'wrong' if wrong and any(c.active for c in prepared) else 'same'
    def measure(function):
        function()
        return native if any(c.active for c in prepared) else stock
    return prepared,prepare,run,measure


def select(**options):
    from default_installation import select_workload
    return select_workload(**options)


def test_selection_installs_every_hot_exercised_faster_candidate():
    prepared,prepare,run,measure=harness()
    selection=select(run=run,functions=[(target,100)],prepare=prepare,measure=measure,digest=lambda x:x)
    assert selection.report['installed_default']==1
    assert prepared[-1].active and not prepared[-1].counted
    selection.close()
    assert not any(c.active for c in prepared)


@pytest.mark.parametrize('options,reason',[
    ({'native':3.0},'slower'),({'hit':False},'not-exercised'),
])
def test_slower_and_zero_hit_candidates_remain_python(options,reason):
    prepared,prepare,run,measure=harness(**options)
    selection=select(run=run,functions=[(target,100)],prepare=prepare,measure=measure,digest=lambda x:x)
    assert selection.report['installed_default']==0
    assert selection.report['rows'][0]['status']==reason
    assert not any(c.active for c in prepared)


def test_cold_functions_are_never_compiled():
    prepared,prepare,run,measure=harness()
    selection=select(run=run,functions=[(target,99)],prepare=prepare,measure=measure,digest=lambda x:x)
    assert not prepared and selection.report['installed_default']==0


def test_wrong_result_closes_all_handles_and_fails_selection():
    prepared,prepare,run,measure=harness(wrong=True)
    with pytest.raises(AssertionError,match='output'):
        select(run=run,functions=[(target,100)],prepare=prepare,measure=measure,digest=lambda x:x)
    assert not any(c.active for c in prepared)


def test_measurement_failure_restores_python():
    prepared,prepare,run,measure=harness()
    def failed(run):
        raise RuntimeError('literal measurement failure')
    with pytest.raises(RuntimeError,match='literal'):
        select(run=run,functions=[(target,100)],prepare=prepare,measure=failed,digest=lambda x:x)
    assert not any(c.active for c in prepared)


def test_combined_winners_are_checked_against_original_output():
    from types import FunctionType
    second=FunctionType(target.__code__,globals())
    prepared,prepare,run,measure=harness()
    def combined():
        run()
        return 'wrong' if sum(c.active for c in prepared)>1 else 'same'
    with pytest.raises(AssertionError,match='output'):
        select(run=combined,functions=[(target,100),(second,100)],prepare=prepare,measure=measure,digest=lambda x:x)
    assert not any(c.active for c in prepared)


@pytest.mark.parametrize('elapsed',[0,-1,float('nan'),float('inf'),True])
def test_invalid_measurement_cannot_install_a_body(elapsed):
    prepared,prepare,run,measure=harness()
    with pytest.raises(ValueError,match='finite'):
        select(run=run,functions=[(target,100)],prepare=prepare,measure=lambda r:elapsed,digest=lambda x:x)
    assert not any(c.active for c in prepared)


def test_tied_measurements_leave_original_python():
    prepared,prepare,run,measure=harness(native=2.0,stock=2.0)
    selection=select(run=run,functions=[(target,100)],prepare=prepare,measure=measure,digest=lambda x:x)
    assert selection.report['installed_default']==0
    assert not any(c.active for c in prepared)


def test_source_change_during_measurement_discards_exact_body():
    from types import FunctionType
    fn=FunctionType(target.__code__,globals())
    def changed(value): return value+1
    prepared,prepare,run,measure=harness()
    def mutate(run):
        value=measure(run)
        fn.__code__=changed.__code__
        return value
    selection=select(run=run,functions=[(fn,100)],prepare=prepare,measure=mutate,digest=lambda x:x)
    assert selection.report['installed_default']==0
    assert not any(c.active for c in prepared)


def test_selected_session_does_not_keep_source_functions_alive():
    from types import FunctionType
    import gc,weakref
    fn=FunctionType(target.__code__,globals());reference=weakref.ref(fn)
    prepared,prepare,run,measure=harness()
    class WeakCandidate(Candidate):
        def __init__(self,function,counted):
            super().__init__(None,counted)
    def weak_prepare(function,*,counted=False):
        candidate=WeakCandidate(function,counted);prepared.append(candidate)
        return candidate
    selection=select(run=run,functions=[(fn,100)],prepare=weak_prepare,measure=measure,digest=lambda x:x)
    del fn
    gc.collect()
    assert reference() is None
    selection.close()


def test_workload_timer_requires_our_exact_lock_owner(tmp_path):
    from default_installation import workload_timer
    lock=tmp_path/'TIMING.lock';lock.mkdir()
    (lock/'owner.txt').write_text('wave21-libs\nclass: development\n')
    timer=workload_timer(lock,'wave18-lift',minimum_seconds=0)
    with pytest.raises(RuntimeError,match='lock'):
        timer(lambda:None)


def test_workload_timer_rechecks_ownership_each_sample(tmp_path):
    from default_installation import workload_timer
    lock=tmp_path/'TIMING.lock';lock.mkdir()
    owner=lock/'owner.txt';owner.write_text('wave18-lift\nclass: development\n')
    timer=workload_timer(lock,'wave18-lift',minimum_seconds=0)
    assert timer(lambda:None)>0
    owner.write_text('wave17-matrix\n')
    with pytest.raises(RuntimeError,match='lock'):
        timer(lambda:None)


def test_hotness_for_old_code_cannot_select_replacement_code():
    from types import FunctionType
    import weakref
    fn=FunctionType(target.__code__.replace(),globals())
    profiled=fn.__code__
    def changed(value):return value+1
    fn.__code__=changed.__code__
    prepared,prepare,run,measure=harness()
    selection=select(run=run,functions=[(weakref.ref(fn),100,weakref.ref(profiled))],
                     prepare=prepare,measure=measure,digest=lambda x:x)
    assert not prepared and selection.report['installed_default']==0
    assert selection.report['rows'][0]['status']=='changed'


def test_measurements_publish_only_after_combined_output_passes():
    prepared,prepare,run,measure=harness()
    published=[]
    selection=select(run=run,functions=[(target,100)],prepare=prepare,measure=measure,digest=lambda x:x,
                     publish=lambda fn,candidate,row:published.append((fn,candidate,row['ratio'])))
    assert len(published)==1 and published[0][0] is target
    assert published[0][1] is prepared[-1] and published[0][2]==0.5
    selection.close()


def test_wrong_combined_output_never_publishes_measurements():
    from types import FunctionType
    second=FunctionType(target.__code__,globals())
    prepared,prepare,run,measure=harness()
    def combined():
        run()
        return 'wrong' if sum(c.active for c in prepared)>1 else 'same'
    published=[]
    with pytest.raises(AssertionError,match='output'):
        select(run=combined,functions=[(target,100),(second,100)],prepare=prepare,measure=measure,digest=lambda x:x,
               publish=lambda *args:published.append(args))
    assert not published
