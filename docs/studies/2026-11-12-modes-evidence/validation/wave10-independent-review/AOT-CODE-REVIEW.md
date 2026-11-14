# Prototype AOT bodies, actual C exports, and timed adapter review

This review concerns the frozen **prototype** study `wave10-measurements/results-formal-v1`: current `1d4084f914fa9594ecb801e3efa565edcd7e1241`, candidate `a5d11d7745da8d324e46e544f929849c0598cddd`, manifest `694bc91952b9342fe098aa50fb7d6450f9361985c1b6670887e67323298f7941`. It does not describe the later Python binding optimization. Source/assembly/JSON files were read only; no command-line process, compiler, tests, kernel execution or binary hashing was used for this review.

## Four boundaries must remain separate

| Evidence | What it establishes | What it does not establish |
| --- | --- | --- |
| Source templates and check inventory | 195 arithmetic sites across five kernels; policy removes selected helper/status pairs | Surviving instructions, physical calls or speedup |
| Cold JIT `prepare-*` selected code | Optimized JIT entry selected during preparation | The actual primary AOT timing body or final adapter optimization |
| Actual AOT DLL body mapped below | Native arithmetic called by the selected extension wrapper in complete-call AOT timings | The cost of Python binding/guards, extension unboxing, loader or executor; timed native-batch code |
| Actual `native-r*` adapter LLVM/assembly | Optimized linked/inlined JIT route used by the native batch | AOT execution, ordinary Python wrapper behavior or an isolated arithmetic-check comparison |

The prototype complete-call binding overhead is outside the selected AOT arithmetic body. A later Python-only binding change must receive its own complete-call results. Arithmetic-body evidence may be reused only with a documented unchanged lowering/binary relationship, not by relabeling prototype timings.

## Selection and control-flow method

The actual AOT collector index is `results-formal-v1/aot-assembly/index.json`. Each selected record joins a successful AOT audit's program digest, Python extension method name (`r0` for strict; `entry` for experimental), binary hash, loaded module base, runtime method address/RVA and static `PyMethodDef` mapping. The method is a Python extension method, not an assertion that the native arithmetic routine has a named PE export.

For all 12 requested kernel/mode combinations, I verified the selected wrapper's machine code contains a direct call to **RVA 0x1090**. This common RVA is coincidental layout within twelve separately identified binaries. I traced the instructions reachable from that call target: ordinary instructions fall through, conditional jumps follow both successors, unconditional jumps follow their target and returns stop traversal. Every successor stayed below the selected wrapper entry and every path closed at recorded returns; no native-body calls or indirect jumps were encountered. Thus the unnamed `<.text+0x90>` label is selected through the actual wrapper call and its arithmetic/control flow, not chosen merely because it appears near the beginning of a dump.

Counts exclude alignment/padding (`nop`, `nopl`, `nopw`, `int3`), labels, wrappers, runtime helpers and unreachable text. The counted code has no nested calls. Native-body unwind entries are not required for these leaf/body boundaries; the wrapper's unwind range anchors the separate wrapper, and reachable CFG/returns establish the native body. All addresses below are RVAs relative to the particular binary's preferred image base 0x180000000; ASLR does not change them.

| Kernel | Variant(s), each separately verified | Wrapper RVA | Wrapper direct-call RVA -> native RVA | Native CFG span [start,end) | Return RVAs |
| --- | --- | --- | --- | --- | --- |
| recurrence_16 | current-strict; candidate-strict | 0x1450 | 0x1723 -> 0x1090 | [0x1090,0x144F) | 0x144E |
| recurrence_16 | checked; unchecked-int64 | 0x1110 | 0x13CE -> 0x1090 | [0x1090,0x1104) | 0x1103 |
| fibonacci | current-strict; candidate-strict | 0x10E0 | 0x1308 -> 0x1090 | [0x1090,0x10E0) | 0x10DF |
| fibonacci | checked; unchecked-int64 | 0x10C0 | 0x12DB -> 0x1090 | [0x1090,0x10C0) | 0x10B8, 0x10BF |
| loop_recurrence16 | current-strict; candidate-strict | 0x1410 | 0x176E -> 0x1090 | [0x1090,0x1409) | 0x1408 |
| loop_recurrence16 | checked; unchecked-int64 | 0x1120 | 0x143E -> 0x1090 | [0x1090,0x111D) | 0x111C |

