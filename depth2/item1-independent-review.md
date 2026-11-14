# Item 1 independent soundness review

Reviewer: independent Codex subagent `range_review`, 2026-11-13.
Scope: draft `src/recompyler/facts.py`, `depth2/item1-design.md`, and the subsequent draft `lift.py` integration. This is a source and analyzer review, not rule acceptance, a native execution result, or a measurement. The draft was not integrated into lift at the start of review; integration was inspected as the implementer added it. The Step 0 snapshot and prior waves were not modified.

Only short Python AST/analyzer and generated-source checks were run, with `python -B`; no native build, timing cohort, full suite, lock acquisition, product edit, or benchmark allocation occurred. This file is the reviewer's only workspace edit.

## Blocking finding at the final recheck

The permutation-carried while refinement checks its ordinary assignments but does not reject other writes to the same name. This counterexample was rechecked against the current source and still marks `a[k]` as a raw index:

```python
def f(n, a):
    r = n
    while r != 1:
        r -= 1
    p = list(range(n))
    p.insert(0, p.pop(-1))
    k = p[0]
    while k:
        a[k] = 1
        k = p[0]
        k += 100
```

At `n=2`, with a two-element `a`, the first access uses `k=1` and the second uses `k=101`. The synthesized guards are `1 <= n <= 16777216` and the array extent guard against `n`; they both pass. The extra augmented assignment destroys the claimed invariant `1 <= k < n`. This is a memory-safety blocker, not only a result mismatch.

Require every write to this carried name to be one of the validated permutation-read assignments, including rejecting additional augmented assignments, named expressions, annotated assignments and iteration targets. The entry value and each admitted read also need the existing range/provenance preconditions. The implementer has been sent this exact counterexample.

## Findings raised and fixes observed

1. **Transitive arithmetic validity.** The initial draft propagated mathematical affine results through operations whose checked implementations could fail. For example, with a private one-element `p`, `j=(n*9223372036854775807-(n-1)*9223372036854775807)-9223372036854775807; p[j]=1` proved mathematical `j=0`, even though checked multiplication can return its failure sentinel and make the raw index enormous. Current expression analysis returns unknown when any arithmetic intermediate is unsafe. Final analyzer recheck: the `p[j]` access is no longer proved.

2. **Unsupported for-loop induction.** `p=list(range(1)); i=0; for i in (100,): p[i]=1` originally reused stale `i=0`. The unrecognized-loop branch now invalidates the loop target. Final recheck: no proved index.

3. **Multiple or repeatedly executed endpoint updates.** `r=n; while r!=1: r-=1; r-=1; a[r]=1` originally admitted negative indices. A single syntactic decrement nested inside `for z in range(n+5)` also invalidated the globally reinstated invariant, making a following `a[r-1]` unsafe. Current control recognition rejects multiple updates per controlling while and intervening for-loop ancestors. Both final rechecks: no proved index.

4. **Unrelated endpoint test.** `r=n; while r!=1:r-=1; while r!=0: a[r]=1; break` originally used the increasing-loop `r<n` refinement for an unrelated comparator. The current code refines that bound only when the comparator resolves to the expected entry extent.

5. **Permutation initial value and failed reads.** An arbitrary initial `k=100` was originally narrowed just because the loop later assigned `k=p[0]`. An empty or unproved `p[0]` also yielded an apparently valid content fact. Current code validates the initial interval and only derives a permutation element interval from an access present in `index_sites`. The remaining blocker above concerns additional writes after these checks.

6. **Local extent and content provenance.** The initial draft inferred metadata globally before initialization and retained exact extents after arbitrary same-list slice assignment. Counterexamples included a copy made after `p[:]=p[:0]`, and `k=-1; p[:k+1]=p[k::-1]`, which doubles a Python list's length. Current code requires local-name presence, invalidates unstable slice shapes and their copy closure, and admits the special prefix shape only with same-permutation index-zero provenance. Upstream `_check_flow` additionally rejects use-before-assignment; callers of the standalone facts API must preserve its prerequisite analyses.

7. **Negative and empty range extents.** `p=list(range(n)); q=list(range(1)); q[len(p)-n]=1` originally removed the bounds check for `n=-1`. The current version retains the rewrite only under an entry guard `0 <= n <= 16777216`, so this counterexample now misses the fast path. `p=list(range(n,n-1)); q=list(range(1)); q[len(p)+1]=1` no longer proves the invalid access. Local exact extents now require nonnegative bounded lengths, rather than blindly using `hi-lo`.

8. **Constructor-bound arithmetic.** `_extent` originally bypassed intermediate arithmetic safety: `p=list(range(n+9223372036854775807)); p[0]=1` could construct an empty array after checked addition failed and then perform a raw access. `_extent` now checks each intermediate. Final recheck: no proved index.

9. **Missing sin input guards.** `math.sin(n)` initially used default parameter limits without collecting their entry requirements. The current sin case calls `need` on its argument. Its raw overload remains float-only; integer cases may decline rather than obtaining a native integer raw-sin implementation.

