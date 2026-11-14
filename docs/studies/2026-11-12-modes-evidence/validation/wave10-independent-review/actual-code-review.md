# Wave 10 actual selected-code review: JIT preflight and C DLL

## Scope and provenance

This review reads existing artifacts under `wave10-measurements/results-formal-v1`; it does not import the product, run tests, compile, execute kernels or hash large artifacts during measurements. All 20 RP `prepare-*` results were present. They report requested LLVM/assembly capture, one dispatcher cache miss, exact corpus validation and zero validation fallbacks. The 12 captures examined in detail cover `recurrence_16`, `fibonacci` and `loop_recurrence16` in current-strict, candidate-strict, checked and unchecked-int64 modes. Validation counts per variant are respectively 284, 81 and 392 native corpus calls.

The study manifest hash recorded in these results is `694bc91952b9342fe098aa50fb7d6450f9361985c1b6670887e67323298f7941`. Current source is `1d4084f914fa9594ecb801e3efa565edcd7e1241`; candidate is `a5d11d7745da8d324e46e544f929849c0598cddd`. Recorded source-tree identities are `6a6bc4af45039d5b302097b2bd564401aef47c591181148dea9bdc227c8fc2c0` and `1341ed9787cf7caa456d88f7a7244e1ad54278bdade977316dd055ee894400b0`. Runtime metadata records Numba 0.68.1 and llvmlite 0.50.0. Hashes below are producer-recorded bindings, not independently recomputed during the timing run.

**These RP captures are JIT-selected entry bodies. They are not the primary AOT complete-call timing bodies.** A separate AOT export/address/disassembly review is required to bind the primary timing results to actual AOT code. The C assembly reviewed here is disassembly of the actual built `kernels.dll`, not an illustrative recompile.

## Function-bounded static instruction totals

For RP, count mnemonic instruction lines strictly between the exact `native_symbol:` label reported by `result.json` and `.Lfunc_end0:` in `selected-0.asm`. Exclude labels, directives, constants, CPython wrappers and other functions. For C, use the named exported entry and the next exported kernel boundary in the DLL disassembly, excluding `nop`, `nopl`, `nopw` and `int3` alignment/padding. These bounds are available for all six requested C exports. Counts are static instructions, not bytes, executed instructions, micro-operations, cycles or measured hardware counters.

The categories in this table partition each total. Integer-data arithmetic counts the recurrence/Fibonacci value `imulq`, `addq` or equivalent `leaq`, excluding counters. FP-check instructions count `cvtsi2sd`, `mulsd` and `ucomisd`. Conditional branches exclude unconditional `jmp` and returns. Other includes moves, bit operations, comparisons, counter operations, prologue/epilogue and status stores.

| Kernel / native body | Total | Integer-data arithmetic | FP-check instructions | Conditional branches | Unconditional jumps | Returns | Other |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| recurrence_16 current-strict | 224 | 32 | 49 | 33 | 0 | 1 | 109 |
| recurrence_16 candidate-strict | 224 | 32 | 49 | 33 | 0 | 1 | 109 |
| recurrence_16 checked | 38 | 32 | 0 | 0 | 0 | 1 | 5 |
| recurrence_16 unchecked-int64 | 38 | 32 | 0 | 0 | 0 | 1 | 5 |
| recurrence_16 C exact | 33 | 32 | 0 | 0 | 0 | 1 | 0 |
| recurrence_16 C wrap | 33 | 32 | 0 | 0 | 0 | 1 | 0 |
| fibonacci current-strict | 26 | 1 | 0 | 3 | 1 | 1 | 20 |
| fibonacci candidate-strict | 26 | 1 | 0 | 3 | 1 | 1 | 20 |
| fibonacci checked | 41 | 9 | 0 | 5 | 1 | 2 | 24 |
| fibonacci unchecked-int64 | 41 | 9 | 0 | 5 | 1 | 2 | 24 |
| fibonacci C exact | 35 | 9 | 0 | 5 | 1 | 2 | 18 |
| fibonacci C wrap | 35 | 9 | 0 | 5 | 1 | 2 | 18 |
| loop_recurrence16 current-strict | 234 | 32 | 49 | 34 | 0 | 1 | 118 |
| loop_recurrence16 candidate-strict | 234 | 32 | 49 | 34 | 0 | 1 | 118 |
| loop_recurrence16 checked | 45 | 32 | 0 | 2 | 0 | 1 | 10 |
| loop_recurrence16 unchecked-int64 | 45 | 32 | 0 | 2 | 0 | 1 | 10 |
| loop_recurrence16 C exact | 38 | 32 | 0 | 2 | 0 | 1 | 3 |
| loop_recurrence16 C wrap | 38 | 32 | 0 | 2 | 0 | 1 | 3 |

