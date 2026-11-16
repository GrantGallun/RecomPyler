import builtins
import gc
import weakref
import numpy as np
import pytest
from recompyler.ir import build


def affine(array,output):
    for index in range(len(array)):
        output[index]=array[index]*2.0+1.0
    return output


def test_plan_comes_from_shared_ssa_and_retains_no_function_or_code():
    from recompyler.libraries.gpu import plan_loop
    def local(array,output):
        for index in range(len(array)):
            output[index]=array[index]*2.0+1.0
        return output
    ref=weakref.ref(local);code=weakref.ref(local.__code__)
    plan=plan_loop(build(local))
    assert plan.input_slot==0 and plan.output_slot==1
    assert plan.expression==('add',('multiply',('load',),('constant',2.0)),('constant',1.0))
    assert plan.guard(local,(np.arange(8,dtype='float64'),np.zeros(8,dtype='float64'))) is None
    del local;gc.collect()
    assert ref() is None
    # Nested code can be retained by this test's enclosing code object.
    assert plan.code_reference is not None and callable(plan.code_reference)


def test_plan_declines_sequential_reduction_neighbor_reads_and_python_effects():
    from recompyler.libraries.gpu import plan_loop,LoopDeclined
    def reduction(array,output):
        total=0.0
        for index in range(len(array)):total+=array[index]
        return total
    def neighbors(array,output):
        for index in range(len(array)-1):output[index]=array[index+1]
        return output
    def callback(array,output):
        for index in range(len(array)):output[index]=float(array[index])
        return output
    def divide(array,output):
        for index in range(len(array)):output[index]=array[index]/2.0
        return output
    for function in [reduction,neighbors,callback,divide]:
        with pytest.raises(LoopDeclined):plan_loop(build(function))


def test_guards_reject_aliases_layouts_callbacks_nonfinite_and_overflow():
    from recompyler.libraries.gpu import plan_loop
    plan=plan_loop(build(affine));array=np.arange(8,dtype='float64');out=np.zeros_like(array)
    assert plan.guard(affine,(array,out)) is None
    assert plan.guard(affine,(array,array))=='overlapping arrays'
    for bad in [array[::2],array.astype('float32'),array.astype('>f8'),array.reshape(2,4),[1.0]*8]:
        assert plan.guard(affine,(bad,out)) is not None
    class Child(np.ndarray):pass
    assert plan.guard(affine,(array.view(Child),out)) is not None
    out.flags.writeable=False
    assert plan.guard(affine,(array,out))=='readonly output'
    out.flags.writeable=True
    for value in [float('nan'),float('inf'),float('-inf'),np.finfo('float64').max]:
        array[0]=value
        assert plan.guard(affine,(array,out)) is not None
    array[0]=0
    original=affine.__globals__.get('range',None)
    affine.__globals__['range']=lambda n:()
    try:assert plan.guard(affine,(array,out))=='builtin binding changed'
    finally:
        if original is None:del affine.__globals__['range']
        else:affine.__globals__['range']=original


def test_gpu_arithmetic_matches_signed_zero_subnormal_and_rounding_bits():
    from recompyler.libraries.gpu import plan_loop,GpuLoop
    plan=plan_loop(build(affine));candidate=GpuLoop(plan)
    array=np.array([0.0,-0.0,5e-324,-5e-324,0.1,-0.1,1.0000000000000002,-0.5000000000000001],dtype='float64')
    expected=np.empty_like(array);affine(array,expected)
    output=np.empty_like(array)
    assert candidate.execute(affine,array,output) is output
    assert output.tobytes()==expected.tobytes()
    assert candidate.last_backend=='cuda' and candidate.transfers_included is True
    assert candidate.fastmath is False and candidate.lto is False


def test_gpu_wrong_bits_are_rejected_before_writing_the_callers_output(monkeypatch):
    from recompyler.libraries.gpu import plan_loop,GpuLoop
    candidate=GpuLoop(plan_loop(build(affine)))
    array=np.arange(8,dtype='float64');output=np.full_like(array,-999.0)
    expected=np.empty_like(array);affine(array,expected)
    def wrong(source,target):
        assert np.all(output==-999.0)
        target.fill(0.0)
    monkeypatch.setattr(candidate,'_run_gpu',wrong,raising=False)
    assert candidate.execute(affine,array,output) is output
    assert output.tobytes()==expected.tobytes()
    assert candidate.last_backend=='python' and candidate.note=='GPU results differed from CPU'
    assert candidate.verified_shapes==set() and len(candidate.rejected_shapes)==1


def test_changed_builtin_range_binding_is_not_admitted(monkeypatch):
    from recompyler.libraries.gpu import plan_loop,LoopDeclined
    plan=plan_loop(build(affine))
    array=np.arange(8,dtype='float64');out=np.zeros_like(array)
    original=builtins.range
    def replacement(*args):return original(0)
    with monkeypatch.context() as changed:
        changed.setattr(builtins,'range',replacement)
        reason=plan.guard(affine,(array,out))
    assert reason=='builtin binding changed'


