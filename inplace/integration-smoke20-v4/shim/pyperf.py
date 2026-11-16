"""Stand-in for pyperf: run each benchmark body in this process so a profiler can see it."""
import argparse
import asyncio
import sys
import time

perf_counter = time.perf_counter
LOOPS = 20


def python_implementation():
    return sys.implementation.name


def python_has_jit():
    return False


class Runner:
    def __init__(self, *args, **kwargs):
        self.metadata = {}
        self.argparser = argparse.ArgumentParser()
        self.args = None

    def parse_args(self, args=None):
        self.args, _ = self.argparser.parse_known_args(args)
        return self.args

    def bench_func(self, name, func, *args, **kwargs):
        for _ in range(LOOPS):
            func(*args)

    def bench_time_func(self, name, func, *args, **kwargs):
        func(LOOPS, *args)

    def bench_async_func(self, name, func, *args, **kwargs):
        for _ in range(LOOPS):
            asyncio.run(func(*args))

    def bench_command(self, *args, **kwargs):
        pass

    def timeit(self, *args, **kwargs):
        pass
