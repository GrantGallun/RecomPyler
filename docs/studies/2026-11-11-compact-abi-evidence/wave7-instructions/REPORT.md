# Compact recursive ABI: actual AOT, current compiler and C

The compact calling convention is present in the **actual successfully selected Barnes-Hut AOT binary**, and this unchanged-source study shows an observed improvement: **47.4918 → 35.8288 ms**, or **24.558% less kernel time / 1.32552x speedup**. The fresh C reference is **9.115458 ms**. RP therefore moves from **5.21003x to 3.93055x C's whole-kernel time**. These are fresh current/candidate measurements, not comparisons against an older historical timing.

The machine-code change is substantial and directly traceable: each recursive force call writes **6 outgoing eight-byte stack argument slots instead of 29**. The force body falls from **524 to 341 static instruction lines**, and its local stack reservation from **488 to 280 bytes**. The six coordinate exactness-bound comparisons and tagged numeric results remain. Static differences explain what changed; they do not assign a numerical fraction of elapsed time to individual instructions.

## Artifact and call-chain identity

Current baseline is integration `5d0fe5296e077b893a0d9c920f6ccfe798696eeb`, product `9ff4908fdc58613d72287f71cfc6b70aa5e693ff`. Candidate is `a033ca14c40afed052a6266a0a575f6cc11559ea`. Candidate `heap.py` SHA256 is `38b77af3e77c73b132db4d973242eb30e8cbc590003b7cb9820e7430c9b3edd6`.

| Actual selected artifact | SHA256 | Successful digest |
|---|---|---|
| Current `rcaotr_d69a5295b7dfe3ae8e1e45a1` | `94afcc7bfed19eeb450e1f3aae3fe0f37aab6e48ba1e08ae1f3122997e4e2fda` | `ab7a5260a3ecad9c50cc0b5ca7997455e7a913b7da1c1c35ccdfc32c43c50e2a` |
| Candidate `rcaotr_b767982c3d43c6022e2cef09` | `76a7b0c2a9475553633ed9aa1621d27bdb4af76abdd3e5cbfeb2b5b37f6ea564` | `8b850a3ec40ed1c9992ac80e245679f7e785fa6b866f2c2a6a64d7f9f892e495` |

Each state audit binds export `r0` to 100 successful AOT calls, zero JIT/fallback/rejected/unknown calls and no Numba import. Static PE `PyMethodDef` mapping agrees with the study's independent runtime wrapper maps. Complete plan/audit/tool/assembly hashes and commands are in `baseline-provenance.json` and `candidate-provenance.json`; `verification.json` independently checks them against the frozen inventory.

The candidate chain contains an extra native adapter level, so choosing the old address as the workload body would be wrong:

| Stage | Current | Candidate |
|---|---|---|
| Python AOT wrapper `r0` | `0x1800019e0` | `0x1800011d0` |
| Wrapper calls native array entry | call `0x18000200a → 0x180001090` | call `0x1800016af → 0x180001090` |
| Array adapter to borrowed advance | No separate adapter level | call `0x180001195 → 0x1800025d0` |
| Advance calls recursive force | call `0x1800017c6 → 0x180003c20` | call `0x180002a1e → 0x180002c30` |
| Force self-call sites | `0x1800040fe`, `4333`, `4552`, `47b4` | `0x180002f78`, `3034`, `30e4`, `31d5` |

Addresses in abbreviated entries retain the same preferred image base. Internal boundaries are inferred from source structure, call targets and the next helper start; nearest-export `PyInit_*+offset` labels are not internal function names. Global counts over the whole multi-export PE would mix different compiled bodies and runtime support code. This review follows the actual `r0` path.

This inspection only reads PE bytes and disassembles them. It imports no measured extension and runs no kernel, build, profile or timing job. Earlier Wave6 evidence is unchanged.

## What became smaller

