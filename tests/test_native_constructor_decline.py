"""Native initializer metadata must decline before Python-body/default readers."""
import tempfile

import pytest

from recompyler.lift import Unsupported, lift


class Empty:
    pass


class EmptySlots:
    __slots__ = ()


class NativeSetattrInitializer:
    """This native initializer is valid Python when name is an existing slot."""
    __slots__ = ("value",)
    __init__ = object.__setattr__


class PythonInitializer:
    __slots__ = ("value",)

    def __init__(self, value):
        self.value = value


def ordinary_empty_factory():
    made = Empty()
    return 1


def slotted_empty_factory():
    made = EmptySlots()
    return 1


def native_initializer_factory(name, value):
    made = NativeSetattrInitializer(name, value)
    return made.value


def native_initializer_column_fill(n, name, value):
    made = [None] * n
    for index in range(n):
        made[index] = NativeSetattrInitializer(name, value)
    return made[0].value


def python_initializer_factory(value):
    made = PythonInitializer(value)
    return made.value


@pytest.mark.parametrize("factory", [ordinary_empty_factory, slotted_empty_factory])
def test_inherited_object_initializer_declines_before_python_body_rewrite(factory):
    # The old synthetic empty AST reaches define(object.__init__) and crashes
    # reading wrapper_descriptor.__globals__. No broad exception catcher is mocked.
    with pytest.raises(Unsupported, match="native constructor has no Python body"):
        lift(factory)


def test_real_tempfile_name_sequence_constructor_declines_without_running_workload():
    # _get_default_tempdir's first assignment constructs _RandomNameSequence.
    # Its inherited object.__init__ follows the real Pathlib-profile crash path.
    # Lifting inspects source only; this test never calls the filesystem routine.
    with pytest.raises(Unsupported, match="native constructor has no Python body"):
        lift(tempfile._get_default_tempdir)


def test_native_initializer_declines_before_ordinary_call_default_metadata():
    # Valid Python construction, but a native descriptor has no __code__/defaults.
    assert native_initializer_factory("value", 7) == 7
    with pytest.raises(Unsupported, match="native constructor has no Python body"):
        lift(native_initializer_factory)


def test_native_initializer_column_fill_declines_before_default_metadata():
    assert native_initializer_column_fill(2, "value", 7) == 7
    with pytest.raises(Unsupported, match="native constructor has no Python body"):
        lift(native_initializer_column_fill)


def test_python_assignment_initializer_remains_liftable():
    assert python_initializer_factory(7) == 7
    lifted = lift(python_initializer_factory)
    assert lifted.original is python_initializer_factory