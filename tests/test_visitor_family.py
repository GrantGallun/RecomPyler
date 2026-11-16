"""The S66 visitor/closure family, through the same public frontend."""
import ast
import pytest
from recompyler.managed import lift_managed


def closure_in_loop(values):
    def square(value):return value*value
    total=0
    for value in values:total+=square(value)
    return total


def ast_walk_loop(node):
    found=[]
    for item in ast.walk(node):
        if isinstance(item,ast.Name):found.append(item.id)
    return found


def two_helpers(values):
    def plus(value):return value+1
    def twice(value):return plus(value)+plus(value)
    found=[]
    for value in values:found.append(twice(value))
    return found


def list_recursion(values):
    found=[]
    def visit(item):
        if isinstance(item,list):
            for child in item:visit(child)
        else:found.append(item)
    visit(values)
    return found


def captured_list_counter(tree):
    count=[0]
    def visit(item):
        count[0]+=1
        for child in ast.iter_child_nodes(item):visit(child)
    visit(tree)
    return count[0]


@pytest.mark.parametrize('fn,args',[
 (closure_in_loop,([1,2,3],)),
 (ast_walk_loop,(ast.parse('left+right+last'),)),
 (two_helpers,([1,2,3],)),
 (list_recursion,([[1,[2]],3,[]],)),
 (captured_list_counter,(ast.parse('left+right'),)),
])
def test_visitor_family_compiles_parent_without_whole_helper_fallback(fn,args):
    fast=lift_managed(fn)
    result=fast(*args)
    assert type(result) is type(fn(*args)) and result==fn(*args)
    assert fast.compiled_calls==1 and fast.fallback_calls==0
    if fn is ast_walk_loop:
        originals=[part.id for part in ast.walk(args[0]) if type(part) is ast.Name]
        assert all(value is owner for value,owner in zip(result,originals))


def vararg_visitor(*nodes):
    found=[]
    def visit(item):found.append(item.id)
    for node in nodes:visit(node)
    return found


def conditional_local(tree,flag):
    found=[]
    def visit(item):
        if flag:local=item.id
        found.append(local)
    visit(tree)
    return found


def test_root_variadic_arguments_keep_native_visitor_bindings():
    nodes=(ast.Name(id='first'),ast.Name(id='last'))
    fast=lift_managed(vararg_visitor)
    assert fast(*nodes)==vararg_visitor(*nodes)
    assert fast.compiled_calls==1 and fast.fallback_calls==0 and fast.native_helper_calls==2


@pytest.mark.parametrize('flag',[False,True])
def test_native_child_local_slot_boundness_and_error_metadata(flag):
    node=ast.Name(id='original');fast=lift_managed(conditional_local)
    def outcome(function):
        try:return('return',function(node,flag))
        except UnboundLocalError as error:return('error',type(error),str(error),error.name,error.__context__,error.__cause__,error.__suppress_context__)
    assert outcome(fast)==outcome(conditional_local)
    assert fast.compiled_calls==1 and fast.fallback_calls==0


CLASS_EVENTS=[]
class ChangingMeta(type):
    def __instancecheck__(cls,value):
        CLASS_EVENTS.append('check')
        globals()['CHECK_KIND']=ast.Name
        return False
class ChangingKind(metaclass=ChangingMeta):pass
CHECK_KIND=ChangingKind


def changing_class_visitor(tree):
    found=[]
    def visit(item):
        if isinstance(item,CHECK_KIND):found.append(item.id);return
        for child in ast.iter_child_nodes(item):visit(child)
    visit(tree)
    return found


def test_class_callbacks_keep_live_bindings_and_exact_effects():
    global CHECK_KIND
    tree=ast.parse('left+right')
    CHECK_KIND=ChangingKind;CLASS_EVENTS.clear()
    fast=lift_managed(changing_class_visitor)
    try:
        expected=changing_class_visitor(tree);events=list(CLASS_EVENTS)
        CHECK_KIND=ChangingKind;CLASS_EVENTS.clear()
        result=fast(tree)
        assert result==expected and CLASS_EVENTS==events==['check']
        assert all(value is owner for value,owner in zip(result,expected))
        assert fast.compiled_calls==1 and fast.fallback_calls==0
    finally:CHECK_KIND=ChangingKind;CLASS_EVENTS.clear()


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


LIFETIME_EVENTS=[]
class LifetimeOwner:
    def __del__(self):LIFETIME_EVENTS.append('drop')
class LifetimeHolder:
    def __init__(self):self.owner=LifetimeOwner()
    def __iter__(self):
        LIFETIME_EVENTS.append('call')
        self.owner=None
        LIFETIME_EVENTS.append('after')
        return iter(())
LIFETIME_HOLDER=None