def test_small_gpu_loop_adds_no_numba_occupancy_warning():
    import warnings
    from numba.core.errors import NumbaPerformanceWarning
    from recompyler.libraries.gpu import plan_loop,GpuLoop
    array=np.arange(8,dtype='float64');output=np.empty_like(array)
    candidate=GpuLoop(plan_loop(build(affine)))
    with warnings.catch_warnings(record=True) as caught:
        warnings.simplefilter('always')
        candidate.execute(affine,array,output)
    assert candidate.last_backend=='cuda'
    assert not [warning for warning in caught if 'under-utilization' in str(warning.message)]


def test_gpu_guard_checks_floating_environment_after_a_shape_is_verified(monkeypatch):
    import recompyler.libraries.gpu as loops
    array=np.arange(8,dtype='float64');output=np.empty_like(array)
    candidate=loops.GpuLoop(loops.plan_loop(build(affine)))
    candidate.execute(affine,array,output)
    assert candidate.last_backend=='cuda'
    monkeypatch.setattr(loops,'default_floating_mode',lambda:False,raising=False)
    candidate.execute(affine,array,output)
    assert candidate.last_backend=='python' and candidate.note=='nondefault floating environment'


def test_actual_upward_rounding_uses_python_after_nearest_shape_seed():
    import ctypes
    import os
    from recompyler.libraries.gpu import plan_loop,GpuLoop
    if os.name!='nt':pytest.skip('Windows CRT rounding regression')
    control=ctypes.CDLL('ucrtbase')._controlfp_s
    control.argtypes=[ctypes.POINTER(ctypes.c_uint),ctypes.c_uint,ctypes.c_uint]
    control.restype=ctypes.c_int
    saved=ctypes.c_uint();assert control(ctypes.byref(saved),0,0)==0
    candidate=GpuLoop(plan_loop(build(affine)))
    array=np.zeros(8,dtype='float64');output=np.empty_like(array)
    candidate.execute(affine,array,output);assert candidate.last_backend=='cuda'
    try:
        current=ctypes.c_uint();assert control(ctypes.byref(current),0x200,0x300)==0
        array.fill(0.1);expected=np.empty_like(array);affine(array,expected)
        candidate.execute(affine,array,output)
        actual=output.tobytes();wanted=expected.tobytes();backend=candidate.last_backend
    finally:
        current=ctypes.c_uint();assert control(ctypes.byref(current),saved.value,0x300)==0
    assert actual==wanted and backend=='python'


def test_gpu_non_power_of_two_multiplication_and_subtraction_match_every_bit():
    from recompyler.libraries.gpu import plan_loop,GpuLoop
    def arithmetic(array,output):
        for index in range(len(array)):
            output[index]=(array[index]*1.0000001-0.1)*0.5
        return output
    array=np.random.default_rng(71).uniform(-1e150,1e150,4096).astype('float64')
    array[:8]=[0.0,-0.0,5e-324,-5e-324,0.1,-0.1,1.0000000000000002,1.0]
    expected=np.empty_like(array);arithmetic(array,expected)
    candidate=GpuLoop(plan_loop(build(arithmetic)));output=np.empty_like(array)
    candidate.execute(arithmetic,array,output)
    assert candidate.last_backend=='cuda'
    assert output.tobytes()==expected.tobytes()


@pytest.mark.parametrize('name',['isfinite','max','abs','geterr','empty_like','array','asarray','asanyarray','ascontiguousarray','empty','dtype','ndarray'])
def test_rebound_numpy_helper_does_not_add_callbacks_to_an_admitted_loop(monkeypatch,name):
    from recompyler.libraries.gpu import plan_loop,GpuLoop
    candidate=GpuLoop(plan_loop(build(affine)))
    array=np.arange(8,dtype='float64');output=np.empty_like(array)
    candidate.execute(affine,array,output)
    assert candidate.last_backend=='cuda'
    events=[];original=getattr(np,name)
    def replacement(*args,**kwargs):events.append('unexpected callback');return original(*args,**kwargs)
    monkeypatch.setattr(np,name,replacement)
    candidate.execute(affine,array,output)
    assert events==[]
    assert candidate.last_backend=='python' and candidate.note=='NumPy helper binding changed'



def test_rebinding_before_gpu_module_import_is_also_refused(monkeypatch):
    import importlib
    import recompyler.libraries.gpu as loops
    events=[];original=np.isfinite
    array=np.arange(8,dtype='float64');output=np.empty_like(array)
    def replacement(*args,**kwargs):events.append('unexpected callback');return original(*args,**kwargs)
    try:
        with monkeypatch.context() as changed:
            changed.setattr(np,'isfinite',replacement)
            importlib.reload(loops)
            candidate=loops.GpuLoop(loops.plan_loop(build(affine)))
            candidate.execute(affine,array,output)
            assert events==[] and candidate.last_backend=='python'
            assert candidate.note=='NumPy helper binding changed'
    finally:importlib.reload(loops)
