"""Prepared original-code child bodies; actual functions/cells bind at CALL."""
from dataclasses import dataclass
import dis,inspect,types

@dataclass(frozen=True)
class NativeCandidate:
    code:types.CodeType
    body_address:int
    entry_offset:int
    owner:object


def prepare_native_child(code):
    if type(code) is not types.CodeType:raise TypeError('a code object is required')
    if (code.co_exceptiontable or code.co_cellvars or
        code.co_flags&(inspect.CO_GENERATOR|inspect.CO_COROUTINE|inspect.CO_ASYNC_GENERATOR) or
        code.co_flags&(inspect.CO_OPTIMIZED|inspect.CO_NEWLOCALS)!=(inspect.CO_OPTIMIZED|inspect.CO_NEWLOCALS)):
        return None
    from .builder import build_code,UnsupportedBytecode
    from .lower_llvm import lower
    try:body=lower(build_code(code),frame_entry=True)
    except (UnsupportedBytecode,NotImplementedError):return None
    return NativeCandidate(code,body.body_address,body.entry_offset,body.execution_owner)
