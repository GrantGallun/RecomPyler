"""Static proof decisions for wave21's dynamic redundancy candidates.

Counts only rank candidates. Only code-derived facts may justify removal.
The lowerer must consume a matching graph certificate at the original PC;
annotation alone does not change runtime behavior or ownership.
Digest/annotation work is linear in bytecode, constants and IR elements; the
integer fixpoint and common verification have explicit linear work limits.
"""
from dataclasses import dataclass, replace
from hashlib import sha256
import marshal
import dis
from .int_analysis import analyze_intbounds
from .ops import Block
from .verifier import verify


def graph_digest(graph):
    # Attributes relevant to integer analysis are pinned too; code digest alone
    # cannot certify an independently transformed CFG. No arbitrary repr calls.
    def value_key(v):
        t=v.type
        return (v.id,t.kind,t.exact is None,t.exact is int,t.exact is bool,
                t.maybe_unbound,v.ownership.value)
    rows=[]
    for instruction in dis.get_instructions(graph.code):
        key=instruction.offset
        if key not in graph.blocks:continue
        block=graph.blocks[key]
        operations=[]
        for op in block.operations:
            arg=op.attributes.get('oparg')
            value=op.attributes.get('argval')
            if type(value) not in (type(None),bool,int,str,bytes):value=None
            operations.append((op.name,op.offset,tuple(value_key(v) for v in op.arguments),
                               tuple(value_key(v) for v in op.results),arg,value,op.attributes.get('slots'),op.instruction.opname,op.instruction.arg))
        rows.append((key,tuple(value_key(v) for v in block.parameters),tuple(operations),
                     tuple((e.target,tuple(value_key(v) for v in e.arguments),e.kind,e.source_offset) for e in block.edges)))
    return sha256(marshal.dumps((graph.code,graph.entry,tuple(rows)))).hexdigest()


@dataclass(frozen=True)
class CheckCandidate:
    digest: str
    offset: int
    kind: str
    argument: int


@dataclass(frozen=True)
class CheckObservation(CheckCandidate):
    executed: int
    failed: int


@dataclass(frozen=True)
class CheckDecision:
    digest: str
    offset: int
    kind: str
    argument: int
    action: str
    reason: str


def _context(graph):
    verify(graph)
    return graph_digest(graph),analyze_intbounds(graph)


def _prove(row,digest,facts):
    action,reason='retain','invalid check site'
    valid=(type(row.offset) is int and row.offset>=0
           and type(row.argument) is int and row.argument>=0)
    if valid and row.digest!=digest:reason='stale graph digest'
    elif valid and facts.limited:action,reason='watcher','integer analysis work budget exceeded'
    elif valid and row.offset not in facts.at:reason='unknown source offset'
    elif valid:
        fact=facts.at[row.offset]
        proven=False
        if row.kind=='int64_overflow':proven=fact.no_overflow
        elif row.argument<len(fact.arguments):
            bound=fact.arguments[row.argument]
            if bound is not None:
                if row.kind=='exact_int':proven=True
                elif row.kind=='nonzero':proven=not bound.contains(0)
                elif row.kind=='nonnegative':proven=bound.lower>=0
        if proven:action,reason='remove','universal CFG integer proof'
        else:action,reason='watcher','no universal proof; counts are not premises'
    return CheckDecision(digest,row.offset,row.kind,row.argument,action,reason)


def prove_checks(graph,candidates):
    """Prove declared predicates without manufacturing profile observations.

    This opt-in batch performs one bounded analysis, O(N+E+C) work for C
    candidates. A remove decision covers only its named predicate at the
    matching graph/PC/argument; it grants no ownership or allocation changes.
    The backend must bind that predicate to the actual emitted guard.
    """
    digest,facts=_context(graph)
    decisions=[]
    for row in candidates:
        if type(row) is not CheckCandidate:raise TypeError('CheckCandidate required')
        decisions.append(_prove(row,digest,facts))
    return tuple(decisions)


def decide_checks(graph,observations):
    """Rank observed candidates and prove them in one bounded analysis."""
    digest,facts=_context(graph)
    decisions=[]
    for row in observations:
        action,reason='retain','invalid observation'
        if not isinstance(row,CheckObservation):raise TypeError('CheckObservation required')
        valid=(all(type(n) is int for n in (row.offset,row.argument,row.executed,row.failed))
               and row.executed>=0 and 0<=row.failed<=row.executed and row.argument>=0)
        if valid and row.digest!=digest:reason='stale graph digest'
        elif valid and row.executed==0:reason='unobserved check'
        elif valid and row.failed:action,reason='watcher','check has observed failures'
        elif valid:
            decisions.append(_prove(row,digest,facts))
            continue
        decisions.append(CheckDecision(digest,row.offset,row.kind,row.argument,action,reason))
    return tuple(decisions)


def annotate_integer_proofs(graph):
    """PassManager-compatible, opt-in analysis annotation; no opcode deletion."""
    verify(graph)
    analysis=analyze_intbounds(graph)
    digest=graph_digest(graph)
    blocks={}
    for key,block in graph.blocks.items():
        operations=[]
        for op in block.operations:
            attrs=dict(op.attributes)
            attrs.pop('integer_proof',None)
            fact=analysis.at.get(op.offset)
            if fact and (fact.no_overflow or any(b is not None for b in fact.results)):
                attrs['integer_proof']=(digest,fact)
            operations.append(replace(op,attributes=attrs))
        blocks[key]=Block(block.offset,block.parameters,operations,list(block.edges))
    result=replace(graph,blocks=blocks)
    verify(result)
    return result


def consume_counter_rows(graph,rows):
    """Consume actual line counters, or future graph-bound predicate counters.

    Line-only guards are watcher opportunities; allocation/refcount counts do
    not certify lifetime. No source line is guessed to be a bytecode predicate.
    """
    rows=tuple(rows)
    observations=[]
    positions=[]
    required={'graph_digest','offset','check_kind','argument','executed','taken'}
    for index,row in enumerate(rows):
        if type(row) is not dict:raise TypeError('counter row must be a dictionary')
        if row.get('kind')=='guard' and required<=row.keys():
            observations.append(CheckObservation(row['graph_digest'],row['offset'],row['check_kind'],
                                                row['argument'],row['executed'],row['taken']))
            positions.append(index)
    proved=decide_checks(graph,observations) if observations else ()
    digest=proved[0].digest if proved else graph_digest(graph)
    result=[CheckDecision(digest,-1,str(row.get('kind','unknown')),-1,
            'watcher','counter lacks graph/PC/predicate identity; lifetime remains unproved') for row in rows]
    for index,decision in zip(positions,proved):result[index]=decision
    return tuple(result)
