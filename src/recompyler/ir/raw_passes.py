"""Verified consumers for backend-private raw SSA optimization plans.

The caller certifies inert, nonraising raw operations through explicit effects.
Boxed Python operations never become raw by annotation. Source PCs stay as nops
when a computation disappears; Python ownership and frame operations stay put.

SSA substitution uses path compression; raw origins change at most twice per
value. Total element work is linear, plus the bounded planners and verifier.
"""
from dataclasses import replace
from collections import deque
from types import MappingProxyType
from .ops import Block
from .types import INT64
from .verifier import verify
from .memory_proofs import MemoryEffect, plan_memory
from .virtual_proofs import VirtualEffect, RAW_RECORD, plan_virtuals
from .ruleproof import CATALOGUE, prove


def _snapshot(graph,effects,kind):
    verify(graph)
    result={}
    for block in graph.blocks.values():
        for op in block.operations:
            if op.offset in result:
                raise ValueError('raw consumers require unique source PCs')
            effect=effects(op) if callable(effects) else effects.get(op.offset,kind())
            if type(effect) is not kind:raise TypeError('explicit '+kind.__name__+' required')
            result[op.offset]=effect
    return MappingProxyType(result)


def _nop(op,reason,proof=None):
    attributes={'raw_optimization':reason}
    if proof is not None:attributes['rule_proof']=proof
    return replace(op,name='nop',arguments=(),results=(),attributes=attributes)


def _rewrite(graph,changes,substitutions,removed_parameters=frozenset()):
    if not changes:return graph
    resolved={}
    def resolve(value):
        seen=set();trail=[]
        while value.id in substitutions:
            if value.id in resolved:
                value=resolved[value.id];break
            if value.id in seen:raise ValueError('cyclic raw substitution')
            seen.add(value.id);trail.append(value.id)
            replacement=substitutions[value.id]
            if value.type!=INT64 or replacement.type!=INT64:
                raise ValueError('only raw scalar values may be substituted')
            value=replacement
        for identifier in trail:resolved[identifier]=value
        return value
    blocks={}
    for key,block in graph.blocks.items():
        operations=[]
        for op in block.operations:
            new=changes.get(op.offset,op)
            attributes=dict(new.attributes)
            attributes.pop('integer_proof',None)  # The original graph certificate is stale.
            operations.append(replace(new,arguments=tuple(resolve(v) for v in new.arguments),attributes=attributes))
        edges=[replace(edge,arguments=tuple(resolve(v) for v,param in zip(edge.arguments,graph.blocks[edge.target].parameters)
                    if param.id not in removed_parameters)) for edge in block.edges]
        blocks[key]=Block(key,tuple(p for p in block.parameters if p.id not in removed_parameters),operations,edges)
    result=replace(graph,blocks=blocks)
    verify(result)
    return result


def optimize_raw_memory(graph,effects):
    """Eliminate certified raw loads/CSE; unknown effects remain barriers."""
    effects=_snapshot(graph,effects,MemoryEffect)
    plan=plan_memory(graph,effects)
    changes={};substitutions={}
    for block in graph.blocks.values():
        for op in block.operations:
            previous=plan.replacements.get(op.offset)
            # Erasing a boxed owner's last use could change its free time
            # when the later reference pass computes liveness.
            if previous is not None and all(v.type==INT64 for v in op.arguments):
                changes[op.offset]=_nop(op,'raw memory/CSE')
                substitutions[op.results[0].id]=previous
    return _rewrite(graph,changes,substitutions)


