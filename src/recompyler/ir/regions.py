"""Bounded bytecode regions and exact stack contracts for optional T2 chunking.

Planning is not admission or installation. Every cross-region word remains a
CPython stackref, including its ownership tag, until a separate proof says so.
"""
from dataclasses import dataclass
import dis
import inspect
import heapq
from .builder import build,UnsupportedBytecode
from .ops import FunctionIR,Value


@dataclass(frozen=True)
class Region:
    entry: int
    offsets: tuple[int,...]
    bytecodes: tuple[int,...]
    entry_stack: tuple[Value,...]


@dataclass(frozen=True)
class Transfer:
    source: int
    target: int
    kind: str
    arguments: tuple[Value,...]
    parameters: tuple[Value,...]


@dataclass(frozen=True)
class Partition:
    graph: FunctionIR
    regions: tuple[Region,...]
    transfers: tuple[Transfer,...]
    max_bytecodes: int


def partition(function,*,max_bytecodes=128):
    """Split at original PCs without running the source or modifying its code.

    Additional bytecode leaders bound long straight-line source. Small blocks
    coalesce only while every nonentry predecessor stays within the region.
    Coalescing is O((blocks+edges) log blocks), with each edge visited once.
    Existing builder/verifier costs are not claimed to be linear here.
    """
    if type(max_bytecodes) is not int or max_bytecodes<1:
        raise ValueError('max_bytecodes must be a positive integer')
    if not inspect.isfunction(function):raise TypeError('region planner requires a Python function')
    code=function.__code__
    if code.co_exceptiontable or code.co_flags & (inspect.CO_GENERATOR|inspect.CO_COROUTINE|inspect.CO_ASYNC_GENERATOR):
        raise UnsupportedBytecode('protected or suspended region entry requires a separate proof')
    instructions=tuple(dis.get_instructions(code))
    graph=build(function,block_starts=tuple(op.offset for op in instructions[::max_bytecodes]))
    # Each edge is visited once; heap ordering makes selection deterministic.
    predecessors={offset:set() for offset in graph.blocks}
    successors={offset:{edge.target for edge in block.edges} for offset,block in graph.blocks.items()}
    for offset,targets in successors.items():
        for target in targets:predecessors[target].add(offset)
    offsets=sorted(graph.blocks);assigned={};regions=[];cursor=0
    bytecodes={offset:tuple(dict.fromkeys(op.offset for op in block.operations)) for offset,block in graph.blocks.items()}
    while len(assigned)<len(offsets):
        while offsets[cursor] in assigned:cursor+=1
        entry=offsets[cursor];ready=[entry];counts={};selected=[];size=0
        while ready:
            offset=heapq.heappop(ready)
            if offset in assigned or size+len(bytecodes[offset])>max_bytecodes:continue
            if offset!=entry and graph.blocks[offset].operations[0].name=='resume':continue
            assigned[offset]=entry;selected.append(offset);size+=len(bytecodes[offset])
            for target in successors[offset]:
                if target in assigned:continue
                counts[target]=counts.get(target,0)+1
                if counts[target]==len(predecessors[target]):heapq.heappush(ready,target)
        selected.sort()
        regions.append(Region(entry,tuple(selected),tuple(pc for offset in selected for pc in bytecodes[offset]),graph.blocks[entry].parameters))
    transfers=tuple(Transfer(offset,edge.target,edge.kind,edge.arguments,graph.blocks[edge.target].parameters)
                    for offset,block in graph.blocks.items() for edge in block.edges if assigned[offset]!=assigned[edge.target])
    assert all(0<len(region.bytecodes)<=max_bytecodes for region in regions)
    assert all(transfer.target==assigned[transfer.target] for transfer in transfers)
    return Partition(graph,tuple(regions),transfers,max_bytecodes)


@dataclass(frozen=True,init=False)
class _RegionContext:
    """Private validated graph shared only by one synchronous lowering call.

    The graph stays local to lower_partition; no source callbacks execute while
    its children are emitted. Public/arbitrary graph lowering still verifies.
    """
    graph: FunctionIR
    regions: tuple[Region,...]
    members: frozenset[Region]
    targets: object

    def __init__(self,plan):
        from types import MappingProxyType
        from .verifier import verify
        verify(plan.graph)
        resume=next(op.offset for op in dis.get_instructions(plan.graph.code) if op.opname=='RESUME')
        selected=tuple(region for region in plan.regions if region.entry>=resume)
        indices=MappingProxyType({region.entry:index for index,region in enumerate(selected)})
        if resume not in indices or any(transfer.target not in indices for transfer in plan.transfers if transfer.source>=resume):
            raise UnsupportedBytecode('region transfer targets a prelude outside the compiled scope')
        object.__setattr__(self,'graph',plan.graph)
        object.__setattr__(self,'regions',selected)
        object.__setattr__(self,'members',frozenset(selected))
        object.__setattr__(self,'targets',indices)


def lower_partition(function,*,max_bytecodes=128,workers=0):
    """Compile bounded regions with one final pointer-table relocation pass.

    Normal source edges use verified musttail transfers. Observer, deopt, error
    and RETURN_VALUE paths return to CPython through the existing shared exit.
    workers=0 keeps the serial reference; 1 or 2 emits objects in spawned
    below-normal workers and links only the completed set in this process.
    This explicit API does not establish admission or install any native body.
    """
    if type(workers) is not int or not 0<=workers<=2:
        raise ValueError('workers must be 0, 1 or 2')
    import ctypes
    from llvmlite import binding,ir
    from .lower_llvm import lower,_finish,_link_emitted
    from .symbols import CPythonSymbols
    from .. import _source_frames_native as provider
    plan=partition(function,max_bytecodes=max_bytecodes);graph=plan.graph;code=graph.code
    resume=next(op.offset for op in dis.get_instructions(code) if op.opname=='RESUME')
    context=_RegionContext(plan);selected=context.regions;indices=context.targets
    owners=[lower(graph,frame_entry=True,entry_offset=region.entry,_region=region,
                  _region_targets=indices,_region_context=context,refcounts=False,_emit_only=bool(workers))
            for region in selected]
    if workers:
        from .region_workers import request,compile_objects
        objects=compile_objects(tuple(request(owner.module) for owner in owners),workers=workers)
        if len(objects)!=len(owners):raise ValueError('incomplete region object set')
        owners=[_link_emitted(owner,obj) for owner,obj in zip(owners,objects)]
    # Bodies only load this table at execution. Populate all holes before the
    # parent can become callable, and retain the table with every child engine.
    table=(ctypes.c_uint64*len(owners))(*(owner.body_address for owner in owners))
    layout=provider.layout();module=ir.Module(name='bounded_frame_dispatch')
    module.triple=binding.get_process_triple();symbols=CPythonSymbols()
    pointer=ir.IntType(8).as_pointer();word=ir.IntType(64)
    number=lambda value:ir.Constant(word,value)
    body=ir.Function(module,ir.FunctionType(pointer,[pointer,word.as_pointer(),pointer]),'body')
    frame,stack,thread=body.args;builder=ir.IRBuilder(body.append_basic_block('entry'))
    signature=ir.FunctionType(pointer,[pointer,word.as_pointer(),pointer,word.as_pointer()])
    target=builder.inttoptr(number(owners[indices[resume]].body_address),signature.as_pointer())
    result=builder.call(target,[frame,stack,thread,number(ctypes.addressof(table)).inttoptr(word.as_pointer())])
    builder.ret(result)
    return _finish(graph,module,None,symbols,frame_entry=True,entry_offset=resume,
                   execution_owners=(table,)+tuple(owner.execution_owner for owner in owners))
