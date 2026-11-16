# Native nested AST visitors

Real unchanged `lift._local_names` now compiles its nested walk as a typed native helper through the shared structure/call compiler. Captured locals use live frames, preserving rebinding, unbound-cell exceptions and original AST/name owners. Shared hooks provide compiler construction, entry admission and counters.

`python matrix/run_context_suite.py`:3290passed,131subtests,4xfail,0skip,0failed; four below-normal correctness workers. The single implementation review found three executable cases, each tested red and corrected: low recursion headroom, unguarded global recursive seeds, and missing-source refusal type. Final bounded ten-minute-mode seed75301:288native/12construction-declined/0wrong across15original/mutated subjects, with canonical owner-retention oracle.

Fresh actual `_local_names` call:1compiled parent/23native helper/80managed calls/0whole-function fallback, exact CPython result (`matrix/managed-visitors-real-helper.log`). Managed counts include AST iterator and set protocols, not fully native arithmetic. Public experimental `managed.lift_managed`; automatic profile/run deployment unchanged. No speed claim.

Accepted shared inference/import base62224c0f is consumed as691d0970. General escaping function/cell creation is a separate next capability; cyclic/deep, unknown-call and unproved recursive graph cases stay Python or decline before effects.
