# Actual AOT instruction change: Barnes–Hut

The measured candidate binary removes the intended object-field negative-index adjustments. One identified total-mass load shrinks from five instructions to one; center/position field loads also become direct. List-header/index adjustments, numeric-kind checks, recursion/status handling, graph layout, and Python boundary costs remain. This is confirmation of the machine-code change, not a cycle attribution or speedup inferred from instruction counts. Timing results belong to the separate `wave5-study` study.

## Exact artifacts inspected

The study froze baseline `3f0370d5fe5c358b4a0b3fd8e1ea10a2f22f87bf` and candidate `e35dce1b7cef4019400696a9d7712ae8571a0b81`. Independent forced-mode audits identify **500 successful AOT calls, zero JIT, zero fallback and no Numba import** for each inspected Barnes artifact. Mapping is based on those successful calls, not mere export availability.

| | Baseline | Candidate |
|---|---|---|
| Selected export | r0 | r0 |
| Source/seed digest | `eabc9168344178edfe14396b2bb28bfe114e71f6a567618667853a68b61a627b` | `a0f9dde9c40c4c638a5a799fba1be65e7c353ab533d9f75c68334174b1f19c1f` |
| Artifact | `rcaotr_2c76336ff39711e0671e54df.cp314-win_amd64.pyd` | `rcaotr_2fe5e05e91a653421cd9997e.cp314-win_amd64.pyd` |
| Artifact SHA256 | `aa2eb8d294278e83f30114866303abe52ad475a9e489cf5d4fd3559b685dfd7c` | `226403d22c98758ad52a79d49d3daf4641f9e2cdd6b1cad9c6e23a11e5f7bc9e` |
| Python C wrapper | `0x180001d20` | `0x1800019e0` |
| Native entry | `0x180001090` | `0x180001090` |
| Recursive force | `0x180004040` | `0x180003c20` |
| Merged insert/subdivide | `0x180005180` | `0x180004a80` |

All paths, artifact/plan/audit hashes, compiler source hashes and exact selected-export metadata are in `provenance.json`. The mapping payloads are the study's `results/diagnostics/{baseline,candidate}-aot-map.payload.json`, reused without importing either extension again. Their artifact, plan and audit hashes were independently checked during extraction.

Actual wrappers call the native entries at baseline `0x18000234a` and candidate `0x18000200a`. Entry helper calls identify force at `0x180001954` / `0x1800017c6` and insert at `0x1800016bf` / `0x18000155b`. Force recursively calls itself four times in each binary. These are stripped PEs: helper names are inferred from these call sites, recursion and matching operations; objdump's nearby exported-name labels are **not** real helper symbols. Addresses use the preferred image base.

## A direct before/after example

`QuadTree.total_mass` occupies floating heap slot `self+9` (byte offset0x48). The baseline must normalize an otherwise-negative NumPy index:

```asm
1800040c7  xorl   %eax, %eax
1800040c9  cmpq   $-0x9, %rsi
1800040cd  cmovlq %rdi, %rax
1800040d1  leaq   (%r12,%rsi,8), %rdx
1800040d5  movsd  0x48(%rdx,%rax,8), %xmm0
```

The candidate knows this final physical field address is nonnegative:

```asm
180003c9f  movsd  0x48(%rbx,%r13,8), %xmm0
```

This is five to one static instructions for the **identified load sequence**, not a fivefold speedup. Register allocation and nearby scheduling differ. Exact slices are `baseline-force-mass.asm` and `candidate-force-mass.asm`.

The center/position chain also changes. Baseline `0x18000416a–41ec` has several `cmpq`/`cmovlq` and `sarq $0x3f`/`andq` corrections for object handles and field offsets. Candidate `0x180003d2a–3d4d` directly loads the center Point handle, its value/tag, and the particle position Point handle/value/tag. See `baseline-force-fields.asm` and `candidate-force-fields.asm`.

## What remains, intentionally

Candidate `0x180003cdf` directly loads the QuadTree particle-list handle, then `3ce7–3cf2` still uses sign extraction and an array-length correction to read the **list length**. `3cfc–3d04` normalizes the list data-pointer slot; `3d0d–3d14` normalizes the list element read. These container paths were outside the proved object-field scope. `candidate-remaining-list.asm` makes the distinction explicit.

The candidate still checks MIXED numeric flags (`3d35/3d44`), combines them (`3d52/3d55`), and checks exact-integer range (`3d59–3d6d`). It still has recursive calls, null-child checks, depth/status handling and the same `0x1e8` local stack reservation in force. It still traverses separate Point/Rectangle/list handles. The kernel still uses scalar hardware square root: baseline `0x18000434c`, candidate `0x180003e40`. Packing/guards/write-back around each region invocation are not optimized by this change.

For orientation, the address-bounded force spans produce these **static** counts:

| Force range | Baseline | Candidate | Matched C |
|---|---:|---:|---:|
| Range bytes, including alignment before next helper | 4416 | 3680 | 480 |
| Disassembled instruction lines, including padding | 772 | 632 | 116 |
| `cmovlq` | 18 | 1 | 0 |
| `sarq $0x3f` | 5 | 2 | 0 |
| Negative-immediate `cmpq` | 18 | 1 | 0 |

Counts use the entire selected force function, including cold exits and all branches. They are not dynamic frequencies, cycle counts, or equivalent total-work ratios. In this function the remaining candidate normalization patterns correspond to the list accesses above. Do not extrapolate “18→1” to all program checks or all heap accesses.

## Comparison with unchanged C

The study's copied C executable has SHA256 `4fd003eeea3b3bf997c90889340719fd71e8f698da5feca673ece46e9418f9ff`, byte-identical to the previously verified Wave4 C binary. It was independently disassembled here as `c-barnes_hut.asm`. Its force function begins at `0x140002710`, recursively calls itself at `2814/2844/2870/2899`, and uses `vsqrtsd` at `278c`.

C loads center values directly at node offsets0x38/0x40, multiplies the particle index by56, then subtracts particle coordinates (`0x140002761–2779`). Candidate RP has eliminated field index wrapping but still follows Point handles and carries numeric-kind flags. C's flattened fixed representation and narrower Python-semantic obligations are unchanged; this optimization does not make those representations equivalent. See the prior `wave4-instructions/c/REPORT.md` for the matched-work and lifetime caveats.

A supplementary read-only nbody control check, requested by the study agent, compared the existing ordinary-lifter AOT PE sections: `.text` bytes and `.pdata` are **identical** baseline/candidate; `.rdata` differs. `nbody-sections.json` records paths, hashes and audits. This rules out changed nbody machine instruction bytes in those artifacts; it does not prove identical whole-process performance or explain timing variation. No extra nbody disassembly, import, execution or timing was performed.

## Extraction and limits

Used the installed `C:/Users/grant/AppData/Local/Programs/Swift/Toolchains/6.3.2+Asserts/usr/bin/llvm-objdump.exe` with `--disassemble --demangle --no-show-raw-insn` on the three existing PE artifacts. `extract.py` checks provenance and writes address-bounded slices/static counts; `compare_nbody.py` only reads PE section bytes. No kernel or artifact was imported/executed by this analysis, no compiler ran, and no tests, profiling or timings were performed. Source/tests and historical Wave3/4 evidence were not changed.

No generated source or LLVM was reconstructed in this wave. The report binds to the study's actual successful-export digest and actual binary hash, without claiming a new independent source-reconstruction digest check. The next interpretation step is to combine these confirmed instruction changes with the study's separately collected kernel/process samples and phase attribution.
