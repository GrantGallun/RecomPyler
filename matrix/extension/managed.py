"""Diagnostic adaptation of numba-passthru's NRT-owned PyObject model.
See vendor/LICENSE.numba-passthru and upstream-sources.json. No product changes.
"""
from llvmlite import ir
from numba.core import cgutils,types
from numba.core.datamodel import models
from numba.extending import intrinsic,register_model
from numba.core.pythonapi import NativeValue,unbox,box

class ManagedPyObject(types.Type):
    def __init__(self):super().__init__('wave17.ManagedPyObject')
managed=ManagedPyObject()
opaque=types.Opaque('wave17.OpaquePyObject')
@register_model(ManagedPyObject)
class ManagedModel(models.StructModel):
    def __init__(self,dmm,fe_type):super().__init__(dmm,fe_type,[('meminfo',types.MemInfoPointer(opaque))])
@unbox(ManagedPyObject)
def unbox_managed(typ,obj,c):
    proxy=cgutils.create_struct_proxy(typ)(c.context,c.builder)
    proxy.meminfo=c.pyapi.nrt_meminfo_new_from_pyobject(obj,obj)
    failed=cgutils.is_null(c.builder,proxy.meminfo)
    with c.builder.if_then(failed,likely=False):
        # Installed NRT increments owner before allocation; undo on NULL.
        c.pyapi.decref(obj);c.pyapi.err_set_string('PyExc_MemoryError','managed object allocation failed')
    return NativeValue(proxy._getvalue(),is_error=failed)
@box(ManagedPyObject)
def box_managed(typ,val,c):
    proxy=cgutils.create_struct_proxy(typ)(c.context,c.builder,value=val)
    obj=c.context.nrt.meminfo_data(c.builder,proxy.meminfo)
    c.pyapi.incref(obj);c.context.nrt.decref(c.builder,typ,val)
    return obj

@intrinsic
def string_body(typing_context,a):
    if a!=managed:return
    result_type=types.Tuple((managed,types.boolean))
    sig=result_type(a)
    def codegen(context,builder,signature,args):
        py=context.get_python_api(builder);null=ir.Constant(py.pyobj,None)
        parent=cgutils.create_struct_proxy(managed)(context,builder,value=args[0])
        obj=context.nrt.meminfo_data(builder,parent.meminfo)
        slots=[cgutils.alloca_once_value(builder,null) for _ in range(6)]
        success=cgutils.alloca_once_value(builder,ir.Constant(ir.IntType(1),0))
        out=cgutils.create_struct_proxy(managed)(context,builder)
        out.meminfo=ir.Constant(context.get_value_type(types.MemInfoPointer(opaque)),None)
        output_slot=cgutils.alloca_once_value(builder,out._getvalue())
        cleanup=builder.append_basic_block('string.cleanup')
        def checked(value,slot):
            builder.store(value,slot)
            with builder.if_then(cgutils.is_null(builder,value),likely=False):builder.branch(cleanup)
            return value
        x=checked(py.object_getattr_string(obj,'x'),slots[0])
        y=checked(py.object_getattr_string(obj,'y'),slots[1])
        z=checked(py.object_getattr_string(obj,'z'),slots[2])
        values=checked(py.tuple_pack([x,y,z]),slots[3])
        for slot in slots[:3]:
            py.decref(builder.load(slot));builder.store(null,slot)
        # unicode_from_string takes an LLVM constant char pointer.
        fmt=checked(py.string_from_string(context.insert_const_string(builder.module,'<%f, %f, %f>')),slots[4])
        result=checked(py.number_remainder(fmt,values),slots[5])
        owned=py.nrt_meminfo_new_from_pyobject(result,result)
        with builder.if_else(cgutils.is_null(builder,owned),likely=False) as (bad,good):
            with bad:
                py.decref(result);py.err_set_string('PyExc_MemoryError','managed result allocation failed')
            with good:
                out.meminfo=owned;builder.store(out._getvalue(),output_slot);builder.store(ir.Constant(ir.IntType(1),1),success)
        builder.branch(cleanup);builder.position_at_end(cleanup)
        # tuple construction owns additional refs; these six owned temporaries
        # unwind at their Python expression boundary, including every NULL edge.
        for slot in reversed(slots):py.decref(builder.load(slot))
        return context.make_tuple(builder,result_type,[builder.load(output_slot),builder.load(success)])
    return sig,codegen

@intrinsic
def propagate_active(typing_context):
    def codegen(context,builder,signature,args):
        context.call_conv.return_exc(builder)
        builder.position_at_end(builder.append_basic_block("unreachable.continuation"))
        return context.get_dummy_value()
    return types.void(),codegen

def string_build(a):
    result,ok=string_body(a)
    if ok:return result
    propagate_active()
    return result
