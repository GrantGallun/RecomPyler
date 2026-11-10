import ast
import copy
import cProfile
import math
import pstats
import runpy
import statistics
import sys
from time import perf_counter
import tokenize


BUILTINS = {fn.__name__: fn for fn in (abs, min, max, range, int, float)}
NODES = (ast.FunctionDef, ast.arguments, ast.arg, ast.Return, ast.Expr, ast.Assign, ast.AnnAssign,
         ast.AugAssign, ast.For, ast.If, ast.Break, ast.Continue, ast.Pass, ast.IfExp, ast.Compare,
         ast.BoolOp, ast.UnaryOp, ast.BinOp, ast.Name, ast.Load, ast.Store, ast.Call, ast.Constant,
         ast.operator, ast.unaryop, ast.cmpop, ast.boolop)


def numeric(value):
    return (type(value) is bool or (type(value) is int and -(2**63) <= value < 2**63)
            or (type(value) is float and math.isfinite(value)))


def numeric_functions(script):
    with tokenize.open(script) as stream:
        tree = ast.parse(stream.read(), filename=str(script))
    functions = {}
    for source in tree.body:
        if not isinstance(source, ast.FunctionDef):
            continue
        node = copy.deepcopy(source)
        args = node.args.posonlyargs + node.args.args
        if node.decorator_list or node.args.vararg or node.args.kwarg or node.args.kwonlyargs or node.args.defaults:
            continue
        node.returns = None
        for arg in args:
            arg.annotation = None
        # A copied function can use local scalar variables and a few known builtins.
        # Dynamic calls, attributes, imports, globals, and mutation are excluded.
        walk = list(ast.walk(node))
        names = {arg.arg for arg in args}
        names.update(item.id for item in walk if isinstance(item, ast.Name) and isinstance(item.ctx, ast.Store))
        if any(not isinstance(item, NODES) for item in walk):
            continue
        if any(isinstance(item, ast.Name) and item.id not in names and item.id not in BUILTINS for item in walk):
            continue
        if any(isinstance(item, ast.Call) and (not isinstance(item.func, ast.Name)
               or item.func.id not in BUILTINS or item.func.id in names) for item in walk):
            continue
        builtin_names = {item.id for item in walk if isinstance(item, ast.Name) and item.id not in names}
        functions[(node.name, node.lineno)] = (node, tuple(arg.arg for arg in args), builtin_names)
    return functions


def capture_calls(filename, functions, max_samples):
    samples = {key: [] for key in functions}

    def trace(frame, event, arg):
        if event != "call" or frame.f_code.co_filename != filename:
            return None
        key = frame.f_code.co_name, frame.f_code.co_firstlineno
        if key not in functions or len(samples[key]) >= max_samples:
            return None
        _, parameters, builtin_names = functions[key]
        if any(frame.f_globals.get(name, frame.f_builtins.get(name)) is not BUILTINS[name]
               for name in builtin_names):
            return None
        inputs = tuple(frame.f_locals[name] for name in parameters)
        if not all(numeric(value) for value in inputs):
            return None
        frame.f_trace_lines = False
        failed = False

        def capture_return(_frame, event, result):
            nonlocal failed
            if event == "exception":
                failed = True
            elif event == "return" and not failed and numeric(result):
                samples[key].append((inputs, result))
            return capture_return

        return capture_return

    return samples, trace


def same_result(actual, expected):
    if type(actual) is not type(expected):
        return False
    if type(expected) is float:
        return math.isclose(actual, expected, rel_tol=1e-12, abs_tol=1e-12)
    return actual == expected


def warm_time(function, inputs):
    def timed(repeats):
        start = perf_counter()
        for _ in range(repeats):
            for arguments, _ in inputs:
                function(*arguments)
        return perf_counter() - start

    repeats = min(4096, max(1, int(0.01 / max(timed(1), 1e-9))))
    return statistics.median(timed(repeats) for _ in range(3)) / (repeats * len(inputs))


def test_candidate(node, inputs, njit, numba_error):
    if not inputs:
        return {"status": "skipped", "reason": "no compatible numeric calls captured"}
    scope = {"__builtins__": BUILTINS}
    isolated = ast.Module(body=[node], type_ignores=[])
    exec(compile(ast.fix_missing_locations(isolated), "<recompyler-candidate>", "exec"), scope)
    original = scope[node.name]
    compiled = njit(original)
    try:
        start = perf_counter()
        for args, expected in inputs:
            if not same_result(original(*args), expected) or not same_result(compiled(*args), expected):
                return {"status": "rejected", "reason": "result differs from a captured call"}
        first_pass = perf_counter() - start
        python_s = warm_time(original, inputs)
        compiled_s = warm_time(compiled, inputs)
    except (numba_error, ArithmeticError, ValueError, TypeError, NameError) as exc:
        return {"status": "skipped", "reason": f"candidate could not be tested ({type(exc).__name__})"}
    return {"status": "verified", "samples": len(inputs), "first_pass_s": first_pass,
            "python_us_per_call": python_s * 1e6, "compiled_cpu_us_per_call": compiled_s * 1e6,
            "speedup": python_s / compiled_s}


def profile_script(script, script_args, limit, sample_limit, try_compile):
    compiler = None
    if try_compile:
        try:
            from numba import njit
            from numba.core.errors import NumbaError
        except ImportError:
            pass
        else:
            compiler = njit, NumbaError
    functions = numeric_functions(script) if compiler else {}
    samples, trace = capture_calls(str(script), functions, sample_limit)
    original_argv, original_path, original_trace = sys.argv, sys.path[:], sys.gettrace()
    profiler = cProfile.Profile()
    try:
        sys.argv = [str(script), *script_args]
        sys.path.insert(0, str(script.parent))
        if functions:
            sys.settrace(trace)
        try:
            profiler.runcall(runpy.run_path, str(script), run_name="__main__")
        except SystemExit as exc:
            if exc.code is not None and exc.code != 0:
                raise
    finally:
        sys.settrace(original_trace)
        sys.argv = original_argv
        sys.path[:] = original_path

    rows = [{"function": name, "line": line, "calls": calls, "self_s": own, "cumulative_s": cumulative}
            for (file, line, name), (_, calls, own, cumulative, _) in pstats.Stats(profiler).stats.items()
            if file == str(script)]
    rows.sort(key=lambda item: item["self_s"], reverse=True)
    for row in rows[:limit]:
        key = row["function"], row["line"]
        if not try_compile:
            candidate = {"status": "skipped", "reason": "profiling only"}
        elif compiler is None:
            candidate = {"status": "skipped", "reason": "install the compile extra to try CPU compilation"}
        elif key not in functions:
            candidate = {"status": "skipped", "reason": "outside the supported top-level numeric subset"}
        else:
            candidate = test_candidate(functions[key][0], samples[key], *compiler)
        row["candidate"] = candidate
    return {"script": str(script), "functions": rows[:limit]}


def print_profile(report):
    print(f"\nRecomPyler profile — {report['script']}", file=sys.stderr)
    for row in report["functions"]:
        print(f"{row['function']}:{row['line']}  {row['calls']:,} calls  {row['self_s'] * 1000:.3f} ms self",
              file=sys.stderr)
        candidate = row["candidate"]
        if candidate["status"] == "verified":
            print(f"  CPU candidate matched {candidate['samples']} captured calls. "
                  f"Warm speed ratio {candidate['speedup']:.2f}x.", file=sys.stderr)
        else:
            print(f"  {candidate['status']}: {candidate['reason']}", file=sys.stderr)
