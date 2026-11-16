from pathlib import Path
import sys
ARTIFACT=Path(sys.argv[1]).resolve()
R=ARTIFACT.parents[2]
sys.path[:0]=[str(R/'matrix/extension'),str(ARTIFACT)]
from llvmlite import ir
from numba import njit,types
from numba.core import cgutils
from numba.extending import intrinsic
from managed import managed,opaque,propagate_active
import wave17_charloop as ext

def make_bridge(name,arity,target=None):
    if target is None:target=getattr(ext,name)
    def define_intrinsic(typing_context,*argtypes):
        if any(t!=managed for t in argtypes):return
        result_type=types.Tuple((managed,types.boolean));sig=result_type(*argtypes)
        def codegen(context,builder,signature,args):
            py=context.get_python_api(builder);null=ir.Constant(py.pyobj,None)
            slots=[cgutils.alloca_once_value(builder,null) for _ in range(3)]
            out=cgutils.create_struct_proxy(managed)(context,builder);out.meminfo=ir.Constant(context.get_value_type(types.MemInfoPointer(opaque)),None)
            output=cgutils.alloca_once_value(builder,out._getvalue());ok=cgutils.alloca_once_value(builder,ir.Constant(ir.IntType(1),0));cleanup=builder.append_basic_block('bridge.cleanup')
            def checked(obj,slot):
                builder.store(obj,slot)
                with builder.if_then(cgutils.is_null(builder,obj),likely=False):builder.branch(cleanup)
                return obj
            environment=context.get_env_manager(builder)
            retained=environment.read_const(environment.add_const(target))
            py.incref(retained)
            fn=checked(retained,slots[0])
            objects=[context.nrt.meminfo_data(builder,cgutils.create_struct_proxy(managed)(context,builder,value=value).meminfo) for value in args]
            packed=checked(py.tuple_pack(objects),slots[1])
            result=checked(py.call(fn,packed,null),slots[2])
            owner=py.nrt_meminfo_new_from_pyobject(result,result)
            with builder.if_else(cgutils.is_null(builder,owner),likely=False) as (bad,good):
                with bad:py.decref(result);py.err_set_string('PyExc_MemoryError','managed bridge allocation failed')
                with good:out.meminfo=owner;builder.store(out._getvalue(),output);builder.store(ir.Constant(ir.IntType(1),1),ok)
            builder.branch(cleanup);builder.position_at_end(cleanup)
            for slot in reversed(slots):py.decref(builder.load(slot))
            return context.make_tuple(builder,result_type,[builder.load(output),builder.load(ok)])
        return sig,codegen
    params=','.join('a'+str(i) for i in range(arity))
    intrinsic_namespace={'_define':define_intrinsic}
    exec('def invoke(typing_context,'+params+'):\n    return _define(typing_context,'+params+')\n',intrinsic_namespace)
    invoke=intrinsic(intrinsic_namespace['invoke'])
    namespace={'__name__':__name__,'__file__':__file__,'_invoke':invoke,'_propagate':propagate_active}
    exec('def '+name+'('+params+'):\n    result,ok=_invoke('+params+')\n    if ok:return result\n    _propagate()\n    return result\n',namespace)
    return namespace[name],managed(*([managed]*arity))

SPECS=[('boxed',1),('borrowed',1)]
def compile_bridges(folder):
    from recompyler._pycc import CC
    cc=CC('wave17_character_bridge');cc.output_dir=str(folder);entries={};dispatchers={}
    for name,arity in SPECS:
        fn,sig=make_bridge(name,arity);dispatcher=njit(sig)(fn)
        dispatchers[name]=dispatcher;entries[name]=next(iter(dispatcher.overloads.values())).entry_point
        (folder/(name+'.ll')).write_text(dispatcher.inspect_llvm(sig.args))
        cc.export(name,sig)(fn)
    cc.compile();sys.path.insert(0,str(folder));import wave17_character_bridge as aot
    return entries,dispatchers,aot
