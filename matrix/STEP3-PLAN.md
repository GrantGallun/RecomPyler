# Step 3 native reuse implementation plan

Spec: ../../CLAUDE-BRIEF-language-matrix.md, ../../CLAUDE-STEERING.md S38.
User selected Extend Numba. Existing clone is isolated; no new worktree or backend.

Pre-flight interfaces: native representation feeds the existing checked overloads, inferred-type stability pass, verifier and AOT builder. Use the existing path; do not change AOT loading, write-back, start-up or prepared-cache code. Pure local native results may be boxed; argument identity and callback-capable values must decline until their provenance is represented.

Blocker ranking: reuse-blockers.json retains all170 row IDs and all37 exact reference/compiled differences. Split the miscellaneous29 recognizers by actual builtin/operation, rather than calling the grab-bag a shared blocker. Largest coherent representation blocker is set27, then Unicode methods23, complex21, selected-value provenance20, bytes18, represented lists17, statement/call syntax15; individual builtin/tuple/error recognizers follow their own row counts.

1. Native sets (S40 final scope): exact signed-int64 working values, scalar results only, detached input copies. Positive typed-use certificate allows order-independent algebra/predicates and private mutation; recursively reject set-bearing results, stores, unknown calls and traversal. Escaping CPython owners are designed for the managed route after its parity gate. Actual counterexamples remain regressions; finite-domain/table-layout experiments are rejected. Full matrix, independent review, union and actual held-out counts before acceptance.
2. Remaining blocker families: native reuse with typed operation guards and result provenance; retain all37 differing rows until explicit protections exist. Each family receives fail-first tests, executed matrix/union/held-out counts and one review.
3. Borrowed bytes: source-generated loops, exact guards, pinned owners, one result construction; four base64 bodies and selection acceptance as S38.2. Speed work three pairs only.
4. Character-loop ceiling; choose representation from measured remaining time.
5. Managed object parity on all three full functions before breadth. Stop breadth if parity fails two-of-three.

Review focus: aliases through returns and mutation; noncached/big integers and subclasses; source/global rebinding; exceptions/evaluation order before effects; AOT boxing and signature restrictions. Each is an execution test, not a text assertion.
