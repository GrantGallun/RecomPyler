"""Canonical lazy CPython frame materialization for GIL-held native bodies.

This is a provider ABI, not permission to compile arbitrary callback sites.
Callers must enter through run_entry, mark original instructions, mirror source
locals/cells/operand lifetimes and leave on every path. Unsupported observers,
protected/suspended/variadic scopes refuse before entry. Existing frontends keep
native_activation_available False until their complete emission contract passes.
"""
from llvmlite import ir, binding
from numba.core import types, cgutils
from numba.core.datamodel import models
from numba.extending import intrinsic, register_model
from . import _managed_native as refs

try:
    from . import _source_frames_native as native
except ImportError:
    native = None
if native is not None:
    for name, address in native.addresses().items():
        binding.add_symbol('rc_source_frame_' + name, address)


def available():
    return native is not None


def run_entry(entry, arguments):
    if native is None:
        raise RuntimeError('source-frame provider unavailable')
    return native.run_entry(entry, arguments)


class Activation(types.Type):
    def __init__(self):
        super().__init__('recompyler.SourceActivation')


activation = Activation()
register_model(Activation)(models.OpaqueModel)


def _call(builder, name, result, values):
    fn = cgutils.get_or_insert_function(builder.module,
        ir.FunctionType(result, [v.type for v in values]), 'rc_source_frame_' + name)
    return builder.call(fn, values)


def _index(context, builder, value, typ):
    return context.cast(builder, value, typ, types.intp)


def _ok(builder, status):
    return builder.icmp_signed('==', status, ir.Constant(status.type, 0))


@intrinsic
def enter(tc, function, code, arguments, pc):
    if not available() or function != refs.managed or code != refs.managed or not isinstance(pc,types.Integer):
        return
    if not isinstance(arguments, types.BaseTuple) or any(t != refs.managed for t in arguments):
        return
    def codegen(context, builder, sig, args):
        py = context.get_python_api(builder)
        values = cgutils.unpack_tuple(builder, args[2], len(sig.args[2]))
        storage = cgutils.alloca_once(builder, py.pyobj, size=max(1, len(values)))
        for index, value in enumerate(values):
            builder.store(refs.borrowed_object(context,builder,value),
                          builder.gep(storage,[context.get_constant(types.intp,index)]))
        pointer = _call(builder,'enter',py.voidptr,[
            refs.borrowed_object(context,builder,args[0]),
            refs.borrowed_object(context,builder,args[1]),storage,
            context.get_constant(types.intp,len(values)),
            _index(context,builder,args[3],sig.args[3])])
        return context.make_tuple(builder,sig.return_type,[pointer,cgutils.is_not_null(builder,pointer)])
    return types.Tuple((activation,types.boolean))(function,code,arguments,pc),codegen


@intrinsic
def mark(tc, frame, pc):
    if not available() or frame != activation or not isinstance(pc,types.Integer):
        return
    def codegen(context,builder,sig,args):
        return _ok(builder,_call(builder,'mark',ir.IntType(32),[
            args[0],_index(context,builder,args[1],sig.args[1])]))
    return types.boolean(frame,pc),codegen


def _slot_load(name):
    @intrinsic
    def operation(tc, frame, index):
        if not available() or frame != activation or not isinstance(index,types.Integer):
            return
        def codegen(context,builder,sig,args):
            py=context.get_python_api(builder)
            value=_call(builder,name,py.pyobj,[args[0],_index(context,builder,args[1],sig.args[1])])
            return refs.adopt_owned(context,builder,py,value)
        return types.Tuple((refs.managed,types.boolean))(frame,index),codegen
    return operation


load = _slot_load('load')
cell = _slot_load('cell')


@intrinsic
def store(tc, frame, index, value):
    if not available() or frame != activation or value != refs.managed or not isinstance(index,types.Integer):
        return
    def codegen(context,builder,sig,args):
        return _ok(builder,_call(builder,'store',ir.IntType(32),[
            args[0],_index(context,builder,args[1],sig.args[1]),
            refs.borrowed_object(context,builder,args[2])]))
    return types.boolean(frame,index,value),codegen


@intrinsic
def delete(tc, frame, index):
    if not available() or frame != activation or not isinstance(index,types.Integer):
        return
    def codegen(context,builder,sig,args):
        return _ok(builder,_call(builder,'delete',ir.IntType(32),[
            args[0],_index(context,builder,args[1],sig.args[1])]))
    return types.boolean(frame,index),codegen


@intrinsic
def push(tc, frame, value):
    if not available() or frame != activation or value != refs.managed:
        return
    def codegen(context,builder,sig,args):
        return _ok(builder,_call(builder,'push',ir.IntType(32),[
            args[0],refs.borrowed_object(context,builder,args[1])]))
    return types.boolean(frame,value),codegen


@intrinsic
def pop(tc, frame):
    if not available() or frame != activation:
        return
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        return refs.adopt_owned(context,builder,py,_call(builder,'pop',py.pyobj,[args[0]]))
    return types.Tuple((refs.managed,types.boolean))(frame),codegen


@intrinsic
def leave(tc, frame, errors, success, pc):
    if not available() or frame != activation or errors != refs.managed or success != types.boolean or not isinstance(pc,types.Integer):
        return
    def codegen(context,builder,sig,args):
        status=_call(builder,'leave',ir.IntType(32),[args[0],
            refs.borrowed_object(context,builder,args[1]),
            builder.zext(args[2],ir.IntType(32)),_index(context,builder,args[3],sig.args[3])])
        return _ok(builder,status)
    return types.boolean(frame,errors,success,pc),codegen

