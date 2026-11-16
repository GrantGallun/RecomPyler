"""Raw proof consumers must preserve executable CFG values and source PCs."""
from dataclasses import replace
import operator
import pytest
from test_ir_memory_proofs import linear, read, shape
from test_ir_virtual_proofs import virtual_case
from recompyler.ir.memory_proofs import MemoryEffect
from recompyler.ir.virtual_proofs import VirtualEffect, RAW_RECORD
from recompyler.ir.ops import Block, Edge, FunctionIR, Operation, Value
from recompyler.ir.types import INT64, PYOBJECT
from recompyler.ir.verifier import verify
from recompyler.ir.raw_passes import optimize_raw_memory, optimize_raw_virtuals, optimize_raw_words


OPS={'add':operator.add,'sub':operator.sub,'mul':operator.mul,
     'and':operator.and_,'or':operator.or_,'xor':operator.xor}


def execute(graph, effects, seeds, memory=None):
    """Small independent raw CFG interpreter; neither planner is an oracle."""
    values={};memory=dict(memory or {});key=graph.entry
    for _ in range(1000):
        block=graph.blocks[key]
        for op in block.operations:
            args=[values[v.id] for v in op.arguments]
            if op.name=='return':return args[0]
            if op.name in ('nop','jump','branch'):continue
            effect=effects.get(op.offset)
            if op.name=='seed':result=seeds[op.results[0].id]
            elif op.name=='constant':result=op.attributes['argval']
            elif op.name in OPS:result=OPS[op.name](*args)
            elif isinstance(effect,MemoryEffect):
                if effect.kind=='read':result=memory[args[0],effect.location.field]
                elif effect.kind=='write':memory[args[0],effect.location.field]=values[effect.stored];continue
                elif effect.kind=='pure':result=OPS[effect.operator](*args)
                else:continue
            elif isinstance(effect,VirtualEffect):
                if effect.kind=='alloc':result=dict(zip(effect.fields,args))
                elif effect.kind=='read':result=args[0][effect.field]
                elif effect.kind=='write':args[0][effect.field]=args[1];continue
                elif effect.kind=='release':continue
                else:continue
            else:continue
            assert len(op.results)==1
            values[op.results[0].id]=result
        edges=[e for e in block.edges if e.kind!='exception']
        if block.operations[-1].name=='branch':
            condition=values[block.operations[-1].arguments[0].id]
            edge=next(e for e in edges if e.kind==('taken' if condition else 'fallthrough'))
        else:edge=edges[0]
        transferred=[values[v.id] for v in edge.arguments]
        key=edge.target
        values.update((v.id,value) for v,value in zip(graph.blocks[key].parameters,transferred))
    raise AssertionError('raw CFG failed to terminate')


def test_memory_consumer_removes_repeated_loads_and_updates_every_use():
    graph,effects,ops=linear(['seed','load','load','load'],{1:read(),2:read(),3:read()})
    transformed=optimize_raw_memory(graph,effects)
    verify(transformed)
    assert sum(op.name=='nop' for op in transformed.blocks[0].operations)==2
    assert transformed.blocks[0].operations[-1].arguments==ops[1].results
    for result in (-(1<<63),-1,0,(1<<63)-1):
        assert execute(transformed,effects,{0:13},{(13,'value'):result})==execute(graph,effects,{0:13},{(13,'value'):result})
    assert [o.name for o in graph.blocks[0].operations]==['seed','load','load','load','return']
    assert [o.offset for o in transformed.blocks[0].operations]==[o.offset for o in ops]


def test_memory_consumer_preserves_unknown_barriers():
    graph,effects,ops=linear(['seed','load','call','load'],{1:read(),3:read()})
    transformed=optimize_raw_memory(graph,effects)
    assert [o.name for o in transformed.blocks[0].operations]==[o.name for o in ops]


