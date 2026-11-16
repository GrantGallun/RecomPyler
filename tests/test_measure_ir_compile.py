"""Compile-cost reports refuse incomplete or mixed-code evidence."""
import importlib
import pytest


def report_api():
    try:return importlib.import_module('tools.measure_ir_compile').summarize
    except ModuleNotFoundError:pytest.fail('compile-cost reporting tool is missing')


def observation(milliseconds,code='same'):
    return {'rows':[dict(name='fixture',status='ok',compile_ms=milliseconds,
                         code_digest=code,ir_instructions=60,ir_lines=75,bytecodes=10)]}


def test_compile_report_uses_literal_median_p90_and_full_ir_volume():
    row=report_api()([observation(30),observation(10),observation(20)])[0]
    assert (row['median_ms'],row['p90_ms'],row['ir_per_bytecode'],row['samples'])==(20,30,6,3)
    assert (row['ir_lines'],row['ir_lines_per_bytecode'])==(75,7.5)


def test_compile_report_refuses_partial_or_changed_code():
    summarize=report_api()
    with pytest.raises(ValueError):summarize([observation(1),observation(2)])
    with pytest.raises(ValueError):summarize([observation(1),observation(2),observation(3,'different')])
    with pytest.raises(ValueError):summarize([observation(1),observation(2),{'rows':[]}])


@pytest.mark.parametrize('position',range(3))
@pytest.mark.parametrize('defect',('empty','duplicate','extra'))
def test_compile_report_validates_every_target_set(position,defect):
    samples=[observation(1),observation(2),observation(3)]
    rows=samples[position]['rows']
    if defect=='empty':rows.clear()
    elif defect=='duplicate':rows.append(dict(rows[0]))
    else:rows.append(dict(rows[0],name='unexpected'))
    with pytest.raises(ValueError):report_api()(samples)
