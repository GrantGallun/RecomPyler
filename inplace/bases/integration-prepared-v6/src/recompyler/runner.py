"""Run a script with the compiled versions a saved profile recommended."""

import builtins
import json
from pathlib import Path
import sys
import types

def _origin_key(*args):
    # Empty-deployment runs do not need hashing or distribution metadata.
    from ._origin import key
    return key(*args)


def _origin_identity(fn):
    from ._origin import identity
    return identity(fn)

USE = "__recompyler_use__"
DISPATCH = "__recompyler_dispatch__"


class _AotOnlyExports(dict):
    """An AOT-budgeted region may use matching exports, but may not start JIT.

    Stay truthy even when the module could not load: Region and Program use an
    ``exports or {}`` default. A missing digest is an ordinary unsupported
    specialization, which Region caches and sends back to Python before execution.
    """
    allow_jit = False
    def __bool__(self):
        return True

    def get(self, digest, default=None):
        export = super().get(digest)
        if export is None:
            from .lift import Unsupported
            raise Unsupported("the plan budgets AOT startup, but no matching region export is available")
        return export


def recommended(plan, force=False):
    """(function name, line) pairs the profile marked as worth compiling.

    Empty when the profile found that loading the compiler would cost more than the
    recommended functions save, unless ``force``.
    """
    data = json.loads(Path(plan).read_text(encoding="utf-8"))
    return _recommended(data, force)


def _recommended(data, force=False):
    """The selections from one already-read plan snapshot."""
    if not force and not data.get("plan", {}).get("worth_running", False):
        return set()
    rows = data.get("functions") or data.get("hotspots") or []
    picks = set()
    for row in rows:
        candidate = row.get("candidate", row)
        if candidate.get("status") == "verified" and candidate.get("recommended"):
            picks.add(_origin_key(row,data.get("script")))
    return picks


def regional(plan):
    """The (function name, line) pairs the profile verified as whole regions."""
    data = json.loads(Path(plan).read_text(encoding="utf-8"))
    return _regional(data)


def _regional(data):
    return {_origin_key(row,data.get("script")) for row in data.get("functions") or []
            if row.get("candidate", {}).get("engine") == "region"}


def batch_pays(data, ratios, picks):
    """Whether the run pays off once batch sites count: the time the batch functions'
    calls would save at their best measured ratio, plus what the single-call plan
    saves, must exceed the start-up cost. Assumes the calls go through the sites."""
    plan = data.get("plan", {})
    saving = plan.get("saving_s", 0.0) if picks else 0.0
    for row in data.get("functions") or []:
        key = row["function"], row["line"]
        if key in ratios:
            python_s = row["calls"] * (row["candidate"].get("python_us_per_call") or 0) / 1e6
            saving += python_s * (1 - 1 / max(ratios[key].values()))
    return saving > plan.get("startup_s", 0.0)


def _Mark(picks):
    """Make a definition marker only when a run needs source rewriting."""
    import ast

    class Mark(ast.NodeTransformer):
        def __init__(self, picks):
            self.picks, self.found = picks, set()

        def visit_FunctionDef(self, node):
            self.generic_visit(node)
            key = node.name, node.lineno
            if key in self.picks and not node.decorator_list:
                self.found.add(key)
                node.decorator_list = [ast.copy_location(ast.Name(id=USE, ctx=ast.Load()), node)]
            return node

        # A coroutine is swapped in the same way; its stand-in returns a coroutine.
        visit_AsyncFunctionDef = visit_FunctionDef

    return Mark(picks)