def source_slot_lifetime(node):
    owner=LIFETIME_HOLDER.owner
    list(LIFETIME_HOLDER)
    def visit(item):return item.id
    visit(node)
    return None


def test_native_source_local_lives_until_frame_exit():
    global LIFETIME_HOLDER
    node=ast.Name(id='input');fast=lift_managed(source_slot_lifetime)
    try:
        LIFETIME_HOLDER=LifetimeHolder();LIFETIME_EVENTS.clear();source_slot_lifetime(node)
        expected=list(LIFETIME_EVENTS)
        LIFETIME_HOLDER=LifetimeHolder();LIFETIME_EVENTS.clear();fast(node)
        assert LIFETIME_EVENTS==expected==['call','after','drop']
        assert fast.compiled_calls==1 and fast.fallback_calls==0
    finally:LIFETIME_HOLDER=None;LIFETIME_EVENTS.clear()


def test_native_recursive_closure_has_original_gc_cycle_lifetime():
    import gc,importlib,weakref
    function=importlib.import_module('recompyler.lift')._local_names
    node=ast.parse('def f():\n x=1\n return x\n').body[0]
    fast=lift_managed(function)
    previous=gc.isenabled();gc.collect();gc.disable()
    try:
        expected=function(node);reference=weakref.ref(expected);del expected
        actual=fast(node);selected=weakref.ref(actual);del actual
        assert (selected() is not None)==(reference() is not None)==True
        assert fast.compiled_calls==1 and fast.fallback_calls==0
    finally:
        if previous:gc.enable()
        gc.collect()


@pytest.mark.parametrize('fn,expected_calls',[(closure_in_loop,3),(two_helpers,9)])
def test_local_helper_family_uses_native_callees(fn,expected_calls):
    from recompyler._visitors import lift_visitors
    native=lift_visitors(fn)
    assert native.run is not None
    assert native([1,2,3])==fn([1,2,3])
    assert native.compiled_calls==1 and native.fallback_calls==0
    assert native.native_helper_calls==expected_calls


def test_native_local_helpers_use_shared_append_without_dispatch():
    from recompyler._visitors import lift_visitors
    native=lift_visitors(two_helpers,call_kinds=True)
    assert native([1,2,3])==two_helpers([1,2,3])
    assert native.compiled_calls==1 and native.fallback_calls==0
    assert native.managed_call_counts.get('append',0)==0
    assert native.managed_dispatch_counts.get('arithmetic',0)==0
    assert native.managed_dispatch_calls==0
    assert sum(native.managed_call_counts.values())==native.managed_calls


def helper_transitive_cells(values,step):
    def twice(value):return plus(value)+plus(value)
    def plus(step):return step+offset
    offset=step
    found=[]
    for value in values:found.append(twice(value))
    return found


def test_native_helpers_pass_transitive_cells_with_shadowed_parameters():
    from recompyler._visitors import lift_visitors
    native=lift_visitors(helper_transitive_cells)
    assert native.run is not None,native.problem
    assert native([1,2],4)==helper_transitive_cells([1,2],4)
    assert native.compiled_calls==1 and native.native_helper_calls==6 and native.fallback_calls==0


def mutual_helpers(value):
    def first(item):return second(item)
    def second(item):return first(item)
    return first(value)


def early_helper_call(value):
    def first(item):return second(item)
    first(value)
    def second(item):return item
    return None


@pytest.mark.parametrize('function',[mutual_helpers,early_helper_call])
def test_unsafe_local_helper_catalogues_decline_native_before_execution(function):
    from recompyler._visitors import lift_visitors
    assert lift_visitors(function).run is None


MIXED_HOLDER=None
class MixedOwner:
    def __init__(self,name,events):self.name=name;self.events=events
    def __del__(self):self.events.append(self.name)
class MixedHolder:
    def __init__(self,events):self.a=MixedOwner('a',events);self.b=MixedOwner('b',events)
    def __iter__(self):self.a=None;self.b=None;return iter(())


def native_mixed_slots(node):
    a=MIXED_HOLDER.a;b=MIXED_HOLDER.b
    list(MIXED_HOLDER)
    def visit(item):
        a
        return item.id
    visit(node)
    return None


def test_native_cells_and_locals_have_original_cleanup_order():
    global MIXED_HOLDER
    events=[];node=ast.Name(id='owned');fast=lift_managed(native_mixed_slots)
    try:
        MIXED_HOLDER=MixedHolder(events);native_mixed_slots(node);reference=list(events);events.clear()
        MIXED_HOLDER=MixedHolder(events);fast(node)
        assert events==reference==['a','b']
        assert fast.compiled_calls==1 and fast.fallback_calls==0
    finally:MIXED_HOLDER=None