For the three kernels × four RP variants × seven rounds, **all 84 `time-aot-r*` records** match the indexed program digest, binary SHA256, method name and runtime wrapper RVA; their program metadata selects AOT. This binds the table to the complete-call timing artifacts, not only the AOT builder's output. The collector's `artifact_executed:false` means the disassembly collector did not execute a binary; selection comes from the separately recorded successful audit/timing processes.

## Exact static counts: actual AOT versus actual C

These are static, nonpadding instructions in the selected function body. The categories partition the total. Integer-data arithmetic counts recurrence/Fibonacci values, excluding counters. FP-check instructions count integer-to-double conversion, floating multiply and floating compare. Other includes moves, XOR/AND/test operations, counters, status stores and prologue/epilogue. Neither static totals nor code size is a cycle estimate.

| Kernel / actual body | Total | Integer-data arithmetic | FP-check instructions | Conditional branches | Unconditional jumps | Returns | Other |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| recurrence_16 AOT current-strict | 214 | 32 | 49 | 33 | 0 | 1 | 99 |
| recurrence_16 AOT candidate-strict | 214 | 32 | 49 | 33 | 0 | 1 | 99 |
| recurrence_16 AOT checked | 34 | 32 | 0 | 0 | 0 | 1 | 1 |
| recurrence_16 AOT unchecked-int64 | 34 | 32 | 0 | 0 | 0 | 1 | 1 |
| recurrence_16 C exact | 33 | 32 | 0 | 0 | 0 | 1 | 0 |
| recurrence_16 C wrap | 33 | 32 | 0 | 0 | 0 | 1 | 0 |
| fibonacci AOT current-strict | 23 | 1 | 0 | 3 | 1 | 1 | 17 |
| fibonacci AOT candidate-strict | 23 | 1 | 0 | 3 | 1 | 1 | 17 |
| fibonacci AOT checked | 17 | 1 | 0 | 2 | 0 | 2 | 12 |
| fibonacci AOT unchecked-int64 | 17 | 1 | 0 | 2 | 0 | 2 | 12 |
| fibonacci C exact | 35 | 9 | 0 | 5 | 1 | 2 | 18 |
| fibonacci C wrap | 35 | 9 | 0 | 5 | 1 | 2 | 18 |
| loop_recurrence16 AOT current-strict | 228 | 32 | 49 | 34 | 0 | 1 | 112 |
| loop_recurrence16 AOT candidate-strict | 228 | 32 | 49 | 34 | 0 | 1 | 112 |
| loop_recurrence16 AOT checked | 41 | 32 | 0 | 2 | 0 | 1 | 6 |
| loop_recurrence16 AOT unchecked-int64 | 41 | 32 | 0 | 2 | 0 | 1 | 6 |
| loop_recurrence16 C exact | 38 | 32 | 0 | 2 | 0 | 1 | 3 |
| loop_recurrence16 C wrap | 38 | 32 | 0 | 2 | 0 | 1 | 3 |

**recurrence_16: 34 AOT versus 33 C.** Experimental AOT consists exactly of 16 `imulq`, 16 `addq`, one `movq %rdx,(%rcx)` result store and one `retq`. C consists of 16 `imulq`, 15 `addq`, one data `leaq`, and one `retq`. The one-instruction difference is AOT's caller-supplied result-pointer store. It is not an arithmetic/status check. The selected AOT routine does not include the extra `xorl %eax,%eax` status-return instruction seen in the earlier JIT ABI body.