def word_case(operation,constant=0,self_pair=False):
    graph,effects,ops=linear(['seed','constant','binary'],{})
    operations=list(ops)
    operations[1]=replace(ops[1],arguments=(),attributes={'argval':constant})
    operations[2]=replace(ops[2],arguments=(ops[0].results[0],ops[0 if self_pair else 1].results[0]))
    graph.blocks[0].operations=operations
    effects[operations[2].offset]=MemoryEffect('pure',operator=operation,inert=True,may_raise=False)
    return graph,effects,operations


@pytest.mark.parametrize('operation,constant,self_pair',[
    ('add',0,False),('sub',0,False),('mul',1,False),('and',0,False),
    ('or',0,False),('xor',0,False),('and',0,True),('or',0,True),
    ('xor',0,True),('sub',0,True)])
def test_each_used_peephole_is_proved_and_value_exact(operation,constant,self_pair):
    graph,effects,ops=word_case(operation,constant,self_pair)
    transformed=optimize_raw_words(graph,effects)
    verify(transformed)
    changed=transformed.blocks[0].operations[2]
    assert changed.name in ('nop','constant')
    assert len(changed.attributes['rule_proof'])==64
    for value in (-(1<<63),-13,0,1,17,(1<<63)-1):
        assert execute(transformed,effects,{0:value})==execute(graph,effects,{0:value})
    assert graph.blocks[0].operations[2].name=='binary'


def test_boxed_python_results_cannot_be_rewritten_by_raw_effects():
    graph,effects,ops=word_case('add')
    values={v.id:replace(v,type=PYOBJECT) for op in graph.blocks[0].operations for v in (*op.arguments,*op.results)}
    graph.blocks[0].operations=[replace(op,arguments=tuple(values[v.id] for v in op.arguments),
        results=tuple(values[v.id] for v in op.results)) for op in graph.blocks[0].operations]
    assert optimize_raw_words(graph,effects).blocks[0].operations[2].name=='binary'
    assert optimize_raw_memory(graph,effects).blocks[0].operations[2].name=='binary'


def test_rewrite_refuses_missing_solver_proof_without_mutating_input(monkeypatch):
    from recompyler.ir import raw_passes
    from recompyler.ir.ruleproof import ProofFailure
    graph,effects,ops=word_case('add')
    def unavailable(*args,**kwargs):raise ProofFailure('solver unavailable')
    monkeypatch.setattr(raw_passes,'prove',unavailable)
    with pytest.raises(ProofFailure,match='solver unavailable'):optimize_raw_words(graph,effects)
    assert graph.blocks[0].operations[2].name=='binary'


def test_private_record_consumer_removes_allocation_read_and_release():
    graph,effects,ops,get=virtual_case()
    graph.blocks[0].operations[-1]=replace(ops[-1],arguments=ops[get].results)
    transformed=optimize_raw_virtuals(graph,effects)
    verify(transformed)
    assert [o.name for o in transformed.blocks[0].operations]==['seed','nop','nop','nop','return']
    assert transformed.blocks[0].operations[-1].arguments==ops[0].results
    for value in (-987,0,333):assert execute(transformed,effects,{0:value})==execute(graph,effects,{0:value})
    assert graph.blocks[0].operations[1].name=='alloc'


def test_virtual_consumer_keeps_visible_or_observed_allocations():
    graph,effects,ops,get=virtual_case()
    effects[ops[1].offset]=replace(effects[ops[1].offset],invisible=False)
    assert optimize_raw_virtuals(graph,effects).blocks[0].operations[1].name=='alloc'
    graph,effects,ops,get=virtual_case(True)
    assert optimize_raw_virtuals(graph,effects).blocks[0].operations[1].name=='alloc'


