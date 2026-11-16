"""CPython MAKE_FUNCTION/real-cell primitives over canonical managed operands."""
from llvmlite import ir, binding
from numba.core import types, cgutils
from numba.extending import intrinsic
from . import _managed_native as refs
try:
    from . import _closure_ops_native as native
except ImportError:
    native = None
if native is not None:
    for name,address in native.addresses().items():
        binding.add_symbol('rc_closure_'+name,address)

def available():
    return native is not None

def _call(builder,name,result,values):
    callee=cgutils.get_or_insert_function(builder.module,
        ir.FunctionType(result,[v.type for v in values]),'rc_closure_'+name)
    return builder.call(callee,values)

@intrinsic
def function_from_cells(tc,code,namespace,cells,defaults,keyword_defaults):
    if not available() or any(t!=refs.managed for t in (code,namespace,defaults,keyword_defaults)):
        return
    if not isinstance(cells,types.BaseTuple) or any(t!=refs.managed for t in cells):
        return
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        values=[refs.borrowed_object(context,builder,args[i]) for i in (0,1,3,4)]
        contents=[refs.borrowed_object(context,builder,v)
            for v in cgutils.unpack_tuple(builder,args[2],len(sig.args[2]))]
        closure=py.tuple_pack(contents) if contents else py.borrow_none()
        result=cgutils.alloca_once_value(builder,py.get_null_object())
        with builder.if_then(cgutils.is_not_null(builder,closure)):
            value=_call(builder,'make_function',py.pyobj,[values[0],values[1],closure,values[2],values[3]])
            builder.store(value,result)
            if contents:py.decref(closure)
        return refs.adopt_owned(context,builder,py,builder.load(result))
    return types.Tuple((refs.managed,types.boolean))(code,namespace,cells,defaults,keyword_defaults),codegen


@intrinsic
def bind_function_from_cells(tc,owner,name,code,namespace,cells,defaults,keyword_defaults):
    if not available() or any(t!=refs.managed for t in (owner,name,code,namespace,defaults,keyword_defaults)):
        return
    if not isinstance(cells,types.BaseTuple) or any(t!=refs.managed for t in cells):
        return
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        values=[refs.borrowed_object(context,builder,args[i]) for i in (0,1,2,3,5,6)]
        contents=[refs.borrowed_object(context,builder,v)
            for v in cgutils.unpack_tuple(builder,args[4],len(sig.args[4]))]
        closure=py.tuple_pack(contents) if contents else py.borrow_none()
        result=cgutils.alloca_once_value(builder,ir.Constant(ir.IntType(1),0))
        with builder.if_then(cgutils.is_not_null(builder,closure)):
            status=_call(builder,'bind_function',ir.IntType(32),values[:4]+[closure]+values[4:])
            builder.store(builder.icmp_signed('==',status,ir.Constant(status.type,0)),result)
            if contents:py.decref(closure)
        return builder.load(result)
    return types.boolean(owner,name,code,namespace,cells,defaults,keyword_defaults),codegen

# Internal opcode path: original CodeType/inert globals and defaults are proved
# by binding; cells are constructed by CPython. Callers must not substitute
# arbitrary managed operands. No alternate application representation exists.
@intrinsic
def bind_proved_function_from_cells(tc,owner,name,code,namespace,cells,defaults,keyword_defaults):
    if not available() or any(t!=refs.managed for t in (owner,name,code,namespace,defaults,keyword_defaults)):
        return
    if not isinstance(cells,types.BaseTuple) or any(t!=refs.managed for t in cells):
        return
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        values=[refs.borrowed_object(context,builder,args[i]) for i in (0,1,2,3,5,6)]
        contents=[refs.borrowed_object(context,builder,v)
            for v in cgutils.unpack_tuple(builder,args[4],len(sig.args[4]))]
        closure=py.tuple_pack(contents) if contents else py.borrow_none()
        result=cgutils.alloca_once_value(builder,ir.Constant(ir.IntType(1),0))
        with builder.if_then(cgutils.is_not_null(builder,closure)):
            status=_call(builder,'bind_function_known',ir.IntType(32),values[:4]+[closure]+values[4:])
            builder.store(builder.icmp_signed('==',status,ir.Constant(status.type,0)),result)
            if contents:py.decref(closure)
        return builder.load(result)
    return types.boolean(owner,name,code,namespace,cells,defaults,keyword_defaults),codegen

@intrinsic
def new_cell(tc,value):
    if value!=refs.managed:return
    def codegen(context,builder,sig,args):
        py=context.get_python_api(builder)
        callee=cgutils.get_or_insert_function(builder.module,ir.FunctionType(py.pyobj,[py.pyobj]),'PyCell_New')
        result=builder.call(callee,[refs.borrowed_object(context,builder,args[0])])
        return refs.adopt_owned(context,builder,py,result)
    return types.Tuple((refs.managed,types.boolean))(value),codegen
