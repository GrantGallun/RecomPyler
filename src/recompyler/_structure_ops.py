"""CPython structure operations through the canonical managed reference ABI."""
import types as pytypes
from llvmlite import ir
from numba.core import cgutils, types
from numba.extending import intrinsic
from llvmlite import binding as llvm
import ctypes
try:
    from . import _structure_ops_native as ops
except ImportError:
    ops=None
if ops is not None:
    _ops_dll=ctypes.PyDLL(ops.__file__)
    for _symbol in ('rc_structure_load_attr','rc_structure_store_attr','rc_structure_getitem','rc_structure_setitem','rc_structure_contains','rc_structure_method_kind','rc_structure_method_value','rc_structure_sequence_matches','rc_structure_unpack','rc_structure_isinstance_builtin'):
        llvm.add_symbol(_symbol,ctypes.cast(getattr(_ops_dll,_symbol),ctypes.c_void_p).value)
from . import _managed_native as refs


def capi(builder,name,result,args,argtypes=None):
    fn=cgutils.get_or_insert_function(builder.module,ir.FunctionType(result,argtypes or [a.type for a in args]),name)
    return builder.call(fn,args)

@intrinsic
def same_object(tc,left,right):
    if left!=refs.managed or right!=refs.managed:return
    def codegen(context,builder,sig,args):
        return builder.icmp_unsigned('==',*[refs.borrowed_object(context,builder,a) for a in args])
    return types.boolean(left,right),codegen

@intrinsic
def callee_matches(tc,callee,function,code,owner,bound):
    if any(t!=refs.managed for t in (callee,function,code,owner)) or bound!=types.boolean:return
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        actual,expected,saved,receiver=[refs.borrowed_object(context,builder,a) for a in args[:4]]
        cls=py.object_type(actual)
        fn_type=context.add_dynamic_addr(builder,id(pytypes.FunctionType),info='exact Python function type')
        method_type=context.add_dynamic_addr(builder,id(pytypes.MethodType),info='exact Python method type')
        result=cgutils.alloca_once_value(builder,ir.Constant(ir.IntType(1),0))
        with builder.if_else(args[4]) as (method,plain):
            with method:
                with builder.if_then(builder.icmp_unsigned('==',cls,method_type)):
                    found=capi(builder,'PyMethod_Function',py.pyobj,[actual])
                    this=capi(builder,'PyMethod_Self',py.pyobj,[actual])
                    matches=builder.and_(builder.icmp_unsigned('==',found,expected),builder.icmp_unsigned('==',this,receiver))
                    with builder.if_then(matches):
                        current=capi(builder,'PyFunction_GetCode',py.pyobj,[found])
                        builder.store(builder.icmp_unsigned('==',current,saved),result)
            with plain:
                matches=builder.and_(builder.icmp_unsigned('==',cls,fn_type),builder.icmp_unsigned('==',actual,expected))
                with builder.if_then(matches):
                    current=capi(builder,'PyFunction_GetCode',py.pyobj,[actual])
                    builder.store(builder.icmp_unsigned('==',current,saved),result)
        py.decref(cls)
        return builder.load(result)
    return types.boolean(callee,function,code,owner,bound),codegen

@intrinsic
def context_matches(tc,callee,special):
    if callee!=refs.managed or special!=refs.managed:return
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder);actual,seq=[refs.borrowed_object(context,builder,a) for a in args]
        found=ir.Constant(ir.IntType(1),0)
        for index in range(6):
            item=py.tuple_getitem(seq,index)
            found=builder.or_(found,builder.icmp_unsigned('==',actual,item))
        return found
    return types.boolean(callee,special),codegen

@intrinsic
def set_attribute(tc,owner,name,value):
    if any(t!=refs.managed for t in (owner,name,value)):return
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder);values=[refs.borrowed_object(context,builder,a) for a in args]
        status=capi(builder,'PyObject_SetAttr',ir.IntType(32),values)
        return builder.icmp_signed('>=',status,ir.Constant(status.type,0))
    return types.boolean(owner,name,value),codegen

@intrinsic
def set_item(tc,owner,name,value):
    if any(t!=refs.managed for t in (owner,name,value)):return
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder);values=[refs.borrowed_object(context,builder,a) for a in args]
        status=capi(builder,'PyObject_SetItem',ir.IntType(32),values)
        return builder.icmp_signed('>=',status,ir.Constant(status.type,0))
    return types.boolean(owner,name,value),codegen

@intrinsic
def keep_alive(tc,values):
    if not isinstance(values,types.BaseTuple) or any(v!=refs.managed for v in values):return
    def codegen(context,builder,sig,args):
        # The IR use keeps source slots live through this point; NRT still
        # owns and releases each value using its canonical model.
        return context.get_dummy_value()
    return types.void(values),codegen

@intrinsic
def cached_load(tc,owner,name,address):
    if owner!=refs.managed or name!=refs.managed or not isinstance(address,types.Integer):return
    signature=types.Tuple((refs.managed,types.boolean))(owner,name,address)
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        values=[refs.borrowed_object(context,builder,a) for a in args[:2]]
        values.append(builder.inttoptr(args[2],py.pyobj))
        result=capi(builder,'rc_structure_load_attr',py.pyobj,values)
        return refs.adopt_owned(context,builder,py,result)
    return signature,codegen

@intrinsic
def cached_store(tc,owner,name,value,address):
    if any(t!=refs.managed for t in (owner,name,value)) or not isinstance(address,types.Integer):return
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        values=[refs.borrowed_object(context,builder,a) for a in args[:3]]
        values.append(builder.inttoptr(args[3],py.pyobj))
        result=capi(builder,'rc_structure_store_attr',ir.IntType(32),values)
        return builder.icmp_signed('>=',result,ir.Constant(result.type,0))
    return types.boolean(owner,name,value,address),codegen

