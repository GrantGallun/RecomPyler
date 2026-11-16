"""Audit code-derived IR check proofs; emits no timings and installs no code."""
import argparse
from dataclasses import asdict
from hashlib import sha256
import json
import marshal
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]


def audit_function(function):
    from recompyler.ir.builder import build
    from recompyler.ir.proof_checks import CheckCandidate, graph_digest, prove_checks
    from recompyler.ir.memory_proofs import plan_memory
    from recompyler.ir.virtual_proofs import plan_virtuals
    graph = build(function)
    digest = graph_digest(graph)
    candidates, sites, allocations = [], [], []
    operations = [op for block in graph.blocks.values() for op in block.operations]
    for op in operations:
        argument = (1 if op.name == 'binary' and op.attributes.get('oparg') == 26
                    else 2 if op.name == 'store_subscr' else None)
        kinds = ('exact_int', 'nonnegative', 'index_in_bounds') if argument is not None else ()
        if op.name == 'binary' and op.attributes.get('oparg') in (0, 5, 10):
            argument, kinds = 0, ('int64_overflow',)
        for kind in kinds:
            candidates.append(CheckCandidate(digest, op.offset, kind, argument))
            sites.append(dict(operation=op.name, operand_ids=[v.id for v in op.arguments]))
        if op.name in ('build_list', 'build_map', 'build_set', 'build_tuple', 'binary_slice'):
            allocations.append(dict(offset=op.offset, operation=op.name))
    decisions = [dict(asdict(decision), **site)
                 for decision, site in zip(prove_checks(graph, candidates), sites)]
    memory, virtual = plan_memory(graph), plan_virtuals(graph)
    return dict(schema=1, function=function.__qualname__,
                code_sha256=sha256(marshal.dumps(function.__code__)).hexdigest(),
                graph_digest=digest, blocks=len(graph.blocks), operations=len(operations),
                decisions=decisions, allocation_sites=allocations,
                heap=dict(replacements=len(memory.replacements), limited=memory.limited),
                virtual=dict(removable=list(virtual.removable), limited=virtual.limited),
                installed=0, graph_transformed=False,
                scope='Static predicates only; emitted guards require matching backend binding. '
                      'Index proofs grant no container bounds/type or lifetime permission.')


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('program', help='name in the frozen shared program manifest')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args(argv)
    sys.path[:0] = [str(ROOT), str(ROOT / 'src')]
    from bench.libs.programs import manifest
    programs = manifest()
    if args.program not in programs:
        parser.error('unknown program: ' + args.program)
    report = audit_function(programs[args.program].prepare())
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
