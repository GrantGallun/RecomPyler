"""Time whole-region compilation (recompyler.heap) on float and barnes_hut.

Uses the benchmark scripts and C timings of the baseline study in
``recompyler-coverage/c-baseline`` next to this repository. Every compiled result is
compared with CPython's, including the type and bits of every attribute afterwards.

Usage: python benchmarks/region_bench.py
"""
import contextlib
import importlib.util
import io
import json
from pathlib import Path
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
BASELINE = ROOT.parent / "recompyler-coverage" / "c-baseline"
sys.path[:0] = [str(ROOT / "src"), str(ROOT.parent / "recompyler-coverage" / "tools" / "shim")]

from recompyler.heap import lift_region  # noqa: E402
from recompyler.lift import same  # noqa: E402


def load(name):
    """A baseline benchmark as a module, with its own timing loop silenced."""
    saved = sys.argv
    sys.argv = [name, "1"]
    spec = importlib.util.spec_from_file_location(f"bench_{name}", BASELINE / "py" / f"{name}.py")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    with contextlib.redirect_stdout(io.StringIO()):
        spec.loader.exec_module(module)
    sys.argv = saved
    return module


def whole(particles, iterations, theta, time_step, width, height):
    """barnes_hut's timed region as one function: the steps, then the final energy."""
    for _ in range(iterations):
        advance_system(particles, theta, time_step, width, height)  # noqa: F821
    return calculate_system_energy(particles)  # noqa: F821


def state(particles):
    return [(type(value), value) for p in particles for point in (p.position, p.velocity, p.acceleration)
            for value in (point.x, point.y)] + [p.mass for p in particles]


def report(name, ok, python_s, region_s, c_s, note=""):
    print(f"{name}: matches CPython {ok}; C {c_s * 1e3:.2f} ms, CPython {python_s * 1e3:.1f} ms, "
          f"region {region_s * 1e3:.2f} ms = {region_s / c_s:.1f}x C, {python_s / region_s:.0f}x CPython{note}")


def main():
    c = {name: entry["c"].get("seconds") for name, entry in
         json.loads((BASELINE / "results.json").read_text(encoding="utf-8")).items()}

    floats = load("float")
    region = lift_region(floats.benchmark)
    ok = same(region(100000), floats.benchmark(100000)) and region.fallback_calls == 0

    def timed(function, repeats):
        best = float("inf")
        for _ in range(repeats):
            start = time.perf_counter()
            function()
            best = min(best, time.perf_counter() - start)
        return best

    report("float", ok, timed(lambda: floats.benchmark(100000), 3), timed(lambda: region(100000), 30), c["float"])

    barnes = load("barnes_hut")
    globals().update(advance_system=barnes.advance_system, calculate_system_energy=barnes.calculate_system_energy)
    step_args = (barnes.DEFAULT_THETA, barnes.TIME_STEP, 1000, 800)

    def galaxy():
        return barnes.create_deterministic_galaxy(barnes.DEFAULT_PARTICLES, 1000 / 2, 800 / 2)

    def run(function, repeats, steps_in_python):
        best, kept = float("inf"), None
        for _ in range(repeats):
            particles = galaxy()
            start = time.perf_counter()
            if steps_in_python:
                for _ in range(barnes.DEFAULT_ITERATIONS):
                    function(particles, *step_args)
                energy = barnes.calculate_system_energy(particles)
            else:
                energy = function(particles, barnes.DEFAULT_ITERATIONS, *step_args)
            best = min(best, time.perf_counter() - start)
            kept = energy, state(particles)
        return best, kept

    python_s, expected = run(whole, 2, False)
    whole_region = lift_region(whole)
    run(whole_region, 1, False)
    region_s, got = run(whole_region, 15, False)
    report("barnes_hut, whole region in one call", same(got, expected) and whole_region.fallback_calls == 0,
           python_s, region_s, c["barnes_hut"], f" (heap {whole_region.slots * 8 / 1e6:.0f} MB)")
    step = lift_region(barnes.advance_system)
    run(step, 1, True)
    step_s, got = run(step, 5, True)
    report("barnes_hut, one compiled call per step", same(got, expected) and step.fallback_calls == 0,
           python_s, step_s, c["barnes_hut"])


if __name__ == "__main__":
    main()
