"""Adapted from CinderX Jit/hir/refcount_insertion.cpp and instr_effects.h @ f3dc0e8.
MIT License

Copyright (c) Meta Platforms, Inc. and affiliates.

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
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

"""
from dataclasses import dataclass,field
from .refcount_effects import Effects,RefKind


@dataclass(frozen=True)
class RefState:
    kind: RefKind
    support: frozenset = frozenset()


@dataclass(frozen=True)
class RefAction:
    kind: str
    value: int


@dataclass
class RefcountPlan:
    before: dict = field(default_factory=dict)
    after: dict = field(default_factory=dict)
    edges: dict = field(default_factory=dict)
    in_states: dict = field(default_factory=dict)
    out_states: dict = field(default_factory=dict)


def _effect(operation,effects):
    effect=effects(operation) if callable(effects) else effects.get(operation.name)
    if not isinstance(effect,Effects):raise ValueError('missing instruction effects: '+operation.name)
    if len(effect.outputs)!=len(operation.results):raise ValueError('output effects do not match '+operation.name)
    operands=effect.steal+effect.retire
    if (any(type(index) is not int or not 0<=index<len(operation.arguments) for index in operands)
            or len(set(operands))!=len(operands)):
        raise ValueError('invalid stolen/retired operands')
    stolen={operation.arguments[index].id for index in effect.steal}
    if any(output.kind is RefKind.BORROWED and output.support & stolen for output in effect.outputs):
        raise ValueError('output borrows from an input stolen inside the operation')
    return effect


def _transfer(state,operation,effect):
    state=dict(state);before=[];after=[]
    for argument in operation.arguments:
        if argument.id not in state:raise ValueError('reference use without live ownership state')
    dying={operation.arguments[index].id for index in effect.steal+effect.retire}
    may_finalize=any(state[operation.arguments[index].id].kind is RefKind.OWNED for index in effect.retire)
    def promote(actions, *, arbitrary=False, stores=frozenset(), owners=frozenset()):
        for value,current in sorted(state.items()):
            if current.kind is not RefKind.BORROWED:continue
            if (current.support & (stores|owners) or
                    arbitrary and any(type(support) is str for support in current.support)):
                actions.append(RefAction('incref',value));state[value]=RefState(RefKind.OWNED)
    # Calls may mutate memory; closing any owned operand may run a destructor.
    promote(before,arbitrary=effect.arbitrary or may_finalize,stores=effect.may_store,owners=dying)
    may_finalize=any(state[operation.arguments[index].id].kind is RefKind.OWNED for index in effect.retire)
    if may_finalize:promote(before,arbitrary=True)
    for index in effect.steal:
        value=operation.arguments[index].id
        if state[value].kind is RefKind.BORROWED:before.append(RefAction('incref',value))
    for value,output in zip(operation.results,effect.outputs):
        if value.id in state:raise ValueError('live SSA owner redefined')
        state[value.id]=RefState(output.kind,output.support)
    # Borrowed results can themselves depend on operands about to be closed.
    promote(after,arbitrary=may_finalize,owners=dying)
    for index in effect.steal:state.pop(operation.arguments[index].id)
    for index in effect.retire:
        value=operation.arguments[index].id
        current=state.pop(value)
        if current.kind is RefKind.OWNED:after.append(RefAction('decref',value))
    return state,tuple(before),tuple(after)


def _liveness(graph):
    live={key:set() for key in graph.blocks}
    changed=True
    while changed:
        changed=False
        for key,block in reversed(tuple(graph.blocks.items())):
            outgoing=set()
            for edge in block.edges:
                target=graph.blocks[edge.target]
                params={value.id for value in target.parameters}
                outgoing |= live[edge.target]-params
                outgoing.update(value.id for value in edge.arguments)
            current=outgoing
            for operation in reversed(block.operations):
                current.difference_update(value.id for value in operation.results)
                current.update(value.id for value in operation.arguments)
            current.difference_update(value.id for value in block.parameters)
            if current!=live[key]:live[key]=current;changed=True
    return live


