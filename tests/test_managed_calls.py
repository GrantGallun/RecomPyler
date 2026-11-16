"""Compiled control flow with exact managed CPython call boundaries."""
import hashlib
import pytest
from recompyler import heap


def digest_head(source):
    return hashlib.sha256(source.encode()).hexdigest()


def call_order(callee, first, second):
    return callee(first(), flag=second())


def call_then_failure(items, action):
    items.append(action())
    return missing_bridge_name(items)


def alias_call(items, action):
    saved = items
    action(items)
    return saved


def global_rebinding(argument):
    return bridge_target(argument())


bridge_target = lambda value: ('old', value)


def _compile(fn):
    constructor = getattr(heap, 'lift_calls', None)
    assert constructor is not None, 'managed call compiler is missing'
    return constructor(fn)


def test_library_hash_chain_is_compiled():
    lifted = _compile(digest_head)
    assert lifted('hello') == digest_head('hello')
    assert lifted.compiled_calls == 1
    assert lifted.managed_calls == 3
    assert lifted.fallback_calls == 0


def test_real_source_digest_runs_compiled_control_flow():
    expected = heap._source_digest('managed call regression')
    lifted = _compile(heap._source_digest)
    assert lifted('managed call regression') == expected
    assert lifted.compiled_calls == 1
    assert lifted.managed_calls > 30
    assert lifted.fallback_calls == 0


def test_positional_keyword_order_and_original_result():
    events = []
    result = object()
    def first():
        events.append('first')
        return result
    def second():
        events.append('second')
        return result
    def target(value, *, flag):
        events.append('call')
        assert value is flag is result
        return result
    lifted = _compile(call_order)
    assert lifted(target, first, second) is result
    assert events == ['first', 'second', 'call']
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_exception_keeps_instance_and_effects_once():
    items = []
    error = ValueError('after mutation')
    def action():
        items.append('called')
        raise error
    lifted = _compile(call_then_failure)
    with pytest.raises(ValueError) as caught:
        lifted(items, action)
    assert caught.value is error
    assert items == ['called']
    assert lifted.fallback_calls == 0


def test_name_failure_after_effect_does_not_replay():
    items = []
    lifted = _compile(call_then_failure)
    with pytest.raises(NameError, match="name 'missing_bridge_name' is not defined"):
        lifted(items, lambda: 'once')
    assert items == ['once']
    assert lifted.fallback_calls == 0


def test_callback_mutation_uses_live_original_owner():
    items = []
    lifted = _compile(alias_call)
    assert lifted(items, lambda original: original.append(original)) is items
    assert items[0] is items
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_callee_is_loaded_before_arguments_and_refreshed_next_call():
    global bridge_target
    original = bridge_target
    def rebind():
        global bridge_target
        bridge_target = lambda value: ('new', value)
        return 7
    lifted = _compile(global_rebinding)
    try:
        assert lifted(rebind) == ('old', 7)
        assert lifted(lambda: 8) == ('new', 8)
        assert lifted.compiled_calls == 2 and lifted.fallback_calls == 0
    finally:
        bridge_target = original

def constant_tuple_owner():
    return ('managed-original-tuple', b'managed-original-bytes')


def deleted_local_after_call(action):
    kept = action()
    return (kept, kept)


def dynamic_compile(source, namespace):
    parsed = compile(source, '<managed regression>', 'exec')
    exec(parsed, namespace)
    return namespace['answer']


def invalid_call_after_effect(action, target):
    return target(action(), unknown=True)


def test_original_constant_tuple_owner():
    lifted = _compile(constant_tuple_owner)
    assert lifted() is constant_tuple_owner()
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_repeated_result_identity_and_exception_cleanup():
    import gc
    events = []
    class Result:
        def __del__(self):
            events.append('released')
    lifted = _compile(deleted_local_after_call)
    pair = lifted(Result)
    assert pair[0] is pair[1]
    del pair
    gc.collect()
    assert events == ['released']


def test_compile_exec_call_boundaries_mutate_original_namespace():
    namespace = {}
    lifted = _compile(dynamic_compile)
    assert lifted('answer = object()', namespace) is namespace['answer']
    assert lifted.compiled_calls == 1 and lifted.managed_calls == 2
    assert lifted.fallback_calls == 0


def test_invalid_keyword_error_after_effect_has_no_replay():
    events = []
    def action():
        events.append('once')
        return 1
    lifted = _compile(invalid_call_after_effect)
    with pytest.raises(TypeError) as expected:
        invalid_call_after_effect(lambda: 1, len)
    with pytest.raises(TypeError) as caught:
        lifted(action, len)
    assert type(caught.value) is type(expected.value)
    assert str(caught.value) == str(expected.value)
    assert events == ['once']
    assert lifted.fallback_calls == 0


