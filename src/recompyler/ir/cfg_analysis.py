"""CFG dominators and explicit linear work budgets.

For V blocks, E edges and N IR elements, storage is O(N+V+E). Dominator
iteration is capped at64*(N+V+E) work units; exceeding it declines compilation
instead of returning a partial tree. Euler intervals answer dominance in O(1).
"""
from dataclasses import dataclass
from types import MappingProxyType
from .semantics import UnsupportedBytecode


class AnalysisLimit(UnsupportedBytecode):
    pass


class AnalysisBudget:
    def __init__(self,graph,limit=None):
        units=getattr(getattr(graph,'code',None),'co_nlocals',0)
        for block in graph.blocks.values():
            units+=1+len(block.parameters)
            units+=sum(1+len(op.arguments)+len(op.results) for op in block.operations)
            units+=sum(1+len(edge.arguments) for edge in block.edges)
        if limit is None:limit=64*max(1,units)
        if type(limit) is not int or limit<=0:raise ValueError('positive analysis work limit required')
        self.limit=limit;self.used=0;self.iterations=0

    def charge(self,amount=1):
        if self.used+amount>self.limit:raise AnalysisLimit('CFG analysis work budget exceeded')
        self.used+=amount


@dataclass(frozen=True)
class DominatorTree:
    starts: object
    ends: object
    work: int
    work_limit: int
    iterations: int

    def dominates(self,source,target):
        return self.starts[source]<=self.starts[target] and self.ends[target]<=self.ends[source]


def dominator_tree(graph,*,work_limit=None):
    """Compute exact immediate dominators with a bounded predecessor walk."""
    blocks=graph.blocks;entry=graph.entry
    if entry not in blocks:raise ValueError('missing entry block')
    if work_limit is not None and (type(work_limit) is not int or work_limit<=0):
        raise ValueError('positive analysis work limit required')
    if len(blocks)==1:
        if any(edge.target!=entry for edge in blocks[entry].edges):raise ValueError('missing edge target')
        return DominatorTree(MappingProxyType({entry:0}),MappingProxyType({entry:1}),0,work_limit or 64,0)
    budget=AnalysisBudget(graph,work_limit)
    predecessors={key:[] for key in blocks}
    for key,block in blocks.items():
        for edge in block.edges:
            if edge.target not in blocks:raise ValueError('missing edge target')
            predecessors[edge.target].append(key)
    seen={entry};postorder=[];pending=[(entry,iter(blocks[entry].edges))]
    while pending:
        key,edges=pending[-1]
        edge=next(edges,None)
        if edge is None:
            postorder.append(key);pending.pop()
        elif edge.target not in seen:
            seen.add(edge.target);pending.append((edge.target,iter(blocks[edge.target].edges)))
    if seen!=set(blocks):raise ValueError('unreachable blocks in IR')
    order=list(reversed(postorder));rank={key:n for n,key in enumerate(order)}
    parents={entry:entry};changed=True
    while changed:
        changed=False;budget.iterations+=1
        for key in order[1:]:
            budget.charge();parent=None
            for predecessor in predecessors[key]:
                budget.charge()
                if predecessor not in parents:continue
                if parent is None:parent=predecessor;continue
                left,right=parent,predecessor
                while left!=right:
                    budget.charge()
                    if rank[left]>rank[right]:left=parents[left]
                    else:right=parents[right]
                parent=left
            if parent is not None and parents.get(key)!=parent:
                parents[key]=parent;changed=True
    children={key:[] for key in blocks}
    for key,parent in parents.items():
        if key!=entry:children[parent].append(key)
    starts={};ends={};clock=0;pending=[(entry,False)]
    while pending:
        key,finished=pending.pop()
        if finished:ends[key]=clock;clock+=1
        else:
            starts[key]=clock;clock+=1;pending.append((key,True))
            pending.extend((child,False) for child in reversed(children[key]))
    return DominatorTree(MappingProxyType(starts),MappingProxyType(ends),budget.used,budget.limit,budget.iterations)
