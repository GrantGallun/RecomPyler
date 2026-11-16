"""Semantic parity and bounded structural work against pre-cache checked IR."""
import ast
import copy
import hashlib
import importlib.util
from pathlib import Path
import sys
import textwrap
from unittest import mock

import pytest

FROZEN = Path(__file__).resolve().parent / 'fixtures/escape_uncached.py'
FROZEN_SHA256 = '54ab41bb195df8b3577cb40374d1e0632e71a517d265ef5b1d0deb1dbca6bc20'


def spec(name, body, params=(), *, object_params=None, allocations=(), returns=False, constructor=False):
    return dict(name=name, body=body, params=tuple(params),
                object_params=tuple(params if object_params is None else object_params),
                allocations=dict(allocations), object_return=returns, constructor=constructor)


def functions(module, specs):
    return [module.FunctionIR(row['name'],
        'def ' + row['name'] + '(' + ','.join(row['params']) + '):\n' +
        textwrap.indent(textwrap.dedent(row['body']).strip() + '\n', '    '),
        row['object_params'], dict(row['allocations']), row['object_return'], row['constructor'])
        for row in specs]


@pytest.fixture(scope='module')
def modules():
    # Dataclasses require the isolated module to be registered while executing.
    assert hashlib.sha256(FROZEN.read_text(encoding='utf-8').encode()).hexdigest() == FROZEN_SHA256
    name = '_f2_pre_structural_cache_reference'
    loader = importlib.util.spec_from_file_location(name, FROZEN)
    original = importlib.util.module_from_spec(loader)
    sys.modules[name] = original
    loader.loader.exec_module(original)
    from recompyler import escape as current
    return current, original


