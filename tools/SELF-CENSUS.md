ï»¿# Compiler-source admission census

Run from the workspace root:

    python selfcompile-progress/self_census.py --repo wave18-lift

The versioned implementation is tools/self_census.py in the clone. The root
launcher delegates to it. Default limits are three below-normal worker processes,
30 minutes overall, and 15 minutes per module. This is correctness work and does
not use TIMING.lock. Module workers are separate processes; only those created by
this invocation are stopped on timeout. --module _call_entry.py gives a smoke run;
use --output for smoke output rather than replacing the full census.

The inventory walks original complete-module code objects and joins them to every
FunctionDef, AsyncFunctionDef and Lambda in the source. Methods, nested functions
and lambdas are labelled separately. Generated comprehension/annotation scopes
are not additional source definitions. No defaults, decorators or enclosing
function bodies are evaluated to manufacture nested functions. Ordinary imports
of compiler modules supply globals; import failures and source-only namespaces
are explicit. Missing closure contents are empty real cells and labelled unbound.

Each definition is attempted through heap.lift_structures, then heap.lift_calls,
then managed.lift_managed until one admits it. A wrapper with an unsupported
entry is declined even if its body compiled. The target is never invoked.
Compilation errors and unfinished attempts stay separate from semantic declines.
This is admission only: original runtime closure/default values, entry guards,
execution parity, frame behavior and profitability remain separate checks.

self-census.json contains per-function attempts and the normalized first refusal.
SELF-CENSUS.md ranks those first refusals. Completion counts are explicitly upper
bounds; a fix can expose a later refusal, so none is a proven completion forecast.
The final summary is appended to history.jsonl, and the command is rerun after an
accepted integration. Worker output lives in the clone's lift-evidence/s70-census.

To finish a bounded run without redoing completed attempts, use --resume and
raise --budget-seconds / --module-timeout. Resume requires the same commit and
unchanged tracked source; original code identities are checked before reuse.
S71's complete c6782857 baseline used one resumed 3600-second module budget.

The isolated execution check is:

    python tools/self_host.py --label self-host --timeout 3600 tests

It prepares admitted live functions before replacing any binding and runs pytest
in the same disposable process. Nested functions and decorators without a live
matching binding remain explicitly unavailable. Per-function counters distinguish
compiled execution, whole-function fallback and unexercised replacements. A
subset smoke pass is never evidence that all census admissions execute correctly.

The IR-native S82 check is separate from the legacy managed wrapper above:

    python tools/ir_self_host.py --label s82-self-host tests

It starts a below-normal fresh child with child-only PYTHON_JIT=1 and persistent
per-clone caches. It discovers real live functions, wrappers and descriptor
accessors without substituting function identities. Every body is prepared
before installation. Compiler entry/bridge modules ir.compiler, ir.entry and
ir.symbols are explicitly excluded to avoid bootstrap recursion. Future nested
functions without a live closure are not manufactured or claimed as installed.
Generated annotation functions are additional runtime machinery, outside the
source-definition census, and their refusals are visible separately.

The harness counts actual native entries with an opt-in LLVM counter around each
prepared body. Reports include live/prepared/installed/actually-executed counts,
canonical seed declines, bootstrap exclusions, test results and ranked failure
locations. A passing suite with zero native entries is not self-host acceptance.
Cold eviction or explicit invalidation can reduce the active count during tests;
active_before_tests and active_after_tests make that visible. No candidate here
is measured for deployment. suite_seconds stays null during correctness work;
reported performance comparisons require TIMING.lock.

The runner collects tests before preparation, releases diagnostic IR trees after
code generation, and bounds its working set with --memory-mb (8192 by default).
Before each test it retries valid cold entries. A tracing/monitoring transition
can temporarily prevent CPython from seeding an entry until the next ordinary
application call; this is retried without invoking a target during seeding.
Permanent first-seed declines remain explicit. Matrix failure reports preserve
the full literal row, including internal compiler errors.

CPython stdlib execution comparisons use:

    python tools/stdlib_self_host.py --module json --mode both --label stdlib

Each mode runs in a separate fresh process. Reports compare complete unittest
counts and failure identities and count actual native execution. A module with
zero native entries is explicitly not verified. --module lists the supported
module groups. This check never changes default deployment.
