# Internal heap indexing and compiler inspection tools

The user requests a measured compiler improvement: remove redundant Python negative-index normalization from proven nonnegative physical heap accesses, preserve Python behavior, and compare actual assembly and performance against the current compiler and matched C ports. Also provide reusable development tools for differences, assembly, C, attribution and test cases.

Baseline is integration `3f0370d` (product `0d2c3d3`). User-facing negative container indices remain Python indices. Internal nullable handles, allocation failures, capacity growth, status exits, integer overflow and aliasing must retain their current behavior. No global disabling of checks or semantic relaxation is authorized.

Tools should work with explicit paths, preserve raw evidence and hashes, distinguish actual AOT artifacts from cached JIT artifacts, save real outputs and execution modes, and label instrumented attribution separately from ordinary timing. Missing tools or unsupported engines should produce useful errors. No network dependencies, package changes or execution of an inspected binary merely to disassemble it.

Measurements must freeze baseline/candidate source and caches, check outputs, audit native execution, serialize CPU work, retain all samples, and distinguish native-entry, complete kernel and complete process boundaries. C ports are comparison implementations, not a proof of optimal code or identical object lifetimes. Native optimization does not imply wider held-out compilation coverage.

All work remains on isolated local branches. Preserve the user's current checkout and its preexisting changes. Historical study evidence is immutable.
