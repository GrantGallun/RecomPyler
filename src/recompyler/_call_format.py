"""General formatted-string calls through canonical managed CPython objects."""
import ast
from llvmlite import ir
from numba.core import types, cgutils
from numba.extending import intrinsic
from ._managed_native import managed, borrowed_object, adopt_owned, str_object, format_object


def _conversion(symbol):
    @intrinsic
    def convert(typing_context, value):
        if value != managed:
            return
        signature = types.Tuple((managed, types.boolean))(value)
        def codegen(context, builder, signature, args):
            py = context.get_python_api(builder)
            fn = cgutils.get_or_insert_function(builder.module, ir.FunctionType(py.pyobj, [py.pyobj]), symbol)
            result = builder.call(fn, [borrowed_object(context, builder, args[0])])
            return adopt_owned(context, builder, py, result)
        return signature, codegen
    return convert


repr_object = _conversion('PyObject_Repr')
ascii_object = _conversion('PyObject_ASCII')


@intrinsic
def join_object(typing_context, separator, values):
    if separator != managed or values != managed:
        return
    signature = types.Tuple((managed, types.boolean))(separator, values)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        fn = cgutils.get_or_insert_function(builder.module, ir.FunctionType(py.pyobj, [py.pyobj, py.pyobj]), 'PyUnicode_Join')
        result = builder.call(fn, [borrowed_object(context, builder, value) for value in args])
        return adopt_owned(context, builder, py, result)
    return signature, codegen


def emit(compiler, node):
    compiler.intrinsics.update(_fmt_repr=repr_object, _fmt_ascii=ascii_object,
                               _fmt_str=str_object, _fmt_value=format_object, _fmt_join=join_object)
    if isinstance(node, ast.JoinedStr):
        pieces = [compiler.expression(value) for value in node.values]
        if len(pieces) == 1:
            return pieces[0]
        values = compiler.operation('_tuple_object', *pieces)
        return compiler.operation('_fmt_join', compiler.pooled(''), values)
    value = compiler.expression(node.value)
    conversions = {114: '_fmt_repr', 115: '_fmt_str', 97: '_fmt_ascii'}
    if node.conversion != -1:
        value = compiler.operation(conversions[node.conversion], value)
    # CPython converts before it evaluates a dynamic format specification.
    spec = compiler.expression(node.format_spec) if node.format_spec is not None else compiler.pooled('')
    return compiler.operation('_fmt_value', value, spec)
