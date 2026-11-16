"""Conservative PyPy-style virtual records for backend-private raw storage.

Python allocations are never assumed invisible: their GC, weakref, finalizer,
frame and traceback behavior is observable. Escape/materialization candidates
are reported to the backend; only all-path private records can be removed.
Adapted from PyPy optimizeopt/virtualize.py (PyPy 8.0.1).
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
import dis
from collections import deque
from types import MappingProxyType
from .types import INT64, ValueType
from .verifier import verify
from .cfg_analysis import AnalysisBudget, AnalysisLimit
from .proof_checks import graph_digest
from .memory_proofs import _dominance, _edge_transfer

RAW_RECORD=ValueType('virtual-record')


@dataclass(frozen=True)
class VirtualEffect:
    kind: str = 'barrier'
    fields: tuple = ()
    field: str | None = None
    invisible: bool = False
    inert: bool = False


@dataclass(frozen=True)
class Recipe:
    origin: int
    fields: tuple


@dataclass(frozen=True)
class VirtualPlan:
    removable: tuple
    replacements: object
    rejected: object
    iterations: int
    digest: str
    limited: bool = False
    work: int = 0


def plan_virtuals(graph,effects=None,*,work_limit=None):
    """O(N+E) bounded escape work; exhaustion retains every allocation.

    Recipe fields and aliases count toward the budget. Incompatible histories
    remain rejected; no optimistic partial recipe escapes the analysis.
    """
    verify(graph)
    budget=AnalysisBudget(graph,work_limit)
    try:return _plan_virtuals(graph,effects,budget)
    except AnalysisLimit:
        return VirtualPlan((),MappingProxyType({}),MappingProxyType({}),budget.iterations,
                           graph_digest(graph),True,budget.used)


def _plan_virtuals(graph,effects,budget):
    """All-or-nothing escape analysis; uncertain joins retain allocation.

    An alloc effect certifies backend-private, non-GC, non-raising storage
    whose creation/release has no Python lifetime/identity observation. Fields
    are raw scalars. No such certificate is inferred for Python containers.
    Partial first-escape materialization and field phi insertion stay explicit
    future backend work; no Python store or release is moved by this planner.
    """
    effects={} if effects is None else effects
    definitions,dominators=_dominance(graph)
    incoming={graph.entry:{}};outgoing={}
    pending=deque([graph.entry]);queued={graph.entry}
    allocations=set();rejected={};records={};iterations=0
    def reject(state,reason):
        budget.charge(len(state))
        for recipe in state.values():rejected.setdefault(recipe.origin,reason)
    while pending:
        key=pending.popleft();queued.remove(key);iterations+=1
        budget.iterations=iterations;budget.charge()
        budget.charge(2*len(incoming[key]))
        block=graph.blocks[key];state=dict(incoming[key]);local={};aliases={}
        for value,recipe in state.items():aliases.setdefault(recipe.origin,set()).add(value)
        for op in block.operations:
            budget.charge(1+len(op.arguments)+len(op.results))
            effect=effects(op) if callable(effects) else effects.get(op.offset,VirtualEffect())
            if not isinstance(effect,VirtualEffect):raise ValueError('explicit VirtualEffect required')
            if not effect.inert:
                reject(state,'observer, error or lifetime barrier');state.clear();aliases.clear();continue
            if effect.kind=='neutral':
                if any(v.type==RAW_RECORD for v in op.arguments):
                    reject(state,'unmodelled record use');state.clear();aliases.clear()
                continue
            if effect.kind=='alloc':
                valid=(effect.invisible and len(op.results)==1 and op.results[0].type==RAW_RECORD
                       and type(effect.fields) is tuple and len(effect.fields)==len(op.arguments)
                       and all(type(f) is str for f in effect.fields)
                       and len(set(effect.fields))==len(effect.fields)
                       and all(v.type==INT64 for v in op.arguments))
                if not valid:
                    reject(state,'uncertified allocation');state.clear();aliases.clear();continue
                if op.results[0].id in state:reject(state,'allocation live across its own backedge')
                allocations.add(op.offset)
                state[op.results[0].id]=Recipe(op.offset,tuple(zip(effect.fields,op.arguments)))
                aliases.setdefault(op.offset,set()).add(op.results[0].id)
            elif effect.kind in ('read','write','release'):
                if not op.arguments:raise ValueError('virtual owner operand required')
                recipe=state.get(op.arguments[0].id)
                if recipe is None:
                    reject(state,'unknown virtual alias');state.clear();aliases.clear();continue
                if effect.kind!='release':budget.charge(len(recipe.fields))
                fields={} if effect.kind=='release' else dict(recipe.fields)
                if effect.kind=='release':
                    members=aliases.pop(recipe.origin,())
                    budget.charge(len(members))
                    for member in members:state.pop(member,None)
                elif effect.field not in fields:
                    reject(state,'unknown or uninitialized field');state.clear();aliases.clear()
                elif effect.kind=='read':
                    if len(op.results)!=1 or op.results[0].type!=INT64:
                        reject(state,'non-scalar virtual read');state.clear();aliases.clear()
                    else:local[op.offset]=(recipe.origin,fields[effect.field])
                else:
                    if len(op.arguments)!=2 or op.arguments[1].type!=INT64:
                        reject(state,'non-scalar virtual store');state.clear();aliases.clear()
                    else:
                        fields[effect.field]=op.arguments[1]
                        updated=Recipe(recipe.origin,tuple(fields.items()))
                        members=aliases[recipe.origin]
                        budget.charge(len(members))
                        for member in members:state[member]=updated
            else:
                reject(state,'unknown effect');state.clear();aliases.clear()
        records[key]=local
        if not block.edges:reject(state,'record remains live at terminal')
        for n,edge in enumerate(block.edges):
            budget.charge(1+len(edge.arguments)+len(state))
            mapped={}
            if edge.kind not in ('normal','jump','taken','fallthrough'):
                reject(state,'exception or suspension escape')
            else:
                rename={v.id:p for v,p in zip(edge.arguments,graph.blocks[edge.target].parameters)}
                transfer=_edge_transfer(graph,edge,definitions,dominators)
                for value,recipe in state.items():
                    budget.charge(len(recipe.fields))
                    fields=tuple((f,transfer(v)) for f,v in recipe.fields)
                    if any(v is None for f,v in fields):
                        rejected.setdefault(recipe.origin,'field snapshot unavailable at CFG edge')
                        continue
                    mapped[rename[value].id if value in rename else value]=Recipe(recipe.origin,fields)
            edge_key=(key,n)
            if outgoing.get(edge_key)==mapped:continue
            outgoing[edge_key]=mapped
            target=edge.target
            old=incoming.get(target)
            budget.charge(2*len(old or {})+len(mapped))
            for recipe in (old or {}).values():budget.charge(len(recipe.fields))
            if old is None:merged=dict(mapped)
            else:
                merged={k:v for k,v in old.items() if mapped.get(k)==v}
                for history in (old,mapped):
                    reject({k:v for k,v in history.items() if merged.get(k)!=v},'incompatible CFG join')
            if old!=merged:
                incoming[target]=merged
                if target not in queued:pending.append(target);queued.add(target)
    removable=tuple(i.offset for i in dis.get_instructions(graph.code) if i.offset in allocations and i.offset not in rejected)
    replacements={offset:v for local in records.values() for offset,(origin,v) in local.items() if origin in removable}
    return VirtualPlan(removable,MappingProxyType(replacements),MappingProxyType(rejected),iterations,graph_digest(graph),work=budget.used)


