"""Locked compile-throughput probe using the canonical compiler, without installs."""
from contextlib import contextmanager
from functools import wraps
from time import perf_counter


class PhaseTimer:
    def __init__(self, clock=perf_counter):
        self.clock, self.stack, self.seconds, self.calls = clock, [], {}, {}

    def wrap(self, name, function):
        @wraps(function)
        def measured(*args, **kwargs):
            frame = [self.clock(), 0.0]
            self.stack.append(frame)
            try: return function(*args, **kwargs)
            finally:
                elapsed = self.clock() - frame[0]
                self.stack.pop()
                self.seconds[name] = self.seconds.get(name, 0.0) + elapsed - frame[1]
                self.calls[name] = self.calls.get(name, 0) + 1
                if self.stack: self.stack[-1][1] += elapsed
        return measured

    @contextmanager
    def instrument(self):
        from recompyler.ir import compiler, lower_llvm, structure_lowerings, _entry_native
        from recompyler.ir.symbols import CPythonSymbols
        from llvmlite import binding, ir
        patches = [
            (compiler, 'build', 'IR build'),
            (structure_lowerings, 'specialize_structure_calls', 'structure feedback'),
            (structure_lowerings, 'select_structure_calls', 'structure selection'),
            (structure_lowerings.StructureCalls, '__init__', 'provider setup'),
            (compiler, 'lower', 'LLVM IR construction'),
            (lower_llvm, 'verify', 'IR verification'),
            (lower_llvm, '_finish', 'LLVM finish other'),
            (ir.Module, '__repr__', 'LLVM serialization'),
            (binding, 'parse_assembly', 'LLVM parse'),
            (binding, 'create_mcjit_compiler', 'MCJIT setup'),
            (binding.ExecutionEngine, 'finalize_object', 'LLVM codegen/link'),
            (CPythonSymbols, 'resolve', 'symbol resolution'),
            (_entry_native, 'prepare_frame_entry', 'prepare entry'),
        ]
        originals = []
        try:
            for owner, attr, label in patches:
                original = getattr(owner, attr)
                originals.append((owner, attr, original))
                setattr(owner, attr, self.wrap(label, original))
            yield
        finally:
            for owner, attr, original in reversed(originals): setattr(owner, attr, original)


def main():
    import argparse,ctypes,json,os
    from pathlib import Path
    from bench.libs.workloads import workloads,output_digest
    from bench.libs.diagnose import collect_calls,select_targets
    from bench.libs.runner import ROOT,timing_lock
    parser=argparse.ArgumentParser()
    parser.add_argument('name')
    parser.add_argument('--limit',type=int,default=24)
    parser.add_argument('--output',required=True)
    args=parser.parse_args()
    if os.name=='nt': ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    case=workloads()[args.name];run=case.prepare();expected=output_digest(run())
    for _ in range(8): assert output_digest(run())==expected
    value,observed=collect_calls(run,case.package,include_driver=args.name=='numpy_loop')
    assert output_digest(value)==expected
    selected,excluded=select_targets(observed,args.limit)
    targets=[(row,row['function']()) for row in selected if row['function']() is not None]
    # Import/setup occurs before the locked measured region.
    from recompyler.ir.compiler import compile_function,compilation_info
    timer=PhaseTimer();rows=[]
    with timing_lock(ROOT.parent/'TIMING.lock',ROOT.parent/'WAVE21-LIBS-PLAN.md',purpose='S89 compile phases '+args.name,expected=15):
        with timer.instrument():
            compile_measured=timer.wrap('compiler other',compile_function)
            start=perf_counter()
            for row,target in targets:
                if compilation_info(target) is not None: raise RuntimeError('probe needs fresh uncompiled targets')
                try:
                    compile_measured(target,strict=True)
                    rows.append(dict(function=row['name'],compiled=compilation_info(target) is not None))
                except Exception as error:
                    rows.append(dict(function=row['name'],compiled=False,reason=type(error).__name__+': '+str(error)))
            elapsed=perf_counter()-start
    compiled=sum(row['compiled'] for row in rows)
    report=dict(name=args.name,attempted=len(rows),compiled=compiled,not_attempted=len(excluded),
                seconds=elapsed,functions_per_second=compiled/elapsed,phase_seconds_exclusive=timer.seconds,
                phase_calls=timer.calls,rows=rows,instrumentation_included=True)
    Path(args.output).write_text(json.dumps(report,indent=2))
    print(json.dumps(report))


if __name__=='__main__':main()