def test_virtual_consumer_rewrites_record_phi_and_edge_operands():
    import dis
    instructions=list(dis.get_instructions(shape))
    scalar=Value(0,INT64);handle=Value(1,RAW_RECORD);phi=Value(2,RAW_RECORD);result=Value(3,INT64)
    target=instructions[3].offset
    def op(n,name,args=(),results=(),block=0):return Operation(name,args,results,instructions[n].offset,block,instructions[n],{})
    seed=op(0,'seed',results=(scalar,));alloc=op(1,'alloc',(scalar,),(handle,));jump=op(2,'jump')
    get=op(3,'read',(phi,),(result,),target);release=op(4,'release',(phi,),block=target);end=op(5,'return',(result,),block=target)
    graph=FunctionIR(shape,shape.__code__,0,{0:Block(0,(),[seed,alloc,jump],[Edge(target,(handle,),'jump')]),
        target:Block(target,(phi,),[get,release,end],[])})
    effects={seed.offset:VirtualEffect('neutral',inert=True),jump.offset:VirtualEffect('neutral',inert=True),
        alloc.offset:VirtualEffect('alloc',fields=('x',),invisible=True,inert=True),get.offset:VirtualEffect('read',field='x',inert=True),
        release.offset:VirtualEffect('release',inert=True)}
    transformed=optimize_raw_virtuals(graph,effects)
    verify(transformed)
    assert not transformed.blocks[target].parameters
    assert not transformed.blocks[0].edges[0].arguments
    assert execute(transformed,effects,{0:71})==execute(graph,effects,{0:71})==71


def test_ambiguous_source_pcs_are_refused():
    graph,effects,ops=word_case('add')
    graph.blocks[0].operations[1]=replace(ops[1],offset=ops[0].offset,instruction=ops[0].instruction)
    with pytest.raises(ValueError,match='unique'):optimize_raw_words(graph,effects)


def test_memory_consumer_uses_must_availability_at_both_cfg_arms():
    import dis
    from recompyler.ir.memory_proofs import Location
    instructions=list(dis.get_instructions(shape));v=[Value(n,INT64) for n in range(4)]
    left,right,join=(instructions[n].offset for n in (3,5,7))
    def op(n,name,args=(),results=(),block=0):return Operation(name,args,results,instructions[n].offset,block,instructions[n],{})
    seed=op(0,'seed',results=(v[0],));first=op(1,'load',(v[0],),(v[1],));branch=op(2,'branch',(v[0],))
    a=op(3,'write',(v[0],),block=left);aj=op(4,'jump',block=left)
    b=op(5,'nop',block=right);bj=op(6,'jump',block=right)
    last=op(7,'load',(v[0],),(v[2],),join);end=op(8,'return',(v[2],),block=join)
    graph=FunctionIR(shape,shape.__code__,0,{
        0:Block(0,(),[seed,first,branch],[Edge(left,(),'taken'),Edge(right,(),'fallthrough')]),
        left:Block(left,(),[a,aj],[Edge(join,(),'jump')]),right:Block(right,(),[b,bj],[Edge(join,(),'jump')]),
        join:Block(join,(),[last,end],[])})
    neutral=MemoryEffect('neutral',inert=True,may_raise=False)
    effects={o.offset:neutral for block in graph.blocks.values() for o in block.operations}
    effects.update({first.offset:read(),last.offset:read()})
    transformed=optimize_raw_memory(graph,effects)
    assert transformed.blocks[join].operations[0].name=='nop'
    for owner in (0,7):assert execute(transformed,effects,{0:owner},{(owner,'value'):83})==83
    effects[a.offset]=MemoryEffect('write',Location('field',0,'value'),stored=0,inert=True,may_raise=False)
    transformed=optimize_raw_memory(graph,effects)
    assert transformed.blocks[join].operations[0].name=='load'
    for owner in (0,7):
        assert execute(transformed,effects,{0:owner},{(owner,'value'):83})==execute(graph,effects,{0:owner},{(owner,'value'):83})


def test_raw_cse_eliminates_computation_after_z3_validation():
    pure=MemoryEffect('pure',operator='add',inert=True,may_raise=False)
    graph,effects,ops=linear(['seed','add','add'],{1:pure,2:pure})
    graph.blocks[0].operations=[replace(op,arguments=op.arguments*2) if op.name=='add' else op for op in ops]
    transformed=optimize_raw_memory(graph,effects)
    assert transformed.blocks[0].operations[2].name=='nop'
    for value in (-3,0,51):assert execute(transformed,effects,{0:value})==execute(graph,effects,{0:value})==2*value