| Scoped recursive force body | Current | Candidate | Unchanged C |
|---|---:|---:|---:|
| Address range | `0x180003c20..4870` | `0x180002c30..3260` | `0x140002710..28f0` |
| Inferred span, including possible padding | 3,152 bytes | 1,584 bytes | 480 bytes |
| Static instruction lines | 524 | 341 | 116 |
| Lines with stack operands | 275 | 69 | 22 |
| Local reservation (`sub rsp`) | 488 (`0x1e8`) | 280 (`0x118`) | 88 (`0x58`) |
| Outgoing stack argument slots per recursive call | 29 | 6 | 0 beyond register arguments |
| Comparisons referencing exact `2**53` | 6 | 6 | 0 |
| Recursive self-call sites | 4 | 4 | 4 |

Frame reservations exclude pushed registers and the return address. Stack-operand lines include arguments, saved registers, local values and return buffers; they are not a count of spills. C uses stack locals for two output values, but passes their addresses in registers. The table is static structure, not dynamic instructions, traffic, cycles or an optimality claim.

Current recursive setup writes slots `0x20..0x100`; candidate writes `0x20..0x48`. `verification.json` checks all four sites separately. At the candidate's first call (`candidate-first-call.asm`), the six slots hold top pointer, status pointer, common arena length, child handle, particle handle and theta. F/I remain in registers alongside the native result pointer and hidden exception argument slot. Four one-dimensional ndarray descriptors previously expanded to 28 context fields; the five borrowed context values remove 23 arguments from this path.

The first candidate call setup is small enough to inspect directly:

```asm
180002f4b: movsd %xmm6, 0x48(%rsp)  # theta
180002f51: movq  %rdi, 0x40(%rsp)   # particle
180002f56: movq  %rax, 0x38(%rsp)   # child
180002f5b: movq  %r14, 0x30(%rsp)   # arena length
180002f60: movq  %rbx, 0x28(%rsp)   # status pointer
180002f65: movq  %rsi, 0x20(%rsp)   # top pointer
180002f6a: leaq  0xc0(%rsp), %rcx  # tagged result buffer
180002f78: callq 0x180002c30
```

The excerpt omits intervening saves of F/I registers; complete instructions are retained beside it. The force body contains only its four self calls, with no added refcount-helper or heap-allocation calls. Runtime NRT helpers and Python-wrapper decrefs still exist elsewhere in the PE; this is not a claim that the whole module has no reference counting. Independent fixture LLVM additionally binds the actual recursive function symbol, proves two self calls, and checks all borrowed bodies for surviving NRT ownership/allocation calls and false F/I `noalias` attributes.

## What deliberately remains different from C

1. **Numeric kinds and checked arithmetic.** Candidate force retains six RIP-relative comparisons against bytes decoded as exactly `9007199254740992.0`. These are in the coordinate subtraction/square/sum path, at `0x180002d3d`, `2d7d`, `2d93`, `2db2`, `2dc0`, `2dd9`. Unknown input fields still permit integer values; the earlier zero-fact proof cannot remove these checks. C stores untagged doubles. Candidate returns doubles at offsets 0/16 plus kind bytes at 8/24 (`0x180003242..3253`), including integer-zero base cases; C returns only two double outputs.
2. **Shared error and recursion state.** Candidate keeps the depth increment/limit comparison before recursive calls, status-byte check after them, error-location stores and depth decrement. C has neither the Python recursion/fallback contract nor this shared status ABI. Both still have four child-presence branches; compact argument passing does not eliminate tree traversal.
3. **Handle-based object layout.** Candidate reads a center handle at `0x180002d01` and a particle-position handle at `0x180002d16`, then accesses their numeric slots. The source C `Node` embeds center/boundary doubles, particle indices and child pointers; `Particle` is a contiguous record array accessed through a global base and index. Candidate list-handle indexing also retains signed normalization where needed. No fields were flattened, numeric layouts changed, or arena lifetimes shortened by this patch.
4. **Still-different call interfaces and values.** C recursive calls pass node, particle index and two output pointers in four registers. Candidate still carries five context scalars, semantic arguments and backend result/exception convention. C loads theta from a constant pool; raw PE bytes at `0x1400042f8` are exactly `0.5`. Candidate loads theta from its argument and passes it recursively. Guarded value specialization could change this later; this patch does not assume the observed theta for arbitrary calls.
5. **Compilation and whole-workload boundaries.** RP AOT uses a generic CPU target; C was compiled with `-O3 -march=native -ffp-contract=off`. C uses scalar VEX floating instructions here, not a demonstrated vectorized tree traversal. The ISA/tuning contribution remains unmeasured. C also has fixed representation and explicit tree-allocation/free choices. RP's timed kernel includes Python region loading/writeback and final Python energy; this ratio is not native-force time divided by native C force time.

