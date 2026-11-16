"""CinderX-style immutable deopt maps, with CPython byte offsets at the API.

Adapted from CinderX Jit/deopt.h and website/docs/Jit/deoptimization.md @ f3dc0e8.
MIT License

Copyright (c) Meta Platforms, Inc. and affiliates.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

"""
from dataclasses import dataclass
from enum import Enum
from types import CodeType
import dis


class RefKind(Enum):
    UNCOUNTED = 'uncounted'
    BORROWED = 'borrowed'
    OWNED = 'owned'


class ValueKind(Enum):
    OBJECT = 'object'
    SIGNED = 'signed'
    UNSIGNED = 'unsigned'
    DOUBLE = 'double'
    BOOL = 'bool'


@dataclass(frozen=True)
class LiveValue:
    location: int
    ref_kind: RefKind
    value_kind: ValueKind

    def __post_init__(self):
        if type(self.location) is not int or self.location < 0:
            raise ValueError('nonnegative spill-table location required')
        if not isinstance(self.ref_kind, RefKind) or not isinstance(self.value_kind, ValueKind):
            raise ValueError('invalid live value kind')
        if self.value_kind is not ValueKind.OBJECT and self.ref_kind is not RefKind.UNCOUNTED:
            raise ValueError('unboxed values must be uncounted')


def localsplus_count(code):
    return code.co_nlocals + sum(name not in code.co_varnames for name in code.co_cellvars) + len(code.co_freevars)


def stack_depths(code):
    """Bytecode stack verification, including original exception-handler entries."""
    instructions=tuple(dis.get_instructions(code))
    by_offset={instruction.offset:index for index,instruction in enumerate(instructions)}
    depths={}
    work=[(instructions[0].offset,0)]
    for entry in dis.Bytecode(code).exception_entries:
        work.append((entry.target,entry.depth+1+int(entry.lasti)))
    terminal={'RETURN_VALUE','RETURN_CONST','RAISE_VARARGS','RERAISE'}
    while work:
        offset,depth=work.pop()
        if offset in depths:
            if depths[offset]!=depth: raise ValueError('inconsistent bytecode stack depth')
            continue
        if depth<0: raise ValueError('negative bytecode stack depth')
        depths[offset]=depth
        index=by_offset[offset]
        instruction=instructions[index]
        if instruction.opname in terminal: continue
        if instruction.opname=='RETURN_GENERATOR':
            # The suspended generator starts with its first send(None) operand.
            if index+1<len(instructions):work.append((instructions[index+1].offset,1))
            continue
        if instruction.opcode in dis.hasjump:
            work.append((instruction.argval,depth+dis.stack_effect(instruction.opcode,instruction.arg,jump=True)))
            if instruction.opname.startswith('JUMP'):continue
        if index+1<len(instructions):
            work.append((instructions[index+1].offset,depth+dis.stack_effect(instruction.opcode,instruction.arg,jump=False)))
    return depths


@dataclass(frozen=True)
class FrameState:
    code: CodeType
    cause_offset: int
    next_offset: int
    localsplus: tuple[int, ...]
    stack: tuple[int, ...]
    lazy: bool = False

    @property
    def cause_instr_idx(self): return self.cause_offset // 2

    @property
    def next_instr_idx(self): return self.next_offset // 2


@dataclass(frozen=True)
class Snapshot:
    state: FrameState


@dataclass(frozen=True)
class Guard:
    condition: int
    state: FrameState


@dataclass(frozen=True)
class DeoptMetadata:
    live_values: tuple[LiveValue, ...]
    frames: tuple[FrameState, ...]

    def __post_init__(self):
        if type(self.live_values) is not tuple or type(self.frames) is not tuple or not self.frames:
            raise ValueError('immutable live table and at least one frame required')
        if not all(isinstance(value,LiveValue) for value in self.live_values):
            raise ValueError('invalid live value table')
        for frame in self.frames:
            if not isinstance(frame,FrameState) or not isinstance(frame.code,CodeType):
                raise ValueError('code-backed frame required')
            offsets={i.offset for i in dis.get_instructions(frame.code)}
            for offset in (frame.cause_offset,frame.next_offset):
                if type(offset) is not int or offset not in offsets:
                    raise ValueError('deopt offset must identify an instruction, not a cache')
            if type(frame.localsplus) is not tuple or len(frame.localsplus)!=localsplus_count(frame.code):
                raise ValueError('localsplus map has wrong size')
            if type(frame.stack) is not tuple or len(frame.stack)>frame.code.co_stacksize:
                raise ValueError('stack map exceeds frame capacity')
            if stack_depths(frame.code).get(frame.next_offset)!=len(frame.stack):
                raise ValueError('stack map differs from original instruction depth')
            for index in frame.localsplus+frame.stack:
                if type(index) is not int or not -1 <= index < len(self.live_values):
                    raise ValueError('invalid live-table index')
            # A NULL operand is safe only at a proved call self/null position.
            instruction=next(i for i in dis.get_instructions(frame.code) if i.offset==frame.next_offset)
            null_slot=None
            if instruction.opname in ('CALL','CALL_KW'):
                null_slot=len(frame.stack)-(instruction.arg or 0)-(2 if instruction.opname=='CALL_KW' else 1)
            for position,index in enumerate(frame.stack):
                if index==-1 and position!=null_slot:
                    raise ValueError('NULL stack sentinel lacks a proved call position')

    @property
    def inline_depth(self): return len(self.frames)-1


