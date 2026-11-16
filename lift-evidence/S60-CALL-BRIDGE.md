# Experimental managed call backend

`recompyler.heap.lift_calls(function)` compiles supported control flow and keeps
application values as CPython objects through the canonical
`recompyler._managed_native` ownership ABI. This is an experimental explicit
entry, also available through `heap.lift_region(function, backend='managed')`.
The ordinary profile/run profitability selector does not select it yet.
It makes no speed claim and does not change the default numeric backend.

The initial slice supports local assignment, return, ordinary positional and
named keyword calls, attribute/subscript reads, tuple/list construction and
iteration. Formatted strings use the CPython conversion/format protocols, including
exact string-subclass owners and dynamic specifications. Shared small-integer
operation facts use the S49 numeric-identity exemption. Unsupported syntax is declined before entry; runtime exceptions leave
through native cleanup and propagate without replay. Every name/callee is read
from the current original namespace at the point CPython evaluates it. There is
no copied mutable heap to become stale during a callback.

Counters are separate: `compiled_calls` counts entered compiled control flow,
`managed_calls` counts executed source call expressions (including calls that
raise), and `fallback_calls` counts whole original-function executions. Runtime
helpers and CPython object operations are managed runtime work, not fully native
arithmetic. `problem` explains construction refusal.

Real unchanged internal regressions are `heap._source_digest`,
`scalar.parse_expr` and `numeric_versions.parse`. Further tests cover inspection,
generated compile/exec, Numba compilation and LLVM object results.

Sibling frontends extend `_Compiler` through `CallRegion.compiler_type`, sharing
all call lowering and entry/no-replay accounting. Wave16 owns compiler structures
and control-flow additions; wave17 owns canonical reference ownership and AST
object machinery. Shared requests are published in the root provenance corpus.

Functions with inherited future compiler flags currently decline before entry;
generated compile/eval/exec therefore keep the original interpreter context.
