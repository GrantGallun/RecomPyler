"""Shared provenance regression contracts (S47/S49)."""
import ast,gc,importlib.util,inspect,os,weakref
from pathlib import Path
from recompyler import provenance as p

def selected(a):
    old=a
    return old

def joined(a,b,choose):
    value=a
    if choose:value=b
    return value

def skipped_else(a,b):
    value=a
    for unused in range(1):
        value=b
        break
    else:value=a
    return value

def target_store(a,values):
    value=a
    for value in values:pass
    return value

def aliases(a):
    value=(a,)
    return value,value

def separate(a):
    left=[a]
    right=[a]
    return left,right

def external_store(value,box):
    box.value=value
    return None

def external_call(value,out):
    out.append((value,))
    return None

def paths(record,values):
    return record.left,values[0]

def numeric_is(a,b):
    return a is b

def singleton_is(a):
    return a is None

def overloaded(a):
    return a+1

def literal():
    return ('wide λ owner','wide λ owner')

def implicit(flag,a):
    if flag:return a

def test_selection_and_joins():
    assert p.analyze(selected).result==p.argument(0)
    s=p.analyze(joined)
    assert s.result.origins==p.argument(0).origins|p.argument(1).origins
    assert s.may_alias(p.argument(0),p.argument(1))
    for fn in (skipped_else,target_store):assert p.analyze(fn).result.unknown

def test_aggregate_sharing_and_escape():
    s=p.analyze(aliases)
    assert s.result.children[0]==s.result.children[1]
    assert s.result.children[0].children[0]==p.argument(0)
    s=p.analyze(separate)
    assert not s.may_alias(*s.result.children)
    assert s.may_escape(p.argument(0))
    for fn in (external_store,external_call):
        s=p.analyze(fn)
        assert s.may_escape(p.argument(0)) and s.identity_observable(p.argument(0))
    store=p.analyze(external_store).stores[0]
    assert store.value==p.argument(0)
    assert next(iter(store.previous.origins)).kind=='attribute'
    assert p.analyze(external_store).naturally_rooted(store.value) is None

def test_paths_and_substitution():
    s=p.analyze(paths)
    assert [next(iter(v.origins)).kind for v in s.result.children]==['attribute','element']
    assert s.may_alias(*s.result.children)
    mapped=p.substitute(s.result.children[0],{0:p.argument(3)})
    assert next(iter(mapped.origins)).parents==tuple(p.argument(3).origins)

def test_s49():
    assert not p.analyze(numeric_is).identity_safe({0:int,1:int})
    assert p.analyze(numeric_is).identity_safe({0:str,1:str})
    assert p.analyze(singleton_is).identity_safe({0:int})
    s=p.analyze(overloaded)
    assert next(iter(s.result.origins)).kind=='operation'
    assert s.may_alias(s.result,p.argument(0))
    assert not s.identity_observable(s.result,exact_type=float)
    assert s.identity_observable(s.result,exact_type=bool)
    assert p.exempt_number(1) and not p.exempt_number(True)
    class Int(int):pass
    assert not p.exempt_number(Int(1))

def test_constants_and_implicit_return():
    origin,=p.analyze(literal).result.origins
    assert origin.kind=='constant'
    assert p.resolve_constant(literal,origin.key) is literal()
    assert any(o.kind=='singleton' and o.key==('None',) for o in p.analyze(implicit).result.origins)
    node=ast.parse('def selected(a):\n return 99\n').body[0]
    assert not p.analyze(selected,node).valid

def test_weak_summary_and_global_rebinding(tmp_path):
    path=tmp_path/'weak.py'
    path.write_text('class Box: pass\nvalue=Box()\ndef f():\n return value\n')
    spec=importlib.util.spec_from_file_location('weak_provenance',path)
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    f,v=weakref.ref(module.f),weakref.ref(module.value)
    s=p.analyze(module.f)
    assert s.valid and s.dependencies_match(module.f)
    module.value=type(module.value)()
    assert not s.dependencies_match(module.f)
    del module;gc.collect()
    assert f() is None and v() is None

