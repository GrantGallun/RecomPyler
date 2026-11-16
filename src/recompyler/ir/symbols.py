"""CPython 3.14.4 export addresses and native linker inputs for the IR backend.

Addresses name exported code OR exported storage. For example PyExc_TypeError
is a global PyObject* slot, so LLVM must load it rather than call it. Prototypes
are the lowerer's responsibility; inconsistent declarations are rejected.
"""
import ctypes
from dataclasses import dataclass
from pathlib import Path
import re
import sys
import sysconfig
from llvmlite import binding,ir

_external_symbols={}


def require_runtime():
    if (sys.implementation.name!='cpython' or tuple(sys.version_info[:3])!=(3,14,4)
            or ctypes.sizeof(ctypes.c_void_p)!=8 or sysconfig.get_config_var('Py_GIL_DISABLED')
            or hasattr(sys,'_is_gil_enabled') and not sys._is_gil_enabled()):
        raise RuntimeError('IR native ABI requires GIL-enabled 64-bit CPython 3.14.4')


@dataclass(frozen=True)
class AOTLinkage:
    include_dir: str
    library_dir: str
    library_name: str


class CPythonSymbols:
    def __init__(self):
        require_runtime()
        self.library=ctypes.pythonapi
        self.addresses={}
        self.global_exports=set()

    def register_external(self,name,address,keepalive,*,aot_library=None):
        if not isinstance(name,str) or re.fullmatch(r'[A-Za-z_][A-Za-z_0-9]*',name) is None:
            raise ValueError('invalid C symbol name')
        if type(address) is not int or address<=0:
            raise ValueError('nonzero external symbol address required')
        old=_external_symbols.get(name)
        if old is not None and old[0]!=address:
            raise ValueError('symbol already registered at a different address: '+name)
        _external_symbols[name]=(address,keepalive,aot_library)
        binding.add_symbol(name,address)

    def aot_libraries(self,names):
        libraries=[]
        for name in names:
            if name in _external_symbols:
                library=_external_symbols[name][2]
                if library is None:
                    raise RuntimeError('external helper has no AOT linkage: '+name)
                if library not in libraries:
                    libraries.append(library)
        return tuple(libraries)

    def emit_object(self,module):
        binding.initialize_native_target();binding.initialize_native_asmprinter()
        triple=binding.get_default_triple()
        if module.triple not in ('', 'unknown-unknown-unknown', triple):
            raise ValueError('AOT module target differs from this CPython process')
        # llvmlite's jitdefault intentionally emits ELF on Windows for MCJIT.
        # AOT must select the ordinary code model to produce linkable COFF.
        target=binding.Target.from_triple(triple).create_target_machine(codemodel='default',opt=3)
        module.triple=triple
        module.data_layout=str(target.target_data)
        native=binding.parse_assembly(str(module))
        if sys.platform=='win32':
            for name in self.global_exports.intersection(module.globals):
                native.get_global_variable(name).storage_class='dllimport'
        from .llvm_semantics import optimize_module
        optimize_module(native,target)
        return target.emit_object(native)

    def resolve(self,name):
        if not isinstance(name,str) or re.fullmatch(r'[A-Za-z_][A-Za-z_0-9]*',name) is None:
            raise ValueError('invalid C symbol name')
        if name in _external_symbols:
            return _external_symbols[name][0]
        if name not in self.addresses:
            try:
                symbol=getattr(self.library,name)
            except AttributeError as error:
                raise LookupError('CPython symbol not exported: '+name) from error
            self.addresses[name]=ctypes.cast(symbol,ctypes.c_void_p).value
        return self.addresses[name]

    def install(self,names):
        # Resolve the whole group before publishing any of it to LLVM.
        addresses={name:self.resolve(name) for name in names}
        for name,address in addresses.items():
            binding.add_symbol(name,address)
        return addresses

    def declare_global(self,module,name,value_type):
        if name in module.globals:
            value=module.globals[name]
            if not isinstance(value,ir.GlobalVariable) or value.value_type!=value_type or value.initializer is not None:
                raise TypeError('conflicting C-API global prototype: '+name)
        else:
            self.install([name])
            value=ir.GlobalVariable(module,value_type,name=name)
        self.global_exports.add(name)
        return value

    def declare(self,module,name,result,arguments):
        signature=ir.FunctionType(result,arguments)
        if name in module.globals:
            value=module.globals[name]
            if not isinstance(value,ir.Function) or value.function_type!=signature:
                raise TypeError('conflicting C-API prototype: '+name)
            return value
        self.install([name])
        from .llvm_semantics import annotate_api
        return annotate_api(ir.Function(module,signature,name=name))

    def aot_linkage(self):
        if sys.platform!='win32':
            raise RuntimeError('IR AOT linker scaffolding currently supports Windows')
        include=Path(sysconfig.get_path('include'))
        directory=Path(sys.base_prefix)/'libs'
        library='python314_d.lib' if sysconfig.get_config_var('Py_DEBUG') else 'python314.lib'
        if not (include/'Python.h').is_file() or not (directory/library).is_file():
            raise RuntimeError('CPython development headers/import library unavailable')
        return AOTLinkage(str(include),str(directory),library)