CASES = [
    pytest.param([
        spec('local', 'p=alloc(I,top,st,2)\nq=p\nF[np.uint64(p+1)]=1.0\nreturn F[q+1]', allocations=[('p','Cell')]),
    ], id='local-fields-alias-and-casts'),
    pytest.param([
        spec('r', 'q=r(p)\nF[np.uint64(np.int64(q+2)+1)]=2.0\nreturn p', ('p',), returns=True),
    ], id='recursive-return-alias-and-offset-mutation'),
    pytest.param([
        spec('left', 'q=right(p)\nreturn q', ('p',), returns=True),
        spec('right', 'if flag:\n    left(p)\nI[p+1]=2\nreturn p', ('p',), returns=True),
    ], id='mutual-recursive-alias-and-effects'),
    pytest.param([
        spec('caller', 'q=middle()\nr=q\nreturn r', returns=True),
        spec('middle', 'q=make()\nreturn q', returns=True),
        spec('make', 'p=alloc(I,top,st,1)\nreturn p', allocations=[('p','Cell')], returns=True),
    ], id='forward-ordered-fresh-return-chain'),
    pytest.param([
        spec('caller', 'q=make(p)\nr=alias(q)\nI[20]=r\nreturn 0', ('p',)),
        spec('alias', 'return x', ('x',), returns=True),
        spec('make', 'if flag:\n    return p\nq=alloc(I,top,st,1)\nreturn q', ('p',), allocations=[('q','Cell')], returns=True),
    ], id='mixed-fresh-and-parameter-return-propagates'),
    pytest.param([
        spec('conditional', 'p=alloc(I,top,st,1)\nif flag:\n    unknown(p)\nreturn 0', allocations=[('p','Cell')]),
        spec('same_loop', 'for i in range(n):\n    p=alloc(I,top,st,1)\n    I[10]=p\nreturn 0', allocations=[('p','Cell')]),
        spec('inner_if', 'for i in range(n):\n    p=alloc(I,top,st,1)\n    if flag:\n        I[10]=p\nreturn 0', allocations=[('p','Cell')]),
    ], id='capture-conditional-relative-to-allocation-controls'),
    pytest.param([
        spec('caller', 'p=alloc(I,top,st,1)\nsink(p)\nreturn 0', allocations=[('p','Cell')]),
        spec('sink', 'if flag:\n    unknown(p)\nreturn 0', ('p',)),
    ], id='callee-conditional-capture-fixed-point'),
    pytest.param([
        spec('mixed', 'if flag:\n    unknown(p)\nunknown(p)\nreturn 0', ('p',)),
        spec('under_try', 'p=alloc(I,top,st,1)\ntry:\n    unknown(p)\nexcept Exception:\n    I[10]=p\nreturn 0', allocations=[('p','Cell')]),
        spec('same_try', 'try:\n    p=alloc(I,top,st,1)\n    unknown(p)\nexcept Exception:\n    pass\nreturn 0', allocations=[('p','Cell')]),
    ], id='try-and-mixed-conditional-controls'),
    pytest.param([
        spec('join', 'p=alloc(I,top,st,1)\nq=alloc(I,top,st,1)\nx=p if flag else q\nreturn x==p', allocations=[('p','Cell'),('q','Cell')]),
        spec('rebind', 'p=alloc(I,top,st,1)\nq=alloc(I,top,st,1)\nx=p\nx=q\nreturn x!=p', allocations=[('p','Cell'),('q','Cell')]),
    ], id='identity-after-conditional-and-reaching-definition-joins'),
    pytest.param([
        spec('sentinels', 'if p<0:\n    return -1\nif p>=0:\n    return p\nreturn -1', ('p',), returns=True),
    ], id='nullable-sentinel-tests-and-failure-return'),
    pytest.param([
        spec('caller', 'p=alloc(I,top,st,1)\nq=get(p)\nI[10]=q\nreturn 0', allocations=[('p','Cell')]),
        spec('get', 'return external()', ('p',), returns=True),
    ], id='unknown-return-conservatively-retains-argument-origins'),
    pytest.param([
        spec('casts', 'q=np.uint64(np.int64(p+2)+1)\nI[q]=7\nF[np.int64(p+3)]+=1.0\nreturn', ('p',)),
        spec('unary', 'q=-p\nr=q+0\nI[10]=r\nreturn 0', ('p',)),
        spec('numeric', 'x=3.0\ny=-x+offset\nreturn y', ('offset',), object_params=()),
    ], id='casts-address-offsets-and-no-numeric-pointer-seeds'),
    pytest.param([
        spec('unknown_attribute', 'external.method(p)\nbox.field=p\nreturn 0', ('p',)),
        spec('unknown_arity', 'reader(0,p)\nreturn 0', ('p',)),
        spec('reader', 'return I[p]', ('p',)),
    ], id='unknown-callee-attribute-store-and-arity'),
    pytest.param([
        spec('tuple_binding', 'p=alloc(I,top,st,1)\nq,x=(p,0)\nreturn 0', allocations=[('p','Cell')]),
        spec('aggregate_return', 'p=alloc(I,top,st,1)\nreturn [p,p]', allocations=[('p','Cell')]),
        spec('set_return', 'p=alloc(I,top,st,1)\nreturn {p}', allocations=[('p','Cell')]),
    ], id='unsupported-binding-and-aggregate-return-captures'),
    pytest.param([
        spec('caller', 'p=alloc(I,top,st,1)\nctor(p)\nreturn F[p]', allocations=[('p','Cell')]),
        spec('ctor', 'F[p]=1.0\nreturn', ('p',), constructor=True),
        spec('my__init__reader', 'return F[p]', ('p',)),
    ], id='explicit-constructor-flag-and-unrelated-init-substring'),
    pytest.param([
        spec('many_args', 'q=consume(unused,p)\nreturn q', ('unused','p'), object_params=('p',), returns=True),
        spec('consume', 'return p', ('unused','p'), object_params=('p',), returns=True),
    ], id='parameter-positions-include-nonobject-abi-slots'),
]


def state(analysis):
    return copy.deepcopy(dict(report=analysis.report(), events=analysis.events, origins=analysis.origins))


@pytest.mark.parametrize('specs', CASES)
def test_full_semantic_state_matches_frozen_original(modules, specs):
    current, original = modules
    expected = original.EscapeAnalysis(functions(original, specs))
    actual = current.EscapeAnalysis(functions(current, specs))
    assert state(actual) == state(expected)
    before = {name: ast.dump(tree, include_attributes=True) for name, tree in actual.trees.items()}
    # Re-scan all functions at the final summaries: structural caches may not
    # mutate the AST or turn fixed-point state into a cached scan result.
    for name in actual.functions:
        assert actual.scan(name) == expected.scan(name)
        assert actual.origins[name] == expected.origins[name]
    assert before == {name: ast.dump(tree, include_attributes=True) for name, tree in actual.trees.items()}


def test_forward_chain_requires_summary_dependent_iterations(modules):
    current, original = modules
    specs = [
        spec('caller', 'q=middle()\nreturn q', returns=True),
        spec('middle', 'q=make()\nreturn q', returns=True),
        spec('make', 'p=alloc(I,top,st,1)\nreturn p', allocations=[('p','Cell')], returns=True),
    ]
    actual = current.EscapeAnalysis(functions(current, specs))
    expected = original.EscapeAnalysis(functions(original, specs))
    assert state(actual) == state(expected)
    assert actual.iterations >= 3
    assert actual.summaries['caller']['fresh_returns'] == ['make:p']
    assert actual.origins['caller']['q'] == {'make:p'}
    assert actual.summaries['caller']['return_unknown'] is False


