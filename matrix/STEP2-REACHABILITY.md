# Original four wrong rows: verification and user reachability

All assertions below come from matrix/baseline-v1.jsonl on unchanged 7e3b688, with actual native counter increments. Verification is not deployment. The tiny matrix functions were never ordinary deployed regions.

| Original wrong row | Actual mismatch | Ordinary verification | Ordinary deployment of this fixture | User reachability |
|---|---|---|---|---|
| operator.tuple.and | Selected right tuple reconstructed; result is not the input tuple | Verified: existing value comparison missed alias loss | Recommended false; measured 0.02136x Python | Wrong through public lift direct execution (observed). No deployed wrong region demonstrated; a profitable caller/forced direct use was not protected by verification |
| operator.tuple.or | Selected left tuple reconstructed; result is not the input tuple | Verified: existing value comparison missed alias loss | Recommended false; measured 0.02051x Python | Wrong through public lift direct execution (observed). No deployed wrong region demonstrated; verifier was not an identity guard |
| method.list.reverse | After warming pop, reverse returned 2 and shortened list to [3,1] instead of returning None and reversing it | Rejected: result differs from a captured call | Not eligible after rejection | Ordinary capture/verify caught the error before deployment. Independent direct native replay produced the wrong result |
| method.list.sort | Same semantic module-cache collision reused pop for sort | Rejected: result differs from a captured call | Not eligible after rejection | Ordinary capture/verify caught the error before deployment. Independent direct native replay produced the wrong result |

Fixes: supported selected-value and/or is now limited to singleton kinds; other represented value kinds decline before native execution. Numeric truth-only conditions still compile. Generated module and record-type identities include stable semantic helper recipes, so warming pop cannot bind reverse/sort to it. Runtime type-domain declines, checked list reads, None columns, precise mixed comparisons and shared-NaN tuple declines address the crash and additional independently executed review witnesses.

Expanded baseline evidence is baseline-matrix.json plus review-probes-base.jsonl and scalar-identity-v1.json (scalar probes ran on the intermediate correction, also exposing the inherited numeric-value identity mechanism). Current full row evidence is step2-v3.jsonl: 1,016 rows, 235 native, 781 declined, zero wrong/crash. This is input-specific execution coverage, not proof for all values of every construct.

Open scope: general scalar input/return identity and arbitrary graph identity outside these witnessed Boolean selection domains remain wider compiler-boundary questions. No blanket proof of all Python identity semantics is claimed.
