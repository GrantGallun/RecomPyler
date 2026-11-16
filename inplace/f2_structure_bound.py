"""Owned F2 structural-cache counterfactual; run only under run_locked.

Uses exact FunctionIR inputs captured by the existing compile-only Richards helper.
No product edits, pass disabling, native execution, AOT builds, or JIT compilation.
"""
from pathlib import Path
import argparse
import ast
import dataclasses
import hashlib
import inspect
import json
import os
import sys
import textwrap
import time
import types

D = Path(__file__).resolve().parent


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def normalize(value):
    if isinstance(value, dict):
        return {str(k): normalize(v) for k, v in sorted(value.items())}
    if isinstance(value, (tuple, list)):
        return [normalize(v) for v in value]
    if isinstance(value, set):
        return sorted((normalize(v) for v in value), key=lambda v: json.dumps(v, sort_keys=True))
    return value


def state(analysis):
    return dict(report=analysis.report(), origins=analysis.origins, events=analysis.events)


def state_digest(value):
    return hashlib.sha256(json.dumps(normalize(value), sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def inputs(functions):
    return [dict(name=f.name, source=f.source, object_params=list(f.object_params),
                 allocations={k: dict(module=v.__module__, qualname=v.__qualname__) for k, v in f.allocations.items()},
                 object_return=f.object_return, constructor=f.constructor) for f in functions]


def cache_variant(module):
    """Generate only structural substitutions from the exact original scan."""
    tree = ast.parse(textwrap.dedent(inspect.getsource(module.EscapeAnalysis.scan)))
    counts = dict(walk=0, parents=0, unparse=0)
    class Structural(ast.NodeTransformer):
        def visit_Assign(self, node):
            if len(node.targets) == 1 and isinstance(node.targets[0], ast.Name) and node.targets[0].id == 'parents':
                counts['parents'] += 1
                node.value = ast.parse('self._structural[name][1]', mode='eval').body
                return node
            return self.generic_visit(node)
        def visit_Call(self, node):
            if isinstance(node.func, ast.Attribute) and isinstance(node.func.value, ast.Name) and node.func.value.id == 'ast':
                if node.func.attr == 'walk' and len(node.args) == 1 and isinstance(node.args[0], ast.Name) and node.args[0].id == 'tree':
                    counts['walk'] += 1
                    return ast.copy_location(ast.parse('self._structural[name][0]', mode='eval').body, node)
                if node.func.attr == 'unparse':
                    counts['unparse'] += 1
                    node.func = ast.parse('self._cached_unparse', mode='eval').body
            return self.generic_visit(node)
    tree = ast.fix_missing_locations(Structural().visit(tree))
    assert counts == dict(walk=4, parents=1, unparse=7), counts
    namespace = dict(module.__dict__)
    exec(compile(tree, '<owned-f2-structural-cache-scan>', 'exec'), namespace)
    changed_scan = namespace['scan']
    original = module.EscapeAnalysis
    class Cached(original):
        def __init__(self, functions):
            self._structural, self._unparsed = {}, {}
            self.metrics = dict(scan_calls=0, scan_ns=0, structure_build_ns=0, unparse_requests=0, unparse_misses=0)
            super().__init__(functions)
        def _cached_unparse(self, node):
            self.metrics['unparse_requests'] += 1
            if node not in self._unparsed:
                self.metrics['unparse_misses'] += 1
                self._unparsed[node] = ast.unparse(node)
            return self._unparsed[node]
        def scan(self, name):
            started = time.perf_counter_ns()
            try:
                if name not in self._structural:
                    build = time.perf_counter_ns()
                    nodes = tuple(ast.walk(self.trees[name]))
                    parents = {child: parent for parent in nodes for child in ast.iter_child_nodes(parent)}
                    self._structural[name] = (nodes, parents)
                    self.metrics['structure_build_ns'] += time.perf_counter_ns() - build
                return changed_scan(self, name)
            finally:
                self.metrics['scan_calls'] += 1
                self.metrics['scan_ns'] += time.perf_counter_ns() - started
    class Baseline(original):
        def __init__(self, functions):
            self.metrics = dict(scan_calls=0, scan_ns=0)
            super().__init__(functions)
        def scan(self, name):
            started = time.perf_counter_ns()
            try:
                return original.scan(self, name)
            finally:
                self.metrics['scan_calls'] += 1
                self.metrics['scan_ns'] += time.perf_counter_ns() - started
    return Baseline, Cached, ast.unparse(tree), counts


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    smoke = D / 'integration-smoke20-v3'
    parser.add_argument('--source', type=Path, default=D / 'bases/integration-noop/src')
    parser.add_argument('--input', type=Path, default=smoke / 'richards_super/input/run_benchmark.py')
    parser.add_argument('--shim', type=Path, default=smoke / 'shim')
    parser.add_argument('--plan', type=Path, default=smoke / 'richards_super/plan.json')
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--lock-label', required=True)
    options = parser.parse_args()
    for name in ('source', 'input', 'shim', 'plan', 'output'):
        path = getattr(options, name).resolve()
        assert path.is_relative_to(D), (name, path)
        setattr(options, name, path)
    owner = (D.parent.parent / 'TIMING.lock/owner.txt').read_text(encoding='utf-8-sig')
    assert 'wave16-inplace' in owner and ('purpose: ' + options.lock_label + '\n') in owner
    assert Path(os.environ['PYTHONPYCACHEPREFIX']).resolve().is_relative_to(D)
    assert not options.output.exists(), 'Preserve previous diagnostic results'
    options.output.mkdir()
    setup = options.output / 'compile-only'
    setup.mkdir()
    sys.path[:0] = [str(options.source), str(options.shim), str(D)]
    class NoNumba:
        def find_spec(self, fullname, path=None, target=None):
            if fullname == 'numba' or fullname.startswith('numba.'):
                raise RuntimeError('Compile-only bound forbids Numba imports')
            return None
    guard = NoNumba()
    sys.meta_path.insert(0, guard)
    import recompyler.heap as heap
    import preparation_phases
    module = heap._escape
    assert Path(module.__file__).resolve().is_relative_to(options.source)
    source_manifest = options.source.parent / 'source-manifest.json'
    manifest = json.loads(source_manifest.read_text(encoding='utf-8-sig'))
    assert sha(module.__file__) == manifest[Path(module.__file__).resolve().relative_to(options.source).as_posix()]
    original_init = module.EscapeAnalysis.__init__
    captured = []
    def capture(instance, functions):
        values = list(functions)
        frozen = [dataclasses.replace(f, object_params=tuple(f.object_params), allocations=dict(f.allocations)) for f in values]
        before = inputs(frozen)
        original_init(instance, values)
        assert inputs(frozen) == before
        captured.append((frozen, state(instance), before))
    module.EscapeAnalysis.__init__ = capture
    try:
        preparation_phases.child(types.SimpleNamespace(source=str(options.source), input=str(options.input),
            shim=str(options.shim), output=str(setup), plan=str(options.plan), label='f2-structural-bound'))
    finally:
        module.EscapeAnalysis.__init__ = original_init
    assert captured and not any(n == 'numba' or n.startswith('numba.') for n in sys.modules)
    Baseline, Cached, variant_source, substitutions = cache_variant(module)
    (options.output / 'cache_scan.py').write_text(variant_source + '\n', encoding='utf-8')
    cohorts, seen = [], set()
    for functions, captured_state, serialized in captured:
        identity = state_digest(serialized)
        if identity in seen:
            continue
        seen.add(identity)
        samples = []
        for pair, order in enumerate(((('original', Baseline), ('cached', Cached)), (('cached', Cached), ('original', Baseline)))):
            for mode, cls in order:
                started = time.perf_counter_ns()
                analysis = cls(functions)
                elapsed = time.perf_counter_ns() - started
                actual = state(analysis)
                assert actual == captured_state, (identity, mode, 'full report/origins/events differ')
                assert inputs(functions) == serialized, 'FunctionIR inputs mutated'
                assert all(ast.dump(tree, include_attributes=True) == ast.dump(ast.parse(analysis.functions[name].source).body[0], include_attributes=True)
                           for name, tree in analysis.trees.items()), 'Analysis mutated immutable AST'
                samples.append(dict(pair=pair, mode=mode, constructor_ns=elapsed,
                    phases=analysis.metrics, state_sha256=state_digest(actual), exact_state_equal=True))
        pairs = [dict(pair=pair, original_ns=next(s['constructor_ns'] for s in samples if s['pair'] == pair and s['mode'] == 'original'),
                      cached_ns=next(s['constructor_ns'] for s in samples if s['pair'] == pair and s['mode'] == 'cached')) for pair in range(2)]
        for row in pairs:
            row['bounded_saving_ns'] = row['original_ns'] - row['cached_ns']
        cohorts.append(dict(function_ir_sha256=identity, functions=serialized,
            captured_state=normalize(captured_state), samples=samples, pairs=pairs))
    loaded = {}
    for name, value in list(sys.modules.items()):
        if (name == 'recompyler' or name.startswith('recompyler.')) and getattr(value, '__file__', None):
            path = Path(value.__file__).resolve()
            assert path.is_relative_to(options.source), (name, path)
            assert sha(path) == manifest[path.relative_to(options.source).as_posix()]
            loaded[name] = dict(path=str(path), sha256=sha(path))
    result = dict(schema='f2-structural-cache-bound-v1', diagnostic_only=True, headline_timing_eligible=False,
        exact_all_states_equal=True, source=str(options.source), source_manifest_sha256=sha(source_manifest),
        loaded_product_modules=loaded, input=str(options.input), input_sha256=sha(options.input),
        shim_sha256=sha(options.shim / 'pyperf.py'), plan_sha256=sha(options.plan),
        captured_constructor_calls=len(captured), unique_inputs=len(cohorts), substitutions=substitutions,
        cache_scan_sha256=sha(options.output / 'cache_scan.py'), cohorts=cohorts,
        limitations=['Compile-only warmed fixture from unchanged preparation_phases.child; no cold saved-run claim.',
            'Each constructor includes parsing and one-time structural cache construction; timers add diagnostic overhead.',
            'Only immutable ordered node lists, parent maps, and ast.unparse results are cached; fixed point/dataflow unchanged.',
            'Two alternating pairs are a bounded counterfactual measurement, not deployed or end-to-end performance.'])
    with (options.output / 'report.json').open('x', encoding='utf-8') as stream:
        json.dump(result, stream, indent=2, allow_nan=False)
        stream.write('\n')
    print(json.dumps(dict(unique_inputs=len(cohorts), pairs=[c['pairs'] for c in cohorts], exact_states_equal=True)), flush=True)


if __name__ == '__main__':
    main()
