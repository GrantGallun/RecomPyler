"""Execution mode counts measure successful calls, not prepared signatures."""
import asyncio

from recompyler import heap


def increment(value):
    return value + 1


def numbers(n):
    for i in range(n):
        yield i


async def coroutine(value):
    return value + 1


def test_counts_track_actual_successful_program():
    region = heap.lift_region(increment)
    prepared = region.program_for((1,))
    # Exercise mode accounting independently of native build mechanics, covered
    # by the fresh-process native artifact regressions.
    prepared.ahead_of_time = True
    assert (region.aot_calls, region.jit_calls) == (0, 0)
    assert region(2) == 3
    assert (region.aot_calls, region.jit_calls) == (1, 0)
    assert region(2.5) == 3.5
    assert (region.aot_calls, region.jit_calls) == (1, 1)
    assert region(2 ** 80) == 2 ** 80 + 1
    assert (region.aot_calls, region.jit_calls, region.fallback_calls) == (1, 1, 1)
    assert region.compiled_calls == region.aot_calls + region.jit_calls


def test_failed_native_attempt_is_not_counted():
    region = heap.lift_region(increment)
    program = region.program_for((1,))
    program.ahead_of_time = True
    def reject(F, I, top, st, value):
        st[0] = 1
        return 0
    program.run = reject
    assert region(1) == 2
    assert (region.aot_calls, region.jit_calls, region.compiled_calls, region.fallback_calls) == (0, 0, 0, 1)


def test_generator_and_coroutine_successes_are_counted():
    generator = heap.lift_region(numbers)
    assert generator.values((3,)) == [0, 1, 2]
    assert (generator.aot_calls, generator.jit_calls, generator.compiled_calls) == (0, 1, 1)
    assert list(generator(2)) == [0, 1]
    assert (generator.jit_calls, generator.fallback_calls) == (1, 1)
    resumed = heap.lift_region(coroutine)
    waiting = resumed(3)
    assert resumed.jit_calls == 0
    assert asyncio.run(waiting) == 4
    assert (resumed.aot_calls, resumed.jit_calls, resumed.compiled_calls) == (0, 1, 1)
