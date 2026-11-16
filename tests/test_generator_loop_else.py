"""Generator loop-else preserves exhaustion and consumer early-exit semantics."""
import pytest
from recompyler.heap import lift_region


def for_else(n, stop):
    for i in range(n):
        yield i
        if i == stop:
            break
    else:
        yield 100
    yield 200


def while_else(n, stop):
    i = 0
    while i < n:
        yield i
        if i == stop:
            break
        i += 1
    else:
        yield 100
    yield 200


def return_else(n):
    while True:
        for i in range(n):
            yield i
        else:
            return
        yield 999


def collect_for(n, stop):
    return list(for_else(n, stop))


def collect_while(n, stop):
    return list(while_else(n, stop))


def collect_return(n):
    return list(return_else(n))


def stop_consumer(n):
    total = 0
    for value in for_else(n, -1):
        total += value
        if value == 1:
            break
    return total


def continue_consumer(n):
    total = 0
    for value in for_else(n, -1):
        if value == 1:
            continue
        total += value
    return total


@pytest.mark.parametrize('fn', [collect_for, collect_while])
@pytest.mark.parametrize('n,stop,want', [(0,-1,[100,200]), (3,-1,[0,1,2,100,200]), (3,1,[0,1,200])])
def test_generator_loop_else_exhaustion_and_own_break(fn, n, stop, want):
    compiled = lift_region(fn)
    assert compiled(n, stop) == want
    assert compiled.compiled_calls == 1, compiled.problem


@pytest.mark.parametrize('n,want', [(0,[]), (3,[0,1,2])])
def test_return_in_generator_else_leaves_outer_loop(n, want):
    compiled = lift_region(collect_return)
    assert compiled(n) == want
    assert compiled.compiled_calls == 1, compiled.problem


@pytest.mark.parametrize('n,want', [(0,300), (3,1)])
def test_consumer_break_skips_generator_else_and_tail(n, want):
    compiled = lift_region(stop_consumer)
    assert compiled(n) == want
    assert compiled.compiled_calls == 1, compiled.problem


def test_consumer_continue_preserves_generator_exhaustion():
    compiled = lift_region(continue_consumer)
    assert compiled(3) == 302
    assert compiled.compiled_calls == 1, compiled.problem

_g1_stop_ = 37


def producer_with_else(n):
    for i in range(n):
        yield i
    else:
        yield 100


def consumer_with_control_names(n):
    _g1_stop = 5
    total = 0
    for value in producer_with_else(n):
        total += value
    return total + _g1_stop_


def test_generated_stop_flag_never_shadows_consumer_global():
    compiled = lift_region(consumer_with_control_names)
    assert compiled(3) == 140
    assert compiled.compiled_calls == 1, compiled.problem
