import gc
import struct
import weakref
import numpy as np
import pytest


def provider():
    from recompyler.libraries import _numpy_native
    return _numpy_native


def test_load_keeps_numpy_scalar_type_and_bits_and_current_storage():
    native=provider()
    for dtype,values in [('float64',[0.0,-0.0,1.25]),('int64',[-(2**63),0,2**63-1])]:
        array=np.array(values,dtype=dtype)
        for index in [0,1,2,-1,-3]:
            value,hit=native.load(array,index)
            expected=array[index]
            assert hit is True and type(value) is type(expected)
            assert value.tobytes()==expected.tobytes()
        assert native.length(array)==(3,True)
        array.resize(1,refcheck=False)
        assert native.length(array)==(1,True)
        assert native.load(array,2)==(None,False)
        assert native.load(array,0)[0].tobytes()==array[0].tobytes()


def test_guard_misses_do_not_invoke_index_or_subclass_protocols():
    native=provider();events=[]
    class Index:
        def __index__(self):events.append('index');return 1
    class Subclass(np.ndarray):
        def __getitem__(self,key):events.append('subclass');return ('own',key)
    array=np.arange(4,dtype='float64')
    key=Index()
    assert native.load(array,key)==(None,False) and not events
    assert array[key]==1 and events==['index']
    child=array.view(Subclass)
    assert native.load(child,0)==(None,False) and events==['index']
    assert child[0]==('own',0) and events==['index','subclass']
    for other in [array[::2],array.astype('>f8'),array.astype('float32'),array.reshape(2,2),np.array(1.0)]:
        assert native.load(other,0)==(None,False)
    for key in [True,np.int64(1),slice(None),2**100,-2**100,99,-99]:
        assert native.load(array,key)==(None,False)


def test_stores_preserve_values_aliases_and_numpy_scalar_results():
    native=provider()
    for dtype,values in [('float64',[0.0,-0.0,np.float64(1.25)]),('int64',[-2**63,2**63-1,np.int64(7)])]:
        array=np.zeros(5,dtype=dtype);view=array[1:]
        expected=array.copy()
        for index,value in enumerate(values):
            assert native.store(view,index,value) is True
            expected[index+1]=value
        assert array.tobytes()==expected.tobytes()
        assert native.store(view,-1,values[-1]) is True
        expected[-1]=values[-1]
        assert array.tobytes()==expected.tobytes()
    floating=np.zeros(1,dtype='float64')
    payload=struct.unpack('d',struct.pack('Q',0x7ff8000000001234))[0]
    assert native.store(floating,0,payload) is True
    assert floating[0].tobytes()==np.float64(payload).tobytes()


def test_store_misses_leave_original_conversion_and_errors_to_numpy():
    native=provider();events=[]
    class Conversion:
        def __float__(self):events.append('convert');return 1.5
    array=np.zeros(2,dtype='float64');value=Conversion()
    assert native.store(array,0,value) is False and not events
    array[0]=value
    assert events==['convert'] and array[0]==1.5
    integer=np.zeros(2,dtype='int64')
    assert native.store(integer,0,2**100) is False
    assert integer.tolist()==[0,0]
    with pytest.raises(OverflowError):integer[0]=2**100
    array.flags.writeable=False
    assert native.store(array,0,2.0) is False
    with pytest.raises(ValueError):array[0]=2.0


def test_numeric_scalar_result_does_not_extend_array_lifetime():
    native=provider();array=np.arange(3,dtype='float64');ref=weakref.ref(array)
    scalar,hit=native.load(array,1)
    del array;gc.collect()
    assert hit is True and type(scalar) is np.float64 and scalar==1.0
    assert ref() is None
