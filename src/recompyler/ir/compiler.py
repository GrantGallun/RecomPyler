"""Public native compilation with conservative, separately measured deployment.

Compilation never invokes the target. The returned function is the original:
its ordinary vectorcall and CPython binding remain intact. A real LLVM body is
retained independently of the source function. Unmeasured bodies stay prepared,
with Python executing unchanged; compilation_info distinguishes installation.
"""
from types import FunctionType
from .builder import build, UnsupportedBytecode
from .lower_llvm import lower
from weakref import WeakKeyDictionary
import math
import dis
import inspect

# Numeric measurements only: no value can hold its weak function key alive.
_measurements=WeakKeyDictionary()
_frameless_candidates=WeakKeyDictionary()


def _record_measurement(function,cpython_ns,native_ns):
    """Record an actual locked measurement for this exact prepared body."""
    info=compilation_info(function)
    if info is None:raise ValueError('compile the function before measuring')
    if not all(type(x) in (int,float) and math.isfinite(x) and x>0 for x in (cpython_ns,native_ns)):
        raise ValueError('positive finite measured times required')
    _measurements[function]=(info['deployment_body_address'],float(cpython_ns),float(native_ns))


def _install_prepared(function,*,expected_address=None):
    """Internal candidate installation; callers own timing/selection policy."""
    import sys
    from . import _entry_native
    from .entry import install_frame_entry
    info=compilation_info(function)
    if info is None or info['installed']:return bool(info and info['installed'])
    candidate=_frameless_candidates.get(function)
    if candidate is not None:
        if expected_address is not None and candidate.body_address!=expected_address:return False
        try:return candidate.install().active
        except (TypeError,ValueError,RuntimeError):return False
    if not sys._jit.is_enabled():return False
    state=_entry_native._compilation_owner(function)
    if state is None:return False
    code,owner=state
    if expected_address is not None and owner.body_address!=expected_address:return False
    prepared=_entry_native._compilation_handle(function)
    if prepared is None:return False
    try:
        handle=install_frame_entry(function,owner.body_address,owner,
            seed_arguments=(None,)*code.co_argcount,
            seed_keywords={name:None for name in code.co_varnames[code.co_argcount:code.co_argcount+code.co_kwonlyargcount]} if code.co_kwonlyargcount else None,
            entry_offset=owner.entry_offset,
            expected_code=code,expected_prepared=prepared)
    except (TypeError,ValueError,RuntimeError):return False
    return handle is prepared and handle.active


def _install_if_measured(function,info):
    measured=_measurements.get(function)
    if measured is not None and measured[0]==info['deployment_body_address'] and measured[2]<measured[1]:
        _install_prepared(function,expected_address=info['deployment_body_address'])



def compilation_info(function):
    from . import _entry_native
    info=_entry_native.compilation_info(function)
    if type(function) is not FunctionType:return info
    candidate=_frameless_candidates.get(function)
    if info is None:
        if candidate is not None:candidate.close();_frameless_candidates.pop(function,None)
        return None
    info['frameless_eligible']=candidate is not None
    info['deployment_abi']='callback-free-vectorcall' if candidate is not None else 'frame'
    info['deployment_body_address']=candidate.body_address if candidate is not None else info['body_address']
    if candidate is not None and candidate.active:
        info.update(installed=True,abi='callback-free-vectorcall',body_address=candidate.body_address)
    return info


def compile_function(function, *, strict=False, structure_calls_factory=None, library_calls=None):
    """Compile without executing the target; leave unsupported functions in Python.

    Native compilation and measured deployment are distinct. A prepared body is
    real machine code, never just an IR graph. No unmeasured path is installed.
    """
    if type(function) is not FunctionType:
        if strict:raise UnsupportedBytecode('a Python function is required')
        return function
    info=compilation_info(function)
    if info is not None:
        if structure_calls_factory is not None or library_calls:
            if strict:raise UnsupportedBytecode('existing prepared body has different model options')
            return function
        _install_if_measured(function,info)
        return function
    _measurements.pop(function,None)
    candidate=_frameless_candidates.pop(function,None)
    if candidate is not None:candidate.close()
    try:
        from .. import _structure_ops_native
        from .symbols import CPythonSymbols
        from .structure_lowerings import StructureCalls,select_structure_calls,specialize_structure_calls
        graph=specialize_structure_calls(build(function),immediate_offsets=True)
        graph=select_structure_calls(graph,{'load_attr','store_attr','getitem','setitem','contains'})
        factory=StructureCalls if structure_calls_factory is None else structure_calls_factory
        calls=factory(CPythonSymbols(),_structure_ops_native)
        # S80: suspended functions compile their first real RESUME prefix;
        # YIELD/SEND hand the untouched real frame to canonical Tier 1.
        entry_offset=None
        if graph.code.co_flags & (inspect.CO_GENERATOR|inspect.CO_COROUTINE|inspect.CO_ASYNC_GENERATOR):
            for instruction in dis.get_instructions(graph.code):
                if instruction.opname=='RESUME':
                    entry_offset=instruction.offset;break
            if entry_offset is None:raise UnsupportedBytecode('suspended function has no original RESUME')
        lowered=lower(graph,frame_entry=True,entry_offset=entry_offset,
                      structure_calls=calls,owned_readonly_loops=True,library_calls=library_calls)
    except (UnsupportedBytecode,NotImplementedError):
        if strict:raise
        return function
    from . import _entry_native
    try:
        _entry_native.prepare_frame_entry(function,lowered.body_address,lowered.execution_owner,lowered.graph.code)
    except _entry_native.CompilationChanged:
        if strict:raise UnsupportedBytecode('function changed during native compilation') from None
        return function
    from .frameless import prepare_frameless
    candidate=prepare_frameless(function)
    if candidate is not None:_frameless_candidates[function]=candidate
    return function
