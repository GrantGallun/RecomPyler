"""Protected managed-call regions preserve finally effects and active errors."""
import sys
from types import SimpleNamespace
import pytest
from recompyler import heap, lift

pytestmark = pytest.mark.skipif(sys.implementation.name != 'cpython' or sys.version_info < (3, 12), reason='CPython raised-exception transfer')


def protected_call(action, cleanup):
    try:
        return action()
    finally:
        cleanup()


def cleanup_result(action, cleanup):
    try:
        return action()
    finally:
        return cleanup()


def nested_cleanup(action, first, second):
    try:
        try:
            return action()
        finally:
            first()
    finally:
        second()


def test_finally_preserves_result_owner_and_single_effects():
    events=[]
    marker=object()
    def action():events.append('action');return marker
    def cleanup():events.append('cleanup')
    region=heap.lift_structures(protected_call)
    assert region(action,cleanup) is marker
    assert events==['action','cleanup']
    assert region.compiled_calls==1 and region.fallback_calls==0


def test_finally_observes_exact_pending_error_and_does_not_replay():
    events=[]
    error=RuntimeError('original')
    inner=ValueError('inner')
    error.__context__=inner
    def action():events.append('action');raise error
    def cleanup():events.append(sys.exception())
    region=heap.lift_structures(protected_call)
    with pytest.raises(RuntimeError) as caught:region(action,cleanup)
    assert caught.value is error and error.__context__ is inner
    assert events==['action',error]
    assert region.compiled_calls==1 and region.fallback_calls==0


def test_finally_return_overrides_error_with_original_owner():
    events=[]
    marker=object()
    error=RuntimeError('suppressed')
    def action():events.append('action');raise error
    def cleanup():events.append(sys.exception());return marker
    region=heap.lift_structures(cleanup_result)
    assert region(action,cleanup) is marker
    assert events==['action',error]
    assert region.compiled_calls==1 and region.fallback_calls==0


def test_nested_finalizers_run_once_in_order():
    events=[]
    marker=object()
    def action():events.append('action');return marker
    def first():events.append('first')
    def second():events.append('second')
    region=heap.lift_structures(nested_cleanup)
    assert region(action,first,second) is marker
    assert events==['action','first','second']
    assert region.compiled_calls==1 and region.fallback_calls==0


@pytest.mark.skipif(sys.version_info[:2] != (3, 14), reason='Numba startup import-from runtime ABI')
def test_real_numba_startup_cleans_up_under_original_error(monkeypatch):
    from numba.core.registry import cpu_target
    region=heap.lift_structures(lift._start_numba)
    events=[]
    error=ValueError('refresh failure')
    class Path(list):
        def insert(self,index,value):events.append('insert');super().insert(index,value)
        def remove(self,value):events.append(sys.exception());super().remove(value)
    path=Path()
    fake_sys=SimpleNamespace(modules={},meta_path=path)
    monkeypatch.setattr(lift,'sys',fake_sys)
    def refresh():events.append('refresh');raise error
    monkeypatch.setattr(cpu_target.target_context,'refresh',refresh)
    with pytest.raises(ValueError) as caught:region()
    assert caught.value is error
    assert path==[] and events==['insert','refresh',error]
    assert region.compiled_calls==1 and region.fallback_calls==0


def test_finalizer_exception_keeps_its_inner_context():
    body_error=ValueError('body')
    def action():raise body_error
    def cleanup():
        try:raise LookupError('cleanup inner')
        except LookupError:raise RuntimeError('cleanup outer')
    region=heap.lift_structures(protected_call)
    with pytest.raises(RuntimeError) as caught:region(action,cleanup)
    assert type(caught.value.__context__) is LookupError
    assert caught.value.__context__.__context__ is body_error
    assert region.compiled_calls==1 and region.fallback_calls==0


def test_protected_calls_are_reentrant_without_frame_or_counter_aliases():
    events=[]
    marker=object()
    region=heap.lift_structures(protected_call)
    def inner():events.append('inner');return marker
    def inner_cleanup():events.append('inner cleanup')
    def outer():events.append('outer');return region(inner,inner_cleanup)
    def outer_cleanup():events.append('outer cleanup')
    assert region(outer,outer_cleanup) is marker
    assert events==['outer','inner','inner cleanup','outer cleanup']
    assert region.compiled_calls==2 and region.fallback_calls==0