def _edge_state(state,edge,target,live):
    mapped={};actions=[];transferred=set()
    rename={value.id:param.id for value,param in zip(edge.arguments,target.parameters)}
    for value,param in zip(edge.arguments,target.parameters):
        if value.id not in state:raise ValueError('edge lacks live reference state')
        current=state[value.id]
        if current.kind is RefKind.OWNED:
            if value.id in live or value.id in transferred:actions.append(RefAction('incref',value.id))
            else:transferred.add(value.id)
        support=frozenset(rename.get(item,item) if type(item) is int else item for item in current.support)
        mapped[param.id]=RefState(current.kind,support)
    for value,current in state.items():
        if value in live:
            support=frozenset(rename.get(item,item) if type(item) is int else item for item in current.support)
            mapped[value]=RefState(current.kind,support)
        elif value not in transferred and current.kind is RefKind.OWNED:
            raise ValueError('owner crosses edge without explicit source retirement')
    return mapped,tuple(actions)


def _join(states):
    keys=set.union(*(set(state) for state in states)) if states else set()
    joined={}
    for value in keys:
        incoming=[state.get(value) for state in states]
        if any(current is None for current in incoming):raise ValueError('inconsistent live owner at CFG join')
        if any(current.kind is RefKind.OWNED for current in incoming):joined[value]=RefState(RefKind.OWNED)
        elif any(current.kind is RefKind.BORROWED for current in incoming):
            joined[value]=RefState(RefKind.BORROWED,frozenset().union(*(current.support for current in incoming)))
        else:joined[value]=RefState(RefKind.UNCOUNTED)
    return joined


def plan_refcounts(graph,effects):
    """Compute native insertion sites without changing the shared STACKREF emitter.

    Every opcode needs an explicit effects contract. Every source-owned reference
    is retained until an explicit ordered retire/steal, never merely its SSA last
    use. The consumer emits before/after actions at the original PC and edge
    actions on the selected edge (including critical edges), before phi renaming.
    Exception/suspension ownership requires a separate verified consumer contract.
    """
    if graph.exceptions or any(edge.kind in ('exception','resume') for block in graph.blocks.values() for edge in block.edges):
        raise ValueError('exception/suspension effects need an explicit ownership contract')
    if graph.blocks[graph.entry].parameters:raise ValueError('entry reference parameters need explicit owner effects')
    descriptions={(key,index):_effect(operation,effects) for key,block in graph.blocks.items() for index,operation in enumerate(block.operations)}
    live=_liveness(graph);incoming={};outgoing={};edge_states={};result=RefcountPlan()
    work=[graph.entry];iterations=0
    limit=max(100,len(graph.blocks)*(1+sum(len(block.operations) for block in graph.blocks.values()))*20)
    while work:
        iterations+=1
        if iterations>limit:raise ValueError('reference dataflow did not converge')
        key=work.pop(0);block=graph.blocks[key]
        states=[state for (source,index),state in edge_states.items() if graph.blocks[source].edges[index].target==key]
        state={} if key==graph.entry else _join(states)
        if key in incoming and incoming[key]==state:continue
        incoming[key]=state.copy()
        for index,operation in enumerate(block.operations):
            state,before,after=_transfer(state,operation,descriptions[(key,index)])
            result.before[(key,index)]=before;result.after[(key,index)]=after
        if not block.edges:
            if any(current.kind is RefKind.OWNED for current in state.values()):
                raise ValueError('source owner lacks explicit terminal retirement')
            state={}
        outgoing[key]=state.copy()
        for index,edge in enumerate(block.edges):
            mapped,actions=_edge_state(state,edge,graph.blocks[edge.target],live[edge.target])
            edge_states[(key,index)]=mapped;result.edges[(key,index)]=actions
            if edge.target not in work:work.append(edge.target)
    if set(incoming)!=set(graph.blocks):raise ValueError('unreachable reference block')
    # Reconcile borrowed/uncounted incoming references to an owned join state.
    for (source,index),state in edge_states.items():
        edge=graph.blocks[source].edges[index];target=graph.blocks[edge.target]
        reverse={param.id:value.id for value,param in zip(edge.arguments,target.parameters)}
        actions=list(result.edges[(source,index)])
        for value,current in state.items():
            if incoming[edge.target][value].kind is RefKind.OWNED and current.kind is RefKind.BORROWED:
                actions.append(RefAction('incref',reverse.get(value,value)))
        result.edges[(source,index)]=tuple(actions)
    result.in_states=incoming;result.out_states=outgoing
    return result
