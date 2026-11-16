# Direct access design (proposed; implementation follows Step 0 and BOUND)

## Intent and approach
Read live exact numeric boxes rather than copying their payloads into F/I; preserve existing logical handles, aliases, arena temporaries, range proofs and scalar replacement. Private graph copying remains the fallback. Compared alternatives: replacing the backend with a C AST compiler would duplicate the compiler and lose established coverage; naked PyObject addresses embedded in Numba output would break AOT/lifetime rules. A parallel per-call live-location table with a callback-free native envelope keeps the current compiler and makes ownership explicit.

## Stage 2: read-only locations first
The transitive effect certificate records writes by canonical object family/field and list cell, topology changes, RNG/arrays, native callbacks, recursion, allocations and output materialization. An input numeric location may be live only when the region cannot store to that location through any alias. Whole read-only regions must work. All remaining locations retain the existing arena path.

Offsets and ABI facts are produced by C built against the installed Python headers and included in source/cache identities. Exact float, bounded PyLong (including non-compact int64), bool, supported ordinary records and fixed-storage exact lists are allowed. Strong pins retain owners and borrowed references for the whole native entry. No fabricated noalias metadata: F and I remain two views of one arena.

Emit numeric-access helpers after scalar replacement, preserving its recognizers. Each helper chooses a live numeric location or the existing arena slot; MIXED payload and tag derive from the same exact box. Audit all raw runtime accesses, slicing/copy helpers and list operations, not only _Gen.slot/store. No reboxing of returned existing inputs; preserve _Unloader.made's original identity map.

Guard exact classes, ordinary attribute access, native slot descriptors, field presence/shape, list storage/length, numeric domains, callable/global identities and alias contracts. Read managed-inline, split and combined storage without materializing nested dictionaries during preparation; the final allocation-free C walk establishes fresh locations. Decline on free-threaded builds and observers capable of executing Python inside the native interval. Pinning does not establish storage stability; topology-changing effects on mapped owners defeat the rule. Class mutation, list resize, aliased locations and late type changes are explicit fail-first cases.

## Stage 3: journaled numeric stores
A C execution envelope performs final validation, enters native work, and commits or restores BEFORE returning to Python. Region.attempt calling program.run and later rolling back in Python is unsound: return permits signals/tracing and result boxing can run GC. Runtime helper pointers belong in per-call context, never persisted process addresses. A raw fixed-ABI adapter/capsule is preferred; direct invocation of an exact AOT C wrapper is an alternative only with a callback-free wrapper proof. JIT must use the same safety envelope or retain arena fallback.

A typed journal is keyed by physical location, canonical across aliases. Allocate capacity and the exact numeric box before publication; keep original references until commit. MIXED stores publish one value/tag atomically. Restore in reverse order for overflow, bounds, native exception, allocation failure, recursion exit and arena growth. No Python replay starts with any live speculative store remaining.

Reject dict watchers, unsupported descriptors/access hooks, topology mutations of mapped owners, finalizer/weakref effects, and observation-capable allocation. Numeric allocations are untracked and cannot trigger GC. None/numeric/existing-input returns can finish inside the envelope; new tracked returned graphs require safe pre-materialization or an arena decision BEFORE stores. The fallback decision itself must not defer a missing safety proof until rollback.

## Fail-first and review gates
Tests: pure reader; aliased field/list paths; int64 extremes and 2**53+1; float signed zero/NaN; float-to-int MIXED reset; changed descriptor/class layout after preparation; list resize; observer/free-threaded decline; identity returns; all five partial-store failure modes; finalizer/weakref/dict watcher non-observation; scalar replacement still fires. Independent guard/journal review precedes timing. Whole-call and trivial-call timing, achieved/bound, and unmodified deployment gates decide acceptance, never native-only gain.

## Fixed costs and output work
Separate effect proofs remove unused recursion scans, RNG export, input unloader walks and arena/control initialization. Cache prepared programs only with exact dependency/source/ABI identity and live guards. transform_point's 441 us mean preparation is first-use contextual lookup, not steady dispatch. create_gc_cycles has no copied input graph and about 9 ms materialization; direct input loads alone do not address it. Design direct native materialization/bulk output conversion and retention/GC semantics explicitly, and measure that mechanism.
