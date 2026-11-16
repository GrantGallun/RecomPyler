"""Adaptation of numba-passthru's NRT-owned PyObject model.
See LICENSE.numba-passthru for the reused NRT ownership model.
"""
from llvmlite import ir
from numba.core import cgutils,types
from numba.core.datamodel import models
from numba.extending import intrinsic,register_model
from numba.core.pythonapi import NativeValue,unbox,box

class ManagedPyObject(types.Type):
    def __init__(self):super().__init__('recompyler.ManagedPyObject')
managed=ManagedPyObject()
opaque=types.Opaque('recompyler.OpaquePyObject')
@register_model(ManagedPyObject)
class ManagedModel(models.StructModel):
    def __init__(self,dmm,fe_type):super().__init__(dmm,fe_type,[('meminfo',types.MemInfoPointer(opaque)),('data',types.voidptr)])
@unbox(ManagedPyObject)
def unbox_managed(typ,obj,c):
    proxy=cgutils.create_struct_proxy(typ)(c.context,c.builder)
    proxy.meminfo=c.pyapi.nrt_meminfo_new_from_pyobject(obj,obj)
    failed=cgutils.is_null(c.builder,proxy.meminfo)
    proxy.data=c.builder.select(failed,c.pyapi.get_null_object(),obj)
    with c.builder.if_then(failed,likely=False):
        # Installed NRT increments owner before allocation; undo on NULL.
        c.pyapi.decref(obj);c.pyapi.err_set_string('PyExc_MemoryError','managed object allocation failed')
    return NativeValue(proxy._getvalue(),is_error=failed)
@box(ManagedPyObject)
def box_managed(typ,val,c):
    proxy=cgutils.create_struct_proxy(typ)(c.context,c.builder,value=val)
    obj=proxy.data
    c.pyapi.incref(obj);c.context.nrt.decref(c.builder,typ,val)
    return obj


def borrowed_object(context, builder, value):
    proxy = cgutils.create_struct_proxy(managed)(context, builder, value=value)
    return proxy.data


def borrow_root(context, builder, reference):
    """Construct a canonical handle for a non-NULL externally pinned root.

    Only synchronous native entry wrappers may use this constructor. The
    caller must pin the actual Python object through the complete native call
    and boxing of its result. Derived handles must not escape in NRT-owned
    containers or persistent native storage. This does not change ordinary
    owning unboxing or create an alternate runtime value representation.
    """
    proxy=cgutils.create_struct_proxy(managed)(context,builder)
    proxy.meminfo=ir.Constant(context.get_value_type(types.MemInfoPointer(opaque)),None)
    proxy.data=reference
    return proxy._getvalue()

def _owned(context, builder, py, obj, borrowed=False):
    """NULL becomes an explicit failed value; all callers propagate before reuse."""
    result_type = types.Tuple((managed, types.boolean))
    proxy = cgutils.create_struct_proxy(managed)(context, builder)
    proxy.meminfo = ir.Constant(context.get_value_type(types.MemInfoPointer(opaque)), None)
    proxy.data = py.get_null_object()
    result = cgutils.alloca_once_value(builder, proxy._getvalue())
    ok = cgutils.alloca_once_value(builder, ir.Constant(ir.IntType(1), 0))
    with builder.if_then(cgutils.is_not_null(builder, obj)):
        info = py.nrt_meminfo_new_from_pyobject(obj, obj)
        with builder.if_else(cgutils.is_null(builder, info), likely=False) as (bad, good):
            with bad:
                py.decref(obj)  # NRT takes its owner reference before allocating.
                py.err_set_string('PyExc_MemoryError', 'managed result allocation failed')
            with good:
                proxy.meminfo = info
                proxy.data = obj
                builder.store(proxy._getvalue(), result)
                builder.store(ir.Constant(ir.IntType(1), 1), ok)
        if not borrowed:
            py.decref(obj)
    return context.make_tuple(builder, result_type, [builder.load(result), builder.load(ok)])


def _operation(name, count):
    def define(typing_context, *arguments):
        if len(arguments) != count or any(arg != managed for arg in arguments):
            return
        signature = types.Tuple((managed, types.boolean))(*arguments)
        def codegen(context, builder, signature, args):
            py = context.get_python_api(builder)
            objects = [borrowed_object(context, builder, value) for value in args]
            value = getattr(py, name)(*objects)
            return _owned(context, builder, py, value)
        return signature, codegen
    names = ["a"+str(index) for index in range(count)]
    scope={"define":define}
    exec("def operation(typing_context,"+",".join(names)+"):\n    return define(typing_context,"+",".join(names)+")",scope)
    return intrinsic(scope["operation"])


getattr_object = _operation('object_getattr', 2)
getitem_object = _operation('object_getitem', 2)


