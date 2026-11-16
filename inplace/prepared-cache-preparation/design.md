ï»¿# Exact-key prepared AOT programs â€” DESIGN 20 proposal

Status: IMPLEMENTATION AUTHORIZED by coordinator after CHECKPOINT20 DESIGN, independent design review, staged fail-first s31-prepared-red-v1, and the second full steering read recorded in root WAVE16-INPLACE-PLAN.md (DESIGN20 interval). User explicitly authorized building this run; S31 requires this cache in Step0. Product edits in wave16-inplace/src and tests are now authorized; all executions still need coordinator timing-lock scheduling. Direct reads/Task2 remain suspended; no commits before accepted gates.

## Decision and acceptance

Persist a primitive JSON execution descriptor and generated-source digest for **every verified original heap Program**, plus every independently compiled normalized/sealed seed Program. On a saved hit, verify its complete compatibility key and an independently compiled native descriptor seal, rebind current functions/classes/namespaces, reconstruct execution metadata, and run the existing live loader/guards/native/result/writeback path. Do not invoke inference or emission to decide whether the hit is valid.

A digest-only index does not restore layout/writeback information. Replaying `_region_seed.restore` still constructs `_Program`/`_Function`, parses source and registers constructors; `.compile` repeats settle, range, F2, R8, zero and kind work before the lookup. Pickling a Program is excluded: it restores stale objects and can execute code. The selected architecture is a new runtime-only descriptor; existing regeneration remains the miss path.

Acceptance requires genuine fresh-process prepared hits for both chaos and Richards, AOT successes and zero JIT imports/entries, exact behavior, complete invalidation tests, union suite, and the coordinator's matched frozen-coverage/integrated cohort. Cache hit validation is reported separately. No expected timing is claimed by this design.

## Current source and required insertion points

* `heap._Program.compile` (906): settles/emits, performs zero/F2/scalar analysis, merges cycles, concatenates source, computes `_source_digest`, THEN resolves export. Capture only after all transforms and native ABI checks, never from an intermediate seed.
* `heap.Region.program_for` (6864): creates `_Program`, `_seed`s args and signatures before trying saved seeds. Prepared lookup must precede that entire block. A hit may perform normal `Region.load`, but not `_seed`, `_init_assigned`, `register`, `_Function.__init__`, `settle`, `_Gen.run`, range/F2/R8/kind passes or `_source_digest`.
* `heap.build_regions` (7252): exports original Programs; separately compiles strict/widened seeds, then may drop all seeds for a function lacking complete strict coverage. Retain a prepared descriptor for the original export regardless of seed normalization. Capture normalized descriptors only for exports that remain in the final export map.
* `runner.prepare` (around 220): loads a module and constructs digest-to-callable dict. It must also open an exact verified artifact binding and pass an optional PreparedIndex to Region. AOT-only mode must survive every miss.
* `_region_seed.py` remains the old reconstruction fallback. Do not expand its eligibility merely to implement prepared legacy hits.

Actual v4 chaos row is `Chaosgame.create_image_chaos`, legacy-only, zero seeds, digest `52685218563fb6df85f99ecc1ba13c2d664550074f8f61c59a04135e1eb1c1dc`. A seed-only cache misses the S31 target. Static source shows synthetic `generator_holders` namespaces are not representable by current seed.capture and can cause this; the plan does not record the exact caught exception, so the specific observed failure remains a hypothesis. Instrument the next root-authorized build's existing capture/restore/seal exception path to report it; no extra workload is needed for design.

## Concrete API and ownership

New `src/recompyler/_prepared.py` (imports no Numba/LLVM):

```python
SCHEMA = 1
class PreparedMiss(Exception): pass

def compiler_key() -> dict: ...
def runtime_key() -> dict: ...
def plan_key(snapshot: dict) -> dict: ...
def capture(program, *, seed: dict | None, export: str,
            plan_key: dict, build_key: dict) -> dict: ...
def bundle(cores: list[dict]) -> dict: ...
def open_index(section: dict, function_row: dict, *,
               plan_snapshot: dict, module=None) -> PreparedIndex | None: ...
class PreparedIndex:
    def bind(self, entry) -> list: ...  # runtime Programs; misses recorded as primitives
```

