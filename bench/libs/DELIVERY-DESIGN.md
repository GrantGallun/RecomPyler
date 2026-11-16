# S85 delivery design

The opt-in API is recompyler.enable(packages=..., profile=...). The CLI accepts
python -m recompyler run app.py, and compile <package> prepares native artifacts
for definitions in the package's loaded modules. The default compile budget is
120 seconds; unattempted and unportable bodies are reported explicitly.

Delivery requires hot, verified evidence at or below CPython. A persistent
receipt identifies code/source/compiler and, for a loaded artifact, the SHA256
of the exact native object. Cold, slower, stale, corrupt and unverified records
stay Python. A receipt never supplies invented measurements to a fresh body.
The canonical installer receives the precise loaded owner, code and prepared
handle, so a concurrent forget/recompile cannot substitute another body. One
coherent receipt row supplies its hotness, verification and speed verdict.

The native cache stores LLVM object bytes plus a checksummed relocation manifest
and IR. Recognised code-owned objects, immutable singleton references and fresh
structure caches are rebound with LLVM per-engine global mappings. No saved raw
process addresses are executed. Unknown pointer casts, immutable type-feedback
plans and inliner plans decline export. Object, IR and full manifest hashes are
checked before load. Code changes during cache reads/export invalidate the load.
Multiple live engines have independent relocation mappings and retain only
executable/compiler resources, not application functions or their code objects.

Real JSON AOT smoke:22/22 prepared,21 portable,0 installed. JSONEncoder.iterencode
has process-specific feedback and correctly declines native export. A matching
receipt without a portable artifact can only use an actual current canonical
measurement; a new body otherwise remains Python. The production measured pool
is currently0. Synthetic receipts appear only in policy unit tests.

The import finder sits immediately before PathFinder, wraps selected source
loaders, preserves original loader metadata and runs compilation after successful
module execution. Discovery executes no descriptors or instance-class protocols;
weak function references survive enumeration, so incidental resources are released
before cache I/O. Missing/deleted module names and custom module objects stay
Python. Enable is idempotent; disable closes only its own handles and monitoring
ID. The script helper preserves caller-owned sessions. CLI shutdown callbacks
keep the application's __main__, argv and path. Reports cannot overwrite the
script or loaded package source, including imported submodules.

Hotness uses a private free sys.monitoring tool ID and weak code ownership;
argument values/frames are never captured. The CLI starts one child with the
required process-local CPython JIT setting when needed, propagating the real
Windows exit status. No machine setting changes. Automatic representative-call
training/measurement is not yet connected: receipts currently consume external
locked evidence, and --library-profile reports observed call counts only.

C-call and ndarray lowerings remain shared IR passes, with no separate library
frontend. Their provider contracts and proof obligations are in BOUNDARY-DESIGN.