def test_rescan_recomputes_origin_fixed_point_after_callee_summary_changes(modules):
    current, original = modules
    specs = [
        spec('caller', 'p=alloc(I,top,st,1)\nq=get(p)\nr=q\nI[10]=r\nreturn 0', allocations=[('p','Cell')]),
        spec('get', 'return p', ('p',), returns=True),
    ]
    actual = current.EscapeAnalysis(functions(current, specs))
    expected = original.EscapeAnalysis(functions(original, specs))
    for aliases, unknown in [([], False), ([0], False), ([], True), ([0], False)]:
        for analysis in (actual, expected):
            summary = analysis.summaries['get']
            summary['return_aliases'] = list(aliases)
            summary['fresh_returns'] = []
            summary['return_unknown'] = unknown
        assert actual.scan('caller') == expected.scan('caller')
        assert actual.origins['caller'] == expected.origins['caller']
        origins = actual.origins['caller']['r']
        assert ('caller:p' in origins) == bool(aliases or unknown)
        assert ('?' in origins) == unknown


def counted_ast(operation):
    counts = {name: 0 for name in ('parse','walk','unparse')}
    originals = {name: getattr(ast, name) for name in counts}
    distinct = {name: set() for name in ('walk', 'unparse')}
    def wrapper(name):
        def call(*args, **kwargs):
            counts[name] += 1
            if name in distinct:
                distinct[name].add(id(args[0]))
            return originals[name](*args, **kwargs)
        return call
    with mock.patch.multiple(ast, **{name: wrapper(name) for name in counts}):
        value = operation()
    counts.update({name + '_distinct_nodes': len(nodes) for name, nodes in distinct.items()})
    return value, counts


STRUCTURAL_SPEC = [
    spec('caller', 'p=alloc(I,top,st,2)\nq=middle(p)\nF[np.uint64(np.int64(q+1))]=2.0\nif flag:\n    external.method(q)\nreturn F[p+1]', allocations=[('p','Cell')]),
    spec('middle', 'q=last(p)\nreturn q', ('p',), returns=True),
    spec('last', 'if flag:\n    q=middle(p)\nreturn p', ('p',), returns=True),
]


def test_structural_ast_work_is_cached_once_per_analysis(modules):
    current, original = modules
    # Include cache creation in the budget; counting only warm scans would hide
    # moving repeated structural work to an equally expensive construction path.
    actual, cached = counted_ast(lambda: current.EscapeAnalysis(functions(current, STRUCTURAL_SPEC)))
    expected, repeated = counted_ast(lambda: original.EscapeAnalysis(functions(original, STRUCTURAL_SPEC)))
    assert state(actual) == state(expected)
    assert actual.iterations >= 3
    assert cached['parse'] == repeated['parse'] == len(STRUCTURAL_SPEC)
    assert cached['walk'] == cached['walk_distinct_nodes'] == len(STRUCTURAL_SPEC)
    assert cached['walk'] < repeated['walk']
    assert 0 < cached['unparse'] == cached['unparse_distinct_nodes'] < repeated['unparse']
    _, warm = counted_ast(lambda: [actual.scan(name) for name in actual.functions])
    assert warm == {'parse': 0, 'walk': 0, 'unparse': 0, 'walk_distinct_nodes': 0, 'unparse_distinct_nodes': 0}


def test_fresh_analysis_rebuilds_structure_for_changed_source(modules):
    current, original = modules
    first = [spec('same_name', 'p=alloc(I,top,st,1)\nF[p]=1.0\nreturn 0', allocations=[('p','Cell')])]
    second = [spec('same_name', 'p=alloc(I,top,st,1)\nif flag:\n    external.method(p)\nreturn 0', allocations=[('p','Cell')])]
    one = current.EscapeAnalysis(functions(current, first))
    before = state(one)
    two, counts = counted_ast(lambda: current.EscapeAnalysis(functions(current, second)))
    expected = original.EscapeAnalysis(functions(original, second))
    assert state(two) == state(expected)
    assert counts['parse'] == len(second) and counts['walk'] > 0
    assert one.allocations['same_name:p']['class'] == 'a'
    assert two.allocations['same_name:p']['class'] == 'd'
    assert state(one) == before
    assert one.trees['same_name'] is not two.trees['same_name']
