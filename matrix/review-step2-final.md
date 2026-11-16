# Step 2 final independent review

Reviewed the final lift.py/profiler.py diff, comparison-chain lowering, the expanded test_matrix_soundness.py, saved step2-matrix-v2.stdout, and existing native record/retyping tests in test_lift.py. No workloads were run for this review.

Saved execution evidence reports 1,009 rows: 237 native, 772 declined, 0 wrong, 0 crash. This review did not generate those verdicts. The previous mixed-precision, tuple-NaN and literal-index probes are represented in that executed matrix.

## Remaining concrete obligation: scalar Boolean result identity

The tuple-valued and/or defect was fixed by permitting only numeric scalars and None in _rc_bool_value. However Python and/or returns the exact selected object for float and noninterned int operands too. Numeric value/type equality does not prove this identity contract, and the matrix oracle treats scalar values without recording their identity relationships.

Execute these targeted checks before accepting the Boolean identity fix:

    def choose_or(a, b):
        return a or b

    def choose_and(a, b):
        return a and b

    x = float("1.25")
    assert lift(choose_or)(x, 0.0) is x
    z = float("-0.0")
    assert lift(choose_and)(z, 1.0) is z
    n = int("1000")
    assert lift(choose_or)(n, 0) is n

Also test selection of the right argument. These are proposed runtime witnesses, not asserted compiler verdicts. If unboxing/reboxing fails them, preserve the selected argument's identity at the boundary or make that domain a named decline. Bool/None are singletons; ordinary int/float objects need an explicit argument-selection rule or proof. A test of numeric equality alone cannot close this finding.

This is the only newly identified specific soundness obligation in this final review. Broader scalar-return identity may already be a product limitation, but this step specifically claims to fix and/or argument identity and must state the scope accurately.

## Reviewed corrections

- Named binding recipes now participate in both the generated module digest and record/column type stem. Runtime source hashing invalidates modules when these helper implementations change.
- Literal numeric-list indices now use the checked numeric reader; heterogeneous tuple literal indexing retains its specialization.
- Mixed int/float comparisons flag fallback when the integer lies outside the exactly representable closed range [-2**53, 2**53]. Inside that range, conversion of that integer is exact. Scalar NaN/infinity and float/float comparisons retain ordinary floating comparison semantics.
- Tuple comparisons are restricted to recursively integer/bool tuples, so tuple float/NaN identity is outside this native domain.
- Comparison-chain lowering evaluates the left operand and each needed comparator once. Each middle operand is assigned to a fresh compiler temporary inside the preceding comparison call, and later calls remain under short-circuit and. User locals starting with _rc are reserved, preventing temporary collision.
- None batch columns are omitted and None is emitted literally; changed row values are checked before launch.
- Recognized overload declines retain _RETYPE recovery before fallback. Existing test_lift.py tests make_counted with both native-call and zero-fallback assertions, plus a second-process disk-cache test with zero fallback and positive cache hits. The pending union suite therefore has meaningful coverage of this obligation.
- Scalar Boolean operand helpers preserve operand evaluation count and short circuit structurally. Their numeric result identity remains the execution obligation above.

The additional retained-native, None batch, and heterogeneous literal tests were read but had not yet been run in this review's evidence. Acceptance remains conditional on the coordinator's union suite and required kernel check under the lock, with the numeric selection-identity witness resolved or explicitly scoped as an open soundness limit.

Only this review report was written. No product or other wave files were edited.

