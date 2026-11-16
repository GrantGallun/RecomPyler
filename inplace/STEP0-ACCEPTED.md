# Accepted Step 0 under S37

The integrated depth, frozen coverage, exact-key prepared runtime cache and native guard shapes are accepted as the Step 0 base. S37 expressly closes integration without further guard variants. Immutable build/source variant: `integration-native-shapes-s37`.

Fresh recovery union: 1,257 tests and 131 subtests passed (48 warnings), root receipt exit 0. The interrupted checkpoint60 union-v4 is failed/excluded and was not reused. The entire prior tree is protected in WIP commit `066589e`.

S37 one-shot check against pre-native-guard integrated source: Barnes candidate-minus-base -2.1540/-0.0084/-1.6204 ms; all gains, paired median saving 1.6204 ms exceeds half the checkpoint49 median regression (0.413925 ms). Keep native guards. FFT +0.0341/+0.0126/+0.0008 ms, all slower; no ten-pair significance claim is made from these three pairs. Exact behavior and expected AOT entries pass, with zero JIT/fallback. Evidence: `s37-shapes-pairs-v1/{summary,paired-analysis,complete}.json`, `logs/s37-{union,shapes-build,shapes-pairs}-v1.receipt.json`.

**Named Step 4 target: per-call lifetime/allocation guard overhead.** Carry forward the checkpoint49 ten-pair Barnes +2.5% and FFT +1.5% control regressions, attributed by checkpoint51 to safety guard work executed on every call. Retaining the native shapes does not erase this recorded target or establish complete recovery on final source.

The accepted startup result remains checkpoint43: integrated/coverage process ratios 0.97480 on chaos and 0.95574 on Richards; 20 AOT calls each, no regeneration. Exact later named committed depth changes are integrated. S37 accepts these recorded gates without another startup cohort inside Step 0. Steps1-4 and their final whole-call/deployment gates remain required.
