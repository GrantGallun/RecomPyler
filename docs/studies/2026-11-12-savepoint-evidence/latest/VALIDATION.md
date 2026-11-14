# Final stopped checkpoint

Final source is clean commit `a9b59be60cdf568c8f6b63442e7efa88fd16fdd2` in the independent `wave8-header-fix` clone. The measured 411 checkout remains byte-identical across all 56 original source/test/native inputs. The new clone began with 817 exact-byte copies.

Two separate commits follow 411:

- `0a8b1768324af2092bd973baabae1409a1c01521`: validated cached-contract reuse for mutable containers, pre-memo actual-class/array validation, and the versioned C packing interface. Different unsupported contracts are rejected before native entry; no mutation-flag merging or blanket writeback.
- `a9b59be60cdf568c8f6b63442e7efa88fd16fdd2`: only the two ListT/ArrT length/truth header reads use the existing physical-address proof.

The freshly rebuilt support module is `_heap.cp314-win_amd64.pyd`, SHA256 `17e2e43e8825188a9e4339586b47fcc712d81a13ef90874cf869cac099dd16e0`, capability `LOAD_CONTRACTS_VERSION=1`. Only the new worker's heap support module was rebuilt with task-owned build/temp directories. The monitor module is unchanged. Exact compiler/link commands, source/binary hashes and raw output are retained in `native-heap-build/`. Older extensions use guarded Python packing; legacy private eight-argument calls cannot reuse an unknown list contract unsafely.

Evidence progression:

| Validation | Observed result |
|---|---|
| Header machine-code RED | 2 intended failures: signed arena-shape normalization remained |
| First header run | 18 passed, 1 inherited alias-writeback failure |
| Cached-contract RED | 14 actual wrong-state/layout/dispatch failures across both loaders |
| Wrapped-container RED | 4 actual dict/ndarray failures; 2 tuple controls already passed |
| Set contract RED | 2 actual lost-update failures |
| Safety GREEN | 31 passed in 42.76s; genuine versioned C path, safe old-extension path, aliases/cycles and AOT |
| Header GREEN | 19 passed in 9.43s, including the original unseen-alias control with explicit safe fallback |
| Combined compatibility | 318 tests + 16 subtests passed in 202.71s |
| Final new full suite | **572 tests + 52 subtests passed in 336.93s**, exit 0, 22 GPU-occupancy/Numba-SSA warnings |

One intermediate Python guard run had two counter-expectation failures: correct safe re-specialization was allowed after rejecting the old incompatible program. Tests were corrected to assert that the old native program receives zero calls, while permitting a valid new specialization. One expanded AOT run passed all semantics/mode assertions but failed an overbroad no-Numba assertion after ndarray fixtures were added. The existing `_nd` import limitation remains explicitly separated: non-ndarray AOT children require no Numba import; ndarray children require actual AOT and zero JIT while recording the pre-existing import. No `_nd` product change was made. All intermediate raw records remain preserved.

The final JIT fixtures show shared header reads: length-one then `[0]` falls from three to two integer loads and loses the redundant item-error store. Truth then dynamic indexing falls from three to two integer loads while keeping its signed comparison and required error store. These are actual JIT fixture observations; no final workload AOT or speedup claim is made here.

All 58 final source/test/native hashes were frozen before the new full suite and stayed unchanged. `candidate-freeze.json` and `full-suite/inputs.json` match. No source/test changes occurred after that freeze. Raw commands, inputs, stdout/stderr and result receipts are retained per validation directory.

The user requested savepoint/stop while the full suite was running. That already-started validation finished; no further tests, builds, profiles, timing jobs or product probes were started afterward. Only exact checkpoint archiving and completion receipts followed. Final paired measurement remains for an explicitly resumed session.