`heap.lift_region(fn, ahead_of_time=None, seeds=None, prepared=None)` and Region's constructor gain an optional PreparedIndex. Only `open_index` constructs one; an arbitrary dict/callable cannot certify a native binding. `bind` validates exact current definitions and returns zero or more runtime-only `_PreparedProgram` instances ordered as build exports. `Region.program_for` tries each candidate with the normal loader. Publish only successful candidates as `programs[('prepared', record_id)]`; retain `latest`, diagnostics and actual AOT counters. Discard failed loaders and candidate programs immediately. Limit accepted signatures using the existing MAX_SIGNATURES. Reusing a prepared runtime instance still requires normal live guards and load checks every call.

`_PreparedProgram` uses `_Program`'s read-only layout/load/write-plan methods, with a separate static `guards_hold`; construct via `__new__` and explicit field assignment, never `_Program.__init__` or `_Function.__init__`. Entry and order rows are simple runtime records. Its `compile` raises Unsupported; miss handling constructs a fresh ordinary candidate, never compiles partial restored state. Metadata reports are primitive copies. `_load_plans`, `_c_kinds`, `_c_plans`, `_c_ok_cache`, `_c_write_plans`, constant NumPy blocks, guards' live identities, arrays, loaders and handles are rebuilt process-locally, not serialized.

The persistent record/index contains primitives only, including primitive miss reasons. It must not gain process-global strong references to classes, functions, RNG instances, argument graphs, exceptions or bound methods. A successfully attached runtime Program has the existing Region runtime lifetime; this cache does not claim to fix the pre-existing strong Program/class retention discussed in Task 2. Rejected binds/loaders add no such retention. Do not install weakref callbacks for bookkeeping.

## Acyclic key and native binding seal

There are three layers; none is accepted by its own checksum alone.

1. **Semantic plan key** includes the complete runner-relevant plan snapshot: selected/recommended function identities, engines, all candidate/pick/batch controls, profitability/budget fields (`startup_s`, `saving_s`, `worth_running`), force/mode, source origins, per-entry exports, seed contents/policy and any future options. Canonicalize all primitive fields, not a whitelist of today's favorite fields. Exclude only the derived `prepared` payloads, seals, record/core IDs and native output file/folder/module/hash fields that are generated from this key. Preserve unrelated plan fields. This exclusion is versioned and tested. Filename relocation is checked separately by the artifact binding, not silently ignored.
2. **Descriptor core** includes schema, semantic plan key, build/compiler/runtime keys, exact live-definition fingerprints/recipes, seed (or explicit legacy `null`), generated source/digest and runtime descriptor below. Canonical encode exact builtin JSON data (reject duplicate keys, nonfinite raw JSON numbers, excessive nesting/size and unknown tags). `core_id = SHA256(canonical(core))`. `bundle_seal = SHA256(canonical({schema, sorted [(entry_id, export, core_id)], full cores}))`. Include the bundle seal in native module identity and export inventory; an old `rcaotr_*` cannot satisfy the new identity merely by existing.
3. **Outer binding** stores final exact extension relative filename, byte length, SHA256, platform extension tag and bundle seal. These are known after compilation and excluded from the core to avoid a self-hash cycle. Before import, hash actual bytes, validate platform/runtime and expected path, then import that exact file using an extension loader. If the module name is already in sys.modules, require the same resolved path/hash and metadata method identity. After import check module origin and the embedded seal. A mismatching cached module, Python shim, replaced export, missing export, mismatched signature or stale old pyd declines prepared binding. Do not fall back to searching another sys.path folder.

Emit a metadata function through the existing PyCC pipeline, e.g. `_rc_prepared_seal() -> UniTuple(int64, 8)`, whose body returns the 8 big-endian uint32 words of bundle_seal as integer literals. No custom C ABI is needed for this startup-only call. Validate its exact builtin function type/module owner/name and expected function list; never call a Python replacement to ask it to vouch for itself. Invoke only before any live graph loading. Each core binds its export and machine signature; swapping r0/r1 or editing runtime fields changes the native-verified seal. The ordinary digest still names the generated code. Metadata export invocation is not an application native call and must not increment Region/audit execution counters.

