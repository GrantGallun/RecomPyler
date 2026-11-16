"""Virtualization keeps Python allocations and observable owner timing exact."""
from dataclasses import replace
from test_ir_memory_proofs import linear
from recompyler.ir.virtual_proofs import RAW_RECORD, VirtualEffect, plan_virtuals


def virtual_case(barrier=False):
    names=['seed','alloc','read','release'] if not barrier else ['seed','alloc','call','read','release']
    graph,_,ops=linear(names,{})
    handle=replace(ops[1].results[0],type=RAW_RECORD)
    operations=list(ops)
    operations[1]=replace(ops[1],results=(handle,))
    get=3 if barrier else 2
    release=4 if barrier else 3
    operations[get]=replace(ops[get],arguments=(handle,))
    operations[release]=replace(ops[release],arguments=(handle,),results=())
    operations[-1]=replace(ops[-1],arguments=(ops[0].results[0],))
    graph.blocks[0].operations=operations
    effects={operations[0].offset:VirtualEffect('neutral',inert=True),
             operations[1].offset:VirtualEffect('alloc',fields=('x',),invisible=True,inert=True),
             operations[get].offset:VirtualEffect('read',field='x',inert=True),
             operations[release].offset:VirtualEffect('release',inert=True)}
    return graph,effects,operations,get


def test_private_raw_record_is_scalar_replaceable():
    graph,effects,ops,get=virtual_case()
    plan=plan_virtuals(graph,effects)
    assert plan.removable==(ops[1].offset,)
    assert plan.replacements[ops[get].offset]==ops[0].results[0]


def test_unknown_observer_forces_materialization():
    graph,effects,ops,get=virtual_case(True)
    plan=plan_virtuals(graph,effects)
    assert not plan.removable and not plan.replacements
    assert ops[1].offset in plan.rejected


def test_visible_python_allocation_never_disappears():
    graph,effects,ops,get=virtual_case()
    effects[ops[1].offset]=replace(effects[ops[1].offset],invisible=False)
    assert not plan_virtuals(graph,effects).removable


def test_unreleased_or_escaping_record_is_retained():
    graph,effects,ops,get=virtual_case()
    effects.pop(ops[-2].offset)
    assert not plan_virtuals(graph,effects).removable

