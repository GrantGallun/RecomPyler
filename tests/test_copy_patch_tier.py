"""T1 accepts only a proved callback-free prefix and uses immutable stencils."""
import dataclasses
import json
import types
import weakref
from opcode import opmap
import pytest


def api():
    from recompyler.copy_patch_tier import classify, load_pack, Unsupported
    return classify, load_pack, Unsupported


def test_identity_and_constant_plans_do_not_retain_source_or_constants():
    classify, _, _ = api()
    def identity(value): return value
    plan = classify(identity)
    assert [op.name for op in plan.operations] == ['entry', 'arg', 'return']
    assert plan.operations[1].operand == 0
    assert plan.bytecodes == len(identity.__code__.co_code) // 2
    assert plan.source() is identity.__code__
    class Constant: pass
    value = Constant()
    def constant(): return None
    code = constant.__code__.replace(co_consts=(None, value),
        co_code=bytes([opmap['RESUME'], 0, opmap['LOAD_CONST'], 1, opmap['RETURN_VALUE'], 0]))
    fn = types.FunctionType(code, {})
    plan = classify(fn)
    ref = weakref.ref(value)
    del fn, code, value
    assert plan.source() is None
    assert ref() is None


@pytest.mark.parametrize('source', [
    'def f(x):\n return x+1',
    'def f(x):\n x=1\n return x',
    'def f(*x):\n return x',
    'def f(x, *, y=1):\n return x',
    'def f(x):\n return x.missing',
    'def f(x):\n yield x',
])
def test_effects_and_unproved_shapes_decline_without_executing(source):
    classify, _, Unsupported = api()
    namespace = {}
    exec(source, namespace)
    with pytest.raises(Unsupported): classify(namespace['f'])


def test_closure_and_nonfunction_decline_without_user_protocols():
    classify, _, Unsupported = api()
    value = object()
    def closure(): return value
    with pytest.raises(Unsupported): classify(closure)
    class Callable:
        def __getattribute__(self, name): raise AssertionError(name)
        def __call__(self): raise AssertionError('called')
    with pytest.raises(Unsupported): classify(Callable())


def test_plan_is_immutable_and_bytecode_prefix_is_fully_checked():
    classify, _, Unsupported = api()
    def identity(x): return x
    plan = classify(identity)
    with pytest.raises(dataclasses.FrozenInstanceError): plan.bytecodes = 0
    code = identity.__code__.replace(co_code=identity.__code__.co_code + bytes([100, 255]))
    with pytest.raises(Unsupported): classify(types.FunctionType(code, {}))


def test_pack_is_bound_to_build_and_rejects_modified_stencils(tmp_path):
    _, load_pack, _ = api()
    pack = load_pack()
    assert set(pack.stencils) == {'entry', 'arg', 'const', 'return'}
    assert all(stencil.code for stencil in pack.stencils.values())
    document = json.loads(pack.path.read_text())
    document['stencils']['arg']['code'] = 'c3'
    path = tmp_path/'changed.json'
    path.write_text(json.dumps(document))
    with pytest.raises(ValueError, match='digest'): load_pack(path)
    document = json.loads(pack.path.read_text())
    document['runtime'] = 'different interpreter build'
    path.write_text(json.dumps(document))
    with pytest.raises(ValueError, match='runtime'): load_pack(path)

@pytest.mark.slow
def test_native_entry_preserves_binding_identity_lifetime_and_invalidation():
    import subprocess, sys, textwrap
    program = r'''
        import gc, inspect, sys, weakref
        from recompyler.copy_patch_tier import compile_function
        def identity(value=17): return value
        original_code = identity.__code__
        compiled = compile_function(identity)
        handle = compiled.install(identity)
        assert handle.active
        assert identity.__code__ is original_code
        assert str(inspect.signature(identity)) == '(value=17)'
        values = [None, True, 1, 2**200, -0.0, complex(1,-0.0), [], object()]
        for value in values:
            for _ in range(1000): assert identity(value) is value
        assert identity() == 17 and identity(value=19) == 19
        try: identity(1,2)
        except TypeError as error:
            assert 'positional' in str(error)
            assert error.__traceback__.tb_next is None
        else: raise AssertionError('bad arguments accepted')
        class Host: method=identity
        host=Host()
        assert host.method() is host
        events=[]
        class Temporary:
            def __del__(self): events.append('free')
        value=Temporary(); ref=weakref.ref(value)
        result=identity(value);del value
        assert ref() is result and events==[]
        del result
        assert ref() is None and events==['free']
        def changed(value=17): return ('changed',value)
        identity.__code__=changed.__code__
        assert not handle.active and identity(3)==('changed',3)
        handle.close()
        assert 'llvmlite' not in sys.modules
        assert 'recompyler.ir.compiler' not in sys.modules
    '''
    subprocess.run([sys.executable, '-c', textwrap.dedent(program)], check=True)


@pytest.mark.slow
def test_native_constant_and_observer_fallback_use_the_source_frame():
    import subprocess, sys, textwrap
    program = r'''
        import sys
        from recompyler.copy_patch_tier import compile_function
        def constant(): return (1,2,3)
        compiled=compile_function(constant)
        handle=compiled.install(constant)
        assert handle.active and constant() is constant.__code__.co_consts[1]
        events=[]
        def trace(frame,event,arg):
            if frame.f_code is constant.__code__: events.append(event)
            return trace
        sys.settrace(trace)
        try: assert constant()==(1,2,3)
        finally: sys.settrace(None)
        assert 'call' in events and 'return' in events and not handle.active
        handle.close()
    '''
    subprocess.run([sys.executable, '-c', textwrap.dedent(program)], check=True)


@pytest.mark.slow
def test_native_owner_does_not_retain_function_code_or_returned_constant():
    import subprocess, sys, textwrap
    program = r'''
        import gc, types, weakref
        from opcode import opmap
        from recompyler.copy_patch_tier import compile_function
        class Value: pass
        value=Value()
        def stub(): return None
        code=stub.__code__.replace(co_consts=(None,value),co_code=bytes([
            opmap['RESUME'],0,opmap['LOAD_CONST'],1,opmap['RETURN_VALUE'],0]))
        function=types.FunctionType(code,{})
        compiled=compile_function(function);handle=compiled.install(function)
        assert handle.active and function() is value
        refs=[weakref.ref(obj) for obj in (function,code,value)]
        del function,code,value
        gc.collect()
        assert all(ref() is None for ref in refs)
        assert not handle.active
        handle.close()
        del compiled,handle
        gc.collect()
    '''
    subprocess.run([sys.executable, '-c', textwrap.dedent(program)], check=True)

@pytest.mark.slow
def test_audit_mutation_between_install_check_and_publication_cannot_rebind_machine_code():
    import subprocess, sys, textwrap
    program = r'''
        import sys
        from recompyler.copy_patch_tier import compile_function
        def original(value): return value
        def replacement(value): return 990
        changed_code=replacement.__code__
        compiled=compile_function(original)
        reads=0
        def audit(event,args):
            global reads
            if event=='object.__getattr__' and args[0] is original and args[1]=='__code__':
                reads+=1
                if reads==2: original.__code__=changed_code
        sys.addaudithook(audit)
        try: handle=compiled.install(original)
        except (ValueError,RuntimeError): pass
        else:
            assert original(5)==990 if reads>=2 else original(5)==5
            handle.close()
    '''
    subprocess.run([sys.executable, '-c', textwrap.dedent(program)], check=True)
