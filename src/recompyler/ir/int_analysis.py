"""CFG integer facts: exact constants, frame slots and stack parameters.

No runtime measurements are premises. Unknown boxed operations are barriers.
This is an analysis, not permission to erase ownership or exception handling.
"""
from dataclasses import dataclass
from collections import deque
from types import MappingProxyType
from .intbounds import IntBound
from .verifier import verify
from .cfg_analysis import AnalysisBudget, AnalysisLimit

UNBOUND='unbound-local'
BINARY={0:'add',10:'sub',5:'mul',1:'and',7:'or',12:'xor'}
LOADS={'frame.load','frame.borrow','frame.load_check','frame.load_load','frame.borrow_borrow'}
NEUTRAL={'resume','nop','jump','null','exception_state'}
# Dropping an arbitrary object can run its finalizer and mutate frame locals.


@dataclass(frozen=True)
class IntegerFacts:
    arguments: tuple
    results: tuple
    no_overflow: bool = False


@dataclass(frozen=True)
class IntegerAnalysis:
    at: object
    incoming: object
    iterations: int
    limited: bool = False
    work: int = 0


def _merge(states):
    if not states:return None
    result=dict(states[0])
    for state in states[1:]:
        result={key:(bound.join(state[key]) if isinstance(bound,IntBound) else UNBOUND)
                for key,bound in result.items() if key in state
                and (isinstance(bound,IntBound) and isinstance(state[key],IntBound)
                     or bound==state[key]==UNBOUND)}
    return result


def analyze_intbounds(graph,*,work_limit=None):
    """O(N+E) bounded work; exhaustion produces no integer certificates."""
    verify(graph)
    budget=AnalysisBudget(graph,work_limit)
    try:return _analyze_intbounds(graph,budget)
    except AnalysisLimit:
        return IntegerAnalysis(MappingProxyType({}),MappingProxyType({}),budget.iterations,True,budget.used)


def _analyze_intbounds(graph,budget):
    """Compute a conservative fixpoint. Missing facts mean unknown, not bottom.

    Tracking locals is disabled at every potential observer, including decrefs
    of unknown objects, backedge periodic work and suspension. Exception edges
    receive no local facts; handler/trace machinery can mutate frame locals.
    """
    code=graph.code
    arguments=code.co_argcount+code.co_kwonlyargcount+bool(code.co_flags & 4)+bool(code.co_flags & 8)
    budget.charge(code.co_nlocals)
    initial={('local',n):UNBOUND for n in range(arguments,code.co_nlocals)}
    incoming={graph.entry:initial}
    outgoing={}
    revisions={}
    queue=deque([graph.entry])
    queued={graph.entry}
    records={}
    iterations=0
    while queue:
        key=queue.popleft();queued.remove(key)
        iterations+=1;budget.iterations=iterations;budget.charge()
        block=graph.blocks[key]
        budget.charge(3*len(incoming[key])+len(block.parameters))
        state=dict(incoming[key])
        values={p.id:state[('stack',n)] for n,p in enumerate(block.parameters)
                if ('stack',n) in state}
        locals_={n:bound for (kind,n),bound in state.items() if kind=='local'}
        local_records={}
        for op in block.operations:
            budget.charge(1+len(op.arguments)+len(op.results))
            args=tuple(values.get(v.id) for v in op.arguments)
            results=(None,)*len(op.results)
            no_overflow=False
            name=op.name
            arg=op.attributes.get('oparg')
            slots=op.attributes.get('slots',(arg,))
            if name=='resume' and ((arg or 0) & 3)<2:
                locals_.clear()
            elif name in ('constant','small_int'):
                value=op.attributes.get('argval')
                if type(value) is int and -(1<<63)<=value<(1<<63):
                    results=(IntBound.constant(value),)
            elif name in LOADS:
                results=tuple(b if isinstance(b,IntBound) else None for slot in slots
                              for b in (locals_.get(slot),))
            elif name=='copy':
                results=args
            elif name in ('frame.store','frame.store_load','frame.store_store'):
                stores=zip(slots,args if name!='frame.store_store' else reversed(args))
                for slot,bound in stores:
                    old=locals_.get(slot)
                    if old is None:
                        # STORE closes the old owner *after* publishing the new
                        # value; its finalizer may even overwrite that new slot.
                        locals_.clear()
                    elif bound is not None:
                        locals_[slot]=bound
                    else:
                        locals_.pop(slot,None)
                if name=='frame.store_load':
                    loaded=locals_.get(slots[1])
                    results=(loaded if isinstance(loaded,IntBound) else None,)
            elif name=='binary' and arg in BINARY and len(args)==2 and all(a is not None for a in args):
                operation=BINARY[arg]
                no_overflow=operation not in ('add','sub','mul') or args[0].cannot_overflow(operation,args[1])
                if no_overflow:results=(args[0].transfer(operation,args[1]),)
            elif name=='branch':
                # int truth / None identity cannot invoke arbitrary user code.
                if op.instruction.opname not in ('POP_JUMP_IF_NONE','POP_JUMP_IF_NOT_NONE') and not all(a is not None for a in args):
                    locals_.clear()
            elif name=='pop' and args and args[0] is not None:
                pass
            elif name not in NEUTRAL:
                locals_.clear()
            # Periodic work at backward jumps can run pending Python callbacks.
            if name=='jump' and 'BACKWARD' in op.instruction.opname:locals_.clear()
            if len(results)!=len(op.results):results=(None,)*len(op.results)
            local_records[op.offset]=IntegerFacts(args,results,no_overflow)
            for v,bound in zip(op.results,results):
                if bound is not None:values[v.id]=bound
        records[key]=local_records
        for index,edge in enumerate(block.edges):
            budget.charge(1+2*len(locals_)+len(edge.arguments))
            # Resume/exception work and iterator protocol may call Python.
            safe=edge.kind not in ('exception','resume','send_return','send_yield','next','exhausted')
            edge_state={('local',n):b for n,b in locals_.items()} if safe else {}
            if safe:
                edge_state.update((('stack',n),values[v.id]) for n,v in enumerate(edge.arguments) if v.id in values)
            edge_key=(key,index)
            if outgoing.get(edge_key)==edge_state:continue
            outgoing[edge_key]=edge_state
            target=edge.target
            old=incoming.get(target)
            budget.charge(2*len(old or {})+len(edge_state))
            # Meet historical incoming states too: lost facts never reappear.
            # This may forgo an optimization, but is a sound overapproximation.
            merged=_merge([old,edge_state]) if old is not None else dict(edge_state)
            if old is not None and revisions.get(target,0)>=2:
                budget.charge(len(merged))
                merged={k:(old[k].widen(v) if isinstance(v,IntBound) and isinstance(old[k],IntBound) else UNBOUND)
                        for k,v in merged.items() if k in old and
                        (isinstance(v,IntBound) and isinstance(old[k],IntBound) or v==old[k]==UNBOUND)}
            if merged!=old:
                incoming[target]=merged
                revisions[target]=revisions.get(target,0)+1
                if target not in queued:queue.append(target);queued.add(target)
    at={offset:fact for rows in records.values() for offset,fact in rows.items()}
    return IntegerAnalysis(MappingProxyType(at),
                           MappingProxyType({k:MappingProxyType(v) for k,v in incoming.items()}),
                           iterations,work=budget.used)


