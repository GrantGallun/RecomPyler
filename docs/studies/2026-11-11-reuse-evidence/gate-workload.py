"""Independent real held-out graph-state AOT gate, not a performance sample."""
import argparse
import importlib.util
import json
from pathlib import Path
import sys
import types


SCRIPT = Path('D:/Code/Datathon/recompyler-coverage/corpus/pyperformance-1.14.0/benchmarks/bm_richards_super/run_benchmark.py')


def load_workload():
    sys.modules['pyperf'] = types.ModuleType('pyperf')
    spec = importlib.util.spec_from_file_location('wave3_real_richards', SCRIPT)
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('mode', choices=['build', 'run'])
    parser.add_argument('folder', type=Path)
    parser.add_argument('--python-loader', action='store_true')
    args = parser.parse_args()
    folder = args.folder.resolve()
    folder.mkdir(parents=True, exist_ok=True)
    from recompyler import heap
    from recompyler.aot import load
    from recompyler.runner import _AotOnlyExports
    module = load_workload()
    heap.NATIVE = not args.python_loader
    fn = module.Richards.run
    key = ('run', fn.__code__.co_firstlineno)
    if args.mode == 'build':
        assert module.Richards().run(1)
        region = heap.lift_region(fn)
        assert region(module.Richards(), 1), region.problem
        assert region.compiled_calls == 1, region.problem
        section = heap.build_regions([(key, fn, region)], folder)
        assert section and section['functions'][0].get('seeds'), 'No reusable metadata exported'
        (folder / 'section.json').write_text(json.dumps(section, indent=2) + '\n')
        print(json.dumps({'built': True, 'export_count': len(section['functions'][0]['exports']),
                          'seed_count': len(section['functions'][0]['seeds']), 'timing_eligible': False}))
        return
    assert module.taskWorkArea.taskList is None, 'Workload did not begin empty'
    section = json.loads((folder / 'section.json').read_text())
    entry = section['functions'][0]
    extension = load(section)
    assert extension is not None
    exports = _AotOnlyExports({digest: getattr(extension, name) for digest, name in entry['exports'].items()})
    region = heap.lift_region(fn, exports, seeds=entry['seeds'])
    original_state = module.taskWorkArea
    ok = region(module.Richards(), 1)
    row = {'ok': ok, 'compiled_calls': region.compiled_calls, 'fallback_calls': region.fallback_calls,
           'aot_calls': getattr(region, 'aot_calls', None), 'jit_calls': getattr(region, 'jit_calls', None),
           'numba_imported': 'numba' in sys.modules, 'hold_count': module.taskWorkArea.holdCount,
           'qpkt_count': module.taskWorkArea.qpktCount, 'same_global': module.taskWorkArea is original_state,
           'python_loader': args.python_loader, 'problem': region.problem, 'timing_eligible': False}
    print(json.dumps(row))
    assert ok and row['compiled_calls'] == row['aot_calls'] == 1 and row['jit_calls'] == row['fallback_calls'] == 0, row
    assert not row['numba_imported'] and row['same_global'], row
    assert row['hold_count'] == 9297 and row['qpkt_count'] == 23246, row


if __name__ == '__main__':
    main()