def test_corpus_all_facts_or_decline():
    total=0
    root=Path(os.environ.get('PROVENANCE_CORPUS',os.environ.get('RECOMPYLER_PROVENANCE_CORPUS',Path(__file__).resolve().parents[2]/'provenance-cases')))
    if not root.exists() and 'PROVENANCE_CORPUS' not in os.environ and 'RECOMPYLER_PROVENANCE_CORPUS' not in os.environ:root=Path(__file__).parent/'provenance_cases'
    assert root.is_dir(), 'explicit provenance snapshot missing'
    for path in sorted(root.glob('*.py')):
        from corpus_loader import load_corpus_module
        module=load_corpus_module(path)
        for name,fn in vars(module).items():
            if inspect.isfunction(fn) and fn.__module__==module.__name__:
                total+=1;s=p.analyze(fn)
                assert s.valid or s.reason,(path,name)
                if not s.valid:assert s.result.unknown
    assert total>=54


def union_escape(a,b,choose):
    if choose:value=[a]
    else:value=[b]
    return value

def indirect_observation(callback,x):
    return callback((x,))

def operator_escape(x,y):
    return x+y

def mutated_aggregate(x,y):
    value=[x]
    alias=value
    value[0]=y
    return alias

def dynamic_reads(box):
    a=box.field
    b=box.field
    return a,b

def test_review_branch_union_and_indirect_numeric_observation():
    import types
    s=p.analyze(union_escape)
    assert s.may_escape(p.argument(0)) and s.may_escape(p.argument(1))
    assert not p.analyze(indirect_observation).identity_safe({0:types.FunctionType,1:int})
    s=p.analyze(operator_escape)
    assert s.may_escape(p.argument(0)) and s.may_escape(p.argument(1))

def test_review_mutation_and_dynamic_reads_not_one_owner():
    s=p.analyze(mutated_aggregate)
    assert s.result.unknown or not s.result.children
    a,b=p.analyze(dynamic_reads).result.children
    assert a.unknown or b.unknown or a!=b

def test_expression_and_statement_points():
    import textwrap
    node=ast.parse(textwrap.dedent(inspect.getsource(selected))).body[0]
    summary=p.analyze(selected)
    assert summary.at(p.site(node.body[1]),'old')==p.argument(0)


def annotation_only(a):
    a: object
    return a

def mutation_callback(callback,a,b):
    value=[a]
    callback(value,b)
    return value

def while_observation(x):
    y=None
    while y is None or y is x:
        y=x
    return y

def test_review_annotation_callback_and_while_observation():
    import types
    assert p.analyze(annotation_only).result==p.argument(0)
    s=p.analyze(mutation_callback)
    assert s.result.unknown or not s.result.children
    assert not p.analyze(while_observation).identity_safe({0:int})

def test_review_observers_individually():
    import types
    assert not p.analyze(indirect_observation).identity_safe({0:types.FunctionType,1:int})
    s=p.analyze(operator_escape)
    assert s.may_escape(p.argument(0))
    assert s.may_escape(p.argument(1))
    a,b=p.analyze(dynamic_reads).result.children
    assert a.unknown or b.unknown or a!=b

def child_escape(a):
    return (a,)[0]

def raised_escape(error):
    raise error

def mutable_point(a,b):
    value=[a]
    value[0]=b
    return value

def test_review_path_child_and_exception_escape():
    assert p.analyze(child_escape).may_escape(p.argument(0))
    assert p.analyze(raised_escape).may_escape(p.argument(0))

def test_review_mutation_at_statement_point():
    import textwrap
    node=ast.parse(textwrap.dedent(inspect.getsource(mutable_point))).body[0]
    s=p.analyze(mutable_point)
    value=s.at(p.site(node.body[-1]),'value')
    assert value.unknown or not value.children

def formal_alias(value):
    return value

def truth_mutation(callback_value,a):
    value=[a]
    if callback_value:pass
    return value

def test_review_substitution_and_implicit_callbacks():
    import types
    actual=p.analyze(aliases).result
    mapped=p.substitute(p.argument(0),{0:actual})
    assert mapped==actual
    assert p.argument(0).origins <= p.descendants(mapped)
    s=p.analyze(truth_mutation)
    assert not s.result.children

def test_review_guard_does_not_repr_application_constant():
    import types
    events=[]
    class Constant:
        def __repr__(self):
            events.append('repr')
            return 'constant'
    code=literal.__code__
    changed=tuple(Constant() if type(value) is tuple else value for value in code.co_consts)
    fn=types.FunctionType(code.replace(co_consts=changed),literal.__globals__,literal.__name__)
    result=p.analyze(fn)
    assert not result.valid and events==[]