@intrinsic
def pool_item(typing_context, pool, index):
    if pool != managed or not isinstance(index, types.Integer):
        return
    signature = types.Tuple((managed, types.boolean))(pool, index)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        index = context.cast(builder, args[1], signature.args[1], types.intp)
        fnty=ir.FunctionType(py.pyobj,[py.pyobj,py.py_ssize_t])
        fn=cgutils.get_or_insert_function(builder.module,fnty,'PyTuple_GetItem')
        obj=builder.call(fn,[borrowed_object(context,builder,args[0]),index])
        # Tuple contents are immutable. The existing pool owner therefore pins
        # this selected object too; reuse its sole MemInfo, with no new owner
        # allocation or persistent Python edge hidden in a native cache.
        owner=cgutils.create_struct_proxy(managed)(context,builder,value=args[0])
        selected=cgutils.create_struct_proxy(managed)(context,builder)
        found=cgutils.is_not_null(builder,obj)
        null_info=ir.Constant(context.get_value_type(types.MemInfoPointer(opaque)),None)
        selected.meminfo=builder.select(found,owner.meminfo,null_info)
        selected.data=obj
        with builder.if_then(found):context.nrt.incref(builder,managed,args[0])
        return context.make_tuple(builder,signature.return_type,[selected._getvalue(),found])
    return signature, codegen


@intrinsic
def tuple_object(typing_context, arguments):
    if not isinstance(arguments, types.BaseTuple) or any(arg != managed for arg in arguments):
        return
    signature = types.Tuple((managed, types.boolean))(arguments)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        values = cgutils.unpack_tuple(builder,args[0],len(signature.args[0]))
        obj = py.tuple_pack([borrowed_object(context, builder, value) for value in values])
        return _owned(context, builder, py, obj)
    return signature, codegen


@intrinsic
def capture_error_into(typing_context,holder):
    """Move the active exception into an existing list, without NRT allocation.

    Callers then return normally through Numba's complete NRT-local cleanup.
    The holder is a private one-slot exact list prepared before native entry.
    """
    if holder != managed:return
    def codegen(context,builder,signature,args):
        py=context.get_python_api(builder)
        fnty=ir.FunctionType(py.pyobj,[])
        fn=cgutils.get_or_insert_function(builder.module,fnty,'PyErr_GetRaisedException')
        error=builder.call(fn,[])
        py.list_setitem(borrowed_object(context,builder,args[0]),ir.Constant(py.py_ssize_t,0),error)
        return context.get_dummy_value()
    return types.void(holder),codegen


def adopt_owned(context, builder, pyapi, new_reference):
    """Consume a new reference, yielding (managed, ok); NULL keeps its error."""
    return _owned(context, builder, pyapi, new_reference)

def retain_borrowed(context, builder, pyapi, reference):
    """Retain a borrowed reference, yielding (managed, ok)."""
    return _owned(context, builder, pyapi, reference, borrowed=True)


@intrinsic
def isinstance_object(typing_context, value, classes):
    if value != managed or classes != managed:
        return
    signature = types.Tuple((types.boolean, types.boolean))(value, classes)
    def codegen(context, builder, signature, args):
        py = context.get_python_api(builder)
        fnty = ir.FunctionType(ir.IntType(32), [py.pyobj, py.pyobj])
        fn = cgutils.get_or_insert_function(builder.module, fnty, 'PyObject_IsInstance')
        result = builder.call(fn, [borrowed_object(context,builder,arg) for arg in args])
        zero = ir.Constant(result.type, 0)
        return context.make_tuple(builder, signature.return_type, [builder.icmp_signed('>',result,zero),builder.icmp_signed('>=',result,zero)])
    return signature, codegen


@intrinsic
def truth_object(typing_context, value):
    if value != managed:return
    signature = types.Tuple((types.boolean, types.boolean))(value)
    def codegen(context,builder,signature,args):
        py=context.get_python_api(builder)
        result=py.object_istrue(borrowed_object(context,builder,args[0]))
        zero=ir.Constant(result.type,0)
        return context.make_tuple(builder,signature.return_type,[builder.icmp_signed('>',result,zero),builder.icmp_signed('>=',result,zero)])
    return signature,codegen


@intrinsic
def list_object(typing_context, arguments):
    if not isinstance(arguments,types.BaseTuple) or any(arg != managed for arg in arguments):return
    signature=types.Tuple((managed,types.boolean))(arguments)
    def codegen(context,builder,signature,args):
        py=context.get_python_api(builder)
        values=cgutils.unpack_tuple(builder,args[0],len(signature.args[0]))
        obj=py.list_new(ir.Constant(py.py_ssize_t,len(values)))
        with builder.if_then(cgutils.is_not_null(builder,obj)):
            for index,arg in enumerate(values):
                item=borrowed_object(context,builder,arg)
                py.incref(item)
                py.list_setitem(obj,ir.Constant(py.py_ssize_t,index),item)
        return adopt_owned(context,builder,py,obj)
    return signature,codegen


getiter_object = _operation('object_getiter', 1)
str_object = _operation('object_str', 1)


