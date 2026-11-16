"""Guarded, callback-free return paths for small original local functions.

This is partial inlining: unsupported paths use the canonical CALL at the same
site, with all original operands untouched. Plans own only nested code already
owned by the caller's original code object. No synthesized Python function runs.
"""
from dataclasses import dataclass
import inspect,types
from .inlining import code_cost

@dataclass(frozen=True)
class ReturnPath:
    conditions:tuple
    result:tuple

@dataclass(frozen=True)
class LocalReturns:
    code:types.CodeType
    paths:tuple

_INERT=(type(None),bool,int,float,complex,str,bytes)

def return_paths(code):
    """Find acyclic load/boolean-branch/return paths; other paths stay Python."""
    if (type(code) is not types.CodeType or code.co_exceptiontable or code.co_freevars or code.co_cellvars
        or code.co_kwonlyargcount or code.co_flags & (inspect.CO_VARARGS|inspect.CO_VARKEYWORDS|inspect.CO_GENERATOR|inspect.CO_COROUTINE|inspect.CO_ASYNC_GENERATOR)
        or code_cost(code)>48):return ()
    from .builder import build_code
    graph=build_code(code)
    pending=[(graph.entry,{},(),frozenset())];results=[]
    def follow(edge,values,conditions,seen):
        environment=dict(values)
        for source,target in zip(edge.arguments,graph.blocks[edge.target].parameters):
            if source.id not in values:return
            environment[target.id]=values[source.id]
        pending.append((edge.target,environment,conditions,seen))
    while pending:
        offset,values,conditions,seen=pending.pop()
        if offset in seen:continue
        seen=seen|{offset};block=graph.blocks[offset]
        for op in block.operations:
            name=op.name
            if name in ('resume','nop'):continue
            if name in ('frame.borrow','frame.load'):
                index=op.attributes['oparg']
                if index>=code.co_argcount:break
                value=('argument',index)
            elif name in ('constant','small_int'):
                value=op.instruction.argval
                if type(value) not in _INERT:break
                value=('constant',value)
            elif name=='to_bool':
                value=values.get(op.arguments[0].id)
                if value is None:break
                if value[0]=='argument':value=('boolean',value[1])
                elif value[0]=='constant':value=('constant',bool(value[1]))
                elif value[0]!='boolean':break
            elif name=='branch':
                spelling=op.instruction.opname
                if spelling not in ('POP_JUMP_IF_TRUE','POP_JUMP_IF_FALSE'):break
                value=values.get(op.arguments[0].id)
                if value is None:break
                for edge in block.edges:
                    want=(edge.kind=='taken')==(spelling=='POP_JUMP_IF_TRUE');new=conditions
                    if value[0]=='constant':
                        if value[1] is not want:continue
                    elif value[0] in ('boolean','argument'):
                        prior=dict(conditions).get(value[1])
                        if prior is not None and prior is not want:continue
                        new=tuple(sorted({**dict(conditions),value[1]:want}.items()))
                    else:continue
                    follow(edge,values,new,seen)
                break
            elif name=='return':
                value=values.get(op.arguments[0].id)
                if value is not None and value[0] in ('argument','constant'):
                    results.append(ReturnPath(conditions,value))
                break
            elif name=='jump':
                for edge in block.edges:follow(edge,values,conditions,seen)
                break
            else:break
            values[op.results[0].id]=value
        else:
            for edge in block.edges:follow(edge,values,conditions,seen)
    return tuple(results)


def local_return_sites(graph):
    """Use the local's original nested-code name, then guard live code at CALL."""
    nested={}
    for code in graph.code.co_consts:
        if type(code) is types.CodeType:
            paths=return_paths(code)
            if paths:nested.setdefault(code.co_name,[]).append(LocalReturns(code,paths))
    producers={value.id:op for block in graph.blocks.values() for op in block.operations for value in op.results}
    parameters={value.id:(block.offset,index) for block in graph.blocks.values() for index,value in enumerate(block.parameters)}
    incoming={}
    for block in graph.blocks.values():
        for edge in block.edges:
            if edge.kind!='exception':incoming.setdefault(edge.target,[]).append(edge)
    def local_names(value,seen=frozenset()):
        if value.id in seen:return set()
        seen=seen|{value.id};source=producers.get(value.id)
        if source is None:
            parameter=parameters.get(value.id)
            if parameter is None:return set()
            offset,index=parameter
            names=set()
            for edge in incoming.get(offset,()):names.update(local_names(edge.arguments[index],seen))
            return names
        if source.name=='cell.get':return {source.attributes['argval']}
        if source.name in ('frame.borrow','frame.load'):slot=source.attributes['oparg']
        elif source.name=='frame.store_load':slot=source.attributes['slots'][1]
        elif source.name in ('frame.borrow_borrow','frame.load_load'):
            slot=source.attributes['slots'][source.results.index(value)]
        else:return set()
        return {graph.code.co_varnames[slot]}
    sites={}
    for block in graph.blocks.values():
        for op in block.operations:
            if op.name!='call':continue
            names=local_names(op.arguments[0])
            candidates=tuple(c for name in sorted(names) for c in nested.get(name,()) if c.code.co_argcount==op.attributes['oparg'])
            if candidates:sites[op.offset]=candidates
    return sites


def emit(builder,candidates,operands,*,frame,base,nargs,pending,canonical,helper,integer,pointer,raw,p,word,i32,counter_address=0):
    """Emit guarded native return paths and rejoin the existing CALL protocol."""
    from llvmlite import ir
    finish=builder.function.append_basic_block('inline_return_join');incoming=[]
    for candidate in candidates:
        for path in candidate.paths:
            # One boolean guard is the initial slice. More involved paths
            # remain canonical rather than adding a per-call plan interpreter.
            if len(path.conditions)>1:continue
            index,want=path.conditions[0] if path.conditions else (-1,None)
            result_index=path.result[1] if path.result[0]=='argument' else -1
            constant=path.result[1] if path.result[0]=='constant' else None
            result=helper('inline_return_owned',p,[frame,base,integer(nargs),pointer(candidate.code),
                integer(index),pointer(want),integer(result_index),pointer(constant)])
            condition=builder.icmp_unsigned('!=',result,ir.Constant(p,None))
            success=builder.function.append_basic_block('inline_return');failure=builder.function.append_basic_block('inline_call_fallback')
            builder.cbranch(condition,success,failure);builder.position_at_end(success)
            builder.store(ir.Constant(i32,0),pending)
            if counter_address:
                counter=integer(counter_address).inttoptr(word.as_pointer())
                builder.store(builder.add(builder.load(counter),integer(1)),counter)
            incoming.append((result,builder.block));builder.branch(finish);builder.position_at_end(failure)
    result=canonical();incoming.append((result,builder.block));builder.branch(finish);builder.position_at_end(finish)
    result=builder.phi(p)
    for value,block in incoming:result.add_incoming(value,block)
    return result
