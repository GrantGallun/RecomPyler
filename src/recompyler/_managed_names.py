"""Native CPython name operations on the canonical managed-reference ABI."""
from llvmlite import ir
from numba.core import cgutils, types
from numba.extending import intrinsic
from ._managed_native import managed, borrowed_object, adopt_owned, retain_borrowed


def _lookup(builder, py, namespace, name):
    # Unlike PyDict_GetItem, this preserves errors from keys inserted by a callback.
    function = cgutils.get_or_insert_function(builder.module,
        ir.FunctionType(py.pyobj, [py.pyobj, py.pyobj]), 'PyDict_GetItemWithError')
    return builder.call(function, [namespace, name])


def _missing_global(builder, py, name):
    py.err_format('PyExc_NameError', "name '%U' is not defined", name)
    matches = cgutils.get_or_insert_function(builder.module,
        ir.FunctionType(ir.IntType(32), [py.pyobj]), 'PyErr_ExceptionMatches')
    with builder.if_then(builder.icmp_signed('!=', builder.call(matches,
            [py.get_c_object('PyExc_NameError')]), ir.Constant(ir.IntType(32), 0))):
        get_error = cgutils.get_or_insert_function(builder.module,
            ir.FunctionType(py.pyobj, []), 'PyErr_GetRaisedException')
        set_error = cgutils.get_or_insert_function(builder.module,
            ir.FunctionType(ir.VoidType(), [py.pyobj]), 'PyErr_SetRaisedException')
        error = builder.call(get_error, [])
        status = py.object_setattr_string(error, 'name', name)
        with builder.if_else(builder.icmp_signed('>=', status, ir.Constant(status.type, 0))) as (good, bad):
            with good:
                builder.call(set_error, [error])  # steals the original exception
            with bad:
                py.decref(error)


def _global_value(builder, py, namespace, builtins, name):
    result = cgutils.alloca_once_value(builder, py.get_null_object())
    value = _lookup(builder, py, namespace, name)
    with builder.if_else(cgutils.is_not_null(builder, value)) as (found, absent):
        with found:
            builder.store(value, result)
        with absent:
            with builder.if_then(cgutils.is_null(builder, py.err_occurred())):
                fallback = _lookup(builder, py, builtins, name)
                with builder.if_else(cgutils.is_not_null(builder, fallback)) as (found_builtin, missing):
                    with found_builtin:
                        builder.store(fallback, result)
                    with missing:
                        with builder.if_then(cgutils.is_null(builder, py.err_occurred())):
                            _missing_global(builder, py, name)
    return builder.load(result)


@intrinsic
def read_global_owned(typing_context, namespace, builtins, name, expected):
    """Reuse the catalogue owner only when the live lookup selects that object."""
    if any(value != managed for value in (namespace, builtins, name, expected)):
        return
    signature = types.Tuple((managed, types.boolean))(namespace, builtins, name, expected)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        namespace, builtins, name, expected = [borrowed_object(context, builder, value) for value in args]
        selected = _global_value(builder, py, namespace, builtins, name)
        result = cgutils.alloca_once(builder, context.get_value_type(signature.return_type))
        with builder.if_else(builder.icmp_unsigned('==', selected, expected)) as (known, changed):
            with known:
                context.nrt.incref(builder, managed, args[3])
                answer = context.make_tuple(builder, signature.return_type,
                    [args[3], ir.Constant(ir.IntType(1), 1)])
                builder.store(answer, result)
            with changed:
                builder.store(retain_borrowed(context, builder, py, selected), result)
        return builder.load(result)
    return signature, codegen


@intrinsic
def read_name(typing_context, frame, namespace, builtins, name, local):
    if any(value != managed for value in (frame, namespace, builtins, name)) or not isinstance(local, types.Boolean):
        return
    signature = types.Tuple((managed, types.boolean))(frame, namespace, builtins, name, local)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        frame, namespace, builtins, name = [borrowed_object(context, builder, value) for value in args[:4]]
        result = cgutils.alloca_once_value(builder, py.get_null_object())
        with builder.if_else(args[4]) as (local_read, global_read):
            with local_read:
                frame_type = py.object_type(frame)
                exact = builder.icmp_unsigned('==', frame_type, py.get_c_object('PyDict_Type'))
                py.decref(frame_type)
                with builder.if_else(exact) as (plain, custom):
                    with plain:
                        value = _lookup(builder, py, frame, name)
                        with builder.if_else(cgutils.is_not_null(builder, value)) as (found, absent):
                            with found:
                                py.incref(value)
                                builder.store(value, result)
                            with absent:
                                with builder.if_then(cgutils.is_null(builder, py.err_occurred())):
                                    py.err_format('PyExc_UnboundLocalError',
                                        "cannot access local variable '%U' where it is not associated with a value", name)
                    with custom:
                        # Cell-backed frames retain their mapping protocol and exact
                        # empty-cell behavior. No helper is called for ordinary dicts.
                        from ._call_bridge import _read_name
                        helper = py.unserialize(py.serialize_object(_read_name))
                        with builder.if_then(cgutils.is_not_null(builder, helper)):
                            flag = py.bool_from_bool(args[4])
                            packed = py.tuple_pack([frame, namespace, builtins, name, flag])
                            py.decref(flag)
                            with builder.if_then(cgutils.is_not_null(builder, packed)):
                                builder.store(py.call(helper, packed), result)
                                py.decref(packed)
                            py.decref(helper)
            with global_read:
                value = _global_value(builder, py, namespace, builtins, name)
                with builder.if_then(cgutils.is_not_null(builder, value)):
                    py.incref(value)
                    builder.store(value, result)
        return adopt_owned(context, builder, py, builder.load(result))
    return signature, codegen


@intrinsic
def store_name(typing_context, frame, name, value):
    if any(value != managed for value in (frame, name, value)):
        return
    signature = types.boolean(frame, name, value)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        frame, name, value = [borrowed_object(context, builder, value) for value in args]
        status = py.object_setitem(frame, name, value)
        return builder.icmp_signed('>=', status, ir.Constant(status.type, 0))
    return signature, codegen

