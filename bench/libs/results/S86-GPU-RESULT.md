# S86 strict CUDA result

The installed numba-cuda 0.30.4 backend defaults to LTO. Its final linker
reintroduced `fma.rn.f64` after the existing NVVM `fma=False` option. The raw
particle probe differed on 62/73 rows before the change.

RecomPyler now requests `lto=False` for its generated device functions and
kernel when that supported option exists. It applies `cuda.jit` directly to
the function: the 0.30.4 decorator factory drops its explicit `lto` argument.
Legacy CUDA backends retain their existing path. The byte-exact GPU/CPU gate
and refusal of transcendental/remainder paths stay active.

Evidence: `s86-probe.log`, `s86-before.ptx`, `s86-probe-after.log`,
`s86-green.log`, and `s86-affected.log`. The corrected probe has zero FMA
instructions and 0/73 raw mismatches. Four GPU-focused tests pass; all 27 tests
in the affected backend/batch/library files pass. One read-only review found
no concrete wrong result or crash. No speed claim is made.

The new regression covers adversarial multiply/add rounding, a subnormal, and
signed zero, and checks that GPU execution remains trusted rather than merely
returning fallback CPU values. Commit-gate evidence is recorded in the ledger.
