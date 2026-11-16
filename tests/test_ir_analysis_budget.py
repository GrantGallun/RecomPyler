"""CFG analysis correctness and deterministic work budgets, never timing gates."""
from dataclasses import replace
from random import Random
from types import SimpleNamespace
import pytest
from recompyler.ir.ops import Block,Edge,Value
from recompyler.ir.builder import build
from recompyler.ir.verifier import verify,VerificationError
from recompyler.ir.cfg_analysis import dominator_tree,AnalysisBudget,AnalysisLimit
from recompyler.ir.int_analysis import analyze_intbounds
from recompyler.ir.memory_proofs import plan_memory
from recompyler.ir.virtual_proofs import plan_virtuals
from test_ir_memory_proofs import linear,read
from test_ir_virtual_proofs import virtual_case


def digraph(adjacency,reverse=False):
    keys=list(adjacency)
    if reverse:keys.reverse()
    return SimpleNamespace(entry=0,blocks={k:Block(k,(),[],[Edge(v,()) for v in adjacency[k]]) for k in keys})


def oracle(graph):
    nodes=set(graph.blocks);dom={k:({k} if k==0 else set(nodes)) for k in nodes}
    changed=True
    while changed:
        changed=False
        for k in nodes-{0}:
            predecessors=[b.offset for b in graph.blocks.values() for e in b.edges if e.target==k]
            new={k}|set.intersection(*(dom[p] for p in predecessors))
            if new!=dom[k]:dom[k]=new;changed=True
    return dom


def test_dominator_tree_matches_independent_set_oracle_on_cycles_and_order():
    rng=Random(2299)
    for n in range(2,20):
        for _ in range(12):
            adjacency={k:([k+1] if k+1<n else []) for k in range(n)}
            for k in range(n):adjacency[k]+=[v for v in range(n) if rng.random()<.1]
            graph=digraph(adjacency,reverse=bool(rng.randrange(2)))
            expected=oracle(graph);tree=dominator_tree(graph)
            assert all(tree.dominates(a,b)==(a in expected[b]) for a in range(n) for b in range(n))
            assert tree.work<=tree.work_limit


def test_irreducible_loop_and_duplicate_edges_have_exact_dominance():
    graph=digraph({0:[1,2,2],1:[3],2:[3],3:[1,2,4],4:[]},True)
    tree=dominator_tree(graph)
    for key,dominators in oracle(graph).items():
        assert {v for v in graph.blocks if tree.dominates(v,key)}==dominators


def test_dominator_budget_never_returns_partial_tree():
    with pytest.raises(AnalysisLimit):dominator_tree(digraph({0:[1,2],1:[3],2:[3],3:[]}),work_limit=1)


def test_invalid_work_limits_are_rejected():
    graph=digraph({0:[1],1:[]})
    for value in (0,-1,True,1.5):
        with pytest.raises(ValueError):dominator_tree(graph,work_limit=value)


def test_budget_exhaustion_returns_no_integer_certificate():
    def target(flag):return (12 if flag is None else 30)+1
    graph=build(target)
    analysis=analyze_intbounds(graph,work_limit=1)
    assert analysis.limited and not analysis.at and not analysis.incoming
    assert analysis.work<=1
    assert analyze_intbounds(graph).at


def test_budget_exhaustion_returns_no_memory_replacements():
    graph,effects,ops=linear(['seed','load','load'],{1:read(),2:read()})
    limited=plan_memory(graph,effects,work_limit=1)
    assert limited.limited and not limited.replacements and not limited.incoming
    assert limited.work<=1
    assert plan_memory(graph,effects).replacements


def test_budget_exhaustion_returns_no_virtual_removals():
    graph,effects,ops,get=virtual_case()
    limited=plan_virtuals(graph,effects,work_limit=1)
    assert limited.limited and not limited.removable and not limited.replacements
    assert limited.work<=1
    assert plan_virtuals(graph,effects).removable


def test_analysis_work_is_explicitly_bounded_on_branchy_cfg():
    source='def target(x):\n'+''.join('    if x: x=x+1\n' for _ in range(48))+'    return x\n'
    namespace={};exec(source,namespace);graph=build(namespace['target'])
    for analyze in (analyze_intbounds,plan_memory,plan_virtuals):
        result=analyze(graph)
        assert not result.limited
        assert result.work<=AnalysisBudget(graph).limit
        assert result.iterations<=result.work


def test_shared_verifier_still_rejects_undefined_ssa_uses():
    def target(x):return x+1
    graph=build(target)
    block=next(b for b in graph.blocks.values() if any(o.arguments for o in b.operations))
    index=next(n for n,o in enumerate(block.operations) if o.arguments)
    op=block.operations[index]
    block.operations[index]=replace(op,arguments=(replace(op.arguments[0],id=100000),)+op.arguments[1:])
    with pytest.raises(VerificationError,match='undefined'):verify(graph)
