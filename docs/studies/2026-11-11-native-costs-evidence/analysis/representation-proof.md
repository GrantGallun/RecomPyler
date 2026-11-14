# Representation and region-boundary proof design

Read-only analysis against integration `0aeb157e8d272e0b1d4787a173f5b66f75d81b01`. No product edits, compilation, benchmarks or new timing claims. Inputs inspected: current `heap.py`, frozen Wave5 Barnes driver/C source, actual-AOT/C instruction reports, phase payloads, and repository tool documentation. Numeric specialization is a separate investigation; this note addresses representation, lifetime and region boundaries.

## What the 5.21x comparison measures

`47.4893 / 9.1083 = approximately 5.21` compares median-of-five fresh-process best-inner observations. The Python/RP side performs **100 separately entered `advance_system` regions and then Python final-energy calculation**. The C side performs 100 C advances, explicitly frees each tree, then computes final energy in C. Setup and initial energy are outside both kernel timers. RP has five inner reset states per process; C has twenty. Whole-process deployment is a different measurement.

The separate instrumented candidate diagnostic reports medians of 27.4435 ms native-extension entry, 9.4542 ms load, 3.2936 ms write-back, 0.7541 ms guards, 4.2549 ms other attempt work and 2.5547 ms final Python energy. Its whole kernel is 48.0503 ms. These independently chosen medians are **not an exact additive partition**, and none is an uninstrumented subcomponent measurement of the 47.4893 ms observation.

Load plus write-back is approximately 12.75 ms in that diagnostic. This identifies a substantial boundary cost worth attacking; subtracting it from the headline kernel does not predict the speed of a fused implementation. Native entry alone is approximately 3.01 times the entire C kernel, but that ratio has different boundaries and instrumentation. It cannot establish a native-only compiler penalty. C build/force/update/energy/free components have not been separately measured here. RP native build/force/update/allocation/check costs have not been separated either.

Actual assembly proves remaining handle chains, mixed tags, status/recursion bookkeeping and list normalization. It supplies no dynamic call count, cache-miss count or cycle attribution for those mechanisms. In particular, 632 versus 116 static force instructions does not mean a 5.45x force-time tax. Layout and numeric/ABI effects interact and must be isolated experimentally.

There is also a confirmed CPU-target mismatch: vendored `src/recompyler/_pycc/cc.py:76` defaults `_target_cpu` to the empty string, and `heap.py:6892` creates CC without overriding it. The installed Numba `AOTCPUCodegen` (`C:/Users/grant/AppData/Roaming/Python/Python314/site-packages/numba/core/codegen.py:1333–1358`) uses the generic architecture model by default and empty explicit features; `cpu_name='host'` selects the host model. The C reference was compiled with `-march=native`. Its contribution to the measured gap is unmeasured, so the residual cannot all be attributed to Python constraints/layout. Changing production targeting requires CPU-feature-aware artifact identity and runtime compatibility guards; this note does not authorize that change or request another timing cohort. See `cpu-target.md`.

## Matching work before interpreting causes

Both implementations retain the same 200-particle, 100-step, theta=0.5, dt=0.1 algorithm, child order NE/NW/SE/SW, containment tests, force accumulation order, softening and energy pair order. The existing unusual parent-mass behavior is retained: update mass when inserting into a leaf with capacity, redistribute on subdivision, and do not repair parent mass during later descendant insertion. A faster experiment that changes this is not the same algorithm.

C representation is intentionally more specialized: each particle is seven adjacent doubles, each node holds rectangle/center doubles inline, four particle indices inline and four child pointers. Python has separate Particle/Point/Rectangle/QuadTree objects and growable lists. C fixes capacity four. The RP arena avoids constructing transient Python objects, so there is already some elimination of Python allocation machinery; it still allocates/addresses separate logical heap blocks. C uses calloc/free per tree. RP bumps an arena cursor and discards its transient tail on the next region attempt. These lifetime policies are different, and physical allocator-call counts should not be forced to match when allocation elimination is the treatment.

Before a causal performance claim, collect separate diagnostic logical counts (node creations, insertion attempts including failed child containment, force visits, approximations, direct leaf visits, pair interactions, allocations/bytes, arena high-water mark and retries). Logical algorithm counts should match. Allocation count differences should be reported as the intended representation treatment. Keep those instrumented diagnostics separate from ordinary timing. Match arithmetic grouping and output/state, not merely the final three scalar checks: compare per-step particle coordinates, velocity, acceleration, mass, their Python types/signed zeros, and input alias identities in correctness-only runs.

