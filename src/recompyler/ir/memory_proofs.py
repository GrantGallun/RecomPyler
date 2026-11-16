"""PyPy-style heap cache and pure CSE adapted to CFG must-availability.

Plans cover raw scalar results only. No stores, owner releases or allocations
are delayed, removed or rescheduled. The backend supplies verified effects.
Adapted from PyPy optimizeopt/heap.py, pure.py and ruleopt (PyPy 8.0.1).
Copyright (c) the PyPy authors (see reference/pypy/LICENSE).
The MIT License
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
"""
from dataclasses import dataclass
from types import MappingProxyType
from collections import deque
from .types import INT64
from .ruleproof import Rule, prove
from .verifier import verify
from .cfg_analysis import AnalysisBudget, AnalysisLimit, dominator_tree
from .proof_checks import graph_digest


@dataclass(frozen=True)
class Location:
    region: str
    owner: int
    field: str

    def __post_init__(self):
        if type(self.region) is not str or type(self.field) is not str or type(self.owner) is not int:
            raise ValueError('explicit raw memory location required')


@dataclass(frozen=True)
class MemoryEffect:
    kind: str = 'barrier'
    location: Location | None = None
    stored: int | None = None
    operator: str | None = None
    inert: bool = False
    may_raise: bool = True


@dataclass(frozen=True)
class MemoryPlan:
    replacements: object
    incoming: object
    rule_digests: tuple
    iterations: int
    digest: str
    limited: bool = False
    work: int = 0


def _join(states):
    if not states:return {}
    return {k:v for k,v in states[0].items() if all(s.get(k)==v for s in states[1:])}


def _dominance(graph):
    definitions={}
    for key,b in graph.blocks.items():
        for v in b.parameters:definitions[v.id]=(key,-1)
        for n,op in enumerate(b.operations):
            for v in op.results:definitions[v.id]=(key,n)
    return definitions,dominator_tree(graph)


def _edge_transfer(graph,edge,definitions,dominators):
    """Preserve dominating snapshots; a loop phi denotes a new iteration.

    Renaming an invariant value to a changing phi loses the old snapshot. Values
    defined in or below the target need an explicit edge argument instead.
    """
    rename={v.id:p for v,p in zip(edge.arguments,graph.blocks[edge.target].parameters)}
    def transfer(value):
        source,_=definitions[value.id]
        if source!=edge.target and dominators.dominates(source,edge.target):return value
        return rename.get(value.id)
    return transfer


def plan_memory(graph,effects=None,*,work_limit=None):
    """O(N+E) bounded availability; exhaustion authorizes no replacements.

    Fixed-width rules add at most six bounded, process-cached Z3 queries.
    Effects supplied by the backend must have O(1) lookup cost.
    """
    verify(graph)
    budget=AnalysisBudget(graph,work_limit)
    try:return _plan_memory(graph,effects,budget)
    except AnalysisLimit:
        return MemoryPlan(MappingProxyType({}),MappingProxyType({}),(),budget.iterations,
                          graph_digest(graph),True,budget.used)


