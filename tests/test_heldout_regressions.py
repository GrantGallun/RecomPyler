"""Regression cases reduced from the frozen held-out profile crashes.

Covers class-header scope and recursive generator inference/discovery.
"""
import ast

from recompyler.flow import analyse, function_locals
from recompyler.heap import lift_region
from recompyler.monitor import Yielded
from recompyler import profiler


CLASS_SCOPE = """
def outer(flag, Base, Meta, decorate):
    @(decorator_seen := decorate)
    class Local((base_seen := Base), metaclass=(meta_seen := Meta)):
        class_body = 1
        def method(self, parameter):
            method_local = parameter
            return method_local
    return Local, decorator_seen, base_seen, meta_seen
"""


def test_class_definition_locals_include_only_surrounding_evaluation():
    node = ast.parse(CLASS_SCOPE).body[0]
    assert function_locals(node) == {
        "flag", "Base", "Meta", "decorate", "Local",
        "decorator_seen", "base_seen", "meta_seen",
    }
    assert analyse(node).names == set()


def test_conditional_class_definition_and_walrus_locals_can_be_unbound():
    source = """
def outer(flag, Base, Meta, decorate):
    if flag:
        @(decorator_seen := decorate)
        class Local((base_seen := Base), metaclass=(meta_seen := Meta)):
            class_body = 1
    return Local, decorator_seen, base_seen, meta_seen
"""
    assert analyse(ast.parse(source).body[0]).names == {
        "Local", "decorator_seen", "base_seen", "meta_seen",
    }


def test_class_base_reads_are_checked_in_surrounding_scope():
    node = ast.parse("def outer():\n class Local(Base): pass\n Base = object\n return Local\n").body[0]
    assert analyse(node).names == {"Base"}


def defines_local_class(number):
    class Local:
        def __init__(self):
            self.value = 1
    return number


def test_candidate_declines_local_class_without_crashing():
    result = profiler.test_candidate(defines_local_class, [((2,), 2, (2,))], 1)
    assert result["status"] == "skipped"
    assert "reason" in result


class Tree:
    def __init__(self, left, value, right):
        self.left = left
        self.value = value
        self.right = right

    def __iter__(self):
        if self.left:
            yield from self.left
        yield self.value
        if self.right:
            yield from self.right


def previous(number):
    return number - 1


def recursive_deferred(number):
    if number:
        yield from recursive_deferred(previous(number))
        yield number


def unsupported_recursive_consumer(number):
    return sum(recursive_deferred(number))


def test_recursive_generator_profiler_discovery_seeds_output(monkeypatch):
    monkeypatch.setattr(profiler, "warm_time", lambda *a, **k: 1.0)
    monkeypatch.setattr(profiler, "warm_start_time", lambda *a, **k: 0.0)
    tree = Tree(Tree(None, 1, None), 2, Tree(None, 3, None))
    sample = ((tree,), Yielded([1, 2, 3], True, False), (tree,))
    result = profiler.test_region(Tree.__iter__, [sample], 1)
    assert result["status"] == "verified", result


def test_recursive_delegation_waits_for_helper_result_inference():
    assert lift_region(recursive_deferred).attempt((3,)) == (True, [1, 2, 3])


def test_unsupported_recursive_consumer_falls_back_cleanly():
    region = lift_region(unsupported_recursive_consumer)
    assert region(3) == 6
    assert region.fallback_calls == 1
    assert region.compiled_calls == 0


def test_class_type_parameters_do_not_bind_surrounding_locals():
    node = ast.parse("def outer():\n class Generic[T]:\n  field: T\n return Generic\n").body[0]
    assert function_locals(node) == {"Generic"}
    assert analyse(node).names == set()