## Smallest useful experiment: bounded region grouping

Use a **task-local counterfactual driver**, not a compiler rewrite or a claimed automatic optimization. Add a plain helper that calls the unchanged `advance_system` in a loop of a supplied small count; select that helper as a region. Keep total work exactly 100 advances and final energy outside the helper. Start with group sizes 1, 2 and 4 (all divide 100); compare to the unchanged 100-entry driver. Group size 1 is essential: it controls for changed call graph, guards, generated digest and native lowering introduced by the wrapper itself.

Use fresh state for every inner observation, fresh actual AOT exports for every version, unchanged C reference, rotating order, full output and actual mode counters. Record arena high-water, growth/retry/fallback and peak allocation demand in separate diagnostics. Stop increasing the group size if it adds retries or substantial transient retention. Do not use `--force` as proof the path remains AOT; audit actual entries. Compile/build costs remain outside ordinary warm timing and are reported separately.

This tests whether amortizing packing/commit helps enough to merit compiler machinery. It does **not** isolate boundary overhead perfectly: a larger region also changes specialization, inlining, numeric type joins and memory footprint. Audit assembly/generated representations for those differences. A manual flattening of the C/Python model likewise remains a representation counterfactual, not evidence of an already sound Python compiler optimization.

Why not start with one 100-step region: `alloc` at `heap.py:1713` only bumps `top[0]`. `Region.attempt` at `heap.py:6645` resets the cursor to the loaded input boundary before a native attempt; generated helper calls do not reset it. Thus a naive fused loop retains every step's otherwise dead tree until the outer attempt finishes. It can hit capacity, repeat the entire grouped work after growth, alter cache locality, or reach MAX_SLOTS and fall back. A speed result without this accounting is ambiguous.

## Smallest generalizable lifetime optimization

**A checked scratch-arena scope around a compiled helper whose newly allocated objects provably cannot survive that helper's successful return.** This is a narrower precursor to arbitrary object flattening or automatic loop fusion. It is useful for builders, parsers and simulations with temporary graphs, not just Barnes.

For an eligible helper call, save `mark = top[0]` before entry and restore `top[0] = mark` only after its successful return/status check. Objects allocated before `mark` keep their existing handles and updated scalar contents. Allocations at or after `mark` are dead. Do not reset recursion/status bookkeeping. On a failure/status exit use the existing region rollback/retry/fallback path; the scratch optimization must not turn a failure into success.

The proof obligation is **no live handle to the reclaimed tail**, not merely “returns None.” Require a conservative transitive summary showing:

1. Returned values contain no fresh handle, recursively through tuples/containers/views. Start with `None` or non-handle scalar returns only.
2. Stores into memory reachable from incoming arguments, globals, caller-owned private objects, or older containers cannot install any fresh handle. This includes list data-pointer growth, newly allocated tuple payloads and ndarray/view descriptors. Scalar field updates are allowed and retained.
3. Fresh objects may hold references to old input particles, or to other fresh objects. The reverse direction is forbidden. Aliased destinations are treated as old/escaping unless proved otherwise. If origin or a transitive store summary is unknown, decline the optimization.
4. All callees in the summary are closed compiled code under existing binding/code guards. Exclude callbacks, generators/coroutines, observable finalizers/weak-reference behavior, escaping closures and unsupported external effects from the initial scope. A changed class method or constructor must invalidate the proof through guards/digest/seed identity.
5. Every success exit has the proof; conditional escapes cause a conservative rejection initially. Recursive summary components reach a conservative fixed point. Reclaim only after the whole eligible helper returns, not arbitrary recursive frames whose descendants may still be reachable by the caller.

Barnes `advance_system` is a promising candidate: it returns None, the fresh tree references input particles, while surviving particle position/velocity/acceleration fields receive numeric values rather than references to the fresh tree. This is a **source-level hypothesis**, not a completed compiler proof. The same `Point` family is used for private centers and external particle fields, so class-wide “Point is private” reasoning is invalid. Need value/allocation-origin and destination reachability information, or conservatively reject ambiguous type joins.

