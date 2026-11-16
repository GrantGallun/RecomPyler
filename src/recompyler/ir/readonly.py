"""Conservative SSA recognition of callback-free traversal candidates.

A plan proves only the control/data-flow shape. Runtime attribute/key guards
must prove each executed operation callback-free; entry ownership admission is
separate. Original offsets and current local state remain available on a miss.
"""
from dataclasses import dataclass
from .verifier import verify


@dataclass(frozen=True)
class ReadonlyLoop:
    kind:str
    state_slot:int
    owner_slot:int
    attribute:str
    loop_offset:int
    effect_offset:int
    initial_state_slot:int|None=None


def _symbolic(block):
    values={};assignments=[];returned=None;condition=None
    for op in block.operations:
        arguments=[values.get(value.id) for value in op.arguments]
        results=[];name=op.name
        if name in ('resume','nop','jump'):pass
        elif name in ('frame.borrow','frame.load','frame.load_check','frame.borrow_borrow','frame.load_load'):
            results=[('local',slot) for slot in op.attributes.get('slots',(op.attributes['oparg'],))]
        elif name=='load_attr' and not op.attributes.get('method'):
            results=[('attr',arguments[0],op.attributes['argval'])]
        elif name=='contains' and op.attributes['oparg']==0:
            results=[('contains',*arguments)]
        elif name=='binary' and op.attributes['oparg']==26:
            results=[('getitem',*arguments)]
        elif name=='frame.store':assignments.append((op.attributes['oparg'],arguments[0]))
        elif name=='branch':condition=(op.instruction.opname,arguments[0])
        elif name=='return':returned=arguments[0]
        else:return None
        if len(results)!=len(op.results) or any(value is None for value in arguments):return None
        values.update((value.id,result) for value,result in zip(op.results,results))
    return assignments,condition,returned


def plan_readonly_loop(graph,*,preserved_arguments=False):
    """Recognize a single readonly while traversal without using function names."""
    verify(graph)
    if graph.exceptions or graph.code.co_cellvars or graph.code.co_freevars:return None
    if len(graph.blocks)!=4:return None
    entry=graph.blocks[graph.entry]
    initial=None
    if preserved_arguments:
        if graph.code.co_nlocals!=graph.code.co_argcount+1:return None
        seed=_symbolic(entry)
        if seed is None or len(seed[0])!=1 or seed[1] is not None or seed[2] is not None:return None
        slot,value=seed[0][0]
        if slot<graph.code.co_argcount or value[0]!='local' or value[1]>=graph.code.co_argcount:return None
        initial=(slot,value[1])
    else:
        if graph.code.co_nlocals!=graph.code.co_argcount:return None
        if any(op.name not in ('resume','nop') for op in entry.operations):return None
    if len(entry.edges)!=1:return None
    header=graph.blocks[entry.edges[0].target]
    if header.parameters or len(header.edges)!=2:return None
    taken=next((edge for edge in header.edges if edge.kind=='taken'),None)
    falling=next((edge for edge in header.edges if edge.kind=='fallthrough'),None)
    if taken is None or falling is None:return None
    body=graph.blocks[falling.target];exit=graph.blocks[taken.target]
    if body is header or exit is header or body is exit:return None
    if body.parameters or exit.parameters or exit.edges:return None
    if len(body.edges)!=1 or body.edges[0].target!=header.offset:return None
    if {entry.offset,header.offset,body.offset,exit.offset}!=set(graph.blocks):return None
    h=_symbolic(header);b=_symbolic(body);e=_symbolic(exit)
    if h is None or b is None or e is None:return None
    if h[0] or h[2] is not None or b[1] is not None or b[2] is not None or len(b[0])!=1:return None
    if e[0] or e[1] is not None:return None
    state,update=b[0][0]
    if initial is not None and state!=initial[0]:return None
    initial_slot=state if initial is None else initial[1]
    if e[2]!=('local',state):return None
    condition=h[1]
    if condition is None:return None
    spelling,test=condition
    if spelling=='POP_JUMP_IF_NONE' and test and test[0]=='attr':
        if test!=update or test[1]!=('local',state):return None
        return ReadonlyLoop('attribute',state,state,test[2],header.offset,
            next(op.offset for op in header.operations if op.name=='load_attr'),initial_slot)
    if spelling=='POP_JUMP_IF_FALSE' and test and test[0]=='contains':
        key,container=test[1:]
        if key!=('local',state) or container[0]!='attr' or container[1][0]!='local':return None
        owner=container[1][1]
        if owner==state or owner>=graph.code.co_argcount or update!=('getitem',container,key):return None
        return ReadonlyLoop('mapping',state,owner,container[2],header.offset,
            next(op.offset for op in header.operations if op.name=='contains'),initial_slot)
    return None
