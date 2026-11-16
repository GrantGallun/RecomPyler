# Character-loop BOUND (S38.3)

Borrowed pinned Unicode wins on the complete fresh default-POSIX first-token wrapper over installed shlex.shlex.read_token. No isolated long-character scanner was identified in the retained40 owned files; owned-source-audit.json records all413 loop sites and source hashes without inferring dynamic receiver types. The authorized stdlib tokenizer substitute is used. It includes the full default-mode grammar, not stateful/non-POSIX/punctuation configurations.

All medians below are complete-call microseconds from one locked alternating three-pair cohort. 2/4-byte fixtures include outer quotes so the entire long token is consumed; token_characters is the count in the table. Every timed native call has exact route counters and zero fallback.

| Token characters | Storage | CPython us | Boxed AOT us | Borrowed AOT us |
|---:|---|---:|---:|---:|
|20|1byte|6.5422|8.7291|3.9190|
|20|2byte|5.1935|6.9819|3.4279|
|20|4byte|4.4248|6.8285|3.0437|
|127|1byte|25.0222|16.2298|3.1666|
|127|2byte|20.0852|22.2056|4.1232|
|127|4byte|26.8300|25.8022|4.5966|
|4096|1byte|1067.4200|659.9550|10.0850|
|4096|2byte|1126.9200|824.8650|15.2200|
|4096|4byte|1165.3900|940.2300|11.0400|
|65536|1byte|39633.7500|32076.6000|116.4500|
|65536|2byte|57097.9500|54069.3000|156.0000|
|65536|4byte|87047.1000|85951.2500|125.3000|

Decision: str shares the bytes pinned-span mechanism: exact-type/context entry guards, a strong owner for data lifetime, data/length plus Unicode kind, checked reads and one result construction. Reuse installed Numba Unicode model/storage and borrowed views where they meet these contracts, with explicit selected-owner provenance; ordinary Unicode boxing alone loses selected identity. No second backend. New scan/result-builder lowering must be generated from ordinary source, not copied from this hand-written ceiling.

At20 and127 characters borrowed AOT wins for all three storage kinds; there is no observed crossing among the measured sizes. Inputs below20 are unmeasured, and no product profitability gate was changed. Boxed AOT is slower than CPython for all20-character cases and the127-character two-byte case. At65,536 four-byte characters boxed and CPython are descriptively close; no neutrality or gain is claimed for that route.

Attribution: boxed retains StringIO.read and repeated Unicode concatenation while moving state control into C. Borrowed removes the private lexer/StringIO/state and repeated result allocations in addition to native character access, so its large gain is a combined complete-wrapper ceiling, not a pure load bound or evidence the product already performs scalar replacement.

Behavior acceptance: sealed character-behavior-v3 has4080 identical exact-type/value/input-and-cached-character-alias/exception-argument-owner gates across C/JIT/AOT,126 dependency/callback/observer guard misses,6 success/error input/output/message-owner refcount groups, and fresh AOT without Numba with native counters(6,6,0). The same independent review is in REVIEW.md. It found actual configuration/import/AOT-deserialization/spec failures, all retained as failed attempts and fixed before this bound. Single-character input alias suspicion produced no mismatch, and no speculative alias rewrite was applied.

Trusted installed-stdlib/GIL diagnostic context only: no PEP669 global/relevant local events, no importtime instrumentation, nominal trace/profile off (active trace/profile delegates). Cached import omission requires exact descriptor-free non-initializing spec and the finite bootstrap path/bindings. Allocator-failure injection, ambient cyclic-finalizer scheduling, asynchronous signals, free-threading and subinterpreters are outside this diagnostic proof. These exclusions are not product soundness claims.

Evidence: three-pairs-v1.json retains every individual sample/counter and links the complete behavior seal; matrix/logs/character-loop-three-pairs-v1.* records audited lock/exit0; character-behavior-v3/input-seal.json and complete.json bind copied source, managed model, toolchain flags/interpreter and actual artifacts before/after. Timing also verifies the accepted installed shlex source before/after. Only complete v3 artifacts were timed; incomplete/failed attempts were never reused.

This diagnostic converts0 production rows, adds0 held-out native functions and deploys0 product functions. The next actual capability is the native Unicode scalar-method/result-owner slice, with a separate DESIGN, fail-first product tests and coverage gates.
