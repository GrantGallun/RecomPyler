# Step 2 third independent review

Reviewed the current lift.py/profiler.py diff after the no-walrus correction, saved union-diagnosis-v2 source/traceback, step2-targeted-v4 and step2-targeted-v5 output, local backend type-inference handling, and selected regression tests. No workloads were run; no product files were edited.

## Decision on current source

No remaining specific soundness blocker was identified in this read-only review. The latest saved targeted run reports 53 passed, including the scorer/map native-path regressions, GPU/cache preservation and numeric selected-object identity checks. The current matrix-v3 run, union suite and required kernel checks remain acceptance evidence to complete; this review does not substitute for them.

## Resolved native-path regression

The prior targeted-v4 source lost the native score_hand path: both exhaustive holding verification and map fell back, and direct compilation exposed an unresolved TypingError. Its scorer had no named bindings/records, ruling out record token normalization as the direct cause.

The distinctive generated shape put a helper call result into a walrus temporary inside a comparison overload argument, then reused it after a short-circuit branch. A simple numeric chain did not cover that shape. Numba's “unknown operation” text was typeinfer.check_var's fallback for an untyped variable whose defining assignment could not be found; it was not proof of an unsupported bytecode opcode. The backend had the relevant COPY/CALL/fused-store handlers.

The current correction retains ast.Compare for chains and wraps each original numeric operand once in _rc_chain_operand. It removes the introduced NamedExpr without duplicating operands or evaluating later comparators eagerly. Saved targeted-v5 output confirms the previously failing native scorer/map tests now pass. That closes the observed compatibility regression for those gates.

## Current comparison and condition soundness

- Each chained operand remains in its original ast.Compare position. CPython/backend chain semantics retain one evaluation of each middle operand and short-circuit later operands. User effects are not duplicated by the lowering.
- _rc_chain_operand accepts signed integers/bools and floats only. Every evaluated integer outside [-2**53,2**53] sets the fallback flag before the result can be accepted. This conservatively protects even integer-only chains, while guaranteeing exact integer-to-float conversion for mixed chain pairs.
- An out-of-domain operand returns its value after flagging, but the wrapper discards the compiled result and replays Python on original inputs. That uses the existing private-copy/rollback contract; preserve its mutation/error regression tests.
- Nonnumeric chains have a named typed decline. This is conservative coverage loss for e.g. tuple/None equality chains, not a demonstrated semantic discrepancy.
- Single comparisons retain pair helpers: exact-domain guards for mixed int/float, recursively integer/bool tuple comparisons only, and explicit scalar None equality behavior. Scalar float NaN/infinity behavior follows ordinary floating comparisons.
- condition() recursively lowers and/or/not only where truth is observed: if, while, conditional-expression tests and comprehension filters. It does not return a selected numeric object to Python. Numeric/list truth therefore stays distinct from value-producing and/or.
- Value-producing and/or accepts only singleton bool/None through _rc_bool_value. Float/noninterned-int selected-object identity is protected by a named decline, rather than by value-only reconstruction. The saved identity gates cover left and right selection cases.
- The repeated Not branch later in visit_UnaryOp is unreachable cleanup. It is not a soundness blocker.

The chain policy may decline more large integer-only chains than strictly necessary. Report that native coverage cost rather than weakening the precision boundary without a separate pairwise proof.

## Stable binding text and persisted retyping

_binding_text removes process-address-bearing make/blank/fill tokens by mapping them to (registry position,module,qualname), preserving the field-kind suffix. It retains method/attribute/slice names and generated aliases. Both module digest and record/column type stem use the stable binding text. Generated source, constants and described fields/boxed fields/kinds remain hashed; actual class-object identity is additionally separated by _ISSUED/record_text in the process. This fixes the earlier missing semantics and raw-address cache instability without removing the class distinction.

A small metadata edge remains: name.partition('|') assumes the registry token cannot contain '|', but unusual assigned class __qualname__ strings can contain that delimiter. Such a token may fail normalization and retain its process address. This is a cache-stability edge, not an observed wrong result. Matching recipe grammar would use the complete token for make and rpartition/rsplit for blank/fill; it need not block the current ordinary-class acceptance.

Unsupported recovery now calls _retype, saves the retype verdict, rebuilds and retries in the same order as the older compile-error branch. Existing make_counted tests assert native execution and zero fallback, while the fresh-process object cache test asserts zero fallback and positive cache hits. Preserve those meaningful assertions in the union suite.

Named type-domain declines remain distinct from unexpected backend errors. Do not convert a future unresolved TypingError to Unsupported merely to clear the matrix.

## Scope of evidence

The v4 failures and v5 recovery are actual saved execution evidence. This review did not run the scorer, matrix, suite or timing. Final acceptance must use the current frozen source's matrix, union and kernel outputs, with native coverage changes and remaining named declines reported explicitly.

Only matrix/review-step2-third.md was written.

