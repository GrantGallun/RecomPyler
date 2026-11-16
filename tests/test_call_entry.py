"""Shared entry-plan and scratch reuse contracts for managed regions."""
import gc
from concurrent.futures import ThreadPoolExecutor
import threading
import weakref
import numpy as np
import pytest
from recompyler import heap


def entry_value(value):
    return value


def entry_action(action):
    return action()


def bound_values(first, /, second=4, *rest, option=5):
    return first, second, rest, option


def default_values(value=None, *, other=None):
    return value, other


def named_self(self):
    return self


def alternate_entry(value):
    return None


def test_warm_entry_does_not_allocate_numpy_scratch(monkeypatch):
    region=heap.lift_calls(entry_value)
    marker=object()
    assert region(marker) is marker
    def allocation(*args,**kwargs):raise AssertionError('warm scratch allocation')
    monkeypatch.setattr(np,'zeros',allocation)
    assert region(marker) is marker
    assert region.compiled_calls==2 and region.fallback_calls==0


def test_reentrant_depth_reuses_distinct_scratch_and_exact_counts(monkeypatch):
    region=heap.lift_calls(entry_action)
    marker=object()
    def inner():return marker
    def outer():return region(inner)
    assert region(outer) is marker
    def allocation(*args,**kwargs):raise AssertionError('warm reentrant scratch allocation')
    monkeypatch.setattr(np,'zeros',allocation)
    assert region(outer) is marker
    assert region.compiled_calls==4 and region.managed_calls==4 and region.fallback_calls==0


def test_named_self_keyword_binds_to_original_parameter():
    region=heap.lift_calls(named_self)
    marker=object()
    assert region(self=marker) is marker
    assert region.compiled_calls==1 and region.fallback_calls==0


def test_binding_plan_reads_current_defaults_and_keyword_values():
    region=heap.lift_calls(bound_values)
    defaults,keywords=bound_values.__defaults__,dict(bound_values.__kwdefaults__)
    marker=object()
    try:
        assert region(marker)==(marker,4,(),5)
        bound_values.__defaults__=(marker,)
        bound_values.__kwdefaults__['option']=marker
        result=region(marker)
        assert result[0] is result[1] is result[3] is marker
        result=region(marker,1,2,3,option=marker)
        assert result[2]==(2,3) and result[3] is marker
    finally:
        bound_values.__defaults__=defaults;bound_values.__kwdefaults__=keywords
    assert region.compiled_calls==3 and region.fallback_calls==0


def test_binding_plan_does_not_pin_replaced_default_owners():
    class Marker:pass
    defaults,keywords=default_values.__defaults__,default_values.__kwdefaults__
    first,second=Marker(),Marker()
    refs=weakref.ref(first),weakref.ref(second)
    default_values.__defaults__=(first,)
    default_values.__kwdefaults__={'other':second}
    enabled=gc.isenabled();gc.disable()
    try:
        region=heap.lift_calls(default_values)
        default_values.__defaults__=None;default_values.__kwdefaults__=None
        del first,second
        assert refs[0]() is None and refs[1]() is None
    finally:
        default_values.__defaults__=defaults;default_values.__kwdefaults__=keywords
        if enabled:gc.enable()


def test_two_threads_keep_private_counters_and_result_owners():
    region=heap.lift_calls(entry_action)
    barrier=threading.Barrier(2)
    markers=object(),object()
    def invoke(marker):
        def action():barrier.wait(timeout=10);return marker
        return region(action)
    with ThreadPoolExecutor(max_workers=2) as pool:
        jobs=[pool.submit(invoke,marker) for marker in markers]
        result=[job.result(timeout=20) for job in jobs]
    assert all(actual is expected for actual,expected in zip(result,markers))
    assert region.compiled_calls==2 and region.managed_calls==2 and region.fallback_calls==0


def test_error_exit_releases_scratch_and_resets_counts(monkeypatch):
    region=heap.lift_calls(entry_action)
    marker=object();error=ValueError('owned')
    def value():return marker
    def failure():raise error
    assert region(value) is marker
    def allocation(*args,**kwargs):raise AssertionError('scratch was not returned after failure')
    monkeypatch.setattr(np,'zeros',allocation)
    with pytest.raises(ValueError) as caught:region(failure)
    assert caught.value is error
    assert region(value) is marker
    assert region.compiled_calls==3 and region.managed_calls==3 and region.fallback_calls==0


def test_changed_code_declines_before_using_cached_argument_names():
    region=heap.lift_calls(entry_value)
    original=entry_value.__code__
    try:
        entry_value.__code__=alternate_entry.__code__
        assert region(object()) is None
    finally:entry_value.__code__=original
    assert region.compiled_calls==0 and region.fallback_calls==1


def test_metadata_subclasses_decline_without_guard_callbacks():
    events=[]
    class Defaults(dict):
        def __iter__(self):events.append('iter');raise AssertionError('metadata hook')
        def get(self,*args):events.append('get');raise AssertionError('metadata hook')
    region=heap.lift_calls(default_values)
    original=default_values.__kwdefaults__
    marker=object()
    try:
        default_values.__kwdefaults__=Defaults(other=marker)
        result=region(marker)
        assert result[0] is result[1] is marker
    finally:default_values.__kwdefaults__=original
    assert events==[] and region.compiled_calls==0 and region.fallback_calls==1


@pytest.mark.parametrize('args,kwargs',[
    ((), {}), ((1, 2), {'second': 3}), ((1,), {'first': 2}),
    ((1,), {'unknown': 2}), ((), {'second': 2}),
])
def test_binding_errors_belong_to_original_function(args, kwargs):
    region = heap.lift_calls(bound_values)
    def observe(call):
        try:
            call(*args, **kwargs)
        except TypeError as error:
            return type(error), str(error), error.__context__, error.__cause__
        raise AssertionError('missing binding error')
    assert observe(region) == observe(bound_values)
    assert region.compiled_calls == 0 and region.fallback_calls == 1


def test_warm_binding_does_not_retain_replaced_defaults():
    class Marker: pass
    defaults, keywords = default_values.__defaults__, default_values.__kwdefaults__
    first, second = Marker(), Marker()
    refs = weakref.ref(first), weakref.ref(second)
    default_values.__defaults__ = (first,)
    default_values.__kwdefaults__ = {'other': second}
    enabled = gc.isenabled()
    gc.disable()
    try:
        region = heap.lift_calls(default_values)
        assert region()[0] is first
        default_values.__defaults__ = default_values.__kwdefaults__ = None
        del first, second
        assert refs[0]() is None and refs[1]() is None
    finally:
        default_values.__defaults__, default_values.__kwdefaults__ = defaults, keywords
        if enabled: gc.enable()


def replaced_names(left, right):
    return left, right


def test_duplicate_code_parameter_names_decline_without_construction_error():
    original = replaced_names.__code__
    try:
        replaced_names.__code__ = original.replace(co_varnames=('value', 'value'))
        assert replaced_names(10, 20) == (10, 20)
        region = heap.lift_calls(replaced_names)
        assert region(10, 20) == (10, 20)
        assert region.compiled_calls == 0 and region.fallback_calls == 1
    finally:
        replaced_names.__code__ = original
