# Final independent correctness review of refined candidate

Verdict: **clear on reviewed source correctness and recorded validation; no actionable code finding** for 0373788b7be436e5e43b0a6a6f3fd40b2871c3a3. This covers the whole branch relative to saved a9b: borrowed recursive context, unsigned proved iteration addresses, and raw context values through already-inline-marked helpers. Performance acceptance and integration remain pending actual selected AOT and fresh matched timing review.

This report extends INLINE-CONTEXT-REVIEW.md with the completed new full suite. It does not reuse the old 578 full-suite result as validation of 037. No numerical imports, tests, compiler runs, builds, profiles or workloads were executed by this reviewer.

## Independently verified completion

The retained full-suite command is `C:/Python314/python.exe -m pytest -q tests` in wave9-inline-context-fix. Receipt exit code is 0; stdout ends **599 passed, 22 warnings, 52 subtests passed in 300.90s (0:05:00)**. The runner's elapsed time is separately 310.1648 seconds. The warnings remain retained CUDA occupancy and Numba internal SSA assumption warnings, not hidden failures or a zero-warning claim.

At 2026-11-12T17:41:58Z, independently compared the union of before/after/freeze input keys: all inventories contain exactly the same 61 inputs and every before/after/frozen hash equals current bytes. Git HEAD is still 0373788b7be436e5e43b0a6a6f3fd40b2871c3a3 and status is clean. The whole branch still changes only heap.py and the three reviewed test modules; no changes followed the focused source review/freeze.

Raw stdout hash 708af821a0523b9aece64e20bf01c3d5177bf1f98b7c6219d6f1f3d19ea5ae8b and empty stderr hash e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 match the retained receipt. The runner hash also matches. Own machine receipt: inline-full-suite-verification.json.

Final heap SHA256 remains 7904ae104331ea666cdcf0b577900771d2b2530f9b3ad28670480ef9e78c40b4. The prior independent source review's lifetime, typed layout, immutable-address/mutable-payload distinction, public guard order, callee-based argument routing, SCC-entry coverage, cache identity, retry/fallback and alias analysis therefore applies to the exact fully tested product bytes.

## Supported conclusion and remaining limit

The complete refined candidate passes the available suite. Earlier focused validation additionally isolates the native signature/descriptor-load mechanism and checks real output/mutation through both ordinary and promoted real SCC-wrapper entry paths. Existing aliases, numeric-kind checks, depth/error handling, growth, rollback/replay, nullable behavior, external NumPy/RNG state, AOT and recursive disk-cache coverage remain tested. This supports accepting source correctness for this implementation; finite tests and reviewed invariants are not a proof for every future program/input.

The old measured raytrace regression remains relevant historical evidence. This new full-suite pass does not show it has been fixed. The fixture's fewer descriptor reads are not selected-workload instruction counts, and test duration is not a compiler workload benchmark. Actual selected ray render/SCC code, Barnes recursive argument count and frame/load costs, retained guard/mode/state checks, profile/startup cost and fresh saved/refined/C timing distributions still determine performance acceptance. Integration should preserve these exact tested bytes once those remaining results are reviewed.
