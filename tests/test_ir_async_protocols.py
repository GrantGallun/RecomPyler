"""Canonical async iterator adapters retain exact slot behavior and ownership."""
import ctypes
import pytest
from recompyler import _source_frames_native as provider


def adapters():
    addresses=provider.addresses()
    get=ctypes.PYFUNCTYPE(ctypes.c_void_p,ctypes.py_object)(addresses['async_iter_get'])
    check=ctypes.PYFUNCTYPE(ctypes.c_void_p,ctypes.c_void_p)(addresses['async_iter_check'])
    release=ctypes.PYFUNCTYPE(None,ctypes.c_void_p)(ctypes.cast(ctypes.pythonapi.Py_DecRef,ctypes.c_void_p).value)
    return get,check,release


def test_async_iterator_slot_returns_the_original_owned_iterator():
    get,check,release=adapters()
    class Iterator:
        def __aiter__(self):return self
        async def __anext__(self):raise StopAsyncIteration
    iterator=Iterator()
    pointer=check(get(iterator))
    try:assert ctypes.cast(pointer,ctypes.py_object).value is iterator
    finally:release(pointer)


def test_async_iterator_missing_slot_uses_original_type_error():
    get,_,_=adapters()
    with pytest.raises(TypeError,match="'async for' requires an object with __aiter__ method, got int"):
        get(12)


def test_async_iterator_invalid_result_is_retired_after_source():
    get,check,_=adapters();events=[]
    class Invalid:
        def __del__(self):events.append('result')
    class Source:
        def __aiter__(self):events.append('get');return Invalid()
        def __del__(self):events.append('source')
    source=Source();pointer=get(source);del source
    assert events==['get','source']
    with pytest.raises(TypeError,match='does not implement __anext__: Invalid'):
        check(pointer)
    assert events==['get','source','result']


def test_async_iterator_slot_error_keeps_the_exact_exception():
    get,_,_=adapters();error=LookupError('async slot')
    class Source:
        def __aiter__(self):raise error
    with pytest.raises(LookupError) as caught:get(Source())
    assert caught.value is error


def test_repeated_address_exports_do_not_retain_temporary_address_integers():
    import tracemalloc
    owned=not tracemalloc.is_tracing()
    if owned:tracemalloc.start()
    try:
        provider.addresses()
        before=tracemalloc.get_traced_memory()[0]
        for _ in range(2048):provider.addresses()
        retained=tracemalloc.get_traced_memory()[0]-before
    finally:
        if owned:tracemalloc.stop()
    assert retained<32768, retained
