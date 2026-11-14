# Independent review of inline-helper context follow-up

Verdict: **no actionable production blocker found** in 0373788b7be436e5e43b0a6a6f3fd40b2871c3a3, based on frozen 57835fa8a89d0d846e291abc7f9f6f335aa272a8. Clear for the planned new full-suite freeze and fresh performance/actual-AOT validation. This is not a finding that the measured raytrace regression has been removed.

Reviewed the complete 25-line product diff, modified compact tests, new inline-context tests and retained focused run. No tests, numerical imports, compiler, build, profiler or workload were executed by this reviewer. Older candidates and results were left untouched.

## Identity and observed validation

The current isolated candidate is clean at 0373788b7be436e5e43b0a6a6f3fd40b2871c3a3. Product heap.py SHA256 is 7904ae104331ea666cdcf0b577900771d2b2530f9b3ad28670480ef9e78c40b4. Compact tests are 464171cddf641413d294588646b71a9d02bc95ca0e1796abfda4b6df384c3c88; new inline tests are d36e5664082018b6d491f2fcf3078c28cc6c7950874bb204aaa32de304bc7e01.

The latest `focused-green-real-entry` run completed: **120 passed, 14 subtests passed in 44.35s**, exit 0. The wrapper elapsed value is separately 46.5319s. Independently checked all 61 before/after inputs against current bytes: no mismatch. Raw stdout SHA256 8c57c8cb8312b228cd8d97a9822b3e5d023555535e38ab63f964400e24e00c58 and empty stderr hash match the receipt. The argv covers inline context, compact ABI, iteration, header, alias-contract, zero-fact and recursive disk-cache cases. Machine receipt: inline-focused-verification.json.

Earlier logs preserve five initial RED failures on 578 and the first GREEN attempt's single incorrect fixture assumption (117 passed plus 14 subtests; assumed initial even_walk entry itself was an inline SCC wrapper). The source controls were corrected without altering production inline eligibility. That initial mistaken fixture is not evidence of a product regression. The added real SCC-member entry fixture now has a passing observed run.

## Production reasoning

All following product line references are in wave9-inline-context-fix/src/recompyler/heap.py.

- At 1673-1674 the map is computed from each original generated source before rewriting and uses the exact `_INLINED + newline + def` prefix. It does not infer eligibility from function size or absence of self recursion. Existing `_Gen.generate` eligibility at 5977 and merged-wrapper decorators are unchanged.
- Call rewriting at 1676-1683 selects the **callee's** context list before renaming the callee. Definition rewriting at 1691-1696 uses that same map. Therefore inline-to-inline, narrow-to-inline, inline-to-narrow and SCC-wrapper-to-dispatcher edges agree about argument order. Unknown runtime helpers are outside the map and keep their previous interfaces.
- Every rewritten function still receives `_heap_ctx`. Inline-marked functions receive the five raw values additionally and reconstruct views without unpacking the descriptor. Other functions unpack once and then reconstruct views. Consequently all known generated callers have the raw values in scope regardless of their own marker. Semantic operands retain the unchanged suffix after replacing the first four original heap operands.
- Public validation at 1707-1712 is unchanged. Raw pointer extraction and length conversion at 1713-1717 occur once and in their original evaluation order after validation. A single pack remains at 1718. The public call at 1719 selects its borrowed entry's marker; an inline SCC wrapper receives all six leading values, while an ordinary entry remains narrow.
- The descriptor type, intrinsics, array-owner lifetime, status retry and exception paths are unchanged. The forwarded raw values are addresses and a length valid for the same synchronous attempt; they are not cached object fields or list contents. Body mutations still hit the aliased F/I/top/st memory. Growth still unwinds before replacing storage. No new alias, readonly, invariant or effect promise was introduced.
- Full generated source and product-source hashes remain part of cache/AOT identity. Decorator spelling is preserved; `_plain` still removes inline hints only after the interface classification. Wider helper signatures on JIT/profiling are a documented cost tradeoff. AOT always-inlining can expose these existing scalar values to optimization without changing the semantics if a helper is not ultimately inlined: its wider ordinary call still has matching operands.

No escaping pointer, stale retry address, signature mismatch, uninitialized leading argument or new cache/linkage assumption was found in this diff.

## Test validity and limits

The source tests inspect marker-selected definitions and all known generated call edges, including a nested helper graph with recursive work, SCC member wrappers/dispatcher, ordinary entry and a deliberately noninline large body. The public-entry control is supplied both synthetically and by promoting an already typed real SCC member in a test program. The latter recompiles the real generated bodies and executes through Region; it checks output, mutation, reused program identity, two compiled calls and zero fallback. It exercises the intended branch without changing product classification or claiming that ordinary root entry construction necessarily selects that branch.

The native helper test checks five CPointer parameters (descriptor plus four payload pointers), int64 length, and no descriptor loads in the widened helper, while recursive/ordinary bodies remain narrow. The AOT-style fixture uses `_inlined_entry` and compiles its unmodified decorated source; it checks actual state/result and at most five descriptor-origin loads in the selected outlined body. Its counter follows GEP/bitcast-derived descriptor addresses and intentionally stops at loaded arena pointers. This matches the reported fixture's mechanism and avoids counting payload loads as descriptor loads. It is still a bounded IR assertion, not a universal dataflow proof or a selected-workload measurement.

The retained existing focused modules continue covering dtypes, aliases, mutation/rebinding, growth, depth, rollback, AOT and disk reuse. Passing these tests supports the changed representation on tested cases. The previous full-suite result belongs to 578, not this new source. A new full-suite receipt is required before calling the new candidate fully validated.

The measured motivation is credible evidence to test this change, but this review did not independently recompute the prior timing cohort. Fresh actual ray render/SCC descriptor reads, instructions/spills/frame costs, Barnes recursive slot count, profile/startup costs and saved/candidate/C timings remain required. Do not infer a speedup or a resolved raytrace regression from the focused pass or the fixture's descriptor-load bound.