def test_missing_global_has_exact_exception_context():
    lifted = _compile(call_then_failure)
    try:
        lifted([], lambda: None)
    except NameError as error:
        assert error.__context__ is None
        assert error.name == 'missing_bridge_name'
    else:
        pytest.fail('expected a NameError')

def test_call_region_supports_shared_frontend_extension():
    from recompyler._call_bridge import CallRegion, _Compiler
    events = []
    class Extension(_Compiler):
        def compile(self):
            events.append(self.fn)
            return super().compile()
    class ExtendedRegion(CallRegion):
        compiler_type = Extension
    lifted = ExtendedRegion(digest_head)
    assert lifted('extension') == digest_head('extension')
    assert events == [digest_head]
    assert lifted.compiled_calls == 1


def implicit_generated_exec(source):
    exec(source)
    return locals()


def test_implicit_exec_uses_original_globals_and_local_snapshot():
    lifted = _compile(implicit_generated_exec)
    actual = lifted('created = 42')
    assert actual == implicit_generated_exec('created = 42')
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0

def presentation_signature(value):
    return value


def exact_globals_owner():
    return globals()


def test_argument_binding_ignores_presentation_signature():
    import inspect
    presentation_signature.__signature__ = inspect.Signature([
        inspect.Parameter('other', inspect.Parameter.POSITIONAL_OR_KEYWORD)])
    try:
        lifted = _compile(presentation_signature)
        marker = object()
        assert lifted(marker) is marker
        assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0
    finally:
        del presentation_signature.__signature__


def test_globals_returns_original_function_namespace_owner():
    lifted = _compile(exact_globals_owner)
    assert lifted() is exact_globals_owner.__globals__
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0

import inspect
import numba
from llvmlite import ir
from recompyler import scalar, numeric_versions


def inspect_function(function):
    return inspect.signature(function)


def compile_numeric_function(function, signature):
    compiled = numba.njit(function)
    compiled.compile(signature)
    return compiled


def build_llvm_pointer(width):
    return ir.IntType(width).as_pointer()


def numeric_kernel(value):
    return value + 1


def sum_library_values(values, target):
    for value in values:
        target.append(str(value))
    return target


@pytest.mark.parametrize('helper', [scalar.parse_expr, numeric_versions.parse])
def test_real_expression_parser_uses_managed_ast_parse(helper):
    import ast
    lifted = _compile(helper)
    result = lifted('a + 3')
    assert type(result) is ast.BinOp
    assert ast.dump(result) == ast.dump(helper('a + 3'))
    assert lifted.compiled_calls == 1 and lifted.managed_calls == 1
    assert lifted.fallback_calls == 0
    with pytest.raises(SyntaxError) as expected:
        helper('a +')
    with pytest.raises(SyntaxError) as actual:
        lifted('a +')
    assert actual.value.args == expected.value.args
    assert lifted.fallback_calls == 0


def test_inspect_signature_library_boundary():
    lifted = _compile(inspect_function)
    assert lifted(call_order) == inspect.signature(call_order)
    assert lifted.compiled_calls == 1 and lifted.managed_calls == 1
    assert lifted.fallback_calls == 0


def test_numba_compilation_orchestration_boundary():
    lifted = _compile(compile_numeric_function)
    compiled = lifted(numeric_kernel, (numba.int64,))
    assert compiled(41) == 42
    assert compiled.py_func is numeric_kernel
    assert lifted.compiled_calls == 1 and lifted.managed_calls == 2
    assert lifted.fallback_calls == 0


def test_llvm_library_object_result_remains_managed():
    lifted = _compile(build_llvm_pointer)
    result = lifted(32)
    assert type(result) is type(build_llvm_pointer(32))
    assert str(result) == 'i32*'
    assert lifted.compiled_calls == 1 and lifted.managed_calls == 2
    assert lifted.fallback_calls == 0


def test_iterator_exception_keeps_prior_mutation_without_replay():
    error = RuntimeError('iteration failed')
    def values():
        yield 7
        raise error
    target = []
    lifted = _compile(sum_library_values)
    with pytest.raises(RuntimeError) as actual:
        lifted(values(), target)
    assert actual.value is error
    assert target == ['7']
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0

def mixed_mutable_tuple():
    return ([], [], False)


def object_local_then_failure(value):
    kept = [value]
    return value.missing_bridge_field


def test_mutable_tuple_operands_are_constructed_separately():
    lifted = _compile(mixed_mutable_tuple)
    result = lifted()
    assert result == ([], [], False)
    assert result[0] is not result[1]
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0


def test_normal_compiler_entry_supports_explicit_experimental_backend():
    lifted = heap.lift_region(heap._source_digest, backend='managed')
    assert lifted('normal entry') == heap._source_digest('normal entry')
    assert lifted.compiled_calls == 1 and lifted.managed_calls > 30
    assert lifted.fallback_calls == 0


