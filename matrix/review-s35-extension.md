# S35 managed-object extension independent preparation review

Read managed.py, run.py, preserved upstream-sources.json, vendored passthru source/license and the installed Numba pythonapi, callwrapper, NRT context and _nrt_python.c implementations. No workloads were executed and no compilation or behavior verdict is inferred from source. Only this review document was written.

## Concrete additional unwind gate

The pre-tuple failure cleanup currently visits x then y then z. Python evaluates x/y/z in order, but when z attribute evaluation raises before BUILD_TUPLE, its operand stack unwinds y then x. Fresh finalizable x/y results can therefore observe a different destruction order. Execute this witness against original GVector.__str__, managed JIT, managed AOT and hand C:

```python
events = []
class Item:
    def __init__(self, label): self.label = label
    def __del__(self): events.append(self.label)
class Broken:
    @property
    def x(self): return Item('x')
    @property
    def y(self): return Item('y')
    @property
    def z(self): raise ValueError('z')
```

Use a fresh Broken for each call and compare both exception and events. The source predicts original y/x versus current intrinsic x/y; this is a fail-first witness proposal awaiting actual execution. The same issue appears in guarded.c's pre-tuple string cleanup. Release acquired attribute temporaries in reverse order on failure; once a tuple has acquired them, normal tuple deallocation handles its element ownership. Ordinary GVector float tests and a failing __float__ local child do not exercise this boundary.

## Ownership and error structure

Installed NRT_meminfo_new_from_pyobject increments the Python owner before attempting MemInfo allocation. Accordingly, unbox_managed's NULL compensation decref is necessary. On output-allocation failure, the manual result decref compensates that attempted owner incref, and the subsequent slot cleanup releases the original formatting result reference: those two decrefs are not a double release under this installed implementation. Record this version dependency; an altered NRT failure contract would require rechecking it.

Success acquires x/y/z, lets PyTuple_Pack acquire independent element references, releases the standalone attribute references, formats, acquires one MemInfo owner reference and releases formatting temporaries. box_managed acquires the outgoing Python reference before dropping the MemInfo. Unbox failure correctly marks NativeValue.is_error; the wrapper skips cleanup of the failed argument, so the explicit compensation matters. Py_DecRef tolerates NULL, and installed NRT incref/decref helpers also tolerate NULL MemInfo, supporting the error-result sentinel.

The intrinsic returns a managed result plus a success bit so native liveness can release the input before propagate_active returns RETCODE_EXC. This is a reasonable design, but the raw exception return bypasses any native cleanup that would appear afterward. Actual generated LLVM must show input MemInfo decref before every error exit, and repeated failing input-refcount gates must pass separately for JIT and AOT. Do not infer this from a successful compile. Retaining the active CPython exception through C-API temporary cleanup is part of the error gates.

Add a result-reference gate as well: retain one non-interned returned string and compare sys.getrefcount against a similarly held CPython result. Stable input refs alone would not expose a leaked output MemInfo. Keep weakref owner/child release and failing-conversion child gates already prepared. Allocation-failure edges are structurally handled but are not exercised by the current suite; disclose that limit rather than claiming tested out-of-memory behavior.

All Python C-API operations require the GIL. Current default JIT entry and ordinary CPython AOT wrapper provide it; this design does not authorize nogil calls or free-threaded operation.

## What the experiment answers

If actual compile and behavior runs pass, this is a real extension-interface mechanism: a custom Numba type with a StructModel containing NRT MemInfo, explicit boxing/unboxing, native signatures, and an intrinsic body calling CPython APIs. It is distinct from forceobj and does not contain an object-mode interpreter region. The body is a manually lowered complete GVector.__str__, not evidence that arbitrary Python source is automatically recognized or lowered. The matching custom signature exported through the unchanged CC directly tests whether the current AOT pipeline can carry this model.

Record generated LLVM and its actual API callsites, JIT direct-entry identity, AOT extension filename/hash and dependency versions. Prefer a fresh-process AOT import/behavior check so the artifact result is independent of the earlier JIT session. A successful adapted model would supersede the broad statement that nopython/AOT cannot carry objects; unchanged types.pyobject signature rejection remains true but is narrower.

The preserved upstream package demonstrates the MemInfo design and retains its BSD two-clause notice in vendor/LICENSE.numba-passthru. Its old llvmlite.llvmpy import is separate from whether the design is adaptable. Preserved PR metadata states PR3640 closed and unmerged; do not describe the old PR as an installed Numba feature. Existing snapshots, vendor source and hashes preserve evidence even though source URLs point at branches; a fetched commit identifier would further strengthen provenance.

Only GVector is prototyped here. Leave the other two extension-interface cells explicitly unmeasured unless separately implemented and executed. Do not estimate new production-native rows from this one manually lowered body without a row operation inventory and the estimate label required by S35.

## Executed v3 managed evidence and actual LLVM follow-up

Read logs/s35-extension-v3-red.stdout, results.json and managed-string.ll without executing workloads. Actual compilation produced the explicit nopython signature (wave17.ManagedPyObject,) -> wave17.ManagedPyObject. The original upstream import fails specifically at missing llvmlite.llvmpy; this is compatibility evidence for the unchanged old package, not a failure of the adapted MemInfo design.

Actual v3 reaches the new operand-unwind gate and reports original ['del-y','del-x'] versus managed ['del-x','del-y']; this independently confirms the preparation-review witness. Earlier ordinary success/error, output refcount, repeated input-refcount and owner/child assertions were reached before that failure. Full acceptance still requires correcting cleanup order and rerunning all gates, AOT and fresh import.

The retained v3 LLVM now calls PyUnicode_FromString, replacing the legacy helper implicated in the earlier process crash. It has no PyString_FromStringAndSize call. Actual native function borrows the input MemInfo; the CPython wrapper unconditionally NRT_decref's its unboxed input immediately after the native call and before testing success/error status. Thus wrapper ownership balances both return statuses; no additional native input decref is required in that artifact. Success boxing increments the returned Python object then decrefs the result MemInfo, as intended. Generated error branches return status -1 with the active exception; return_exc is structurally connected to the wrapper error return. This actual artifact evidence narrows the earlier general liveness inspection request.

The revised runner now checks a non-interned result refcount, records AOT artifact path/hash and includes a fresh-process import/call check that asserts Numba was not imported. Those gates directly answer the requested output ownership and artifact independence obligations once actual execution reaches them. No AOT or timing outcome is inferred from the prepared code.
