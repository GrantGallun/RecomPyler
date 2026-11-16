"""Cell opcodes use interpreter exception classes even if builtins are rebound."""
import builtins
import pytest
from recompyler.managed import lift_managed


def missing_free(flag):
    def read():return value
    if flag:value=1
    return read()


def missing_cell(flag):
    def read():return value
    if flag:value=1
    return value


@pytest.mark.parametrize('function,name',[(missing_free,'NameError'),(missing_cell,'UnboundLocalError')])
def test_empty_cell_uses_original_interpreter_exception_class(function,name):
    fast=lift_managed(function)
    def outcome(callable_):
        try:callable_(False)
        except BaseException as error:return(type(error),str(error),error.name)
    expected=outcome(function);original=getattr(builtins,name)
    class Replacement(original):pass
    try:
        setattr(builtins,name,Replacement)
        actual=outcome(fast)
    finally:setattr(builtins,name,original)
    assert actual==expected
    assert fast.compiled_calls==1 and fast.fallback_calls==0