def optimize_raw_words(graph,effects):
    """Apply matching catalogue rules only after Z3 has proved each rule."""
    effects=_snapshot(graph,effects,MemoryEffect)
    constants={op.results[0].id:op.attributes['argval']
        for block in graph.blocks.values() for op in block.operations
        if op.name=='constant' and not op.arguments and len(op.results)==1 and op.results[0].type==INT64
        and type(op.attributes.get('argval')) is int and -(1<<63)<=op.attributes['argval']<(1<<63)}
    catalogue={rule.name:rule for rule in CATALOGUE}
    changes={};substitutions={}
    for block in graph.blocks.values():
        for op in block.operations:
            effect=effects[op.offset]
            if (effect.kind!='pure' or not effect.inert or effect.may_raise or len(op.arguments)!=2
                or len(op.results)!=1 or any(v.type!=INT64 for v in (*op.arguments,*op.results))):continue
            left,right=op.arguments;name=None;zero=False
            if left.id==right.id:
                name={'and':'and_self','or':'or_self','xor':'xor_self','sub':'sub_self'}.get(effect.operator)
                zero=effect.operator in ('xor','sub')
            if name is None and constants.get(right.id)==0:
                name={'add':'add_zero','sub':'sub_zero','and':'and_zero','or':'or_zero','xor':'xor_zero'}.get(effect.operator)
                zero=effect.operator=='and'
            if name is None and constants.get(right.id)==1 and effect.operator=='mul':name='mul_one'
            if name is None:continue
            proof=prove(catalogue[name])
            if zero:
                changes[op.offset]=replace(op,name='constant',arguments=(),attributes={
                    'argval':0,'raw_optimization':name,'rule_proof':proof.digest})
                constants[op.results[0].id]=0
            else:
                changes[op.offset]=_nop(op,name,proof.digest)
                substitutions[op.results[0].id]=left
    return _rewrite(graph,changes,substitutions)


def optimize_raw_virtuals(graph,effects):
    """Scalar-replace all-path private records, including CFG record phis.

    The planner must certify creation, every field operation and release. Python
    containers, escaping records and uncertain joins keep their allocations.
    """
    effects=_snapshot(graph,effects,VirtualEffect)
    plan=plan_virtuals(graph,effects)
    if not plan.removable:return graph
    removable=set(plan.removable)
    # Three-point origin lattice: unseen -> one allocation -> ambiguous.
    # Each raw value changes at most twice, regardless of CFG insertion order.
    unknown=object();origins={};users={}
    for block in graph.blocks.values():
        origins.update((p.id,None) for p in block.parameters if p.type==RAW_RECORD)
        for op in block.operations:
            for value in op.results:
                if value.type==RAW_RECORD:
                    origins[value.id]=op.offset if effects[op.offset].kind=='alloc' else unknown
        for edge in block.edges:
            for value,param in zip(edge.arguments,graph.blocks[edge.target].parameters):
                if param.type==RAW_RECORD:users.setdefault(value.id,[]).append(param.id)
    pending=deque(key for key,value in origins.items() if value is not None)
    while pending:
        source=pending.popleft();origin=origins[source]
        for target in users.get(source,()):
            old=origins[target]
            merged=origin if old is None else old if old==origin else unknown
            if merged!=old:origins[target]=merged;pending.append(target)
    handles={key for key,origin in origins.items() if type(origin) is int and origin in removable}
    changes={};substitutions={}
    for block in graph.blocks.values():
        for op in block.operations:
            effect=effects[op.offset]
            if op.offset in removable:
                if len(op.results)!=1 or op.results[0].id not in handles:
                    raise ValueError('virtual allocation has an unresolved alias')
                changes[op.offset]=_nop(op,'private record allocation')
            elif any(v.id in handles for v in op.arguments):
                if not op.arguments or op.arguments[0].id not in handles or effect.kind not in ('read','write','release'):
                    raise ValueError('virtual record has an unmodelled use')
                if effect.kind=='read':
                    if op.offset not in plan.replacements:raise ValueError('virtual read lacks a scalar proof')
                    substitutions[op.results[0].id]=plan.replacements[op.offset]
                elif op.results:raise ValueError('virtual writes/releases must have no results')
                changes[op.offset]=_nop(op,'private record '+effect.kind)
        for edge in block.edges:
            for value,param in zip(edge.arguments,graph.blocks[edge.target].parameters):
                if value.id in handles and param.id not in handles:
                    raise ValueError('virtual edge has an unresolved alias')
    return _rewrite(graph,changes,substitutions,handles)
