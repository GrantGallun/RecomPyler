"""Compile unchanged nested AST visitors using shared managed call machinery."""
import ast
import importlib
import pytest
from recompyler.managed import lift_managed
from recompyler.lift import Unsupported
L=importlib.import_module('recompyler.lift')


def collect_equivalent(tree):
    found=[]
    def visit(item):
        if isinstance(item,ast.Name):
            found.append(item.id)
            return
        for child in ast.iter_child_nodes(item):
            visit(child)
    visit(tree)
    return found


def rebound_capture(tree):
    found=['old']
    def visit(item):
        if isinstance(item,ast.Name):
            found.append(item.id)
            return
        for child in ast.iter_child_nodes(item):visit(child)
    found=[]
    visit(tree)
    return found


def unbound_capture(tree,flag):
    def visit(item):
        found.append(item.id)
    if flag:found=[]
    visit(tree)
    return found


def escaping_helper(tree):
    def visit(item):return item.id
    return visit


@pytest.mark.parametrize('text',[
    'def f(a):\n x=a\n return x\n',
    'def f(a):\n x=[value for value in a]\n y=x\n return y\n',
    'def f(a):\n for left,right in a:\n  result=left\n return result\n',
    'def f(a):\n def inner():\n  child=a\n return inner\n',
])
def test_actual_local_names_compiles_nested_walk(text):
    node=ast.parse(text).body[0]
    fast=lift_managed(L._local_names)
    result=fast(node)
    assert result==L._local_names(node)
    assert fast.compiled_calls==1 and fast.fallback_calls==0
    assert fast.native_helper_calls>0 and fast.managed_calls>0
    assert 'walk(' not in fast.source and '_local_names(' not in fast.source


@pytest.mark.parametrize('fn',[collect_equivalent,rebound_capture])
def test_unrelated_recursive_closure_retains_live_capture(fn):
    node=ast.parse('left+right+last')
    fast=lift_managed(fn)
    result=fast(node)
    assert result==fn(node)==['left','right','last']
    assert fast.compiled_calls==1 and fast.fallback_calls==0
    owners=[part.id for part in ast.walk(node) if type(part) is ast.Name]
    assert all(any(value is owner for owner in owners) for value in result)


def test_unbound_free_cell_raises_once_without_entry_replay():
    fast=lift_managed(unbound_capture)
    node=ast.Name(id='source')
    expected=None
    try:unbound_capture(node,False)
    except NameError as exc:expected=(type(exc),str(exc),exc.name)
    with pytest.raises(NameError) as caught:fast(node,False)
    assert (type(caught.value),str(caught.value),caught.value.name)==expected
    assert fast.compiled_calls==1 and fast.fallback_calls==0


def test_escaping_helper_stays_an_explicit_decline():
    from recompyler._visitors import lift_visitors
    region=lift_visitors(escaping_helper)
    assert region.run is None and ('escap' in region.problem or 'nonescap' in region.problem)

SHADOW_AST=__import__('types').SimpleNamespace(iter_child_nodes=lambda node:iter((node,)))

def captured_iterator_shadow(tree):
    ast=SHADOW_AST
    def visit(item):
        for child in ast.iter_child_nodes(item):visit(child)
    visit(tree)


def unknown_capture_rebinding(tree):
    found=[]
    def visit(item):
        if isinstance(item,ast.Name):found.append(item.id);return
        for child in ast.iter_child_nodes(item):visit(child)
    found=SHADOW_AST
    visit(tree)


def positional_only_child(tree):
    found=[]
    def visit(item,/):found.append(item.id)
    visit(item=tree)
    return found


@pytest.mark.parametrize('fn',[captured_iterator_shadow,unknown_capture_rebinding])
def test_shadowed_or_unknown_capture_protocols_decline_before_native_recursion(fn):
    from recompyler._visitors import lift_visitors
    region=lift_visitors(fn)
    assert region.run is None and any(word in region.problem for word in ('shadow','capture','proved','binding'))


def test_positional_only_child_binding_is_not_relaxed():
    from recompyler._visitors import lift_visitors
    region=lift_visitors(positional_only_child)
    assert region.run is None and any(word in region.problem for word in ('argument','binding'))


def list_chain_visitor(tree):
    found=[]
    def visit(item):
        found.append(item)
        for child in item:visit(child)
    visit(tree)
    return found


def test_reduced_python_recursion_budget_declines_before_native_entry():
    import sys
    fast=lift_managed(list_chain_visitor)
    tree=[]
    for _ in range(90):tree=[tree]
    previous=sys.getrecursionlimit()
    try:
        sys.setrecursionlimit(80)
        with pytest.raises(RecursionError):list_chain_visitor(tree)
        with pytest.raises(RecursionError):fast(tree)
    finally:sys.setrecursionlimit(previous)
    assert fast.compiled_calls==0 and fast.fallback_calls==1


GLOBAL_CHAIN=[]
for _ in range(600):GLOBAL_CHAIN=[GLOBAL_CHAIN]


def global_chain_visitor():
    found=[]
    def visit(item):
        found.append(item)
        for child in item:visit(child)
    visit(GLOBAL_CHAIN)
    return found


def test_recursive_global_graph_cannot_bypass_argument_admission():
    from recompyler._visitors import lift_visitors
    region=lift_visitors(global_chain_visitor)
    assert region.run is None and any(word in region.problem for word in ('root','argument','graph','proved'))


def test_missing_source_keeps_public_unsupported_contract():
    namespace={}
    exec(compile('def function(value): return value','<wave17-review-visitor-missing-source>','exec'),namespace)
    with pytest.raises(Unsupported):lift_managed(namespace['function'])

def class_progress(node):
    def visit(item):return visit(item.__class__)
    return visit(node)


def inherited_progress(node):
    def visit(item):return visit(item.body[0])
    return visit(node)


def test_class_pseudo_descent_declines_native_construction():
    from recompyler._visitors import lift_visitors
    native=lift_visitors(class_progress)
    assert native.run is None


def test_class_provided_recursive_edges_are_not_owned_input_edges():
    from recompyler._visitors import lift_visitors
    node=ast.Name(id='root');previous=vars(ast.Name).get('body',None)
    had='body' in vars(ast.Name)
    try:
        ast.Name.body=[node]
        native=lift_visitors(inherited_progress)
        assert native.run is None or not native.admit_entry((node,))
    finally:
        if had:ast.Name.body=previous
        else:del ast.Name.body
