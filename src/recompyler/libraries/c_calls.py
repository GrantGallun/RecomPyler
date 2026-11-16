"""Weak guarded C-call candidates for the canonical owned CALL boundary."""
from dataclasses import dataclass


@dataclass(frozen=True)
class CFunctionCall:
    dispatcher_address:int
    context_address:int
    guard:object
    provider:object

    @classmethod
    def capture(cls,function):
        from . import _boundary_native
        guard=_boundary_native.new_guard(function)
        return cls(_boundary_native.dispatcher_address(),_boundary_native.address(guard),guard,_boundary_native)
