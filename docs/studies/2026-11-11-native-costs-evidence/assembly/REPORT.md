# Actual Barnes AOT proof and remaining representation costs

The production zero-or-float proof **does take effect in the actual selected Barnes-Hut AOT binary**. It removes eight recursive-accumulator comparisons against `2**53`, while retaining the six comparisons associated with unknown coordinate fields and retaining numeric-kind flags in the recursive return ABI. This is a verified compiler simplification, **not a measured workload speedup**: the unchanged-source cohort reports 47.2972 ms baseline and 47.4359 ms candidate median kernel time (+0.293%), with overlapping sample ranges.

## Scope and provenance

Baseline source is `0aeb157e8d272e0b1d4787a173f5b66f75d81b01`; production proof is `9ff4908fdc58613d72287f71cfc6b70aa5e693ff`. Production `heap.py` SHA256 is `e7ee3bb1fb2b8c42a6848383388ef28ed3eaf79e6a1f50e0fc53b210570e5109`. Manual forceonly/fullfloat cases use the baseline compiler with explicitly edited numeric contracts; their differences are diagnostic counterfactuals, not equivalent production transformations.

Each inspected state audit identifies one successful `advance_system` digest, 100 actual AOT calls, zero JIT/fallback/rejected/unknown-native calls, and no Numba import. The production timing cohort separately records 2,500 AOT calls per side and zero JIT/fallback. Plan/export/digest mappings, complete artifact hashes, audit hashes, disassembler command/tool hash and assembly hashes are retained in the four `*-provenance.json` files. `verification.json` independently checks those bytes against the frozen artifact inventories and matches baseline/candidate wrappers to the study's independent runtime-address maps. This inspection executes no native artifact, kernel, build, profiling or timing job.

| Case | Artifact SHA256 prefix | Export wrapper | Native entry | Recursive force |
|---|---|---|---|---|
| Baseline/current-direct | `226403d22c98758a` | `0x1800019e0` | `0x180001090` | `0x180003c20` |
| Production proof | `94afcc7bfed19eeb` | `0x1800019e0` | `0x180001090` | `0x180003c20` |
| Manual forceonly | `c9119e644feebd83` | `0x1800019d0` | `0x180001090` | `0x180003bf0` |
| Manual fullfloat | `40ee22ee0ad34a4e` | `0x180001980` | `0x180001090` | `0x180003b40` |

Wrappers are located through PE `PyMethodDef` records. Their machine calls lead to the native entry; entry call sites and four self-recursive calls identify force. Nearest-export `PyInit_*+offset` labels in disassembly are not internal function names. Force ranges below are inferred from those calls and the next helper boundary, including alignment padding; `.pdata` does not supply these native helper boundaries.

Production manifest SHA256 is `b58ae5be6211787fae5a47cf5943b277d61443edf70a12e05d3cde6eda58c46d`; manual manifest is `77e07518f29ec54d697de1bd6ee94486b74fe89622cec4a5bd09a71d3e902795`. Independent retained-data checking confirms all 100 step sets and numeric/type/alias hashes match plain Python for baseline and production, without type relaxation. This closes the original harness's missing intermediate-type comparison. It remains finite-corpus evidence alongside the proof/code review, not universal equivalence.

## What the machine code proves

| Force body | Inferred byte span | Instruction lines | Stack-operand lines | Frame reservation | RIP comparisons to actual `2**53` |
|---|---:|---:|---:|---:|---:|
| Baseline `3c20..4a80` | 3,680 | 632 | 277 | `0x1e8` | 14 |
| Production `3c20..4870` | 3,152 | 524 | 275 | `0x1e8` | 6 |
| Manual forceonly `3bf0..46f0` | 2,816 | 471 | 249 | `0x198` | 6 |
| Manual fullfloat `3b40..4550` | 2,576 | 418 | 249 | `0x198` | 0 |

Counts are static instruction lines in specified ranges. Stack-operand lines include outgoing arguments, saved registers, local values and return buffers; they are not a count of register spills. Neither count measures execution frequency, memory traffic, cycles or a numerical share of the C gap. `static-counts.json` records all addresses and mnemonic counts; referenced PE constant bytes were decoded as exactly `9007199254740992.0`.

After the baseline's first child call at `0x180004101`, the integer return tag selects a bound check at `0x180004152`; failure writes status and an error code before leaving. A shortened excerpt from `current-direct-first-return.asm`:

```asm
180004146: movapd abs_mask(%rip), %xmm1
18000414e: andpd %xmm7, %xmm1
180004152: ucomisd exact_2_to_53(%rip), %xmm1
18000415a: jb accepted
180004160: movb $1, (%rdi)
180004163: movq $0x3d0922, 0x18(%rsi)
```

The production counterpart calls at `0x1800040fe`, checks existing failure status, reads the two return flags, and adds the two values without that bound branch (`production-first-return.asm`). The other seven recursive-accumulator threshold references also disappear. The six coordinate checks at `0x180003d65`, `3da4`, `3dba`, `3dd9`, `3de7` and `3e00` remain; `production-fields.asm` preserves their complete context. Unknown field values did not acquire invented zero facts.

At production force return `0x180004852..4863`, doubles are still stored at result offsets 0 and 16, with kind bytes at offsets 8 and 24. The zero base case and recursive result flags preserve the public integer/float distinction. Both baseline and production reserve `0x1e8` stack bytes and retain the broad recursive-call setup. The source-level redundant normalization is removable by the proof, but remaining zero additions in the machine code can implement source accumulator operations; their mere presence is not evidence the proof missed.

