# Independent alias-contract safety review

The coordinator explicitly authorized this separate safety repair after the new header AOT control exposed stale list writeback. The two header casts are not its cause. Source/evidence for the original411 benchmark remains immutable.

## Confirmed defects and bounded design

Independently read baseline411 evidence and the dedicated alias-contract RED result:14 semantic failures,4 controls deselected,3.85s, exit1 with unchanged inputs. Both loaders exhibit field/argument and nested-field live-alias writeback loss, int/float list layout reinterpretation, and ArrT writeback loss. Four additional failures show Base/Derived cached method dispatch using the previously expected class when a repeated live identity bypasses second class validation.

The accepted list policy is conservative: a per-load id→canonical `_find(kind.cell)` map permits same-contract aliases/cycles and rejects the same live list under another contract before native entry. Do not merge cells, OR mutation metadata, write every list back, or reinterpret/repack a block already loaded under another layout. Apply the guard in Python ListT/ArrT packing and native recursive load_list. Existing native c_kind descriptors include the canonical root at index3.

Object fix scope is only moving the existing actual-class membership/plan lookup ahead of known-handle return. RED fixture warm(Derived,Base) then sameDerived and reverse proves the need; the global actual-class layout remains shared. No new object alias graph or field scan is proposed.

## Native API review checklist for actual patch

Keep handles id→integer format used by writeback. One per-loader contract map must be shared across all native calls and recursive loads, and reset with each new load/retry. An optional ninth private load argument is acceptable with explicit version capability: new Python must require the capability before fast packing and always pass the map. Old native extension must fall back to guarded Python packing. Legacy eight-argument native calls may only reuse handles whose contract can be proven within that call; do not silently accept unknown preexisting list records.

C dictionary entries own their root references; no borrowed root may outlive its owner. Propagate allocation/dict errors, release id keys on all early-return paths, and decref an internally allocated legacy map on every exit. Reject incompatible contracts before publishing a new load result or entering compiled code. The implementation must not introduce false F/I noalias metadata or affect the generated ABI.

Positive tests must prove actual C loader capability/packing, not merely NATIVE=True with a stale extension silently using Python. Fresh AOT tests count exported native entries: changed alias contracts reject before entry, same-contract aliases/cycles retain AOT, effects occur once on fallback, no JIT/Numba. Full frozen source/native-extension fingerprints and a new full suite are required before the next measured cohort.

Actual patch/refcount review and green validation are pending. Reviewer performed no product edits, builds or test execution.

## Recursive-wrapper boundary review requested by coordinator

Tuple does not memoize/return a known outer handle: `_Loader.tuple` allocates and visits every payload; argument TupT likewise recursively visits its components. A repeated tuple containing a list therefore reaches the list contract guard. Add a wrapped-tuple regression/control, but no tuple contract machinery is supported by this source finding.

DictT/SetT `_Loader.container` does return an existing identity before traversing entries or checking the second canonical key/value cells. A repeated live dict can therefore hide a differently typed nested list from the new list guard. Coordinator approved cheap RED controls; if confirmed, a bounded known-container guard can use the existing canonical DictT key/value cell roots or SetT element cell root. Preserve same-contract recursion by recording the token before traversing entries. No second whole-graph prewalk, cell merging or immutable tuple identity change is needed.

The source also shows `_Loader.ndarray` returning a known handle before its existing dtype/rank/writable/native-format checks, contrary to the initial assumption that these checks already dominated memoization. A warm float64/int64 pair later becoming one float64 array can bypass the second expected format. Requested a concrete RED before any source edit; if confirmed, moving the existing validation block before known return is the same bounded guard-order correction as ObjT. It is not a new ndarray representation or relaxed view/stride contract.

## Actual safety patch verdict before commit

**Clear: no actionable source finding in the actual heap.py/_heap.c safety diff on411.** The header casts were withdrawn for this separate change. Additional worker RED confirmed tuple controls pass, while Dict, Set and NdT cases each fail on both loader modes; coordinator explicitly authorized only those demonstrated guard-boundary extensions.

Reviewed every added C path. The ninth contracts dictionary is borrowed from the Loader; the legacy eight-argument path owns a new dictionary and decrefs it on invalid-type, buffer-failure, and post-load exits. Heap buffers are released after loading. Known-list branches release the id key on success, mismatch and dictionary error; new-list branches release it after record insertion. PyDict_SetItem retains the canonical root reference. Recording the root before visiting payloads preserves recursive reuse. An unknown preexisting list under legacy eight-argument use is rejected because its contract is unavailable. The integer handle-map format remains unchanged. Class-plan lookup before known return uses a borrowed plan retained by the live kind descriptor.

Reviewed Python paths: fresh per-Loader contracts map is passed into every native packing call; Region.load constructs a new Loader inside its retry loop. ListT/ArrT require exact type and same canonical cell before known reuse. DictT records a tuple of class/key-root/value-root and SetT class/element-root before traversal; same-contract recursion remains possible. Existing ObjT membership and all existing NdT format/rank/writable/view/stride checks now precede memoization. Strings and tuples are untouched. Capability must equal LOAD_CONTRACTS_VERSION1 before fast packing; old extensions use the guarded Python loader rather than bypassing the new checks.

Independently read alias-contracts-green-final receipt/output:31 tests passed in42.76s, exit0, unchanged inputs and no skips. Tests assert actual native packing/version, safe legacy8/new9 API behavior, old-capability fallback, changed-role rejection and positive aliases/cycles. Fresh AOT tests warm a valid specialization and count native exports; unsafe alias reuse adds no old-export entry, while exact result/type/state and once-only effects hold. Non-Nd fixtures assert no Numba import. NdT fixtures explicitly retain the inherited source-regeneration Numba import limitation while asserting actual AOT and zero JIT; this is not a claim that NdT startup is import-free.

Read native build/probe receipts and independently hashed current files: _heap.c3c75e33bb259e360835bba7052c675898e7688e22550f21fdee34d45499d77d8; rebuilt worker-only _heap.pyd17e2e43e8825188a9e4339586b47fcc712d81a13ef90874cf869cac099dd16e0; unchanged _monitor.pyd00d6138bbf198ecff79cea44e18de1d122727c3c0e2acacbe9260a603f22e9e5. The build/probe reports capability1 and unchanged C source during build. git diff --check passes. No reviewer build/test execution occurred.

Ready for the separate safety commit. Final whole-branch verdict still requires the final source/test/native-extension freeze, restored header optimization checks and full-suite evidence. No performance claim is made for the new loader checks; old411 native timing remains a different, immutable source/binary state.

## Savepoint completion

Safety commit0a8b1768324af2092bd973baabae1409a1c01521 and header follow-upa9b59be60cdf568c8f6b63442e7efa88fd16fdd2 are frozen and reviewed. Final full suite completed572 tests plus52 subtests in336.93s,22 warnings, exit0. Reviewer verified raw receipt/log hashes and all58 frozen/current inputs; HEADER-FOLLOWUP-REVIEW.md and header-savepoint-verification.json contain the final boundary. Whole-branch source/validation verdict is clear. Performance on this final source/new loader remains unmeasured. Stop at the requested savepoint; no further jobs authorized tonight.
