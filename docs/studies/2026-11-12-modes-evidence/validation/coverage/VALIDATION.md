# Guarded region coverage pilot status

Frozen product worker: `wave10-coverage`, clean at `e0af82ad4bd6ff09ba971101a10e587085f28419`, based on strict integration `1d4084f914fa9594ecb801e3efa565edcd7e1241`. Heap SHA256 `23ef9b7e3dfdb3f30dd736e3dab9735e9fab4ab6cbfd80f5c0b8c46266a9012c`.

Four separate commits: `a20b912` integer-tagged MIXED indexing and kind-tag preservation; `5a68c15` guarded callable object expressions/fields; `749d420` whole-transaction exit before builtin print statements; `e0af82a` require and observe the actual native loader in tests. No numeric policy or arithmetic helper changes, selection threshold changes, workload-name rules or generic unsupported-call catch.

## Verification retained

| Stage | Observed result | Receipt |
|---|---|---|
| Initial runtime RED |32 failed,24 passed in0.46s|`runtime-red/`|
| Source-only initial gate |0/11 generated; expected assertion RED|`source-red.json`|
| Source-only incremental |3 MIXED,9 callable,11 print generated|`source-*-green.json`|
| Callable field source gate |11/12 RED then12/12 GREEN|`source-field-*.json`|
| Initial runtime GREEN |62 passed in7.27s|`runtime-green/`|
| Actual native support copy |Exact retained heap17e2e43e and monitor00d6138b|`native-support-copy.json`|
| Genuine two-loader runtime GREEN |64 passed in6.63s, no warnings|`runtime-native-green/`|
| Frozen final byte identity |All source/test/native bytes match the64-test run; clean git status|`product-native-freeze.json`|

The first62-test GREEN lacked ignored native support binaries in the fresh git clone. Both NATIVE fixture values therefore used Python packing; that run proves JIT semantics with Python loading, not both loaders. It is preserved rather than relabeled. The second run requires the extension for every native parameter and spies on `_native.load`: the positive State is actually packed by C only when requested, while its Python-loader control performs no native pack. All new Python/native input hashes are bound before/after.

The initial whole-chaos source probe used fake AOT lookup and no Numba/kernel, but indirectly imported NumPy through `_rng`; an earlier design sentence overstated its import isolation and has been corrected. The later source regression gates explicitly deny NumPy/Numba/pytest/native extensions and complete in subsecond children. Source generation never establishes machine compilation or native execution.

## Original chaos diagnostic profile

One new, non-headline diagnostic profile of the unchanged frozen chaos source and loops=2 shim completed exit0 in67.20s. Exact command/raw streams/source/native hashes are in `chaos-profile-diagnostic/`. The outer wrapper subsequently failed to print retained stderr under console cp1252; the successful child, raw streams and plan were already saved.

The original full `Chaosgame.create_image_chaos` now verifies2/2 captured calls compiled, zero captured fallback. Measured per-call values in that diagnostic: Python35.77945ms, compiled1.24447ms, ratio28.7508x. These are candidate kernel measurements, not a process speedup.

Per-entry recommendation is true, but default whole-script `worth_running` is **false**: net cached saving8.13377ms versus startup105.13180ms. Thus this short default case still deploys no native wrapper. The built AOT section is legacy-only (no guarded strict seed); successful fresh reuse must be audited rather than assumed. No default held-out coverage expansion or whole-process gain is claimed.

## Remaining coordinated work

The measurement worker owns all formal execution. New `coverage-helpers/` prepares two explicit populations: unchanged loops2 original subset denominator1, and separately labeled loops32 diagnostic using identical source/arguments/default policy. The latter can amortize real startup but never enters the historical38 denominator. Both get fresh profiles, rotating CPython/current/candidate timings and independent mode audits. Pre-timing deployment checks abort a selected plan that fails actual full-entry AOT reuse or falls back/JITs.

`state_audit.py` prepares exact original None/RNG/input graph/type/alias checks and a separately derived original-body-plus-return-image canary. Raw C export entries and wrapper PE RVAs bind actual native calls to binary hashes. These new helper files have only been syntax checked; no successful state-AOT or formal benchmark result is claimed yet. Full combined product suite/review are coordinator work. Original dirty checkout and all frozen prior results remain unchanged.