**loop_recurrence16: 41 AOT versus 38 C.** Both have 16 multiply/add pairs and two loop-related branches. AOT has two moves (a stack load of `n` at `0x28(%rsp)` and result-pointer store), versus C's single move from input `x` to the return register. AOT's extra result pointer shifts `n` beyond the four integer argument registers. AOT also uses `incq` before the loop and `cmpq $1` before the `ja` backedge, whereas C uses `decq`/`jne` without those two instructions. The net three-instruction difference is one net move plus `incq` plus `cmpq`, not three safety checks.

**Fibonacci: AOT is not the unrolled JIT body.** All AOT variants use a scalar recurrence loop. Experimental AOT's positive path is `movq; addq; decq; cmpq; movq; movq; ja`, followed by the result store/return, with a separate zero-trip exit. C exact/wrap are unrolled eightfold, hence eight data-add sites plus one remainder-loop site. The earlier JIT preflight experimental body was also eightfold-unrolled (41 instructions), whereas the actual timed adapter is further transformed below. Do not explain AOT timing using either unrolled JIT body; do not equate AOT's smaller static body with faster execution.

Strict AOT recurrence/long-loop code still includes 17 `cvtsi2sd`, 16 `mulsd`, 16 `andpd`, 16 `ucomisd`, 16 `jae`, 32 `xorq`, 16 addition-sign tests, one byte-status comparison and a failure status write. Experimental AOT removes those data-overflow/status paths while retaining ordinary loop control where applicable. Binary x86 disassembly cannot itself reveal LLVM `nsw`/`nuw` flags; the prior JIT/source audit establishes those flag distinctions, and they must not be misrepresented as an AOT IR inspection.

## Actual C binding

C counts were reread from `processes/c-disassembly.stdout`, with named PE exports cross-referenced to `processes/c-exports.stdout`. DLL SHA256 recorded by the build is `b52385c4da2897e37e0ea729e1477edec26f1b7b4ac6c7c5a17bad018bcc5e88`. Kernel intervals end at the next exported kernel; padding is excluded and the final counted instruction is the last return.

| Export | Start RVA | Last return RVA | Following export boundary |
| --- | --- | --- | --- |
| recurrence_16_exact | 0x1020 | 0x1091 | 0x10A0 |
| recurrence_16_wrap | 0x10A0 | 0x1111 | 0x1120 |
| loop_recurrence16_exact | 0x14C0 | 0x1545 | 0x1550 |
| loop_recurrence16_wrap | 0x1550 | 0x15D5 | 0x15E0 |
| fibonacci_exact | 0x15E0 | 0x1661 | 0x1670 |
| fibonacci_wrap | 0x1670 | 0x16F1 | 0x1700 |

Signed C exact is valid on the no-overflow corpus only; wrapping C uses unsigned arithmetic. Matching machine opcode inventories do not license overflowing signed C calls. `batch_exact` calls its runtime kernel pointer at RVA 0x1770; `batch_rp` calls its adapter pointer at RVA 0x1937 and checks/reset status separately. These are different call boundaries and overheads.

## Actual timed adapters: 84 records inspected

For all seven rounds of the same 12 RP kernel/mode combinations, I compared `native_batch.selected_target_digest` with the AOT/JIT program digest, selected symbol(s) with the result's overload metadata, and recorded physical-call flags with actual LLVM call/definition topology. All 84 bindings match. All samples report positive completed native invocations and zero status failures; Region Python counter deltas are zero, as expected for native adapter execution. This is artifact/metadata verification, not a repeat benchmark.

The C loop invokes the cfunc wrapper; that wrapper calls the adapter core. The following describes the adapter core and whether its linked selected target remains a distinct call. Counts are static core instructions only, not the full cfunc wrapper, C batch loop, selected callee closure or dynamic total. Seven rounds give the same counts/topology in each row.

