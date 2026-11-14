# CPU target is another unmeasured difference

Read-only source observation; no imports/builds/timings and no target change.

- `integration/src/recompyler/_pycc/cc.py:76` initializes `_target_cpu` to an empty string. The builder passes it as `cpu_name` at line208.
- `integration/src/recompyler/heap.py` and `aot.py` construct CC without setting `target_cpu`.
- The installed `C:/Users/grant/AppData/Roaming/Python/Python314/site-packages/numba/core/codegen.py:1333–1358` defines AOTCPUCodegen with a generic architecture default. A `host` CPU name is explicitly resolved to the host model; its feature customization otherwise returns an empty feature string.
- The unchanged C comparison manifest records `-march=native`.

Thus current RP AOT and C are not using the same CPU tuning/ISA selection policy. Existing actual Barnes assembly shows scalar SSE square root on RP and scalar AVX spelling on C; that observation does not quantify a speed difference. The native gap cannot all be labelled Python semantic overhead. Numeric representation, memory layout, algorithm/lifetime boundaries and backend optimization also matter.

Do not expand the already selected six-case causal matrix solely for this finding. A later CPU-target-only experiment could establish its contribution using fresh same-code builds and unchanged numeric semantics. Before any production host targeting, include CPU model/features/ABI policy in artifact identity and reject incompatible reuse at runtime. Platform.machine() alone is insufficient for host-feature compatibility. Portable fallback should remain available. No compatibility implementation or speedup is claimed here.
