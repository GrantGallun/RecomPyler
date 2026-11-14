# Final whole-branch review — changes required

Reviewed frozen product revision `13f3224dfbc82e7a6f78899d53abc03cbef1e917` against `dba45a7379402ea33664a5754a2fe6f0927b6855`. Two concrete findings remain. Product source was not edited.

## 1. [P1] Reject cyclic/inconsistent family aliases before replay

**Location:** `src/recompyler/_region_seed.py:310-320`, especially the unchecked `program.alias[own] = root` at line 317.

The new JSON restore path can create a cycle in `program.alias` while passing the concrete-member coverage/overlap check. For two unrelated families A and B, swap the saved family root paths but leave their member lists intact. Restoration accepts A→B and B→A because all concrete members still appear exactly once. Subsequent seeded generation enters `_Program.canon` (`heap.py:625`) and never terminates. The exact export digest gate is not reached; the exception handlers cannot stop this nonrecursive loop. Thus malformed saved metadata hangs the application instead of declining AOT and running Python.

Independent bounded reproduction:

- `alias_cycle.py` captures and seals an ordinary source-only program reading A.x and B.y, JSON-roundtrips the seed, swaps only those family root paths, and calls the real restore path. It prints `restored aliases: {'A': 'B', 'B': 'A'}`.
- `check_alias_timeout.py` runs the actual `_AotOnlyExports` / `Region.program_for` path in a child with a deliberately nonexistent export digest. The child fails to terminate and is killed by the 3-second timeout. This demonstrates the failure occurs before a digest miss can safely reject the seed.
- Neither probe imports Numba or builds native code.

Validate canonical family roots and unique own-root assignments before publishing the alias map; reject cycles/inconsistency before any replay calls `canon`. Do not simply require the canonical root to be a concrete member: valid families can have an abstract base as their canonical root. Add a bounded regression that proves malformed aliases decline and preserve exactly-once Python fallback.

## 2. [P2] Preserve valid legacy exports when another signature alone is seedable

**Location:** `src/recompyler/heap.py:6490-6493`; contributing restriction at `_region_seed.py:29-45`.

Strict seeds repair the previously reported mixed-signature loss only when the original specialization can itself be captured. Supported specializations can remain unseedable. For example, a helper using `sum(i for i in xs)` contains a nested code object in `co_consts`; `_fingerprint` passes that through `_literal`, which rejects it. An entry with an object branch calling that helper and a separate None branch returning 1.5 consequently gets a valid legacy object export but only a None seed. When any seeds exist, AOT-only runtime exhausts those seeds and returns None without considering that valid legacy export. The unrelated signature's seed changes a previously successful native selection into Python fallback.

Independent compiler-free reproduction: `unseedable_signature.py` invokes the real source generation, build selection, capture/seal and runtime selection paths with a no-op compiler and placeholder native exports. Its output is:

```
exports: 3 seeds: 1
with_seeds False object signature accepted True problem None
with_seeds True object signature accepted False problem no saved AOT inference seed matches the live program
```

The same generated object source/export is present in both controls. This establishes selection loss, not a native execution or timing claim. No Numba is imported. This regression is introduced by the new all-seed-miss return; the baseline could regenerate and match the legacy source.

Preserve guarded selection for supported unseedable specializations without allowing an unrelated seed to authorize unrestricted inference of a poisoned branch. Supporting structural fingerprints of nested code objects would cover this concrete generator-expression case, but broader unseedable legacy cases also need an explicit policy. Regression coverage should include both call orders, guarded native selection and the existing poisoned-branch rejection constraint.

## Other reviewed properties and limits

The source/seed digest binding, original-versus-normalized parameter and return machine-format checks, constant-return gate, source-identical export sharing, sealed normalized dependency validation, build-time math check, live graph loading, and successful local-program mode-counter placement have no additional actionable finding from this review. Seeds carry inference metadata rather than mutable user values; loaders retain their alias/cycle handling. Ordinary runner accounting separates mode counts from the conservative `ahead_of_time` flag.

I read the complete branch diff, relevant unchanged compilation/loading/writeback/guard context, and the existing implementation/review evidence. I did not run native builds, the full suite, held-out benchmarks or performance measurements, and did not spawn agents. The implementer-owned full suite and the coordinator-owned real fresh-process deployment and held-out speed gates remain separate requirements. The three probe files are retained beside this report; all product files remain read-only.