| Kernel | Mode(s), separately inspected | Core instructions | Physical selected-target call retained? | Selected target definition in adapter LLVM? | Observed optimization |
| --- | --- | ---: | --- | --- | --- |
| recurrence_16 | current-strict; candidate-strict | 54 | Yes, one | Yes | Builds native array argument ABI and calls selected strict entry |
| recurrence_16 | checked; unchecked-int64 | 38 | No | No | Selected arithmetic inlined into adapter core |
| fibonacci | current-strict; candidate-strict | 26 | No | No | Scalar strict loop inlined; overflow/status checks remain |
| fibonacci | checked; unchecked-int64 | 68 | No | No | Sixteen-step main recurrence loop, optional eight-step remainder block, scalar tail |
| loop_recurrence16 | current-strict; candidate-strict | 55 | Yes, one | Yes | Builds native array argument ABI and calls selected strict entry |
| loop_recurrence16 | checked; unchecked-int64 | 45 | No | No | Selected arithmetic/loop inlined into adapter core |

For retained strict targets, actual adapter assembly loads the exact selected symbol using `movabsq $<selected native symbol>, %rax` then executes `callq *%rax`; the LLVM has the corresponding selected-symbol call and linked definition. This physically retained machine call is implemented indirectly through the loaded symbol address, even though its target is statically bound in the generated adapter. The descriptor setup is visible as many stack stores before the call. The 54/55 core counts must not be compared to 38/45 as though they include the strict callee's arithmetic instructions.

For inlined targets, the selected-symbol call and standalone definition disappear, while the arithmetic/control flow appears directly in the core. Strict Fibonacci's LLVM `llvm.smax.i64` intrinsic is not a retained selected-target machine call; its machine code uses comparisons/conditional move. Experimental Fibonacci's adapter core has 25 static data-add sites (16 main-loop, eight optional block, one scalar tail), plus two counter-adjustment `addq` instructions, explaining its 27 `addq` total. Other loop-related LLVM additions may carry no-wrap flags; data additions remain the wrapping chain.

The actual adapter has therefore changed the comparison in two ways beyond arithmetic checks: strict recurrence/long-loop retain an additional native ABI call that experimental code inlines away, and experimental Fibonacci undergoes another unrolling transformation. Native-batch speedup must not be attributed entirely to the helper/status checks. It is a measurement of these complete selected adapter paths, including C-loop indirect call/reset/check work. It is not AOT performance and does not count Python Region calls.

## Reporting conclusions and limits

- Actual AOT confirms removal of the intended arithmetic checks; all requested wrapper-to-native mappings and all 84 complete-call timing selections match.
- AOT selected bodies differ from both cold JIT and timed adapters. The Fibonacci scalar/8-way/16-way distinction is material to any explanation.
- Native adapter comparisons include mode-dependent inlining and ABI setup. Report that limitation alongside any speed ratio; source-site counts cannot isolate its contribution.
- The prototype's Python binding costs live outside these native bodies. None of these static counts predicts complete-call speed or validates later binding-optimized timings.
- No new correctness or selection mismatch was found in the inspected AOT/adapters. No AOT LLVM flags, live instruction counts, cycle counts or hardware-counter claims are made.

## Artifact-specific bindings

The appendix below records each actual binary/digest/disassembly binding and the round-zero adapter artifact hashes/symbols as examples. All seven rounds were checked for each pair as described above. Hashes are read from the existing producer records; artifacts were not rehashed during the concurrent work.

### fibonacci / candidate-strict

- Program digest: c186324c1dab4c37d8b0c0431cd34e72748e7dab3c1144e8e320364dd9f42dcf
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/candidate-strict/fibonacci/rcaotr_b19cba7e9f83b6770fdb3d59.cp314-win_amd64.pyd
- Binary SHA256: 1b7a7ef7830c390184daee4e487edcf1a588a13853861a9c6d58f7398de167f0
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/fibonacci-candidate-strict.asm
- Assembly SHA256: 460d8bad6c6d6e770907cc14d818ea0c57ac88d9b17a6227788ca45c7baad9a4
- Audit SHA256: aab3475c3a80d173de5f44b308a36e2ac83a44d52ef3f59ad6ea7d47f324cc6b
- Extension method: r0; wrapper unwind interval: [0x10e0,0x13f2)
- Reachable native branch targets: 0x10dc, 0x10d7, 0x10b0, 0x10da
- Round-zero adapter cell: cells/native-r0-fibonacci-candidate-strict
- Adapter LLVM SHA256: 78d47c7b2bf2591b1f4a44d9f4fb053250f9d1b1028956cac28084d2ba2ebdd4
- Adapter assembly SHA256: 91f57068fa33e476586fead7ab7d1525a54ab3161d16e25eee4343057c94909b
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: false): _ZN32rc_heap_76885d8ba89d2be1fa3724cd12f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx

