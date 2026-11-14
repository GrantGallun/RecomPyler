"""Instrument one warmed Barnes driver; diagnostic overhead is not a speed result."""
import ast
import argparse
import builtins
import functools
import json
import os
from pathlib import Path
import statistics
import sys
import time

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--source', required=True, type=Path)
parser.add_argument('--driver', required=True, type=Path)
parser.add_argument('--plan', required=True, type=Path)
parser.add_argument('--output', required=True, type=Path)
args = parser.parse_args()
sys.path.insert(0, str(args.source.resolve() / 'src'))
from recompyler import heap, runner

clock = time.perf_counter_ns
records, energy = [], []
active = None
driver_globals = None


def phase(cls, name, label):
    original = getattr(cls, name)
    @functools.wraps(original)
    def measured(*args, **kwargs):
        if active is None:
            return original(*args, **kwargs)
        started = clock()
        try:
            return original(*args, **kwargs)
        finally:
            active[label] += clock() - started
    setattr(cls, name, measured)


phase(heap.Region, 'load', 'load_ns')
phase(heap._Program, 'guards_hold', 'guards_ns')
phase(heap._Unloader, 'write_back', 'writeback_ns')
compile_original = heap._Program.compile
def compile_measured(program, *args, **kwargs):
    result = compile_original(program, *args, **kwargs)
    if program.entry_fn.__name__ == 'advance_system':
        native = program.run
        def run(*args):
            started = clock()
            try:
                return native(*args)
            finally:
                if active is not None:
                    active['native_ns'] += clock() - started
                    active['native_entries'] += 1
                    active['aot'] = program.ahead_of_time
        program.run = run
    return result
heap._Program.compile = compile_measured

attempt_original = heap.Region.attempt
def attempt_measured(region, *args, **kwargs):
    global active
    if region.original.__name__ != 'advance_system':
        return attempt_original(region, *args, **kwargs)
    record = dict(load_ns=0, guards_ns=0, native_ns=0, writeback_ns=0, native_entries=0)
    active = record
    started = clock()
    try:
        result = attempt_original(region, *args, **kwargs)
        record['ok'] = result[0]
        return result
    finally:
        record['attempt_ns'] = clock() - started
        records.append(record)
        active = None
heap.Region.attempt = attempt_measured


def energy_wrap(fn):
    global driver_globals
    driver_globals = getattr(fn, '__recompyler_original__', fn).__globals__
    @functools.wraps(fn)
    def measured(*args, **kwargs):
        started = clock()
        try:
            return fn(*args, **kwargs)
        finally:
            energy.append(clock() - started)
    measured.__recompyler_original__ = getattr(fn, '__recompyler_original__', fn)
    return measured
builtins.__recompyler_diag_energy = energy_wrap
mark_original = runner._Mark.visit_FunctionDef
def mark(node_self, node):
    node = mark_original(node_self, node)
    if node.name == 'calculate_system_energy':
        node.decorator_list.insert(0, ast.copy_location(ast.Name(id='__recompyler_diag_energy', ctx=ast.Load()), node))
    return node
runner._Mark.visit_FunctionDef = mark

report = runner.run_script(args.driver.resolve(), ['6'], args.plan.resolve(), force=True)
valid = len(records) == 600 and len(energy) == 12 and all(r['ok'] and r.get('aot') for r in records)
if not valid:
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(dict(valid=False, report=report, calls=records, energy_ns=energy,
                                           headline_timing_eligible=False), indent=2) + '\n')
    raise SystemExit('Separate phase diagnostic did not execute exactly600successful AOT advances; raw evidence retained.')
summaries = []
for rep in range(6):
    calls = records[rep * 100:(rep + 1) * 100]
    row = {key: sum(c[key] for c in calls) / 1e6 for key in ['load_ns', 'guards_ns', 'native_ns', 'writeback_ns', 'attempt_ns']}
    row = {k.replace('_ns', '_ms'): v for k, v in row.items()}
    row['energy_ms'] = energy[rep * 2 + 1] / 1e6
    row['kernel_ms'] = driver_globals['_times'][rep] * 1000
    row['other_attempt_ms'] = row['attempt_ms'] - sum(row[k] for k in ['load_ms', 'guards_ms', 'native_ms', 'writeback_ms'])
    row['native_entries'] = sum(c['native_entries'] for c in calls)
    summaries.append(row)
out = dict(method='Six repetitions; first excluded from warmed medians. Timers add overhead. Source/artifacts unchanged. Final energy is inside the original kernel timer.',
           report=report, repetitions=summaries,
           warm_component_medians_ms={k: statistics.median(r[k] for r in summaries[1:]) for k in summaries[0] if k.endswith('_ms')},
           native_imported_numba='numba' in sys.modules)
path = args.output.resolve()
path.parent.mkdir(parents=True, exist_ok=True)
path.write_text(json.dumps(out, indent=2) + '\n')
print(json.dumps(out['warm_component_medians_ms'], indent=2))
