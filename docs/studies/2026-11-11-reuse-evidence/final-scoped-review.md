# Scoped final re-review — 0d2c3d33215f7c289b89944214d4c7b8eaf9ac89

**Verdict: both findings from REVIEW.md are resolved. No remaining actionable finding in this scoped correction.** This supersedes the two open findings in the earlier review for this revision only. It is conditional on the implementer-owned complete-suite result and does not approve native deployment or performance claims.

Reviewed exactly `13f3224..0d2c3d3`, covering family-topology validation and preserving legacy coverage when guarded strict seeds are incomplete. Product HEAD was the requested commit and product status remained clean.

## Family aliases

The restore path validates canonical roots, own-root ownership, complete/nonoverlapping membership and alias termination before publishing the topology. Cyclic or inconsistent maps cannot enter replay's unbounded `canon()` loop. A canonical root need not be a concrete member; an abstract root owning one or more concrete members remains valid, including merged families.

The original independent `alias_cycle.py` now rejects immediately with `Unsupported: invalid AOT canonical family root`, instead of accepting A→B→A. The focused compiler-free tests also exercise actual AOT-only fallback for cyclic and conflicting-own-root metadata (correct value, one Python side effect, one fallback, zero compiled calls, no Numba) and source-identical restoration/loading of valid abstract and merged families.

Validation: `3 passed, 54 deselected` for `invalid_family_topology` and `valid_abstract_and_merged_family_roots_restore`, with test temporary files confined to this review directory and cache/bytecode output disabled. No native fixture was built.

## Mixed seeded/unseedable coverage

Build selection now requires guarded strict-seed coverage for every exported specialization of a function before publishing any seeds for that function. Incomplete coverage retains all original legacy exact-source exports, discards optional normalized exports, emits an empty seed mapping, and records `seed_policy: legacy-only` with its reason. This makes the legacy decision at build time; it does not escape to ordinary inference after a guarded seed rejects. The AOT-only adapter still prohibits JIT on a digest miss.

The original independent generator-expression probe `unseedable_signature.py` now prints:

```
exports: 2 seeds: 0
with_seeds False object signature accepted True problem None
with_seeds True object signature accepted True problem None
```

The additional compiler-free `unseedable_default.py` uses a helper with an unused mutable default, explicitly overridden by the call, and no generator expression. It yields the same result, confirming this policy covers a distinct reason for unseedability without expanding code serialization.

Export numbers now come from a monotonic counter rather than the pruned list length, so removing optional exports cannot reuse a name already retained for another function. The added native regressions cover both unseedable causes, both call orders and loaders, exactly-once mutation, zero JIT imports, and a second guarded function after numbering gaps; I inspected these tests but did not duplicate their native builds.

## Limits

The probes substitute compiler/export objects to exercise actual capture, restoration, build selection and runtime source matching. They do not prove native execution or speed. No full suite, native build, benchmark, timing study, source edit or subagent was run in this re-review. The reported 75 focused worker tests, frozen full suite and coordinator-owned fresh Richards rebuild remain separately owned evidence. Whole-function legacy policy intentionally retains baseline behavior and can forgo widened cold-start coverage for an incompletely seedable function; this is explicit and does not reintroduce blind inference after invalid guarded metadata.