### fibonacci / checked

- Program digest: f758397a0d1850fac42cfbc416788a259098c500010373bc56f4c1e71cb46d73
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/checked/fibonacci/rcnumeric_f758397a0d1850fac42cfbc4.cp314-win_amd64.pyd
- Binary SHA256: 0f5ec0f54ad7e92c0968d21d5a38352c7af4a4a87a573ebadab6db0c5029de8e
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/fibonacci-checked.asm
- Assembly SHA256: 3ae2d8785a04eb6d4f93a88d3df1332304d1099f797bf9804531ecae406871a2
- Audit SHA256: bdd441aea77ac31168a291df3428c901be24389534d97aeca5e4ce6c4c4f4b4c
- Extension method: entry; wrapper unwind interval: [0x10c0,0x13c3)
- Reachable native branch targets: 0x10b9, 0x10a0
- Round-zero adapter cell: cells/native-r0-fibonacci-checked
- Adapter LLVM SHA256: d6f85a5e5bcbb33771f21b4749e3a9f4400196f5d6a378f2a86696a5b2aaebd2
- Adapter assembly SHA256: 77faf78711992d574a9440aa160676685dfce0595c5c86166e2c6589ffcf4a19
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: false): _ZN32rc_heap_85f07cc79ec7251995a7229812f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx

### fibonacci / current-strict

- Program digest: ee0a347fd88aadd48b9fa9faa9d66558f7eeb85c1b8aad2713a77af4949b6c2d
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/current-strict/fibonacci/rcaotr_a8fcc7b14a6c3e5e54741004.cp314-win_amd64.pyd
- Binary SHA256: 5dbb17aa56cca34c2cab767e8715fecd3a7140eb6eac3d4428b21caa827345a0
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/fibonacci-current-strict.asm
- Assembly SHA256: 802ed4447bf3ebd68d7a775217ac63aa13f5098aa4677a80801ac0a9ac1ca59c
- Audit SHA256: 0226568dbd6265fd255ec44fc8da3636a04eeeb96fa87b87e253ba8e51d3f657
- Extension method: r0; wrapper unwind interval: [0x10e0,0x13f2)
- Reachable native branch targets: 0x10dc, 0x10d7, 0x10b0, 0x10da
- Round-zero adapter cell: cells/native-r0-fibonacci-current-strict
- Adapter LLVM SHA256: fe1c35adf521fdf9f686e887dc71c885add37fdfb52979d984ef38f59b7c3996
- Adapter assembly SHA256: 044446580fcdb86f21715a3d36be4c55be15abdd1dde1e6d3bc0a1e116a6e88f
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: false): _ZN32rc_heap_16371f099018d0a4b008fe1912f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx

### fibonacci / unchecked-int64

- Program digest: 3d36deac3a8cae31652c24de249ff57bd31092f1313e44ddbb25ea31a1db51be
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/unchecked-int64/fibonacci/rcnumeric_3d36deac3a8cae31652c24de.cp314-win_amd64.pyd
- Binary SHA256: 94e9ef27261d11dbffd11d98d314cfac0f9f990d0e3b3cde332f68e3fd5b25db
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/fibonacci-unchecked-int64.asm
- Assembly SHA256: af4079ec60368407b273ca471e8af6de9937e6b928809de1ea597befd13d0dec
- Audit SHA256: 7b79c70165a20767303d91f4e94f3e9da6c323d14f871907fa0cc12cc41df50e
- Extension method: entry; wrapper unwind interval: [0x10c0,0x13c3)
- Reachable native branch targets: 0x10b9, 0x10a0
- Round-zero adapter cell: cells/native-r0-fibonacci-unchecked-int64
- Adapter LLVM SHA256: d1b2f4b93d7fc646e3e839f5bb0707079872396ad167c5f59b2b66cf660ee66a
- Adapter assembly SHA256: 23c9d66e368493bcb323dfc6d6407bc8797df88ddef44b51b4e6c72ca86218d6
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: false): _ZN32rc_heap_fd62efb1f1d505f678775a8112f0_fibonacciB3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedEx

