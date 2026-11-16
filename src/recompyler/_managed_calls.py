"""CPython calls using the shared NRT-owned managed-reference ABI."""
from llvmlite import ir
from numba.core import cgutils, types
from numba.extending import intrinsic
from ._managed_native import managed, borrowed_object, adopt_owned, retain_borrowed, capture_error_into as capture_error


@intrinsic
def call_object(typing_context, callee, positional, keywords):
    if any(value != managed for value in (callee, positional, keywords)):
        return
    signature = types.Tuple((managed, types.boolean))(callee, positional, keywords)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        objects = [borrowed_object(context, builder, arg) for arg in args]
        return adopt_owned(context, builder, py, py.call(*objects))
    return signature, codegen


@intrinsic
def dict_object(typing_context, arguments):
    if not isinstance(arguments, types.BaseTuple) or len(arguments) % 2 or any(value != managed for value in arguments):
        return
    signature = types.Tuple((managed, types.boolean))(arguments)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        args = cgutils.unpack_tuple(builder, args[0], len(signature.args[0]))
        obj = py.dict_new()
        valid = cgutils.alloca_once_value(builder, cgutils.is_not_null(builder, obj))
        for index in range(0, len(args), 2):
            with builder.if_then(builder.load(valid)):
                status = py.dict_setitem(obj, borrowed_object(context, builder, args[index]),
                                        borrowed_object(context, builder, args[index + 1]))
                builder.store(builder.icmp_signed('>=', status, ir.Constant(status.type, 0)), valid)
        with builder.if_then(builder.not_(builder.load(valid))):
            py.decref(obj)
        selected = builder.select(builder.load(valid), obj, py.get_null_object())
        return adopt_owned(context, builder, py, selected)
    return signature, codegen


@intrinsic
def call_in_frame(typing_context, callee, positional, keywords, frame, namespace, helper, special):
    if any(value != managed for value in (callee, positional, keywords, frame, namespace, helper, special)):
        return
    signature = types.Tuple((managed, types.boolean))(*([managed] * 7))
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        objects = [borrowed_object(context, builder, arg) for arg in args]
        actual, positional, keywords, frame, namespace, helper, special = objects
        match = ir.Constant(ir.IntType(1), 0)
        for index in range(6):
            candidate = py.tuple_getitem(special, index)
            match = builder.or_(match, builder.icmp_unsigned('==', actual, candidate))
        slot = cgutils.alloca_once(builder, py.pyobj)
        with builder.if_else(match) as (context_call, ordinary):
            with context_call:
                packed = py.tuple_pack([actual, positional, keywords, frame, namespace])
                result = cgutils.alloca_once_value(builder, py.get_null_object())
                with builder.if_then(cgutils.is_not_null(builder, packed)):
                    builder.store(py.call(helper, packed), result)
                    py.decref(packed)
                builder.store(builder.load(result), slot)
            with ordinary:
                builder.store(py.call(actual, positional, keywords), slot)
        return adopt_owned(context, builder, py, builder.load(slot))
    return signature, codegen

@intrinsic
def slice_object(typing_context, lower, upper, step):
    if any(value != managed for value in (lower, upper, step)):
        return
    signature = types.Tuple((managed, types.boolean))(lower, upper, step)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        fn = cgutils.get_or_insert_function(builder.module, ir.FunctionType(py.pyobj, [py.pyobj] * 3), 'PySlice_New')
        result = builder.call(fn, [borrowed_object(context, builder, value) for value in args])
        return adopt_owned(context, builder, py, result)
    return signature, codegen


@intrinsic
def import_from_object(typing_context, module, name):
    if module != managed or name != managed:
        return
    signature = types.Tuple((managed, types.boolean))(module, name)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        # CPython 3.14's own IMPORT_FROM operation includes circular-import
        # sys.modules lookup and exact ImportError metadata, beyond getattr.
        state_fn = cgutils.get_or_insert_function(builder.module,
            ir.FunctionType(py.pyobj, []), 'PyThreadState_Get')
        fn = cgutils.get_or_insert_function(builder.module,
            ir.FunctionType(py.pyobj, [py.pyobj] * 3), '_PyEval_ImportFrom')
        result = builder.call(fn, [builder.call(state_fn, []),
            borrowed_object(context, builder, args[0]), borrowed_object(context, builder, args[1])])
        return adopt_owned(context, builder, py, result)
    return signature, codegen


@intrinsic
def function_object(typing_context, code, namespace, closure, defaults, keyword_defaults):
    """Create a real CPython function from original code and owned metadata."""
    if any(value != managed for value in (code, namespace, closure, defaults, keyword_defaults)):
        return
    signature = types.Tuple((managed, types.boolean))(*([managed] * 5))
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        values = [borrowed_object(context, builder, arg) for arg in args]
        create = cgutils.get_or_insert_function(builder.module,
            ir.FunctionType(py.pyobj, [py.pyobj] * 2), 'PyFunction_New')
        value = builder.call(create, values[:2])
        slot = cgutils.alloca_once_value(builder, value)
        for name, metadata in zip(('PyFunction_SetClosure','PyFunction_SetKwDefaults','PyFunction_SetDefaults'),(values[2],values[4],values[3])):
            with builder.if_then(cgutils.is_not_null(builder, builder.load(slot))):
                setter = cgutils.get_or_insert_function(builder.module,
                    ir.FunctionType(ir.IntType(32), [py.pyobj] * 2), name)
                status = builder.call(setter, [value, metadata])
                with builder.if_then(builder.icmp_signed('<', status, ir.Constant(status.type, 0))):
                    py.decref(value)
                    builder.store(py.get_null_object(), slot)
        return adopt_owned(context, builder, py, builder.load(slot))
    return signature, codegen


@intrinsic
def counts_owner(typing_context, counts):
    if counts != types.Array(types.int64, 1, 'C'):
        return
    signature = types.Tuple((managed, types.boolean))(counts)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        array = context.make_array(signature.args[0])(context, builder, value=args[0])
        parent = array.parent
        with builder.if_then(cgutils.is_null(builder, parent)):
            py.err_set_string('PyExc_SystemError', 'protected call has no Python counter owner')
        return retain_borrowed(context, builder, py, parent)
    return signature, codegen
