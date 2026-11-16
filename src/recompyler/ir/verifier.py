"""Structural/SSA checks in linear element work plus bounded dominance.

Exception sources are indexed once; no per-edge operation/predecessor scans.
"""
import dis
from .semantics import UnsupportedBytecode
from .cfg_analysis import dominator_tree

class VerificationError(ValueError):
    pass



def _dominance_intervals(blocks,entry):
    """Indexed Lengauer-Tarjan dominators, then half-open tree intervals.

    DFS/link-eval uses only linear storage and no Python recursion. Simple
    link with path compression takes O((V+E) log V); queries are O(1).
    The caller has already checked edge destinations. Exceptional/resume
    edges participate exactly like normal edges, as in the old fixedpoint.
    """
    successors={key:tuple(edge.target for edge in block.edges) for key,block in blocks.items()}
    vertices=[None,entry];number={entry:1};parent=[0,0]
    work=[(entry,iter(successors[entry]))]
    while work:
        node,targets=work[-1]
        try:target=next(targets)
        except StopIteration:work.pop();continue
        if target in number:continue
        number[target]=len(vertices);vertices.append(target);parent.append(number[node])
        work.append((target,iter(successors[target])))
    if len(number)!=len(blocks):raise VerificationError('unreachable blocks in IR')
    count=len(number);predecessors=[[] for _ in vertices]
    for node,targets in successors.items():
        for target in targets:predecessors[number[target]].append(number[node])
    semi=list(range(count+1));label=list(range(count+1))
    ancestor=[0]*(count+1);immediate=[0]*(count+1);buckets=[[] for _ in vertices]
    def evaluate(node):
        original=node;path=[]
        while ancestor[node] and ancestor[ancestor[node]]:
            path.append(node);node=ancestor[node]
        for node in reversed(path):
            previous=ancestor[node]
            if semi[label[previous]]<semi[label[node]]:label[node]=label[previous]
            ancestor[node]=ancestor[previous]
        return label[original]
    for node in range(count,1,-1):
        for previous in predecessors[node]:semi[node]=min(semi[node],semi[evaluate(previous)])
        buckets[semi[node]].append(node)
        ancestor[node]=parent[node]
        for pending in buckets[parent[node]]:
            candidate=evaluate(pending)
            immediate[pending]=candidate if semi[candidate]<semi[pending] else parent[node]
        buckets[parent[node]].clear()
    for node in range(2,count+1):
        if immediate[node]!=semi[node]:immediate[node]=immediate[immediate[node]]
    children=[[] for _ in vertices]
    for node in range(2,count+1):children[immediate[node]].append(node)
    starts=[0]*(count+1);ends=[0]*(count+1);clock=0
    work=[(1,False)]
    while work:
        node,leaving=work.pop()
        if leaving:ends[node]=clock;continue
        starts[node]=clock;clock+=1;work.append((node,True))
        work.extend((child,False) for child in reversed(children[node]))
    return {vertices[node]:(starts[node],ends[node]) for node in range(1,count+1)}


def verify(graph):
    def require(condition,message):
        if not condition: raise VerificationError(message)
    blocks=graph.blocks
    require(graph.entry in blocks,'missing entry block')
    require(not blocks[graph.entry].parameters,'entry operand stack must be empty')
    definitions={}
    exceptional_definitions={}
    resumed_definitions={}
    instructions=tuple(dis.get_instructions(graph.code,adaptive=False))
    offsets={i.offset for i in instructions}
    positions={}
    handlers={}
    following={op.offset:instructions[n+1].offset for n,op in enumerate(instructions[:-1])}
    for key,block in blocks.items():
        require(key==block.offset and key in offsets,'invalid block offset')
        require(bool(block.operations),'empty block')
        for position,values in [(-1,block.parameters)]+[(n,op.results) for n,op in enumerate(block.operations)]:
            for value in values:
                require(value.id not in definitions,f'duplicate SSA definition {value.id}')
                definitions[value.id]=(key,position,value)
        positions[key]={};handlers[key]={}
        for number,op in enumerate(block.operations):
            if op.name!='exception_state':positions[key].setdefault(op.offset,number)
            if op.handler is not None:handlers[key].setdefault(op.offset,op.handler)
            if op.name in ('generator.start','yield'):
                for value in op.results:resumed_definitions[value.id]=op.offset
            if op.name=='exception_state':
                for value in op.results: exceptional_definitions[value.id]=op.offset
            require(op.block==key and op.offset in offsets,'operation source offset/block mismatch')
            require(op.instruction.offset==op.offset,'instruction source offset mismatch')
        for edge in block.edges:
            require(edge.target in blocks,f'edge targets missing block {edge.target}')
            require(len(edge.arguments)==len(blocks[edge.target].parameters),
                    f'edge stack argument depth differs at {key}->{edge.target}')
        normal=[e for e in block.edges if e.kind!='exception']
        semantic=[op for op in block.operations if op.name!='exception_state'][-1]
        expected=0 if semantic.name in ('return','raise','reraise') else 2 if semantic.name in ('branch','for_iter','send') else 1
        require(len(normal)==expected,f'block {key} terminator requires {expected} normal edges')
        if semantic.name=='send':
            require({edge.kind for edge in normal}=={'send_return','send_yield'},'SEND requires return/yield edges')
            require(all(edge.target==(semantic.instruction.jump_target if edge.kind=='send_return' else following[semantic.offset])
                        for edge in normal),'SEND must retain its original successors')
        if semantic.name in ('generator.start','yield'):
            require(len(normal)==1 and normal[0].kind=='resume', 'suspension requires one resume edge')
            require(normal[0].source_offset==semantic.offset and normal[0].target==following.get(semantic.offset),
                    'resume edge must reach the original continuation')
        else:
            require(all(edge.kind!='resume' for edge in normal),'resume edge requires a suspension operation')
    dominance=_dominance_intervals(blocks,graph.entry)
    def use(value,key,position):
        require(value.id in definitions,f'undefined SSA value {value.id}')
        owner,number,original=definitions[value.id]
        require(original==value,f'inconsistent SSA value {value.id}')
        require(dominance[owner][0]<=dominance[key][0]<dominance[owner][1],
                f'SSA value {value.id} definition does not dominate use')
        require(owner!=key or number<position,f'SSA value {value.id} used before definition')
    for key,block in blocks.items():
        for number,op in enumerate(block.operations):
            for value in op.arguments:
                require(value.id not in exceptional_definitions,'exception-only value used on normal path')
                require(value.id not in resumed_definitions,'resume-only value used before suspension continuation')
                use(value,key,number)
        for edge in block.edges:
            for value,param in zip(edge.arguments,blocks[edge.target].parameters):
                if value.id in resumed_definitions:
                    require(edge.kind=='resume' and edge.source_offset==resumed_definitions[value.id],
                            'resume-only value used on a different suspension edge')
                if value.id in exceptional_definitions:
                    require(edge.kind=='exception' and edge.source_offset==exceptional_definitions[value.id],
                            'exception-only value used on a different edge')
                position=len(block.operations)
                if edge.kind=='exception' and value.id not in exceptional_definitions:
                    position=positions[key].get(edge.source_offset,position)
                use(value,key,position)
                from .types import join_types
                require(join_types(value.type,param.type)==param.type,
                        f'incompatible stack parameter type at {key}->{edge.target}')
            if edge.kind=='exception':
                handler=handlers[key].get(edge.source_offset)
                require(handler is not None,'exception edge lacks handler operation')
                require(edge.target==handler.target and len(edge.arguments)==handler.depth+1+handler.lasti,
                        'exception handler stack depth/lasti mismatch')
    return None
