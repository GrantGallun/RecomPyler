# S49 range values: resumed design and implementation plan

Spec: CLAUDE-BRIEF-lift.md, S45.2/10, S47 and S49. Supersedes only the numeric-owner dependency and C-long-owner guard in RANGE-DESIGN.md. S49 exact int/float/complex identity is exempt; exact type/value, singleton identity, exception/order and all nonnumeric identity remain binding.

Goal: wire unchanged installed Numba range construction/iteration into heap regions using RangeT with three signed-int64 codes (start, stop, step). Repeated iteration constructs fresh iterator state. RngT continues to mean random.Random. No generic object/provenance backend or private origin certificate is added.

Alternatives: storing a native range object would require special Numba ABI/AOT types; using three existing integer ABI slots fits the current pipeline. A heap handle would falsely imply an original Python owner. Choose the flat triple and refuse every heap/public placement. Kind-specific argument packing is necessary; existing load/write-back/startup behavior is unchanged. Init-entry work still must not alter wave16-owned load/write-back/startup paths.

Domain: exact builtin ranges; exact int/bool constructor and int/bool query/index operands. Each bound fits int64, step excludes zero/INT_MIN, and checked stop-start fits [-INT_MAX,INT_MAX]. Python entry guards use unbounded arithmetic before narrowing. Construction guards run after eager once-only argument evaluation at the original point. len uses Numba range count, integer indexing normalizes/checks then checked multiply/add, integer membership bounds-checks then checked subtraction/remainder. Huge, custom, subclass, NumPy, float/complex query, slice, truth, equality/identity/attribute and explicit-iterator cases decline. Terminal unused iterator addition may wrap but cannot be observed: only the yielded values enter the region and iterators never escape. C-long owner guards are removed under S49.

Storage/public proof is structural, not origin inference: reject ranges recursively in aggregate inputs/displays/stores, object fields, globals, public entry return and generator results. Direct internal parameters and returns are allowed. Refuse RangeT in slot/heap APIs and positive allowlists; no bound can be interpreted as an arena handle. Original public range owners therefore always remain Python. Numeric is/is-not/id in region or compiled callees decline; singleton controls retain exact identity.

Files: heap.py for kind/guard/emit/flat packing only; _region_seed.py and _prepared.py for positive kind metadata; tests/test_range_values.py and tests/test_range_values_aot.py for real CPython and fresh AOT controls. Borrowed-mutable local closures wait for wave17 provenance.

## Tasks and gates
- [ ] Execute tests/test_range_values.py on unchanged product; verify missing native assertions fail and fallback controls pass, sealed by run_correctness.py.
- [ ] Add RangeT to type descriptions/joins/width/machine/dummy/coercion and positive seed/prepared metadata; add construction/loop/len/index/membership and reject unsupported storage/public escape. Inspect every result.
- [ ] Run focused and fresh AOT tests on frozen source, correct review findings only after red receipts. Independent review of final diff is mandatory.
- [ ] Freeze hashes, run matrix verdicts including ten held-out-form witnesses, full held-out collector with first-failure top ten and union; do not infer reach from row counts.
- [ ] Under TIMING.lock only, run three alternating pairs of four kernels; report disturbed/unresolved evidence honestly. Commit one accepted range capability only after all gates.
- [ ] Continue scalar local calls/nonlocal numeric cells, init entry, kwargs/names and scoped inventory. If a backend/ownership/interface blocker prevents authorized progress, record DEVIATION and concrete steering request.

Review focus: eager argument snapshots, int64 domain before narrowing, internal-return flattening, nested aggregate escape, fresh AOT live bounds and numeric identity observers. Existing red receipts are baseline only; incomplete directories are excluded.