Current-strict and candidate-strict have matching opcode frequency inventories for all three kernels. Checked and unchecked likewise have matching inventories. Distinct policy/program identities still apply; matching native instruction counts do not mean shared policies, guards or artifacts.

## Observed checks and transformations

**recurrence_16.** Both strict entries retain 17 `cvtsi2sd`, 16 `mulsd`, 16 `andpd`, 16 `ucomisd` and 16 `jae` for multiplication magnitude guards. The two source comparisons are folded into an absolute-value comparison. The 16 addition guards retain 32 `xorq`, 16 `testq` and 16 sign branches (15 `js`, one `jns`). There is one explicit `cmpb`/`jne` on status, not 32 separately preserved caller status branches; LLVM has merged/eliminated redundant checks. The failure block writes `movb $1, (%rax)`. Checked/unchecked entries contain 16 `imulq` and 16 `addq`, four `movq`, one `xorl`, one return, and no overflow/status access. C exact/wrap use 16 `imulq`, 15 `addq`, one `leaq` and one return; RP's five extra static instructions reflect its selected Numba ABI/body shape, not additional arithmetic checking.

Representative strict sequence from `prepare-recurrence_16-current-strict/selected-0.asm`: `cvtsi2sd; cvtsi2sd; mulsd; andpd; ucomisd; jae`, followed later by `imulq; leaq; xorq; movq; xorq; testq; js`. The checked native entry starts with three argument loads followed directly by alternating `imulq`/`addq`.

**loop_recurrence16.** The same strict arithmetic guards survive inside the loop. Checked/unchecked retain 16 multiply/add pairs plus loop control (`jle` for zero trips; `incq`, `decq`, `cmpq $1`, `ja` for the positive loop), and no data-overflow checks. The C bodies have the same 16 arithmetic pairs but a simpler `decq`/`jne` loop and register arguments. The 45-versus-38 static difference includes ABI and loop lowering, so it is not a count of retained safety checks. All bodies remain loops; source sites must not be multiplied by maximum trip count when reporting static instructions.

**Fibonacci.** Strict has one data `leaq` per iteration with XOR/sign overflow detection and a byte-status test, then a loop backedge. Checked/unchecked and both C exports are unrolled eightfold with a scalar remainder loop: eight data additions in the unrolled body and one in the remainder body. Their tenth static `addq` updates the loop counter. This is why checked/unchecked have 41 static instructions versus strict's 26 despite removing data-overflow checks. More static code does not imply slower execution. The optimization changes loop/control work per iteration, so any speed difference cannot be attributed solely to a count of removed checks.

The [source inventory](check-inventory.md) remains correct about which helper/status pairs are bypassed. Its 195 arithmetic sites across five kernels are **not 195 surviving machine branches**, and its conceptual 390 helper-plus-caller conditional occurrences are not an assembly branch count. This review's exact counts cover three kernels only.

## LLVM flags

The selected checked and unchecked recurrence data operations are plain `mul i64` / `add i64` with no `nsw` or `nuw`; their long-loop data operations also retain that property. Fibonacci's nine unrolled/remainder data additions likewise have no no-wrap flags. Optimized Fibonacci does contain `add nsw i64 %lsr.iv3, -8` and `add nsw i64 %lsr.iv, -1`, but those are bounded loop-induction decrements, not Fibonacci values. A whole-file search for `nsw` is therefore not a valid audit of wrapping arithmetic.

The strict selected LLVM contains `mul nsw` / `add nsw` data operations in both baseline and candidate while the inspected assembly still retains the guards described above. This is existing strict lowering, not a flag introduced by the experimental intrinsics. The present review establishes observed guard retention; it is not a general proof of strict LLVM poison semantics for every input or optimization.

C exact uses signed `int64_t` arithmetic and has `nsw` in its optimized data expressions. Its semantics are justified only on the checked, no-overflow corpus. C wrap uses unsigned `uint64_t` data arithmetic and plain wrapping LLVM operations. Identical C exact/wrap machine opcode inventories do not make signed-overflow calls to C exact valid. Build flags are `-O3 -march=x86-64 -ffp-contract=off -fms-runtime-lib=dll`, with no link-time optimization.