The C binary is the same SHA256 `4fd003eeea3b3bf997c90889340719fd71e8f698da5feca673ece46e9418f9ff`; `c-force.asm` is an exact copy of the prior same-binary excerpt, checked by hash. The C port is a comparison implementation, not proof that its assembly is optimal. Layout, tag liveness and guarded-value specialization still require their own proofs; making the call interface smaller does not justify dropping those contracts.

## Measurement, state and scope checks

The frozen primary study has five rotating fresh-process samples per mode. RP/Python report the best of five reset-state kernels per process; C reports the best of 20. Candidate kernel samples span **35.0590–36.5932 ms**; current spans **46.9036–50.7206 ms**, with no overlap in this cohort. Whole-process medians are **559.6180 → 511.8625 ms** (8.534% lower). All 20 timing processes passed; each RP version has 2,500 successful AOT calls and zero JIT/fallback. Unknown background load remains; no formal statistical-significance or OS-wide-quiet claim is made.

Separate instrumented warm medians are native entry **30.6576 → 17.4821 ms**, load **10.4110 → 9.8389 ms**, writeback **3.6494 → 3.5889 ms**. They support locating the improvement within native execution, but instrumentation/independent processes and nonadditive medians prevent assigning an exact share of the ordinary timing delta. Both phase runs report the same 7,538-slot allocation high-water and 512 KiB capacity, with zero growth retries; this patch did not obtain its result by grouping steps or changing transient-tree lifetime.

Cold `program_for` measured **47.990 → 65.311 ms**, one observed invocation per side. This includes saved-graph/source reconstruction, AOT preparation/validation and nested loading; it overlaps other timers and is not pure source-generation cost. Candidate combined capture/verification/AOT profiling took 65.1603 seconds. The baseline's 56.7311 seconds is reused historical profile evidence, not a fresh paired build-cost comparison.

The reviewer independently compared all 100 step sets and numeric/type/alias hashes plus full initial/final vectors to plain Python; all match with no type relaxation. Three separate generality controls—recursive object reduction, mutable containers/negative indices, and object/tuple returns—have valid plain/native outputs and eight actual AOT calls per compiler per case, zero JIT/fallback/rejected/unknown. They establish bounded generality/behavior, not an extra speed claim.

Manifest SHA256 is `308adefb126b9d36f4742ec29bb4590f807d2955293f168aa2c90d0dd6bcaabc`. The frozen source comparison includes an LF/CRLF difference in `_region_seed.py` as well as the semantic `heap.py` change. Independent normalization confirms identical seed source content; its different raw hash remains correctly preserved in source/artifact identities. No source or historical evidence was normalized or rewritten to hide this difference.

The final independent code review is clear. Full validation passed 465 tests and 52 subtests; a later test-only precision improvement passed its affected test with unchanged product bytes, as recorded in `wave7-analysis/abi-review.md`. This is a general recursive-region ABI transformation, with ordinary nonrecursive regions unchanged. It preserves the supported Python/Region contract and shows an observed Barnes improvement in the retained cohort; it does not establish universal Python-to-C parity or attribute the remaining 3.93x ratio to one cause.
