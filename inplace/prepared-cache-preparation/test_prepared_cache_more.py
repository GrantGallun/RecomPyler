"""Additional schema, closure and sealed ordinary-map regression tests."""
from copy import deepcopy
import json
import pytest
from test_prepared_cache import artifact, row_for, standalone, load_source


@pytest.mark.parametrize('mutation', ['bool-index','bad-index','bad-kind','duplicate-param','duplicate-field','alias-cycle','unknown-guard','wrong-flag','bad-cell'])
def test_malformed_runtime_grammar_declines(artifact, mutation):
    pc=artifact[0]
    core=deepcopy(next(c for c in artifact[4]['prepared']['cores'] if c['entry_id']['qualname']=='work'))
    e=core['execution']
    if mutation=='bool-index': e['entry_function']=True
    elif mutation=='bad-index': e['order']=[len(e['functions'])]
    elif mutation=='bad-kind': e['functions'][0]['ret']='unknown'
    elif mutation=='duplicate-param': e['functions'][0]['params']*=2
    elif mutation=='duplicate-field': e['families'][0]['fields']*=2
    elif mutation=='alias-cycle':
        r=e['families'][0]['root']; e['aliases']=[[r,r]]
    elif mutation=='unknown-guard': e['guards'].append(['future-unknown'])
    elif mutation=='wrong-flag': e['flags']['rng_used']=1
    elif mutation=='bad-cell': e['functions'][0]['vars'][1][1]=['list',True]
    with pytest.raises((pc.PreparedMiss,KeyError,TypeError,ValueError)):
        pc.validate_core(core)


def test_only_verified_loader_can_construct_index():
    from recompyler import _prepared as pc
    with pytest.raises(pc.PreparedMiss):
        pc.PreparedIndex(None,{},[],{}, {})


def test_compiler_generation_miss_retains_sealed_ordinary_map(artifact,monkeypatch):
    pc,heap,module,source,section=artifact
    key=pc.compiler_key()
    monkeypatch.setattr(pc,'compiler_key',lambda:dict(key,schema=999))
    index=pc.open_index(section,row_for(section),plan_snapshot=standalone(section))
    assert index is not None and index.exports and not index.bind(module.work)
    assert index.exports.allow_jit is False
    program=next(c for c in section['prepared']['cores'] if c['entry_id']['qualname']=='work')
    from types import SimpleNamespace
    malformed=SimpleNamespace(digest=program['generated']['digest'],entry=SimpleNamespace(params=[],ret=heap.FLOAT,vars={}))
    with pytest.raises(pc.PreparedMiss): index.exports.resolve_program(malformed)


def test_each_guarded_builtin_replacement_is_a_key_miss(artifact,monkeypatch):
    pc,heap,module,source,section=artifact
    index=pc.open_index(section,row_for(section),plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.work)
    # A private table changes only this newly created function's builtin lookup.
    from types import FunctionType
    namespace=dict(module.__dict__)
    import builtins
    table=dict(vars(builtins)); table['abs']=lambda v:999
    namespace['__builtins__']=table
    helper=FunctionType(module.helper.__code__,namespace,'helper',module.helper.__defaults__)
    namespace['helper']=helper
    work=FunctionType(module.work.__code__,namespace,'work',module.work.__defaults__)
    work.__kwdefaults__=module.work.__kwdefaults__.copy()
    assert index.bind(work)==[]


def test_immutable_closure_and_late_cell_invalidation(tmp_path,monkeypatch):
    from recompyler import heap,_prepared as pc
    source=tmp_path/'closure_fixture.py'
    source.write_text('def make():\n    value=3\n    def work(x):\n        return x+value\n    return work\nwork=make()\n')
    module=load_source(source)
    region=heap.lift_region(module.work)
    assert region(4)==7 and region.compiled_calls==1
    section=heap.build_regions([(('work',module.work.__code__.co_firstlineno),module.work,region)],tmp_path)
    index=pc.open_index(section,section['functions'][0],plan_snapshot=standalone(section))
    assert index is not None,pc.last_miss()
    assert index.bind(module.work),pc.last_miss()
    fast=heap.lift_region(module.work,index.exports,prepared=index)
    assert fast(4)==7 and fast.aot_calls==1
    cell=module.work.__closure__[0]
    monkeypatch.setattr(cell,'cell_contents',8)
    assert fast(4)==12 and fast.aot_calls==1 and fast.fallback_calls==1


def test_verified_metadata_detaches_from_caller_and_rejects_later_internal_edits(artifact,monkeypatch):
    pc,heap,module,source,original=artifact
    section=deepcopy(original)
    index=pc.open_index(section,row_for(section),plan_snapshot=standalone(section))
    assert index is not None and index.bind(module.work)
    section['prepared']['cores'][0]['execution']['written']=[]
    section['prepared']['manifest']['signatures'].clear()
    assert index.bind(module.work),pc.last_miss()
    for core in index.cores: core['execution']['written']=[]
    assert index.bind(module.work)==[]


def test_only_known_nonsemantic_adapter_diagnostics_are_excluded_from_plan_key():
    from recompyler import _prepared as pc
    baseline=dict(mode='saved',force=False,functions=[],plan=dict(worth_running=True))
    expected=pc.plan_key(baseline)
    for name in ('candidate_ranking','uncaptured_hotspots','capture_inventory'):
        assert pc.plan_key(dict(baseline,**{name:{'diagnostic':'removed by adapter'}}))==expected
    assert pc.plan_key(dict(baseline,future_runtime_control=True))!=expected
