"""Guarded one-argument builtin calls on the original CALL operand stack."""

def type_sites(graph):
    producers={value.id:op for block in graph.blocks.values() for op in block.operations for value in op.results}
    result=set()
    for block in graph.blocks.values():
        for op in block.operations:
            if op.name!='call' or op.attributes['oparg']!=1:continue
            source=producers.get(op.arguments[0].id)
            if source is not None and source.name=='global.load' and source.attributes.get('argval')=='type':result.add(op.offset)
    return frozenset(result)


def emit_type(builder,operands,*,frame,base,pending,canonical,helper,integer,pointer,raw,p,i32,null_word):
    from llvmlite import ir
    matches=builder.and_(builder.icmp_unsigned('==',raw(operands[0]),pointer(().__class__.__class__)),
                        builder.icmp_unsigned('==',operands[1],null_word))
    native=builder.function.append_basic_block('builtin_type')
    fallback=builder.function.append_basic_block('builtin_type_fallback')
    finish=builder.function.append_basic_block('builtin_type_join')
    builder.cbranch(matches,native,fallback);builder.position_at_end(native)
    result=helper('type_call_owned',p,[frame,base,pending])
    source=builder.block;builder.branch(finish);builder.position_at_end(fallback)
    other=canonical();other_source=builder.block;builder.branch(finish);builder.position_at_end(finish)
    merged=builder.phi(p);merged.add_incoming(result,source);merged.add_incoming(other,other_source)
    return merged
