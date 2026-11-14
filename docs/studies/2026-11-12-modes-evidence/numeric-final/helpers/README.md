New complete-call-only helpers for the coordinator-gated final binding cohort.
Read PROTOCOL.md. Source preparation only; no code here has been executed.

The controller retains build, preflight, build-aot, audit-aot, timing and summary
stages; `--stage all` runs them serially. The final preparation command requires
`--candidate-commit` and `--native-reference` pointing to the immutable v1
manifest. It rejects changed fixed kernel/corpus/C-source bytes.

The expected population is355cells/361rawprocesses. `verify.py` checks this new
population, exact outcomes, actual completed AOT calls, selected native
identities, checksums and raw hashes. It must never be used to replace or rewrite
the separately frozen v1 verification.
