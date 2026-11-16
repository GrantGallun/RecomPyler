"""LLVM facts remove work while preserving Python mutation boundaries."""
import ctypes
from llvmlite import binding, ir


def test_full_o3_promotes_stack_and_eliminates_redundant_field_load():
    from recompyler.ir.llvm_semantics import annotate_access, optimize_module
    p=ir.IntType(64).as_pointer();module=ir.Module()
    fn=ir.Function(module,ir.FunctionType(ir.IntType(64),[p,p]),'facts')
    b=ir.IRBuilder(fn.append_basic_block('entry'))
    slot=b.alloca(ir.IntType(64));b.store(ir.Constant(ir.IntType(64),7),slot)
    first=annotate_access(b.load(fn.args[0]),'object.type')
    annotate_access(b.store(b.load(slot),fn.args[1]),'object.refcount')
    second=annotate_access(b.load(fn.args[0]),'object.type')
    b.ret(b.sub(second,first))
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    target=binding.Target.from_default_triple().create_target_machine(opt=3)
    native=binding.parse_assembly(str(module));optimize_module(native,target)
    assert 'alloca' not in str(native) and 'ret i64 0' in str(native)
    engine=binding.create_mcjit_compiler(native,target);engine.finalize_object()
    run=ctypes.CFUNCTYPE(ctypes.c_uint64,ctypes.POINTER(ctypes.c_uint64),ctypes.POINTER(ctypes.c_uint64))(engine.get_function_address('facts'))
    kind=ctypes.c_uint64(123);count=ctypes.c_uint64(2)
    assert run(ctypes.byref(kind),ctypes.byref(count))==0 and count.value==7


def test_api_effects_are_whitelisted_and_refcount_writes_remain_effectful():
    from recompyler.ir.symbols import CPythonSymbols
    symbols=CPythonSymbols();module=ir.Module();p=ir.IntType(8).as_pointer()
    subtype=symbols.declare(module,'PyType_IsSubtype',ir.IntType(32),[p,p])
    assert {'readonly','nounwind'} <= set(subtype.attributes)
    assert 'argmemonly' not in subtype.attributes
    newref=symbols.declare(module,'Py_NewRef',p,[p])
    assert 'readonly' not in newref.attributes and 'readnone' not in newref.attributes
    for name,result in [('Py_DecRef',ir.VoidType()),('PyObject_Length',ir.IntType(64))]:
        function=symbols.declare(module,name,result,[p])
        assert not {'readonly','readnone','argmemonly','willreturn'} & set(function.attributes)
    binding.parse_assembly(str(module)).verify()


def test_facts_describe_proven_values_and_validate_as_llvm():
    from recompyler.ir.llvm_semantics import annotate_access, assume
    module=ir.Module();p=ir.IntType(8).as_pointer();word=ir.IntType(64)
    fn=ir.Function(module,ir.FunctionType(ir.VoidType(),[p.as_pointer(),word.as_pointer()]),'facts')
    b=ir.IRBuilder(fn.append_basic_block('entry'))
    annotate_access(b.load(fn.args[0]),'object.type',nonnull=True)
    annotate_access(b.load(fn.args[1]),'type.basicsize',immutable=True,value_range=(0,2**63))
    assume(b,b.icmp_unsigned('!=',fn.args[0],ir.Constant(p.as_pointer(),None)))
    b.ret_void();text=str(module)
    assert all('!'+name in text for name in ('tbaa','nonnull','range','invariant.load'))
    assert 'llvm.assume' in text
    binding.parse_assembly(text).verify()


def test_mutable_version_guard_never_gets_permanent_invariance():
    from recompyler.ir.structure_lowerings import StructureCalls
    from recompyler.ir.symbols import CPythonSymbols
    from recompyler import _structure_ops_native as provider
    calls=StructureCalls(CPythonSymbols(),provider);module=ir.Module();p=ir.IntType(8).as_pointer()
    fn=ir.Function(module,ir.FunctionType(ir.IntType(32),[p]),'version')
    b=ir.IRBuilder(fn.append_basic_block('entry'))
    value=calls.field(b,fn.args[0],calls.layout['type_version'],ir.IntType(32),semantic='type.version')
    assert 'invariant.load' not in value.metadata
    b.ret(value);binding.parse_assembly(str(module)).verify()