def set_protocol(key):
    return {key}

def dict_protocol(key,x):
    return {key:x}

def starred_protocol(sequence):
    return [*sequence]

def raise_protocol(exception):
    raise exception

def test_review_collection_and_raise_protocols():
    for fn in (set_protocol,dict_protocol,starred_protocol,raise_protocol):
        assert not p.analyze(fn).identity_safe({0:object,1:int}),fn.__name__

def test_review_type_queries_do_not_call_metaclass():
    events=[]
    class Meta(type):
        def __eq__(self,other):
            events.append('eq');return False
        def __hash__(self):
            events.append('hash');return 42
    class Kind(metaclass=Meta):pass
    s=p.analyze(numeric_is)
    s.identity_safe({0:Kind,1:Kind})
    s.identity_observable(p.argument(0),exact_type=Kind)
    assert events==[]

def unpack_set(a,b):
    left,right={a,b}
    return left,right

def unpack_dict(a):
    left,right={'key':a}
    return left,right

MAPPING_GLOBAL='wide owner'
def mapping_later_global(mapping):
    return {**mapping,'later':MAPPING_GLOBAL}

def test_review_unordered_unpack_is_unknown():
    for fn in (unpack_set,unpack_dict):
        s=p.analyze(fn)
        assert s.result.unknown or all(child.unknown for child in s.result.children)

def test_review_mapping_expansion_effect_precedes_sibling_read():
    import inspect,textwrap
    node=ast.parse(textwrap.dedent(inspect.getsource(mapping_later_global))).body[0]
    target=next(n for n in ast.walk(node) if isinstance(n,ast.Name) and n.id=='MAPPING_GLOBAL')
    assert p.analyze(mapping_later_global).expressions[p.site(target)].unknown

def starred_unpack(xs,middle,zs):
    a,b,c=[*xs,middle,*zs]
    return a,b,c

def test_review_starred_display_has_no_fixed_member_positions():
    import inspect,textwrap
    node=ast.parse(textwrap.dedent(inspect.getsource(starred_unpack))).body[0]
    pure=frozenset(p.site(n) for n in ast.walk(node) if hasattr(n,'lineno'))
    s=p.analyze(starred_unpack,pure_sites=pure)
    assert s.result.unknown or all(child.unknown for child in s.result.children)

def test_review_defaults_guard_never_invokes_application_truth():
    import types
    events=[]
    class Defaults(tuple):
        def __bool__(self):events.append('bool');return False
    fn=types.FunctionType(selected.__code__,selected.__globals__,selected.__name__)
    fn.__defaults__=Defaults()
    summary=p.analyze(fn)
    assert not summary.dependencies_match(fn) and events==[]

def another_literal():
    return ('different λ constant',)

def another_separate(a):
    left=[a]
    right=[a]
    return left,right

def test_cross_function_origins_keep_original_scope():
    left=p.analyze(separate).result.children[0]
    right=p.analyze(another_separate).result.children[0]
    assert left!=right
    origin=next(iter(p.analyze(literal).result.origins))
    assert p.resolve_origin(literal,origin) is literal()
    import pytest
    with pytest.raises(ValueError):p.resolve_origin(another_literal,origin)

def test_call_substitution_does_not_certify_repeated_dynamic_allocations():
    value=p.analyze(separate).result
    assert p.substitute(value,{0:p.argument(0)}).unknown

def discarded_format(value,selected):
    f'{value}'
    return selected

def test_review_unmodeled_expression_cannot_hide_protocol_callback():
    summary=p.analyze(discarded_format)
    assert not summary.identity_safe({0:object,1:str})
    assert summary.may_escape(p.argument(0))

KEYWORD_GLOBAL='original'
def keyword_expansion_then_global(callback,mapping):
    return callback(**mapping,later=KEYWORD_GLOBAL)

def test_review_keyword_expansion_precedes_later_siblings():
    import inspect,textwrap
    node=ast.parse(textwrap.dedent(inspect.getsource(keyword_expansion_then_global))).body[0]
    target=next(n for n in ast.walk(node) if isinstance(n,ast.Name) and n.id=='KEYWORD_GLOBAL')
    assert p.analyze(keyword_expansion_then_global).expressions[p.site(target)].unknown
