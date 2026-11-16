"""Verifier dominance agrees with a small reference, including irreducible CFGs."""
from types import SimpleNamespace
import random
import pytest
from recompyler.ir import build
from recompyler.ir import verifier


def reference(edges,entry):
    nodes=set(edges);result={node:({entry} if node==entry else set(nodes)) for node in nodes}
    changed=True
    while changed:
        changed=False
        for node in nodes-{entry}:
            parents=[p for p,targets in edges.items() if node in targets]
            value={node}|set.intersection(*(result[p] for p in parents))
            if value!=result[node]:result[node]=value;changed=True
    return result


def intervals(edges,entry=0):
    helper=getattr(verifier,'_dominance_intervals',None)
    if helper is None:pytest.fail('indexed dominance intervals are missing')
    return helper({node:SimpleNamespace(edges=[SimpleNamespace(target=target) for target in targets])
                   for node,targets in edges.items()},entry)


def test_indexed_dominance_matches_reference_for_seeded_arbitrary_graphs():
    rng=random.Random(1699)
    for size in range(2,65):
        edges={node:set() for node in range(size)}
        for node in range(1,size):edges[rng.randrange(node)].add(node)
        for _ in range(size*3):edges[rng.randrange(size)].add(rng.randrange(size))
        labels=list(range(size));rng.shuffle(labels)
        edges={labels[node]:{labels[target] for target in targets} for node,targets in edges.items()}
        spans=intervals(edges,labels[0]);expected=reference(edges,labels[0])
        for node in edges:
            actual={owner for owner in edges if spans[owner][0]<=spans[node][0]<spans[owner][1]}
            assert actual==expected[node],(edges,node,actual,expected[node])


@pytest.mark.parametrize('edges',[
    {0:{1,2},1:{3},2:{3},3:{4},4:set()},
    {0:{1,2},1:{3},2:{3},3:{1,2,4},4:{3}},
    {0:{0}},
])
def test_diamond_irreducible_and_root_self_loop_dominance(edges):
    spans=intervals(edges);expected=reference(edges,0)
    for node in edges:
        assert {owner for owner in edges if spans[owner][0]<=spans[node][0]<spans[owner][1]}==expected[node]


def test_deep_dominance_uses_no_python_recursion():
    size=4000;edges={node:{node+1} if node+1<size else set() for node in range(size)}
    spans=intervals(edges)
    assert len(spans)==size
    assert spans[0][0]<=spans[size-1][0]<spans[0][1]
    assert not spans[size-1][0]<=spans[0][0]<spans[size-1][1]


def test_public_verification_does_not_rescan_global_predecessors(monkeypatch):
    def source(value,flag):
        while value:
            if flag:value-=1
            else:value-=2
        return value
    graph=build(source)
    monkeypatch.setattr(graph,'predecessors',lambda target:pytest.fail('global predecessor scan'))
    verifier.verify(graph)


def test_unreachable_graph_is_still_refused():
    from dataclasses import replace
    def source(value,flag):
        if flag:return value
        return value+1
    graph=build(source)
    # Keep two branch successors but redirect both to the same arm.
    entry=graph.blocks[graph.entry]
    entry.edges[0]=replace(entry.edges[0],target=entry.edges[1].target,arguments=entry.edges[1].arguments)
    with pytest.raises(verifier.VerificationError,match='unreachable'):verifier.verify(graph)