Build ordering needs a small split: derive final export/descriptor inventories, freeze the exact runtime plan snapshot, seal cores, compile the native module, then attach artifact fields. Existing profiler currently calls run_plan after build_regions: refactor its orchestration to freeze the same selection/profitability result once counts are known, before native compilation. Do not rerun or alter the gate. Standalone build_regions uses an explicit standalone plan context. Recommended interface is `build_regions(entries, folder, *, plan_context=None)` plus an internal inventory/finalize split; profiler supplies a callback/context from already selected candidates. Unknown runtime plan fields enter the canonical key automatically. Build failure publishes neither partially sealed records nor a plan claiming prepared coverage.

Artifact hashes prove consistency, not authenticity against an attacker able to replace both the native executable and every trust anchor. The required tamper cases are corrupt/forged metadata paired with the original native module, stale or swapped artifacts, wrong exports and incompatible runtime layouts.

## Exact keys without imports or user hooks

`compiler_key`: SHA256 of exact bytes of every installed package Python/C/header/runtime generator input used by heap/AOT/loader (prefer a deterministic package source manifest, not the current incomplete five-file `_source_digest` list), schema/serializer version, Python implementation/compiler identity, selected compilation flags/options/target policy, Numba/llvmlite build versions recorded at build, and their installed distribution metadata if present. A saved host without those packages may use the sealed build tool versions; do not require importing or installing them. Runtime/generator source changes always invalidate. New `numeric_versions.py`, facts/owner lowering, `_nd`, `_rng`, `_pycc`, C runtime and loader must be in the manifest. Hash raw bytes with exact line endings; no normalized file hash masquerades as current `_origin` identity. Cache file bytes only within one immutable validation snapshot; do not trust path+mtime across invocations.

`runtime_key`: sys.version, implementation cache_tag/hexversion/api_version, SOABI/EXT_SUFFIX, architecture/pointer width/endianness, target CPU/features (portable target or exact requirements), active native loader path+binary hash and LOAD_CONTRACTS_VERSION, Python executable/DLL ABI identity, NumPy version/C ABI and relevant runtime binary/header facts, build flags including debug/free-threaded mode. No literal copied C offsets. Runtime values come from installed runtime/header-built extension facts; if unavailable, no prepared hit for the incompatible component. Caching does not call lift._runtime_key because that imports Numba. Runtime key computation may import NumPy, which this existing AOT wrapper already requires; NumPy removal is out of scope.

Function fingerprint contains canonical file path + exact full source-file bytes hash, qualname/name/firstlineno, recursive deterministic code fields: co_code/co_consts/co_names/co_varnames/co_freevars/co_cellvars/co_flags, argument counts, exceptiontable, stacksize/nlocals, line/position table; exact defaults/kwdefaults; defining globals and all guarded dependencies; original function and runner-wrapper identity contracts. Code constants recursively handle builtin scalar/tuple/frozenset/slice/code objects with exact tags; binary64/complex bits preserve signed zero/NaN payload. Unsupported objects decline, never repr/hash/eq them. Defaults encoded only for exact supported immutable values or a separately proven binding recipe; mutable/unsupported closure/default values decline. `__class__` closure contents use a class recipe; ordinary unsupported closures decline, and any closure mutation invalidates. Where immutable closure support is deliberately provided, include cell order/name/content and per-call cell-content guard. Source availability failure is a miss, not permission to hash bytecode alone.

Classes: exact type is type; ordered MRO/base recipes, ordinary allocation and no finalizer/hook checks; constructor and every reached/guarded method including inherited source; absent/shadowed attributes; __slots__, slot/member descriptors (owner/name/type), dict/weakref layout and relevant type flags/size offsets from this runtime. Do not reconstruct classes or call constructors. Run `_object_problem`/equivalent static lifetime checks, but never `_init_assigned`/source parsing: sealed assigned-field names plus exact constructor source/code prove the persisted layout. Every current instance still passes normal loader field/type/alias checks.

Namespace bindings: exact function globals, exact module __dict__, exact class dict/MRO lookup, builtin namespace, defaults/kwdefaults and constants by index. Static dictionary access only; reject subclasses/custom metaclasses before accessing attributes. Resolve only from entry and already loaded trusted roots; never import a module named by JSON or walk arbitrary descriptors. Preserve runner-owned wrapper marker AND wrapper code identity plus underlying original identity, so unchanged wrappers do not cause false misses and changed wrapper bodies cannot be ignored.

