# Known gaps

- S56 flat prototype is private JIT only; default Region routing, saved AOT and deployment selection remain unchanged.
- Cold empty lists decline until a nonempty numeric shape is prepared; warmed empty lists run with exact checks.
- One container occurrence only: aliasing/multiple roots, result containers, list stores, resize and Python callbacks inside native code decline; field-only ordinary instances may expose one array-d buffer and numeric scalar reads, but methods and field-reference stores decline.
- Raw array undo copies the complete buffer; sparse first-store journaling remains unimplemented and its cost is retained.
- The private native-call adapter preserves raw backend error status, marks failure and rolls back before original-Python replay; dynamic native exception allocation is declined by no-NRT and the helper allow-list. It is not a general resumable deoptimisation mechanism.
- Native wrapper cleanup is tied to installed Numba/Python ABI; only this installed exact Python build is enabled by the audited guard header.
- Existing deployed-graph evidence proves native reachability and inline-always requests, not actual LLVM inlining or outer resolver probe counts.

## Shared differential fuzzer
- The S51 diagnostic loses sound type/state information after a refusal; all 134 analysed blocked roots retain an unknown remainder and receive no reliable completion credit.
- Structural traversal includes conditional/unreachable branches and nested declarations; those observations are not executable-path or native-acceptance proofs.
- Inlined reasons may identify the callsite rather than a callee statement; the event records preserve both scope and location kind.
- The collector basename prefilter can omit nested input paths; exact source/qualname matching then leaves the row unknown.
- Bounded settling, positive inert seeding and observed record views do not establish backend support, constructor validity, ownership permission or deployment benefit.
- Existing inclusive capture weights overlap between caller/callee roots; missing weights are unknown and neither their sum nor optimistic completion counts estimate unlocked wall time.
- S54 arbitrary callbacks cannot safely use replay-from-entry after an effect; post-call kind misses, later overflow, callback exceptions and re-entry require explicit handling. Current product calls remain declined.
- The accepted shared provenance layer has no product managed-reference/call API yet; diagnostic NRT models exist in matrix/extension/managed.py. A second representation must not be invented.
- Fuzzer: extension objects, arbitrary callback/finalizer observation, async results, recursive tuple fixups and mutable closure factories are currently unchecked; they do not count as passing fuzz cases.
- Fuzzer: static test extraction omits module setup/imports outside its allow-list and class methods as direct subjects; use a dedicated fixture wrapper for those programs.
- Fuzzer: resource-risk filtering and per-subject timeouts leave some large-loop/exponent probes unchecked; these results are reported separately.
- Fuzzer: bounded greedy shrinking proves reproduction of each reduction, not a globally smallest program.
- Fuzzer: portable string literals may merge distinct equal strings; replay validation rejects a recipe when that changes the finding.
- Fuzzer: module attributes, dunder namespace metadata, and arbitrary callback observer protocols need dedicated fixtures; the initial oracle does not claim to walk their external state.
- Fuzzer: optional parameters omitted by the fixture are not yet synthesized as extra argument slots; use an explicit fixture argument or keyword to probe those domains.



## Shared differential fuzzer


- Member entry bounds class/instance name-table scans (8 MRO,64keys,8fields); method binding, slots, descriptors/custom getters, non-string keys and larger name tables decline. No broader owner graph is admitted.
- The installed-runtime signature is checked before private member layout access; other Python builds are outside this candidate and decline. No alternate-build portability claim.
- S59 replaces spectral/SOR/LU/MonteCarlo as in-place targets after wave19 merge; member primitives have no default/AOT program gain until routing is integrated.
- Unicode: heap-produced or converted str/bytes graphs decline until their exact owners can be preserved; scalar comparisons can remain native. This deliberately withdraws unsupported text production rather than reconstructing owners by value.
- Source acquisition: the heap constructor-field helper remains on its pre-existing inspect path, outside this frontend change; arbitrary audit/read observers require dedicated controls.

- Managed AST: the first public experimental API compiles read-only fields/control/recursion; general call sites and the ordinary profile/run pipeline require the sibling bridge integration.
- Managed AST: callback-capable owners/descriptors and cyclic/deep graphs decline before entry; nested visitors and actual function/class creation are the next slices.
- Managed AST: general external managed-call counts exclude field/type/iterator/list intrinsics, which still use CPython objects and protocols.

Managed library calls: functions carrying future compiler flags decline before entry until compile/eval/exec inherit the original frame flags. Concrete annotations flag regression returns16777216 in CPython versus0 without this refusal.

- Managed call/structure entries decline before effects while a caller exception is actively handled, preserving CPython exception context until native handled-exception propagation is supported.

- Managed ordinary imports currently decline dotted aliases before entry; import-from attribute extraction is a separate next boundary.

- Managed import-from uses the installed CPython3.14 IMPORT_FROM ABI and declines other runtimes or missing symbols before entry; star imports remain declined.

- Protected compiled regions currently support try/finally on CPython with raised-exception transfer (3.12+); except/else and protected break/continue decline before entry. Real Numba startup's import-from still requires the guarded3.14 runtime operation.
- Native visitors: owned captures rebound through loop targets conservatively decline until alias-safe capture mutation is supported.

- Function creation WIP: actual nested CodeType/default tuple/keyword keys and real cells are preserved; inline comprehensions with cells decline until shared frame scopes are supplied. Nested callable bodies remain managed CPython, not native child control flow.
S87 constant-word lowering: no isolated runtime regression combines an optimized immortal non-singleton with code replacement or error handoff; emitted word is identical to pinned CPython, and mortal replacement/error cases pass. Single review found no executable defect.

S87 local tagged words: no direct COPY-of-OR/SELECT or mixed-tag SELECT/PHI regression in this slice; those forms stay conservative unless both SELECT choices prove tagged. Single review found no executable defect.
