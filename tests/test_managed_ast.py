"""S60 fail-first: compile the actual AST target helper, not a call to it."""
import ast
import importlib
import sys
import pytest
from recompyler.lift import Unsupported
L = importlib.import_module('recompyler.lift')


def target_equivalent(node):
    if isinstance(node, ast.Name):
        return [node.id]
    if isinstance(node, (ast.Tuple, ast.List)):
        return [value for child in node.elts for value in target_equivalent(child)]
    raise ValueError(f'bad target {node.lineno}')


def allocated_field(node):
    return node.payload


class Allocated:
    def __new__(cls, payload):
        value = super().__new__(cls)
        value.payload = payload
        return value


def build(fn):
    from recompyler.managed import lift_managed
    return lift_managed(fn)


@pytest.mark.parametrize('fn', [L._target_names, target_equivalent])
@pytest.mark.parametrize('source', ['left = 1', 'a, (b, c) = values', '[a, [b, c]] = values'])
def test_real_helper_native_control_and_recursion(fn, source):
    target = ast.parse(source).body[0].targets[0]
    fast = build(fn)
    result = fast(target)
    assert result == fn(target)
    assert fast.compiled_calls == 1 and fast.fallback_calls == 0
    assert fast.whole_function_fallback_calls == 0
    assert fast.managed_calls == 0  # field/iteration/list protocols are intrinsic.
    assert '_target_names(' not in fast.source and 'target_equivalent(' not in fast.source
    assert fast._compiled.nopython_signatures
    owners = [n.id for n in ast.walk(target) if type(n) is ast.Name]
    assert all(any(value is owner for owner in owners) for value in result)


@pytest.mark.parametrize('fn,exception,message', [(L._target_names, Unsupported, 'assignment target at line 1'), (target_equivalent, ValueError, 'bad target 1')])
def test_original_exception_type_and_message(fn, exception, message):
    target = ast.parse('obj.field = 1').body[0].targets[0]
    fast = build(fn)
    with pytest.raises(exception) as exc:
        fast(target)
    assert str(exc.value) == message
    assert fast.compiled_calls == 1 and fast.fallback_calls == 0


def test_custom_allocation_and_exact_field_identity():
    held = object()
    value = Allocated(held)
    fast = build(allocated_field)
    assert fast(value) is held
    assert fast.compiled_calls == 1


def test_object_lifetime_on_success_and_exception():
    import gc,weakref
    fast = build(L._target_names)
    good = ast.parse('a, [b,c] = values').body[0].targets[0]
    bad = ast.parse('obj.field = value').body[0].targets[0]
    references=[weakref.ref(good),weakref.ref(bad)]
    for _ in range(1000):
        assert fast(good) == ['a','b','c']
        with pytest.raises(Unsupported):fast(bad)
    del good,bad;gc.collect()
    assert all(reference() is None for reference in references)


def test_missing_field_exception_does_not_replay():
    fast = build(allocated_field)
    value = ast.Name(id='a')
    with pytest.raises(AttributeError,match='payload'):fast(value)
    assert fast.compiled_calls == 1 and fast.fallback_calls == 0

OUTER_NAME = 'outer owner'

def comprehension_shadow(node):
    OUTER_NAME = node.id
    result = [OUTER_NAME for OUTER_NAME in node.elts]
    return result, OUTER_NAME

def unbound_local(node, flag):
    if flag:
        OUTER_NAME = node.id
    return OUTER_NAME

def predicate_value(node):
    return isinstance(node, ast.Name)


def test_comprehension_scope_restores_outer_local():
    node=ast.Tuple(elts=[ast.Name(id='a')]);node.id='original'
    fast=build(comprehension_shadow)
    result=fast(node)
    assert result[0][0] is node.elts[0] and result[1] is node.id


def test_native_ast_potentially_unbound_local_declines_at_construction():
    from recompyler.managed import ManagedLifted
    with pytest.raises(Unsupported,match='before assignment'):
        ManagedLifted(unbound_local)


def test_native_predicate_value_keeps_singleton_owner():
    fast=build(predicate_value)
    assert fast(ast.Name(id='x')) is True
    assert fast(ast.Tuple(elts=[])) is False


def constant_tuple():
    return ('pooled-owner',)

def formatted_field(node):
    raise ValueError(f'field {node.payload}')