def test_common_lowerer_runs_o3_without_fast_math():
    from recompyler.ir import build
    from recompyler.ir.lower_llvm import lower
    def identity(value):return value
    body=lower(build(identity));text=str(body.native_module)
    assert body.optimization_level==3
    assert 'alloca' not in text and ' fast ' not in text


def test_subtype_reads_indirect_base_chain_after_an_unrelated_global_store():
    # The C API explicitly accepts not-yet-ready types (tp_mro == NULL).
    # Private, borrowed-field copies avoid mutating any live Python type.
    from recompyler.ir.symbols import CPythonSymbols
    from recompyler.ir.llvm_semantics import optimize_module
    prototype=type('SubtypePrototype',(int,),{})
    size=type.__basicsize__;data=ctypes.string_at(id(prototype),size)
    def offset(value):
        hits=[i for i in range(0,size-7,8) if int.from_bytes(data[i:i+8],'little')==id(value)]
        assert len(hits)==1
        return hits[0]
    base=offset(int);mro=offset(prototype.__mro__)
    left=ctypes.create_string_buffer(data,size);middle=ctypes.create_string_buffer(data,size)
    def put(buffer,where,value):
        ctypes.c_void_p.from_address(ctypes.addressof(buffer)+where).value=value
    put(left,mro,None);put(middle,mro,None)
    put(left,base,ctypes.addressof(middle));put(middle,base,id(int))
    subtype=ctypes.pythonapi.PyType_IsSubtype
    subtype.argtypes=[ctypes.c_void_p,ctypes.c_void_p];subtype.restype=ctypes.c_int
    assert subtype(ctypes.addressof(left),id(int))==1
    put(middle,base,id(str));assert subtype(ctypes.addressof(left),id(int))==0
    put(middle,base,id(int))
    symbols=CPythonSymbols();module=ir.Module();p=ir.IntType(8).as_pointer();i32=ir.IntType(32)
    a=ir.GlobalVariable(module,ir.ArrayType(ir.IntType(8),size),'SubtypeProbeA')
    b=ir.GlobalVariable(module,ir.ArrayType(ir.IntType(8),size),'SubtypeProbeB')
    target=symbols.declare_global(module,'PyLong_Type',ir.IntType(8))
    other=symbols.declare_global(module,'PyUnicode_Type',ir.IntType(8))
    callee=symbols.declare(module,'PyType_IsSubtype',i32,[p,p])
    fn=ir.Function(module,ir.FunctionType(i32,[]),'subtype_probe')
    builder=ir.IRBuilder(fn.append_basic_block('entry'))
    arguments=[builder.bitcast(a,p),target];before=builder.call(callee,arguments)
    at=builder.gep(builder.bitcast(b,p),[ir.Constant(ir.IntType(64),base)])
    builder.store(other,builder.bitcast(at,p.as_pointer()))
    after=builder.call(callee,arguments);builder.ret(builder.sub(after,before))
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    machine=binding.Target.from_default_triple().create_target_machine(opt=3)
    native=binding.parse_assembly(str(module));optimize_module(native,machine)
    engine=binding.create_mcjit_compiler(binding.parse_assembly(''),machine);engine.add_module(native)
    live={v.name:v for v in native.global_variables}
    for name,buffer in [('SubtypeProbeA',left),('SubtypeProbeB',middle)]:
        if name in live:engine.add_global_mapping(live[name],ctypes.addressof(buffer))
    engine.finalize_object()
    run=ctypes.PYFUNCTYPE(ctypes.c_int)(engine.get_function_address('subtype_probe'))
    assert run()==-1
