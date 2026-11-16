"""Self-host counters can discard private finalized LLVM IR, retaining code."""
import gc
from pathlib import Path
import sys
import weakref

sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))


def test_private_finalized_ir_is_released_before_broad_selfhost_installation(monkeypatch):
    from ir_self_host import CountedBody
    import test_ir_existing_frame as frames
    lower=frames.lower;modules=[]
    def counted_lower(graph,**options):
        lowered=lower(graph,**options)
        modules.append(weakref.ref(lowered.native_module))
        return CountedBody(lowered.execution_owner,discard_ir=True)
    monkeypatch.setattr(frames,'lower',counted_lower)
    def walk(value):
        while value.parent is not None:value=value.parent
        return value
    class Node:parent=None
    root=Node();leaf=Node();leaf.parent=root
    entry,counted,status=frames.frame_entry(walk)
    gc.collect()
    assert modules[0]() is None, 'private finalized LLVM IR remained pinned by the execution owner'
    for value in (root,leaf,leaf):assert entry(value) is root
    assert counted.calls.value>=3
    try:entry(object())
    except AttributeError:pass
    else:raise AssertionError('detached code lost its original error continuation')


def test_counter_preserves_diagnostic_ir_by_default():
    from ir_self_host import CountedBody
    from recompyler.ir import compile_function,_entry_native
    def target(value):return value+1
    compile_function(target,strict=True)
    code,owner=_entry_native._compilation_owner(target)
    try:
        counted=CountedBody(owner)
        assert counted.original.native_module is owner.native_module
        assert not owner.native_module.closed
    finally:_entry_native.forget_compilation(target)