def test_virtual_uses_after_release_fail_closed():
    graph,effects,ops,get=virtual_case()
    operations=list(ops)
    operations[get],operations[get+1]=replace(ops[get+1],offset=ops[get].offset,instruction=ops[get].instruction),replace(ops[get],offset=ops[get+1].offset,instruction=ops[get+1].instruction)
    graph.blocks[0].operations=operations
    effects[operations[get].offset]=VirtualEffect('release',inert=True)
    effects[operations[get+1].offset]=VirtualEffect('read',field='x',inert=True)
    with pytest.raises(ValueError,match='scalar proof'):optimize_raw_virtuals(graph,effects)
    assert graph.blocks[0].operations[1].name=='alloc'


def test_callable_effects_are_snapshotted_once_per_operation():
    graph,effects,ops=linear(['seed','load','load'],{1:read(),2:read()})
    calls=[]
    def describe(op):
        calls.append(op.offset)
        return effects.get(op.offset,MemoryEffect())
    assert optimize_raw_memory(graph,describe).blocks[0].operations[2].name=='nop'
    assert calls==[op.offset for op in ops]


def test_virtual_record_loop_phi_is_removed_without_losing_scalar_loop_phi():
    import dis
    def loop_shape(x):
        a=x+x;b=a+a;c=b+b;d=c+c;e=d+d;f=e+e
        return f
    instructions=list(dis.get_instructions(loop_shape))
    seed=Value(0,INT64);one=Value(1,INT64);handle=Value(2,RAW_RECORD)
    counter=Value(10,INT64);record=Value(11,RAW_RECORD);nextcount=Value(21,INT64)
    temp=Value(20,INT64);outrecord=Value(30,RAW_RECORD);result=Value(31,INT64)
    head,body,out=(instructions[n].offset for n in (4,5,9))
    def op(n,name,args=(),results=(),block=0,attrs=None):return Operation(name,args,results,instructions[n].offset,block,instructions[n],attrs or {})
    start=op(0,'seed',results=(seed,));constant=op(1,'constant',results=(one,),attrs={'argval':1})
    alloc=op(2,'alloc',(seed,),(handle,));jump=op(3,'jump')
    branch=op(4,'branch',(counter,),block=head);get=op(5,'read',(record,),(temp,),body)
    decrement=op(6,'sub',(counter,one),(nextcount,),body);back=op(7,'jump',block=body)
    finish=op(9,'read',(outrecord,),(result,),out);release=op(10,'release',(outrecord,),block=out);end=op(11,'return',(result,),block=out)
    graph=FunctionIR(loop_shape,loop_shape.__code__,0,{
        0:Block(0,(),[start,constant,alloc,jump],[Edge(head,(seed,handle),'jump')]),
        head:Block(head,(counter,record),[branch],[Edge(body,(),'taken'),Edge(out,(record,),'fallthrough')]),
        body:Block(body,(),[get,decrement,back],[Edge(head,(nextcount,record),'jump')]),
        out:Block(out,(outrecord,),[finish,release,end],[])})
    effects={op.offset:VirtualEffect('neutral',inert=True) for b in graph.blocks.values() for op in b.operations}
    effects.update({alloc.offset:VirtualEffect('alloc',fields=('x',),invisible=True,inert=True),
        get.offset:VirtualEffect('read',field='x',inert=True),finish.offset:VirtualEffect('read',field='x',inert=True),
        release.offset:VirtualEffect('release',inert=True)})
    transformed=optimize_raw_virtuals(graph,effects)
    verify(transformed)
    assert transformed.blocks[head].parameters==(counter,)
    assert transformed.blocks[body].edges[0].arguments==(nextcount,)
    for value in (0,1,8):assert execute(transformed,effects,{0:value})==execute(graph,effects,{0:value})==value