def run_script(script, script_args, plan, force=False):
    """Run ``script`` as ``__main__`` with recommended functions compiled.

    The source on disk is not changed. Each chosen function is lifted on its first
    call, when the helpers it uses exist; if it cannot be, Python runs it as before.
    Returns the per-function call counts.
    """
    data = json.loads(Path(plan).read_text(encoding="utf-8"))
    picks = _recommended(data, force)
    if not picks and not _batch_candidates(data):
        return _run_plain(script, script_args)
    from .batch import Batches, Sites, plan_ratios

    # Batch rewriting identifies lexical names in this script only. External
    # origins must use the identity-checked single-call dispatch below.
    local_data = dict(data,functions=[r for r in data.get("functions",[]) if len(_origin_key(r,script))==2])
    ratios = plan_ratios(local_data)
    if not picks and not force and not batch_pays(local_data, ratios, picks):
        return _run_plain(script, script_args)

    import ast
    import functools
    import tokenize

    section = data.get("plan", {}).get("aot")
    built = {_origin_key(item,script): item for item in section["functions"]} if section else {}
    regions = _regional(data)
    region_section = data.get("plan", {}).get("aot_regions")
    region_exports = {_origin_key(item,script): item["exports"]
                      for item in region_section["functions"]} if region_section else {}
    region_entries = {_origin_key(item,script): item for item in region_section["functions"]} if region_section else {}
    region_seeds = {_origin_key(item,script): item.get("seeds", {})
                    for item in region_section["functions"]} if region_section else {}
    covered = {key for key in picks if (region_exports.get(key) if key in regions
                                       else built.get(key, {}).get("exports"))}
    # run_plan budgets AOT startup when every recommendation has an export.
    # --force explicitly permits the former JIT behavior on deployment misses.
    aot_only = not force and bool(picks) and picks <= covered
    extension = {}
    with tokenize.open(script) as handle:
        source = handle.read()
    tree = ast.parse(source, str(script))
    sites = Sites({name for name, _ in ratios})
    tree = sites.visit(tree)
    ratios = {key: value for key, value in ratios.items() if key[0] in {name for name, _ in sites.found}}
    if ratios and not force and not batch_pays(local_data, ratios, picks):
        ratios = {}
    if not picks and not ratios:
        # No accepted sites remain. Execute the original source so each rejected
        # site costs nothing and the script receives no unused runtime hooks.
        return _run_plain(script, script_args)
    batches = Batches(ratios)
    library_picks = {key for key in picks if len(key) == 3}
    local_picks = picks - library_picks
    marker = _Mark(local_picks | set(ratios))
    tree = marker.visit(tree)
    if library_picks:
        class Calls(ast.NodeTransformer):
            def visit_Call(self, node):
                self.generic_visit(node)
                # Expansion errors must keep the original callable's error path.
                if any(k.arg is None for k in node.keywords) or any(isinstance(a,ast.Starred) for a in node.args):
                    return node
                node.func = ast.copy_location(ast.Call(func=ast.Name(id=DISPATCH,ctx=ast.Load()),args=[node.func],keywords=[]),node.func)
                return node
        tree = ast.fix_missing_locations(Calls().visit(tree))
    code = compile(tree, str(script), "exec")
    used = []
    def use(fn, key=None):
        key = key or (fn.__name__, fn.__code__.co_firstlineno)
        state = {"lifted": None, "failed": False, "aot_loaded": False, "region": key in regions,
                 "python_calls": 0, "file": fn.__code__.co_filename}
        if key not in picks:
            # Only batch sites use this function compiled; single calls stay in Python
            # and pay nothing, so the function itself is kept, just registered.
            return batches.mark(fn)
        entry = None if state["region"] else built.get(key)

        def prepare():
            origin_entry = (region_entries if state["region"] else built).get(key)
            current_origin = _origin_identity(fn) if origin_entry and origin_entry.get("origin") else None
            expected_origin = origin_entry.get("origin") if origin_entry else None
            if current_origin is not None and region_section and 'prepared' in region_section:
                # Prepared definitions bind exact file/code/default/dependency keys.
                # Module labels change when a profiled import runs as __main__.
                current_origin = {k:v for k,v in current_origin.items() if k != 'module'}
                expected_origin = {k:v for k,v in expected_origin.items() if k != 'module'}
            if current_origin is not None and current_origin != expected_origin:
                if aot_only:
                    state["failed"] = True
                elif state["region"]:
                    from .heap import lift_region
                    state["lifted"] = lift_region(fn)
                else:
                    from .lift import lift
                    state["lifted"] = lift(fn)
                return
            # The ahead-of-time module first: it needs no Numba. If the function or
            # its constants changed since the build, compile it the usual way.
            if entry is not None:
                from .aot import AotLifted, load

                if "module" not in extension:
                    extension["module"] = load(section)
                if extension["module"] is not None:
                    try:
                        state["lifted"], state["aot_loaded"] = AotLifted(fn, entry, extension["module"]), True
                        return
                    except Exception:
                        pass
                if aot_only:
                    state["failed"] = True
                    return
            if state["region"]:
                from .heap import lift_region

                exports, built_ahead, prepared = region_exports.get(key), {}, None
                if exports:
                    if "prepared" in region_section:
                        # Presence is authoritative: corrupt/null metadata must
                        # never route a changed artifact through legacy load().
                        from ._prepared import open_index, PreparedArtifactMismatch
                        try:
                            prepared = open_index(region_section, region_entries[key],
                                plan_snapshot=dict(data, mode="saved", force=bool(force)),
                                module=extension.get("regions"))
                        except PreparedArtifactMismatch:
                            prepared = None
                        if prepared is not None:
                            extension["regions"] = prepared.module
                            built_ahead = prepared.exports
                    else:
                        from .aot import load
                        if "regions" not in extension:
                            extension["regions"] = load(region_section)
                        if extension["regions"] is not None:
                            built_ahead = {digest: getattr(extension["regions"], name)
                                           for digest, name in exports.items()}
                state["aot_loaded"] = bool(built_ahead)
                options = {"seeds": region_seeds[key]} if region_seeds.get(key) else {}
                if prepared is not None:
                    options["prepared"] = prepared
                state["lifted"] = lift_region(fn, built_ahead if hasattr(built_ahead, 'resolve_program') else (_AotOnlyExports(built_ahead) if aot_only else built_ahead),
                                              **options)
                return
            from .lift import lift

            state["lifted"] = lift(fn)

        if state["region"] and fn.__code__.co_flags & 0x220:
            # Even a pass-only loop assigns its target between yields. Keep
            # generator calls lazy until those intervening writes can be proven safe.
            used.append((fn.__qualname__, state))
            return fn

        @functools.wraps(fn)
        def fast(*args, **kwargs):
            if state["lifted"] is None and not state["failed"]:
                try:
                    prepare()
                except Exception:
                    state["failed"] = True
                from ._runner_wrapper import record_lifted
                record_lifted(fast)
            if state["lifted"] is None:
                state["python_calls"] += 1
                return fn(*args, **kwargs)
            return state["lifted"](*args, **kwargs)

        fast.__recompyler_original__ = fn
        fast.__recompyler_lifted__ = lambda: state["lifted"]
        from ._runner_wrapper import register
        register(fast, fn, prepare, state)
        used.append((fn.__qualname__, state))
        return fast

    dispatched = {}
    def dispatch(fn):
        # Inspect exact builtin function/method objects only; arbitrary callable
        # objects receive no extra attribute lookups and keep their Python path.
        bound = type(fn) is types.MethodType
        target = fn.__func__ if bound else fn
        if type(target) is not types.FunctionType:
            return fn
        code = target.__code__
        key = _origin_key(dict(file=code.co_filename,function=code.co_name,line=code.co_firstlineno))
        if key not in library_picks:
            return fn
        fast = dispatched.get(target)
        if fast is None:
            fast = dispatched[target] = use(target,key)
            marker.found.add(key)
        return types.MethodType(fast,fn.__self__) if bound else fast

    module = types.ModuleType("__main__")
    module.__dict__.update({"__file__": str(script), "__builtins__": builtins, USE: use, DISPATCH: dispatch, **batches.namespace()})
    saved = sys.modules.get("__main__"), sys.argv, sys.path[:]
    sys.modules["__main__"], sys.argv = module, [str(script), *script_args]
    sys.path.insert(0, str(script.parent))
    exit_code = None
    undo = batches.intercept() if ratios else (lambda: None)
    try:
        exec(code, module.__dict__)
    except SystemExit as exc:
        exit_code = exc.code
    finally:
        undo()
        sys.modules["__main__"], sys.argv = saved[0], saved[1]
        sys.path[:] = saved[2]
    report = []
    for name, state in used:
        lifted = state["lifted"]
        aot_calls, jit_calls = _execution_counts(state)
        report.append({"function": name, "file": state["file"], "compiled_calls": lifted.compiled_calls if lifted else 0,
                       "aot_calls": aot_calls, "jit_calls": jit_calls,
                       "fallback_calls": (lifted.fallback_calls if lifted else 0) + state["python_calls"],
                       "lifted": lifted is not None,
                       "ahead_of_time": _executed_ahead_of_time(state),
                       "aot_loaded": state["aot_loaded"], "region": state["region"]})
    missing = sorted(picks - marker.found)
    return {"script": str(script), "functions": report, "not_found": [":".join(map(str,key)) for key in missing],
            "batches": batches.used, "batch_failures": {f"{name}:{line}": why for (name, line), why in batches.failed.items()},
            "exit_code": exit_code}