Object identity is process-relative. Persist binding paths and alias/equality relations between resolved references, not id values. Across processes a newly created class/object satisfying the same binding recipe is expected. Mutable global object contents are never persisted as guard values: bind the current live object, enforce recipe/type/alias contracts, then load its current contents every call. Replacing that binding after bind must invalidate the captured live `is` guard. Immutable copied global constants and absence/builtin-shadow assumptions are exact-key inputs.

### RNG and other compiler-owned namespaces

Legacy Programs may contain `generator_holders` made by heap.call_value: `{'gen': target.__self__}`. Encode `['rng_holder', binding_id_of_original_module_method, 'self']`; resolve the exact live module binding, validate Python MethodType's __func__/__self__ or supported exact builtin Random method, validate `_rng.guards()` and Random's source/native runtime identity, then create only a new private holder dictionary pointing at the **current** generator. If a static path to random._inst exists, record the equivalence too; never assume every module bound RNG is random._inst. Distinct/aliased bound methods preserve the same generator sharing. Do not persist or reseed RNG state. Globals pointing to the same object through different recipes retain alias relations. Unknown compiler-owned namespace is an explicit no-record reason; keep its ordinary AOT export.

## Primitive core schema (required keys; no live objects)

```text
core = {
  schema: 1, backend: 'heap', variant: 'legacy'|'strict-seed'|'wide-seed',
  entry_id: {file, qualname, line}, export: 'rN',
  plan_key: {...}, build_key: {compiler: {...}, runtime: {...}},
  seed: null|{...}, seed_identity: null|hex,
  definitions: {functions: [...], classes: [...], namespaces: [...],
                values: [...], aliases: [[binding_id, binding_id], ...]},
  generated: {digest: hex, source: string, source_sha256: hex,
              entry_symbol: string, signature: {args: [...], ret: [...]}},
  execution: {
    entry_function: function_index,
    functions: [{binding, owner: null|class_id, name, params: [str],
                 vars: [[str, kind]], ret: kind, constant: null|literal,
                 sink: bool, generator: bool, coroutine: bool, recursive: bool}],
    order: [function_index],
    cells: [{elem: kind, mutated: bool}],
    classes: [{binding: class_id, assigned_names: [str]}],
    families: [{root: class_id, members: [class_id],
                fields: [[name, kind]], layout: [[name, slot]], slots: int}],
    aliases: [[class_id, canonical_root_id]],
    written: [[canonical_root_id, field_name]],
    globals: [{namespace: recipe_id, name: str, kind: kind}],
    strings: [str], guards: [guard_recipe],
    flags: {arrays_used: bool, arrays_written: bool, array_views: bool,
            rng_used: bool, fast_mixed: bool, saw_mixed: bool,
            mixed_kind_used: bool, zero_optimized: bool},
    reports: {scalar: primitive, escape: primitive, range: primitive,
              numeric: primitive, owner: primitive}
  }
}
```

`kind` = scalar exact tag, or tagged object(root/classes/nullable), shared-cell list/array, tuple(items/nullable), optional(base), string(nullable), dict(kcell/vcell/nullable), set(cell/nullable), ndarray(dtype/ndim/writable), random. IDs are bounded indices; canonical cells have no parent cycle. Kind graph may recur through cells/objects; reject illegal by-value tuple/optional cycles. Fields and members remain ordered. Class assigned_names is a set semantic with canonical encoding; field order must not be sorted away. Validate root ownership/complete nonoverlapping families, aliases acyclic, widths/slots/layout consistent, every written field defined, global order/string placement exact, complete order/entry indices and machine signature widths. Derive physical offsets from kinds using current trusted `_slots` and compare the sealed layout. Never let JSON supply an unchecked offset.

Guard recipes cover **all** actual guard kinds, not merely seed.dependencies:

* code(function binding, current code fingerprint)
* lifetime(class binding) plus MRO/layout/type checks
* attr(static owner lookup or approved function/cell intrinsic, name, expected value recipe)
* own(class binding, own-dict name, expected recipe OR explicit MISSING)
* item(namespace recipe, key, expected recipe OR explicit MISSING)
* builtin(function namespace, name absent, builtin namespace/value recipe)
* const(namespace, name, exact literal bits/type)
* kwdefaults(function binding, exact dictionary/current items with identity recipes)

