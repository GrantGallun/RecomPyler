"""Optional signed-62 integer arithmetic for the canonical LLVM lowerer.

The single numeric_ops protocol borrows object operands and returns an owned
object. Tags exist only in SSA. The canonical lowerer owns original-PC error,
stack and retirement policy. Wave17 can extend this protocol for float/regions.
Layout source: CPython 3.14.4 Include/cpython/longintrepr.h. No borrowed code.
"""
import ctypes
import sys
from llvmlite import ir
from .symbols import CPythonSymbols, require_runtime


class _LongHead(ctypes.Structure):
    _fields_ = [('refcount', ctypes.c_ssize_t), ('type', ctypes.c_void_p),
                ('tag', ctypes.c_size_t), ('digit', ctypes.c_uint32)]


class TaggedIntOps:
    """Exact-int guards, signed62 SSA arithmetic, same-site generic miss.

    No source objects or frame pointers are retained. All generated loads run
    under the required GIL and cannot invoke Python. Bool/subclasses are misses.
    """
    def __init__(self):
        require_runtime()
        if sys.int_info.bits_per_digit != 30 or sys.int_info.sizeof_digit != 4:
            raise RuntimeError('tagged integers require CPython 30-bit digits')
        self.symbols = CPythonSymbols()

    @property
    def keepalive(self):
        return (self.symbols.library,)

    def emit_binary(self, builder, oparg, left, right, generic):
        if oparg not in (0, 10, 5):
            return generic()
        word = ir.IntType(64)
        digit = ir.IntType(32)
        pointer = left.type
        number = lambda value: ir.Constant(word, value)
        body = builder.function
        miss = body.append_basic_block('numeric.generic')
        exact = body.append_basic_block('numeric.exact')
        done = body.append_basic_block('numeric.done')

        def field(obj, offset, kind):
            return builder.load(builder.bitcast(builder.gep(obj, [number(offset)]), kind.as_pointer()))

        int_type = number(ctypes.addressof(ctypes.c_byte.in_dll(ctypes.pythonapi,'PyLong_Type'))).inttoptr(pointer)
        types_match = builder.and_(
            builder.icmp_unsigned('==', field(left, _LongHead.type.offset, pointer), int_type),
            builder.icmp_unsigned('==', field(right, _LongHead.type.offset, pointer), int_type))
        builder.cbranch(types_match, exact, miss)
        builder.position_at_end(exact)

        def unbox(obj):
            tag = field(obj, _LongHead.tag.offset, word)
            size = builder.lshr(tag, number(3))
            digits_ok = body.append_basic_block('numeric.digits')
            builder.cbranch(builder.icmp_unsigned('<=', size, number(3)), digits_ok, miss)
            builder.position_at_end(digits_ok)
            # Zero's allocated digit may be uninitialized; its numeric value is
            # determined by size. Never read digit 1/2 unless allocated.
            first = builder.zext(field(obj, _LongHead.digit.offset, digit), word)
            magnitude = builder.select(builder.icmp_unsigned('==', size, number(0)), number(0), first)
            for index in (1, 2):
                more = body.append_basic_block('numeric.more')
                join = body.append_basic_block('numeric.digit.done')
                prior_block = builder.block
                builder.cbranch(builder.icmp_unsigned('>', size, number(index)), more, join)
                builder.position_at_end(more)
                part = builder.zext(field(obj, _LongHead.digit.offset + 4 * index, digit), word)
                if index == 2:
                    fits = body.append_basic_block('numeric.high.fits')
                    # Signed62 magnitude is at most 2**61. Reject before shift
                    # so larger three-digit integers cannot wrap into range.
                    builder.cbranch(builder.icmp_unsigned('<=', part, number(2)), fits, miss)
                    builder.position_at_end(fits)
                combined = builder.or_(magnitude, builder.shl(part, number(30 * index)))
                end = builder.block
                builder.branch(join)
                builder.position_at_end(join)
                merged = builder.phi(word)
                merged.add_incoming(magnitude, prior_block)
                merged.add_incoming(combined, end)
                magnitude = merged
            value = builder.select(builder.icmp_unsigned('==', builder.and_(tag, number(3)), number(2)),
                                   builder.neg(magnitude), magnitude)
            in_range = builder.and_(builder.icmp_signed('>=', value, number(-(1 << 61))),
                                    builder.icmp_signed('<=', value, number((1 << 61) - 1)))
            fits = body.append_basic_block('numeric.signed62')
            builder.cbranch(in_range, fits, miss)
            builder.position_at_end(fits)
            return builder.or_(builder.shl(value, number(2)), number(3))

        left_tag, right_tag = unbox(left), unbox(right)
        a, b = builder.ashr(left_tag, number(2)), builder.ashr(right_tag, number(2))
        if oparg == 0:
            value = builder.add(a, b)
            overflow = ir.Constant(ir.IntType(1), 0)
        elif oparg == 10:
            value = builder.sub(a, b)
            overflow = ir.Constant(ir.IntType(1), 0)
        else:
            product = builder.smul_with_overflow(a, b)
            value, overflow = builder.extract_value(product, 0), builder.extract_value(product, 1)
        fits = builder.and_(builder.not_(overflow), builder.and_(
            builder.icmp_signed('>=', value, number(-(1 << 61))),
            builder.icmp_signed('<=', value, number((1 << 61) - 1))))
        box = body.append_basic_block('numeric.box')
        builder.cbranch(fits, box, miss)
        builder.position_at_end(box)
        result_tag = builder.or_(builder.shl(value, number(2)), number(3))
        function = self.symbols.declare(builder.module, 'PyLong_FromLongLong', pointer, [word])
        fast = builder.call(function, [builder.ashr(result_tag, number(2))])
        fast_end = builder.block
        builder.branch(done)
        builder.position_at_end(miss)
        slow = generic()
        slow_end = builder.block
        builder.branch(done)
        builder.position_at_end(done)
        result = builder.phi(pointer)
        result.add_incoming(fast, fast_end)
        result.add_incoming(slow, slow_end)
        return result