def _execution_counts(state):
    """Successful executions by their actual mode; unused programs count nothing."""
    lifted = state["lifted"]
    if lifted is None:
        return 0, 0
    if state["region"]:
        return lifted.aot_calls, lifted.jit_calls
    # Ordinary AotLifted has only native exports; ordinary Lifted only uses JIT.
    return (lifted.compiled_calls, 0) if state["aot_loaded"] else (0, lifted.compiled_calls)


def _executed_ahead_of_time(state):
    """Whether compiled calls ran with an exclusively AOT-prepared implementation.

    Export availability alone says nothing about a region's digest matches. With
    this conservative compatibility flag, require every prepared region program
    to be a valid AOT program, as well as a compiled call. False
    can therefore mean mixed/unknown preparation, not necessarily JIT execution.
    ``aot_loaded`` records loaded exports; ``aot_calls``/``jit_calls`` give exact
    successful execution counts, independent of unused prepared signatures.
    """
    lifted = state["lifted"]
    if lifted is None or not lifted.compiled_calls:
        return False
    if not state["region"]:
        return state["aot_loaded"]
    programs = tuple(lifted.programs.values())
    return bool(programs) and all(program is not None and not program.broken
                                  and getattr(program, "ahead_of_time", False) for program in programs)


def _batch_candidates(data):
    """Whether any function in the profile could be used at batch sites (batch.plan_ratios)."""
    for row in data.get("functions") or []:
        candidate = row.get("candidate", {})
        ratios = candidate.get("batch_backends") or {}
        if candidate.get("status") == "verified" and ratios and max(ratios.values()) >= 1.05:
            return True
    return False