## Remaining ABI work is concrete, its runtime cost is unmeasured

Even the manual fullfloat body, with no `2**53` comparisons and untagged two-double returns, still writes every outgoing eight-byte argument slot from `0x20(%rsp)` through `0x100(%rsp)` before its first recursive call at `0x180003ed0`: **29 slots**. See `fullfloat-direct-call-marshalling.asm`; additional `0x108/0x110` stores are saved locals, not counted outgoing slots. The generated helper accepts the heap's F/I/top/status arrays plus semantic arguments; the native call expansion carries their descriptors repeatedly. Status checks, recursion-counter updates and child checks remain. Fullfloat also loads separate center/position handles before loading doubles (`fullfloat-direct-fields.asm`); changing numeric kinds alone did not flatten those objects.

The retained original Python profile supplies relevant dynamic context: `wave5-study/results/programs/barnes_hut/candidate.plan.json` (SHA256 `7d5aacc5254488f1a961ea801c8c94a37dc1c9aeef0034e3ec99b696d8aade0f`) records 2,144,216 `calculate_force` calls, 100 `advance_system`, 255,303 each `insert` and `contains`, 34,544 mass updates and 3,636 subdivisions. `profiler.py:792` runs the script under the monitor before candidate verification, and `monitor.py:596` increments the Python call count at function start. These are observed calls in that original Python profiling run, **not native hardware counters or measured C call counts**. They strengthen the reason to investigate recursive call representation; multiplying them by static instructions or slots would not establish actual traffic or cycle cost.

The unchanged C binary SHA256 is `4fd003eeea3b3bf997c90889340719fd71e8f698da5feca673ece46e9418f9ff`. Its force excerpt is copied byte-for-byte from the earlier inspection (`c-force.asm`, source hash in `verification.json`): frame reservation `0x58`, recursive setup with node/index/two output-pointer arguments, and a RIP-loaded theta constant decoded as exactly `0.5`. This is direct evidence of a narrower call interface and value specialization. It does not isolate their benefit from C layout, allocation/lifetime choices, compiler decisions or ISA targeting. RP AOT is generic-target while C uses `-march=native`; that confounder's impact remains unmeasured.

## A bounded next proof target

Two generalizable directions follow from the actual instructions, without another patch or timing claim here:

1. **Internal recursive result-tag liveness.** The existing zero-or-float certificate can support an internal float-only specialization only when every use of each result leaf ignores its integer/float distinction and preserves required arithmetic/error behavior. Prove this across the recursive strongly connected component, including every call site and escape; retain tagged adapters for public returns, object stores, type-sensitive consumers, unknown callees and mixed arithmetic needing the flag. Float division at a known consumer may make a flag dead, but the certificate alone does not make all result flags dead. Compare generated structure before requesting performance evidence.
2. **An internal heap-context ABI.** Keep the public AOT boundary stable and pass a bounded internal context holding borrowed buffer pointers/lengths and shared top/status state, instead of repeatedly expanding all array descriptors through recursive calls. Prove owners remain alive for the call, backing addresses cannot move during the native attempt, growth exits before stale-pointer reuse, and every helper observes shared mutations/error state. F and I can alias the same storage: no invented `noalias` assumption. Preserve recursion limits, transaction/fallback behavior and bounds checks; version affected internal artifacts/cache keys. A small recursive fixture should first demonstrate fewer outgoing arguments while matching error/alias behavior. The current assembly motivates this hypothesis but supplies no performance estimate.

Guarded theta specialization is another bounded value-fact opportunity visible in C; it requires a checked input/value dependency in artifact selection and cannot become an unguarded global constant. Private layout or arena rewind needs separate escape/lifetime proof. In particular, fusing 100 calls without a scratch-region reclamation proof can retain all transient trees; eliminating loader boundaries alone is not sufficient.

## Timing interpretation and review verdict

The fresh proof cohort's C median is 9.123802 ms. RP whole-kernel medians are 47.2972/47.4359 ms; whole-process wall medians are 530.8935/540.1634 ms (+1.746%). Five samples per side overlap. The extra source-generation proof passes are a possible wall-time contributor, but these data do not identify their cost or establish a significant wall regression. No toggle or additional implementation is justified solely by this one cohort.

Separate instrumented phase medians report native-entry time 27.5022/30.3387 ms; loading 9.1300/10.6163 ms; writeback 3.3424/3.4514 ms. These are one instrumented phase process per side, with first repetition excluded, not headline timing or a causal decomposition of the uninstrumented delta. Component medians need not sum to a whole-run median. The ordinary timing cohort is the basis for the no-observed-speedup conclusion.

The earlier roughly 5.21x ratio includes RP boundary work and Python final energy versus the C whole timed algorithm, not only native force. Manual source edits and wrapper grouping change different constraints and must remain labeled separately. Static code size reduction, actual guard elimination and the observed fullfloat counterfactual cannot be converted into a promised production speedup.

Independent production code review is clear; focused 14+14 and full 441+52 tests passed as recorded in `wave6-analysis/zero-facts-review.md`. The production rule is a validated general compiler building block with an actual Barnes hit. The retained study does not demonstrate a Barnes speed improvement.
