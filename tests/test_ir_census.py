"""IR graph construction is never counted as native self-compilation."""
import importlib.util
from pathlib import Path
import sys
from types import SimpleNamespace


def load_census():
    spec=importlib.util.spec_from_file_location('ir_census_tool',Path(__file__).parents[1]/'tools/self_census.py')
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    return module


def ir_target(action):return action()


def test_ir_builder_graph_and_missing_compiler_never_count_as_native(monkeypatch):
    from recompyler import ir
    census=load_census()
    # Lazy module exports are recreated on lookup; None models unavailable.
    monkeypatch.setattr(ir,'compile_function',None,raising=False)
    assert census.attempt_ir(ir_target)['status']=='unavailable'
    calls=[]
    def graph_only(fn):calls.append(fn);return SimpleNamespace(blocks=[])
    monkeypatch.setattr(ir,'compile_function',graph_only,raising=False)
    result=census.attempt_ir(ir_target)
    assert result['status']=='error' and result['native_compiled'] is False
    assert calls==[ir_target]


def test_ir_native_admission_does_not_execute_target_body(monkeypatch):
    from recompyler import ir
    from recompyler.ir.entry import create_callable
    from test_ir_entry import NativeBody
    census=load_census();body=NativeBody('forward')
    calls=[]
    def compile_only(fn):
        calls.append(fn)
        return create_callable(fn,body.address,body)
    monkeypatch.setattr(ir,'compile_function',compile_only,raising=False)
    result=census.attempt_ir(ir_target)
    assert result['status']=='compiled' and result['native_compiled'] is True
    assert result['execution_verified'] is False and calls==[ir_target]
    rows=[dict(status='declined',family='closures-functions-cells',nested=False,ir_path=result),
          dict(status='compiled',nested=False,ir_path=dict(status='unavailable',native_compiled=False))]
    summary=census.summarize(rows)
    assert summary['compiled']==1
    assert summary['ir_path']['compiled']==1 and summary['ir_path']['unavailable']==1


def test_public_prepared_machine_code_counts_without_deployment_or_execution():
    from recompyler import ir
    from types import FunctionType
    def source(value):return value
    function=FunctionType(source.__code__.replace(),{})
    result=load_census().attempt_ir(function)
    assert result['status']=='compiled' and result['native_compiled']
    assert result['installed'] is False and result['execution_verified'] is False
    assert ir.compilation_info(function)['body_address']>0


def test_baseline_matching_uses_qualname_not_shifted_source_indices():
    import importlib.util
    spec=importlib.util.spec_from_file_location('ir_baseline',Path(__file__).parents[1]/'tools/ir_census.py')
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    original=[dict(index=0,qualname='outer'),dict(index=1,qualname='outer.<locals>.<lambda>'),
              dict(index=2,qualname='outer.<locals>.<lambda>'),dict(index=3,qualname='removed')]
    current=[dict(index=0,qualname='new'),dict(index=1,qualname='outer'),
             dict(index=2,qualname='outer.<locals>.<lambda>'),dict(index=3,qualname='outer.<locals>.<lambda>')]
    assert module.match_baseline(original,current)==[(0,1),(1,2),(2,3),(3,None)]


def test_actual_suspended_prefix_is_labelled_without_deployment_or_execution():
    from test_ir_native_prefix import suspended,ordinary,fresh
    census=load_census();prefix=census.attempt_ir(fresh(suspended));body=census.attempt_ir(fresh(ordinary))
    assert prefix['status']=='compiled' and prefix['native_compiled']
    assert prefix['native_prefix'] is True and prefix['compilation_kind']=='native-prefix'
    assert prefix['installed'] is False and prefix['execution_verified'] is False
    assert body['status']=='compiled' and body['native_prefix'] is False
    rows=[dict(status='compiled',nested=False,ir_path=prefix),dict(status='compiled',nested=False,ir_path=body),
          dict(status='declined',nested=False,family='test',ir_path=dict(status='declined',native_prefix=True))]
    summary=census.summarize(rows)['ir_path']
    assert summary['compiled']==2 and summary['native_prefix']==1 and summary['declined']==1