## Actual C binary and exports

The recorded actual DLL SHA256 is `b52385c4da2897e37e0ea729e1477edec26f1b7b4ac6c7c5a17bad018bcc5e88`; separately generated C LLVM SHA256 is `5f072fc4fb5844bb6b9a77f26cb696c8faecb6aaf806118b1aad7e2318b1ac38`. Evidence is `build/identity.json`, `processes/c-exports.stdout` and `processes/c-disassembly.stdout`. The compiler commands and successful process receipts bind the disassembler to the same DLL path. No independent binary rehash was done during measurements.

| Export | RVA | Disassembly start |
| --- | --- | --- |
| recurrence_16_exact | 0x1020 | 0x180001020 |
| recurrence_16_wrap | 0x10A0 | 0x1800010A0 |
| loop_recurrence16_exact | 0x14C0 | 0x1800014C0 |
| loop_recurrence16_wrap | 0x1550 | 0x180001550 |
| fibonacci_exact | 0x15E0 | 0x1800015E0 |
| fibonacci_wrap | 0x1670 | 0x180001670 |
| batch_exact | 0x1700 | 0x180001700 |
| batch_wrap | 0x17B0 | 0x1800017B0 |
| batch_rp | 0x1860 | 0x180001860 |

Do not attribute every later `<batch_rp+offset>` label in the DLL dump to that function: stripped/unlabelled runtime code after the last exported name receives nearest-symbol annotations. The reviewed batch hot loop is the bounded region around 0x1800018F0–0x180001978, not the rest of the DLL.

## Native-batch boundary and pending evidence

Actual C `batch_exact` invokes its function pointer with `callq *%r14` at 0x180001770; `batch_rp` invokes the adapter pointer with `callq *%r14` at 0x180001937. In `batch_rp`, immediately preceding instructions reset top/depth/status, and `cmpb $0,(%r12)` / `jne` afterward checks status. Thus the prevalidated native timing includes a C loop, an indirect native invocation and RP status/depth reset/check work; it excludes ordinary Python entry binding, policy interval/type guards, per-call scalar loading and Region counters. C exact/wrap loops lack those RP status/depth resets, so this boundary is useful but not identical overhead for RP and C.

`helpers/worker.py:native_batch` builds a cfunc adapter that calls the selected `program.run` dispatcher with native array views. LLVM may inline the selected body into that adapter. The helper records `selected_target_digest`, symbols, adapter LLVM/assembly hashes, selected-symbol call lines and `selected_target_physical_calls_retained`, and correctly says that the C loop counts adapter invocations while the selected body may be inlined. One counted adapter invocation is not evidence of a retained physical call instruction to the original selected symbol.

At this review checkpoint, native timing/adapter artifacts were not yet available; source inspection establishes the intended adapter path, not its final optimized topology. Do not use this JIT preflight assembly as a substitute for the actual timed adapter assembly. The later adapter inspection should require matching selected digest, inspect actual linked definitions/call sites, and report inlining without claiming physical dispatcher calls. Similarly, no AOT machine-code equivalence is asserted from this JIT capture.

## Actionable reporting constraints

1. Bind the primary complete-call result to the actual AOT export and binary before using an assembly explanation for that boundary. This report covers JIT preparation bodies and the actual C DLL.
2. Bind each native timing adapter to its selected program digest and distinguish adapter invocations, linked/inlined target bodies and physical target calls. The current helper metadata supports that distinction; adapter captures remain to be inspected.
3. Preserve the Fibonacci unroll factor and loop-control changes in the explanation. Static totals alone cannot establish speed or attribute all speedup to check removal.
4. Keep wrapping-data flag checks scoped to data dependencies; loop-induction `nsw` is present and does not contradict modulo arithmetic. Keep C exact claims confined to the no-overflow corpus.
5. Scope all static counts to exact symbols. Exclude CPython wrappers, ABI helper routines, alignment and unrelated DLL runtime text. Scalar kernels do not exercise native C object/list loading merely because native-loader availability metadata is true.

No new product defect is demonstrated by these inspected artifacts. They support arithmetic-check removal while retaining the earlier boundary qualifications. No timings are interpreted in this report.

## Exact RP artifact bindings