def verify_guards(instructions, metadata):
    """Verify a single basic block; callers reset at every block boundary.

    Snapshot dominance across blocks is intentionally not inferred here. Unknown
    operations are effects, so callers must insert a fresh Snapshot after them.
    """
    snapshot=None
    effect=False
    for instruction in instructions:
        if isinstance(instruction,Snapshot):
            if instruction.state not in metadata.frames:
                raise ValueError('snapshot frame missing from metadata')
            snapshot=instruction.state
            effect=False
        elif isinstance(instruction,Guard):
            if type(instruction.condition) is not int or not 0<=instruction.condition<len(metadata.live_values):
                raise ValueError('guard condition must name a live value')
            if snapshot is None or instruction.state != snapshot:
                raise ValueError('guard lacks matching dominating snapshot')
            if effect: raise ValueError('effect between snapshot and guard')
        else:
            effect=True


def prepare(metadata, frame_index=0, *, weak_code=False):
    """Compile one frame map for the cold deopt edge; no happy-path calls.

    Existing canonical resume_python() transfers its registered activation to
    _PyEval_EvalFrameDefault. Real executor entries return the reified PC to Tier1.
    Inlined chains and generator exc_info must be resumed by their owning runtime;
    this function only prepares one map and does not create or bind frames.
    weak_code=True keeps source-independent execution owners from retaining code
    constants; reify refuses an expired code owner.
    """
    from .symbols import require_runtime
    require_runtime()
    if not isinstance(metadata,DeoptMetadata): raise TypeError('deopt metadata required')
    from . import _deopt_native
    frame=metadata.frames[frame_index]
    kinds={kind:index for index,kind in enumerate(ValueKind)}
    arguments=(frame.code,frame.cause_offset,frame.next_offset,frame.localsplus,frame.stack,
               tuple(value.location for value in metadata.live_values),
               tuple(kinds[value.value_kind] for value in metadata.live_values))
    return _deopt_native.plan(*arguments,True) if weak_code else _deopt_native.plan(*arguments)

def emit_guard(builder, condition, *, frame, plan, raw, count, reify, resume, error):
    """Emit only a conditional cold edge into a vectorcall body.

    reify(), resume(), error() are compiler callbacks emitting calls through the
    canonical provider. They run while compiling the cold block, never from Python
    at runtime. The caller prepares spills only on that block when needed; this
    helper introduces no hot-path allocation, reference operation, or helper call.
    Frame-ABI users instead return their reified original PC to the interpreter.
    """
    from llvmlite import ir
    with builder.if_then(builder.not_(condition), likely=False):
        status=reify()
        with builder.if_then(builder.icmp_signed('<',status,ir.Constant(status.type,0))):
            error()
            builder.ret(ir.Constant(builder.function.function_type.return_type,None))
        builder.ret(resume())

def emit_lazy_guard(builder, condition, *, materialize, reify, resume, error):
    """Materialize through the canonical provider only on a failed guard.

    This requires the caller's existing proof that the preceding native lane
    cannot execute arbitrary code or expose a frame. It does not certify entry
    binding/argument ownership. All callbacks emit machine code on the cold edge.
    """
    from llvmlite import ir
    result_type=builder.function.function_type.return_type
    with builder.if_then(builder.not_(condition),likely=False):
        frame=materialize()
        with builder.if_then(builder.icmp_unsigned('==',frame,ir.Constant(frame.type,None))):
            builder.ret(ir.Constant(result_type,None))
        status=reify(frame)
        with builder.if_then(builder.icmp_signed('<',status,ir.Constant(status.type,0))):
            error(frame)
            builder.ret(ir.Constant(result_type,None))
        builder.ret(resume(frame))