Capture expands the dependency closure of every recipe, every runtime function/class, constructor, global namespace and guard value. Unknown guard/opcode/namespace or unsafe expected value means no prepared record; never drop it. Rebinding constructs current identity guards; immutable value comparisons are exact builtin only. Check guards before attempting live graph load and again at existing pre-native boundary. Array shape/strides/writability, range/exact-int constraints, per-call alias contracts, recursion limits/status rollback, RNG writeback and returned original-object identity remain current runtime checks, not cached successes.

Reports are diagnostics only and may be emitted as stable primitive snapshots; no proof is rerun to obtain them. They cannot authorize execution. Preserve post-merge numeric_report from 2455034 and compiler facts/owner lowering from cb70f90. Owner stability currently changes lift/facts; if a lift prepared path is later added it needs its own typed schema, not heap fields. The mandatory compiler manifest invalidates pre-merge records, then rebuild captures final numeric/owner metadata. Source persistence is for diagnostics/digest verification only: loading a prepared record never execs its source.

## Runtime consumer coverage

| Consumer | Persisted facts / live check |
|---|---|
| Region.load | entry params/kinds; ordered global namespace/name/kind; current objects |
| Loader.c_ok/c_kind/load_plan | fields/class_fields/members/aliases/shared cells; derive fresh C plans |
| Loader list/dict/set | cell alias identity and mutated flags; current repeated-identity contracts |
| Loader ndarray | NdT dtype/ndim/writable + array_views; current flags/shape/stride/buffer |
| Region.constants | ordered strings/global slots; derive fresh NumPy blocks and prefix |
| Region.attempt | arrays_written rollback, entry ret, order origin for bailout, sealed run, ahead_of_time |
| Unloader.reference/write_back | family tag order/layout/class_fields/written/cell mutated; same original handles |
| RNG | current generator binding/state; existing load/store and method guards |
| Diagnostics/audit | source/digest/order origins and primitive reports; actual successful AOT counters only |

`calls`, AST nodes, `_facts` object keys, expression IDs, analysis objects and lowered temporary owner maps are compile-only, not runtime authority. If a new runtime consumer is introduced, schema/compiler key changes and a field-inventory test must fail until capture/rebind is updated.

## Fail-closed behavior and diagnostics

Any shape/definition/key/descriptor/native mismatch records a primitive reason (`schema`, `plan`, `source`, `code`, `constants`, `defaults`, `closure`, `dependency`, `class`, `mro`, `layout`, `binding`, `compiler`, `runtime`, `artifact`, `seal`, `metadata`) then follows the pre-existing regeneration path. `allow_jit=False` stays false, including legacy/no-seed mismatch: exact export map lookup must raise Unsupported before `_start_numba`. No miss ever invokes a mismatched export. Missing prepared records preserve old plans. Corrupt metadata does not disable a still-valid ordinary AOT export. A failed native file/ABI verification also disables that export itself, so ordinary regeneration cannot bypass the same incompatible artifact.

Expose `Region.prepared_hits`, `prepared_misses`, and `prepared_reasons` (counts/primitives). Count a hit only once an independently sealed program matches current live arguments, not when JSON is parsed. Existing compiled/aot/jit/fallback counters retain successful-call semantics. A metadata seal call is preparation, not deployment.

## Staged test contract and activation order

Draft tests are in this directory, outside tests/. They are not executed. They require real built AOT artifacts for positive hit/seal cases; synthetic API tests prove only canonicalization and validator behavior. Fresh subprocess imports of numba/llvmlite and all forbidden analysis entry points must raise AssertionError on an expected hit; stdout/identity/writeback/counters still must match.

Test every component independently: exact source bytes (same bytecode), entry/dependency code/constants/defaults/kwdefaults/closures, class constructor/MRO/slot/descriptor/shadow/absence/finalizer/allocation, global/module/builtin bindings and mutable contents, seed/plan/profitability/options/exports, every compiler/runtime/native ABI input, artifact bytes/path/module collision/export swap, every descriptor field (especially written/ret/member order/flags/cells/order), malformed/cyclic/duplicate/oversized JSON. Include forged metadata with recomputed outer checksums to prove the native seal is independent.

