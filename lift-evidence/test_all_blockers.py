"""Fail-first S51 diagnostic tests; not part of product or accepted range tests."""
import sys
from pathlib import Path
sys.path[:0] = [str(Path(__file__).parent), str(Path(__file__).resolve().parents[1]/'src')]
import pytest
from all_blockers import diagnose, choose, inert


def two(n):
    x = missing_a(n)
    return missing_b(n)


def child(n):
    return missing_a(missing_b(n))


def branches(n):
    if missing_test(n):
        missing_a(n)
    else:
        missing_b(n)


def stale(n):
    x = 1
    x = missing_a(n)
    return x.real


def declaration(n, **kwargs):
    x = missing_a(n)
    def helper():
        return missing_b(n)
    return x


def recovery(n):
    try:
        for x in range(n):
            missing_a(x)
    finally:
        missing_b(n)
    return missing_c(n)


def numeric(n):
    return n + 1


def pending_helper(n):
    return n + 1


def pending(n):
    return pending_helper(n)


def texts(result):
    return '\n'.join(e['reason'] for e in result['events'])


def test_two_refusals_and_sticky_unknown():
    r = diagnose(two, (3,))
    assert 'missing_a' in texts(r) and 'missing_b' in texts(r)
    assert any(e['after_unknown'] and 'missing_b' in e['reason'] for e in r['events'])
    assert r['unknown_remainder'] and not r['forecast_eligible']


def test_failed_parent_does_not_hide_child():
    r = diagnose(child, (3,))
    assert 'missing_a' in texts(r) and 'missing_b' in texts(r)


def test_unknown_branch_structural_coverage():
    r = diagnose(branches, (3,))
    assert all(n in texts(r) for n in ('missing_test','missing_a','missing_b'))
    assert any(e['structural'] for e in r['events'])


def test_bottom_never_erases_unknown():
    r = diagnose(stale, (3,))
    assert r['unknown_remainder'] and not r['forecast_eligible']


def test_declaration_failure_still_visits_body_and_nested_scope():
    r = diagnose(declaration, (3,))
    assert 'kwargs' in texts(r)
    assert 'missing_a' in texts(r) and 'missing_b' in texts(r)
    assert any('helper' in e['scope'] for e in r['events'])
    assert all(e['absolute_line'] >= declaration.__code__.co_firstlineno for e in r['events'])


def test_state_recovery_deterministic():
    a, b = diagnose(recovery, (3,)), diagnose(recovery, (3,))
    assert a == b
    assert all(n in texts(a) for n in ('missing_a','missing_b','missing_c'))
    assert all(s['depth']==1 and s['loop_depth']==0 and not s['finals'] for s in a['final_states'])


def test_known_forward_call_has_no_pending_refusal():
    r = diagnose(pending, (3,))
    assert not r['events'] and r['settled'] and not r['unknown_remainder']


def test_never_compiles_or_publishes_source(monkeypatch):
    from recompyler import heap
    original = heap._Program.function
    def trap(*a, **k):
        raise AssertionError('compile/JIT/AOT path touched')
    monkeypatch.setattr(heap._Program, 'compile', trap)
    monkeypatch.setattr(heap._Gen, 'generate', trap)
    r = diagnose(numeric, (3,))
    assert not r['events']
    assert heap._Program.function is original
    assert r['generated_source_bytes'] == 0


def test_inert_allowlist_precedes_seed():
    class Hooks:
        hits = 0
        def __getattribute__(self, name):
            type(self).hits += 1
            raise AssertionError('arbitrary object inspected')
    obj = Hooks()
    assert not inert(obj)
    r = diagnose(numeric, (obj,))
    assert r['unknown_remainder'] and Hooks.hits == 0
    assert inert([1, 2.0, (True, None), range(4)])
    recursive=[];recursive.append(recursive)
    assert not inert(recursive)


def row(name, families, weight=1, eligible=True, native=False, wrapper=False):
    return dict(key=name, program=name[0], families=families, inclusive_s=weight,
                forecast_eligible=eligible, already_native=native, wrapper=wrapper)


def test_completion_arithmetic_not_reason_coverage():
    rs=[row('p1',['A']),row('p2',['A','B']),row('q3',['B']),
        row('r4',['C'],100,False),row('s5',['A'],1,True,True)]
    seq=choose(rs, baseline=60, limit=2)
    assert [(s['family'],s['marginal'],s['cumulative_native']) for s in seq] == [('A',1,61),('B',2,63)]


def test_complementary_zero_first_choice_preserved():
    seq=choose([row('p1',['A','B'])],baseline=60,limit=2)
    assert [(s['family'],s['marginal'],s['cumulative_native']) for s in seq] == [('A',0,60),('B',1,61)]


def test_weighted_tie_and_missing_weight_not_zero():
    rs=[row('p1',['A'],None),row('q2',['B'],4),row('r3',['C'],2)]
    seq=choose(rs,baseline=60,limit=1)
    assert seq[0]['family']=='B' and seq[0]['weighted_s']==4
    assert seq[0]['missing_weight_functions']==0


