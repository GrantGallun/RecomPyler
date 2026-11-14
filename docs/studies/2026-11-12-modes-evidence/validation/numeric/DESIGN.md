# Experimental numeric pilot, wave 10

Base: integration commit `1d4084f914fa9594ecb801e3efa565edcd7e1241`.
Working checkout: `wave10-modes`, branch `codex/wave10-numeric-modes`.
The copied native guard extension has SHA256
`17e2e43e8825188a9e4339586b47fcc712d81a13ef90874cf869cac099dd16e0`.

## Public API

`recompyler.experimental.IntIntervals(**parameter_bounds)` is an immutable,
canonical mapping from every function parameter to inclusive exact-int int64
bounds. Bool bounds, malformed/reversed/out-of-representation intervals and
missing/extra parameter names are configuration errors.

`lift_numeric(fn, mode="strict", contract=None)` returns the current ordinary
`heap.Region` in default strict mode, with all its existing eligibility and
fallback behavior. The pilot grammar applies only to explicit `checked` and
`unchecked-int64` requests, which require an `IntIntervals` contract.

`UnsupportedNumericRegion` derives from the compiler's `Unsupported`. It names
an unsupported grammar or an unprovable checked specialization at construction.
This never reclassifies a Python call as a successful native call.
`NumericContractError(ValueError)` identifies unchecked type/representation or
operational loop-cap failures before native execution.

Checked calls bind exactly, then guard exact `int` type and inclusive contract
bounds. Misses replay the original function with the original arguments.
Unchecked calls require exact Python `int` parameters in signed int64, then
execute every admitted arithmetic site modulo 2**64, interpreted as signed int64.
Tight intervals are documentary in unchecked mode. A separate operational guard
limits loop trips to 1024; negative stops produce zero trips as in Python.

## Integrated implementation

New module `src/recompyler/experimental.py` owns contracts, eligibility, immutable
per-operation certificates/policy, the guarded `NumericRegion` wrapper, and
explicit experimental artifact build/load. Existing `_Program`, `_Gen`, loader,
ABI and Region execution remain the compiler and executor.

Small `heap.py` hooks:

* `_Program(entry, numeric_policy=None)` defaults to current strict behavior.
* Policy source/runtime is included in generated source and digest before lookup.
* `_Gen.binop` may discharge only exact INT/INT add/sub/mul sites selected by the
  policy; all other lowering is unchanged.
* `Region._make_program()` defaults to `_Program(self.original)` and is the sole
  new-program construction hook. NumericRegion overrides it, not `program_for`.
* `_signature` appends policy identity only for experimental programs.
* `build_regions` ignores experimental wrappers, preventing strict seed export.

`NumericRegion.attempt`, not only `__call__`, performs binding/entry guards, so
latest-program reuse and direct attempts cannot bypass policy guards. It passes
fully bound positional scalar values to the existing attempt/loader. Changed
function code invalidates an experimental wrapper; checked replays and unchecked
raises. It never patches a strict program's run function.

## Grammar and proof

Plain source-backed functions with fixed positional/keyword-only parameters.
Scalar names, exact integer constants and signed integer literals; binary +,-,*;
single-name and parallel tuple assignments; name-only augmented assignments;
one terminal scalar return. No globals/closures, heap, calls, arbitrary unary
operators, division, branches, recursion, generators, exceptions or mutation.

One nonnested `for i in range(stop)` is admitted. `range` must resolve to the
actual builtin and retains the compiler's existing per-call builtin guard.
Stop is an int literal or an entry parameter never rebound in the prefix or
body. This lets the unchecked operational limit be guarded before execution.
No break/continue/else/return/nested loop is admitted in its body.

Host interval arithmetic uses arbitrary-precision Python ints. Addition sums
matching endpoints, subtraction crosses endpoints, multiplication takes the min
and max of the four products. Every reached intermediate must fit signed int64
before its checked certificate can remove its arithmetic overflow helper.
Parallel assignment evaluates all RHS expressions against the preassignment
environment before rebinding any target.

For stop interval [L,H], enumerate abstract states for at most max(0,H) trips,
with the iteration variable [k,k] at trip k. Analyze the whole body in evaluation
order and union operand/result facts per AST origin across all trips. Join all
possible exit environments for trip counts max(0,L)..max(0,H), including the zero
trip path. Only definitely bound names survive the join. Correlation with the
stop value is deliberately ignored, making bounds conservative. The proof cap
is 1024 trips; reject larger/unknown bounds. The runtime stays a loop in existing
code generation. For unchecked mode eligibility uses the same bounded grammar;
arithmetic needs no no-overflow certificate because its semantics wrap.

Fibonacci fixture: a,b=0,1; for i in range(n): a,b=b,a+b; return a, n in [0,80].
The addition site's union result is [1,F81]=[1,37889062373143906], fitting int64.
At n=93 the intermediate b=F94 overflows, so checked construction is rejected
even though a final-result-only certificate would miss this failure.

## Check-removal table

| Check | Strict | Checked | Unchecked |
| --- | --- | --- | --- |
| exact Python type / int64 representation | current loader | mandatory entry guard | mandatory, reject on miss |
| tight interval entry test | absent | mandatory, Python replay on miss | omitted |
| per-site add_i/sub_i/mul_i + numeric status test | retained | removed only at certified exact-int sites | replaced by explicit wrap intrinsics |
| generic fail/check mechanism | retained | retained | retained |
| loader/code/builtin guards | retained | retained | retained |
| loop operational trip cap | no new cap | contract upper <=1024 | explicit pre-entry <=1024 guard |
| bounds/layout/capacity/recursion checks | retained | retained; those regions excluded | retained; those regions excluded |
| float conversions/magnitude/math/fastmath | existing policy | excluded, unchanged | excluded, unchanged |

Wrapping intrinsics emit LLVM add/sub/mul with empty flags, never nsw/nuw.
Certificate keys include AST span and operation; no string-based check deletion.
Policy identity includes mode, schema/proof version, canonical contract, original
source/bytecode identity, intrinsic implementation, and current native/source
ABI digest. Different contracts or modes do not share source/cache/program keys.

## Evidence sequence

1. RED test draft in `tests/test_experimental_numeric.py`; no product code yet.
2. Root CPU grant, run construction/proof RED tests before implementation.
3. Minimal integrated implementation, source/proof GREEN and native semantics.
4. Explicit tagged AOT manifest/build/load, fresh-process mode mismatch rejection
   and no-Numba replay; no legacy type seed can restore a contract.
5. Selected LLVM/assembly and strict regression evidence; full suite coordinated
   once combined coverage is ready. Measurement agent owns rotating children,
   boundary/native timing and matched C evidence.

Counters expose native contract completions, checked guard misses and unchecked
representation/cap rejections separately from existing jit/aot/fallback counts.
All original evidence is preserved. No global install or push is requested.
