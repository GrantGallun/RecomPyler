"""Real no-NRT machine entry tests; no live-object execution is claimed here."""
import ctypes
import importlib.util

import numpy as np
import pytest


def test_raw_adapter_mechanism_exists():
    assert importlib.util.find_spec('recompyler._direct_adapter') is not None, 'shared raw native adapter is missing'


def source(F, I, top, st, integer, floating):
    F[0] += floating
    I[1] += integer
    return F[0], I[1], I[1] > 0


def checked_exit(F, I, top, st, integer):
    if integer < 0:
        st[0] = 1
        return 0
    return integer + I[0]


def raises_static(F, I, top, st, integer):
    if integer < 0:
        raise ValueError('native failure')
    return integer


def allocation(F, I, top, st, integer):
    return np.empty(integer).sum()


def invoke(entry, arguments, *, integer=0, floating=0.0):
    # Test-owned buffers stay alive through the actual raw machine invocation.
    F = np.zeros(8, dtype=np.float64)
    I = F.view(np.int64)
    top = np.zeros(4, dtype=np.int64)
    st = np.zeros(1, dtype=np.uint8)
    cap = ctypes.c_int64(len(F))
    args_i = (ctypes.c_int64 * max(1, len(arguments)))()
    args_f = (ctypes.c_double * max(1, len(arguments)))()
    for n, kind in enumerate(arguments):
        if kind == 'f': args_f[n] = floating
        else: args_i[n] = integer
    out_i = (ctypes.c_int64 * max(1, len(entry.returns)))(*([-77] * max(1, len(entry.returns))))
    out_f = (ctypes.c_double * max(1, len(entry.returns)))(*([-77.0] * max(1, len(entry.returns))))
    pointers = (ctypes.c_void_p * 9)(F.ctypes.data, I.ctypes.data, top.ctypes.data, st.ctypes.data,
        ctypes.addressof(cap), ctypes.addressof(args_i), ctypes.addressof(args_f),
        ctypes.addressof(out_i), ctypes.addressof(out_f))
    call = ctypes.PYFUNCTYPE(ctypes.c_int, ctypes.POINTER(ctypes.c_void_p))(entry.address)
    status = call(pointers)
    return status, F, I, st, list(out_i), list(out_f)


def build(fn, *args, nrt=False):
    from numba import njit, types
    from recompyler import _direct_adapter as adapter
    signature = (types.float64[::1], types.int64[::1], types.int64[::1], types.uint8[::1], *args)
    return adapter.build(njit(_nrt=nrt, error_model='numpy')(fn), signature)


def test_actual_raw_entry_uses_borrowed_aliasing_arrays_and_typed_results():
    from numba import types
    entry = build(source, types.int64, types.float64)
    assert entry.returns == ('f', 'i', 'b')
    status, F, I, st, out_i, out_f = invoke(entry, ('i', 'f'), integer=3, floating=2.5)
    assert status == 0 and not st[0]
    assert F[0] == out_f[0] == 2.5
    assert I[1] == out_i[1] == 3 and out_i[2] == 1
    assert I[0] == np.float64(2.5).view(np.int64)
    assert entry.abi_version == 1
    assert len(entry.ir_sha256) == 64


def test_checked_status_is_not_turned_into_a_python_exception():
    from numba import types
    entry = build(checked_exit, types.int64)
    status, _, _, st, out_i, _ = invoke(entry, ('i',), integer=-1)
    assert status == 0 and st[0] == 1 and out_i[0] == 0
    assert invoke(entry, ('i',), integer=7)[4][0] == 7


def test_static_native_exception_returns_status_before_any_python_boxing():
    from numba import types
    entry = build(raises_static, types.int64)
    status, _, _, _, out_i, out_f = invoke(entry, ('i',), integer=-1)
    assert status != 0
    assert out_i == [-77] and out_f == [-77.0]
    assert invoke(entry, ('i',), integer=7)[4][0] == 7


def test_nrt_enabled_entry_is_rejected_before_binding():
    from numba import types
    from recompyler import _direct_adapter as adapter
    with pytest.raises(adapter.AdapterDecline, match='NRT'):
        build(source, types.int64, types.float64, nrt=True)


def test_allocating_or_callback_capable_code_never_gets_a_raw_binding():
    from numba import types
    from recompyler import _direct_adapter as adapter
    with pytest.raises(adapter.AdapterDecline):
        build(allocation, types.int64)


def test_entry_owns_environments_after_dispatcher_collection():
    import gc
    from numba import njit, types
    from recompyler import _direct_adapter as adapter
    dispatcher = njit(_nrt=False)(checked_exit)
    signature = (types.float64[::1], types.int64[::1], types.int64[::1], types.uint8[::1], types.int64)
    entry = adapter.build(dispatcher, signature)
    assert entry.environments, 'machine code and Python environment ownership are separate'
    del dispatcher
    gc.collect()
    assert invoke(entry, ('i',), integer=17)[4][0] == 17
