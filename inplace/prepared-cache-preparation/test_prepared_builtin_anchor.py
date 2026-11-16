import builtins
import importlib
import pytest

def test_preimport_poisoned_builtin_range_is_not_a_native_anchor():
    from recompyler import _prepared as pc
    real=builtins.range
    fake=type('range',(),{})
    try:
        builtins.range=fake
        importlib.reload(pc)
        builtins.range=real
        def entry(): return 1
        try: key=pc._class_key(fake,pc.References(entry))
        except pc.PreparedMiss: key=None
        assert key!={'builtin':'range'}
        assert pc._native_builtin(fake) is None
    finally:
        builtins.range=real
        importlib.reload(pc)
