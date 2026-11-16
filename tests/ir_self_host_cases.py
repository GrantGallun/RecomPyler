"""Fresh actual-function native entry accounting for the self-host runner."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[1]/'tools'))
from ir_self_host import CountedBody
from recompyler import heap
from recompyler.ir.compiler import compile_function, _install_prepared
from recompyler.ir import _entry_native

function = heap._find
code = function.__code__
compile_function(function, strict=True)
source, original = _entry_native._compilation_owner(function)
owner = CountedBody(original)
_entry_native.forget_compilation(function)
_entry_native.prepare_frame_entry(function, owner.body_address, owner, source)
assert owner.calls.value == 0
assert _install_prepared(function)
class Node:
    parent = None
root = Node()
try:
    if sys.argv[-1] == 'observer':
        from ir_self_host import CandidateRefresh, install_candidate
        handle = _entry_native._compilation_handle(function)
        refresh = CandidateRefresh({function:handle}, install_candidate, installed=[function])
        def trace(frame,event,arg): return trace
        for observer in ('trace','monitor'):
            if observer == 'trace': sys.settrace(trace)
            else:
                sys.monitoring.use_tool_id(5,'selfhost-refresh-test')
                sys.monitoring.set_events(5,sys.monitoring.events.PY_START)
            try:
                assert function(root) is root
                refresh()
            finally:
                if observer == 'trace': sys.settrace(None)
                else:
                    sys.monitoring.set_events(5,0)
                    sys.monitoring.free_tool_id(5)
            refresh()
            assert function(root) is root
            refresh()
            before = owner.calls.value
            assert function(root) is root and owner.calls.value == before+1
        assert refresh.reinstallations >= 2
        print('PASS native entry recovered after trace and monitoring')
    elif sys.argv[-1] == 'rearm':
        import ctypes
        interpreter = ctypes.pythonapi.PyInterpreterState_Get
        interpreter.argtypes = (); interpreter.restype = ctypes.c_void_p
        sweep = ctypes.pythonapi._Py_Executors_InvalidateCold
        sweep.argtypes = (ctypes.c_void_p,); sweep.restype = None
        sweep(interpreter()); sweep(interpreter())
        assert not _entry_native.compilation_info(function)['installed']
        assert _install_prepared(function), 'prepared native body must be reinstallable after cold eviction'
        assert function(root) is root and owner.calls.value == 1
        print('PASS cold native entry reinstalled')
    elif sys.argv[-1] == 'cold':
        import ctypes
        interpreter = ctypes.pythonapi.PyInterpreterState_Get
        interpreter.argtypes = (); interpreter.restype = ctypes.c_void_p
        sweep = ctypes.pythonapi._Py_Executors_InvalidateCold
        sweep.argtypes = (ctypes.c_void_p,); sweep.restype = None
        for step in range(3):
            before = owner.calls.value
            assert function(root) is root
            sweep(interpreter())
            assert owner.calls.value == before + 1 and _entry_native.compilation_info(function)['installed'], step
        print('PASS native entries remain warm')
    else:
        assert function(root) is root
        assert function(cell=root) is root
        assert owner.calls.value == 2
    assert function.__code__ is code and _entry_native.compilation_info(function)['installed']
finally:
    _entry_native.forget_compilation(function)
assert _entry_native.compilation_info(function) is None
assert function(root) is root
print('PASS self-host actual native entries='+str(owner.calls.value))
