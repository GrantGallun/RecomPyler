import pytest
from bench.libs.llvm_pass_report import parse_report, summarize


def test_parse_sections_wall_time_duplicates_and_totals():
    text="""Pass execution timing report
    0.1000 ( 20.0%) 0.1200 ( 24.0%) LCSSAPass on body
    0.1000 ( 20.0%) 0.1300 ( 26.0%) LCSSAPass on helper
    0.5000 (100.0%) 0.5000 (100.0%) Total
    Analysis execution timing report
    0.0100 (100.0%) 0.0200 (100.0%) LoopAnalysis
    0.0100 (100.0%) 0.0200 (100.0%) Total
    """
    result=parse_report(text)
    assert result['per']['pass:LCSSAPass']==pytest.approx(.25)
    assert result['per']['analysis:LoopAnalysis']==.02
    assert result['totals']=={'pass':.5,'analysis':.02}
    assert 'pass:Total' not in result['per']


def test_empty_or_malformed_reports_cannot_look_like_zero_cost():
    for text in ('', 'Pass execution timing report\nunknown format'):
        with pytest.raises(ValueError): parse_report(text)


def test_pass_exponents_and_ir_volume_report_actual_axes():
    rows=[dict(bytecodes=n,llvm_lines=40*n,per={'pass:LCSSAPass':n*n/1000000}) for n in (100,200,400)]
    report=summarize(rows)
    assert report['passes']['pass:LCSSAPass']['exponent']==pytest.approx(2)
    assert report['max_llvm_lines_per_bytecode']==40
    assert not report['shape_budget_ok']


def test_rounded_zeros_and_missing_passes_are_unresolved():
    rows=[dict(bytecodes=n,llvm_lines=8*n,per={'pass:LCSSAPass':0}) for n in (100,200,400)]
    report=summarize(rows)
    assert report['passes']['pass:LCSSAPass']['exponent'] is None
    assert report['shape_budget_ok'] is None



def test_factory_keeps_actual_builder_and_restores_on_failure():
    from types import SimpleNamespace
    from contextlib import contextmanager
    from bench.libs.llvm_pass_report import capture_passes
    events=[]
    class Manager:
        def __enter__(self): return self
        def __exit__(self,*args): events.append('manager closed')
        def run(self,module,actual):
            assert actual is builder
            assert module=='define body {\n  ret void\n}'
            events.append('run')
    class Builder:
        def getModulePassManager(self):return Manager()
        def start_pass_timing(self):events.append('start')
        def finish_pass_timing(self):
            events.append('finish')
            return 'Pass execution timing report\n  0.1 (100.0%) SomePass\n  0.1 (100.0%) Total'
    builder=Builder()
    @contextmanager
    def factory(*args):
        yield builder
        events.append('builder closed')
    binding=SimpleNamespace(create_pass_builder=factory)
    with pytest.raises(RuntimeError):
        with capture_passes(binding) as rows:
            with binding.create_pass_builder(None,None) as actual:
                with actual.getModulePassManager() as manager:
                    manager.run('define body {\n  ret void\n}',actual)
            raise RuntimeError('later compilation failed')
    assert binding.create_pass_builder is factory
    assert events==['start','run','manager closed','finish','builder closed']
    assert rows[0]['modules'][0]['llvm_lines']==1
    assert rows[0]['modules'][0]['llvm_text_nonblank_lines']==3
    assert rows[0]['per']=={'pass:SomePass':.1}
