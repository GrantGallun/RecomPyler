"""Ownership dataflow plans preserve source retirement boundaries."""
import dis
import pytest
from recompyler.ir.ops import Value,Operation,Block,Edge,FunctionIR


def prototype(flag):
    if flag:return 0
    return 1


def graph_for(spec, edges=()):
    ins=tuple(dis.get_instructions(prototype))
    blocks={}
    values={}
    for block_id,params,operations in spec:
        parameters=tuple(values.setdefault(n,Value(n)) for n in params)
        ops=[]
        for name,inputs,outputs in operations:
            args=tuple(values.setdefault(n,Value(n)) for n in inputs)
            results=tuple(values.setdefault(n,Value(n)) for n in outputs)
            instruction=next(i for i in ins if i.offset==block_id)
            ops.append(Operation(name,args,results,block_id,block_id,instruction))
        blocks[block_id]=Block(block_id,parameters,ops,[])
    for source,target,args in edges:
        blocks[source].edges.append(Edge(target,tuple(values[n] for n in args)))
    return FunctionIR(prototype,prototype.__code__,0,blocks)


def api():
    from recompyler.ir.refcount import plan_refcounts,RefState,RefAction
    from recompyler.ir.refcount_effects import Effects,Output,RefKind
    return plan_refcounts,RefState,RefAction,Effects,Output,RefKind


def test_borrow_is_promoted_before_its_support_is_mutated():
    plan,State,Action,E,O,R=api()
    graph=graph_for([(0,(),[('borrow',(),(0,)),('mutate',(),()),('discard',(0,),()),('return',(),())])])
    effects={'borrow':E(outputs=(O(R.BORROWED,frozenset({'local:x'})),)),
             'mutate':E(may_store=frozenset({'local:x'})),
             'discard':E(retire=(0,)),'return':E()}
    result=plan(graph,effects)
    assert result.before[(0,1)]==(Action('incref',0),)
    assert result.after[(0,2)]==(Action('decref',0),)


def test_source_owned_value_is_not_released_at_its_last_ssa_use():
    plan,State,Action,E,O,R=api()
    graph=graph_for([(0,(),[('new',(),(0,)),('read',(0,),()),('effect',(),()),('discard',(0,),()),('return',(),())])])
    effects={'new':E(outputs=(O(R.OWNED),)), 'read':E(), 'effect':E(arbitrary=True),
             'discard':E(retire=(0,)), 'return':E()}
    result=plan(graph,effects)
    assert not result.after.get((0,1)) and not result.before.get((0,2))
    assert result.after[(0,3)]==(Action('decref',0),)


def test_decref_invalidates_memory_borrows_before_finalizer_can_run():
    plan,State,Action,E,O,R=api()
    graph=graph_for([(0,(),[('new',(),(0,)),('borrow',(),(1,)),('discard',(0,),()),('discard',(1,),()),('return',(),())])])
    effects={'new':E(outputs=(O(R.OWNED),)), 'borrow':E(outputs=(O(R.BORROWED,frozenset({'dict:d'})),)),
             'discard':E(retire=(0,)), 'return':E()}
    result=plan(graph,effects)
    assert result.before[(0,2)]==(Action('incref',1),)
    assert result.after[(0,2)]==(Action('decref',0),)


def test_retirement_order_and_stolen_inputs_are_preserved():
    plan,State,Action,E,O,R=api()
    graph=graph_for([(0,(),[('new',(),(0,)),('new',(),(1,)),('consume',(0,1),()),('return',(),())])])
    result=plan(graph,{'new':E(outputs=(O(R.OWNED),)), 'consume':E(steal=(0,),retire=(1,)), 'return':E()})
    assert result.after[(0,2)]==(Action('decref',1),)
    assert not result.out_states[0]


def test_unknown_operations_and_unretired_owners_fail_closed():
    plan,State,Action,E,O,R=api()
    graph=graph_for([(0,(),[('new',(),(0,)),('return',(),())])])
    with pytest.raises(ValueError,match='effect'):plan(graph,{})
    with pytest.raises(ValueError,match='owner'):plan(graph,{'new':E(outputs=(O(R.OWNED),)),'return':E()})

def test_join_promotes_only_borrowed_incoming_edge():
    plan,State,Action,E,O,R=api()
    offsets=[i.offset for i in dis.get_instructions(prototype)]
    left,right,join=offsets[1],offsets[2],offsets[-1]
    graph=graph_for([(0,(),[('branch',(),())]),
                     (left,(),[('borrow',(),(0,)),('jump',(),())]),
                     (right,(),[('new',(),(1,)),('jump',(),())]),
                     (join,(2,),[('discard',(2,),()),('return',(),())])],
                    [(0,left,()),(0,right,()),(left,join,(0,)),(right,join,(1,))])
    result=plan(graph,{'branch':E(),'jump':E(),'borrow':E(outputs=(O(R.BORROWED,frozenset({'local:x'})),)),
                       'new':E(outputs=(O(R.OWNED),)),'discard':E(retire=(0,)),'return':E()})
    assert result.in_states[join][2]==State(R.OWNED)
    assert result.edges[(left,0)]==(Action('incref',0),)
    assert result.edges[(right,0)]==()
    assert result.after[(join,0)]==(Action('decref',2),)


