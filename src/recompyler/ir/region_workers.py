"""Transient T2 object emission: workers never execute parent object pointers."""
from dataclasses import dataclass
import hashlib
import os


@dataclass(frozen=True)
class ObjectRequest:
    text: str
    digest: str
    triple: str


@dataclass(frozen=True)
class NativeObject:
    data: bytes
    digest: str
    triple: str
    pid: int
    optimization_level: int = 3


def request(module):
    text=str(module)
    return ObjectRequest(text,hashlib.sha256(text.encode()).hexdigest(),module.triple)


def _priority():
    if os.name=='nt':
        import ctypes
        kernel=ctypes.WinDLL('kernel32',use_last_error=True)
        kernel.GetCurrentProcess.restype=ctypes.c_void_p
        kernel.SetPriorityClass.argtypes=(ctypes.c_void_p,ctypes.c_uint32)
        if not kernel.SetPriorityClass(kernel.GetCurrentProcess(),0x4000):
            raise OSError('cannot set region worker below-normal priority')


def _compile_object(item):
    from llvmlite import binding
    from .llvm_semantics import optimize_module
    if type(item) is not ObjectRequest or hashlib.sha256(item.text.encode()).hexdigest()!=item.digest:
        raise ValueError('region request digest mismatch')
    if item.triple!=binding.get_process_triple():raise ValueError('region target mismatch')
    binding.initialize_native_target();binding.initialize_native_asmprinter()
    target=binding.Target.from_default_triple().create_target_machine(opt=3)
    native=binding.parse_assembly(item.text)
    if native.triple!=item.triple or str(native.data_layout)!=str(target.target_data):
        raise ValueError('region object layout mismatch')
    optimize_module(native,target)
    return NativeObject(target.emit_object(native),item.digest,item.triple,os.getpid())


def compile_objects(requests,*,workers):
    """Complete all objects before any parent linking; nothing is installed.

    Only immutable text/identity crosses the process boundary. Literal parent
    pointers in the IR are opaque to LLVM and are never dereferenced here.
    """
    if type(workers) is not int or not 1<=workers<=2:
        raise ValueError('workers must be 1 or 2')
    from concurrent.futures import ProcessPoolExecutor
    import multiprocessing
    with ProcessPoolExecutor(max_workers=workers,mp_context=multiprocessing.get_context('spawn'),initializer=_priority) as pool:
        return tuple(pool.map(_compile_object,requests))
