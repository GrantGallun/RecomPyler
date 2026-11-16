import numpy as np
from test_ir_existing_frame import frame_entry


def test_shared_lowerer_uses_ndarray_guards_and_preserves_overlapping_views():
    from recompyler.libraries.numpy_models import NumpyCalls
    from recompyler.ir import build
    from recompyler.ir.structure_lowerings import specialize_structure_calls,select_structure_calls
    from recompyler.ir.symbols import CPythonSymbols
    from recompyler import _structure_ops_native
    def transform(array,output):
        for index in range(len(array)):
            output[index]=array[index]*2.0+1.0
        return output
    expected=np.arange(6,dtype='float64')
    transform(expected[:-1],expected[1:])
    for _ in range(8):transform(np.arange(5,dtype='float64'),np.empty(5,dtype='float64'))
    graph=specialize_structure_calls(build(transform),immediate_offsets=True)
    graph=select_structure_calls(graph,{'getitem','setitem','load_attr','store_attr','contains'})
    models=NumpyCalls(CPythonSymbols(),_structure_ops_native,count_hits=True)
    entry,lowered,_=frame_entry(transform,graph=graph,structure_calls=models,
                               lowering_options={'owned_readonly_loops':True})
    array=np.arange(6,dtype='float64');output=array[1:]
    assert entry(array[:-1],output) is output
    assert models.hits.value==10
    assert array.tobytes()==expected.tobytes()
    assert 'rc_numpy_try_load' in str(lowered.module) and 'rc_numpy_try_store' in str(lowered.module)