class _FloatHead(ctypes.Structure):
    _fields_ = [("refcount", ctypes.c_ssize_t), ("type", ctypes.c_void_p),
                ("value", ctypes.c_double)]


class FloatOps(TaggedIntOps):
    """Exact finite doubles, plus the accepted signed62 lane, on numeric_ops.

    Box at this same operation boundary. Nonfinite/mixed/subclass operands take
    the canonical original operation once; inspect exponent bits without an FP
    comparison so the guard cannot alter floating-point exception flags.
    LLVM arithmetic has no fast-math/contraction/reassociation permissions.
    """
    def emit_binary(self, builder, oparg, left, right, generic):
        if oparg not in (0, 10, 5):
            return super().emit_binary(builder, oparg, left, right, generic)
        word = ir.IntType(64)
        double = ir.DoubleType()
        pointer = left.type
        number = lambda value: ir.Constant(word, value)
        body = builder.function
        exact = body.append_basic_block('numeric.float.exact')
        finite = body.append_basic_block('numeric.float.finite')
        miss = body.append_basic_block('numeric.float.generic')
        done = body.append_basic_block('numeric.float.done')

        def field(obj, offset, kind):
            return builder.load(builder.bitcast(builder.gep(obj, [number(offset)]), kind.as_pointer()))

        float_type = number(ctypes.addressof(ctypes.c_byte.in_dll(ctypes.pythonapi,'PyFloat_Type'))).inttoptr(pointer)
        match = builder.and_(
            builder.icmp_unsigned('==', field(left, _FloatHead.type.offset, pointer), float_type),
            builder.icmp_unsigned('==', field(right, _FloatHead.type.offset, pointer), float_type))
        builder.cbranch(match, exact, miss)
        builder.position_at_end(exact)
        a = field(left, _FloatHead.value.offset, double)
        b = field(right, _FloatHead.value.offset, double)
        exponent = number(0x7ff0000000000000)
        is_finite = builder.and_(
            builder.icmp_unsigned('!=', builder.and_(builder.bitcast(a, word), exponent), exponent),
            builder.icmp_unsigned('!=', builder.and_(builder.bitcast(b, word), exponent), exponent))
        builder.cbranch(is_finite, finite, miss)
        builder.position_at_end(finite)
        value = {0: builder.fadd, 10: builder.fsub, 5: builder.fmul}[oparg](a, b)
        box = self.symbols.declare(builder.module, 'PyFloat_FromDouble', pointer, [double])
        fast = builder.call(box, [value])
        fast_end = builder.block
        builder.branch(done)
        builder.position_at_end(miss)
        slow = super().emit_binary(builder, oparg, left, right, generic)
        slow_end = builder.block
        builder.branch(done)
        builder.position_at_end(done)
        result = builder.phi(pointer)
        result.add_incoming(fast, fast_end)
        result.add_incoming(slow, slow_end)
        return result