Existing `_ESCAPES`/`_init_assigned` (`heap.py:1406`) is only a constructor-initialization safety analysis. It records whether an incompletely initialized receiver was stored elsewhere; it does not prove lifetime escape freedom. `floats_unseen` and `written_set` also are not such proofs: they track observable numeric kinds and class-family writes, not whether a particular allocation becomes reachable from an older root. Reusing these as a lifetime certificate would be unsound.

First correctness cases: nonescaping temporary linked structures; a fresh object returned; fresh object stored into an input object/list/global; append-induced data-buffer replacement in an older list; borrowed old alias returned/stored; two incoming aliases to one object; exception/overflow on a later grouped iteration; allocation exhaustion/retry; recursion limit; changed binding; transient and persistent instances of the same class. The proof must reject escaping variants and preserve exactly-once effects on bailout.

This pass alone mainly bounds transient retention inside larger regions; it need not improve the existing one-step entry. Report it as enabling safe region grouping, not a predicted direct reduction of the 5.21x ratio.

## Next representation step, after lifetime facts

Select **one fresh private leaf allocation** for scalar replacement or embedding, such as a QuadTree's private Rectangle boundary. It is read by contains/subdivide/force; the original code creates it per node and does not change its fields after initialization. Its lack of escape must be proved through all constructor/call aliases. Preserve value evaluation order and exceptions; reject identity comparisons, exposed aliases, dynamic hooks or independently escaping fields in the first version. Keep all numeric kinds/checks unchanged so this isolates indirection/storage rather than overlapping the numeric agent's work.

An allocation-origin-specific layout is necessary. `_Program.layout` (`heap.py:658`) is currently class-family-wide, while inputs and private instances can share a family. Do not globally flatten Point or change input object layout based on the private center case. If values are later materialized or escape, the initial pass should fall back to the normal layout, rather than invent a partial deoptimization system.

Inlining the four-element particle list is a larger follow-up: prove capacity/bounds and absence of list identity/alias/rebinding observations, preserve the old list when `self.particles = []` rebinds a field, and distinguish physical reservation from semantic length. Profiling a maximum length of four is not a proof. C's fixed CAPACITY is not authority to make every Python list fixed length.

## Larger regions and hoisted checks require a separate proof

Automatically group adjacent calls only when no Python observation/effect can occur between them. Intermediate aliases held by the caller, callbacks, mutation of global bindings, asynchronous suspension, exceptions and zero-copy array writes are all barriers. If a later iteration fails, the outer fallback must reproduce earlier visible effects exactly once. The existing all-or-nothing private heap rollback can support this for a closed grouped helper, but it does not authorize arbitrary call-sequence fusion or skipping per-call binding/guard checks without closed-world effect facts.

For the manual Barnes helper, holding Python aliases outside the helper is not itself an observation during the helper, but the final alias identities/state still must be preserved. Error cases must compare Python's partially progressed state. Exclude external callbacks and writable NumPy buffers from an initial automatic grouping pass unless their rollback behavior is explicitly proven.

Loop-invariant handle loads/checks can be hoisted only with alias-aware memory effects: a stable receiver handle does not prove a child field or list data buffer stays unchanged. Recursive calls and appends can invalidate facts. Same-kind F/I arrays share storage; `noalias` on these views is unsound. Use narrow validity ranges, then verify whether LLVM already removed the candidate load/check before implementing an extra pass.

## Measurement decision gates

- First ask the causal study for native build/force/update and C advance/final-energy/lifetime boundaries; do not infer these from assembly. Use whole-kernel evidence for final user impact.
- Run the 1/2/4 grouping counterfactual only under the coordinator's exclusive slot and preserve mode/arena diagnostics. A flat or negative result is useful and should stop boundary work from displacing a larger native opportunity.
- If grouping helps but memory grows, implement/review the conservative scratch proof before pursuing large groups. If representation remains attractive after numeric specialization, isolate one private Rectangle treatment and retain original source outputs/types/identities.
- Use `tools/dev_inspect.py` for lossless source/assembly diffs, actual artifact disassembly and labelled diagnostic phases. Its artifact-kind label is supplied by the caller; retain separate audited digest/export/path proof. Rebuild actual AOT artifacts for transformed source; do not compare stale caches. Use `c` provenance to preserve the unchanged reference and keep all new evidence separate from Wave5.

No numerical speedup forecast is justified yet. The concrete opportunity is to remove *proved unobservable* representation and boundary work while leaving visible behavior, algorithm and failure semantics intact; the unresolved question is which removed work contributes most on the actual execution path.
