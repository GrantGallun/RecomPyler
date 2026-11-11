import array
import json
import os
from pathlib import Path
import subprocess
import importlib.util
import runpy
import statistics
import sys
from time import perf_counter
import weakref

from .lift import Unsupported, _record_fields, _record_problem, lift, same
from .monitor import CallMonitor

MAX_ELEMENTS = 4096
# A function counts as verified only if at least this share of captured calls ran compiled.
MIN_COMPILED_SHARE = 0.9
# A compiled version is recommended only if it is at least this much faster a call.
MIN_SPEEDUP = 1.05
MAX_BATCH = 65536
# Smaller batches finish before extra threads or a GPU could start up.
PARALLEL_MINIMUM = 256
GPU_MINIMUM = 1024


# Per class: its __init__ when last checked, and its record fields (None if its
# instances cannot be copied). Finding the fields parses __init__'s source, far too
# slow to repeat for every object copied while the script runs.
_CLASS_FIELDS = weakref.WeakKeyDictionary()


def _object_fields(value):
    """lift._object_fields, with the per-class part cached."""
    cls = type(value)
    init = getattr(cls, "__init__", None)
    cached = _CLASS_FIELDS.get(cls)
    if cached is None or cached[0] is not init:
        fields = None if _record_problem(cls) is not None else _record_fields(cls)
        try:
            _CLASS_FIELDS[cls] = init, fields
        except TypeError:
            pass
    else:
        fields = cached[1]
    if fields is None:
        return None
    if hasattr(value, "__dict__") and vars(value).keys() != set(fields):
        return None
    try:
        return {name: getattr(value, name) for name in fields}
    except AttributeError:
        return None


def snapshot(value, budget=None):
    """Copy a value made of numbers, tuples, lists and array.array, so later mutation cannot change it.

    An object that appears more than once appears as one object in the copy.
    """
    budget = [MAX_ELEMENTS, {}] if budget is None else budget
    kind = type(value)
    if kind in (bool, int, float, type(None)):
        budget[0] -= 1
        if budget[0] < 0:
            raise ValueError("too large to capture")
        return value
    if id(value) in budget[1]:
        return budget[1][id(value)]
    budget[0] -= 1 + (len(value) if kind is array.array else 0)
    if budget[0] < 0:
        raise ValueError("too large to capture")
    if kind is array.array:
        copied = budget[1][id(value)] = array.array(value.typecode, value)
        return copied
    if kind is list:
        copied = budget[1][id(value)] = []
        copied.extend(snapshot(item, budget) for item in value)
        return copied
    if kind is tuple:
        return tuple(snapshot(item, budget) for item in value)
    fields = _object_fields(value)
    if fields is not None:
        # A plain object: a new instance with copies of its attributes.
        try:
            copied = budget[1][id(value)] = kind.__new__(kind)
            for name, field in fields.items():
                setattr(copied, name, snapshot(field, budget))
        except ValueError:
            raise
        except Exception:
            # The script must run as it would without the profiler.
            raise ValueError("cannot copy this object") from None
        return copied
    raise ValueError("unsupported value")


def _holds_object(value):
    if type(value) in (tuple, list):
        return any(map(_holds_object, value))
    return type(value).__module__ != "builtins" and type(value).__name__ != "array"


def fresh_copy(value):
    return snapshot(value, [float("inf"), {}])


def warm_time(function, inputs, fresh=False):
    """Seconds per call. With ``fresh``, each call gets its own copy of the captured
    arguments, made outside the timed part, so a function that changes its
    arguments always starts from the captured state."""
    def timed(repeats):
        if fresh:
            elapsed = 0.0
            for _ in range(repeats):
                for arguments, *_ in inputs:
                    copied = fresh_copy(arguments)
                    start = perf_counter()
                    function(*copied)
                    elapsed += perf_counter() - start
            return elapsed
        start = perf_counter()
        for _ in range(repeats):
            for arguments, *_ in inputs:
                function(*arguments)
        return perf_counter() - start

    repeats = min(4096, max(1, int(0.01 / max(timed(1), 1e-9))))
    return statistics.median(timed(repeats) for _ in range(3)) / (repeats * len(inputs))


