# Native direct build proof

Preparation only. No build or verifier has run. This contract addresses the
current setup.py's optional=True extensions: its successful exit may coexist
with a stale .pyd left after a compiler failure.

## Compiled fingerprint

Add two compile definitions for the direct extension: source-input SHA-256 and
header-input SHA-256. Compute them during setup from explicit, deterministic
input sets, before compiling. Embed their string values into _heap.c and return
them from native.direct_abi(). Source inputs include _heap.c and every local
header or generated source it uses. The generator/build definition affecting
this feature is an input too; its change cannot silently leave the same build
identity. The source manifest is checked in and reviewed with any new include.

Hash the schema tag and sorted relative-path/content records with length
prefixes, not concatenation without boundaries. Keep source bytes exact;
normalize path separators to '/', not file newlines. Include the manifest
itself, excluding only the generated output that contains its own digest.

Header inputs use the selected interpreter's include directory and complete
relevant Python/header closure, including pyconfig.h and installed internal
headers used for managed dict/list/numeric layouts. The build must not choose
headers from another Python on PATH. Export PY_VERSION_HEX, SOABI/target,
Py_GIL_DISABLED, endianness, pointer width, required sizeof/offsetof values and
long digit/tag constants as compiled values alongside the header hash. These
layout values, version and hashes together form the DirectABI digest.

Do not use the .pyd timestamp or setup return code as the fingerprint. A Python
constant generated next to an old .pyd does not prove which C source compiled.
All new direct sources and saved adapters seal this compiled ABI plus their own
source/plan identity. Runtime addresses are not fingerprint or artifact inputs.

## Independent post-build acceptance

After IMPLEMENT, the coordinator's locked build job must invoke a fresh
interpreter to perform all of these checks before claiming the build passed:

1. Resolve this clone's source and extension paths explicitly. Import
   recompyler._heap directly with this clone/src first in sys.path. Reject a
   Python fallback, missing extension, or module outside this clone. Record the
   resolved .pyd path and its own file SHA-256 in the build log.
2. Require callable direct_abi, direct_bind, direct_prepare and direct_execute.
   Missing APIs fail the build even if ordinary arena tests could fall back.
3. Independently hash the current source manifest/input files on disk using the
   versioned algorithm, and compare with the hash embedded in the loaded .pyd.
   Independently hash the selected installed header closure and compare it too.
   Do not read expected_source_sha256 from a cached Python metadata module.
4. Check current interpreter/ABI facts and the required exported layout keys.
   Validate adapter signature/version expectations without invoking native user
   work. Reject unsupported free-threaded mutable-graph ABI.
5. Print exact expected/actual source and header digests, extension-file digest,
   and exported API/ABI summary; exit nonzero on every mismatch. A newly built
   correct binary remains valid when loaded from a different fresh process.

A later verifier implementation can be a small repository build script with a
fresh-process command scheduled by the coordinator. Keep it independent of
Numba and compilation; the point is to prove the binary that would actually run.
The existing clone-local run_locked.py owns both build and verification as one
coordinator job; no second waiter is started here.

## Fail-first requirements

The draft ABI mismatch test exercises native binding, with a mutated expected
ABI version and ordinary compiled fallback. Add a native build-verifier test
when the build schema is implemented: a copied expected manifest with changed
source bytes must fail, as must an absent direct API or mismatched loaded path.
Use temporary fixtures; never intentionally leave the live clone's extension
stale. The full fresh-process AOT test separately proves matching saved direct
artifacts can execute without importing Numba.

These are activation checks, not executed evidence. Until they pass, native
build status and direct benchmark claims are unverified regardless of setup's
exit code.
