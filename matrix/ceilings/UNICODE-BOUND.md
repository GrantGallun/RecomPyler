# Unicode complete-call control (S32/S36)

This is a small real-source control for a Unicode representation, separate from the three dominant base64 byte-loop bodies. No product capability or newly native matrix row is claimed. The retained textwrap.dedent envelope is 273 calls /0.001078s inclusive /0.000544s self; those historical aggregate times are not attributed to these three fixture calls.

The baseline is the actual installed CPython3.14 textwrap.dedent (split/isspace/lexical min-max/slice/join), not its older regex implementation. The fixtures are uncleaned actual SQLAlchemy2.0.51 Session.commit, Session.flush and Query.all docstrings, located with asserted AST function/owning-class/line identities and transformed by the installed _dedent_docstring first-line rule. Source/input hashes and full operands are recorded in unicode-green-v3.json; they are static recipe controls from retained-executed source, not serialized historical dynamic arguments. SQLALCHEMY-LICENSE.txt retains the source MIT notice.

Three alternating pairs under audited TIMING.lock,500 complete calls per sample; initialization is outside every call and guards/entry/ownership/output construction are inside. C is hand-translated full-body boxed CPython-API work or borrowed one/two/four-byte Unicode scans. Managed njit/AOT versions call those bodies through the demonstrated NRT-owner/intrinsic mechanism, including callable/tuple/input/output ownership costs. These bridges are not automatic source lowering.

| Real-source operand | Characters | CPython us | Boxed C us | Borrowed C us | Boxed AOT us | Borrowed AOT us |
|---|---:|---:|---:|---:|---:|---:|
|Session.commit|1323|4.0322|5.9182|4.8406|6.6740|5.5732|
|Session.flush|959|3.0010|4.2460|3.8704|5.0336|4.5394|
|Query.all|603|2.7574|4.0798|2.5742|4.8140|3.3658|

## Decision

Keep standalone dedent on CPython for these measured inputs: every managed boxed/AOT or borrowed/AOT complete call is slower. Boxed direct C is also slower; borrowed direct C is slower on Session.commit/flush and only6.6% faster on Query.all. That small raw-C advantage does not survive the managed boundary. Much of the original work is already in CPython split/isspace/slice/join implementations, and this translated control cannot repay its guards/boundary/scan cost here. This is a measured result for this function and these operands, not a rejection of Unicode kinds or of every boxed C-API kernel.

S36 compares remaining time with2x of the best measured route; no boxed route outside that bound can be the primary merely because it saves half the baseline time. Passing a2x ceiling is necessary for route selection, not permission to deploy slower code: the unchanged profitability gate still chooses CPython for these standalone controls. The large byte controls independently justify the shared native span representation; there is no independent Unicode speed justification from dedent.

After the user chooses the backend, bytes and read-only Unicode scanning should share the mechanism in SPAN-DESIGN.md: exact-type/context entry guards; pinned buffer owner; data/logical length and PEP393 kind; checked indexing; one Python-result construction with explicit ownership on escape. Reuse installed Numba Unicode/Buffer data models and lowerings where strict behavior matches, while preserving selected-object provenance separately from buffer ownership. Existing standard boxing recreates results and does not itself prove identity or single-result allocation. Guards after effects require boxed continuation, not rerun from entry. This is one design, not two parallel implementations; the estimated shared1100-2100 lines plus integration tests remain work after the explicit backend choice.

## Executed gates and domain

Final pass: 2328 all-identical value/type/input-alias/event/exception gates; six variants each pass1000-call success/error input references and relative output reference counts. All29 current CPython whitespace code points appear both as blank lines and before nonblank text; tests also exercise tabs/spaces, CR, Latin-1/BMP/astral/lone-surrogate/NUL content, repeated/trailing empty lines, prefixes, str subclasses and non-str errors. Fresh AOT imports and success/error/identity calls pass without importing Numba.

Each timing sample asserts its exact boxed/borrowed counter multiplicity and zero fallback (63 recorded routes). Source, fixture, binary, receipt and audit seals are in unicode-seal.json; full three samples are in unicode-green-v3.json. The final behavior/timing pass is green-v3; green-v2 is superseded only to add explicit NUL/prefix/repeated-empty-line cases, with no C implementation change.

The first actual red pass produced12 mismatches: deleting gc.callbacks made the guard raise AttributeError absent from the original, and a gc-module subclass added guard callbacks, across all six routes. Corrected eligibility uses a pure exact-module/inert-dict/same-callback-binding check and original fallback for missing/rebound/subclass state. The initial signed-int newline counter and potentially overflowing start+margin expression were corrected structurally to Py_ssize_t/line-relative bounds; no giant allocation is claimed as a test.

Trusted initial CPython3.14/GIL context and exact-str native input remain explicit restrictions. Nonempty/rebound/missing gc.callbacks and unsupported context take original fallback. Ambient cyclic-finalizer interleavings, asynchronous mutation, OOM injection, free-threading/subinterpreters and hostile import-time mutation are not proved. No Stable ABI or universal textwrap/library promise follows. The raw input owner remains pinned during borrowed reads; output is sized, allocated and filled before exposure. No byte-based Unicode indexing or unmeasured unlocked held-out-time claim is made.

| Operand | Best measured route | Boxed AOT / best | Borrowed AOT / best |
|---|---|---:|---:|
|Session.commit|cpython|1.655|1.382|
|Session.flush|cpython|1.677|1.513|
|Query.all|borrowed-C|1.870|1.308|

Both AOT representations are within2x of the best on these operands, but neither beats CPython. Keep the original standalone call; no faster deployment is credited.
