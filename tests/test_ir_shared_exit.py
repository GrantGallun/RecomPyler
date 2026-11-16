"""Loop exits consume canonical frame memory instead of live stack SSA."""
import gc
import weakref
import pytest
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from test_ir_existing_frame import frame_entry


def loop_source(callback, value, count):
    while count:
        value=callback(value,callback(value,count))
        count-=1
    return value


def test_loop_error_observer_unbound_and_return_share_one_memory_exit():
    owner=lower(build(loop_source),frame_entry=True)
    body=owner.module.get_global('body')
    cold=[instruction for block in body.blocks for instruction in block.instructions
          if instruction.opname=='call' and instruction.callee.name.startswith('rc_ir_cold_exit')]
    assert len(cold)==1, 'loop stack values escape through separate cold returns'
    exit_block=cold[0].parent
    # The validation error before any bytecode runs is outside every source loop.
    returns=[block for block in body.blocks if block.terminator.opname=='ret'
             and not block.name.startswith('entry')]
    assert returns==[exit_block]
    # The common return can consume entry values and its own loads, never a
    # different bytecode block's computed stackref. Include helper call operands.
    for instruction in exit_block.instructions:
        for operand in instruction.operands:
            if hasattr(operand,'opname'):
                assert operand.parent is exit_block or operand.parent.name=='entry'
    guards=[block for block in body.blocks
            if block.terminator.opname=='br' and exit_block in block.terminator.operands]
    assert len(guards)>8
    assert all(any(i.opname=='store' for i in block.instructions) for block in guards)


@pytest.mark.parametrize('outlined',[False,True])
def test_loop_exit_preserves_live_stack_traceback_and_finalizer_order(outlined):
    def source(make, callback, count):
        value=make('initial')
        while count:
            value=callback(value,make(count))
            count-=1
        return value
    def observe(call):
        events=[];refs=[]
        class Probe:
            def __init__(self,name):self.name=name
            def __del__(self):events.append(('drop',self.name))
        def make(name):
            value=Probe(name);refs.append(weakref.ref(value));return value
        def callback(prior,current):
            events.append(('call',prior.name,current.name))
            if current.name==2:raise ValueError('loop exit sentinel')
            return current
        try:call(make,callback,3)
        except ValueError as error:
            assert str(error)=='loop exit sentinel'
            traceback=error.__traceback__;source_pc=None
            current=traceback
            while current:
                if current.tb_frame.f_code is source.__code__:source_pc=current.tb_lasti
                current=current.tb_next
            assert source_pc is not None
            alive=tuple(ref() is not None for ref in refs)
            assert alive==(False,True,True)
        else:raise AssertionError('error swallowed')
        del traceback
        gc.collect()
        assert not any(ref() is not None for ref in refs)
        return events,source_pc,alive
    expected=observe(source)
    native,owner,status=frame_entry(source,lowering_options={'outline_frame_paths':outlined})
    assert observe(native)==expected
    assert status.value==1
