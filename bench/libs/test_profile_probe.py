import gc
import sys
import types
import weakref
import pytest


def test_probe_distinguishes_functions_with_shared_code():
    from bench.libs._frame_function_native import function
    def body():
        return function(sys._getframe())
    alias = types.FunctionType(body.__code__, body.__globals__, 'alias', closure=body.__closure__)
    assert body() is body
    assert alias() is alias
    assert alias.__code__ is body.__code__


def test_probe_rejects_non_frames_and_does_not_retain_function():
    from bench.libs._frame_function_native import function
    with pytest.raises(TypeError):
        function(None)
    def make():
        namespace = {'function': function, 'sys': sys}
        exec('def transient():\n return function(sys._getframe())', namespace)
        target = namespace.pop('transient')
        assert target() is target
        return weakref.ref(target), weakref.ref(target.__code__)
    target, code = make()
    gc.collect()
    assert target() is None
    assert code() is None