def test_already_native_never_double_credited():
    assert choose([row('p1',['A'],3,True,True)],baseline=60,limit=10)==[]


class ObservedRecord:
    def __init__(self,n):
        self.n=n
        self.items=[1]


def uses_observed_record(record):
    missing_a(record.n)
    return missing_b(record.items[0])


def test_observed_record_field_views_are_tainted_not_product_permission():
    r=diagnose(uses_observed_record,(ObservedRecord(3),))
    assert r['observed_fields']['ObservedRecord']['n']=='int'
    assert r['observed_fields']['ObservedRecord']['items']=='list[int]'
    assert r['unknown_remainder'] and not r['forecast_eligible']
    assert 'missing_a' in texts(r) and 'missing_b' in texts(r)


def test_callee_chain_and_exact_original_coordinates():
    r=diagnose(pending,(3,))
    # A known helper remains supported; coordinate validation uses a refused helper.
    def local_closure(n):
        return missing_a(n)
    q=diagnose(local_closure,(3,))
    event=next(e for e in q['events'] if 'missing_a' in e['reason'])
    assert event['absolute_line']==local_closure.__code__.co_firstlineno+1
    assert event['call_chain']==[local_closure.__qualname__]


def unsafe_module_read():
    return diagnostic_module.value


def unsafe_class_read():
    return diagnostic_class.value


def test_custom_module_metadata_hooks_are_not_run(monkeypatch):
    import types
    hits=[]
    class CountingModule(types.ModuleType):
        def __getattribute__(self,name):
            hits.append(name)
            return super().__getattribute__(name)
    obj=CountingModule('diagnostic_module');obj.value=3
    monkeypatch.setitem(unsafe_module_read.__globals__,'diagnostic_module',obj)
    hits.clear();r=diagnose(unsafe_module_read,())
    assert hits==[] and r['unknown_remainder']


def test_custom_metaclass_metadata_hooks_are_not_run(monkeypatch):
    hits=[]
    class Meta(type):
        def __getattribute__(cls,name):
            hits.append(name)
            return super().__getattribute__(name)
        def __hash__(cls):
            hits.append('hash')
            return type.__hash__(cls)
    class Object(metaclass=Meta):
        value=3
    monkeypatch.setitem(unsafe_class_read.__globals__,'diagnostic_class',Object)
    hits.clear();r=diagnose(unsafe_class_read,())
    assert hits==[] and r['unknown_remainder']


def unsafe_callable_use():
    return diagnostic_callable()


def unsafe_class_call():
    return diagnostic_class()


def module_payload_use():
    return diagnostic_module.value


def test_direct_call_and_module_payload_hooks_do_not_run(monkeypatch):
    import types
    hits=[]
    class Hook:
        def __getattribute__(self,name):
            hits.append(name)
            return object.__getattribute__(self,name)
        def __call__(self):raise AssertionError('called')
    obj=Hook();module=types.ModuleType('diagnostic_module');module.value=obj
    monkeypatch.setitem(unsafe_callable_use.__globals__,'diagnostic_callable',obj)
    monkeypatch.setitem(module_payload_use.__globals__,'diagnostic_module',module)
    for fn in (unsafe_callable_use,module_payload_use):
        hits.clear();r=diagnose(fn,());assert hits==[] and r['unknown_remainder']


def test_custom_metaclass_call_does_not_run_hooks(monkeypatch):
    hits=[]
    class Meta(type):
        def __getattribute__(cls,name):
            hits.append(name);return type.__getattribute__(cls,name)
    class Object(metaclass=Meta):pass
    monkeypatch.setitem(unsafe_class_call.__globals__,'diagnostic_class',Object)
    hits.clear();r=diagnose(unsafe_class_call,())
    assert hits==[] and r['unknown_remainder']


def nested_defaults(n):
    def helper(x=missing_default(n)):
        return missing_body(x)
    class Inner(missing_base(n)):
        def method(self):
            return missing_method(n)
    return missing_return(n)


def test_declaration_expressions_and_class_scope_are_retained():
    r=diagnose(nested_defaults,(3,))
    assert all(name in texts(r) for name in ('missing_default','missing_body','missing_base','missing_method','missing_return'))
    event=next(e for e in r['events'] if 'missing_method' in e['reason'])
    assert '.Inner.' in event['scope']


def branch_and_dict(n):
    value={1:2}
    if n:
        return value[1]
    return 0


def test_no_literal_eval_or_dict_helper_source(monkeypatch):
    from recompyler import heap
    def trap(*a,**k):raise AssertionError('literal evaluator/helper source touched')
    monkeypatch.setattr(heap,'_literal_truth',trap)
    monkeypatch.setattr(heap,'_dict_helpers',trap)
    r=diagnose(branch_and_dict,(3,))
    assert not any(e['category']=='analysis_error' for e in r['events'])
    assert r['generated_source_bytes']==0 and r['helper_source_bytes']==0


def test_duplicate_root_cannot_inflate_forecast():
    with pytest.raises(ValueError):choose([row('p1',['A']),row('p1',['A'])])
