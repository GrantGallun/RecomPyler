"""The original function creates its canonical frame only on a cold deopt."""
import ctypes
import dis
import sys
from types import FunctionType
from llvmlite import binding, ir


def source(value):
    result = value
    return result + 1


def installed(*, pending_error=False, expired_plan=False):
    from recompyler import _source_frames_native as frames
    from recompyler.ir.deopt import (FrameState, LiveValue, RefKind, ValueKind,
                                    DeoptMetadata, prepare, emit_vectorcall_deopt)
    from recompyler.ir.entry import install_vectorcall_entry
    from recompyler.ir.symbols import CPythonSymbols
    fn = FunctionType(source.__code__, globals())
    pc = next(op.offset for op in dis.get_instructions(fn) if op.opname in ('LOAD_FAST', 'LOAD_FAST_BORROW') and op.argval == 'result')
    cause = next(op.offset for op in dis.get_instructions(fn) if op.opname == 'BINARY_OP') if pending_error else pc
    plan_code = fn.__code__.replace(co_filename='<expired-plan>') if expired_plan else fn.__code__
    plan = prepare(DeoptMetadata((LiveValue(0, RefKind.BORROWED, ValueKind.OBJECT),),
        (FrameState(plan_code, cause, pc, (0, 0), (), lazy=True),)), weak_code=True)
    symbols = CPythonSymbols(); p = ir.IntType(8).as_pointer(); n = ir.IntType(64)
    module = ir.Module(name='frameless_deopt_fixture')
    body = ir.Function(module, ir.FunctionType(p, [p, p.as_pointer(), n, p, p]), 'body')
    original, args, nargsf, names, saved = body.args
    b = ir.IRBuilder(body.append_basic_block('entry'))
    def num(value): return ir.Constant(n, value)
    def obj(value): return num(id(value)).inttoptr(p)
    signature = ir.FunctionType(p, [p, p.as_pointer(), n, p])
    good = b.and_(b.icmp_unsigned('==', b.and_(nargsf, num((1 << 63) - 1)), num(1)),
                  b.icmp_unsigned('==', names, ir.Constant(p, None)))
    with b.if_then(b.not_(good)):
        b.ret(b.call(b.bitcast(saved, signature.as_pointer()), [original, args, nargsf, names]))
    value = b.load(args); cold_count = ctypes.c_uint64()
    with b.if_then(b.icmp_unsigned('!=', value, obj(1)), likely=False):
        counter = num(ctypes.addressof(cold_count)).inttoptr(n.as_pointer())
        b.store(b.add(b.load(counter), num(1)), counter)
        if pending_error:
            seterror = symbols.declare(module, 'PyErr_SetString', ir.VoidType(), [p, p])
            text = ir.GlobalVariable(module, ir.ArrayType(ir.IntType(8), 14), 'native_error')
            text.initializer = ir.Constant(text.value_type, bytearray(b'native failed\x00'))
            b.call(seterror, [obj(ValueError), b.bitcast(text, p)])
        emit_vectorcall_deopt(b, original=original, args=args, code=fn.__code__,
                             plan=plan, raw=(b.ptrtoint(value, n),), symbols=symbols,
                             cause_offset=cause)
    inc = symbols.declare(module, 'Py_IncRef', ir.VoidType(), [p])
    b.call(inc, [obj(2)]); b.ret(obj(2))
    binding.initialize_native_target(); binding.initialize_native_asmprinter()
    parsed = binding.parse_assembly(str(module)); parsed.verify()
    engine = binding.create_mcjit_compiler(parsed, binding.Target.from_default_triple().create_target_machine())
    engine.finalize_object()
    handle = install_vectorcall_entry(fn, engine.get_function_address('body'), (engine, plan, symbols, cold_count))
    return fn, handle, cold_count, module


def test_hot_guard_creates_no_source_activation():
    from recompyler import _source_frames_native as frames
    fn, handle, count, module = installed()
    with handle:
        for _ in range(100): assert fn(1) == 2
        assert count.value == 0 and frames.active_depth() == 0
    assert 'deopt_resume' in str(module)


