"""Separate untimed execution-mode audit. Never used in headline timing children."""
import argparse
import functools
import json
from pathlib import Path
import sys


class Auditor:
    def __init__(self):
        self.patches = []
        self.rows = {}

    def row(self, value, kind):
        key = id(value)
        if key not in self.rows:
            fn = getattr(value, "original", None)
            self.rows[key] = {"function": getattr(fn, "__qualname__", "fixture"), "kind": kind,
                              "aot_calls": 0, "jit_calls": 0, "unknown_native_calls": 0,
                              "rejected_attempts": 0, "fallback_calls": 0, "programs": {}}
        return self.rows[key]

    def patch(self, cls, name, wrapper):
        original = getattr(cls, name)
        self.patches.append((cls, name, original))
        setattr(cls, name, wrapper(original))

    def patch_region(self, cls):
        auditor = self
        def wrapper(original):
            @functools.wraps(original)
            def attempt(region, *args, **kwargs):
                result = original(region, *args, **kwargs)
                row = auditor.row(region, "region")
                if result[0]:
                    program = getattr(region, "latest", None)
                    mode = getattr(program, "ahead_of_time", None)
                    key = "aot_calls" if mode is True else "jit_calls" if mode is False else "unknown_native_calls"
                    row[key] += 1
                    digest = getattr(program, "digest", "unknown")
                    event = row["programs"].setdefault(str(digest), {"aot_calls": 0, "jit_calls": 0, "unknown_native_calls": 0})
                    event[key] += 1
                else:
                    row["rejected_attempts"] += 1
                return result
            return attempt
        self.patch(cls, "attempt", wrapper)
        # Fallback counters are sampled after wrapper completion, including awaits
        # and generator-specific entry points. They are not inferred from rejects.
        for name in ("__call__", "values", "_resumed"):
            if not hasattr(cls, name):
                continue
            original = getattr(cls, name)
            import inspect
            if inspect.iscoroutinefunction(original):
                def async_wrapper(original):
                    @functools.wraps(original)
                    async def call(region, *args, **kwargs):
                        before = region.fallback_calls
                        try:
                            return await original(region, *args, **kwargs)
                        finally:
                            auditor.row(region, "region")["fallback_calls"] += region.fallback_calls - before
                    return call
                self.patch(cls, name, async_wrapper)
            else:
                def sync_wrapper(original):
                    @functools.wraps(original)
                    def call(region, *args, **kwargs):
                        before = region.fallback_calls
                        try:
                            return original(region, *args, **kwargs)
                        finally:
                            auditor.row(region, "region")["fallback_calls"] += region.fallback_calls - before
                    return call
                self.patch(cls, name, sync_wrapper)

    def patch_lifted(self, cls, aot_cls):
        auditor = self
        def wrapper(original):
            @functools.wraps(original)
            def call(lifted, *args, **kwargs):
                before = lifted.compiled_calls, lifted.fallback_calls
                try:
                    return original(lifted, *args, **kwargs)
                finally:
                    row = auditor.row(lifted, "ordinary")
                    row["aot_calls" if isinstance(lifted, aot_cls) else "jit_calls"] += lifted.compiled_calls - before[0]
                    row["fallback_calls"] += lifted.fallback_calls - before[1]
            return call
        self.patch(cls, "__call__", wrapper)

    def restore(self):
        for cls, name, original in reversed(self.patches):
            setattr(cls, name, original)
        self.patches.clear()

    def result(self):
        keys = ("aot_calls", "jit_calls", "unknown_native_calls", "rejected_attempts", "fallback_calls")
        return {"totals": {k: sum(r[k] for r in self.rows.values()) for k in keys},
                "functions": list(self.rows.values())}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--plan", required=True, type=Path)
    parser.add_argument("script", type=Path)
    parser.add_argument("script_args", nargs=argparse.REMAINDER)
    args = parser.parse_args()
    initial_modules = set(sys.modules)
    from recompyler.heap import Region
    from recompyler.lift import Lifted
    from recompyler.aot import AotLifted
    from recompyler.runner import run_script
    instrumented_modules = set(sys.modules)
    auditor = Auditor()
    auditor.patch_region(Region)
    auditor.patch_lifted(Lifted, AotLifted)
    report = None
    try:
        report = run_script(args.script.resolve(), args.script_args, args.plan.resolve(), False)
    finally:
        result = auditor.result()
        auditor.restore()
        result.update(runner_report=report, numba_imported_before="numba" in initial_modules,
                      numba_imported_by_audit_bootstrap="numba" in instrumented_modules,
                      numba_imported_after="numba" in sys.modules,
                      timing_eligible=False,
                      limitations=["Audit imports/patches add overhead; this process is never a latency sample.",
                                   "Successful Region.attempt mode uses its actual selected latest program, not export availability.",
                                   "jit_calls includes fresh JIT and Numba disk-cache execution; no machine-code cache-hit inference."])
        if report is not None:
            fields = report.get("functions", [])
            result["runner_total_compiled_calls"] = sum(f.get("compiled_calls", 0) for f in fields)
            result["runner_total_fallback_calls"] = sum(f.get("fallback_calls", 0) for f in fields)
            result["product_exact_aot_calls"] = sum(f.get("aot_calls", 0) for f in fields) if all("aot_calls" in f for f in fields) else None
            result["product_exact_jit_calls"] = sum(f.get("jit_calls", 0) for f in fields) if all("jit_calls" in f for f in fields) else None
            totals = result["totals"]
            result["compiled_total_reconciles"] = sum(totals[k] for k in ("aot_calls", "jit_calls", "unknown_native_calls")) == result["runner_total_compiled_calls"]
            result["runner_only_fallback_calls"] = result["runner_total_fallback_calls"] - totals["fallback_calls"]
            result["product_exact_counter_matches_audit"] = None if result["product_exact_aot_calls"] is None else (
                result["product_exact_aot_calls"] == totals["aot_calls"] and result["product_exact_jit_calls"] == totals["jit_calls"])
            result["batch_execution_needs_separate_audit"] = bool(report.get("batches"))
            result["fallback_note"] = "Audit wrapper counts exclude direct runner preparation-failure Python calls; runner counter retains those."
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    if report and report["exit_code"] not in (None, 0):
        return report["exit_code"] if isinstance(report["exit_code"], int) else 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