Positive runtime cases include aliasing/cycles, shared mutated cells, returned original object identity, polymorphic member tags, readonly/mutating lists, arrays/view rollback, recursion/checked bailout attribution, hidden and explicit RNG generator state/aliasing, legacy-only prepared records, strict/wide seed startup cases, no descriptors invoked while declining, and no retained failed-bind graph or cached weakref targets. Existing late-finalizer guards must remain effective after the hit.

After root authorization: implement key/codec/schema with red/green; capture both legacy+normalized runtimes; build native seal and exact binding; integrate hit-before-inference + miss AOT-only rule; review positive fresh-process hits and all invalidation components; union suite; matched S31 cohort. Only then merge 2455034/cb70f90/56860c3, regenerate artifacts under the new compiler key, run union/kernel acceptance as directed. No commits are authorized in this preparation task.

### Exact profiler assembly (resolved integration contract)

Use `heap.build_regions(entries, folder, *, plan_factory=None)`; thread the same optional argument through `profiler.build_regions_ahead_of_time`. Internally split into `_collect_region_exports(entries)` and `_finish_region_exports(inventory, folder, plan_snapshot)`. Collection creates the final function rows/exports/seeds plus post-transform cores in memory, but does not compile or publish a module. It yields `preview_section`, with artifact-derived fields absent.

In profile_script, preserve selected region objects in a local entries list, then remove private `_region/_rows/_lifted/_captured` candidate fields as it already does. Supply a closure `plan_factory(preview_section)` that sets `report['plan'] = run_plan(chosen_candidates, lift_section, preview_section)` and returns the same primitive `report` snapshot plus explicit mode `force=False`. This uses the final export coverage count, unchanged candidates and unchanged gate equations. Invoke once on a successful build. `plan_key` projects this complete snapshot, removing only: outer nonsemantic measurement/audit inventory outside the actual runtime plan/candidate selection records; all derived prepared payloads/IDs; and AOT `folder/module/artifact file/hash/length/seal` routing outputs. Include the complete functions/candidate records used by selection, batch controls, semantic plan options, origins, exports and seeds, and every plan field including startup_s/saving_s/worth_running. Unknown plan/candidate fields remain included. The exact projection is a named versioned function, tested field by field, never an ad hoc dict subset.

After native compile, fill the previously absent artifact/prepared fields into that same preview_section dict. Their exclusion makes the stored key equal the later runner snapshot projection. If native compile fails, omit the failed region section and recompute the existing plan for reduced coverage; no prepared core is published and no selection/profitability rule changes. An empty inventory follows the existing no-regions path. Standalone callers use the canonical snapshot `{'mode': 'standalone', 'functions': [], 'plan': {'aot_regions': preview_section}}`; loading their test artifact constructs the same snapshot with the final section. Runtime --force changes the mode key and therefore declines a normal prepared record, while retaining its already-authorized ordinary force behavior.

`_prepared.literal_key(value)` is the shared exact immutable tagged encoder; `validate_core(core)` performs structural/type/index/layout validation without binding. Both are available for unit tests; neither grants native-entry authority. Build settings include actual CC target_cpu, use_nrt, extra C/link flags and target options, not merely package versions.

### Reviewer closure: authority, full runner input, wrappers

The `plan_factory` return value is the **complete final runner input report**, not only the run_plan result. Its projection includes top-level script, all function identities and candidate.recommended/status/engine, calls, batch_backends/batch candidates and every control consumed by runner/batch.plan_ratios/_selected/_regional, in addition to the plan. It is invoked exactly once after final export inventory on a successful build; copy/freeze the primitive snapshot before sealing. Attaching derived outputs may mutate only the explicitly excluded locations. A test compares callback count and run_plan gate output with the old orchestration and independently edits recommendation, engine, batch fields and an unknown future option. Timings in startup_s/saving_s are retained as exact key data; there is no need to execute the gate on a saved hit.