def test_cold_guard_reifies_current_locals_before_original_callback():
    fn, handle, count, _ = installed(); seen = []; marker = object()
    class Spy:
        def __add__(self, other):
            frame = sys._getframe(1)
            seen.append((frame, frame.f_code is fn.__code__,
                         frame.f_locals['value'] is self, frame.f_locals['result'] is self))
            return marker
    value = Spy()
    with handle:
        assert fn(value) is marker
        assert count.value == 1
        assert seen[0][1:] == (True, True, True)
    assert seen[0][0].f_code is fn.__code__


def test_cold_error_has_original_instruction_traceback_and_next_call_works():
    import pytest
    from recompyler import _source_frames_native as frames
    fn, handle, count, _ = installed()
    with handle:
        with pytest.raises(TypeError) as caught: fn(object())
        tb = caught.value.__traceback__
        while tb and tb.tb_frame.f_code is not fn.__code__: tb = tb.tb_next
        assert tb is not None and tb.tb_frame.f_locals['result'] is tb.tb_frame.f_locals['value']
        assert tb.tb_lasti == next(op.offset for op in dis.get_instructions(fn) if op.opname == 'BINARY_OP')
        assert count.value == 1 and frames.active_depth() == 0
        assert fn(1) == 2


def test_pending_native_error_materializes_original_traceback_without_replaying():
    import pytest
    from recompyler import _source_frames_native as frames
    fn, handle, count, _ = installed(pending_error=True)
    with handle:
        with pytest.raises(ValueError, match='^native failed$') as caught: fn(9)
        tb = caught.value.__traceback__
        while tb and tb.tb_frame.f_code is not fn.__code__: tb = tb.tb_next
        assert tb is not None and tb.tb_frame.f_locals == {'value': 9, 'result': 9}
        assert tb.tb_lasti == next(op.offset for op in dis.get_instructions(fn) if op.opname == 'BINARY_OP')
        assert count.value == 1 and frames.active_depth() == 0
        assert fn(1) == 2


def test_weak_deopt_plan_does_not_retain_original_code_or_constants():
    import gc
    import weakref
    from recompyler.ir.deopt import FrameState, DeoptMetadata, prepare
    code = compile('def temporary():\n return None\n', '<weak-deopt>', 'exec').co_consts[0]
    first = next(op.offset for op in dis.get_instructions(code) if op.opname != 'RESUME')
    metadata = DeoptMetadata((), (FrameState(code, first, first, (), (), lazy=True),))
    reference = weakref.ref(code)
    plan = prepare(metadata, weak_code=True)
    del metadata, code
    gc.collect()
    assert reference() is None
    assert plan is not None


def test_cold_deopt_refuses_protected_handlers():
    import pytest
    from recompyler.ir.deopt import emit_vectorcall_deopt
    def protected(value):
        try: return value + 1
        except ValueError: return 'caught'
    first = next(op.offset for op in dis.get_instructions(protected) if op.opname == 'RESUME')
    with pytest.raises(ValueError, match='unprotected'):
        emit_vectorcall_deopt(None, original=None, args=None, code=protected.__code__,
                             plan=None, raw=(), symbols=None, cause_offset=first)


def test_expired_weak_plan_refuses_without_dereferencing_retired_code():
    import pytest
    from recompyler import _source_frames_native as frames
    fn, handle, count, _ = installed(expired_plan=True)
    with handle:
        with pytest.raises(RuntimeError, match='matching active frame'): fn(9)
        assert count.value == 1 and frames.active_depth() == 0
        assert fn(1) == 2


def test_cold_deopt_refuses_unbindable_fixed_argument_shapes():
    import pytest
    from recompyler.ir.deopt import emit_vectorcall_deopt
    sources = [
        'def excessive(' + ','.join('a'+str(i) for i in range(65)) + '):\n return a64\n',
        'def variadic(value,*rest):\n return value\n',
        'def keywords(value,*,required):\n return value\n',
    ]
    for text in sources:
        code = compile(text, '<cold-binding>', 'exec').co_consts[0]
        first = next(op.offset for op in dis.get_instructions(code) if op.opname == 'RESUME')
        with pytest.raises(ValueError, match='fixed positional|64'):
            emit_vectorcall_deopt(None, original=None, args=None, code=code,
                                 plan=None, raw=(), symbols=None, cause_offset=first)