class Formatted:
    def __format__(self, spec):return 'formatted'
    def __str__(self):return 'string'


def isinstance_binding(node):
    return isinstance(node, ast.Name)


def keyword_default(node, *, chosen=ast.Name(id='first')):
    return chosen


def test_original_pooled_tuple_owner():
    fast=build(constant_tuple)
    assert fast() is constant_tuple()


def test_fstring_default_uses_format_protocol():
    fast=build(formatted_field)
    with pytest.raises(ValueError,match='^field formatted$'):
        fast(Allocated(Formatted()))


def test_builtin_guard_checks_new_global_shadow():
    fast=build(isinstance_binding)
    sentinel=object();previous=globals().get('isinstance',sentinel)
    globals()['isinstance']=lambda *args:False
    try:
        assert fast(ast.Name(id='x')) is False
        assert fast.fallback_calls==1
    finally:
        if previous is sentinel:globals().pop('isinstance')
        else:globals()['isinstance']=previous


def test_mutated_keyword_default_is_live():
    fast=build(keyword_default);prior=keyword_default.__kwdefaults__['chosen']
    current=ast.Name(id='replacement')
    try:
        keyword_default.__kwdefaults__['chosen']=current
        assert fast(ast.Name(id='x')) is current and fast.fallback_calls==1
    finally:keyword_default.__kwdefaults__['chosen']=prior


def retain_then_fail(node):
    values = [node]
    answer = node.missing
    return [values, answer]

G = 'before owner'
NEW = 'after owner'
class RebindOnTruth:
    def __bool__(self):
        global G
        G = NEW
        return True

def callback_rebinding(node):
    if node:return G
    return G

class SingleMessageError(Exception):
    def __init__(self,message):super().__init__(message)

def tuple_message(node):
    raise SingleMessageError(node)


def test_exception_exit_releases_all_native_locals():
    import gc
    node=ast.Name(id='original');fast=build(retain_then_fail)
    import weakref
    reference=weakref.ref(node)
    for _ in range(100):
        with pytest.raises(AttributeError):fast(node)
    gc.collect()
    del node;gc.collect()
    assert reference() is None


def test_callback_rebinding_is_exact_or_declined_before_entry():
    global G
    fast=build(callback_rebinding)
    G='before owner'
    try:assert fast(RebindOnTruth()) is NEW
    finally:G='before owner'


def test_exception_constructor_receives_tuple_as_one_argument():
    fast=build(tuple_message)
    with pytest.raises(SingleMessageError) as caught:fast((1,2))
    assert caught.value.args==((1,2),)


def test_managed_ast_fresh_aot_without_numba(tmp_path):
    import json,os,subprocess
    from recompyler.managed import build_managed_aot,load_managed_aot
    section=build_managed_aot(L._target_names,tmp_path)
    fast=load_managed_aot(L._target_names,section)
    node=ast.parse('a,[b,c]=values').body[0].targets[0]
    assert fast(node)==['a','b','c'] and fast.compiled_calls==1
    code="""import ast,importlib,json,sys
from recompyler.managed import load_managed_aot
fn=importlib.import_module('recompyler.lift')._target_names
assert 'numba' not in sys.modules
fast=load_managed_aot(fn,json.loads(sys.argv[1]))
node=ast.parse('a,[b,c]=values').body[0].targets[0]
assert fast(node)==['a','b','c'] and fast.compiled_calls==1
try:fast(ast.parse('obj.field=1').body[0].targets[0])
except Exception as exc:assert type(exc) is importlib.import_module('recompyler.lift').Unsupported and str(exc)=='assignment target at line 1'
else:raise AssertionError('missing error')
assert 'numba' not in sys.modules
print('native AST AOT without Numba')
"""
    result=subprocess.run([sys.executable,'-c',code,json.dumps(section)],capture_output=True,text=True,env=os.environ.copy(),timeout=60)
    assert result.returncode==0,(result.stdout,result.stderr)
    assert 'native AST AOT without Numba' in result.stdout

GLOBAL_CALLBACK = RebindOnTruth()

def global_callback_rebinding():
    if GLOBAL_CALLBACK:return G
    return G

class PropertyRebinding:
    @property
    def payload(self):
        global G
        G=NEW
        return 'field'

def property_callback_rebinding(node):
    value=node.payload
    return G