def _run_plain(script, script_args):
    """run_script when the plan uses nothing: the script runs as ``python script`` would
    run it, compiled straight from its source with no rewriting and no hooks."""
    code = compile(script.read_bytes(), str(script), "exec")
    module = types.ModuleType("__main__")
    module.__dict__.update({"__file__": str(script), "__builtins__": builtins})
    saved = sys.modules.get("__main__"), sys.argv, sys.path[:]
    sys.modules["__main__"], sys.argv = module, [str(script), *script_args]
    sys.path.insert(0, str(script.parent))
    exit_code = None
    try:
        exec(code, module.__dict__)
    except SystemExit as exc:
        exit_code = exc.code
    finally:
        sys.modules["__main__"], sys.argv = saved[0], saved[1]
        sys.path[:] = saved[2]
    return {"script": str(script), "functions": [], "not_found": [], "batches": {}, "batch_failures": {},
            "exit_code": exit_code}


def print_run(report):
    print(f"\nRecomPyler run — {report['script']}", file=sys.stderr)
    for row in report["functions"]:
        how = ("compiled as one region" if row.get("region") else "compiled") + (
            " ahead of time" if row.get("ahead_of_time") else "")
        state = how if row["lifted"] else "ran in Python"
        print(f"  {row['function']}: {state}, {row['compiled_calls']:,} compiled calls, "
              f"{row['fallback_calls']:,} handed back to Python", file=sys.stderr)
    for name, stats in report.get("batches", {}).items():
        where = ", ".join(f"{backend} x{count}" for backend, count in stats["backends"].items())
        print(f"  {name}: {stats['rows']:,} calls in {stats['batches']:,} batches ({where}), "
              f"{stats['fallback']:,} handed back to Python", file=sys.stderr)
    for name, why in report.get("batch_failures", {}).items():
        print(f"  {name}: batch sites ran in Python ({why})", file=sys.stderr)
    for name in report["not_found"]:
        print(f"  {name}: in the plan but not found in the script; it may have changed", file=sys.stderr)
    if not report["functions"] and not report["not_found"] and not report.get("batches"):
        print("  The plan recommends nothing for this script, so it ran in plain Python.", file=sys.stderr)