def test_loop_fixed_point_moves_promotion_to_borrowed_entry_edge():
    plan,State,Action,E,O,R=api()
    offsets=[i.offset for i in dis.get_instructions(prototype)]
    loop,exit=offsets[1],offsets[-1]
    graph=graph_for([(0,(),[('borrow',(),(0,)),('jump',(),())]),
                     (loop,(1,),[('mutate',(),()),('branch',(),())]),
                     (exit,(2,),[('discard',(2,),()),('return',(),())])],
                    [(0,loop,(0,)),(loop,loop,(1,)),(loop,exit,(1,))])
    result=plan(graph,{'borrow':E(outputs=(O(R.BORROWED,frozenset({'local:x'})),)),
                       'jump':E(),'mutate':E(may_store=frozenset({'local:x'})),
                       'branch':E(),'discard':E(retire=(0,)),'return':E()})
    assert result.in_states[loop][1]==State(R.OWNED)
    assert result.edges[(0,0)]==(Action('incref',0),)
    assert result.before[(loop,0)]==()


def test_borrowed_result_is_promoted_before_its_owned_input_dies():
    plan,State,Action,E,O,R=api()
    graph=graph_for([(0,(),[('new',(),(0,)),('borrow',(0,),(1,)),('discard',(1,),()),('return',(),())])])
    result=plan(graph,{'new':E(outputs=(O(R.OWNED),)),
                      'borrow':E(outputs=(O(R.BORROWED,frozenset({0})),),retire=(0,)),
                      'discard':E(retire=(0,)),'return':E()})
    assert result.after[(0,1)]==(Action('incref',1),Action('decref',0))


def test_duplicate_phi_ownership_gets_an_extra_reference():
    plan,State,Action,E,O,R=api()
    target=[i.offset for i in dis.get_instructions(prototype)][-1]
    graph=graph_for([(0,(),[('new',(),(0,)),('jump',(),())]),
                     (target,(1,2),[('discard',(1,2),()),('return',(),())])],[(0,target,(0,0))])
    result=plan(graph,{'new':E(outputs=(O(R.OWNED),)),'jump':E(),'discard':E(retire=(1,0)),'return':E()})
    assert result.edges[(0,0)]==(Action('incref',0),)
    assert result.after[(target,0)]==(Action('decref',2),Action('decref',1))

def test_newly_promoted_retired_value_also_invalidates_other_borrow_support():
    plan,State,Action,E,O,R=api()
    graph=graph_for([(0,(),[('borrow_x',(),(0,)),('borrow_d',(),(1,)),
                            ('mutate_discard',(0,),()),('discard',(1,),()),('return',(),())])])
    result=plan(graph,{'borrow_x':E(outputs=(O(R.BORROWED,frozenset({'local:x'})),)),
                      'borrow_d':E(outputs=(O(R.BORROWED,frozenset({'dict:d'})),)),
                      'mutate_discard':E(may_store=frozenset({'local:x'}),retire=(0,)),
                      'discard':E(retire=(0,)),'return':E()})
    assert result.before[(0,2)]==(Action('incref',0),Action('incref',1))


def test_output_cannot_borrow_from_an_input_stolen_inside_the_operation():
    plan,State,Action,E,O,R=api()
    graph=graph_for([(0,(),[('new',(),(0,)),('bad',(0,),(1,)),('discard',(1,),()),('return',(),())])])
    with pytest.raises(ValueError,match='stolen'):
        plan(graph,{'new':E(outputs=(O(R.OWNED),)),'bad':E(outputs=(O(R.BORROWED,frozenset({0})),),steal=(0,)),
                    'discard':E(retire=(0,)),'return':E()})

def test_live_through_borrow_support_follows_transferred_phi_owner():
    plan,State,Action,E,O,R=api()
    target=[i.offset for i in dis.get_instructions(prototype)][-1]
    graph=graph_for([(0,(),[('new',(),(0,)),('borrow',(0,),(1,)),('jump',(),())]),
                     (target,(2,),[('discard',(2,),()),('read',(1,),()),('discard',(1,),()),('return',(),())])],
                    [(0,target,(0,))])
    result=plan(graph,{'new':E(outputs=(O(R.OWNED),)),
                      'borrow':E(outputs=(O(R.BORROWED,frozenset({0})),)),
                      'jump':E(),'discard':E(retire=(0,)),'read':E(),'return':E()})
    assert result.in_states[target][1]==State(R.BORROWED,frozenset({2}))
    assert result.before[(target,0)]==(Action('incref',1),)
    assert result.after[(target,2)]==(Action('decref',1),)