### loop_recurrence16 / candidate-strict

- Program digest: c318ac0fb823ace0893838672f7321dabfa801a694eb2bfff5dd039fc66b26ee
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/candidate-strict/loop_recurrence16/rcaotr_17d17a09c42e57a4da3f958e.cp314-win_amd64.pyd
- Binary SHA256: a0354449708e8841edd6087ab2234c2fb3382e4f6cc29662091d9f75a3d29222
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/loop_recurrence16-candidate-strict.asm
- Assembly SHA256: 7f7d180143f491be1e9701b7576241b1bf43e1eb5d87823c0c683ccf18834774
- Audit SHA256: 322ac8c20ec243767bc6565efd3b4a7a5856f7aa2dc95636cc80e6c97a87daba
- Extension method: r0; wrapper unwind interval: [0x1410,0x188e)
- Reachable native branch targets: 0x1404, 0x13fe, 0x1401, 0x10bd
- Round-zero adapter cell: cells/native-r0-loop_recurrence16-candidate-strict
- Adapter LLVM SHA256: 8bb51d71f67a19e978cb6a5b23b85e7e0a520f50cc0a62a9fbf5c08e68a289e5
- Adapter assembly SHA256: db55033dfb5caaef45a462a010a84ee21482d9ed9da915d0c9c64a69c3e88730
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: true): _ZN32rc_heap_73547edce78f3bbe0466b8e920f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx

### loop_recurrence16 / checked

- Program digest: 202f683b665d056f07b8d3ed299c5069eafddc74cf520492d703e67087cba0b6
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/checked/loop_recurrence16/rcnumeric_202f683b665d056f07b8d3ed.cp314-win_amd64.pyd
- Binary SHA256: 2debec473a749846fbbb6f98dbd08c993791a31f5d2ea19f1b8c548d176c960b
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/loop_recurrence16-checked.asm
- Assembly SHA256: 558b8e366b3b4fe74f573f7e22832e93763885261008f5b64693977d5c1d1679
- Audit SHA256: 6f0764d4d33a118f48cf85bff230bfccf815789e45caf1a234553dbb53c5dde6
- Extension method: entry; wrapper unwind interval: [0x1120,0x156b)
- Reachable native branch targets: 0x1119, 0x10a0
- Round-zero adapter cell: cells/native-r0-loop_recurrence16-checked
- Adapter LLVM SHA256: d10a08199be1bb725aff0d3101d920e31d303bd5890ab658c76a1cc32965b7e0
- Adapter assembly SHA256: 5fe3dc3bacd26b95c28012af86541ad48737721f877511f066a6e3a5f5b2e9ac
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: false): _ZN32rc_heap_ec96b18ef2b3e13226bd6fd620f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx

### loop_recurrence16 / current-strict

- Program digest: a28d914bd450093c6bfdc6ea80dfe30a1c9e2ff872fae91491094943a721cffe
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/current-strict/loop_recurrence16/rcaotr_0cedc59f0901480dc0803d7c.cp314-win_amd64.pyd
- Binary SHA256: ec986eb99be91996bc56b828a7b8aa6b47a60ba9a49e7df64d4890c83a2fb036
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/loop_recurrence16-current-strict.asm
- Assembly SHA256: b7265b824a2eb4131b62a3e6042147e24a8befe19673fc3dc5c93a4bf02f31cb
- Audit SHA256: 050d52d4b8fe7462db363f9b83fcc3d1373d44aa5a218bad5ea2fe3d811003bd
- Extension method: r0; wrapper unwind interval: [0x1410,0x188e)
- Reachable native branch targets: 0x1404, 0x13fe, 0x1401, 0x10bd
- Round-zero adapter cell: cells/native-r0-loop_recurrence16-current-strict
- Adapter LLVM SHA256: 07a9079d17613dac582c497322b4caa2b838cbf201a991b998843c651e632d7e
- Adapter assembly SHA256: 485dee6a0cb2fff992e7716dd11fca06233f1a60e4ed140bb34628a45ef134b8
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: true): _ZN32rc_heap_a840a9a92cd3a10be28522e420f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx

