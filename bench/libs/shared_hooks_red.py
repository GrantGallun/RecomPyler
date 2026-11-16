"""Literal owner-hook REDs; run explicitly before applying shared-hooks-proposed.diff."""
import dis
import gc
from pathlib import Path
import sys
import weakref
import numpy as np


def test_public_compile_accepts_a_shared_ndarray_model_factory():
    from recompyler.ir import compile_function,compilation_info,_entry_native
    from recompyler.libraries.numpy_models import NumpyCalls
    observed=[]
    def read(array,index):return array[index]
    def factory(symbols,provider):
        observed.append(True)
        return NumpyCalls(symbols,provider)
    try:
        assert compile_function(read,strict=True,structure_calls_factory=factory) is read
        assert observed==[True]
        state=_entry_native._compilation_owner(read)
        assert state is not None and 'rc_numpy_try_load' in str(state[1].module)
        assert compilation_info(read)['installed'] is False
    finally:_entry_native.forget_compilation(read)


def test_direct_c_call_hook_keeps_canonical_rebinding_and_errors():
    import math
    from recompyler.ir import build
    from recompyler.libraries.c_calls import CFunctionCall
    sys.path.insert(0,str(Path(__file__).resolve().parents[2]/'tests'))
    try:from test_ir_existing_frame import frame_entry
    finally:sys.path.pop(0)
    namespace={'callee':math.sin}
    exec('def compute(value):\n    return callee(value)\n',namespace)
    function=namespace['compute'];graph=build(function)
    pc=next(op.offset for block in graph.blocks.values() for op in block.operations if op.name=='call')
    guard=CFunctionCall.capture(math.sin)
    entry,lowered,_=frame_entry(function,graph=graph,lowering_options={'library_calls':{pc:guard}})
    assert 'rc_ir_frame_call_library_owned' in str(lowered.module)
    assert entry(.5)==math.sin(.5)
    events=[]
    def replacement(value):events.append(value);return ('replacement',value)
    namespace['callee']=replacement
    assert entry(3)==('replacement',3) and events==[3]
    def failure(value):raise LookupError('exact')
    namespace['callee']=failure
    import pytest
    with pytest.raises(LookupError,match='exact'):entry(1)


def test_c_call_candidate_keeps_neither_bound_receiver_nor_callable_alive():
    from recompyler.libraries.c_calls import CFunctionCall
    events=[]
    class Owner(list):
        def __del__(self):events.append('drop')
    owner=Owner();function=owner.append
    reference=weakref.ref(owner);callable_reference=weakref.ref(function)
    guard=CFunctionCall.capture(function)
    del owner,function;gc.collect()
    assert reference() is None and callable_reference() is None and events==['drop']
    assert type(guard.dispatcher_address) is int and type(guard.context_address) is int
