# Accepted member primitive and wave19 merge

Commits02a02882 merges1eb3ac55 (including2d3f0e26 ranges);62d80170 adds field-only direct scalar reads and array-d member writes to the private flat candidate. Scalar fields are opaque typed snapshots, not retained application classes. The C final open freshly resolves managed/inline fields after the profile point, rejects custom getters/data descriptors/non-string keys, pins the current exact buffer and uses the existing full-byte undo. Opaque buffer access avoids ndarray layout bypasses and NRT return restrictions. Methods, slots, reference-field stores, numeric-list stores, multiple roots and returned containers decline.

Fail-first member gate6failed/1passed becomes67focused protocol/shape/member passes. Ten-minute accepted shared-oracle seed5615 run164799cases=3975native+160824declined,0wrong/unchecked (`inplace/s56-member-fuzz10m.txt`). A final cheap runtime fingerprint refusal before private member layout access and partial-import getter refusal were added before the full gate; the admitted installed-runtime path is unchanged. One independent implementation review approved the member delta; no rereview. The combined command `PROVENANCE_CORPUS=tests/provenance_cases python inplace/run_low.py s59-member-merge-full-suite.txt python -m pytest tests -q` exits0:2812passed,131subtests,2expected xfails. Post-merge focused189passed. No seals/receipts.

Fresh-cache whole-process cohort command: `python inplace/flat-preparation/time_locked.py s59-merge-programs python inplace/bench_program.py s59-merge-programs scimark spectral_norm`. Profile then alternate plain and recompyler run for3pairs using the unchanged20-loop shim. Raw `inplace/s59-merge-programs.txt`, each command stdout/stderr/counts and summary JSON in `inplace/s59-merge-programs/`. All outputs identical, selected calls AOT with0JIT/0fallback. Peer correctness jobs overlap and the measured samples are used as is.

| Program | Plain median s | RecomPyler median s | Ratio | PyPy JOINED20loops |
|---|---:|---:|---:|---:|
| scimark |10.4727483|1.1875787|8.8186x|11.91x|
| spectral_norm |1.9313585|0.6807206|2.8372x|3.40x|

These are wave19 integration results, not member-attributed gains. scimark20SOR/20MonteCarlo/20LU plus1000FFT_transform/1000FFT_inverse; spectral400eval_AtA_times_u. Numeric correctness is independently exercised by the union and exact protocol tests, rather than inferred from the benchmark's empty stdout. Old33-program selection and kernel ladders are carried as historical only, with no new selection claim. S59 retargets in-place work toward FFT/raytrace/Barnes/Richards. Newly accepted wave17 source/Unicode guards are next to merge, followed by saved flat AOT.