10. **Lexical shadowing.** With a global math module and a local parameter also named `math`, `def f(math,n): return math.sin(float(n))` originally bypassed the parameter's method. The current sin, math-constant and log-summary recognition excludes parameter/local-store names. A generated-source recheck emits the parameter method call and no raw-sin version for this example.

11. **Function key corruption.** The initial versioning loop reused `key` for guard names, leaving function IDs in `building` and storing definitions under guard strings. The loop now uses `guard_key`. A generated-source recheck of `return n+1` records the original function ID and leaves `building` empty.

12. **Fail-closed unsupported syntax and source kinds.** Named expressions, annotated assignments and unknown statement writes previously left stale scalar facts. Current code invalidates unknown writes. `log_summary` now verifies `FunctionDef` before accessing its body and arguments. Front-end rejection of unsupported AST forms remains an additional boundary.

## Other reviewed conditions

Guard collection is per function and all collected guards are conjoined. Distinct array/extent guard keys accumulate rather than silently replacing one another. The local-extent constraint helper intersects entry integer limits. Power-of-two, evenness and array constraints preserve the relational induction preconditions. Signed integer kind checks exclude uint64 and floating extent inputs; the array guard checks a one-dimensional numeric array and an upper length bound.

The geometric rule rejects changed test-bound names and continue statements; it requires the doubling and counter update shapes directly in the loop body. The emitter uses the updated affine value after a doubling, so no counterexample was found based only on accessing a post-update value. Dependent range strides receive the stronger terminal bound only when they match the admitted geometric symbol.

The exact logarithm summary is based on inspected source, not a workload/function name. The checked body still compiles and guards the callee through the existing function-source and code-identity machinery. No additional successful-path counterexample was established for the recognized logarithm algorithm. The summary is deliberately narrow.

The raw sin path still registers the math name, so the existing math agreement and identity gates remain active. A math constant's emitted literal is guarded by the existing attribute identity/value mechanism. No floating reassociation was introduced in the reviewed emission branches. This source review does not replace native bit-level regression checks for signed zero, NaN, exception behavior or platform libm agreement.

## Acceptance boundary

Do not accept item 1 while the additional-write permutation-loop counterexample remains. Once it is fixed, rerun its regression and the previously reported counterexamples against the final source, then perform the brief's native correctness checks, independent generated-code review, full suite and locked measurement. Analyzer proof counts alone do not establish native deployment, reach or gain. The implementer reported 25 passing analyzer tests in `depth2/item1-review-green6.log`; this reviewer did not rerun that test file and does not claim those tests cover the newly reported blocker.

## Final resolution addendum

The implementer fixed the carried-index blocker after the review above. The loop now counts every `Name(Store)` for the carried index and requires that count to equal the validated ordinary permutation-read assignment count. I independently reran the exact `k += 100` counterexample against the current source: the unsafe `a[k]` access is no longer in `index_sites`.

The implementer also found and fixed an entry-provenance hole in prefix reversal: a parameter `k` could be used before its later `k=p[0]` assignment. The current content condition explicitly requires a name that is not a parameter. I reread this condition and independently checked `def f(n,k,a): p=list(range(n)); p[:k+1]=p[k::-1]; k=p[0]; for i in range(len(p)): a[i]=1`: no unsafe `a` access is proved and no local exact extent is retained for `p`.

I independently ran both focused analyzer modules, `test_range_facts` and `test_range_review`, through Python's unittest runner after these fixes: **27 tests passed**. This supersedes the earlier statement that this reviewer had not rerun the test files. The run performed AST analysis only and did not start a native compiler or timing job.

No unresolved concrete soundness blocker remains from the counterexamples identified in this independent review. This addendum supersedes the open-blocker status and the corresponding acceptance hold above. Native correctness, generated-code deployment, bit-level behavior, suite validation, reach and locked performance measurement remain the implementer's acceptance work; this review does not claim those outcomes.

## Lazy heap fact-storage bookkeeping review

Reviewed the follow-up change from eager `_Program.facts` instance storage to a read-only property that lazily stores `Facts` on `self.entry._facts`. No initialization, lifetime or cache-correctness blocker was found in the reviewed call paths. `_Program.__init__` completes entry construction before any present facts query: `_Function` construction and `function()` do not read the property. The entry is a private per-program analysis record; production paths do not replace it. The existing private test that replaces the entry calls `compile()` afterward, whose first action clears the newly selected entry's facts before inference.

The constructor-only F2 and float-observability F4 call sites still query the same Facts interface. `compile()` still clears `answers` before `settle()` and before the F4 decision. Moving this storage does not change those invalidation points, generated native source or fact semantics. Heap disk-cache keys hash `heap.py` and the lifter runtime; source/AOT digests also hash the generator modules, so this bookkeeping change does not reuse a cache key that excludes the edited heap implementation.

Independently executed property-only assertions using uninitialized `_Program` instances and private `SimpleNamespace` entry records: lazy creation, repeated-access identity, separate-program isolation, clearing and reusing the same Facts object, entry replacement obtaining separate metadata, and absence of a `facts` entry in `_Program.__dict__` all passed. This check did not instantiate a user region, compile native code or measure execution. The implementer's reported 765-test semantics result was not rerun for this small follow-up review. Scalar replacement remains outside this change and was not reviewed as implemented work.