def _plan_memory(graph,effects,budget):
    """Compute replacement candidates; require a separate verified emitter.

    Effects are keyed by bytecode offset, or supplied by a compiler callable.
    A distinct SSA owner never proves non-aliasing: any write invalidates its
    entire region. Exceptional/resume edges discard all available expressions.
    Missing, raising, observing or finalizing operations are full barriers.
    """
    effects={} if effects is None else effects
    definitions,dominators=_dominance(graph)
    values={v.id:v for block in graph.blocks.values() for v in block.parameters}
    for block in graph.blocks.values():
        values.update((v.id,v) for op in block.operations for v in op.results)
    incoming={graph.entry:{}}
    outgoing={}
    queue=deque([graph.entry]);queued={graph.entry}
    records={};digests=set();iterations=0
    expressions={'add':'x + y','sub':'x - y','mul':'x * y',
                 'and':'x & y','or':'x | y','xor':'x ^ y'}
    while queue:
        block_id=queue.popleft();queued.remove(block_id)
        iterations+=1;budget.iterations=iterations;budget.charge()
        block=graph.blocks[block_id]
        budget.charge(2*len(incoming[block_id]))
        state=dict(incoming[block_id]);replacements={}
        heap_keys={}
        for expression in state:
            if expression[0]=='heap':heap_keys.setdefault(expression[1].region,set()).add(expression)
        for position,op in enumerate(block.operations):
            budget.charge(1+len(op.arguments)+len(op.results))
            effect=effects(op) if callable(effects) else effects.get(op.offset,MemoryEffect())
            if not isinstance(effect,MemoryEffect):raise ValueError('explicit MemoryEffect required')
            if not effect.inert or effect.may_raise:
                state.clear();heap_keys.clear();continue
            if effect.kind=='neutral':continue
            if effect.kind in ('read','write'):
                location=effect.location
                if not isinstance(location,Location) or location.owner not in {v.id for v in op.arguments}:
                    raise ValueError('memory owner must be an operation operand')
                expression=('heap',location)
                if effect.kind=='write':
                    invalidated=heap_keys.pop(location.region,())
                    budget.charge(len(invalidated))
                    for expression_to_drop in invalidated:state.pop(expression_to_drop,None)
                    stored=next((v for v in op.arguments if v.id==effect.stored),None)
                    if stored is None:raise ValueError('stored value must be an operation operand')
                    if stored.type==INT64:
                        state[expression]=stored
                        heap_keys.setdefault(location.region,set()).add(expression)
                    continue
            elif effect.kind=='pure':
                if effect.operator not in expressions or len(op.arguments)!=2:
                    state.clear();heap_keys.clear();continue
                if any(v.type!=INT64 for v in op.arguments):state.clear();heap_keys.clear();continue
                rule=prove(Rule('cse_'+effect.operator,expressions[effect.operator],expressions[effect.operator]))
                digests.add(rule.digest)
                expression=('pure',effect.operator,tuple(v.id for v in op.arguments))
            else:
                state.clear();heap_keys.clear();continue
            if len(op.results)!=1 or op.results[0].type!=INT64:
                state.clear();heap_keys.clear();continue
            previous=state.get(expression)
            if previous is not None:
                source,number=definitions[previous.id]
                if dominators.dominates(source,block_id) and (source!=block_id or number<position):
                    replacements[op.offset]=previous
                    continue
            state[expression]=op.results[0]
            if expression[0]=='heap':heap_keys.setdefault(expression[1].region,set()).add(expression)
        records[block_id]=replacements
        for index,edge in enumerate(block.edges):
            budget.charge(1+len(edge.arguments)+len(state))
            if edge.kind in ('exception','resume','send_return','send_yield','next','exhausted'):
                mapped={}
            else:
                transfer=_edge_transfer(graph,edge,definitions,dominators)
                mapped={}
                for expression,value in state.items():
                    value=transfer(value)
                    if value is None:continue
                    if expression[0]=='heap':
                        loc=expression[1]
                        owner=transfer(values[loc.owner])
                        if owner is None:continue
                        expression=('heap',Location(loc.region,owner.id,loc.field))
                    else:
                        operands=tuple(transfer(values[n]) for n in expression[2])
                        if any(v is None for v in operands):continue
                        expression=('pure',expression[1],tuple(v.id for v in operands))
                    mapped[expression]=value
            edge_key=(block_id,index)
            if outgoing.get(edge_key)==mapped:continue
            outgoing[edge_key]=mapped
            target=edge.target
            old=incoming.get(target)
            budget.charge(2*len(old or {})+len(mapped))
            merged=_join([old,mapped]) if old is not None else dict(mapped)
            if old!=merged:
                incoming[target]=merged
                if target not in queued:queue.append(target);queued.add(target)
    replacements={offset:value for rows in records.values() for offset,value in rows.items()}
    return MemoryPlan(MappingProxyType(replacements),
                      MappingProxyType({k:MappingProxyType(v) for k,v in incoming.items()}),
                      tuple(sorted(digests)),iterations,graph_digest(graph),work=budget.used)


