"""Direct LLVM CPython exports resolve for native calls and AOT relocation."""
import ctypes
from pathlib import Path
import pytest
from llvmlite import ir,binding


def test_resolved_python_export_executes_from_direct_llvm():
    from recompyler.ir.symbols import CPythonSymbols
    symbols=CPythonSymbols()
    module=ir.Module(name='test_capi_length')
    pointer=ir.IntType(8).as_pointer()
    integer=ir.IntType(ctypes.sizeof(ctypes.c_void_p)*8)
    length=symbols.declare(module,'PyObject_Length',integer,[pointer])
    function=ir.Function(module,ir.FunctionType(integer,[pointer]),'compiled_length')
    block=function.append_basic_block('entry');builder=ir.IRBuilder(block)
    builder.ret(builder.call(length,list(function.args)))
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    target=binding.Target.from_default_triple().create_target_machine()
    parsed=binding.parse_assembly(str(module));parsed.verify()
    engine=binding.create_mcjit_compiler(parsed,target);engine.finalize_object()
    call=ctypes.PYFUNCTYPE(ctypes.c_ssize_t,ctypes.py_object)(engine.get_function_address('compiled_length'))
    assert call([object(),object(),object()])==3
    obj=target.emit_object(parsed)
    assert len(obj)>100 and b'PyObject_Length' in obj
    linkage=symbols.aot_linkage()
    assert Path(linkage.library_dir,linkage.library_name).is_file()
    assert Path(linkage.include_dir,'Python.h').is_file()


def test_unresolved_symbol_and_conflicting_prototype_fail_before_native_call():
    from recompyler.ir.symbols import CPythonSymbols
    symbols=CPythonSymbols()
    with pytest.raises(LookupError,match='not exported'):
        symbols.resolve('PyThisSymbolDoesNotExist_71818')
    with pytest.raises(ValueError,match='symbol name'):
        symbols.resolve('PyObject_Length;bad')
    module=ir.Module()
    symbols.declare(module,'PyObject_Length',ir.IntType(64),[ir.IntType(8).as_pointer()])
    with pytest.raises(TypeError,match='prototype'):
        symbols.declare(module,'PyObject_Length',ir.IntType(32),[])


def test_runtime_guard_rejects_another_patch_before_export_registration(monkeypatch):
    from recompyler.ir import symbols
    monkeypatch.setattr(symbols.sys,'version_info',(3,14,5,'final',0))
    with pytest.raises(RuntimeError,match='3.14.4'):
        symbols.CPythonSymbols()

def test_external_native_helper_uses_shared_declaration_and_retains_library():
    import gc,weakref
    from recompyler.ir.symbols import CPythonSymbols
    class Library:pass
    library=Library();ref=weakref.ref(library)
    symbols=CPythonSymbols()
    address=symbols.resolve('PyObject_Length')
    symbols.register_external('RP_TestLength71818',address,library)
    del library;gc.collect();assert ref() is not None
    module=ir.Module()
    value=symbols.declare(module,'RP_TestLength71818',ir.IntType(64),[ir.IntType(8).as_pointer()])
    assert value.name=='RP_TestLength71818'
    assert symbols.resolve(value.name)==address
    with pytest.raises(RuntimeError,match='AOT linkage'):
        symbols.aot_libraries([value.name])
    with pytest.raises(ValueError,match='different address'):
        symbols.register_external(value.name,address+1,ref())


def test_aot_object_links_to_python_import_library_and_executes(tmp_path):
    from recompyler.ir.symbols import CPythonSymbols
    import setuptools
    new_compiler=setuptools.distutils.ccompiler.new_compiler
    symbols=CPythonSymbols();linkage=symbols.aot_linkage()
    module=ir.Module(name='aot_capi_fixture');pointer=ir.IntType(8).as_pointer();integer=ir.IntType(64)
    callee=symbols.declare(module,'PyObject_Length',integer,[pointer])
    exception=symbols.declare_global(module,'PyExc_ValueError',pointer)
    error_type=ir.Function(module,ir.FunctionType(pointer,[]),'RP_AOT_ErrorType')
    eb=ir.IRBuilder(error_type.append_basic_block('entry'));value=eb.load(exception)
    inc=symbols.declare(module,'Py_IncRef',ir.VoidType(),[pointer]);eb.call(inc,[value]);eb.ret(value)
    function=ir.Function(module,ir.FunctionType(integer,[pointer]),'RP_AOT_Length')
    builder=ir.IRBuilder(function.append_basic_block('entry'));builder.ret(builder.call(callee,list(function.args)))
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    target=binding.Target.from_default_triple().create_target_machine()
    native=binding.parse_assembly(str(module));native.verify()
    objectfile=tmp_path/'length.obj';objectfile.write_bytes(symbols.emit_object(module))
    output=tmp_path/'length.dll'
    compiler=new_compiler(compiler='msvc')
    compiler.link_shared_object([str(objectfile)],str(output),libraries=[Path(linkage.library_name).stem],library_dirs=[linkage.library_dir],export_symbols=['RP_AOT_Length','RP_AOT_ErrorType'],extra_postargs=['/NOENTRY'])
    library=ctypes.PyDLL(str(output));call=library.RP_AOT_Length
    call.restype=ctypes.c_ssize_t;call.argtypes=[ctypes.py_object]
    assert call([object(),object()])==2
    error_type=library.RP_AOT_ErrorType;error_type.restype=ctypes.py_object;error_type.argtypes=[]
    assert error_type() is ValueError
