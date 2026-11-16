"""Shared W^X executable image owner; no compiler or LLVM dependency.

The immutable Layout copies and patches once after allocation supplies its base.
Existing frame/vector handles retain this owner. This module adds no registry,
source binder, object parser or runtime code emitter.
"""
from functools import lru_cache

@lru_cache(maxsize=1)
def _kernel32():
    import ctypes
    kernel = ctypes.WinDLL('kernel32', use_last_error=True)
    kernel.VirtualAlloc.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_ulong, ctypes.c_ulong]
    kernel.VirtualAlloc.restype = ctypes.c_void_p
    kernel.VirtualFree.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_ulong]
    kernel.VirtualFree.restype = ctypes.c_int
    kernel.VirtualProtect.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_ulong, ctypes.POINTER(ctypes.c_ulong)]
    kernel.VirtualProtect.restype = ctypes.c_int
    kernel.GetCurrentProcess.restype = ctypes.c_void_p
    kernel.FlushInstructionCache.argtypes = [ctypes.c_void_p, ctypes.c_void_p, ctypes.c_size_t]
    kernel.FlushInstructionCache.restype = ctypes.c_int
    return kernel


class ExecutableImage:
    """Private W^X allocation; the existing entry handle owns its lifetime."""
    def __init__(self, layout, symbols=None):
        self.address = 0
        import ctypes
        kernel = _kernel32()
        self._kernel = kernel
        address = kernel.VirtualAlloc(None, layout.size, 0x3000, 0x04)
        if not address: raise ctypes.WinError(ctypes.get_last_error())
        self.address = address
        try:
            self.image = layout.link(base=address, symbols=symbols)
            ctypes.memmove(address, self.image.body, len(self.image.body))
            old = ctypes.c_ulong()
            if not kernel.VirtualProtect(address, layout.size, 0x20, ctypes.byref(old)):
                raise ctypes.WinError(ctypes.get_last_error())
            if not kernel.FlushInstructionCache(kernel.GetCurrentProcess(), address, layout.size):
                raise ctypes.WinError(ctypes.get_last_error())
        except BaseException:
            self._release()
            raise

    def _release(self):
        if self.address:
            self._kernel.VirtualFree(self.address, 0, 0x8000)
            self.address = 0

    def __del__(self):
        self._release()