def reused_time(lifted, inputs, fresh=False):
    """Seconds per compiled call when each call gets the same list objects as the
    one before, as in the profiled run, so converted copies are reused. None if
    the calls stopped running compiled, as when repeating a call that changes its
    arguments pushes a value out of range."""
    elapsed = calls = 0
    fallbacks = lifted.fallback_calls
    for arguments, *_ in inputs[:64]:
        given = fresh_copy(arguments) if fresh else arguments
        # The cache keeps a list's copy from the second time it meets the list.
        lifted(*given)
        lifted(*given)
        start = perf_counter()
        for _ in range(16):
            lifted(*given)
        elapsed += perf_counter() - start
        calls += 16
    if not calls or lifted.fallback_calls != fallbacks:
        return None
    return elapsed / calls


def batch_time(lifted, rows, backend="cpu"):
    def timed():
        start = perf_counter()
        lifted.map(rows, backend)
        return perf_counter() - start

    return statistics.median(timed() for _ in range(3)) / len(rows)


def compare_backends(lifted, rows, expected, python_s, cpu_s):
    """Time the batch on all CPU cores and on the GPU, checking each against the captured results.

    Returns speed ratios against Python for every backend that reproduced the results,
    and the reason the GPU was left out, if it was. Timings include packing the
    arguments and, for the GPU, the transfers in both directions.
    """
    ratios, note = {"cpu": python_s / cpu_s}, None
    for backend, minimum in (("parallel", PARALLEL_MINIMUM), ("gpu", GPU_MINIMUM)):
        if len(rows) < minimum:
            continue
        try:
            if not same(lifted.map(rows, backend), expected):
                note = f"{backend} results differed from the captured calls"
            elif backend == "gpu" and lifted.gpu_note:
                note = lifted.gpu_note
            else:
                ratios[backend] = python_s / batch_time(lifted, rows, backend)
        except Exception as exc:
            note = f"{backend} could not run ({type(exc).__name__})"
    return ratios, note


def test_candidate(function, inputs, calls, list_reuse=0.0, extra=()):
    """Test the usual lifter on one function, and where it does not apply, the
    whole-region lifter (recompyler.heap), which also takes the functions it calls."""
    result = test_lifted(function, inputs, calls, list_reuse, extra)
    if result["status"] != "skipped" or not inputs:
        return result
    region = test_region(function, inputs, calls, extra)
    if region["status"] == "skipped":
        result["region_reason"] = region["reason"]
        return result
    region["lift_reason"] = result["reason"]
    return region


