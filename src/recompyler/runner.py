"""Run a script with the compiled versions a saved profile recommended."""

import ast
import builtins
import functools
import json
from pathlib import Path
import sys
import tokenize
import types

USE = "__recompyler_use__"


def recommended(plan, force=False):
    """(function name, line) pairs the profile marked as worth compiling.

    Empty when the profile found that loading the compiler would cost more than the
    recommended functions save, unless ``force``.
    """
    data = json.loads(Path(plan).read_text(encoding="utf-8"))
    if not force and not data.get("plan", {}).get("worth_running", False):
        return set()
    rows = data.get("functions") or data.get("hotspots") or []
    picks = set()
    for row in rows:
        candidate = row.get("candidate", row)
        if candidate.get("status") == "verified" and candidate.get("recommended"):
            picks.add((row["function"], row["line"]))
    return picks


def regional(plan):
    """The (function name, line) pairs the profile verified as whole regions."""
    data = json.loads(Path(plan).read_text(encoding="utf-8"))
    return {(row["function"], row["line"]) for row in data.get("functions") or []
            if row.get("candidate", {}).get("engine") == "region"}


class _Mark(ast.NodeTransformer):
    """Decorate the chosen definitions, wherever they are, with the swap-in hook."""

    def __init__(self, picks):
        self.picks, self.found = picks, set()

    def visit_FunctionDef(self, node):
        self.generic_visit(node)
        key = node.name, node.lineno
        if key in self.picks and not node.decorator_list:
            self.found.add(key)
            node.decorator_list = [ast.copy_location(ast.Name(id=USE, ctx=ast.Load()), node)]
        return node


def run_script(script, script_args, plan, force=False):
    """Run ``script`` as ``__main__`` with recommended functions compiled.

    The source on disk is not changed. Each chosen function is lifted on its first
    call, when the helpers it uses exist; if it cannot be, Python runs it as before.
    Returns the per-function call counts.
    """
    picks = recommended(plan, force)
    section = json.loads(Path(plan).read_text(encoding="utf-8")).get("plan", {}).get("aot")
    built = {(item["function"], item["line"]): item for item in section["functions"]} if section else {}
    regions = regional(plan)
    extension = {}
    with tokenize.open(script) as handle:
        source = handle.read()
    tree = ast.parse(source, str(script))
    marker = _Mark(picks)
    tree = marker.visit(tree)
    code = compile(tree, str(script), "exec")
    used = []

    def use(fn):
        key = fn.__name__, fn.__code__.co_firstlineno
        state = {"lifted": None, "failed": False, "ahead_of_time": False, "region": key in regions}
        entry = built.get(key)

        def prepare():
            # The ahead-of-time module first: it needs no Numba. If the function or
            # its constants changed since the build, compile it the usual way.
            if entry is not None:
                from .aot import AotLifted, load

                if "module" not in extension:
                    extension["module"] = load(section)
                if extension["module"] is not None:
                    try:
                        state["lifted"], state["ahead_of_time"] = AotLifted(fn, entry, extension["module"]), True
                        return
                    except Exception:
                        pass
            if state["region"]:
                from .heap import lift_region

                state["lifted"] = lift_region(fn)
                return
            from .lift import lift

            state["lifted"] = lift(fn)

        @functools.wraps(fn)
        def fast(*args, **kwargs):
            if state["lifted"] is None and not state["failed"]:
                try:
                    prepare()
                except Exception:
                    state["failed"] = True
            if state["lifted"] is None:
                return fn(*args, **kwargs)
            return state["lifted"](*args, **kwargs)

        fast.__recompyler_original__ = fn
        used.append((fn.__qualname__, state))
        return fast

    module = types.ModuleType("__main__")
    module.__dict__.update({"__file__": str(script), "__builtins__": builtins, USE: use})
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
    report = []
    for name, state in used:
        lifted = state["lifted"]
        report.append({"function": name, "compiled_calls": lifted.compiled_calls if lifted else 0,
                       "fallback_calls": lifted.fallback_calls if lifted else 0, "lifted": lifted is not None,
                       "ahead_of_time": state["ahead_of_time"], "region": state["region"]})
    missing = sorted(picks - marker.found)
    return {"script": str(script), "functions": report, "not_found": [f"{name}:{line}" for name, line in missing],
            "exit_code": exit_code}


def print_run(report):
    print(f"\nRecomPyler run — {report['script']}", file=sys.stderr)
    for row in report["functions"]:
        how = ("compiled ahead of time" if row.get("ahead_of_time")
               else "compiled as one region" if row.get("region") else "compiled")
        state = how if row["lifted"] else "ran in Python"
        print(f"  {row['function']}: {state}, {row['compiled_calls']:,} compiled calls, "
              f"{row['fallback_calls']:,} handed back to Python", file=sys.stderr)
    for name in report["not_found"]:
        print(f"  {name}: in the plan but not found in the script; it may have changed", file=sys.stderr)
    if not report["functions"] and not report["not_found"]:
        print("  The plan recommends nothing for this script, so it ran in plain Python.", file=sys.stderr)