`runner.prepare` must NOT call current `aot.load` or obtain ordinary export callables before verifying the prepared section's outer native artifact/hash/ABI. Move verified import and export selection into `_prepared.open_index`/a shared verified artifact loader; return the same verified module for ordinary regenerated lookup. Separate two results: (a) missing/unsupported/invalid descriptor while binary remains independently compatible permits the original AOT regeneration path; (b) incompatible/missing/replaced native artifact disables **all** exports from that artifact, including ordinary fallback lookup. Existing legacy plans without prepared metadata retain the old compatibility behavior and no prepared-hit claim. Corrupt newly sealed binary cannot be smuggled back through the legacy route. Preloaded sys.modules name collisions, Python shims and a replaced seal/export builtin must fail before native body entry.

Trusted runner equivalence is explicit. A plain dependency at profile/build time can resolve to runner.use.fast at saved time. Its freevars (`fn`, `prepare`, `state`) are not ordinary application closure values and must not cause positive S31 cases to miss. Use a process-local runner-owned weak wrapper registry plus a static validator, not `__recompyler_original__` alone. Register wrappers when use() creates them. The registry stores weak original/wrapper/prepare references and primitive current-process identity tokens/code fingerprints, without a value-to-key strong cycle; it is never serialized. Validation requires registry membership, exact FunctionType, trusted fast/prepare code objects derived from current hashed runner code, exact marker == original == fn closure cell, expected closure layout and the original prepare/state relationships. Validate any dispatch-state fields on which equivalence relies (e.g. an attached lifted object's exact trusted type and original function); a user replacement cannot be accepted solely because a marker remains. Persist the logical `runner_equivalent_original` recipe and underlying function fingerprint; at bind install live guards on current wrapper code/marker/cells and underlying code/defaults. Do not require profile-time plain code to equal runtime fast code. A forged marker, changed fast body, changed original or registry/state mismatch declines. Existing unwrapped dependency binding remains accepted. Wrapper records do not extend function/class lifetimes.

Performance accounting: compiler/runtime/file hashing and dependency-key validation happen once per fresh saved-process immutable validation snapshot, then live guards remain per-call. Do not import importlib.metadata repeatedly or hash unrelated large binaries on every invocation. Do not weaken the compiler/runtime key to meet a timing target. Report validation time as its own measured scope after implementation. All identity caches are scoped to that snapshot; path+mtime does not certify immutable file content for another invocation.

### Persisted section wire format (tests and harness)

`section['prepared'] = {schema: 1, cores: [core...], bundle_seal: hex, seal_export: '_rc_prepared_seal', artifact: {file: basename, length: int, sha256: hex, extension_tag: str}}`. Each section.functions row has `prepared: [core_id...]`. Existing exports/seeds remain intact. `bundle(cores)` returns the schema/cores/bundle_seal/seal_export portion; it never computes or authorizes artifact facts. Each core ID is canonical content-derived. Runtime diagnostic reason fields are not persisted into the sealed build payload. `PreparedIndex` is rejected unless built through verified open_index; binding failure returns an empty list and records primitive reasons without retaining the caught exception.

## Native binding authority on prepared misses — coordinator ruling

This section supersedes any earlier suggestion that `open_index(...) is None` may silently fall through to `aot.load`. The agreed API remains unchanged: a verified `PreparedIndex` exposes `.module`, `.exports`, `.bind(entry)` and primitive `.reasons`. No OpenResult API rewrite is required.

### Three distinct decisions

| Condition | open_index / runner result | Ordinary AOT authority |
|---|---|---|
| The section has no `prepared` key at all | Runner follows the existing pre-feature AOT load path | Existing old-plan behavior only; no prepared-hit claim |
| `prepared` key exists, and artifact, ABI, complete bundle seal and exact function/export mapping all validate | Return a verified PreparedIndex | Use only index.exports derived from the sealed manifest |
| `prepared` key exists but is null, empty, malformed, incompatible, wrongly bound, or fails any native/core/mapping seal | Return None or raise PreparedArtifactMismatch; runner disables all exports from that section | None; do not call aot.load or rebuild a digest map from the untrusted section |

The presence decision is exactly `'prepared' in section`, not `bool(section.get('prepared'))`. Exceptions from a present record are rejection, never evidence that the record was absent. In AOT-only mode the invalid case receives the existing empty truthy _AotOnlyExports and eventually runs Python. In explicitly forced mode it may follow the already-authorized fresh JIT path, using no callable from the rejected artifact.

After open_index successfully authenticates consistency with the original native seal, index.bind may discover a current source/code/default/closure/dependency/class/plan/compiler-generation key mismatch and return no prepared Program. This is a **live key miss**: the unchanged native-sealed stored records and export map are still internally valid. Keep the verified ordinary export map, run the existing fresh regeneration path under its existing AOT-only budget, and attach only an exact regenerated match. No stale prepared runtime metadata is used. Unknown/unrepresentable live bindings are the same kind of miss.

A hard Python/native/NumPy/loader/header/target ABI mismatch is not a live metadata miss. It revokes ordinary native authority as well. A changed native file, different resolved module path, preloaded module collision, replaced builtin metadata function, source-to-export mapping corruption, or bad bundle seal likewise revokes every callable. Do not return a partially verified index with nonempty exports.

### Seal the full ordinary export map

Add `export_manifest` to the native-sealed bundle, not just to untrusted outer JSON:

```text
export_manifest = [
  {entry_id: {file, function, qualname, line, origin},
   exports: [{digest: hex, export: 'rN', signature: {args: [...], ret: [...]}}],
   prepared: [core_id, ...]}
]
```

It covers every retained original legacy and normalized seed export, including exports that have no serializable prepared core. Duplicate native symbols are permitted only for intentionally shared code with the same ABI; each digest/entry mapping is explicit. All digest/name/index/signature values are validated as primitives before any lookup. The complete manifest, cores, schema and compiler/runtime binding facts determine the bundle seal embedded by the native metadata export. Artifact file hash remains an outer fact to avoid a self-hash cycle.

Compare the current section's full function-origin/exports/prepared-ID projection against this sealed manifest, including completeness, duplicates and additional rows. The `function_row` passed to open_index must match an actual row of that verified section; it cannot introduce an alternate digest/export mapping. Construct index.exports exclusively from the manifest and the already verified native module, never from a separately trusted `function_row['exports']` dictionary. Resolve and retain the actual verified builtin functions once. A mapping edit that recomputes JSON IDs or checksums still disagrees with the compiled bundle seal and cannot expose r0/r1.

A single combined seal is deliberately sufficient: corrupting any core invalidates the whole bundle and disables all ordinary exports, even when an uncorrupted export could theoretically have been reused. This is a conservative corruption fallback, not an unnoticed lost optimization. An independent second native seal for the full ordinary map could later preserve those exports despite a damaged prepared core, but that extra mechanism is not part of the current design. Never simulate it by trusting an unsealed map.

For a live key miss, compare the regenerated machine argument/return ABI with the manifest before attaching the matching ordinary export. A typed resolver on the verified exports map (called from _Program.compile after regeneration) can perform this check. The native wrapper's coercion behavior is not a proof that an inferred float may use an int64 export. Digest lookup, entry identity and ABI must agree.

### Required control-flow tests

1. Absent prepared key alone calls the old loader. Present values None, {}, wrong type, malformed schema, bad seal and incompatible ABI never call it; instrument old aot.load to raise if reached.
2. A genuine sealed index with a changed live source/default/dependency/semantic plan returns bind=[] while preserving only its independently sealed ordinary exports. Exact regeneration may reuse a compatible export; AOT-only never imports Numba.
3. Tamper a structurally valid core, recompute JSON core IDs/row references/bundle hashes and retain the original native artifact: structural validation passes, native seal fails, no mapped native body enters, and no old-loader call occurs.
4. Swap r0/r1, add/delete an export, change its digest, entry identity, signature or prepared-ID membership, or pass an alternate function_row: fail before exposing exports, even if every JSON checksum was updated.
5. Include a valid ordinary legacy export with no prepared core. Its manifest entry is native-sealed, open_index exposes it for ordinary regenerated lookup, and no prepared hit is counted for it.
6. Hard ABI/artifact mismatch returns no usable native map; a mere live definition/key mismatch retains a verified map. These states have separate primitive reasons and tests.
7. Recompute generated digest successfully while changing the candidate's machine signature: the verified ordinary resolver rejects the incompatible native signature before invocation.

These tests exercise the runner's actual branch, not only open_index in isolation, because an unsafe fallback after a correct rejection would otherwise remain invisible.
