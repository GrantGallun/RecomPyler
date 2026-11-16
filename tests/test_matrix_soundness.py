from pathlib import Path
import json,sys
import pytest
R=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(R/'matrix'));sys.path.insert(0,str(R/'src'))
from catalogue import Case,cases
from run_matrix import run_case
from recompyler.lift import lift
ROWS={r.id:r for r in cases()}

@pytest.mark.parametrize('identity',['operator.float.binary7','operator.float.binary9','operator.tuple.and','operator.none.compare0','method.list.reverse','method.list.sort','method.int.bit_length','boundary.index'])
def test_observed_defect_is_native_or_named_decline(identity):
    # Warm a method with identical generated source first: cache keys must retain
    # the semantic method binding, not only the name _rc_method0.
    if identity.startswith('method.list.'):run_case(ROWS['method.list.pop'])
    row=run_case(ROWS[identity])
    assert row['verdict'] in ('native','declined'),row

@pytest.mark.parametrize('op',['and','or'])
@pytest.mark.parametrize('left,right',[((1,2),(3,4)),((),(3,4)),((1,2),())])
def test_tuple_boolean_returns_the_original_selected_argument(op,left,right):
    from run_matrix import fixture
    case=Case('identity.'+op,'identity','return a '+op+' b','a,b')
    module,_=fixture(case);native=lift(module.construct)
    result=native(left,right)
    assert result is (left and right if op=='and' else left or right)

@pytest.mark.parametrize("identity",[r for r in ROWS if r.startswith("review.")])
def test_independent_review_precision_and_bounds(identity):
    row=run_case(ROWS[identity])
    assert row["verdict"] in ("native","declined"),row

@pytest.mark.parametrize("identity",["statement.for_else","operator.bool.binary9","operator.int.binary7","literal.tuple","call.method","order.chain","order.chain_short"])
def test_retains_existing_native_paths(identity):
    row=run_case(ROWS[identity])
    assert row["verdict"]=="native",row

@pytest.mark.parametrize("a,b",[(None,None),(1,None),(None,2),(2,3)])
def test_none_batch_constant_columns(a,b):
    from run_matrix import fixture
    module,_=fixture(Case("batch.none","batch","return a==b","a,b"))
    compiled=lift(module.construct)
    expected=module.construct(a,b)
    assert compiled.map([(a,b)]*3)==[expected]*3

@pytest.mark.parametrize("expression",["(1,2.0)[0]","(1,2.0)[1]","[1,2][-1]","[1,2][0]"])
def test_retains_literal_index_specializations(expression):
    row=run_case(Case("literal.native."+str(len(expression))+expression,"literal","return "+expression))
    assert row["verdict"]=="native",row

@pytest.mark.parametrize('op,a,b', [('or',float('1.25'),0.0),('and',float('-0.0'),1.0),('or',int('1000'),0),('or',0.0,float('1.25'))])
def test_numeric_boolean_preserves_selected_object(op,a,b):
    from run_matrix import fixture
    module,_=fixture(Case('numeric.identity.'+op,'identity','return a '+op+' b','a,b'))
    result=lift(module.construct)(a,b)
    assert result is (a and b if op=='and' else a or b)
