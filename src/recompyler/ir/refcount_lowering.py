"""Bounded STACKREF consumer of the reviewed reference ownership dataflow.

The first consumer removes only CLOSE/DUP helper calls whose source stackref
is provably tagged (immortal, NULL, or an original CPython borrow). It never
changes a word, extends a lifetime, or removes an owned retirement. Shapes
requiring promotion/edge reconciliation keep the existing emitter unchanged.
"""
from dataclasses import dataclass
from .refcount import plan_refcounts
from .refcount_effects import Effects,Output,RefKind


@dataclass(frozen=True)
class ReferenceLoweringPlan:
    plan: object
    skip_retire: dict
    skip_copy: frozenset


_PLAIN={'resume','nop','jump','swap'}
_BORROW={'frame.borrow','frame.borrow_borrow'}
_LOAD={'frame.load','frame.load_check','frame.load_load','frame.take'}
_RETIRE={'load_attr','binary','is','contains','compare','to_bool','branch','pop','store_attr','store_subscr','call','call_kw','get_iter','unary'}
_SUPPORTED=_PLAIN|_BORROW|_LOAD|_RETIRE|{'constant','small_int','null','global.load','copy','frame.store','return'}


def _outputs(operation):
    name=operation.name
    if name in _BORROW:return (RefKind.BORROWED,)*len(operation.results)
    if name in {'small_int','null','is','contains','to_bool'}:
        return (RefKind.UNCOUNTED,)*len(operation.results)
    if name=='constant':
        value=operation.attributes.get('argval')
        # LOAD_CONST's actual operand is available through the original code
        # in prepare_reference_plan; no application equality is consulted.
        return (RefKind.UNCOUNTED if value is None or value is True or value is False else RefKind.OWNED,)
    if name=='global.load':
        return (RefKind.OWNED,RefKind.UNCOUNTED) if len(operation.results)==2 else (RefKind.OWNED,)
    if name=='compare' and operation.attributes['oparg']&16:return (RefKind.UNCOUNTED,)
    if name=='unary' and operation.instruction.opname=='UNARY_NOT':return (RefKind.UNCOUNTED,)
    if name=='copy':return None
    return (RefKind.OWNED,)*len(operation.results)


def prepare_reference_plan(graph):
    """Return a verified no-op elision plan, or retain the original lowering.

    No source callbacks run here. Exception/suspension support and insertion of
    new owners are deliberately left to their future explicit consumers.
    """
    if graph.exceptions or graph.blocks[graph.entry].parameters:return None
    if any(edge.kind in ('exception','resume') for block in graph.blocks.values() for edge in block.edges):return None
    operations=[op for block in graph.blocks.values() for op in block.operations]
    if any(op.name not in _SUPPORTED or op.name=='load_attr' and op.attributes.get('method') for op in operations):return None
    kinds={}
    for op in operations:
        outputs=_outputs(op)
        if op.name=='constant':
            value=graph.code.co_consts[op.attributes['oparg']]
            outputs=(RefKind.UNCOUNTED if value is None or value is True or value is False else RefKind.OWNED,)
        if outputs is not None:kinds.update((value.id,kind) for value,kind in zip(op.results,outputs))
    # Original stack parameters and COPY transport the same tagged word. Mixed
    # owned joins stay owned; the reviewed pass decides whether edges need work.
    changed=True
    while changed:
        changed=False
        for key,block in graph.blocks.items():
            for index,param in enumerate(block.parameters):
                incoming=[edge.arguments[index] for source in graph.blocks.values() for edge in source.edges if edge.target==key]
                if not incoming or any(value.id not in kinds for value in incoming):continue
                incoming_kinds={kinds[value.id] for value in incoming}
                kind=(RefKind.OWNED if RefKind.OWNED in incoming_kinds else
                      RefKind.BORROWED if RefKind.BORROWED in incoming_kinds else RefKind.UNCOUNTED)
                if kinds.get(param.id) is not kind:kinds[param.id]=kind;changed=True
            for op in block.operations:
                if op.name=='copy' and op.arguments[0].id in kinds:
                    kind=kinds[op.arguments[0].id]
                    if kinds.get(op.results[0].id) is not kind:kinds[op.results[0].id]=kind;changed=True
    if any(value.id not in kinds for block in graph.blocks.values() for value in block.parameters):return None
    if any(value.id not in kinds for op in operations for value in op.arguments+op.results):return None
    descriptions={}
    for op in operations:
        outputs=tuple(Output(kinds[value.id]) for value in op.results)
        if op.name in {'return','frame.store'}:
            effect=Effects(outputs=outputs,steal=(0,),arbitrary=op.name=='frame.store')
        elif op.name in _RETIRE:
            order=(1,0) if op.name in {'compare','is','contains'} else tuple(range(len(op.arguments)))
            if op.name in {'store_attr','store_subscr'}:order=tuple(reversed(order))
            effect=Effects(outputs=outputs,retire=order,arbitrary=op.name not in {'is','branch','pop'})
        else:effect=Effects(outputs=outputs)
        descriptions[op.offset]=effect
    try:plan=plan_refcounts(graph,lambda op:descriptions[op.offset])
    except (ValueError,KeyError):return None
    if (any(actions for actions in plan.before.values()) or
            any(actions for actions in plan.edges.values()) or
            any(action.kind!='decref' for actions in plan.after.values() for action in actions)):
        return None
    skip={};copies=set()
    for key,block in graph.blocks.items():
        for index,op in enumerate(block.operations):
            decrefs={action.value for action in plan.after.get((key,index),())}
            skipped=frozenset(operand for operand in descriptions[op.offset].retire
                if op.arguments[operand].id not in decrefs and kinds[op.arguments[operand].id] in (RefKind.BORROWED,RefKind.UNCOUNTED))
            if skipped:skip[op.offset]=skipped
            if op.name=='copy' and kinds[op.arguments[0].id] in (RefKind.BORROWED,RefKind.UNCOUNTED):copies.add(op.offset)
    return ReferenceLoweringPlan(plan,skip,frozenset(copies))