The following section is populated directly from the 12 inspected `result.json` records. Each named native symbol was found as the definition/entry label in its paired LLVM/assembly files. Paths are relative to `results-formal-v1`; both `selected-0.ll` and `selected-0.asm` are paired with the cell's `result.json`. Hashes are the recorded artifact hashes, not a fresh during-run rehash.

### recurrence_16 / current-strict

- Cell: cells/prepare-recurrence_16-current-strict
- Program digest: 7418cd63af9cd8b24ce0a5c926626eeee1a09fcb7cf83a558df6dcf1202b4e8c
- Generated source SHA256: 8ac3acbca715415767ef1924d11e58922754a2b235ad71b63aba60c85fc85e77
- LLVM SHA256: 5fdc5f9f3dd3a9e3d33905cdb6f1c94cc5464f463957cbfacd8dd0c681a40b61
- Assembly SHA256: 7842efefea8b432e6720ff0b186628c81552b40cfaed912597375b0bba09641c
- Native symbol: _ZN32rc_heap_2b6ae51a3c827ac03ab1c7cf16f0_recurrence_16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx

### recurrence_16 / candidate-strict

- Cell: cells/prepare-recurrence_16-candidate-strict
- Program digest: 3dbef551048c2605ccb464c876eb733b4acec969cd2180c482875d7de6ead964
- Generated source SHA256: 8ac3acbca715415767ef1924d11e58922754a2b235ad71b63aba60c85fc85e77
- LLVM SHA256: 2d59b4ef5ecdd22fbe425b0e39bdde8a80006c32e64ee4ce3c63b0cd81d9ad8f
- Assembly SHA256: 7c4292094d8e0c8d8f92df2527ace746697d32125371fc6e8bb6e871c45a3f02
- Native symbol: _ZN32rc_heap_0bc4322814ec5c10910c668416f0_recurrence_16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx

### recurrence_16 / checked

- Cell: cells/prepare-recurrence_16-checked
- Program digest: 7b35aa9c6f39bd13153c7a767f40755c60cf0e9c87bc7fdcc1838c5e0c0e7a4a
- Generated source SHA256: 52af6a52e00df215b32935fe439ce69e6d770678a7ae0ec09615f25627a539ae
- LLVM SHA256: 8071ac0534f229bc9118437c4b517251eeb0f427bf38b1b5257a8acf829c13ee
- Assembly SHA256: d23ae9ee0498ddfd7985ea8284c2797a7988efb971332c6102ce20d57b3b7f44
- Native symbol: _ZN32rc_heap_a044c7d78212f1595140e8fa16f0_recurrence_16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx

### recurrence_16 / unchecked-int64

- Cell: cells/prepare-recurrence_16-unchecked-int64
- Program digest: c22eebaf1fa306f6be37fd80b0f91fa703feaad7355c86ef97721d5f2c9d7ccf
- Generated source SHA256: 4fc72872fbbe430055a4b7fcc75fcd6b8b702879587328781ecb9d26aa0b3dcd
- LLVM SHA256: fbd815351c340a57a05b15fc41953fefe816c2b14b252075b721019f6f5de066
- Assembly SHA256: 02a503718178fdbc1718112ed1b3ca4ab821a59a602eab6e7eedc8fd3b22595f
- Native symbol: _ZN32rc_heap_a39a8e178a9a302942ae2ac216f0_recurrence_16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx

### fibonacci / current-strict

- Cell: cells/prepare-fibonacci-current-strict
- Program digest: ee0a347fd88aadd48b9fa9faa9d66558f7eeb85c1b8aad2713a77af4949b6c2d
- Generated source SHA256: 15020bc158108e1f42ec57c0f8d35aba4565e5e0e1e2137d211fd457066846aa
- LLVM SHA256: ec91bfeb26d14b8fa2d027e23a660e359a593ff67a2785219e84cc3fb44dfbf6
- Assembly SHA256: b1cab72458dc60653d17f50e69866d53aa9561e7c8c041fdea6294d73a3124f9
- Native symbol: _ZN32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx

### fibonacci / candidate-strict

