# Fresh-process reuse evidence

Start with [the final report](../2026-11-11-fresh-process-reuse.md). The measured source is `0d2c3d33215f7c289b89944214d4c7b8eaf9ac89`, compared with `dba45a7379402ea33664a5754a2fe6f0927b6855`. A later documentation commit does not change product source.

This archive contains compact measurements, implementation/review reports, final test transcripts, the rebuilt Richards deployment gate and historical measurement scripts. Earlier review findings and intermediate test counts are retained; the final scoped review and 383-test transcript describe the final code. Report accuracy was checked independently after measurements.

The first `afd09b0` study was deliberately stopped and is partial evidence. Only final `results-v2` and `results-long-v2` data support the report's fixed/long results. Native diagnostics use the same nine C ports, freshly executed for both versions, with explicit warm/forced paths distinguished from default plans.

Archive text is normalized to LF and a single final newline; ANSI color escapes and trailing whitespace are removed from test transcripts. `archive-sha256.json` hashes all other archive files. `provenance.json` also records original paths/hashes and normalized archive hashes. These are local integrity records, not signatures or independent attestations.

Full raw plans, stdout/stderr, manifests, inputs and compiler caches remain under `D:/Code/Datathon/recompyler-codex-20261111/wave3-study`, `wave3-native-baseline`, `wave3-native` and `review-scratch`. Environment values and full input trees are not duplicated here; manifest hashes bind them. Historical harnesses assume that local directory layout. Archive filenames are descriptive; provenance.json records their original filenames and locations. Use the original workspace copies, or restore the original filenames, adapt paths and generate a new manifest/output directory when repeating the experiment; never silently resume a frozen study with changed code or inputs.

Native-call counts measure RecomPyler execution, not all C/C++ work performed internally by Python libraries. Opportunity figures are the largest verified candidate's profiled share, not union coverage or actual native execution time. Warm kernel comparisons exclude startup/profile and are separate from complete-process results.
