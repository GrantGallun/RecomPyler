"""Execution gate: pinned verdicts, never AST/source-based support assertions."""
import json
from pathlib import Path
import sys
import pytest
R=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(R/'matrix'))
from catalogue import cases
from run_matrix import run_case
ROWS={r.id:r for r in cases()}
PINS=json.loads((R/'matrix/matrix.json').read_text(encoding='utf-8'))['rows']

@pytest.mark.parametrize('pin',PINS,ids=lambda p:p['id'])
def test_construct_verdict(pin):
    row=run_case(ROWS[pin['id']])
    assert not row.get('harness_error'),row
    assert row['verdict']==pin['verdict'],row

def test_installed_inventory_is_complete():
    from catalogue import inventory
    inventory_=inventory(cases())
    assert not inventory_['missing_ast_nodes']
    assert not inventory_['missing_keyword_tokens']
    assert set(ROWS)=={p['id'] for p in PINS}