- Cell: cells/prepare-fibonacci-candidate-strict
- Program digest: c186324c1dab4c37d8b0c0431cd34e72748e7dab3c1144e8e320364dd9f42dcf
- Generated source SHA256: 15020bc158108e1f42ec57c0f8d35aba4565e5e0e1e2137d211fd457066846aa
- LLVM SHA256: 7dd1d2c2eab84f5ae9f4503e4c7ea2ea405419a893f215b61af0f671068a52ae
- Assembly SHA256: 49d6fc81cb368b20243d97470f1880ab26dc080ddd3507478ac5cbec8b6a3489
- Native symbol: _ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx

### fibonacci / checked

- Cell: cells/prepare-fibonacci-checked
- Program digest: f758397a0d1850fac42cfbc416788a259098c500010373bc56f4c1e71cb46d73
- Generated source SHA256: 69de5027e01007975281e89e02609e722a9ce81a9552216dc190f30d93a1d55b
- LLVM SHA256: cb2bf5d5d4a681874b5cd7bdc9ca0b833d462d89f9176c2f7890591c9f4218e1
- Assembly SHA256: e5df99ec8747676ae94931b34dbdfb597e445901477bcdd46af0a02abedacf0d
- Native symbol: _ZN32rc_heap_85f07cc79ec7251995a7229812f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx

### fibonacci / unchecked-int64

- Cell: cells/prepare-fibonacci-unchecked-int64
- Program digest: 3d36deac3a8cae31652c24de249ff57bd31092f1313e44ddbb25ea31a1db51be
- Generated source SHA256: 8bd77155570d003a5ee0fb77ab42a0074fdcf516a75caa34816f15eddfebc373
- LLVM SHA256: e5c34739c90a5eefea001056c37f39d943e0ac0d10541a51146f640500b01bb9
- Assembly SHA256: 623894adc3e78f0ac2aa2e84f1532bffc5f735bd20f70f87b4ba622719a0333b
- Native symbol: _ZN32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx

### loop_recurrence16 / current-strict

- Cell: cells/prepare-loop_recurrence16-current-strict
- Program digest: a28d914bd450093c6bfdc6ea80dfe30a1c9e2ff872fae91491094943a721cffe
- Generated source SHA256: 273f21ce77fb0f406fd3546b37df1b479d725709daffb63e5e81022ef9fefcdd
- LLVM SHA256: 39d2eaea616c773da94269e65c70c80114dabd024ffc6d2f4e3fa69e4464ded6
- Assembly SHA256: 60da23ddd0a02d591af5c2072398c0982ac4eff32e9d74ed7a1f1332e7458ba8
- Native symbol: _ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx

### loop_recurrence16 / candidate-strict

- Cell: cells/prepare-loop_recurrence16-candidate-strict
- Program digest: c318ac0fb823ace0893838672f7321dabfa801a694eb2bfff5dd039fc66b26ee
- Generated source SHA256: 273f21ce77fb0f406fd3546b37df1b479d725709daffb63e5e81022ef9fefcdd
- LLVM SHA256: 2414e6a31271bb4956891d6d08340f244f362f2f6438d1b199a8363c3cfbf6d2
- Assembly SHA256: 144a18730163782f0b0a2a375bd5c2c13f0511af3300ef5fea660026ee9ec1ea
- Native symbol: _ZN32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx

### loop_recurrence16 / checked

- Cell: cells/prepare-loop_recurrence16-checked
- Program digest: 202f683b665d056f07b8d3ed299c5069eafddc74cf520492d703e67087cba0b6
- Generated source SHA256: 6e724cf67a73ad27cfd0553a184a7caf1576584811996e8fe0d9e6faa5694516
- LLVM SHA256: fc7675d13e4eddf00e2e00e97035fb3bd92febbecbe4c8649927cfb672d28a7b
- Assembly SHA256: 4c61c0ca055b88438f304d9864797e2b668b6e525c72afc9b81b74f3a62d5c3d
- Native symbol: _ZN32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx

### loop_recurrence16 / unchecked-int64

- Cell: cells/prepare-loop_recurrence16-unchecked-int64
- Program digest: 123ef0b2d30a1c1895b018d663448026d600339ae6695cf43e8d0fc480092a42
- Generated source SHA256: 87bf405d8b9f95217573ccd8fdfe9cf9cdb15cec09832ecfd8f492c3e6a456a6
- LLVM SHA256: ad110514b1a736935b752e36ffefee77b1b7cb84b05baa0e82236295cf8cd4f0
- Assembly SHA256: 828bcc52eee5b3efd1a30698049672fd50183e3ca3b37de99b1d8e1240867965
- Native symbol: _ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B2v1B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx
