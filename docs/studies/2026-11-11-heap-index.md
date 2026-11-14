# Nonnegative object-field indexing and compiler development tools

The optimization is implemented and validated. The actual selected Barnes–Hut AOT artifact loses the targeted signed-index adjustments: one mass-field load changes from five instructions to one. Measured gains are modest: its ordinary timed workload improves from **49.0671 to 47.4893 ms** (1.0332x speed), while a separate instrumented diagnostic measures **31.4393 to 27.4435 ms** in native-extension entry calls. The whole workload still takes **5.21x the matched C kernel time**. This change improves native code already reached; it adds no frontend coverage.

Work is integrated locally on `codex/integrated-coverage`. The measured baseline is `3f0370d` (product `0d2c3d3`); measured candidate is `e35dce1`. Product source differs only in `heap.py`. Tools are `bc8db62` plus reviewed timing correction `dc4c9f9`; they do not change measured compiler source. All 49 tracked product/test files match the independently tested worker byte-for-byte.

## What changed and why it is safe

The compiler explicitly marks physical object-field addresses and guarded class-tag addresses as nonnegative. It casts the **complete signed address expression** only at the final array subscript. Existing loader/layout checks, present-object guards and checked allocation establish that these addresses fit inside the finite arena (`MAX_SLOTS = 2**27`). Handle arithmetic, sentinel values and intermediate offsets remain signed.

The marker defaults off. Python negative list/string indices and slices, raw ndarray strides, container/runtime helpers and host loaders keep their previous lowering. A nullable tuple can contain a -1 handle whose speculative payload is ignored; its nested payload accesses deliberately remain signed. This is a bounded proof applied to object fields across supported programs, rather than blanket removal of Python behavior.

Validation: **405 compiler tests and 38 subtests passed**, including 22 new cases. These cover native LLVM removal of the sign adjustment, both loaders, negative indices/bounds, nullable/unbound values, class-field guards, growth/exhaustion, exactly-once fallback, aliases, integer overflow, mixed numeric types, signed zero and reversed ndarray views. The 22 warnings are existing GPU occupancy and Numba SSA warnings, documented in the [implementation evidence](2026-11-11-heap-index-evidence/validation/IMPLEMENTATION.md).

A new test also exposed an inherited tuple-identity limitation: a returned tuple and the same tuple stored in an object field can compare equal but lose shared identity. This reproduces before the optimization. No tuple-engine rewrite is included, and this report does not claim arbitrary Python equivalence.

## Actual assembly against current code and C

The selected AOT exports are bound to successful-call audits, source/seed digests, PE hashes and wrapper call targets. Both inspected exports completed 500 AOT calls with zero JIT/fallback in their independent audits. No profiling-JIT LLVM is presented as AOT assembly.

For the identified Barnes mass-field load, baseline code normalizes the signed index:

```asm
xorl   %eax, %eax
cmpq   $-0x9, %rsi
cmovlq %rdi, %rax
leaq   (%r12,%rsi,8), %rdx
movsd  0x48(%rdx,%rax,8), %xmm0
```

The candidate uses a direct load:

```asm
movsd  0x48(%rbx,%r13,8), %xmm0
```

Across the address-bounded force function, static `cmovlq` count falls 18→1 and sign-extraction shifts 5→2. The remaining index adjustments are list accesses outside this proof. These are static facts, not cycle counts or a fivefold speedup. Numeric-kind/exact-integer checks, recursive status handling and separate Point handles remain. C still has a flatter fixed representation and fewer semantic obligations. See the [actual AOT and C report](2026-11-11-heap-index-evidence/assembly/REPORT.md) for exact addresses, excerpts, layouts, hashes and limits.

## Measured performance

All nine matched workloads completed: **18 fresh profiles, 300 rotating fresh-process timings and 42 separate execution-mode audits**, with matching numeric checks, no failures/timeouts and no unknown audit modes. Both separate six-repetition Barnes diagnostics also matched, each completing 600 AOT calls without JIT/fallback. Source/runtime/input/artifact/bytecode fingerprints stayed fixed. Root independently verified the complete matrix.

The table includes every workload whose selected path uses the heap engine. Times are medians of five fresh processes' best-of-five state-reset inner times. C uses the same existing hash-verified comparison ports, newly timed with 20 inner states per process. Smaller time is better; these forced/warm views are distinct from default deployment.

