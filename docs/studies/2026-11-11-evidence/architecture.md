# General Python compatibility and native performance

This is the coordinator's engineering assessment, to be ranked against the fresh held-out results. It is a roadmap, not a claim that these mechanisms already exist.

## The target

RecomPyler should accept an ordinary program, preserve its observable behavior, and accelerate profitable stable regions. Accepting every program through Python fallback is different from compiling every program fully. Handwritten C ports also remove language behavior by choosing representations and algorithms explicitly; matching their speed requires proving that the removed behavior cannot matter in a particular region.

There is no single optimal assembly sequence for all inputs, processors and workloads. The useful measurable target is the gap to a comparable native implementation using the same work, arithmetic order and observable results, with compilation/startup and steady execution reported separately.

## What can be removed when guarded or proved

| Cost | Mechanism | What must remain correct |
| --- | --- | --- |
| Python dispatch and repeated type checks in arithmetic loops | Specialize stable types and compile the loop/region; move guards to entry or loop boundaries | Changed types route to a valid implementation; Python integer overflow and exception behavior remain intact |
| Boxed temporary numbers and objects | Keep values in native registers/stack; scalar-replace objects that do not escape | Materialize objects when identity or external visibility becomes observable |
| Repeated attribute/global/method lookup | Guard source/code, layouts and binding versions; inline stable calls | Monkey-patching, descriptors and overridden methods invalidate the specialization |
| Pointer-heavy temporary containers | Infer homogeneous layouts; avoid allocations for temporary intermediate containers; fuse producer/consumer loops | Aliases, iteration order, custom hashing/equality and mutations preserve their effects |
| Python/native boundary copying | Keep larger regions native; use verified array storage directly; avoid unnecessary packing | Aliasing and failure recovery cannot expose partial or repeated effects |
| JIT startup and unnecessary compilation | Reusable AOT/native caches, negative-result caches, hotness thresholds and an honest cost model | Invalid code/configuration caches are rejected; short/library-bound scripts can remain plain Python |
| Serial independent work | Prove iteration independence; batch across CPU cores or GPU only after measuring dispatch/transfers | Preserve dependencies, random sequence, exceptions and required floating-point evaluation order |

Guarded specialization and cheap deoptimization are established mechanisms in [CPython's specialization design](https://peps.python.org/pep-0659/). Larger regions need more careful state recovery than individual operations. Our recommendation is to specialize stable portions while bounding the cost of mis-specialization.

## Semantics that cannot simply be dropped

Python object identity, mutation, protocols, custom hashing/equality and method dispatch are observable behavior described by the [Python data model](https://docs.python.org/3.14/reference/datamodel.html). An optimizer may prove such behavior irrelevant locally; it cannot assume it away globally. Python integers have unlimited precision, so native-width arithmetic needs checked overflow followed by correct promotion or fallback ([built-in numeric types](https://docs.python.org/3.14/library/stdtypes.html#numeric-types-int-float-complex)).

Aliased writes cannot be reordered freely. Floating-point reductions generally cannot be reassociated while preserving exact results. LLVM documents runtime alias checks and the restrictions on vectorizing floating-point reductions in its [vectorizer documentation](https://llvm.org/docs/Vectorizers.html). Independent per-element work can offer more parallelism than a dependent exact reduction. GPU transfer/setup and already-native library time can dominate any Python-loop saving.

## The largest architectural step toward generality

Current whole-function/region compilation makes an unsupported operation block its containing candidate. Extending language forms helps, but a general solution should compile supported islands within mixed code. That requires explicit entry state, guards and a way to return to Python at the correct program point.

The crucial invariant is **exactly-once effects**. Restarting the original function after external writes or I/O is unsafe unless those writes are fully reversible. The first-wave NumPy rollback repair demonstrates this directly. Copying writable arrays preserves correctness at a cost; a future write journal, staged commit, or resumable continuation can reduce that cost. Bridging to arbitrary Python/C-extension calls also requires boxing/materializing visible state before the call and respecting the GIL/API rules.

Proposed sequence after the combined study:

1. Rank remaining blockers by held-out self-time and actual default-run benefit, with short/library-bound workloads retained as overhead controls. Check that verified functions are actually installed: the present runner rewrites the entry script, while profiler `--include` can capture imported modules. File-aware module installation and invalidation may be necessary before those opportunities turn into real application acceleration.
2. Complete common binding, container and generator-consumer forms that repeatedly block hot code, adding differential tests beyond the tuned nine.
3. Introduce a narrow resumable native loop inside a mixed Python function, initially with no irreversible effects. Test changing types, overflow, exceptions and mutation before expanding the boundary.
4. Track aliases and effect classes explicitly. Add native-to-Python call boundaries only when state is materialized and resumption is exact.
5. Reduce native overhead with escape analysis/scalar replacement and smaller guards. Inspect generated machine code and comparable C kernels only after profiling identifies the remaining cost. One concrete code-generation check: both AOT builders currently create `CC(module)` without setting `target_cpu`, whose vendored default is the empty generic target. Evaluate host-targeted AOT with a CPU-feature-keyed cache and portable fallback against the native-CPU C ports; do not assume the flags alone will fix heap/boundary costs.
6. Add CPU/GPU dispatch for demonstrably independent batches; report transfer-inclusive break-even points and keep serial/Python alternatives.

Keep automatic selection, explicit diagnostics and a stable fallback. A sampled verification success supplies regression evidence; it is not a semantic proof for all future inputs. Coverage growth, speedup, startup overhead, memory growth and semantic correctness need separate tests and reports.
