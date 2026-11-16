"""Preloading reads exact namespaces under watcher coverage without user protocols."""
import gc
import weakref
import pytest
from types import FunctionType


def template(value):return global_value(value),len(())


def make_fn(namespace):return FunctionType(template.__code__.replace(),namespace)


def test_preload_resolves_global_and_builtin_bindings():
    from recompyler.ir.preload import preload_function
    function=make_fn({'global_value':abs})
    with preload_function(function) as prepared:
        first=next(binding for binding in prepared.bindings if binding.name=='global_value')
        second=next(binding for binding in prepared.bindings if binding.name=='len')
        assert first.origin=='globals' and prepared.resolve(first) is abs
        assert second.origin=='builtins' and prepared.resolve(second) is len
        assert prepared.valid and prepared.code is function.__code__
    assert not prepared.valid


def test_mutation_invalidates_before_stale_value_is_resolved():
    from recompyler.ir.preload import preload_function,PreloadInvalidated
    namespace={'global_value':abs};function=make_fn(namespace)
    with preload_function(function) as prepared:
        binding=next(b for b in prepared.bindings if b.name=='global_value')
        namespace['global_value']=round
        assert not prepared.valid
        with pytest.raises(PreloadInvalidated):prepared.resolve(binding)


def test_missing_global_is_metadata_and_never_raises_runtime_nameerror_at_compile_time():
    from recompyler.ir.preload import preload_function
    function=make_fn({})
    with preload_function(function) as prepared:
        binding=next(b for b in prepared.bindings if b.name=='global_value')
        assert binding.origin is None and binding.identity==0


def test_preload_does_not_pin_old_global_after_mutation():
    from recompyler.ir.preload import preload_function
    events=[]
    class Value:
        def __del__(self):events.append('drop')
    namespace={'global_value':Value()};function=make_fn(namespace)
    prepared=preload_function(function)
    namespace['global_value']=None
    assert events==['drop'] and not prepared.valid
    prepared.close()


def test_mixed_key_namespace_declines_without_equality_callbacks():
    from recompyler.ir.preload import preload_function,PreloadUnsupported
    events=[]
    class Key:
        def __hash__(self):return hash('global_value')
        def __eq__(self,other):events.append('eq');return False
    namespace={Key():1};function=make_fn(namespace)
    with pytest.raises(PreloadUnsupported):preload_function(function)
    assert events==[]


def test_preload_does_not_keep_original_function_or_defaults_alive():
    from recompyler.ir.preload import preload_function
    events=[]
    class Token:
        def __del__(self):events.append('drop')
    function=make_fn({'global_value':abs});function.__defaults__=(Token(),)
    ref=weakref.ref(function);prepared=preload_function(function)
    del function
    assert ref() is None and events==['drop'] and not prepared.valid
    prepared.close()


def test_code_change_invalidates_preload_without_retaining_original_function():
    from recompyler.ir.preload import preload_function
    function=make_fn({'global_value':abs});prepared=preload_function(function)
    function.__code__=function.__code__.replace()
    assert not prepared.valid
    prepared.close()

def test_dependencies_can_transfer_to_execution_owner_without_invalidating(monkeypatch):
    from recompyler.ir.preload import preload_function
    namespace={'global_value':abs};function=make_fn(namespace)
    prepared=preload_function(function)
    dependency=prepared.detach_dependencies()
    assert not prepared.valid and dependency.valid
    prepared.close()
    assert dependency.valid
    namespace['global_value']=round
    assert not dependency.valid


def test_code_change_during_preload_construction_is_rejected(monkeypatch):
    from recompyler.ir import preload
    function=make_fn({'global_value':abs})
    original=preload.PreloadedFunction.__init__
    def changing(self,fn,*args):
        fn.__code__=fn.__code__.replace()
        original(self,fn,*args)
    monkeypatch.setattr(preload.PreloadedFunction,'__init__',changing)
    with pytest.raises(preload.PreloadInvalidated):preload.preload_function(function)


def test_function_death_releases_its_private_namespace_without_gc():
    from recompyler.ir.preload import preload_function
    events=[]
    class Token:
        def __del__(self):events.append('drop')
    function=make_fn({'global_value':Token()})
    prepared=preload_function(function)
    del function
    assert events==['drop'] and not prepared.valid
    prepared.close()