| Heap-engine workload | Current ms | Optimized ms | Time change | C ms | Optimized/C time | Execution |
|---|---:|---:|---:|---:|---:|---|
| Barnes–Hut | 49.0671 | 47.4893 | -3.22% | 9.1083 | 5.21x | AOT |
| Float | 1.4408 | 1.4058 | -2.43% | 1.1182 | 1.26x | AOT |
| Coroutines | 1.2229 | 1.2113 | -0.95% | 0.1194 | 10.14x | AOT |
| Basic Richards | 1.0618 | 1.1021 | +3.80% | 0.1850 | 5.96x | Explicit warm JIT/cache |
| Raytrace | 4.4852 | 4.2369 | -5.54% | 0.6039 | 7.02x | AOT |

These are finite observations on a shared Windows machine with an unknown external CPU consumer. All samples and regressions are retained; five observations do not establish statistical significance or isolate every cause. Coroutines also uses the heap engine but is not evidence that this particular object-field transformation benefits every heap program.

The [complete 13-row comparison and nine default-process comparisons](2026-11-11-heap-index-evidence/study/RESULTS.md) retain unchanged paths and Python fallbacks. Nbody's native `.text` and `.pdata` are identical across artifacts; its overlapping-sample median increase is an unchanged-code control. Candidate FFT uses ordinary JIT for transform and AOT for inverse, whereas baseline uses AOT for both: its timing variation is not a heap-index gain. The four other SciMark kernels remain Python, and spectral norm uses ordinary JIT helpers with outer Python work. Workload-wide counters are not assigned to unrelated timed kernels.

For Barnes–Hut, default whole-process median changes **0.529219→0.517286 s**; selected forced-process median changes **0.524897→0.518646 s**. Each contains five inner states. Other default-process results are mixed, and there is no claim of universal end-to-end improvement or increased native coverage. C process walls are not compared as equivalent end-to-end work because its inner repetition count differs.

## Where the remaining time goes

The separate instrumented Barnes diagnostic excludes its first repetition. Native-entry median drops **31.4393→27.4435 ms**, about 12.7% less time (1.146x speed). Loading stays **9.2806→9.4542 ms**, write-back **3.3203→3.2936 ms**, and guards **0.7393→0.7541 ms**. Instrumented whole-kernel time is **51.8119→48.0503 ms**. Timers add overhead, native entry includes the ABI wrapper, and independently selected medians do not form an exact additive partition. These figures are not replacements for ordinary timings.

Packing/write-back still costs around 12.7 ms per 100-step repetition. Native-entry work alone still exceeds the 9.1083 ms C whole workload by about three times. Further progress requires better numeric facts, representation/locality and safe boundary amortization, with separate proofs and measurements; removing this one indexing cost is insufficient.

Fresh combined capture/verification/JIT/AOT/startup-probe wall costs were **287.98 s current and 284.81 s candidate**, outside ordinary execution timings. The API does not expose a clean build-only timer. C ports were not rebuilt: their recorded Clang 21.1.6 `-O3 -march=native -ffp-contract=off` provenance remains unchanged. They are optimized comparisons, not proof of optimal assembly or identical object lifetimes.

## Reusable tools and evidence

[tools/README.md](../../tools/README.md) documents the standard-library CLI:

- `diff`: lossless byte comparison with raw copies; optional explicitly labelled normalization.
- `asm`: disassembly and tool/binary provenance; never executes the inspected binary.
- `c`: C source/header/binary/flag provenance, with supplied flags labelled as such.
- `phases`: explicit-repository region attribution with real output, attempts, successful AOT/JIT counters and loaded-artifact hashes; unsupported paths fail explicitly.
- `cases`: named correctness and cross-process reuse regressions, including dry runs.

All **18 tool tests passed in the integration checkout**. Final review found and fixed recursive return-conversion double-counting in the attribution timer. A deterministic failing regression precedes the correction. The fixed tool then ran an existing real AOT plan: **100 entries, 100 AOT successes, zero JIT/fallback, no Numba import**, all three numeric checks matching the frozen Python reference, and the exact audited artifact hash recorded. This smoke is a diagnostic, not another performance sample. The diff, assembly and C commands also inspected the actual comparison files successfully; the named negative-index case command ran four real compiler regressions successfully.

The adjacent [evidence archive](2026-11-11-heap-index-evidence/archive-manifest.json) contains exact copied reports, raw assembly, test logs, all sample vectors/counts in SUMMARY.json, the frozen measurement manifest, phase outputs, tool smoke and the [clear independent review](2026-11-11-heap-index-evidence/review/REVIEW.md). `.gitattributes` disables line-ending conversion for archived evidence. The independent study repository committed its reports, raw process records and selected AOT artifacts at `57e80008b17f07e380a73a387445932604ffdaf8`; complete raw process outputs, plans, binaries and caches remain under the local `recompyler-codex-20261111/wave5-study/results` directory.
