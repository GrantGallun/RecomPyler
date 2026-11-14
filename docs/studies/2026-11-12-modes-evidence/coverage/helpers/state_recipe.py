"""Helpers for the separately labeled Chaos full-state canary.

No kernel executes on import. The measurements worker owns execution and records.
"""
import argparse
import importlib.util
import inspect
from pathlib import Path
import struct
import sys
import textwrap
import types


FROZEN_SOURCE = Path(r"D:/Code/Datathon/recompyler-coverage/corpus/pyperformance-1.14.0/benchmarks/bm_chaos/run_benchmark.py")


def load_workload():
    # Import definitions only. main is invoked with the collector below, never
    # with a benchmark runner, and does no image kernel work.
    if "pyperf" not in sys.modules:
        sys.modules["pyperf"] = types.ModuleType("pyperf")
    spec = importlib.util.spec_from_file_location("wave10_frozen_chaos", FROZEN_SOURCE)
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def original_entry(module):
    class Collector:
        def __init__(self):
            self.metadata, self.found = {}, None

        def bench_func(self, name, bound, *arguments):
            self.found = name, bound, arguments

    collector = Collector()
    args = argparse.Namespace(thickness=module.DEFAULT_THICKNESS,
                              width=module.DEFAULT_WIDTH, height=module.DEFAULT_HEIGHT,
                              iterations=module.DEFAULT_ITERATIONS,
                              rng_seed=module.DEFAULT_RNG_SEED, filename=None)
    module.main(collector, args)
    name, bound, arguments = collector.found
    assert name == "chaos"
    assert bound.__func__ is module.Chaosgame.create_image_chaos
    return bound.__func__, (bound.__self__, *arguments)


def image_observation_entry(module, destination):
    """Same body with a final `return im`, saved so source discovery is real.

    This changes the digest and output contract. Its successful native image
    result is a derived state canary, not default held-out deployment evidence.
    """
    source = textwrap.dedent(inspect.getsource(module.Chaosgame.create_image_chaos))
    source += "\n    return im\n"
    destination = Path(destination)
    encoded = source.encode("utf-8")
    if destination.exists():
        assert destination.read_bytes() == encoded, "saved derived canary differs from the original body plus image return"
    else:
        destination.write_bytes(encoded)
    namespace = dict(vars(module))
    exec(compile(source, str(destination.resolve()), "exec"), namespace)
    return namespace["create_image_chaos"], source


def freeze_graph(value):
    """Exact numbers/types plus traversal-relative aliases; independent of heap.same."""
    seen = {}

    def visit(item):
        kind = type(item)
        if kind is float:
            return ["float", struct.pack("<d", item).hex()]
        if kind in (bool, int, str, type(None)):
            return [kind.__name__, item]
        if id(item) in seen:
            return ["ref", seen[id(item)]]
        number = seen[id(item)] = len(seen)
        if kind in (list, tuple):
            return [kind.__name__, number, [visit(child) for child in item]]
        if kind is dict:
            return ["dict", number, [[visit(key), visit(child)] for key, child in item.items()]]
        return [kind.__module__ + "." + kind.__qualname__, number,
                [[name, visit(child)] for name, child in sorted(vars(item).items())]]

    return visit(value)


# Execution recipe (in an isolated fresh child after CPU authorization):
# 1. load_workload(); original_entry() returns exact original game/arguments.
# 2. Save random.getstate(), freeze_graph(arguments), and original alias ids.
# 3. Run Python original once; save None/final random state/exact graph.
# 4. Restore the original pre-state on a separate identically constructed game,
#    random.setstate(before), then invoke the actual AOT region with the same args.
# 5. Require exact graph + RNG equality, original alias identities and
#    aot_calls=1, jit_calls=0, fallback_calls=0. Original image is unobservable.
# 6. Separately repeat with image_observation_entry() and compare every returned
#    integer pixel and row type/shape/alias. Report its changed digest separately.
