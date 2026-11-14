# Wave 2 build review

Verdict: **No actionable findings** in `cbf5bde..78ca7a357807d9e6096e2a526b38c6ff6974de56`. Ready for coordinator import.

Reviewed `src/recompyler/_pycc/platform.py`, all new platform regression tests, the focused diff, and `WAVE2-build.md`. Checked the helper against installed setuptools compiler setup and MSVC compile behavior. The compiler receives original source paths and options; only object-name calculation receives flat relative SHA-256 names. Thus source roots, sibling quoted includes, macros, dependencies, diagnostics, and current-directory interpretation are preserved. Backend object extensions remain under backend control, while the digest includes the source extension and full normalized absolute path. Generated names contain no source path separators or drive components that could discard the supplied output directory.

The override is restricted to the selected compiler instance and restored in `finally`, preserving an existing instance override or removing the temporary attribute as appropriate. Both probe source/object cleanup and failure restoration are covered. No global/compiler-class patch or source staging is introduced. Native runtime code is unchanged.

Evidence considered: reported full suite 221 passed with no skips, followed by five targeted tests passed with no skips including both original AOT failures and the added restoration case. The report explicitly states the full suite began before that last test was added. The real AOT tests and CLI smoke block Numba/llvmlite in the consuming process. These are author-provided execution results, not an independently repeated suite.

Limits: this bounded review did not rerun full suites or execute a separate Unix toolchain. Static inspection of the common compiler setup and MSVC implementation found no platform-specific regression requiring a change. Concurrent compilation on the same compiler instance is outside the existing intended use and is explicitly documented in the build report.