### loop_recurrence16 / unchecked-int64

- Program digest: 123ef0b2d30a1c1895b018d663448026d600339ae6695cf43e8d0fc480092a42
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/unchecked-int64/loop_recurrence16/rcnumeric_123ef0b2d30a1c1895b018d6.cp314-win_amd64.pyd
- Binary SHA256: 2c5621d5bb64a51bf3d34b87797a2d220c55bf272ae867287ba219f7608f3c4c
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/loop_recurrence16-unchecked-int64.asm
- Assembly SHA256: 232847b2427878616b5431da0c84232dcd6fb73ead92c1d3d1e022fa60863c5c
- Audit SHA256: e26ae24297c0026552ff22eadb32862d29e9481a2cacfb516e4bf5111194e00f
- Extension method: entry; wrapper unwind interval: [0x1120,0x156b)
- Reachable native branch targets: 0x1119, 0x10a0
- Round-zero adapter cell: cells/native-r0-loop_recurrence16-unchecked-int64
- Adapter LLVM SHA256: 40bf8ab2a01c4f15bad30121a59f222dd464868140ab7dcbb76e113ae8c2d5ee
- Adapter assembly SHA256: 6b4e1e31f7492c5eaf2dad7c8a7f5407f6e7c614f4efbe52047267204dd51398
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: false): _ZN32rc_heap_90b0c6f3cf785308b7ee93d320f0_loop_recurrence16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxxx

### recurrence_16 / candidate-strict

- Program digest: 3dbef551048c2605ccb464c876eb733b4acec969cd2180c482875d7de6ead964
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/candidate-strict/recurrence_16/rcaotr_aaf42c2db6d9b748cf4faa74.cp314-win_amd64.pyd
- Binary SHA256: 427da7917b8e2b5178020858aaa37c2a48478fde9e9cae0c1e2cf78692c36da0
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/recurrence_16-candidate-strict.asm
- Assembly SHA256: aacea5ee3fdc00fcde1b3fa2460c91e4f254aa47c0088be1484d0fa41e7c1b21
- Audit SHA256: 6e0715771c547437e08c19e38575825ffc8df2fdc3e8c14500317028b0830fd8
- Extension method: r0; wrapper unwind interval: [0x1450,0x1843)
- Reachable native branch targets: 0x1445, 0x1448, 0x144b
- Round-zero adapter cell: cells/native-r0-recurrence_16-candidate-strict
- Adapter LLVM SHA256: 7a084c64c69643a5d571e4985cd47984335bd4165ff7d64b0e9054e1a5f31462
- Adapter assembly SHA256: e9dc9148f5e723a4ea6340135ad84316c9a5515ca6abee293b608355fe0120ae
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: true): _ZN32rc_heap_0bc4322814ec5c10910c668416f0_recurrence_16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx

### recurrence_16 / checked

- Program digest: 7b35aa9c6f39bd13153c7a767f40755c60cf0e9c87bc7fdcc1838c5e0c0e7a4a
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/checked/recurrence_16/rcnumeric_7b35aa9c6f39bd13153c7a76.cp314-win_amd64.pyd
- Binary SHA256: adf5f757e6332fdea5da371603ba530c730afc22e177a1673586e45930c5887c
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/recurrence_16-checked.asm
- Assembly SHA256: 120f9a1c2ef342b43cb3932986c96e51e4dccd233e7915109150942ed2d7463b
- Audit SHA256: f5a13d57daa084a8f58ab236ad95dbd838d7d714b72e28ef5f996a752646c451
- Extension method: entry; wrapper unwind interval: [0x1110,0x14e2)
- Reachable native branch targets: none
- Round-zero adapter cell: cells/native-r0-recurrence_16-checked
- Adapter LLVM SHA256: c8e09ef5bfc6af07a3f24a372952f23a8206e37442b7ac12f036538dc0fbc364
- Adapter assembly SHA256: 4d47a5c0359038228e1cb5087aef9b218dd90473093e69eafd9aad35621fa63f
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: false): _ZN32rc_heap_a044c7d78212f1595140e8fa16f0_recurrence_16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx

