"""Shared native image ownership is LLVM-free and cleans every failure path."""
import ctypes
import gc
import sys
import pytest
from recompyler.copy_patch import Hole,Operation,Stencil,prepare

pytestmark=pytest.mark.skipif(sys.platform!='win32',reason='Windows native allocator')


def test_native_owner_keeps_legacy_alias_and_uses_execute_read_pages():
    from recompyler.native_image import ExecutableImage
    from recompyler.copy_patch_tier import _Executable
    assert _Executable is ExecutableImage
    layout=prepare([Operation(Stencil(b'\xc3'),{})])
    image=ExecutableImage(layout,{})
    assert image.address and ctypes.string_at(image.address,1)==b'\xc3'
    class Information(ctypes.Structure):
        _fields_=[('base',ctypes.c_void_p),('allocation',ctypes.c_void_p),
                  ('allocation_protect',ctypes.c_ulong),('partition',ctypes.c_ushort),
                  ('size',ctypes.c_size_t),('state',ctypes.c_ulong),
                  ('protect',ctypes.c_ulong),('kind',ctypes.c_ulong)]
    query=ctypes.WinDLL('kernel32',use_last_error=True).VirtualQuery
    query.argtypes=[ctypes.c_void_p,ctypes.c_void_p,ctypes.c_size_t]
    query.restype=ctypes.c_size_t
    information=Information()
    assert query(image.address,ctypes.byref(information),ctypes.sizeof(information))
    assert information.protect&255==0x20


def test_early_allocator_failure_preserves_exception_without_unraisable(monkeypatch):
    from recompyler import native_image
    events=[]
    monkeypatch.setattr(sys,'unraisablehook',lambda event:events.append(event.exc_type))
    def fail():raise MemoryError('allocator setup')
    monkeypatch.setattr(native_image,'_kernel32',fail)
    layout=prepare([Operation(Stencil(b'\xc3'),{})])
    with pytest.raises(MemoryError,match='allocator setup'):
        native_image.ExecutableImage(layout,{})
    gc.collect()
    assert events==[]


def test_link_failure_releases_allocated_memory_once(monkeypatch):
    from recompyler import native_image
    real=native_image._kernel32();allocations=[];freed=[]
    class Kernel:
        def VirtualAlloc(self,*arguments):
            address=real.VirtualAlloc(*arguments);allocations.append(address);return address
        def VirtualFree(self,address,*arguments):
            freed.append(address);return real.VirtualFree(address,*arguments)
    monkeypatch.setattr(native_image,'_kernel32',Kernel)
    stencil=Stencil(bytes(8),holes=(Hole('code',0,'abs64','missing'),))
    layout=prepare([Operation(stencil,{})])
    with pytest.raises(ValueError,match='missing'):
        native_image.ExecutableImage(layout,{})
    gc.collect()
    assert len(allocations)==1 and allocations==freed