def test_region(function, inputs, calls, extra=()):
    """test_lifted for recompyler.heap: the function and everything it calls compiled
    as one region, with objects held in the region's own heap. Never batched."""
    from .heap import lift_region

    start = perf_counter()
    try:
        region = lift_region(function)
    except Unsupported as exc:
        return {"status": "skipped", "reason": f"as a region: {exc}"}
    mutates = any(not same(arguments, after) for arguments, _, after in inputs)
    compiled = fallback = 0
    try:
        # Only the compiled path runs here, never the original: a function that is not
        # known to be free of side effects must not be called again. One that compiles
        # is, since its whole body had to fit the compiled subset.
        for arguments, expected, after in inputs:
            given = fresh_copy(arguments)
            ok, got = region.attempt(tuple(given))
            if not ok:
                fallback += 1
                continue
            compiled += 1
            if not same(got, expected):
                return {"status": "rejected", "engine": "region", "reason": "result differs from a captured call"}
            if not same(given, after):
                return {"status": "rejected", "engine": "region",
                        "reason": "arguments were changed differently from a captured call"}
        for arguments, expected, after in extra:
            given = fresh_copy(arguments)
            ok, got = region.attempt(tuple(given))
            if ok and (not same(got, expected) or not same(given, after)):
                return {"status": "rejected", "engine": "region",
                        "reason": "a call with rarer argument types gave a different result"}
        if not compiled:
            why = region.problem or (f"a check at {region.gave_up[0]} line {region.gave_up[1]} sent it back to Python"
                                     if region.gave_up else "it handed every captured call back to Python")
            return {"status": "skipped", "reason": f"as a region: {why}"}
        if compiled < MIN_COMPILED_SHARE * len(inputs):
            return {"status": "skipped", "reason": f"as a region, only {compiled} of {len(inputs)} captured calls "
                                                   "ran compiled"}
        first_pass = perf_counter() - start
        python_s = warm_time(function, inputs, fresh=mutates)
        compiled_s = warm_time(region, inputs, fresh=mutates)
        warm_start = warm_start_time(function, inputs, lift_region)
    except Exception as exc:
        return {"status": "rejected", "engine": "region",
                "reason": f"a captured call raised {type(exc).__name__} when replayed"}
    advice = recommend(calls, python_s, compiled_s, first_pass, warm_start)
    cached = all(getattr(program, "cached", False) for program in region.programs.values() if program is not None)
    return {"status": "verified", "engine": "region", "_lifted": None, "_rows": None,
            "samples": len(inputs), "compiled_samples": compiled, "fallback_samples": fallback,
            "rare_samples_checked": len(extra), **advice, "first_pass_s": first_pass, "warm_start_s": warm_start,
            "python_us_per_call": python_s * 1e6, "compiled_cpu_us_per_call": compiled_s * 1e6,
            "speedup": python_s / compiled_s, "changes_arguments": mutates, "disk_cached": cached,
            "batch_backends": {}, "backend_note": "not batched: compiled as one region"}


