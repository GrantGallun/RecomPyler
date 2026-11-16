"""Must-availability, aliasing and lifetime barriers for raw IR cache plans."""
from dataclasses import replace
import dis
from recompyler.ir.ops import FunctionIR, Block, Operation, Value, Edge
from recompyler.ir.types import INT64
from recompyler.ir.memory_proofs import Location, MemoryEffect, plan_memory


def shape(x):
    a=x+x
    b=a+a
    c=b+b
    return c


def linear(names, effects):
    instructions=list(dis.get_instructions(shape))
    values=[Value(n,INT64) for n in range(20)]
    operations=[]
    for n,name in enumerate(names):
        args=() if n==0 else (values[0],)
        operations.append(Operation(name,args,(values[n],),instructions[n].offset,0,instructions[n],{}))
    n=len(names)
    operations.append(Operation('return',(values[n-1],),(),instructions[n].offset,0,instructions[n],{}))
    graph=FunctionIR(shape,shape.__code__,0,{0:Block(0,(),operations,[])})
    descriptions={operations[n].offset:effect for n,effect in effects.items()}
    return graph,descriptions,operations


def read():
    return MemoryEffect('read',Location('field',0,'value'),inert=True,may_raise=False)


def test_repeated_raw_load_and_unknown_barrier():
    graph,effects,ops=linear(['seed','load','load','call','load'],{1:read(),2:read(),4:read()})
    plan=plan_memory(graph,effects)
    assert plan.replacements[ops[2].offset]==ops[1].results[0]
    assert ops[4].offset not in plan.replacements


def test_write_invalidates_potential_aliases():
    write=MemoryEffect('write',Location('field',0,'other'),stored=0,inert=True,may_raise=False)
    graph,effects,ops=linear(['seed','load','store','load'],{1:read(),2:write,3:read()})
    assert ops[3].offset not in plan_memory(graph,effects).replacements


def test_effects_cannot_silently_assert_boxed_loads_pure():
    graph,effects,ops=linear(['seed','load','load'],{1:read(),2:read()})
    values={v.id:replace(v,type=replace(v.type,kind='object')) for op in ops for v in (*op.arguments,*op.results)}
    graph.blocks[0].operations=[replace(op,arguments=tuple(values[v.id] for v in op.arguments),
                                      results=tuple(values[v.id] for v in op.results)) for op in ops]
    assert not plan_memory(graph,effects).replacements


def test_pure_cse_requires_explicit_inert_effects_and_z3_proof():
    pure=MemoryEffect('pure',operator='add',inert=True,may_raise=False)
    graph,effects,ops=linear(['seed','add','add'],{1:pure,2:pure})
    # The semantic operation has two raw scalar operands.
    graph.blocks[0].operations=[replace(op,arguments=(op.arguments*2) if op.name=='add' else op.arguments) for op in ops]
    plan=plan_memory(graph,effects)
    assert plan.replacements[ops[2].offset]==ops[1].results[0]
    assert plan.rule_digests
    effects[ops[2].offset]=replace(pure,may_raise=True)
    assert not plan_memory(graph,effects).replacements


def test_cfg_join_requires_cache_on_every_path():
    instructions=list(dis.get_instructions(shape))
    v=[Value(n,INT64) for n in range(4)]
    def op(n,name,args=(),results=(),block=0):
        i=instructions[n]
        return Operation(name,args,results,i.offset,block,i,{})
    b,c,j=(instructions[n].offset for n in (3,5,7))
    seed=op(0,'seed',results=(v[0],))
    first=op(1,'load',(v[0],),(v[1],))
    branch=op(2,'branch')
    left=op(3,'left',(v[0],),block=b)
    left_end=op(4,'jump',block=b)
    right=op(5,'right',block=c)
    right_end=op(6,'jump',block=c)
    second=op(7,'load',(v[0],),(v[2],),block=j)
    end=op(8,'return',(v[2],),block=j)
    graph=FunctionIR(shape,shape.__code__,0,{
        0:Block(0,(),[seed,first,branch],[Edge(b,(),'taken'),Edge(c,(),'fallthrough')]),
        b:Block(b,(),[left,left_end],[Edge(j,(),'jump')]),
        c:Block(c,(),[right,right_end],[Edge(j,(),'jump')]),
        j:Block(j,(),[second,end],[])})
    neutral=MemoryEffect('neutral',inert=True,may_raise=False)
    effects={o.offset:neutral for o in (seed,branch,left,left_end,right,right_end,end)}
    effects.update({first.offset:read(),second.offset:read()})
    assert plan_memory(graph,effects).replacements[second.offset]==v[1]
    effects[left.offset]=MemoryEffect('write',Location('field',0,'value'),stored=0,inert=True,may_raise=False)
    assert second.offset not in plan_memory(graph,effects).replacements


def test_cse_replacement_is_a_live_canonical_definition():
    graph,effects,ops=linear(['seed','load','load','load'],{1:read(),2:read(),3:read()})
    plan=plan_memory(graph,effects)
    assert plan.replacements[ops[2].offset]==ops[1].results[0]
    assert plan.replacements[ops[3].offset]==ops[1].results[0]

