"""Watcher callbacks invalidate entry flags while executable owners stay pinned."""
import ctypes,gc,os,subprocess,sys,weakref
from pathlib import Path
from types import FunctionType
import pytest
from recompyler.ir import _entry_native,compile_function
from recompyler.ir.entry import create_callable,install_frame_entry
from test_ir_entry import NativeBody,original_path,identity

Accept=ctypes.PYFUNCTYPE(ctypes.c_int,ctypes.py_object)
Invalidate=ctypes.PYFUNCTYPE(None,ctypes.py_object)
class Invalidator(ctypes.Structure):
    _fields_=[('version',ctypes.c_int),('accepts',Accept),('invalidate',Invalidate)]
def api():
    capsule=_entry_native.invalidation_api()
    pointer=ctypes.pythonapi.PyCapsule_GetPointer
    pointer.argtypes=[ctypes.py_object,ctypes.c_char_p];pointer.restype=ctypes.c_void_p
    return capsule,Invalidator.from_address(pointer(capsule,b'recompyler.ir.EntryInvalidator.v1'))

def test_invalidation_capsule_accepts_only_supported_exact_entry_types():
    capsule,interface=api();body=NativeBody();entry=create_callable(original_path,body.address,body)
    assert interface.version==1 and interface.accepts(entry)==1
    for value in (None,object(),original_path,{},1):assert interface.accepts(value)==0

def test_native_entry_invalidation_falls_back_and_retains_executable_until_release():
    capsule,interface=api();body=NativeBody();reference=weakref.ref(body)
    entry=create_callable(original_path,body.address,body);marker=object();del body
    assert entry(marker) is marker
    interface.invalidate(entry);interface.invalidate(entry)
    assert reference() is not None and entry(marker)==('original',marker)
    del entry;gc.collect();assert reference() is None

def test_managed_handle_snapshot_does_not_retain_original_function():
    capsule,interface=api();fn=FunctionType(identity.__code__.replace(),globals())
    assert _entry_native._compilation_handle(fn) is None
    compile_function(fn,strict=True)
    handle=_entry_native._compilation_handle(fn)
    assert interface.accepts(handle)==1 and handle.function is fn
    interface.invalidate(handle)
    assert _entry_native._compilation_owner(fn) is None
    reference=weakref.ref(fn);del fn;gc.collect()
    assert reference() is None and handle.function is None and not handle.active
    interface.invalidate(handle)

def case_real_frame_invalidation():
    from recompyler import heap
    from recompyler.ir import build
    from recompyler.ir.lower_llvm import lower
    from frame_install_cases import Keepalive
    capsule,interface=api();fn=FunctionType(heap._find.__code__.replace(),heap._find.__globals__)
    owner=Keepalive(lower(build(fn),frame_entry=True));reference=weakref.ref(owner)
    handle=install_frame_entry(fn,owner.address,owner,seed_arguments=(None,));del owner
    class Root:parent=None
    root=Root()
    class Leaf:parent=root
    assert fn(Leaf()) is root and reference().calls.value==1
    interface.invalidate(handle)
    assert not handle.active and handle.function is fn and reference() is not None
    assert fn(Leaf()) is root and reference().calls.value==1
    handle.close();gc.collect();assert reference() is None

def case_active_frame_invalidation():
    from recompyler import heap
    from recompyler.ir import build
    from recompyler.ir.lower_llvm import lower
    from frame_install_cases import Keepalive
    capsule,interface=api();fn=FunctionType(heap._find.__code__.replace(),heap._find.__globals__)
    owner=Keepalive(lower(build(fn),frame_entry=True));reference=weakref.ref(owner)
    handle=install_frame_entry(fn,owner.address,owner,seed_arguments=(None,));del owner
    class Root:parent=None
    root=Root()
    class Leaf:
        @property
        def parent(self):
            interface.invalidate(handle)
            assert reference() is not None
            return root
    assert fn(Leaf()) is root and reference().calls.value==1
    assert not handle.active and reference() is not None
    assert fn(Leaf()) is root and reference().calls.value==1
    handle.close();gc.collect();assert reference() is None

def case_prepared_handle_is_promoted_without_replacing_subscription_target():
    from recompyler import heap
    from recompyler.ir.compiler import _install_prepared
    capsule,interface=api();fn=FunctionType(heap._find.__code__.replace(),heap._find.__globals__)
    compile_function(fn,strict=True);handle=_entry_native._compilation_handle(fn)
    assert not handle.active and _install_prepared(fn)
    assert _entry_native._compilation_handle(fn) is handle and handle.active
    interface.invalidate(handle)
    assert not handle.active and not _entry_native.compilation_info(fn)['installed']
    assert not _install_prepared(fn)
    assert fn(type('Value',(),{'parent':None})()).parent is None
    _entry_native.forget_compilation(fn)

def case_invalidated_or_replaced_owner_snapshot_cannot_install_stale_body():
    from recompyler import heap
    from recompyler.ir.compiler import _install_prepared
    capsule,interface=api();original=_entry_native._compilation_owner
    for mode in ('invalidate','replace'):
        fn=FunctionType(heap._find.__code__.replace(),heap._find.__globals__)
        compile_function(fn,strict=True);old=_entry_native._compilation_handle(fn)
        def raced(function):
            snapshot=original(function)
            if mode=='invalidate':interface.invalidate(_entry_native._compilation_handle(function))
            else:
                _entry_native.forget_compilation(function)
                compile_function(function,strict=True)
            return snapshot
        _entry_native._compilation_owner=raced
        try:assert not _install_prepared(fn)
        finally:_entry_native._compilation_owner=original
        current=_entry_native._compilation_handle(fn)
        assert current is not None and not current.active
        assert (current is old)==(mode=='invalidate')
        assert not _entry_native.compilation_info(fn)['installed']
        _entry_native.forget_compilation(fn)

@pytest.mark.slow
@pytest.mark.parametrize('case',['case_real_frame_invalidation','case_active_frame_invalidation','case_prepared_handle_is_promoted_without_replacing_subscription_target','case_invalidated_or_replaced_owner_snapshot_cannot_install_stale_body'])
def test_original_frame_entry_invalidation(case):
    root=Path(__file__).resolve().parents[1]
    env=dict(os.environ,PYTHON_JIT='1',PYTHONPATH=str(root/'src'))
    result=subprocess.run([sys.executable,str(Path(__file__)),case],cwd=root,env=env,capture_output=True,text=True,timeout=90,
        creationflags=0x4000|0x08000000 if os.name=='nt' else 0)
    assert result.returncode==0,(result.stdout,result.stderr)
    assert 'PASS '+case in result.stdout

if __name__=='__main__':
    ctypes.windll.kernel32.SetPriorityClass(ctypes.windll.kernel32.GetCurrentProcess(),0x4000)
    case=sys.argv[1];globals()[case]();print('PASS '+case,flush=True)
