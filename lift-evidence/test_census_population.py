"""Literal population/weight correctness fixtures for the S51 evidence join."""
from pathlib import Path
import ast,hashlib,json,sys
sys.path.insert(0,str(Path(__file__).parent))
import pytest
from census_population import weight_value, index_rows, resolve_definition, timer_wrapper, validated_weight_rows, join_program


def test_missing_and_invalid_weight_are_explicit():
    for rows in ([],[{}],[{'cumulative_s':None}],[{'cumulative_s':True}],[{'cumulative_s':'3'}],
                 [{'cumulative_s':-1}],[{'cumulative_s':float('nan')}],[{'cumulative_s':float('inf')}],
                 [{'cumulative_s':1},{'cumulative_s':2}]):
        value,status=weight_value(rows)
        assert value is None and status!='measured'
    assert weight_value([{'cumulative_s':0}])==(0,'measured')
    assert weight_value([{'cumulative_s':2.5}])==(2.5,'measured')


def test_duplicate_current_rows_never_overwrite():
    a={'function':'f','line':2,'whole_function_native':False}
    b={**a,'whole_function_native':True}
    result=index_rows([a,b])
    assert result[('f',2)]==[a,b]


def test_ambiguous_missing_source_are_retained_unknown():
    defs=[{'function':'f','line':2,'source':'a.py'},{'function':'f','line':2,'source':'b.py'}]
    assert resolve_definition(defs,('f',2))==(None,'ambiguous_source')
    assert resolve_definition(defs,('missing',2))==(None,'missing_source')


def test_join_preserves_all_historical_keys_and_native_credit_once():
    old=[{'function':n,'line':i,'captured':True,'whole_function_native':False} for i,n in enumerate(('f','g','h'),1)]
    current=[{**old[0],'whole_function_native':True},old[1],{**old[1],'whole_function_native':True}]
    rows=join_program('p',old,current,[],[],source_status='missing_source')
    assert len(rows)==3 and len({tuple(r['key']) for r in rows})==3
    assert sum(r['already_native'] for r in rows)==1
    assert rows[1]['current_status']=='duplicate_current' and rows[2]['current_status']=='missing_current'
    assert all(r['inclusive_s'] is None and r['unknown_remainder'] for r in rows)


def test_nested_timer_calls_do_not_make_wrapper():
    real=ast.parse('''def bench_x(loops):
    indices=range(loops)
    start=time.perf_counter()
    for i in indices:
        work()
    return time.perf_counter()-start
''').body[0]
    nested=ast.parse('''def bench_x(loops):
    def unused():
        time.perf_counter()
        time.perf_counter()
    for i in range(loops):
        work()
    return 3
''').body[0]
    assert timer_wrapper(real) and not timer_wrapper(nested)


def test_weight_receipt_chain_and_source_identity(tmp_path):
    sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
    script=tmp_path/'work.py';script.write_text('def f():return 1\n')
    plan=tmp_path/'plan.json';receipt=tmp_path/'complete.json'
    plan.write_text(json.dumps({'script':str(script),'functions':[{'function':'f','line':1,'cumulative_s':2}]}))
    receipt.write_text(json.dumps({k:True for k in ('artifacts_unchanged','bytecode_unchanged','inputs_unchanged','profile_complete','source_unchanged')}))
    accepted={str(plan):sha(plan),str(receipt):sha(receipt)}
    assert validated_weight_rows(plan,accepted,script)[1]=='accepted'
    assert validated_weight_rows(plan,{**accepted,str(plan):'bad'},script)[0]==[]
    assert validated_weight_rows(plan,{**accepted,str(receipt):'bad'},script)[0]==[]
    assert validated_weight_rows(plan,accepted,tmp_path/'different.py')[0]==[]


def test_accepted_input_map_and_actual_manifest_both_sealed(tmp_path):
    from census_population import validate_input_map
    p=tmp_path/'input-manifest.json';p.write_text('{}')
    accepted={str(p):hashlib.sha256(p.read_bytes()).hexdigest()}
    digest=hashlib.sha256(json.dumps(accepted,sort_keys=True,separators=(',',':')).encode()).hexdigest()
    receipt={'input_manifest_sha256':digest}
    validate_input_map(accepted,receipt,p)
    with pytest.raises(AssertionError):validate_input_map(accepted,{'input_manifest_sha256':'bad'},p)
    p.write_text('{"changed":true}')
    with pytest.raises(AssertionError):validate_input_map(accepted,receipt,p)
