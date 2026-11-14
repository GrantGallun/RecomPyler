# Freeze/resume review fixes

Both P2 findings from `../WAVE2-study-REVIEW.md` are fixed before preparation. No benchmarks ran.

- Children are constructed from a closed allowlist of Windows/system/compiler path variables and numeric runtime/thread controls frozen in manifest schema 2. Ambient environment changes on resume cannot change the child configuration. Unknown settings and credentials are stripped. `NUMBA_DISABLE_JIT=0` is explicit. Bot root/model/strategy selectors are pinned to the hashed `heads-up-bot` tree and its default `adaptive` / `counter_pref_identify` policy.
- Resume validates the current Python executable path and SHA-256, interpreter version/implementation/cache tag, platform, Python runtime DLL hashes, and installed distributions' versions plus METADATA/RECORD hashes against the manifest. No network or installation operations occur.
- Preparation and resume call the same filtered inventory function and compare full mappings, rejecting additions and deletions as well as changed bytes. Corpus inputs include all files except cache/generated results directories and bytecode. Bot inventory includes Python/native modules and all files under models, excluding `.venv`, `.git`, `results`, `.pytest_cache`, and `__pycache__`. This catches newly created optional models and shadowing modules. Source fingerprints and frozen driver/shim/harness checks remain.

Fail-first evidence: after adding the three regression tests, the six-test run failed with three missing-function errors (`execution_environment`, `runtime_identity`, `input_inventory`). After implementation, all six tests passed in 3.351 seconds. New cases prove frozen sanitized child settings despite altered ambient JIT/thread/bot values, no credential serialization, rejection of mocked executable/package/runtime changes, and rejection of new local modules or optional model files. Existing raw-output/resume/timeout and overlap tests still pass.

Ready preparation command after coordinator freeze:

```powershell
C:/Python314/python.exe D:/Code/Datathon/recompyler-codex-20261111/wave2-study/compare.py prepare --output D:/Code/Datathon/recompyler-codex-20261111/wave2-study/results --baseline D:/Code/Datathon/recompyler-codex-20261111/baseline --integrated D:/Code/Datathon/recompyler-codex-20261111/integration --limit 40 --samples 8 --repetitions 5 --timeout 180 --bot-deals 2
```

Then, only with exclusive timing slot: `C:/Python314/python.exe D:/Code/Datathon/recompyler-codex-20261111/wave2-study/compare.py run --output D:/Code/Datathon/recompyler-codex-20261111/wave2-study/results`.
