"""AOT source seals follow generated callees through runner-owned wrappers."""
import ast
import functools
from types import SimpleNamespace
from recompyler import aot,lift

def helper(value):
    return value + 1

def changed_helper(value):
    return value + 2

def caller(value):
    return helper(value) * 2

def generated():
    unit=lift._Unit();unit.function(caller)
    source=ast.unparse(ast.fix_missing_locations(ast.Module(body=unit.definitions,type_ignores=[])))
    return unit,source

def test_runner_wrapped_callee_keeps_generated_aot_identity():
    original=helper
    before,source=generated()
    @functools.wraps(original)
    def fast(*args,**kwargs):
        return original(*args,**kwargs)
    fast.__recompyler_original__=original
    try:
        globals()['helper']=fast
        after,wrapped_source=generated()
        assert source==wrapped_source
        assert aot._digest(before,source)==aot._digest(after,wrapped_source)
        assert after.guards_hold()
        def changed_fast(*args,**kwargs):
            return original(*args,**kwargs) + 1
        fast.__code__=changed_fast.__code__
        assert not after.guards_hold()
    finally:
        globals()['helper']=original

def test_underlying_code_still_changes_aot_origin_seal():
    first=SimpleNamespace(constants={},guards=[({},'helper',helper,helper.__code__)])
    second=SimpleNamespace(constants={},guards=[({},'helper',changed_helper,changed_helper.__code__)])
    assert aot._digest(first,'same generated source')!=aot._digest(second,'same generated source')


def test_changed_underlying_callee_code_invalidates_live_guard():
    unit,_=generated()
    old=helper.__code__
    assert unit.guards_hold()
    try:
        helper.__code__=changed_helper.__code__
        assert not unit.guards_hold()
    finally:
        helper.__code__=old