def emit_vectorcall_deopt(builder, *, original, args, code, plan, raw, symbols, cause_offset):
    """End a cold vectorcall block by reifying its original interpreter frame.

    This emits a cold native thunk through the EXISTING run_vectorcall boundary;
    the hot path runs neither a boundary helper nor a frame allocation. Payload
    words contain the original fixed positional arguments followed by the live
    table. The caller retains plan and the generated module, proves ordinary
    entry/argument lifetimes, and branches here before executing arbitrary code.
    Pending native exceptions acquire the original source traceback and unwind;
    protected handlers must use the existing-frame path. No argument ownership
    or stale-local retirement is inferred by this helper.
    """
    from llvmlite import ir
    from .. import _source_frames_native as frames
    from . import _deopt_native
    p = ir.IntType(8).as_pointer()
    word = ir.IntType(64)
    status = ir.IntType(32)
    raw = tuple(raw)
    if any(value.type != word for value in raw):
        raise TypeError('deopt live table requires machine words')
    if type(code) is not CodeType:
        raise TypeError('original code required')
    import inspect
    if code.co_exceptiontable or code.co_flags & (inspect.CO_GENERATOR | inspect.CO_COROUTINE | inspect.CO_ASYNC_GENERATOR):
        raise ValueError('cold vectorcall deopt requires ordinary unprotected scope')
    # Match the fixed argument table in the canonical source provider's enter.
    if code.co_argcount > 64 or code.co_kwonlyargcount or code.co_flags & (inspect.CO_VARARGS | inspect.CO_VARKEYWORDS):
        raise ValueError('cold deopt requires fixed positional binding with at most 64 arguments')
    instructions = tuple(dis.get_instructions(code))
    if cause_offset not in {op.offset for op in instructions}:
        raise ValueError('deopt cause must identify an original instruction')
    resume_pc = next(op.offset for op in instructions if op.opname == 'RESUME')
    for name in ('run_vectorcall', 'enter', 'resume_python', 'leave_raw'):
        symbols.register_external('rc_ir_frame_' + name, frames.addresses()[name], frames)
    symbols.register_external('rc_ir_deopt_reify', _deopt_native.addresses()['reify'], _deopt_native)
    module = builder.module
    thunk = ir.Function(module, ir.FunctionType(p, [p, p.as_pointer(), word, p]),
                        module.get_unique_name('deopt_resume'))
    cold = ir.IRBuilder(thunk.append_basic_block('entry'))
    cold_original, payload, _, _ = thunk.args
    def integer(value):
        return ir.Constant(word, value)
    def pointer(value):
        return integer(id(value)).inttoptr(p)
    def call(name, result, operands):
        return cold.call(symbols.declare(module, name, result, [value.type for value in operands]), operands)
    null = ir.Constant(p, None)
    words = cold.bitcast(payload, word.as_pointer())
    def materialize():
        return call('rc_ir_frame_enter', p, [cold_original, pointer(code), payload,
                                           integer(code.co_argcount), integer(resume_pc)])
    def reify(frame):
        return call('rc_ir_deopt_reify', status, [frame, pointer(plan),
                    cold.gep(words, [integer(code.co_argcount)]), integer(len(raw))])
    def error(frame):
        return call('rc_ir_frame_leave_raw', status, [frame, ir.Constant(status, 0), integer(cause_offset)])
    def resume(frame):
        pending = call('PyErr_Occurred', p, [])
        with cold.if_then(cold.icmp_unsigned('!=', pending, null)):
            error(frame)
            cold.ret(null)
        return call('rc_ir_frame_resume_python', p, [frame])
    emit_lazy_guard(cold, ir.Constant(ir.IntType(1), 0), materialize=materialize,
                    reify=reify, resume=resume, error=error)
    cold.unreachable()
    packed = builder.alloca(word, integer(max(1, code.co_argcount + len(raw))), name='deopt_live_table')
    for index in range(code.co_argcount):
        value = builder.load(builder.gep(args, [integer(index)]))
        builder.store(builder.ptrtoint(value, word), builder.gep(packed, [integer(index)]))
    for index, value in enumerate(raw, code.co_argcount):
        builder.store(value, builder.gep(packed, [integer(index)]))
    operands = [builder.bitcast(thunk, p), original, builder.bitcast(packed, p.as_pointer()),
                integer(code.co_argcount), null]
    runner = symbols.declare(module, 'rc_ir_frame_run_vectorcall', p, [value.type for value in operands])
    builder.ret(builder.call(runner, operands))
