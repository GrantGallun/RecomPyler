# Wave 10 fixed numeric-mode and coverage measurement protocol

Status at protocol freeze: design and metadata preparation only. No mode workload, test, profile,
Numba import, compiler build or timing has been run for this study. Execution
requires the coordinator's exclusive CPU grant. This directory is new evidence;
all prior studies, helpers, result sets and source freezes remain immutable.

## Questions and populations

1. Against the current strict compiler at
   `1d4084f914fa9594ecb801e3efa565edcd7e1241`, does an explicit checked interval
   contract remove only certified integer overflow checks? What entry guards and
   complete-call costs remain?
2. Does opt-in `unchecked-int64` emit defined wrapping arithmetic while retaining
   exact-int/int64 representation guards? Does it agree with Python on the fixed
   valid-contract population and an independent modular oracle outside it?
3. How do those actual variants compare with the original CPython function and
   matching C arithmetic, including both complete Python calls and separately
   labelled repeated native-call loops?
4. On a separately fixed general-Python population selected with the coverage
   implementer, what changes in default/native eligibility, successful actual
   execution, output and state? Numeric-mode force selection is not default
   coverage evidence.

The straight-line numeric population is three source-backed functions with exactly
1, 16 and 64 unrolled recurrence steps, each step `t = t * y + z`, starting from
`t = x`. This is straight-line code, not a compiled counted-loop claim. Inputs
are runtime scalars with exact `int` type: x,z in [-2**20, 2**20], y in [-1,1].
The sound interval after k steps is within +/-(k+1)*2**20. Each intermediate is
representable and each valid result has Python's exact int type. A one-step
function exposes boundary cost; 16/64 steps test amortization with a larger
supported body. Inspect selected assembly to detect algebraic collapse and
report the resulting instruction body honestly.

The coordinator additionally requested a bounded counted-loop pilot. If the
implementation admits it with a sound per-iteration proof, include a fourth
source-backed Fibonacci function: `a,b=0,1; for i in range(n): a,b=b,a+b; return a`,
contract n in [0,80], fixed valid corpus containing all 81 integers in that range.
The runtime loop must remain a runtime loop; capture the selected code to verify
it. Its proof covers every intermediate, including the extra b value. If support
does not ship, preserve the unavailable row with its reason. An unchecked
operational loop cap, if implemented, is a retained safety guard and part of its
semantics, not a documentary interval. Freeze its exact rule before auditing.

A fifth fixed kernel, `loop_recurrence16(x,y,z,n)`, retains one runtime
`for i in range(n)` with sixteen successive `t=t*y+z` steps in its body. The
contract extends the recurrence contract with n in [0,1024]; all intermediates
are within +/-(16*1024+1)*2**20. Its fixed population is the 27 endpoint/zero
triples crossed with n=(0,1,16,256,1024), plus the 257 deterministic random triples
with deterministic n in [0,1024]. This population has 392 inputs. The unchecked
operational cap is `max(0,n)<=1024`, distinct from the tighter document contract.
Before any performance observation, freeze complete repetition count1/native
repetition count8 for this long kernel; the four smaller kernels use8/2048.

Each straight-line function has the same fixed valid corpus: all endpoint/zero combinations
plus 257 deterministic pseudorandom tuples, including all y values. No constant
arguments are specialized into the generated function. Every timed call loads
runtime inputs; a result checksum depends on every return. Corpus and expected
results are frozen before timing. Endpoint/random results are exact, never
float-tolerance comparisons. No out-of-contract result enters the Python-equal
speed table.

Separate semantic audits cover tighter-bound misses still within int64, int64
overflow, INT64_MIN/MAX, huge Python ints, bool, int subclass, float, missing and
unexpected arguments. Checked must replay the original binding/value/type/error
behavior on guard misses. Unchecked representable exact ints must match an
independent per-operation modulo-2**64 oracle; invalid types/representations must
raise its documented contract exception before native execution. These audits
are counts and outcomes, not an averaged performance comparison.

## Fixed variants and boundaries

| Variant | Source | Boundary and semantics |
|---|---|---|
| CPython original | fixed function source | ordinary Python call, arbitrary-precision ints |
| current strict | frozen current `heap.lift_region` | original strict wrapper/guards/replay; actual JIT/AOT/fallback counted |
| candidate strict | same final candidate compiler, `heap.lift_region` | controls shared-internal changes separately from mode policy |
| checked | `experimental.lift_numeric(..., mode="checked", contract=...)` | entry exact-int/tight-range guard, certified exact int64 body, Python replay on misses |
| unchecked | `experimental.lift_numeric(..., mode="unchecked-int64", contract=...)` | entry exact-int/int64 representation guard, defined modulo arithmetic |
| C exact contract-safe | fixed C source, same valid corpus | int64 arithmetic only on proved-safe inputs; explicit Python-side entry guards for complete-call row |
| C defined wrap | fixed C source, separate semantic row | uint64 operations; explicit signed result interpretation, no signed-overflow UB |

C complete-call rows use a Python guard and a foreign-function call. Their
boundary is not the CPython extension/heap wrapper ABI and will be stated in the
report. C arithmetic-only rows do not claim Python arbitrary-precision behavior.
C exact and wrap are not pooled. Use the same generic x86-64 target for primary
C and RP comparison; an optional host-tuned C diagnostic is a separate row.

Complete-call timing includes argument binding, policy guards, packing,
dispatch, native invocation, conversion and result checksum in the same Python
loop. It excludes preparation/compilation, which are reported separately. Do
not subtract an independently measured loop median from another median.