def test_lifted(function, inputs, calls, list_reuse=0.0, extra=()):
    """Lift one function and compare it with what the script itself computed.

    A function that lifts is pure, so calling it again here cannot repeat a side effect.
    ``list_reuse`` is the share of the run's calls that passed the same list objects
    as the call before; the compiled time per call is weighted between reusing
    converted copies and converting afresh by that share. ``extra`` holds captured
    calls with argument types the uniform sample lacks: they are checked for
    correctness only, so they do not skew the compiled share or the timings.
    """
    start = perf_counter()
    try:
        lifted = lift(function)
    except Unsupported as exc:
        return {"status": "skipped", "reason": f"outside the supported subset: {exc}"}
    if not inputs:
        return {"status": "skipped", "reason": "no calls with numeric arguments and results were captured"}
    rows = [arguments for arguments, *_ in inputs]
    repeats = -(-min(max(calls, len(rows)), MAX_BATCH) // len(rows))
    # A function that changes its arguments is checked on what it leaves in them too,
    # and is not batched: its calls are not independent of each other.
    mutates = any(not same(arguments, after) for arguments, _, after in inputs)
    # Objects travel one call at a time, so batches of them would only replay Python.
    objects = any(_holds_object(arguments) for arguments, *_ in inputs)
    try:
        for arguments, expected, after in inputs:
            given = fresh_copy(arguments)
            if not same(lifted(*given), expected):
                return {"status": "rejected", "reason": "result differs from a captured call"}
            if not same(given, after):
                return {"status": "rejected", "reason": "arguments were changed differently from a captured call"}
        compiled, fallback = lifted.compiled_calls, lifted.fallback_calls
        for arguments, expected, after in extra:
            given = fresh_copy(arguments)
            if not same(lifted(*given), expected) or not same(given, after):
                return {"status": "rejected", "reason": "a call with rarer argument types gave a different result"}
        if not compiled:
            return {"status": "skipped", "reason": "the compiled version did not apply to the captured calls"}
        if compiled < MIN_COMPILED_SHARE * len(inputs):
            return {"status": "skipped", "samples": len(inputs), "compiled_samples": compiled,
                    "reason": f"only {compiled} of {len(inputs)} captured calls ran compiled; the rest fell back to Python"}
        first_pass = perf_counter() - start
        python_s = warm_time(function, inputs, fresh=mutates)
        # Time compiled calls without the list cache: a small sample would otherwise
        # reuse copies whether or not the run did.
        cache = lifted._list_cache
        enabled, cache.enabled = cache.enabled, False
        try:
            fresh_s = warm_time(lifted, inputs, fresh=mutates)
        finally:
            cache.enabled = enabled
        reused_s = reused_time(lifted, inputs, fresh=mutates) if list_reuse and enabled else None
        cache.entries.clear()
        compiled_s = fresh_s if reused_s is None else list_reuse * reused_s + (1 - list_reuse) * fresh_s
        reason = "changes its arguments" if mutates else "takes objects"
        ratios, note, batch, batch_s = {}, f"not batched: the function {reason}", [], None
        if not (mutates or objects):
            batch, batch_expected = rows * repeats, [expected for _, expected, _ in inputs] * repeats
            if not same(lifted.map(batch), batch_expected):
                return {"status": "rejected", "reason": "batched result differs from a captured call"}
            batch_s = batch_time(lifted, batch)
            ratios, note = compare_backends(lifted, batch, batch_expected, python_s, batch_s)
        warm_start = warm_start_time(function, inputs)
    except Exception as exc:
        return {"status": "rejected", "reason": f"a captured call raised {type(exc).__name__} when replayed"}
    advice = recommend(calls, python_s, compiled_s, first_pass, warm_start)
    # "_lifted" and "_rows" stay in this process: an ahead-of-time build needs them.
    return {"status": "verified", "_lifted": lifted, "_rows": rows,
            "samples": len(inputs), "compiled_samples": compiled, "fallback_samples": fallback,
            "rare_samples_checked": len(extra),
            **advice, "first_pass_s": first_pass, "warm_start_s": warm_start, "python_us_per_call": python_s * 1e6,
            "compiled_cpu_us_per_call": compiled_s * 1e6, "speedup": python_s / compiled_s,
            "list_reuse": list_reuse, "compiled_fresh_us_per_call": fresh_s * 1e6,
            "compiled_reused_us_per_call": reused_s and reused_s * 1e6,
            "changes_arguments": mutates, "batch_size": len(batch),
            "batch_us_per_call": batch_s and batch_s * 1e6, "batch_speedup": batch_s and python_s / batch_s,
            "batch_backends": ratios, "best_backend": max(ratios, key=ratios.get) if ratios else None,
            "backend_note": note}


def warm_start_time(function, inputs, lifter=lift):
    """Seconds to lift ``function`` again and make its first calls, with the compiled
    code now in the disk cache: what a later run of the script pays to start."""
    start = perf_counter()
    again = lifter(function)
    for arguments, *_ in inputs[:4]:
        again(*fresh_copy(arguments))
    return perf_counter() - start


def recommend(calls, python_s, compiled_s, first_pass_s, warm_start_s):
    """Whether swapping in the compiled version pays off for a run like the profiled one.

    It must be at least MIN_SPEEDUP faster a call, and the time it saves over the
    run's calls must exceed its start-up cost once the compiled code is cached.
    Batch speedups are not counted: they need the caller rewritten to batch.
    """
    saved = calls * (python_s - compiled_s)
    net_cold, net_warm = saved - first_pass_s, saved - warm_start_s
    ratio = python_s / compiled_s
    if ratio < MIN_SPEEDUP:
        verdict, why = False, f"one call at a time it is {ratio:.2f}x Python"
    elif net_warm <= 0:
        verdict, why = False, (f"it would save {saved * 1000:.1f} ms over {calls:,} calls, less than the "
                               f"{warm_start_s * 1000:.0f} ms it takes to start")
    elif net_cold > 0:
        verdict, why = True, f"saves {net_cold * 1000:.0f} ms on the first run, compile time included"
    else:
        verdict, why = True, f"saves {net_warm * 1000:.0f} ms a run once the compiled code is cached"
    return {"recommended": verdict, "recommendation": why, "net_s_first_run": net_cold, "net_s_cached": net_warm}


def profile_script(script, script_args, limit, sample_limit, try_compile, include=()):
    """Run ``script`` once, timing the functions in it and in ``include`` (more files
    or folders), and test compiled versions of the hottest ones."""
    can_compile = try_compile and importlib.util.find_spec("numba") is not None
    monitor = CallMonitor([script, *include], sample_limit if can_compile else 0, snapshot)
    original_argv, original_path = sys.argv, sys.path[:]
    try:
        sys.argv = [str(script), *script_args]
        sys.path.insert(0, str(script.parent))
        with monitor:
            try:
                runpy.run_path(str(script), run_name="__main__")
            except SystemExit as exc:
                if exc.code is not None and exc.code != 0:
                    raise
    finally:
        sys.argv = original_argv
        sys.path[:] = original_path

    rows = monitor.rows()
    rows.sort(key=lambda item: item["self_s"], reverse=True)
    rows, samplers = rows[:limit], []
    for row in rows:
        key = row.pop("_key")
        if row["file"] == str(script):
            del row["file"]
        sampler = monitor.samplers.get(key)
        samplers.append(sampler)
        if sampler is not None:
            row["signatures"] = len(sampler.signatures)
        if not try_compile:
            candidate = {"status": "skipped", "reason": "profiling only"}
        elif not can_compile:
            candidate = {"status": "skipped", "reason": "install the compile extra to try CPU compilation"}
        elif sampler is None:
            candidate = {"status": "skipped", "reason": f"not captured: the function {monitor.skipped.get(key)}"}
        else:
            candidate = test_candidate(sampler.function, sampler.samples, row["calls"], sampler.list_reuse,
                                       sampler.extra())
        row["candidate"] = candidate
    # total_s is the whole run with the profiler's own time taken out.
    report = {"script": str(script), "profiler": monitor.backend, "total_s": monitor.total_s,
              "script_self_s": sum(row["self_s"] for row in monitor.rows()), "functions": rows}
    chosen = [(row, sampler) for row, sampler in zip(rows, samplers) if row["candidate"].get("recommended")]
    section = None
    # Regions are not built ahead of time; they run through Numba's JIT and disk cache.
    built = [(row, sampler) for row, sampler in chosen if row["candidate"].get("engine") != "region"]
    if built:
        section = build_ahead_of_time([((row["function"], row["line"]), sampler.function,
                                         row["candidate"]["_lifted"], row["candidate"]["_rows"])
                                        for row, sampler in built])
    for row in rows:
        row["candidate"].pop("_lifted", None)
        row["candidate"].pop("_rows", None)
    if chosen:
        report["plan"] = run_plan([row["candidate"] for row, _ in chosen], section)
    return report


def build_ahead_of_time(entries):
    """Compile the recommended functions into an extension module in the cache
    directory, so ``recompyler run`` can skip loading Numba. None if it cannot."""
    from .lift import _cache_dir

    folder = _cache_dir()
    if folder is None:
        return None
    try:
        from .aot import build

        return build(entries, folder)
    except Exception as exc:
        # No C compiler, or code that pycc cannot export: run mode uses the JIT.
        print(f"recompyler: ahead-of-time build skipped ({type(exc).__name__}: {str(exc)[:120]})", file=sys.stderr)
        return None


def process_startup(ahead_of_time=False):
    """Seconds a fresh process spends loading the compiler before any compiled call.

    With ``ahead_of_time``, what loading the lifter and NumPy costs when the compiled
    code comes from a built extension module and Numba is never imported. Measured
    once in a separate process and kept in the cache directory.
    """
    from .lift import _cache_dir, _runtime_key

    folder = _cache_dir()
    kind = "startup-aot" if ahead_of_time else "startup"
    saved = folder and folder / f"{kind}-{_runtime_key()[:24]}.json"
    if saved:
        try:
            return float(json.loads(saved.read_text(encoding="utf-8")))
        except (OSError, ValueError):
            pass
    # Load the compiler and make one compiled call from the disk cache: the first
    # compiled call in a process also sets up LLVM and Numba's type system.
    sample = folder / "startup_probe.py" if folder else None
    if sample and not sample.exists():
        sample.write_text("def probe(n):\n    total = 0.0\n    for i in range(n):\n        total += i * 0.5\n"
                          "    return total\n", encoding="utf-8")
    if ahead_of_time:
        probe = ("import time; start = time.perf_counter(); import numpy; import recompyler.aot; "
                 "print(time.perf_counter() - start)")
    else:
        probe = ("import sys, time; start = time.perf_counter(); from recompyler.lift import _runtime, _math_agrees, lift; "
             "_runtime(); _math_agrees(); "
             + (f"sys.path.insert(0, {str(folder)!r}); import startup_probe; lift(startup_probe.probe)(10); "
                if sample else "")
             + "print(time.perf_counter() - start)")
    environment = dict(os.environ, PYTHONPATH=os.pathsep.join(filter(None, (
        str(Path(__file__).resolve().parents[1]), os.environ.get("PYTHONPATH")))))
    try:
        # The first run fills the self-test cache; the second is what a later run pays.
        for _ in range(2):
            done = subprocess.run([sys.executable, "-c", probe], capture_output=True, text=True, timeout=300,
                                  env=environment)
        seconds = float(done.stdout.strip().splitlines()[-1])
    except (OSError, ValueError, IndexError, subprocess.SubprocessError):
        return 1.0
    if saved:
        try:
            saved.write_text(json.dumps(seconds), encoding="utf-8")
        except OSError:
            pass
    return seconds


def run_plan(chosen, section=None):
    """Whether ``recompyler run`` pays off for the whole script: the recommended
    functions must together save more than a process spends loading the compiler.

    When every recommended function went into an ahead-of-time module, a run never
    loads Numba, so its much smaller start-up is what counts.
    """
    covered = section is not None and len(section["functions"]) == len(chosen)
    startup = process_startup(ahead_of_time=covered)
    saving = sum(candidate["net_s_cached"] for candidate in chosen)
    plan = {"startup_s": startup, "saving_s": saving, "worth_running": saving > startup}
    if section is not None:
        plan["aot"] = section
    return plan


def print_profile(report):
    print(f"\nRecomPyler profile — {report['script']}", file=sys.stderr)
    for row in report["functions"]:
        print(f"{row['function']}:{row['line']}  {row['calls']:,} calls  {row['self_s'] * 1000:.3f} ms self",
              file=sys.stderr)
        candidate = row["candidate"]
        if candidate["status"] == "verified":
            what = ("Compiled as one region with the functions it calls,"
                    if candidate.get("engine") == "region" else "Compiled CPU version")
            print(f"  {what} matched {candidate['samples']} captured calls exactly "
                  f"({candidate['fallback_samples']} needed the Python fallback).", file=sys.stderr)
            batches = (f"Batches of {candidate['batch_size']:,}: "
                       + ", ".join(f"{backend} {ratio:.2f}x" for backend, ratio in candidate["batch_backends"].items())
                       + f" (fastest: {candidate['best_backend']})." if candidate["batch_backends"] else "")
            print(f"  One call at a time: {candidate['speedup']:.2f}x. {batches}".rstrip(), file=sys.stderr)
            if candidate["backend_note"]:
                print(f"  Note: {candidate['backend_note']}.", file=sys.stderr)
            verdict = "Recommended" if candidate["recommended"] else "Not recommended"
            print(f"  {verdict}: {candidate['recommendation']}.", file=sys.stderr)
        else:
            print(f"  {candidate['status']}: {candidate['reason']}", file=sys.stderr)
    plan = report.get("plan")
    if plan:
        verdict = "worth it" if plan["worth_running"] else "not worth it"
        print(f"\nRunning with recompyler run: {verdict}. The recommended functions save about "
              f"{plan['saving_s'] * 1000:.0f} ms a run; loading the compiler takes about "
              f"{plan['startup_s'] * 1000:.0f} ms.", file=sys.stderr)