@pytest.mark.parametrize('fn,args',[(global_callback_rebinding,()),(property_callback_rebinding,(PropertyRebinding(),))])
def test_global_and_property_callbacks_decline_before_effects(fn,args):
    global G
    fast=build(fn);G='before owner'
    try:
        assert fast(*args) is NEW
        assert fast.fallback_calls==1 and fast.compiled_calls==0
    finally:G='before owner'


def test_cyclic_recursive_ast_declines_before_native_entry():
    from recompyler.managed import _admitted_arguments
    node=ast.Tuple(elts=[]);node.elts.append(node)
    assert not _admitted_arguments((node,),{'id','elts','lineno'})
    fast=build(L._target_names)
    with pytest.raises(RecursionError):fast(node)
    assert fast.compiled_calls==0 and fast.fallback_calls==1


def same_argument_recursion(node):
    if isinstance(node,ast.Name):return [node.id]
    return same_argument_recursion(node)


def test_native_recursion_requires_a_descending_owner():
    with pytest.raises(Unsupported,match='recurs.*progress|descend'):
        build(same_argument_recursion)

class ClassOwnedChild:
    pass
CLASS_CHILD = ClassOwnedChild()
ClassOwnedChild.child = CLASS_CHILD


def apparent_field_descent(node):
    if isinstance(node,ast.Name):return [node.id]
    return apparent_field_descent(node.child)


def primitive_field_descent(node):
    if isinstance(node,ast.Name):return [node.id]
    return primitive_field_descent(node.real)


def primitive_index_descent(node):
    if isinstance(node,ast.Name):return [node.id]
    return primitive_index_descent(node[0])


@pytest.mark.parametrize('fn,value',[(apparent_field_descent,CLASS_CHILD),(primitive_field_descent,1.0),(primitive_index_descent,'a')])
def test_nonphysical_recursive_step_declines_before_replayable_read_only_entry(fn,value):
    fast=build(fn)
    with pytest.raises(RecursionError):fast(value)
    assert fast.compiled_calls==0 and fast.fallback_calls==1

META_EVENTS=[]
class QuietMeta(type):
    def __eq__(cls,other):
        META_EVENTS.append('comparison')
        return False
    __hash__=type.__hash__
class MetaValue(metaclass=QuietMeta):
    def __init__(self):self.payload='instance owner'


def test_custom_metaclass_decline_does_not_call_comparison_hooks():
    fast=build(allocated_field);value=MetaValue();META_EVENTS.clear()
    assert fast(value) is value.payload
    assert META_EVENTS==[]
    assert fast.compiled_calls==0 and fast.fallback_calls==1

class ContextConstructorError(Exception):
    def __init__(self,value):
        try:raise ValueError('inner context')
        except ValueError:raise RuntimeError('constructor failed')


def constructor_context(value):
    raise ContextConstructorError(value)


def test_managed_ast_preserves_preexisting_handled_exception_context():
    fast=build(constructor_context)
    def outcome(fn):
        try:raise KeyError('outer context')
        except KeyError:
            try:fn(3)
            except RuntimeError as exc:
                return type(exc.__context__),str(exc.__context__)
    assert outcome(fast)==outcome(constructor_context)==(ValueError,'inner context')
    assert fast.compiled_calls==0 and fast.fallback_calls==1


GUARD_MODULE_EVENTS=[]
class GuardModuleValue:
    def __eq__(self,other):GUARD_MODULE_EVENTS.append(other);return False
class GuardPayload:
    def __init__(self,payload):self.payload=payload
class GuardForeignSlot:
    __slots__=('ghost',)
class GuardForeignPayload:
    foreign=GuardForeignSlot.__dict__['ghost']
    def __init__(self,payload):self.payload=payload


def guard_payload(value):return value.payload


def test_guard_does_not_compare_arbitrary_class_module_values():
    original=GuardPayload.__module__
    marker=object();value=GuardPayload(marker);fast=build(guard_payload)
    try:
        GuardPayload.__module__=GuardModuleValue();GUARD_MODULE_EVENTS.clear()
        assert fast(value) is marker
        assert GUARD_MODULE_EVENTS==[]
    finally:GuardPayload.__module__=original;GUARD_MODULE_EVENTS.clear()


def test_irrelevant_foreign_slot_declines_without_guard_exception():
    marker=object();value=GuardForeignPayload(marker);fast=build(guard_payload)
    assert fast(value) is marker
