import pytest
from bench.libs.llvm_pass_scaling import summarize_report


def report():
    cohorts=[]
    for kind in ('straight','branchy'):
        for n in (100,200,400):
            row=dict(bytecodes=n,diagnostic_only=True,diagnostics={'pass_reports':[dict(per={'pass:LCSSAPass':n/100000},modules=[dict(llvm_lines=8*n,llvm_instructions=8*n)])]})
            cohorts.append(dict(kind=kind,size=n,attempts=[dict(samples=[row,row,row])]))
    return dict(source_sha256='source',compiler='adapter',samples=cohorts)


def test_native_medians_all_shapes_and_shape_gate():
    result=summarize_report(report())
    assert result['shape_budget_ok'] is True
    assert result['kinds']['straight']['passes']['pass:LCSSAPass']['exponent']==pytest.approx(1)
    assert result['points']['branchy'][0]['llvm_instructions']==800


def test_missing_diagnostics_and_shape_failures_cannot_pass():
    value=report();value['samples'][0]['attempts'][0]['samples'][0]['diagnostics']={}
    with pytest.raises(ValueError):summarize_report(value)
    value=report()
    for cohort in value['samples']:
        for row in cohort['attempts'][0]['samples']:
            row['diagnostics']['pass_reports'][0]['modules'][0]['llvm_lines']=40*row['bytecodes']
    assert summarize_report(value)['shape_budget_ok'] is False