@intrinsic
def fast_getitem(tc,owner,key):
    if owner!=refs.managed or key!=refs.managed:return
    signature=types.Tuple((refs.managed,types.boolean))(owner,key)
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        result=capi(builder,'rc_structure_getitem',py.pyobj,[refs.borrowed_object(context,builder,a) for a in args])
        return refs.adopt_owned(context,builder,py,result)
    return signature,codegen

@intrinsic
def fast_setitem(tc,owner,key,value):
    if any(t!=refs.managed for t in (owner,key,value)):return
    def codegen(context,builder,sig,args):
        status=capi(builder,'rc_structure_setitem',ir.IntType(32),[refs.borrowed_object(context,builder,a) for a in args])
        return builder.icmp_signed('>=',status,ir.Constant(status.type,0))
    return types.boolean(owner,key,value),codegen

@intrinsic
def contains_value(tc,owner,key,negate):
    if owner!=refs.managed or key!=refs.managed or negate!=types.boolean:return
    signature=types.Tuple((refs.managed,types.boolean))(owner,key,negate)
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        status=capi(builder,'rc_structure_contains',ir.IntType(32),[refs.borrowed_object(context,builder,a) for a in args[:2]])
        result=cgutils.alloca_once_value(builder,ir.Constant(py.pyobj,None))
        with builder.if_then(builder.icmp_signed('>=',status,ir.Constant(status.type,0))):
            bit=builder.icmp_signed('!=',status,ir.Constant(status.type,0))
            builder.store(py.bool_from_bool(builder.xor(bit,args[2])),result)
        return refs.adopt_owned(context,builder,py,builder.load(result))
    return signature,codegen

@intrinsic
def compare_value(tc,left,right,op):
    if left!=refs.managed or right!=refs.managed or not isinstance(op,types.Integer):return
    signature=types.Tuple((refs.managed,types.boolean))(left,right,op)
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        values=[refs.borrowed_object(context,builder,a) for a in args[:2]]
        values.append(context.cast(builder,args[2],sig.args[2],types.int32))
        value=capi(builder,'PyObject_RichCompare',py.pyobj,values)
        return refs.adopt_owned(context,builder,py,value)
    return signature,codegen

@intrinsic
def isinstance_builtin(tc,callee):
    if callee!=refs.managed:return
    def codegen(context,builder,sig,args):
        selected=capi(builder,'rc_structure_isinstance_builtin',ir.IntType(32),
                      [refs.borrowed_object(context,builder,args[0])])
        return builder.icmp_signed('!=',selected,ir.Constant(selected.type,0))
    return types.boolean(callee),codegen

@intrinsic
def isinstance_value(tc,value,classes,true_owner,false_owner):
    if any(t!=refs.managed for t in (value,classes,true_owner,false_owner)):return
    signature=types.Tuple((refs.managed,types.boolean))(value,classes,true_owner,false_owner)
    def codegen(context,builder,sig,args):
        # CPython3.14.4 abstract.c performs the exact-type test, physical MRO
        # check and the required __class__/metaclass/tuple/union fallbacks.
        # Call that C operation directly: no Python dispatcher or arg containers.
        status=capi(builder,'PyObject_IsInstance',ir.IntType(32),
                    [refs.borrowed_object(context,builder,a) for a in args[:2]])
        slot=cgutils.alloca_once_value(builder,args[3])
        with builder.if_then(builder.icmp_signed('>',status,ir.Constant(status.type,0))):
            builder.store(args[2],slot)
        result=builder.load(slot);context.nrt.incref(builder,refs.managed,result)
        ok=builder.icmp_signed('>=',status,ir.Constant(status.type,0))
        return context.make_tuple(builder,sig.return_type,[result,ok])
    return signature,codegen


@intrinsic
def method_kind(tc,callee):
    if callee!=refs.managed:return
    def codegen(context,builder,sig,args):
        return capi(builder,'rc_structure_method_kind',ir.IntType(32),[refs.borrowed_object(context,builder,args[0])])
    return types.int32(callee),codegen

@intrinsic
def method_value(tc,callee,first,second,kind):
    if any(t!=refs.managed for t in (callee,first,second)) or not isinstance(kind,types.Integer):return
    signature=types.Tuple((refs.managed,types.boolean))(callee,first,second,kind)
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        values=[refs.borrowed_object(context,builder,a) for a in args[:3]]
        values.append(context.cast(builder,args[3],sig.args[3],types.int32))
        result=capi(builder,'rc_structure_method_value',py.pyobj,values)
        return refs.adopt_owned(context,builder,py,result)
    return signature,codegen

@intrinsic
def sequence_matches(tc,value,count):
    if value!=refs.managed or not isinstance(count,types.Integer):return
    def codegen(context,builder,sig,args):
        count=context.cast(builder,args[1],sig.args[1],types.intp)
        result=capi(builder,'rc_structure_sequence_matches',ir.IntType(32),[refs.borrowed_object(context,builder,args[0]),count])
        return builder.icmp_signed('!=',result,ir.Constant(result.type,0))
    return types.boolean(value,count),codegen

@intrinsic
def unpack_sequence(tc,value):
    if value!=refs.managed:return
    signature=types.Tuple((refs.managed,types.boolean))(value)
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        result=capi(builder,'rc_structure_unpack',py.pyobj,[refs.borrowed_object(context,builder,args[0])])
        return refs.adopt_owned(context,builder,py,result)
    return signature,codegen
