# Shared provenance integration review

Independent read-only review approved the0b8ffc2d integration and pinned-corpus correction before merge. Product diff adds the shared conservative module only; existing runtime source remains unchanged, and REPORT preserves wave16 status. The module is unused by active direct execution. Unknowns are explicit refusals, not hidden support.

Both corpus tests now honor RECOMPYLER_PROVENANCE_CORPUS and reject a missing selection. The smoke verifies exits0/1/2 for the selected snapshot and both missing-directory controls. The full union runs on an11-file immutable snapshot and passes2577tests/131subtests with2expected xfails. Independent review recomputed all44source and108test files, corpus hashes, harness and freeze hash: zero mismatches. Receipt verifies below-normal serial correctness and no timing lock.

The first union attempt was cancelled early after detecting live-root input outside the old seal. Its own process tree and cancellation proof are retained; it supplies no accepted aggregate. The new complete label is s47-provenance-union-v2.

Shared-layer consumer review confirms CO_METHOD is a real source-binding limitation on8of10S46 bodies. Six positive method queries fail before semantic consumption. Current corpus collectors do not execute class-method metadata automatically; the new method cases document queries and the separate red tests supply executed evidence. The owner request preserves all other source/code/position/dependency checks. No private solver or blanket flag-mask workaround is introduced.

Independent S46 review recomputed source/helper/child/application hashes and all160calls' reconciled partitions, successful real dispatcher events and public counter deltas. Both complete passes are disturbed descriptive timing only; no isolated native-body time, guaranteed saving or new deployment is claimed.

Independent S55 review recomputed budget inputs and arithmetic with zero mismatches. Largest remainder selection was corrected to include all retained phases (Hex.link_nodes staged_payload_copy14.26?22.79us). Zero conversion-only projected winners remains. The lazy runtime is unpriced; S55.3 is an explicit DEVIATION/steering request, not DONE. Steps2/3, S53 and4b remain unfinished.

Evidence: s47-provenance-union-v2/{complete,freeze}.json; correctness/s47-provenance-union-v2/{receipt.json,stdout}; s47-pinned-corpus-smoke-v1/complete.json; S46-TEN-BOUND.{md,json}; S55-ENTRY-BUDGET.{md,json}.