### recurrence_16 / current-strict

- Program digest: 7418cd63af9cd8b24ce0a5c926626eeee1a09fcb7cf83a558df6dcf1202b4e8c
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/current-strict/recurrence_16/rcaotr_f4280ac84c2bd72a00920277.cp314-win_amd64.pyd
- Binary SHA256: 1697f5f1350761f4007cabda8f95b3a95dff655208a755239a0b35fa8072a18e
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/recurrence_16-current-strict.asm
- Assembly SHA256: 49e0122708e90586dbc753f6a5347ddce3ca5223cef549a20fe141eec25dd3e2
- Audit SHA256: dcd8ceb9b4dfbfdaec27fd6235a8b81813972d235a229c105962ca1491b0ac93
- Extension method: r0; wrapper unwind interval: [0x1450,0x1843)
- Reachable native branch targets: 0x1445, 0x1448, 0x144b
- Round-zero adapter cell: cells/native-r0-recurrence_16-current-strict
- Adapter LLVM SHA256: e2a2b99ed4370f247bc5ed7618a35a5de91ab7fdf2dbe6b4307db03c794beecd
- Adapter assembly SHA256: d42ea13b2f7c1c2f073d0160ef2e7ad18d4fdb2e4bdccb9f670bd349e6a202de
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v14B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: true): _ZN32rc_heap_2b6ae51a3c827ac03ab1c7cf16f0_recurrence_16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx

### recurrence_16 / unchecked-int64

- Program digest: c22eebaf1fa306f6be37fd80b0f91fa703feaad7355c86ef97721d5f2c9d7ccf
- Binary: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot/unchecked-int64/recurrence_16/rcnumeric_c22eebaf1fa306f6be37fd80.cp314-win_amd64.pyd
- Binary SHA256: 6eb50c552a442ede55647eac036406d3252ab26a6526f8eccc05ee6975a5d891
- Assembly: D:/Code/Datathon/recompyler-codex-20261111/wave10-measurements/results-formal-v1/aot-assembly/recurrence_16-unchecked-int64.asm
- Assembly SHA256: 0c79fea489474add5b0c53bce247dd89c0b0ba0f160311b1d3bbed781f481217
- Audit SHA256: 15026dc7de941eb734163a03756884ae6e5079d830f4fdda2b0c4b88f4632adc
- Extension method: entry; wrapper unwind interval: [0x1110,0x14e2)
- Reachable native branch targets: none
- Round-zero adapter cell: cells/native-r0-recurrence_16-unchecked-int64
- Adapter LLVM SHA256: b236b72f69e90e1919ceb7fa75360b27551b244b9a961be975ae64c0329e55a9
- Adapter assembly SHA256: 7d506cc83cdd7b40ba7def6d084ee77d5283af32139b73f216dfe0d5901fb7b9
- Adapter core symbol: _ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Adapter C entry symbol: cfunc._ZN13_3cdynamic_3e7adapterB3v12B52c8tJTIeFIjxB2IKSgI4CrvQClUYkACQB1EiFSRRB9GgCAA_3d_3dE10float64_2a8int64_2a8int64_2a8uint8_2axxxx
- Selected target symbol (retained call: false): _ZN32rc_heap_a39a8e178a9a302942ae2ac216f0_recurrence_16B3v11B44c8tJTIeFIjxB2IKSgI4CrvQCk0Z4yRYcWsBAK4JIagIAE5ArrayIdLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIxLi1E1C7mutable7alignedE5ArrayIhLi1E1C7mutable7alignedExxx
