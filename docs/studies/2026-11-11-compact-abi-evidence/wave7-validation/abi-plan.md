# Compact internal heap calling convention

Keep the exported four-array entry and every semantic parameter/return unchanged. After mutual-recursion merging, rewrite generated user/SCC functions to borrow four typed pointers plus the arena length, reconstructing local one-dimensional carray views. Runtime helpers retain their existing interfaces. The public adapter validates contiguous one-dimensional context shapes before borrowing. F/I remain potentially aliased, all status/depth operations remain shared, and allocation/growth still exits before Python retries with new buffers. Helper source participates in generated source/digest identity; source construction performs no Numba import on an AOT hit.

1. Add RED compiler tests for a genuinely recursive native signature, public adapter/context rejection, and direct recursive entry behavior.
2. Add generated pointer intrinsic and post-merge AST rewrite, preserving source reset/repeated compilation.
3. Verify focused source/LLVM/native tests: five scalar context args, no pointer ownership/allocation calls, alias writes, signed/nullable indices, SCC/default argument behavior, recursion limit, growth and rollback under both loaders.
4. Build real AOT fixture and verify fresh-process execution without Numba under both loaders; run full project suite in the coordinated CPU slot.
5. Review diff, preserve all new validation evidence here, and commit only product/tests.