def test_failed_managed_operation_releases_native_local_references():
    import gc,weakref
    class Value:
        pass
    value = Value()
    reference=weakref.ref(value)
    lifted = _compile(object_local_then_failure)
    for _ in range(15):
        try:
            lifted(value)
        except AttributeError as error:
            error.__traceback__ = None
        else:
            pytest.fail('expected original attribute error')
    del value;gc.collect()
    assert reference() is None
    assert lifted.fallback_calls == 0

def folded_original_owner():
    prefix = 'managed-'
    suffix = 'folded-owner'
    return ('managed-' + 'folded-owner',)


def test_folded_constant_uses_shared_original_owner():
    lifted = _compile(folded_original_owner)
    assert lifted() is folded_original_owner()
    assert lifted.compiled_calls == 1 and lifted.fallback_calls == 0

def test_shared_frontend_can_opt_into_local_closure_cells():
    from recompyler._call_bridge import _Compiler, UnsupportedCall
    def outer():
        captured = []
        def child():
            return captured
        return captured
    with pytest.raises(UnsupportedCall):
        _Compiler(outer)
    class VisitorCompiler(_Compiler):
        allow_closure_cells = True
    try:
        compiler = VisitorCompiler(outer)
    except UnsupportedCall:
        compiler = None
    assert compiler is not None, 'shared initialization must allow the visitor policy hook'
    assert 'captured' in compiler.locals

def test_preimport_builtin_replacement_is_called_normally(tmp_path):
    import os
    from pathlib import Path
    import subprocess
    import sys
    code = '''import builtins,importlib,numba
from recompyler import heap
marker=[]
events=[]
def replacement():
    events.append('called')
    return marker
saved=builtins.globals
builtins.globals=replacement
try:importlib.import_module('recompyler._call_bridge')
finally:builtins.globals=saved
globals=replacement
def subject():return globals()
region=heap.lift_calls(subject)
assert region() is marker
assert events==['called']
assert region.compiled_calls==1 and region.fallback_calls==0
'''
    path=tmp_path/'preimport_context.py'
    path.write_text(code)
    child=subprocess.run([sys.executable,str(path)],capture_output=True,text=True,timeout=30,
        env=dict(os.environ,PYTHONPATH=str(Path(__file__).resolve().parents[1]/'src')))
    assert child.returncode==0,(child.stdout,child.stderr)


def test_error_holder_does_not_add_an_exception_reference_cycle():
    import gc
    import weakref
    class Value:
        pass
    lifted=_compile(object_local_then_failure)
    def invoke(call):
        value=Value()
        reference=weakref.ref(value)
        try:call(value)
        except AttributeError:pass
        del value
        return reference
    enabled=gc.isenabled()
    gc.disable()
    try:
        assert invoke(object_local_then_failure)() is None
        assert invoke(lifted)() is None
    finally:
        if enabled:gc.enable()
    assert lifted.compiled_calls==1 and lifted.fallback_calls==0

def test_future_compilation_context_declines_before_effects(tmp_path):
    source="from __future__ import annotations\ndef future_compilation():\n    return compile('x: int', '<generated>', 'exec').co_flags\n"
    filename=tmp_path/'future_context.py'
    filename.write_text(source)
    namespace={}
    exec(compile(source,str(filename),'exec'),namespace)
    original=namespace['future_compilation']
    lifted=heap.lift_calls(original)
    assert lifted()==original()
    assert lifted.compiled_calls==0 and lifted.fallback_calls==1


def invoke_under_exception(action):
    return action()


@pytest.mark.parametrize('lift', [heap.lift_calls, heap.lift_structures])
def test_active_caller_exception_keeps_inner_context_and_effects(lift):
    events = []
    def action():
        events.append('once')
        try:
            raise ValueError('inner')
        except ValueError:
            raise RuntimeError('result')
    lifted = lift(invoke_under_exception)
    assert lifted.run is not None, lifted.problem
    try:
        raise KeyError('outer')
    except KeyError:
        with pytest.raises(RuntimeError) as caught:
            lifted(action)
    assert type(caught.value.__context__) is ValueError
    assert str(caught.value.__context__) == 'inner'
    assert events == ['once']


def return_callback_value(action):
    return action()


def test_returned_callback_exception_has_no_wrapper_reference_cycle():
    import gc
    import sys
    import weakref
    class Marker:pass
    references=[]
    def factory():
        error=ValueError('returned')
        error.marker=Marker()
        references.append(weakref.ref(error.marker))
        return error
    def action():
        try:raise factory()
        except ValueError:return sys.exception()
    lifted=heap.lift_calls(return_callback_value)
    enabled=gc.isenabled()
    gc.disable()
    try:
        result=return_callback_value(action)
        del result
        assert references[-1]() is None
        result=lifted(action)
        del result
        assert references[-1]() is None
    finally:
        if enabled:gc.enable()
    assert lifted.compiled_calls==1 and lifted.fallback_calls==0