@pytest.mark.skipif(sys.version_info[:2] != (3, 14), reason='Numba startup import-from runtime ABI')
def test_real_numba_startup_success_preserves_cleanup_order(monkeypatch):
    from numba.core.registry import cpu_target
    region=heap.lift_structures(lift._start_numba)
    events=[]
    class Path(list):
        def insert(self,index,value):events.append('insert');super().insert(index,value)
        def remove(self,value):events.append('remove');super().remove(value)
    path=Path()
    monkeypatch.setattr(lift,'sys',SimpleNamespace(modules={},meta_path=path))
    monkeypatch.setattr(cpu_target.target_context,'refresh',lambda:events.append('refresh'))
    monkeypatch.setattr(lift,'_keep_refcount_pass',lambda:events.append('keep'))
    assert region() is None
    assert path==[] and events==['insert','refresh','keep','remove']
    assert region.compiled_calls==1 and region.fallback_calls==0


def protected_attribute(value):
    try:
        value.missing
    finally:
        pass


def mutating_finally(items, item):
    try:
        items.append(item)
        return items
    finally:
        items.append(None)


def test_protected_error_transfer_has_no_additional_reference_cycle():
    import gc
    import weakref
    class Value:pass
    region=heap.lift_structures(protected_attribute)
    def invoke(call):
        value=Value()
        reference=weakref.ref(value)
        try:call(value)
        except AttributeError:pass
        del value
        return reference
    enabled=gc.isenabled()
    gc.disable()
    try:
        assert invoke(protected_attribute)() is None
        assert invoke(region)() is None
    finally:
        if enabled:gc.enable()
    assert region.compiled_calls==1 and region.fallback_calls==0


def test_finally_mutates_the_original_shared_argument_once():
    items=[]
    marker=object()
    region=heap.lift_structures(mutating_finally)
    assert region(items,marker) is items
    assert len(items)==2 and items[0] is marker and items[1] is None
    assert region.compiled_calls==1 and region.fallback_calls==0


@pytest.mark.parametrize('kind',[KeyboardInterrupt,SystemExit,GeneratorExit])
def test_finally_runs_for_base_exceptions(kind):
    error=kind('protected')
    events=[]
    def action():raise error
    def cleanup():events.append(sys.exception())
    region=heap.lift_structures(protected_call)
    with pytest.raises(kind) as caught:region(action,cleanup)
    assert caught.value is error and events==[error]
    assert region.compiled_calls==1 and region.fallback_calls==0


def test_failed_finalizer_releases_discarded_return_before_caller_catches():
    def execute(call):
        events=[]
        class Result:
            def __del__(self):
                active=sys.exception()
                events.append(('destroy',type(active).__name__ if active is not None else None))
        error=RuntimeError('cleanup')
        def action():return Result()
        def cleanup():events.append('cleanup');raise error
        try:call(action,cleanup)
        except RuntimeError:events.append('caught')
        return events,error
    plain,error=execute(protected_call)
    region=heap.lift_structures(protected_call)
    native,native_error=execute(region)
    assert native==plain
    assert region.compiled_calls==1 and region.fallback_calls==0


def return_pending_error(action):
    try:
        action()
    finally:
        return sys.exception()


def test_returned_pending_exception_has_no_new_reference_cycle():
    import gc
    import weakref
    class Marker:pass
    references=[]
    def factory():
        marker=Marker()
        error=ValueError('returned')
        error.marker=marker
        references.append(weakref.ref(marker))
        return error
    def action():raise factory()
    region=heap.lift_structures(return_pending_error)
    enabled=gc.isenabled()
    gc.disable()
    try:
        result=return_pending_error(action)
        del result
        assert references[-1]() is None
        result=region(action)
        del result
        assert references[-1]() is None
    finally:
        if enabled:gc.enable()
    assert region.compiled_calls==1 and region.fallback_calls==0
