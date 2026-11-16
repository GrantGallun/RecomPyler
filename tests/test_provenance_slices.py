"""Canonical bindings for Python's immutable slice code constants."""
import ast
from recompyler import provenance


def constant_slice(value):
    return value[1:4:2]


def test_slice_code_constant_has_exact_original_binding():
    binding = provenance.bind_source(constant_slice)
    node = binding.node.body[0].value.slice
    facts = binding.constants[provenance.site(node)]
    origin, = facts.origins
    original = next(value for value in constant_slice.__code__.co_consts if type(value) is slice)
    assert origin.kind == 'constant'
    assert provenance.resolve_origin(constant_slice, origin) is original