Native-batched timing, where supported, is a distinct C-driven repeated-call
loop around the actual selected native entry, using runtime input arrays and
all-return checksums. An RP cfunc adapter must call the actual selected dispatcher
or ABI entry, without reimplementing/recompiling the arithmetic as a surrogate.
Its generated source/LLVM/ASM and target linkage are captured. If this cannot be
done with a stable exposed ABI, mark RP native batching unavailable; do not label
Python repeated wrapper calls as native batching. C kernels and batch caller are
separate translation units, no LTO, so the caller cannot hoist/fold pure calls.
The native batch loop overhead is included, and call/iteration counts are
retained. A C-native-only arithmetic table cannot be used as a complete-call
speedup claim.

## Preparation, process schedule and provenance

Preparation is separate from measurement. Freeze source, helper, corpus,
runtime binary and compiler identities into a new manifest. Record exact Python
3.14 executable, relevant DLL/package versions, Clang command/version/hash,
LLVM disassembler command/version/hash, CPU/target flags, closed environment
allowlist, function qualname/source/bytecode digest, mode/policy/proof versions,
canonical contract, generated source and program digest, cache paths and selected
native export/binary hash. Freeze both current and candidate source trees before
building. Source snapshots copy only from authorized isolated trees.

Each construction/first call records wall time and actual counters before and
after; it is never mixed into a warm call median. Experimental AOT is absent
unless a mode-tagged loader/manifest actually exists. Report absent AOT as absent,
not zero-cost AOT. JIT and disk-cache fresh-process reuse are different modes.
The candidate supplies explicit `build_numeric`/`load_numeric` AOT APIs. Build
mode-tagged AOT and current/candidate strict AOT during preparation, then use
actual AOT for primary complete-call rows, with no Numba imported in fresh replay
children. Native batch is separately labelled JIT-dispatcher plus compiled
adapter when an actual AOT-native callable ABI is unavailable.

Native batches use a separate cold JIT cache for every child so the actual
selected target and linked adapter LLVM/ASM are available for inspection.
Compilation/adapter costs are retained outside native call samples. LLVM may
inline selected JIT code into the adapter; capture physical-call retention
explicitly and label C-loop counts as adapter invocations, never AOT or Region
counter calls. Cold prepare cells capture original selected LLVM; later cached
audit/build cells record metadata without claiming unavailable cached LLVM.

After semantic/dispatch preflight, use seven independent rotating rounds. Each
cell launches a fresh process; the round order is cyclic over the predeclared
variant list and reverses on odd rounds. Each child warms the selected artifact,
records counters, then times three fixed corpus passes (each pass repeats the
same predetermined iteration count). Preserve all three samples; the child
median and the median/range across children are descriptive. The repetition
counts above are fixed analytically before any execution or performance
observation; no adaptive calibration selects later samples. No cherry-picking
or historical pooling.

Separate fresh children use the same frozen persistent cache to audit reuse.
Record whether Numba was imported, whether compilation ran, loaded cache files
and actual JIT/AOT/fallback/reject counts. A JIT dispatcher loaded from disk is
still JIT execution, not AOT. Reject timing cells with unexpected native misses;
retain failures as raw evidence and state exclusions explicitly.

Every process writes raw stdout/stderr, exit status, process wall time, command,
input manifest hash, work/dispatch counts, exact checksum/outcomes and phase
timings. The controller measures complete process wall separately. A result
record is append-only; reruns use a new cohort path, never overwrite a record.

## Selected-code and check inventory

Bind wrapper -> actual program digest -> selected dispatcher/export/signature ->
LLVM symbol/call chain -> assembly body; capture all raw files/hashes. Do not
inspect a nearby symbol or a fresh surrogate specialization. For each variant
count static emitted sites and retained entry sites separately:

* integer add/sub/multiply overflow helper calls and their status branches;
* multiply floating estimate/exactness checks and actual overflow intrinsics;
* mandatory exact input type and signed-int64 representation guards;
* checked tight interval guards and Python replay exits;
* remaining native status/exception checks and wrapper conversion work;
* unchecked arithmetic op flags (`nsw`/`nuw` must not promise absent overflow).

Map each certified source operation to its generated body where optimization
permits; include optimized-away operations rather than inventing one-to-one
assembly counts. Retained Python guard counts are source/call-path counts, not
native instruction counts. Static counts are not dynamic instruction totals or
cycle attribution. Unchecked changes no memory, container, recursion, float or
alias semantics. No claims about their costs can follow from this integer pilot.

## Coverage cohort

Before any coverage run, freeze canary names, source, inputs, expected stdout,
return/error outcomes, full relevant mutable-state/alias snapshots and call
counts with the coverage implementer. Run matched current/candidate source with
ordinary strict/default entry behavior and a CPython reference. Keep explicit
native canaries separate from default deployment. Count actual AOT/JIT/fallback,
reject and unknown calls; a verified profile sample is not deployed native
coverage. Preserve unsupported cases in the fixed denominator. If the full
49-program population is not rerun, state that limitation and report only the
new fixed canaries. Do not relabel saved a9b/037 historical coverage as new data.

## Completion gates

- Fixed source identities and corpus validated before timing freeze.
- Every valid result/type and separate invalid semantic audit passes.
- Actual dispatch counters reconcile with attempted/success/rejected calls.
- Fresh-process cache reuse tested and accurately labelled.
- Every timing cell/raw stream/checksum/manifest hash independently verifiable.
- Actual bound LLVM/ASM supports each check-removal claim.
- Report complete-call, native-batched, preparation and process wall separately.
- Preserve regressions, unavailable cells and uncertainty; no universal coverage
  or near-C claim from a restricted scalar pilot.
