"""Object call syntax uses guarded class special lookup and one receiver."""
import pytest

from recompyler import heap


class Callable:
    def __init__(self, value):
        self.value = value
        self.calls = 0

    def __call__(self, amount, *, scale=2):
        self.calls += 1
        self.value += amount * scale
        return self


class Derived(Callable):
    def __call__(self, amount, *, scale=2):
        self.calls += 1
        self.value -= amount * scale
        return self


class Inherited(Callable):
    pass


class Shadow:
    def __init__(self, value):
        self.value = value
        self.__call__ = 99

    def __call__(self, amount):
        return self.value + amount


class Holder:
    def __init__(self, target, other):
        self.target = target
        self.other = other
        self.order = []


def direct_call(target, amount):
    return target(amount, scale=3)


def subscript_call(targets, index, amount):
    return targets[index](amount, scale=3)


def get_target(holder):
    holder.order.append(1)
    return holder.target


def replace_target(holder):
    holder.order.append(2)
    holder.target = holder.other
    return 4


def captured_receiver(holder):
    return get_target(holder)(replace_target(holder))


def captured_field_receiver(holder):
    return holder.target(replace_target(holder), scale=3)


def nullable_call(holder, choose):
    target = holder.target if choose else None
    holder.order.append(1)
    return target(3)


def shadow_call(target, amount):
    return target(amount)


def replacement_call(self, amount, *, scale=2):
    self.calls += 1
    self.value = amount + scale
    return self


@pytest.fixture(params=[False, True], ids=["python-loader", "native-loader"])
def loader(request, monkeypatch):
    if request.param:
        assert heap._native is not None, "native-loader cases require the support extension"
    monkeypatch.setattr(heap, "NATIVE", request.param)


def test_local_callable_keywords_preserve_self_alias(loader):
    target = Callable(10)
    region = heap.lift_region(direct_call)
    assert region(target, 4) is target
    assert (target.value, target.calls) == (22, 1)
    assert (region.compiled_calls, region.fallback_calls) == (1, 0), region.problem


def test_subscript_callable_keywords_dispatch_by_class(loader):
    targets = [Callable(10), Derived(20)]
    region = heap.lift_region(subscript_call)
    assert region(targets, 0, 4) is targets[0]
    assert region(targets, 1, 4) is targets[1]
    assert [(target.value, target.calls) for target in targets] == [(22, 1), (8, 1)]
    assert (region.compiled_calls, region.fallback_calls) == (2, 0), region.problem


def test_callable_receiver_is_captured_once_before_arguments(loader):
    original, other = Callable(10), Callable(20)
    holder = Holder(original, other)
    region = heap.lift_region(captured_receiver)
    assert region(holder) is original
    assert holder.target is other and holder.order == [1, 2]
    assert (original.value, original.calls, other.value, other.calls) == (18, 1, 20, 0)
    assert (region.compiled_calls, region.fallback_calls) == (1, 0), region.problem


def test_callable_field_is_captured_before_arguments(loader):
    original, other = Callable(10), Callable(20)
    holder = Holder(original, other)
    region = heap.lift_region(captured_field_receiver)
    assert region(holder) is original
    assert holder.target is other and holder.order == [2]
    assert (original.value, original.calls, other.value, other.calls) == (22, 1, 20, 0)
    assert (region.compiled_calls, region.fallback_calls) == (1, 0), region.problem


def test_nullable_noncallable_exits_with_single_prior_effect(loader):
    target = Callable(10)
    holder = Holder(target, target)
    region = heap.lift_region(nullable_call)
    assert region(holder, True) is target
    with pytest.raises(TypeError):
        region(holder, False)
    assert holder.order == [1, 1]
    assert (target.value, target.calls) == (16, 1)
    assert (region.compiled_calls, region.fallback_calls) == (1, 1), region.problem


def test_instance_call_attribute_does_not_shadow_class_special_method(loader):
    target = Shadow(10)
    region = heap.lift_region(shadow_call)
    assert region(target, 4) == 14
    assert target.__call__ == 99
    assert (region.compiled_calls, region.fallback_calls) == (1, 0), region.problem


@pytest.mark.parametrize("cls", [Callable, Inherited])
def test_call_method_rebinding_invalidates_guarded_code(loader, monkeypatch, cls):
    target = cls(10)
    region = heap.lift_region(direct_call)
    assert region(target, 4) is target
    assert (region.compiled_calls, region.fallback_calls) == (1, 0), region.problem
    monkeypatch.setattr(Callable, "__call__", replacement_call)
    assert region(target, 4) is target
    assert (target.value, target.calls) == (7, 2)
    assert (region.compiled_calls, region.fallback_calls) == (1, 1)
