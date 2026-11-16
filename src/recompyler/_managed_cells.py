"""Shared direct CPython cell operations; no converted closure environment."""
from llvmlite import ir
from numba.core import cgutils,types
from numba.extending import intrinsic
from ._managed_native import managed,borrowed_object,adopt_owned
from ._call_bridge import _NAME_ERROR,_UNBOUND_ERROR


def empty_cell_error(name,free):
    if free:return _NAME_ERROR(f"cannot access free variable '{name}' where it is not associated with a value in enclosing scope",name=name)
    return _UNBOUND_ERROR(f"cannot access local variable '{name}' where it is not associated with a value")


def raise_unbound_local(name):raise empty_cell_error(name,False)


@intrinsic
def cell_get(typing_context,cell,name,free,error_factory):
    if cell!=managed or name!=managed or free!=types.boolean or error_factory!=managed:return
    signature=types.Tuple((managed,types.boolean))(cell,name,free,error_factory)
    def codegen(context,builder,signature,args):
        py=context.get_python_api(builder)
        get=cgutils.get_or_insert_function(builder.module,ir.FunctionType(py.pyobj,[py.pyobj]),'PyCell_Get')
        value=builder.call(get,[borrowed_object(context,builder,args[0])])
        with builder.if_then(cgutils.is_null(builder,value)):
            flag=py.bool_from_bool(args[2])
            error=py.call_function_objargs(borrowed_object(context,builder,args[3]),[borrowed_object(context,builder,args[1]),flag])
            py.decref(flag)
            with builder.if_then(cgutils.is_not_null(builder,error)):
                set_error=cgutils.get_or_insert_function(builder.module,ir.FunctionType(ir.VoidType(),[py.pyobj]),'PyErr_SetRaisedException')
                builder.call(set_error,[error])
        return adopt_owned(context,builder,py,value)
    return signature,codegen


@intrinsic
def cell_set(typing_context,cell,value):
    if cell!=managed or value!=managed:return
    def codegen(context,builder,signature,args):
        py=context.get_python_api(builder)
        fn=cgutils.get_or_insert_function(builder.module,ir.FunctionType(ir.IntType(32),[py.pyobj]*2),'PyCell_Set')
        status=builder.call(fn,[borrowed_object(context,builder,value) for value in args])
        return builder.icmp_signed('==',status,ir.Constant(status.type,0))
    return types.boolean(cell,value),codegen


class CellAccess:
    def configure_cells(self,names,free_names=()):
        self.cell_names=tuple(names)
        self.cell_slots={name:'_native_cell'+str(index) for index,name in enumerate(self.cell_names)}
        self.cell_free=set(free_names)
        self.intrinsics.update(_cell_get=cell_get,_cell_set=cell_set)

    def cell_prefix(self,lines,frame='_frame'):
        saved=self.lines,self.indent
        self.lines=[];self.indent=1
        try:
            if self.cell_names:
                cells=self.operation('_getattr_object',frame,self.pooled('cells'))
                for name in self.cell_names:
                    value=self.operation('_getitem_object',cells,self.pooled(name))
                    self.line(self.cell_slots[name]+' = '+value)
            return self.lines+lines
        finally:self.lines,self.indent=saved

    def read_cell(self,name):
        return self.operation('_cell_get',self.cell_slots[name],self.pooled(name),str(name in self.cell_free),self.pooled(empty_cell_error))

    def write_cell(self,name,value):
        self.line('_ok = _cell_set('+self.cell_slots[name]+','+value+')')
        self.line('if not _ok:')
        self.indent+=1
        self.line('_capture_error(_errors)');self.line('return _errors,False')
        self.indent-=1