def test_heap_cache_does_not_replace_invariant_load_with_loop_counter_phi():
    import dis
    instructions=list(dis.get_instructions(shape))
    owner=Value(0,INT64);loaded=Value(1,INT64);one=Value(2,INT64)
    counter=Value(10,INT64);decremented=Value(11,INT64);result=Value(20,INT64)
    head,body,out=(instructions[n].offset for n in (4,5,7))
    def op(n,name,args=(),results=(),block=0,attrs=None):return Operation(name,args,results,instructions[n].offset,block,instructions[n],attrs or {})
    seed=op(0,'seed',results=(owner,));first=op(1,'load',(owner,),(loaded,))
    constant=op(2,'constant',results=(one,),attrs={'argval':1});jump=op(3,'jump')
    branch=op(4,'branch',(counter,),block=head);sub=op(5,'sub',(counter,one),(decremented,),body);back=op(6,'jump',block=body)
    last=op(7,'load',(owner,),(result,),out);end=op(8,'return',(result,),block=out)
    graph=FunctionIR(shape,shape.__code__,0,{
        0:Block(0,(),[seed,first,constant,jump],[Edge(head,(loaded,),'jump')]),
        head:Block(head,(counter,),[branch],[Edge(body,(),'taken'),Edge(out,(),'fallthrough')]),
        body:Block(body,(),[sub,back],[Edge(head,(decremented,),'jump')]),out:Block(out,(),[last,end],[])})
    effects={o.offset:MemoryEffect('neutral',inert=True,may_raise=False) for b in graph.blocks.values() for o in b.operations}
    effects.update({first.offset:read(),last.offset:read()})
    transformed=optimize_raw_memory(graph,effects)
    for value in (0,1,5):assert execute(transformed,effects,{0:13},{(13,'value'):value})==execute(graph,effects,{0:13},{(13,'value'):value})==value


def test_raw_load_consumer_keeps_boxed_owner_uses_for_exact_lifetime():
    graph,effects,ops=linear(['seed','load','load'],{1:read(),2:read()})
    owner=replace(ops[0].results[0],type=PYOBJECT)
    graph.blocks[0].operations=[replace(op,arguments=tuple(owner if v.id==owner.id else v for v in op.arguments),
        results=tuple(owner if v.id==owner.id else v for v in op.results)) for op in ops]
    transformed=optimize_raw_memory(graph,effects)
    assert transformed.blocks[0].operations[2].name=='load'
    assert transformed.blocks[0].operations[2].arguments==(owner,)


def test_virtual_store_is_replaced_with_its_current_scalar_value():
    graph,_,ops=linear(['seed','constant','alloc','write','read','release'],{})
    scalar=ops[0].results[0];replacement=ops[1].results[0];handle=replace(ops[2].results[0],type=RAW_RECORD)
    changes={1:replace(ops[1],arguments=(),attributes={'argval':177}),
        2:replace(ops[2],arguments=(scalar,),results=(handle,)),
        3:replace(ops[3],arguments=(handle,replacement),results=()),4:replace(ops[4],arguments=(handle,)),
        5:replace(ops[5],arguments=(handle,),results=()),6:replace(ops[6],arguments=ops[4].results)}
    graph.blocks[0].operations=[changes.get(n,op) for n,op in enumerate(ops)]
    effects={ops[0].offset:VirtualEffect('neutral',inert=True),ops[1].offset:VirtualEffect('neutral',inert=True),
        ops[2].offset:VirtualEffect('alloc',fields=('x',),invisible=True,inert=True),
        ops[3].offset:VirtualEffect('write',field='x',inert=True),ops[4].offset:VirtualEffect('read',field='x',inert=True),
        ops[5].offset:VirtualEffect('release',inert=True)}
    transformed=optimize_raw_virtuals(graph,effects)
    assert sum(op.name=='nop' for op in transformed.blocks[0].operations)==4
    for value in (-1,0,13):assert execute(transformed,effects,{0:value})==execute(graph,effects,{0:value})==177
