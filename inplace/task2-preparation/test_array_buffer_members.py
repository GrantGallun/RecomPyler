"""S53 fail-first buffer-member preparation; no product capability is claimed."""
from array import array
from pathlib import Path
import hashlib,json,struct
import pytest
from recompyler import heap

class BufferBox:
    def __init__(self,data):self.data=data

def read_member(box,index):return box.data[index]
def store_member(box,index,value):
    old=box.data[index]
    box.data[index]=value
    return old

def write_then_read(box,index):
    box.data[0]+=1.0
    return box.data[index]

def resize_through_callback(box,callback):
    return callback(box.data)

def bits(value):return struct.pack('!d',value)
def make_array(bit_patterns):
    value=array('d')
    value.frombytes(b''.join(struct.pack('=Q',x) for x in bit_patterns))
    return value

def test_reused_peer_plain_numba_probe():
    from numba import njit
    data=json.loads(Path(__file__).with_name('array-buffer-probe-source.json').read_text())
    assert hashlib.sha256(data['source'].encode()).hexdigest()==data['source_sha256']
    namespace={};exec(compile(data['source'],str(Path(__file__))+'-peer-probe','exec'),namespace)
    native=njit(namespace['borrowed'])
    values=array('d',[1.25,-0.0])
    for wanted in (2.25,3.25):
        result=native(values)
        assert tuple(map(bits,result))==(bits(wanted),bits(-0.0))
        assert values[0]==wanted and bits(values[1])==bits(-0.0)
    values[0]=10.0
    assert native(values)==(11.0,-0.0)
    assert native.nopython_signatures
    # The export must have been released after native return.
    values.append(8.0)

@pytest.mark.parametrize('pattern',[0x8000000000000000,0x7ff8000000000042,0x7ff8000000001234,0x3ff4000000000000])
def test_direct_member_read_preserves_exact_bits_first_warm_and_python_write(pattern):
    values=make_array([pattern]);box=BufferBox(values);region=heap.lift_region(read_member)
    for call in (1,2):
        expected=read_member(box,0);actual=region(box,0)
        assert type(actual) is float and bits(actual)==bits(expected)
        assert region.compiled_calls==call and region.fallback_calls==0,region.problem
        assert region.direct_calls==call
        assert box.data is values
    values[0]=-0.0
    assert bits(region(box,0))==bits(-0.0) and region.direct_calls==3
    values.append(9.0)  # no leaked Py_buffer on success

@pytest.mark.parametrize('replacement',[-0.0,1.25])
def test_direct_member_store_updates_original_storage_and_releases_export(replacement):
    values=array('d',[4.5,8.0]);box=BufferBox(values);region=heap.lift_region(store_member)
    actual=region(box,0,replacement)
    assert bits(actual)==bits(4.5) and bits(values[0])==bits(replacement)
    assert box.data is values and region.compiled_calls==1 and region.fallback_calls==0,region.problem
    assert region.direct_calls==1
    values.append(9.0)

def test_exception_after_store_replays_once_and_releases_export():
    values=array('d',[4.5]);box=BufferBox(values);region=heap.lift_region(write_then_read)
    assert region(box,0)==5.5
    assert region.compiled_calls==1 and region.direct_calls==1
    before=values[0]
    with pytest.raises(IndexError):region(box,9)
    assert values[0]==before+1.0  # rollback before replay, no double store
    assert region.direct_calls==1 and region.fallback_calls==1
    values.append(9.0)

def test_unknown_resize_callback_stays_python_and_keeps_order():
    values=array('d',[4.5]);box=BufferBox(values);events=[]
    def resize(data):
        events.append('resize');data.append(8.0);return len(data)
    region=heap.lift_region(resize_through_callback)
    assert region(box,resize)==2 and list(values)==[4.5,8.0]
    assert events==['resize'] and region.compiled_calls==0 and region.fallback_calls==1
