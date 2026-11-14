# New wave10 measurements

This directory owns only new reproducible tools and evidence. Product changes
are in the separately owned mode and coverage workers. The current comparison
is clean strict integration `1d4084f914fa9594ecb801e3efa565edcd7e1241`.

Read `PROTOCOL.md` before running. At authoring time none of these tools has been
executed. An explicit coordinator CPU grant is required before any build,
profile, test, workload or timing. Source/corpus preparation does not import the
product, NumPy or Numba. Its manifest freezes the exact source/runtime/helper
inputs. Choose a new output directory for each source/cohort; tools reject
existing records.

Files:

* `prepare.py`: snapshots current/candidate compiler sources, emits fixed
  source-backed kernels and exact C counterparts, corpus/runtime manifest.
* `worker.py`: one fresh-process preparation/audit/complete-call/native-batch
  cell, actual dispatch counts, cache evidence and bound selected LLVM/ASM.
* `batch.c`: external native-call loop; no reimplementation of selected RP body.
* `controller.py`: separate-TU C compilation, JIT preflight, actual strict/mode
  AOT construction/fresh replay audits and seven rotating rounds.
* `inspect_code.py`: read-only selected native LLVM extraction/static metrics.
* `pe_method.py`: binds actual runtime AOT wrapper RVA to sealed PE method data.
* `collect_aot.py`: disassembles the actual audit-selected AOT binaries and
  records wrapper/unwind/call-target candidates for native-body review.
* `verify.py`: independent all-cell/hash/counter/sample verification with a
  separate exact/modular mathematical oracle.
* `common.py`: append-only records, hashes, controlled environment, grant gate.

The CPU grant JSON has schema `wave10-numeric-study-v1`,
`exclusive_cpu_grant: true`, and a coordinator-written description of its scope.
Its existence is an operational gate; it is not evidence that a measurement
passed. Source freezes, program metadata, exact results and actual counters
remain necessary.

The fixed timing rows separate complete Python calls from prevalidated native
batches. Region counters do not count native-adapter calls; batch evidence uses
the actual C-loop invocation/status counts and identifies the selected JIT body
and adapter. A JIT disk-cache hit is not AOT. The C wrapping implementation uses
uint64 arithmetic and signed interpretation; no signed overflow is relied upon.
Out-of-contract wrapping behavior never enters a Python-equal aggregate.

Whole-child wall time includes measurement harness preparation, validation,
timing, metadata and file hashing. It is retained as an experiment cost, not an
ordinary application startup or default-deployment speed claim. First-call and
construction costs are separate from warm complete-call samples.
