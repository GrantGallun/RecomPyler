"""Next independent peephole: a literal tagged word has no CLOSE work."""
from llvmlite import ir
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from recompyler import _source_frames_native as provider

def mixed_graph(value):return {'value':value}['value'] is None

def static_closes(body):
    tag=provider.layout()['tag_refcnt']
    return [instruction for block in body.module.get_global('body').blocks for instruction in block.instructions
            if instruction.opname=='call' and getattr(instruction.callee,'name','')=='rc_ir_frame_word_close'
            and isinstance(instruction.args[0],ir.Constant) and type(instruction.args[0].constant) is int
            and instruction.args[0].constant&tag]

def test_static_tagged_closes_elide_even_when_whole_graph_plan_is_unavailable():
    optimized=lower(build(mixed_graph),frame_entry=True)
    assert optimized.reference_plan is None
    assert not static_closes(optimized)
    assert optimized.refcount_stats['noop_closes']>0

def test_refcount_control_preserves_static_close_helpers():
    baseline=lower(build(mixed_graph),frame_entry=True,refcounts=False)
    assert static_closes(baseline)


def test_dynamic_owned_closes_still_use_canonical_helper():
    body=lower(build(mixed_graph),frame_entry=True)
    closes=[instruction for block in body.module.get_global('body').blocks for instruction in block.instructions
            if instruction.opname=='call' and getattr(instruction.callee,'name','')=='rc_ir_frame_word_close']
    assert closes and any(not isinstance(instruction.args[0],ir.Constant) for instruction in closes)


def test_mortal_code_constants_still_retire_through_canonical_helper():
    import types
    def subject(value):return 'mortal_close_marker' is value
    marker=object()
    constants=tuple(marker if type(value) is str and value=='mortal_close_marker' else value for value in subject.__code__.co_consts)
    function=types.FunctionType(subject.__code__.replace(co_consts=constants),globals())
    body=lower(build(function),frame_entry=True)
    instructions=[instruction for block in body.module.get_global('body').blocks for instruction in block.instructions]
    owners=[instruction for instruction in instructions if instruction.opname=='call' and getattr(instruction.callee,'name','')=='rc_ir_frame_word_newref']
    assert owners
    assert any(instruction.opname=='call' and getattr(instruction.callee,'name','')=='rc_ir_frame_word_close'
               and instruction.args[0] in owners for instruction in instructions)