@intrinsic
def next_object(typing_context, value):
    if value != managed:return
    signature=types.Tuple((managed,types.boolean,types.boolean))(value)
    def codegen(context,builder,signature,args):
        py=context.get_python_api(builder)
        fnty=ir.FunctionType(py.pyobj,[py.pyobj])
        fn=cgutils.get_or_insert_function(builder.module,fnty,'PyIter_Next')
        obj=builder.call(fn,[borrowed_object(context,builder,args[0])])
        ended=cgutils.is_null(builder,obj)
        error=cgutils.is_not_null(builder,py.err_occurred())
        owned=retain_borrowed(context,builder,py,py.borrow_none())
        slot=cgutils.alloca_once_value(builder,owned)
        with builder.if_then(builder.not_(ended)):
            # Replace the temporary None owner before giving the item to Numba.
            prior=builder.load(slot)
            context.nrt.decref(builder,managed,builder.extract_value(prior,0))
            builder.store(adopt_owned(context,builder,py,obj),slot)
        pair=builder.load(slot)
        return context.make_tuple(builder,signature.return_type,[builder.extract_value(pair,0),ended,builder.and_(builder.extract_value(pair,1),builder.not_(error))])
    return signature,codegen


@intrinsic
def append_object(typing_context, seq, value):
    if seq != managed or value != managed:return
    def codegen(context,builder,signature,args):
        py=context.get_python_api(builder)
        status=py.list_append(*[borrowed_object(context,builder,arg) for arg in args])
        return builder.icmp_signed('>=',status,ir.Constant(status.type,0))
    return types.boolean(seq,value),codegen


@intrinsic
def raise_object(typing_context, exception, message):
    if exception != managed or message != managed:return
    def codegen(context,builder,signature,args):
        import ctypes
        py=context.get_python_api(builder)
        cls,value=[borrowed_object(context,builder,arg) for arg in args]
        instance=py.call_function_objargs(cls,[value])
        with builder.if_then(cgutils.is_not_null(builder,instance)):
            actual_type=py.object_type(instance)
            long_type=ir.IntType(ctypes.sizeof(ctypes.c_ulong)*8)
            flags_fn=cgutils.get_or_insert_function(builder.module,ir.FunctionType(long_type,[py.pyobj]),'PyType_GetFlags')
            flags=builder.call(flags_fn,[actual_type]);py.decref(actual_type)
            exception_bit=ir.Constant(long_type,1<<30)
            valid=builder.icmp_unsigned('!=',builder.and_(flags,exception_bit),ir.Constant(long_type,0))
            with builder.if_else(valid) as (good,bad):
                with good:
                    fn=cgutils.get_or_insert_function(builder.module,ir.FunctionType(ir.VoidType(),[py.pyobj]),'PyErr_SetRaisedException')
                    builder.call(fn,[instance])  # consumes the new instance reference
                with bad:
                    py.decref(instance)
                    py.err_set_string('PyExc_TypeError','exceptions must derive from BaseException')
        return context.get_dummy_value()
    return types.void(exception,message),codegen


concat_object = _operation('number_add', 2)


@intrinsic
def format_object(typing_context,value,spec):
    if value != managed or spec != managed:return
    def codegen(context,builder,signature,args):
        py=context.get_python_api(builder)
        fnty=ir.FunctionType(py.pyobj,[py.pyobj,py.pyobj])
        fn=cgutils.get_or_insert_function(builder.module,fnty,'PyObject_Format')
        obj=builder.call(fn,[borrowed_object(context,builder,arg) for arg in args])
        return adopt_owned(context,builder,py,obj)
    return types.Tuple((managed,types.boolean))(value,spec),codegen


@intrinsic
def bool_object(typing_context,value):
    if value != types.boolean:return
    def codegen(context,builder,signature,args):
        py=context.get_python_api(builder)
        return adopt_owned(context,builder,py,py.bool_from_bool(args[0]))
    return types.Tuple((managed,types.boolean))(value),codegen


@intrinsic
def owned_container(typing_context,value):
    """Only exact lists/tuples have elements in the guarded owner graph."""
    if value != managed:return
    def codegen(context,builder,signature,args):
        py=context.get_python_api(builder)
        obj=borrowed_object(context,builder,args[0])
        cls=py.object_type(obj)
        valid=ir.Constant(ir.IntType(1),0)
        for name in ('PyList_Type','PyTuple_Type'):
            glob=builder.module.globals.get(name)
            if glob is None:
                glob=ir.GlobalVariable(builder.module,ir.IntType(8),name)
                glob.linkage='external'
                if __import__('sys').platform=='win32':glob.storage_class='dllimport'
            expected=builder.bitcast(glob,py.pyobj)
            valid=builder.or_(valid,builder.icmp_unsigned('==',cls,expected))
        py.decref(cls)
        return valid
    return types.boolean(value),codegen
