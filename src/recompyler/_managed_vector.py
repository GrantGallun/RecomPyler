"""Fixed-shape CPython vectorcall using canonical managed operands."""
from llvmlite import ir
from numba.core import cgutils, types
from numba.extending import intrinsic
from ._managed_native import managed, borrowed_object, adopt_owned


def _arguments_type(arguments):
    return isinstance(arguments, types.BaseTuple) and all(value == managed for value in arguments)


def _valid(callee, arguments, names, positional):
    return (callee == managed and _arguments_type(arguments)
        and (names == managed or names == types.none)
        and isinstance(positional, types.IntegerLiteral)
        and 0 <= positional.literal_value <= len(arguments)
        and (names == managed or positional.literal_value == len(arguments)))


def _values(context, builder, arguments, count):
    return [borrowed_object(context, builder, value)
            for value in cgutils.unpack_tuple(builder, arguments, count)]


def _vectorcall(context, builder, py, callee, values, names, positional):
    # Reserve args[-1] for bound-method forwarding, as CPython's call sites do.
    storage = cgutils.alloca_once(builder, py.pyobj, size=len(values) + 1)
    builder.store(py.get_null_object(), storage)
    for index, value in enumerate(values, 1):
        builder.store(value, builder.gep(storage, [ir.Constant(py.py_ssize_t, index)]))
    arguments = builder.gep(storage, [ir.Constant(py.py_ssize_t, 1)])
    nargsf = ir.Constant(py.py_ssize_t, positional | (1 << (py.py_ssize_t.width - 1)))
    function = cgutils.get_or_insert_function(builder.module,
        ir.FunctionType(py.pyobj, [py.pyobj, py.pyobj.as_pointer(), py.py_ssize_t, py.pyobj]),
        'PyObject_Vectorcall')
    return builder.call(function, [callee, arguments, nargsf, names])


def _context_call(builder, py, actual, values, names, positional, frame, namespace, helper):
    result = cgutils.alloca_once_value(builder, py.get_null_object())
    arguments = py.tuple_pack(values[:positional])
    keywords = py.dict_new()
    valid = cgutils.alloca_once_value(builder, builder.and_(
        cgutils.is_not_null(builder, arguments), cgutils.is_not_null(builder, keywords)))
    for index, value in enumerate(values[positional:]):
        with builder.if_then(builder.load(valid)):
            name = py.tuple_getitem(names, index)
            with builder.if_else(cgutils.is_not_null(builder, name)) as (found, bad):
                with found:
                    status = py.dict_setitem(keywords, name, value)
                    builder.store(builder.icmp_signed('>=', status, ir.Constant(status.type, 0)), valid)
                with bad:
                    builder.store(ir.Constant(ir.IntType(1), 0), valid)
    with builder.if_then(builder.load(valid)):
        packed = py.tuple_pack([actual, arguments, keywords, frame, namespace])
        with builder.if_then(cgutils.is_not_null(builder, packed)):
            builder.store(py.call(helper, packed), result)
            py.decref(packed)
    py.decref(arguments)
    py.decref(keywords)
    return builder.load(result)


@intrinsic(prefer_literal=True)
def call_vector(typing_context, callee, arguments, names, positional):
    if not _valid(callee, arguments, names, positional):
        return
    signature = types.Tuple((managed, types.boolean))(callee, arguments, names, positional)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        actual = borrowed_object(context, builder, args[0])
        values = _values(context, builder, args[1], len(signature.args[1]))
        names = borrowed_object(context, builder, args[2]) if signature.args[2] == managed else py.get_null_object()
        result = _vectorcall(context, builder, py, actual, values, names, signature.args[3].literal_value)
        return adopt_owned(context, builder, py, result)
    return signature, codegen


def _in_frame(context, builder, signature, args):
    py = context.get_python_api(builder)
    actual = borrowed_object(context, builder, args[0])
    values = _values(context, builder, args[1], len(signature.args[1]))
    names = borrowed_object(context, builder, args[2]) if signature.args[2] == managed else py.get_null_object()
    frame, namespace, helper, special = [borrowed_object(context, builder, value) for value in args[4:]]
    match = ir.Constant(ir.IntType(1), 0)
    for index in range(6):
        candidate = py.tuple_getitem(special, index)
        match = builder.or_(match, builder.icmp_unsigned('==', actual, candidate))
    result = cgutils.alloca_once_value(builder, py.get_null_object())
    with builder.if_else(match) as (contextual, ordinary):
        with contextual:
            builder.store(_context_call(builder, py, actual, values, names,
                signature.args[3].literal_value, frame, namespace, helper), result)
        with ordinary:
            builder.store(_vectorcall(context, builder, py, actual, values, names,
                signature.args[3].literal_value), result)
    return py, builder.load(result)


@intrinsic(prefer_literal=True)
def call_vector_in_frame(typing_context, callee, arguments, names, positional, frame, namespace, helper, special):
    if not _valid(callee, arguments, names, positional) or any(value != managed for value in (frame, namespace, helper, special)):
        return
    signature = types.Tuple((managed, types.boolean))(callee, arguments, names, positional, frame, namespace, helper, special)
    def codegen(context, builder, signature, args):
        py, result = _in_frame(context, builder, signature, args)
        return adopt_owned(context, builder, py, result)
    return signature, codegen


def _discard(builder, py, result):
    ok = cgutils.is_not_null(builder, result)
    with builder.if_then(ok):
        # POP_TOP consumes the new reference before the next source effect.
        py.decref(result)
    return ok


@intrinsic(prefer_literal=True)
def call_vector_discard(typing_context, callee, arguments, names, positional):
    """Bare vectorcall plus POP_TOP for operands pinned through both steps.

    Ephemeral source operands use the split result/discard pair instead, so
    CALL operand cleanup precedes result cleanup exactly as in CPython.
    """
    if not _valid(callee, arguments, names, positional):
        return
    signature = types.boolean(callee, arguments, names, positional)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        actual = borrowed_object(context, builder, args[0])
        values = _values(context, builder, args[1], len(signature.args[1]))
        names = borrowed_object(context, builder, args[2]) if signature.args[2] == managed else py.get_null_object()
        result = _vectorcall(context, builder, py, actual, values, names, signature.args[3].literal_value)
        return _discard(builder, py, result)
    return signature, codegen


@intrinsic(prefer_literal=True)
def call_vector_in_frame_result(typing_context, callee, arguments, names, positional, frame, namespace, helper, special):
    """New C reference in a native stack slot, consumed by discard_vector_result.

    This is an internal call/POP_TOP pair, not an application value or alternate
    managed object model. The pointer may not escape or cross another effect.
    Splitting the pair lets Numba release call operands before POP_TOP, as CALL
    does in CPython. NULL remains the pending-error indicator.
    """
    if not _valid(callee, arguments, names, positional) or any(value != managed for value in (frame, namespace, helper, special)):
        return
    result_type = types.Tuple((types.voidptr, types.boolean))
    signature = result_type(callee, arguments, names, positional, frame, namespace, helper, special)
    def codegen(context, builder, signature, args):
        py, result = _in_frame(context, builder, signature, args)
        return context.make_tuple(builder, result_type, [result, cgutils.is_not_null(builder, result)])
    return signature, codegen


@intrinsic
def discard_vector_result(typing_context, result):
    if result != types.voidptr:
        return
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        _discard(builder, py, args[0])
        return context.get_dummy_value()
    return types.void(result), codegen
