import pytest
from recompyler import lift as public_lift
from recompyler.lift import same
from recompyler import profiler

def test_slots_compare_without_user_hooks_and_track_missing_fields():
    events=[]
    class Record:
        __slots__=('value',)
        def __eq__(self,other):events.append('eq');raise AssertionError('user equality')
        def __hash__(self):events.append('hash');raise AssertionError('user hash')
        def __repr__(self):events.append('repr');raise AssertionError('user repr')
        def __bool__(self):events.append('bool');raise AssertionError('user truth')
    a,b=Record(),Record()
    assert same(a,b)
    a.value=3
    assert not same(a,b)
    b.value=3
    assert same(a,b)
    b.value=4
    assert not same(a,b)
    assert events==[]

def test_constructor_snapshots_preserve_absent_and_present_slots():
    class FactorsShape:
        __slots__=('factors','gens')
    obj=FactorsShape();before=profiler.snapshot(obj)
    obj.factors={};obj.gens=frozenset();after=profiler.snapshot(obj)
    assert profiler._object_fields(before)=={}
    assert profiler._object_fields(after)=={'factors':{},'gens':frozenset()}
    assert not same(before,after)

def test_uninspectable_value_has_named_comparison_decline_without_hooks():
    events=[]
    class Meta(type):
        def __eq__(cls,other):events.append('meta eq');raise AssertionError('meta equality')
        def __hash__(cls):events.append('meta hash');raise AssertionError('meta hash')
        def __repr__(cls):events.append('meta repr');raise AssertionError('meta repr')
    class Unknown(metaclass=Meta):
        def __eq__(self,other):events.append('eq');raise AssertionError('equality')
        def __bool__(self):events.append('bool');raise AssertionError('truth')
    a,b=Unknown(),Unknown()
    with pytest.raises(ValueError,match='comparison rule:'):
        same(a,b)
    assert events==[]

def test_noninert_set_elements_are_declined_before_hash_or_equality():
    events=[]
    class Element:
        def __hash__(self):events.append('hash');return 1
        def __eq__(self,other):events.append('eq');return True
    a,b={Element()},{Element()};events.clear()
    with pytest.raises(ValueError,match='comparison rule:'):
        same(a,b)
    assert events==[]

def test_candidate_names_uninspectable_comparison_instead_of_running_hooks(monkeypatch):
    class Native:
        def __init__(self):self.value=1
    value=Native();samples=[((value,),1,(value,))]
    # A late class mutation makes a previously captured shape unsafe to inspect.
    Native.__getattribute__=lambda self,name:(_ for _ in ()).throw(AssertionError('attribute hook'))
    def fn(obj):return 1
    result=profiler.test_candidate(fn,samples,1)
    assert result['status']!='verified'
    assert 'comparison rule:' in result['reason']

@pytest.mark.parametrize('backend',['python','c'])
def test_real_factors_constructor_entry_sample_has_uninitialized_slots(backend):
    exprtools=pytest.importorskip('sympy.core.exprtools')
    from recompyler import monitor
    if backend=='c' and monitor._accelerator is None:pytest.skip('C monitor not built')
    fn=exprtools.Factors.__init__
    with monitor.CallMonitor([fn.__code__.co_filename],max_samples=8,copy=profiler.snapshot,backend=backend) as capture:
        value=exprtools.Factors()
    sampler=next(s for s in capture.samplers.values() if s.function is fn)
    arguments,expected,after=sampler.samples[0]
    assert profiler._object_fields(arguments[0])=={}
    assert profiler._object_fields(after[0])=={'factors':{},'gens':frozenset()}
    assert not same(arguments,after)
    assert value.factors=={} and value.gens==frozenset()

def test_primitive_numpy_values_compare_by_type_shape_and_bits():
    np=pytest.importorskip('numpy')
    assert same(np.array([1.,2.]),np.array([1.,2.]))
    assert not same(np.array([0.]),np.array([-0.]))
    assert not same(np.array([1.]),np.array([[1.]]))
    assert not same(np.int64(1),1)
    assert same(np.float64(float('nan')),np.float64(float('nan')))

def test_cycles_and_builtin_container_iteration_compare_structurally():
    a=[];a.append(a);b=[];b.append(b)
    assert same(a,b)
    assert same({1,2,3},{3,2,1})
    assert not same({1,2},{1,3})
    assert same({'x':[1,2]},{'x':[1,2]})
    assert not same({'x':1,'y':2},{'y':2,'x':1})


def test_numpy_alias_cannot_authorize_an_unrelated_type(monkeypatch):
    np=pytest.importorskip('numpy')
    import io
    monkeypatch.setattr(np,'ndarray',io.BytesIO)
    with pytest.raises(ValueError,match='comparison rule:'):
        same(io.BytesIO(),io.BytesIO())

def test_set_iteration_difference_is_observable():
    a={-1,-2};b={-2,-1}
    if list(a)!=list(b):assert not same(a,b)

def test_numpy_alias_cannot_read_a_proxy_target_property(monkeypatch):
    import weakref
    np=pytest.importorskip('numpy');events=[]
    class Target:
        @property
        def dtype(self):events.append('dtype');raise AssertionError('proxy property')
    obj=Target();proxy=weakref.proxy(obj)
    monkeypatch.setattr(np,'ndarray',weakref.ProxyType)
    with pytest.raises(ValueError,match='comparison rule:'):
        same(proxy,proxy)
    assert events==[]

def test_rebound_helper_invalidates_compiled_guard_and_falls_back(tmp_path):
    import importlib.util
    from recompyler.lift import lift
    pytest.importorskip('numba')
    path=tmp_path/'guard_sample.py'
    path.write_text('def helper(x):\n    return x + 1\ndef root(x):\n    return helper(x)\n')
    spec=importlib.util.spec_from_file_location('guard_sample',path)
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    compiled=lift(module.root)
    assert compiled(2)==3 and compiled.compiled_calls==1
    module.helper=lambda x:x+100
    assert compiled(2)==102
    assert compiled.compiled_calls==1 and compiled.fallback_calls==1

def test_exception_type_metadata_compares_by_identity_without_metaclass_hooks():
    events=[]
    class Meta(type):
        def __eq__(cls,other):events.append('eq');raise AssertionError('class equality')
        def __hash__(cls):events.append('hash');raise AssertionError('class hash')
    class Error(Exception,metaclass=Meta):pass
    class Other(Exception,metaclass=Meta):pass
    assert same((ZeroDivisionError,(0,0)),(ZeroDivisionError,(0,0)))
    assert same((Error,(1,)),(Error,(1,)))
    assert not same((Error,(1,)),(Other,(1,)))
    assert events==[]
