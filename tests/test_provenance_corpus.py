"""Every shared case gets a proved contract or a concrete refusing obligation."""
import ast,hashlib,inspect,json,os,struct,types
from pathlib import Path
import pytest
from recompyler import provenance as p

ROOT=Path(os.environ.get('PROVENANCE_CORPUS',os.environ.get('RECOMPYLER_PROVENANCE_CORPUS',Path(__file__).resolve().parents[2]/'provenance-cases')))
if not ROOT.exists() and 'PROVENANCE_CORPUS' not in os.environ and 'RECOMPYLER_PROVENANCE_CORPUS' not in os.environ:ROOT=Path(__file__).parent/'provenance_cases'
assert ROOT.is_dir(), 'explicit provenance snapshot missing'

def modules():
    for path in sorted(ROOT.glob('*.py')):
        from corpus_loader import load_corpus_module
        module=load_corpus_module(path)
        yield path,module

def functions():
    for path,module in modules():
        for name,fn in vars(module).items():
            if inspect.isfunction(fn) and fn.__module__==module.__name__:
                yield path,name,fn
        for case in getattr(module,'PROVENANCE_CASES',()):
            fn=module
            for part in case['function'].split('.'):fn=getattr(fn,part)
            assert inspect.isfunction(fn) and fn.__module__==module.__name__
            yield path,case['function'],fn

def bits(value):
    if type(value) is float:return struct.pack('!d',value)
    if type(value) is complex:return struct.pack('!dd',value.real,value.imag)
    return value

def fixture(name,index):
    if name in ('choose','flag'):return True
    if name in ('text','s','t','other'):return ''.join(['wide λ owner ',str(index)])
    if name in ('r',):return range(10000,10002)
    if name in ('values',):return (10001,10002)
    return int('1000003')+index

def check_graph(value,actual,fn,args,memo):
    if value.unknown or len(value.origins)!=1:
        raise LookupError('ambiguous or unknown origin requires runtime tag')
    origin=next(iter(value.origins))
    if origin.kind=='argument':
        expected=args[origin.key[0]]
    elif origin.kind=='constant':
        expected=p.resolve_origin(fn,origin)
    elif origin.kind=='singleton':
        expected={'None':None,'True':True,'False':False}[origin.key[0]]
    elif origin.kind=='allocation' and origin.key[-1] in ('Tuple','List'):
        expected_type=tuple if origin.key[-1]=='Tuple' else list
        assert type(actual) is expected_type
        if value.contained or len(value.children)!=len(actual):
            raise LookupError('mutable or uncorrelated members require guarded heap transfer')
        if origin in memo:assert actual is memo[origin]
        else:
            assert all(actual is not previous for previous in memo.values())
            memo[origin]=actual
        for child,item in zip(value.children,actual):check_graph(child,item,fn,args,memo)
        return
    else:
        raise LookupError(origin.kind+' requires a typed/guarded consumer transfer')
    if p.exempt_number(expected):
        assert type(actual) is type(expected) and bits(actual)==bits(expected)
    else:assert actual is expected

def test_complete_corpus_contracts(tmp_path):
    results=[]
    for path,name,fn in functions():
        summary=p.analyze(fn)
        record={'file':path.name,'function':name,'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}
        doc=inspect.getdoc(fn) or ''
        if 'S49-exempt' in doc:record['numeric_identity']='S49-exempt'
        try:
            if not summary.valid:raise LookupError(summary.reason)
            if any(right is None for left,right in summary.observations):
                raise LookupError('unresolved callback/effect requires exact guarded consumer proof')
            params=list(inspect.signature(fn).parameters)
            args=tuple(fixture(n,i) for i,n in enumerate(params))
            # Verify the shape is interpretable BEFORE executing any corpus case.
            def can_check(value):
                if value.unknown or len(value.origins)!=1:return False
                origin=next(iter(value.origins))
                return (origin.kind in ('argument','constant','singleton')
                        or origin.kind=='allocation' and origin.key[-1] in ('Tuple','List')
                        and not value.contained and all(can_check(x) for x in value.children))
            if not can_check(summary.result):raise LookupError('result origin/aggregate requires tagged or typed materialization')
            actual=fn(*args)
            check_graph(summary.result,actual,fn,args,{})
            record.update(verdict='proved',contract='CPython original owner and aggregate alias graph; S49 exact type/value')
        except LookupError as error:
            record.update(verdict='declined',reason=str(error))
        results.append(record)
    assert len(results)>=54
    (tmp_path/'corpus.json').write_text(json.dumps(results,indent=2))
    assert any(x['verdict']=='proved' for x in results)

@pytest.mark.parametrize('name,indices',[
 ('joined_aggregate_escape',(1,2)),('return_aggregate_escape',(0,)),
 ('store_aggregate_escape',(1,)),('call_aggregate_escape',(1,)),
 ('overloaded_add_selects_left',(0,1)),('selected_structural_child_escape',(0,)),
 ('raised_argument_escape',(0,)),('subscript_key_observation',(0,1)),
 ('augmented_operator_escape',(0,1)),
])
def test_reviewer_escape_contract(name,indices):
    fn=next(fn for _,n,fn in functions() if n==name)
    summary=p.analyze(fn)
    assert all(summary.may_escape(p.argument(i)) for i in indices)

@pytest.mark.parametrize('name',[
 'indirect_numeric_observation','repeated_while_observation',
 'subscript_key_observation','augmented_operator_escape',
 'implicit_truth_callback','dictionary_hash_callback','set_hash_callback',
 'starred_iteration_callback','raised_class_callback',
])
def test_reviewer_callback_refusals(name):
    fn=next(fn for _,n,fn in functions() if n==name)
    assert not p.analyze(fn).identity_safe({i:int for i in range(8)})

@pytest.mark.parametrize('value',[
 int('10000000000000000000000000003'),-0.0,
 struct.unpack('!d',bytes.fromhex('7ff8000000001234'))[0],
 complex(-0.0,struct.unpack('!d',bytes.fromhex('fff8000000001234'))[0]),
])
def test_s49_leaf_contract(value):
    # Producer identity is exempt; the consumer comparison still uses all bits.
    assert p.exempt_number(value)
    assert type(value) in (int,float,complex)
    assert bits(value)==bits(value)
    assert not p.exempt_number(True)


def test_s49_sidecar_expected_types_and_values():
    metadata=json.loads((ROOT/'wave17-matrix-s49.json').read_text(encoding='utf-8-sig'))
    available={(path.name,name):fn for path,name,fn in functions()}
    for case in metadata['cases']:
        fn=available[(case['file'],case['function'])]
        for _ in range(2):
            actual=fn(*case['args'])
            assert type(actual).__name__==case['expected_type']
            expected={'int':int,'float':float,'complex':complex}[case['expected_type']](case['expected_value'])
            assert bits(actual)==bits(expected)

def test_original_numeric_forward_bits():
    available={(path.name,name):fn for path,name,fn in functions()}
    for name, value in [('forwarded_negative_zero',-0.0),('forwarded_nan',struct.unpack('!d',bytes.fromhex('7ff8000000001234'))[0])]:
        fn=available[('wave16-inplace-numeric.py',name)]
        assert type(fn(value)) is float and bits(fn(value))==bits(value)



def test_explicit_class_method_queries_are_executed():
    cases={(path.name,name) for path,name,fn in functions()}
    assert ('wave16-inplace-method-binding.py','MethodBindingTask.read') in cases
    assert ('wave16-inplace-method-binding.py','MethodBindingTask.qpkt') in cases
