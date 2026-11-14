# Proven nonnegative object-field indices

Implemented and committed as `e35dce1b7cef4019400696a9d7712ae8571a0b81`, branch `codex/nonnegative-heap-index`, parent `3f0370d`. The previous `codex/heldout-fixes` branch and historical Wave3/4 evidence are preserved. Only `src/recompyler/heap.py` and `tests/test_heap_indices.py` changed. Working tree and `git diff --check` are clean.

## Scope and proof

`_Gen.physical_index(where, nonnegative)` emits `np.uint64(complete_signed_expression)` only at explicitly marked object-field accesses and partial-class attribute tag checks. The flag defaults to false. Attribute reads, assignment and augmented assignment first call `handle()`; nullable receivers fail before the physical access. Every `attr_check` caller follows this proof, and partial-layout checks precede field access. Loaded objects have validated layouts; newly allocated objects are used only after the existing allocation-status check. Handles and field/flag offsets identify slots within the finite arena (`MAX_SLOTS = 2**27`), so the complete field address is nonnegative and does not approach signed-64-bit overflow. Only its final interpretation as a NumPy index changes. Handle values, sentinel tests, arithmetic operands, field values, and return values remain signed where they were signed before.

The proof propagates through MIXED flags, optional-number presence flags and NumPy-scalar kind flags, wrapping the full address including each flag offset. Tuple fields need special care: their outer object slot is valid, but a nullable tuple can contain a -1 payload handle whose speculative values are ignored. Nested tuple payload loads deliberately reset to the default signed indexing; tuple payload stores also keep the previous lowering. This is why a blanket F/I rewrite was rejected.

Container helpers, user negative list/string indices and slices, dictionary helpers, raw NumPy strides/indices, `_Loader`/`_Unloader` accesses, and all other generated physical accesses remain unchanged. This bounded optimization does not claim all internal negative-index adjustments have disappeared.

## Tests and evidence

- `indices-red.txt`: initial baseline run, four failures. Two expected failures demonstrated the real native LLVM entry's signed handle comparison/select for object reads and writes. Two additional failures exposed an inherited tuple identity limitation: returned tuple and stored field tuple compare equal but are not the same object. No tuple implementation was changed; this limitation is explicitly outside the optimization's scope.
- `indices-red-scoped.txt`: baseline rerun with the tuple test checking values/presence rather than the inherited identity issue: exactly two expected LLVM structural failures, 16 passing behavioral cases.
- `indices-green.txt`: minimal product change, 18 passing cases.
- `indices-focused.txt`: final 22 tests passed in 1.20 seconds. Added class-tag/missing-field fallback and optional mixed numeric type/signed-zero controls.
- `full-suite.txt`: final frozen product/tests, **405 passed, 38 subtests passed, 22 warnings in 249.27 seconds**, process exit0. No source or test edits occurred during this run.

The LLVM tests compile and execute real object-field functions, verify outputs/identity for the object-store case, then inspect the native entry. Baseline has `icmp slt i64 %arg.v_cell, 0` and a select adding array length; candidate does not. No mocked machine output or cache-inspection shortcut is used. Disk compilation reuse is disabled only for these two inspection tests so the IR is available. Actual workload AOT disassembly and performance comparisons remain the coordinator/study team's next gate; no speedup claim is made from these tests.

Behavioral cases run with both loaders and cover negative logical indices and bounds errors; optional tuple presence; null/unbound handles; heap growth and exhaustion; single-effect Python fallback; object/list alias identity; integer overflow; negative ndarray strides; partial-class field guards; optional mixed field type and signed zero.

The 22 warnings comprise 10 existing GPU occupancy warnings and 12 Numba IR-scope assumption warnings in three existing `test_lift.py` column/object tests. These same 12 warning cases already appear in `.tmp/wave3/full-suite.txt` (351 tests, 22 warnings at the earlier revision); the later warm-cache run reported only10. The warnings did not arise from the new tests and all associated correctness/reference-count checks passed. Their compiler-internal cause is not fixed or claimed resolved by this change.

## Reproduction

Working directory: `D:/Code/Datathon/recompyler-codex-20261111/heldout-fixes`.

```powershell
$env:PYTHONPATH = (Get-Location).Path + '/src'
$env:RECOMPYLER_CACHE = (Get-Location).Path + '/.tmp/wave5/recompyler'
$env:NUMBA_CACHE_DIR = (Get-Location).Path + '/.tmp/wave5/numba'
$env:TEMP = (Get-Location).Path + '/.tmp/wave5/temp'
$env:TMP = $env:TEMP
& C:/Python314/python.exe -m pytest -q > ../wave5-validation/full-suite.txt 2>&1
```

Focused command replaces `-m pytest -q` with `-m pytest tests/test_heap_indices.py -q`. The log path above describes the completed run; preserve it rather than overwriting historical evidence during future checks.

Frozen file SHA256:

- `src/recompyler/heap.py`: `3bdbb2e20b5544bd60ad8c4100d37c5a1146a2d859ad0adf59201e2c99383279`
- `tests/test_heap_indices.py`: `96287b342edd243c65c95af4700a5b4de525d8adbaae8e43b20f1c1d0d023cc5`

The CPU slot was released after full-suite process completion. No workload timing, package change, or modification to the user's original checkout was performed.
