"""Native vectorcall entry for direct LLVM bodies (no Numba or Python bridge).

body(original, args, nargsf, kwnames) receives borrowed original/vectorcall input,
GIL held, and returns a NEW reference or NULL with the current Python error.
keepalive must retain every machine-code module used by body and guards. Guards
have int(PyObject* original) ABI: 1 = enter, 0 = original call, -1 = pending error.
An optional runner has PyObject*(void* body, original, args, nargsf, kwnames)
ABI and supplies the canonical native source-frame barrier. An optional owned
runner receives a sixth borrowed argument, the actual entry callable, for shared
provider ownership validation. The hooks are mutually exclusive. Passing this
hook alone does not transfer argument ownership or establish admission. Binding, source
frames and operation cleanup belong to the shared IR lowering.
This low-level constructor does not establish semantic admission of a body.
"""
from .symbols import require_runtime


def create_callable(original_function,body_address,keepalive,guards=(),*,runner_address=0,owned_runner_address=0):
    require_runtime()
    from . import _entry_native
    return _entry_native.create_callable(original_function,body_address,keepalive,tuple(guards),runner_address,owned_runner_address)


def install_frame_entry(original_function,body_address,keepalive,*,seed_arguments=(),seed_keywords=None,entry_offset=None,expected_code=None,expected_prepared=None):
    """Install a low-level real-frame body while preserving the original function.

    Requires process-enabled CPython JIT. Keep the returned non-callable handle
    alive and call the ORIGINAL function. close()/GC restores CPython's executor;
    active code stays pinned until it returns. A body has (frame, stack, thread)
    ABI and returns an original continuation PC, or NULL with an error. Seeding
    uses the canonical provider and does not invoke the target body. Optional
    seed_keywords bind through CPython, including required keyword-only names;
    the established positional ABI is unchanged. CPython may
    decline a seed (for example a root-return-only or specialized-property trace);
    this raises before installing native code. This API
    does not establish semantic admission or permit borrowed-input loop bodies.
    """
    require_runtime()
    import sys
    if not sys._jit.is_enabled():
        raise RuntimeError('frame entry requires process-enabled CPython JIT')
    from .. import _source_frames_native
    from . import _entry_native
    import dis
    addresses=_source_frames_native.addresses()
    branches=tuple(op.offset for op in dis.get_instructions(original_function)
                   if op.opname in ('POP_JUMP_IF_NONE','POP_JUMP_IF_NOT_NONE',
                                    'POP_JUMP_IF_FALSE','POP_JUMP_IF_TRUE'))
    seed_depth=0
    import inspect
    code=original_function.__code__
    if code.co_flags & (inspect.CO_GENERATOR|inspect.CO_COROUTINE|inspect.CO_ASYNC_GENERATOR):
        resumes=[op.offset for op in dis.get_instructions(original_function) if op.opname=='RESUME']
        selected=resumes[0] if entry_offset is None else entry_offset
        if selected not in resumes:raise ValueError('generator entry must identify RESUME')
        if selected!=resumes[0]:
            from .builder import build
            seed_depth=len(build(original_function).blocks[selected].parameters)
    values=tuple(seed_arguments)
    if seed_keywords is not None:
        if type(seed_keywords) is not dict:raise TypeError('exact seed keyword dictionary required')
        pairs=tuple(seed_keywords.items())
        names=tuple(key for key,value in pairs)
        values+=tuple(value for key,value in pairs)
        return _entry_native.install_frame_entry(original_function,body_address,keepalive,
            values,addresses['enter'],addresses['leave_raw'],addresses['run_vectorcall'],branches,
            entry_offset,expected_code,expected_prepared,seed_depth,names,addresses['enter_keywords'])
    return _entry_native.install_frame_entry(original_function,body_address,keepalive,
        values,addresses['enter'],addresses['leave_raw'],addresses['run_vectorcall'],branches,entry_offset,expected_code,expected_prepared,seed_depth)


def install_vectorcall_entry(original_function, body_address, keepalive):
    """Install a low-level frameless body on the original Python function.

    Body ABI: (original, args, nargsf, kwnames, saved_vectorcall) -> new ref.
    The borrowed fifth argument is the original CPython vectorcall function
    pointer; cold fallback must call it directly. PyObject_Vectorcall(original)
    would re-enter this body. Body admission, ownership and lazy source-frame
    materialization belong to the shared lowering, not this constructor.
    Keep the returned handle alive; close()/GC restores the saved slot only if
    our slot is still installed. Registered observers leave the handle inactive;
    later observer registration and function mutation restore the original slot.
    This path does not require the CPython JIT.
    """
    require_runtime()
    from . import _entry_native
    return _entry_native.install_vectorcall_entry(original_function, body_address, keepalive)
