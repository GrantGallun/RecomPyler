"""Compile-time regression policy is deterministic; real timings require the lock."""
import math
import pytest


def series(exponent=1.0, ms_per_bytecode=.005, tier='T1'):
    return [dict(kind='straight', size=n, bytecodes=n, tier=tier,
                 stages={'total':ms_per_bytecode*n/1000*(n/100)**(exponent-1),
                         'llvm_opt':.000001*n**exponent}) for n in (100,200,400)]


def test_scaling_exponent_and_t1_budgets():
    from bench.libs.compile_scaling import summarize
    report=summarize(series(),tier='T1')
    assert report['ok'] and report['tier']=='T1'
    total=report['kinds']['straight']['total']
    assert total['exponent']==pytest.approx(1)
    assert total['max_ms_per_bytecode']==pytest.approx(.005)
    assert not summarize(series(ms_per_bytecode=.011),tier='T1')['ok']
    assert not summarize(series(exponent=1.06),tier='T1')['ok']


def test_t2_is_reported_without_applying_t1_limits():
    from bench.libs.compile_scaling import summarize
    report=summarize(series(exponent=1.6,ms_per_bytecode=2,tier='T2'),tier='T2')
    assert report['ok'] and not report['budget_enforced']
    assert report['kinds']['straight']['total']['exponent']==pytest.approx(1.6)


@pytest.mark.parametrize('mutation',['mixed-tier','missing','duplicate','nonfinite'])
def test_incomplete_or_incompatible_scaling_cannot_pass(mutation):
    from bench.libs.compile_scaling import summarize
    rows=series()
    if mutation=='mixed-tier': rows[0]['tier']='T2'
    elif mutation=='missing': rows.pop()
    elif mutation=='duplicate': rows[1]['bytecodes']=rows[0]['bytecodes']
    else: rows[0]['stages']['total']=math.nan
    with pytest.raises(ValueError): summarize(rows,tier='T1')


def test_stage_extraction_uses_function_names_instead_of_line_numbers():
    from bench.libs.compile_scaling import profile_stages
    stats={('/repo/recompyler/ir/builder.py',999,'build'):(1,1,.1,.2,{}),
           ('/repo/llvmlite/binding/passmanagers.py',12,'optimize_module'):(1,1,.1,.3,{}),
           ('/repo/llvmlite/binding/executionengine.py',24,'finalize_object'):(1,1,.1,.4,{})}
    result=profile_stages(stats)
    assert result['build']==.2 and result['llvm_opt']==.3 and result['llvm_codegen']==.4
    assert result['parse']==0


def test_t1_adapter_must_identify_its_pipeline():
    from bench.libs.compile_scaling import validate_compiler
    def compile_fn(function,*,strict): pass
    with pytest.raises(ValueError,match='T1'): validate_compiler(compile_fn,'T1')
    compile_fn.recompyler_tier='T1'
    assert validate_compiler(compile_fn,'T1') is compile_fn


def test_synthetic_functions_grow_without_running_the_target():
    import dis
    from bench.libs.compile_scaling import make
    for kind in ('straight','branchy'):
        small=make(8,kind);large=make(16,kind)
        assert len(list(dis.get_instructions(small)))<len(list(dis.get_instructions(large)))
    with pytest.raises(ValueError): make(0,'straight')
    with pytest.raises(ValueError): make(8,'unknown')


def test_worker_compiles_twice_without_invoking_either_target(monkeypatch):
    import sys,types
    from bench.libs.compile_scaling import measure
    calls=[]
    module=types.ModuleType('scaling_test_adapter')
    def compile_fn(function,*,strict):
        assert strict
        calls.append(function)
    compile_fn.recompyler_tier='T1'
    module.compile_fn=compile_fn
    monkeypatch.setitem(sys.modules,module.__name__,module)
    monkeypatch.setattr('bench.libs.compile_scaling.preparation_receipt',lambda function,expected_code:dict(body_address=1,abi='test-only'))
    row=measure(8,'branchy','T1','scaling_test_adapter:compile_fn')
    assert len(calls)==2 and calls[0] is not calls[1]
    assert row['bytecodes']>0 and row['tier']=='T1'


def test_t1_budget_cannot_consume_diagnostic_serialization():
    from bench.libs.compile_scaling import validate_compiler
    def compiler(function,*,strict): pass
    compiler.recompyler_tier='T1';compiler.diagnostic_only=True
    with pytest.raises(ValueError,match='diagnostic'):validate_compiler(compiler,'T1')


def test_noop_adapter_cannot_pass_as_a_compiled_tier(monkeypatch):
    import sys,types
    from bench.libs.compile_scaling import measure
    module=types.ModuleType('noop_scaling_adapter')
    def compiler(function,*,strict):return function
    compiler.recompyler_tier='T1';module.compiler=compiler
    monkeypatch.setitem(sys.modules,module.__name__,module)
    with pytest.raises(ValueError,match='prepared native body'):
        measure(8,'straight','T1','noop_scaling_adapter:compiler')
