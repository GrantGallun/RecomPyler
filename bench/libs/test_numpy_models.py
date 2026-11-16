import ctypes
import numpy as np


def test_shared_lowerer_executes_guarded_ndarray_operations_and_preserves_aliases():
    from recompyler.libraries.numpy_models import NumpyCalls
    from recompyler.ir import build
    from recompyler.ir.lower_llvm import lower
    from recompyler.ir.structure_lowerings import specialize_structure_calls,select_structure_calls
    from recompyler.ir.symbols import CPythonSymbols
    from recompyler import _structure_ops_native
    from recompyler.ir._entry_native import prepare_frame_entry,forget_compilation
    from tools.ir_self_host import CountedBody,install_candidate
    def transform(array,output):
        for index in range(len(array)):
            output[index]=array[index]*2.0+1.0
        return output
    expected=np.arange(6,dtype='float64')
    transform(expected[:-1],expected[1:])
    array=np.arange(6,dtype='float64')
    for _ in range(8):transform(np.arange(5,dtype='float64'),np.empty(5,dtype='float64'))
    graph=specialize_structure_calls(build(transform),immediate_offsets=True)
    graph=select_structure_calls(graph,{'getitem','setitem','load_attr','store_attr','contains'})
    models=NumpyCalls(CPythonSymbols(),_structure_ops_native,count_hits=True)
    lowered=lower(graph,frame_entry=True,structure_calls=models,owned_readonly_loops=True)
    counter=CountedBody(lowered.execution_owner)
    prepare_frame_entry(transform,counter.body_address,counter,transform.__code__)
    try:
        assert install_candidate(transform)
        counter.calls.value=0;models.hits.value=0
        output=array[1:]
        assert transform(array[:-1],output) is output
        assert counter.calls.value==1
        assert models.hits.value==10
        assert array.tobytes()==expected.tobytes()
        assert 'rc_numpy_try_load' in str(lowered.module) and 'rc_numpy_try_store' in str(lowered.module)
    finally:forget_compilation(transform)
