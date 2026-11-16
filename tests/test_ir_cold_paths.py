"""Frame bookkeeping can be shared without changing source observations."""
import gc
import sys
import weakref
import pytest
from recompyler.ir import build
from recompyler.ir.lower_llvm import lower
from test_ir_existing_frame import frame_entry


def deep_calls():
    names=','.join('a'+str(i) for i in range(20))
    statements='\n'.join('    fn('+names+')' for _ in range(6))
    namespace={}
    exec('def target(fn,'+names+'):\n'+statements+'\n    return 123\n',namespace)
    return namespace['target']


def instruction_count(module):
    return sum(len(block.instructions) for fn in module.functions for block in fn.blocks)


def test_shared_frame_paths_reduce_total_ir_on_repeated_deep_calls():
    source=deep_calls()
    inline=lower(build(source),frame_entry=True,outline_frame_paths=False)
    outlined=lower(build(source),frame_entry=True,outline_frame_paths=True)
    # Count every helper too: moving code into more functions cannot game this.
    assert instruction_count(outlined.module)<instruction_count(inline.module)*0.60


@pytest.mark.parametrize('outlined',[False,True])
def test_stack_publication_preserves_callbacks_errors_and_traceback_lifetimes(outlined):
    def target(make, fail, events):
        local=make('local')
        make('discard')
        events.append('before')
        return fail(local)
    def observe(call):
        events=[];references={}
        class Probe:
            def __init__(self,name):self.name=name
            def __del__(self):
                caller=sys._getframe(1)
                events.append((self.name,caller.f_code.co_name,caller.f_lasti,
                               tuple(sorted(caller.f_locals))))
        def make(name):
            value=Probe(name);references[name]=weakref.ref(value);return value
        def fail(value):
            caller=sys._getframe(1)
            events.append(('callback',caller.f_code is target.__code__,caller.f_lasti,
                           tuple(sorted(caller.f_locals))))
            raise ValueError('cold sentinel')
        try:call(make,fail,events)
        except ValueError as error:
            assert str(error)=='cold sentinel'
            saved=error.__traceback__
            current=saved;source_pc=None
            while current:
                if current.tb_frame.f_code is target.__code__:source_pc=current.tb_lasti
                current=current.tb_next
            assert source_pc is not None
            assert references['local']() is not None
            assert references['discard']() is None
        else:raise AssertionError('native error swallowed')
        del saved
        gc.collect()
        assert references['local']() is None
        return events,source_pc
    expected=observe(target)
    entry,body,status=frame_entry(target,lowering_options={'outline_frame_paths':outlined})
    assert observe(entry)==expected
    assert status.value==1


@pytest.mark.parametrize('value',[None,1,'yes'])
def test_frame_path_mode_rejects_non_boolean_options(value):
    def identity(value):return value
    with pytest.raises(TypeError):lower(build(identity),outline_frame_paths=value)
